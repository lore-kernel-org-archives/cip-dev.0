Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B434C88E5D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40072.1789135330663907887
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7733540F0C;
	Fri, 11 Sep 2026 14:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7047B1F000FF;
	Fri, 11 Sep 2026 14:02:09 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 12/14] mmc: renesas_sdhi: take DMA end interrupts into account
Date: Fri, 11 Sep 2026 17:01:49 +0300
Message-ID: <20260911140151.2119555-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24144

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c330601c9c93392000c077d973b182cc0164b9ac upstream.

So far, we have been relying on access_end interrupts only to mark DMA
transfers as done implying that DMA end interrupts have occurred by then
anyhow. On some SoCs under some conditions, this turned out to be not
enough. So, we enable DMA interrupts as well and make sure that both
events, DMA irq and access_end irq, have happened before finishing the
DMA transfer.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-6-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  5 ++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 51 ++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
index 444dbd0bb774..aef2f094900c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -50,7 +50,12 @@ struct renesas_sdhi_of_data_with_quirks {
 	const struct renesas_sdhi_quirks *quirks;
 };
=20
+/* We want both end_flags to be set before we mark DMA as finished */
+#define SDHI_DMA_END_FLAG_DMA		BIT(0)
+#define SDHI_DMA_END_FLAG_ACCESS	BIT(1)
+
 struct renesas_sdhi_dma {
+	unsigned long end_flags;
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 5d8d054d2503..21d3f33f4890 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -47,7 +47,6 @@
 #define RST_RESERVED_BITS	GENMASK_ULL(31, 0)
=20
 /* DM_CM_INFO1 and DM_CM_INFO1_MASK */
-#define INFO1_CLEAR		0
 #define INFO1_MASK_CLEAR	GENMASK_ULL(31, 0)
 #define INFO1_DTRANEND1		BIT(20)
 #define INFO1_DTRANEND1_OLD	BIT(17)
@@ -264,12 +263,14 @@ static void
 renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool e=
nable)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	u32 dma_irqs =3D INFO1_DTRANEND0 |
+			(priv->quirks && priv->quirks->old_info1_layout ?
+			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
=20
 	if (!host->chan_tx || !host->chan_rx)
 		return;
=20
-	if (!enable)
-		writel(INFO1_CLEAR, host->ctl + DM_CM_INFO1);
+	writel(enable ? ~dma_irqs : INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_M=
ASK);
=20
 	if (priv->dma_priv.enable)
 		priv->dma_priv.enable(host, enable);
@@ -290,12 +291,36 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mm=
c_host *host)
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 }
=20
+static bool renesas_sdhi_internal_dmac_dma_irq(struct tmio_mmc_host *hos=
t)
+{
+	struct renesas_sdhi *priv =3D host_to_priv(host);
+	struct renesas_sdhi_dma *dma_priv =3D &priv->dma_priv;
+
+	u32 dma_irqs =3D INFO1_DTRANEND0 |
+			(priv->quirks && priv->quirks->old_info1_layout ?
+			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
+	u32 status =3D readl(host->ctl + DM_CM_INFO1);
+
+	if (status & dma_irqs) {
+		writel(status ^ dma_irqs, host->ctl + DM_CM_INFO1);
+		set_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags);
+		if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags))
+			tasklet_schedule(&dma_priv->dma_complete);
+	}
+
+	return status & dma_irqs;
+}
+
 static void
 renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	struct renesas_sdhi_dma *dma_priv =3D &priv->dma_priv;
=20
-	tasklet_schedule(&priv->dma_priv.dma_complete);
+	set_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags);
+	if (test_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags) ||
+	    host->data->error)
+		tasklet_schedule(&dma_priv->dma_complete);
 }
=20
 /*
@@ -365,6 +390,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_=
host *host,
 		dtran_mode |=3D DTRAN_MODE_CH_NUM_CH0;
 	}
=20
+	priv->dma_priv.end_flags =3D 0;
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
=20
 	/* set dma parameters */
@@ -385,11 +411,19 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mm=
c_host *host,
 static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long ar=
g)
 {
 	struct tmio_mmc_host *host =3D (struct tmio_mmc_host *)arg;
+	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
 	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
=20
-	/* start the DMAC */
-	writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
+	if (!host->cmd->error) {
+		/* start the DMAC */
+		writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
+	} else {
+		/* on CMD errors, simulate DMA end immediately */
+		set_bit(SDHI_DMA_END_FLAG_DMA, &priv->dma_priv.end_flags);
+		if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &priv->dma_priv.end_flags))
+			tasklet_schedule(&priv->dma_priv.dma_complete);
+	}
 }
=20
 static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *ho=
st)
@@ -469,9 +503,11 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_m=
mc_host *host,
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
-	/* Disable DMAC interrupts, we don't use them */
+	/* Disable DMAC interrupts initially */
 	writel(INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_MASK);
 	writel(INFO2_MASK_CLEAR, host->ctl + DM_CM_INFO2_MASK);
+	writel(0, host->ctl + DM_CM_INFO1);
+	writel(0, host->ctl + DM_CM_INFO2);
=20
 	/* Each value is set to non-zero to assume "enabling" each DMA */
 	host->chan_rx =3D host->chan_tx =3D (void *)0xdeadbeaf;
@@ -503,6 +539,7 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_int=
ernal_dmac_dma_ops =3D {
 	.abort =3D renesas_sdhi_internal_dmac_abort_dma,
 	.dataend =3D renesas_sdhi_internal_dmac_dataend_dma,
 	.end =3D renesas_sdhi_internal_dmac_end_dma,
+	.dma_irq =3D renesas_sdhi_internal_dmac_dma_irq,
 };
=20
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev=
)
--=20
2.43.0


