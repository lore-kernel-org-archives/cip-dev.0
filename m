Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC7AC433FE
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.2209.1648666508225964836
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211096"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D2E6240D5446;
	Thu, 31 Mar 2022 03:55:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/39] mmc: renesas_sdhi: populate hook for longer
 busy_wait
Date: Wed, 30 Mar 2022 19:54:27 +0100
Message-Id: <20220330185454.10887-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7863

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit b191deced78a12e26a827db03745b0da6cbc4f0e upstream.

Make use of the EXTOP bit in R-Car Gen3 SoCs to have a twice as large
busy wait duration.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201125213001.15003-4-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 20 ++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 980c50b9226e..8306a5b5b06e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -561,6 +561,7 @@ static int renesas_sdhi_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_io
 static void renesas_sdhi_reset(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
+	u16 val;
 
 	if (priv->scc_ctl) {
 		renesas_sdhi_disable_scc(host->mmc);
@@ -573,6 +574,21 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_INIT_RCAR2);
+
+	if (sd_ctrl_read16(host, CTL_VERSION) >= SDHI_VER_GEN3_SD) {
+		val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
+		val |= CARD_OPT_EXTOP;
+		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, val);
+	}
+}
+
+static unsigned int renesas_sdhi_gen3_get_cycles(struct tmio_mmc_host *host)
+{
+	u16 num, val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
+
+	num = (val & CARD_OPT_TOP_MASK) >> CARD_OPT_TOP_SHIFT;
+	return 1 << ((val & CARD_OPT_EXTOP ? 14 : 13) + num);
+
 }
 
 #define SH_MOBILE_SDHI_MIN_TAP_ROW 3
@@ -1072,6 +1088,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			quirks->hs400_calib_table + 1);
 	}
 
+	/* these have an EXTOP bit */
+	if (ver >= SDHI_VER_GEN3_SD)
+		host->get_timeout_cycles = renesas_sdhi_gen3_get_cycles;
+
 	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset &&
 	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f60559bc413a..784fa6ed5843 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -82,7 +82,9 @@
 /* Definitions for values the CTL_SD_MEM_CARD_OPT register can take */
 #define CARD_OPT_TOP_MASK	0xf0
 #define CARD_OPT_TOP_SHIFT	4
+#define CARD_OPT_EXTOP		BIT(9) /* first appeared on R-Car Gen3 SDHI */
 #define CARD_OPT_WIDTH8		BIT(13)
+#define CARD_OPT_ALWAYS1	BIT(14)
 #define CARD_OPT_WIDTH		BIT(15)
 
 /* Definitions for values the CTL_SDIO_STATUS register can take */
-- 
2.17.1


