Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10BC433FE
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 12:56:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.7659.1667912197098258360
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 04:56:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="141917611"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Nov 2022 21:56:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.61])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 92DBE4007204;
	Tue,  8 Nov 2022 21:56:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/3] mmc: tmio: avoid glitches when resetting
Date: Tue,  8 Nov 2022 12:56:28 +0000
Message-Id: <20221108125630.3853219-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
References: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 12:56:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9945

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2e586f8a5b0ed4a525014a692923ac96f6647816 upstream.

If we reset because of an error, we need to preserve values for the
clock frequency. Otherwise, glitches may be seen on the bus.

To achieve that, we introduce a 'preserve' parameter to the reset
function and the IP core specific reset callbacks to handle everything
accordingly.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20220625131722.1397-1-wsa@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 27 ++++++++++++++-------------
 drivers/mmc/host/tmio_mmc.c          |  2 +-
 drivers/mmc/host/tmio_mmc.h          |  6 +++++-
 drivers/mmc/host/tmio_mmc_core.c     | 28 ++++++++++++++++++++++------
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ca74fe8bfd9c..120bb5860645 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -51,9 +51,6 @@
 #define HOST_MODE_GEN3_32BIT	(HOST_MODE_GEN3_WMODE | HOST_MODE_GEN3_BUSWIDTH)
 #define HOST_MODE_GEN3_64BIT	0
 
-#define CTL_SDIF_MODE	0xe6
-#define SDIF_MODE_HS400		BIT(0)
-
 #define SDHI_VER_GEN2_SDR50	0x490c
 #define SDHI_VER_RZ_A1		0x820b
 /* very old datasheets said 0x490c for SDR104, too. They are wrong! */
@@ -571,21 +568,25 @@ static void renesas_sdhi_scc_reset(struct tmio_mmc_host *host, struct renesas_sd
 }
 
 /* only populated for TMIO_MMC_MIN_RCAR2 */
-static void renesas_sdhi_reset(struct tmio_mmc_host *host)
+static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	int ret;
 	u16 val;
 
-	if (priv->rstc) {
-		reset_control_reset(priv->rstc);
-		/* Unknown why but without polling reset status, it will hang */
-		read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
-				  false, priv->rstc);
-		priv->needs_adjust_hs400 = false;
-		renesas_sdhi_set_clock(host, host->clk_cache);
-	} else if (priv->scc_ctl) {
-		renesas_sdhi_scc_reset(host, priv);
+	if (!preserve) {
+		if (priv->rstc) {
+			reset_control_reset(priv->rstc);
+			/* Unknown why but without polling reset status, it will hang */
+			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
+					  false, priv->rstc);
+			/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
+			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
+			priv->needs_adjust_hs400 = false;
+			renesas_sdhi_set_clock(host, host->clk_cache);
+		} else if (priv->scc_ctl) {
+			renesas_sdhi_scc_reset(host, priv);
+		}
 	}
 
 	if (sd_ctrl_read16(host, CTL_VERSION) >= SDHI_VER_GEN3_SD) {
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index d2d3b8df1bbe..49732054237f 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -75,7 +75,7 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	tmio_mmc_clk_start(host);
 }
 
-static void tmio_mmc_reset(struct tmio_mmc_host *host)
+static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 {
 	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	usleep_range(10000, 11000);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f936aad945ce..da63193dd45b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -42,6 +42,7 @@
 #define CTL_DMA_ENABLE 0xd8
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
+#define CTL_SDIF_MODE 0xe6 /* only known on R-Car 2+ */
 
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
 #define TMIO_STOP_STP		BIT(0)
@@ -98,6 +99,9 @@
 /* Definitions for values the CTL_DMA_ENABLE register can take */
 #define DMA_ENABLE_DMASDRW	BIT(1)
 
+/* Definitions for values the CTL_SDIF_MODE register can take */
+#define SDIF_MODE_HS400		BIT(0) /* only known on R-Car 2+ */
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
@@ -181,7 +185,7 @@ struct tmio_mmc_host {
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
-	void (*reset)(struct tmio_mmc_host *host);
+	void (*reset)(struct tmio_mmc_host *host, bool preserve);
 	bool (*check_retune)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	unsigned int (*get_timeout_cycles)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 79f237d754bd..aaa7f15f2169 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -179,8 +179,17 @@ static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
 }
 
-static void tmio_mmc_reset(struct tmio_mmc_host *host)
+static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 {
+	u16 card_opt, clk_ctrl, sdif_mode;
+
+	if (preserve) {
+		card_opt = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
+		clk_ctrl = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+			sdif_mode = sd_ctrl_read16(host, CTL_SDIF_MODE);
+	}
+
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
 	usleep_range(10000, 11000);
@@ -190,7 +199,7 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	tmio_mmc_abort_dma(host);
 
 	if (host->reset)
-		host->reset(host);
+		host->reset(host, preserve);
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 	host->sdcard_irq_mask = host->sdcard_irq_mask_all;
@@ -206,6 +215,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
 	}
 
+	if (preserve) {
+		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, card_opt);
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+			sd_ctrl_write16(host, CTL_SDIF_MODE, sdif_mode);
+	}
+
 	if (host->mmc->card)
 		mmc_retune_needed(host->mmc);
 }
@@ -248,7 +264,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	tmio_mmc_reset(host);
+	tmio_mmc_reset(host, true);
 
 	/* Ready for new calls */
 	host->mrq = NULL;
@@ -959,7 +975,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_power_off(host);
 		/* For R-Car Gen2+, we need to reset SDHI specific SCC */
 		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
-			tmio_mmc_reset(host);
+			tmio_mmc_reset(host, false);
 
 		host->set_clock(host, 0);
 		break;
@@ -1196,7 +1212,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->sdcard_irq_mask_all = TMIO_MASK_ALL;
 
 	_host->set_clock(_host, 0);
-	tmio_mmc_reset(_host);
+	tmio_mmc_reset(_host, false);
 
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
@@ -1292,7 +1308,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
 	tmio_mmc_clk_enable(host);
-	tmio_mmc_reset(host);
+	tmio_mmc_reset(host, false);
 
 	if (host->clk_cache)
 		host->set_clock(host, host->clk_cache);
-- 
2.25.1


