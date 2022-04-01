Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE7BC64EB1
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3553.1648842163502856312
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453826"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CF83040061B8;
	Sat,  2 Apr 2022 04:42:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 11/40] mmc: tmio: set max_busy_timeout
Date: Fri,  1 Apr 2022 20:42:05 +0100
Message-Id: <20220401194234.14057-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7922

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 30ae3e13caeaa47884c222ebf5711ce27ed25f19 upstream.

Set max_busy_timeouts for variants known to support the TOPxx bits in
the SD_OPTION register. The timeout mechanism was running in the
background but not yet properly handled in the driver. So, let the MMC
core know when to not use R1B to avoid unhandled timeouts.

My datasheets for older variants (tmio_mmc.c) suggest that they support
it, too. However, actual bit descriptions are lacking, so I chose an
opt-in approach.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201125213001.15003-2-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c |  3 +++
 drivers/mmc/host/tmio_mmc.h          |  2 ++
 drivers/mmc/host/tmio_mmc_core.c     | 15 +++++++++++++++
 drivers/mmc/host/uniphier-sd.c       |  1 +
 include/linux/mfd/tmio.h             |  7 ++++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 751e21243ebf..980c50b9226e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1046,6 +1046,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
+	/* All SDHI support HW busy detection */
+	mmc_data->flags |= TMIO_MMC_USE_BUSY_TIMEOUT;
+
 	dev_pm_domain_start(&pdev->dev);
 
 	ret = renesas_sdhi_clk_enable(host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7ff41185896a..819198af17f4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -80,6 +80,8 @@
 #define	CLK_CTL_SCLKEN		BIT(8)
 
 /* Definitions for values the CTL_SD_MEM_CARD_OPT register can take */
+#define CARD_OPT_TOP_MASK	0xf0
+#define CARD_OPT_TOP_SHIFT	4
 #define CARD_OPT_WIDTH8		BIT(13)
 #define CARD_OPT_WIDTH		BIT(15)
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ac4e7874a3f1..a896595cf575 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -885,6 +885,18 @@ static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
 }
 
+static void tmio_mmc_max_busy_timeout(struct tmio_mmc_host *host)
+{
+	u16 val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
+	unsigned int clk_rate = host->mmc->actual_clock ?: host->mmc->f_max;
+	unsigned int cycles;
+
+	val = (val & CARD_OPT_TOP_MASK) >> CARD_OPT_TOP_SHIFT;
+	cycles = 1 << (13 + val);
+
+	host->mmc->max_busy_timeout = cycles / (clk_rate / MSEC_PER_SEC);
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -943,6 +955,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	if (host->pdata->flags & TMIO_MMC_USE_BUSY_TIMEOUT)
+		tmio_mmc_max_busy_timeout(host);
+
 	/* Let things settle. delay taken from winCE driver */
 	usleep_range(140, 200);
 	if (PTR_ERR(host->mrq) == -EINTR)
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 196e94bf37f0..73d5bebd0f33 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -586,6 +586,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 	tmio_data = &priv->tmio_data;
 	tmio_data->flags |= TMIO_MMC_32BIT_DATA_PORT;
+	tmio_data->flags |= TMIO_MMC_USE_BUSY_TIMEOUT;
 
 	host = tmio_mmc_host_alloc(pdev, tmio_data);
 	if (IS_ERR(host))
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 8ba042430d8e..27264fe4b3b9 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -55,7 +55,12 @@
  */
 #define TMIO_MMC_HAS_IDLE_WAIT		BIT(4)
 
-/* BIT(5) is unused */
+/*
+ * Use the busy timeout feature. Probably all TMIO versions support it. Yet,
+ * we don't have documentation for old variants, so we enable only known good
+ * variants with this flag. Can be removed once all variants are known good.
+ */
+#define TMIO_MMC_USE_BUSY_TIMEOUT	BIT(5)
 
 /*
  * Some controllers have CMD12 automatically
-- 
2.17.1


