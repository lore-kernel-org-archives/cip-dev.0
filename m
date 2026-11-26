Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15966.1795706531957178822
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B58B42AD6;
	Thu, 26 Nov 2026 15:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2333A1F000C4;
	Thu, 26 Nov 2026 15:22:09 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/27] dmaengine: sh: rz-dmac: Make channel irq local
Date: Thu, 26 Nov 2026 17:21:39 +0200
Message-ID: <20261126152204.1297798-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25113
Content-Type: text/plain; charset="utf-8"

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e0c51fd02f9cfab341907f6764d2f15c134eea55 upstream.

The channel IRQ is only used inside the function rz_dmac_chan_probe(),
so there is no need to store it in the rz_dmac_chan structure for later
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/312c2e3349f4747e0bca861632bfc3592224b012.1=
767718556.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6cf60c11a355..3115ff2ab595 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -64,7 +64,6 @@ struct rz_dmac_chan {
 	void __iomem *ch_base;
 	void __iomem *ch_cmn_base;
 	unsigned int index;
-	int irq;
 	struct rz_dmac_desc *desc;
 	int descs_allocated;
=20
@@ -769,29 +768,27 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	struct rz_lmdesc *lmdesc;
 	char pdev_irqname[6];
 	char *irqname;
-	int ret;
+	int irq, ret;
=20
 	channel->index =3D index;
 	channel->mid_rid =3D -EINVAL;
=20
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
-	if (channel->irq < 0)
-		return channel->irq;
+	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
=20
 	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
 	if (!irqname)
 		return -ENOMEM;
=20
-	ret =3D devm_request_threaded_irq(dmac->dev, channel->irq,
-					rz_dmac_irq_handler,
+	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
 					rz_dmac_irq_handler_thread, 0,
 					irqname, channel);
 	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			channel->irq, ret);
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
 		return ret;
 	}
=20
--=20
2.43.0

