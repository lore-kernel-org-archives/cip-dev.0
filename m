Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15975.1795706545545556254
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 584CA43DE1;
	Thu, 26 Nov 2026 15:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636051F000C0;
	Thu, 26 Nov 2026 15:22:24 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/27] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Thu, 26 Nov 2026 17:21:48 +0200
Message-ID: <20261126152204.1297798-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25122
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 731712403ddb39d1a76a11abf339a0615bc85de7 upstream.

Once the interrupt is requested, the interrupt handler may run immediatel=
y.
Since the IRQ handler can access channel->ch_base, which is initialized
only after requesting the IRQ, this may lead to invalid memory access.
Likewise, the IRQ thread may access uninitialized data (the ld_free,
ld_queue, and ld_active lists), which may also lead to issues.

Request the interrupts only after everything is set up. To keep the error
path simpler, use dmam_alloc_coherent() instead of dma_alloc_coherent().

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-2-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rz_dmac_probe() by moving the code in
 charge or requesting the error IRQ after rz_dmac_chan_probe()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 92 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 79d1ba71eb18..61300845968f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -963,25 +963,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->index =3D index;
 	channel->mid_rid =3D -EINVAL;
=20
-	/* Request the channel interrupt. */
-	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
-	if (irq < 0)
-		return irq;
-
-	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
-				 dev_name(dmac->dev), index);
-	if (!irqname)
-		return -ENOMEM;
-
-	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
-					rz_dmac_irq_handler_thread, 0,
-					irqname, channel);
-	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
-		return ret;
-	}
-
 	/* Set io base address for each channel */
 	if (index < 8) {
 		channel->ch_base =3D dmac->base + CHANNEL_0_7_OFFSET +
@@ -994,9 +975,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
=20
 	/* Allocate descriptors */
-	lmdesc =3D dma_alloc_coherent(&pdev->dev,
-				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				    &channel->lmdesc.base_dma, GFP_KERNEL);
+	lmdesc =3D dmam_alloc_coherent(&pdev->dev,
+				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				     &channel->lmdesc.base_dma, GFP_KERNEL);
 	if (!lmdesc) {
 		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
 		return -ENOMEM;
@@ -1012,7 +993,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
=20
-	return 0;
+	/* Request the channel interrupt. */
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
+	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
+
+	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
+				 dev_name(dmac->dev), index);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
+					rz_dmac_irq_handler_thread, 0,
+					irqname, channel);
+	if (ret)
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
+
+	return ret;
 }
=20
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
@@ -1039,7 +1037,6 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
 	const char *irqname =3D "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	int ret;
 	int irq;
 	u8 i;
@@ -1069,19 +1066,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
 	if (IS_ERR(dmac->ext_base))
 		return PTR_ERR(dmac->ext_base);
=20
-	/* Register interrupt handler for error */
-	irq =3D platform_get_irq_byname(pdev, irqname);
-	if (irq < 0)
-		return irq;
-
-	ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-			       irqname, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-			irq, ret);
-		return ret;
-	}
-
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
=20
@@ -1107,6 +1091,21 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
 			goto err;
 	}
=20
+	/* Register interrupt handler for error */
+	irq =3D platform_get_irq_byname(pdev, irqname);
+	if (irq < 0) {
+		ret =3D irq;
+		goto err;
+	}
+
+	ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+			       irqname, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+			irq, ret);
+		goto err;
+	}
+
 	/* Register the DMAC as a DMA provider for DT. */
 	ret =3D of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
 					 NULL);
@@ -1148,16 +1147,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
-	channel_num =3D i ? i - 1 : 0;
-	for (i =3D 0; i < channel_num; i++) {
-		struct rz_dmac_chan *channel =3D &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
-
 	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
@@ -1170,18 +1159,9 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
 static int rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
-	unsigned int i;
=20
 	dma_async_device_unregister(&dmac->engine);
 	of_dma_controller_free(pdev->dev.of_node);
-	for (i =3D 0; i < dmac->n_channels; i++) {
-		struct rz_dmac_chan *channel =3D &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
--=20
2.43.0

