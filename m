Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9358C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.2209.1648666508225964836
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211112"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 34C0040D4D0B;
	Thu, 31 Mar 2022 03:55:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/39] mmc: renesas_sdhi: break SCC reset into own
 function
Date: Wed, 30 Mar 2022 19:54:35 +0100
Message-Id: <20220330185454.10887-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7871

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0e5870145840e91fc33cd4eca6e228b009d86705 upstream.

renesas_sdhi_reset used to mainly reset the SCC but is now doing more
and even more will be added. So, factor out SCC reset to have a clear
distinction when we want to reset either SCC or SDHI+SCC.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210317091622.31890-3-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index bee27e2fe446..eaf6071ab3cc 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -557,21 +557,25 @@ static int renesas_sdhi_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_io
 	return 0;
 }
 
+static void renesas_sdhi_scc_reset(struct tmio_mmc_host *host, struct renesas_sdhi *priv)
+{
+	renesas_sdhi_disable_scc(host->mmc);
+	renesas_sdhi_reset_hs400_mode(host, priv);
+	priv->needs_adjust_hs400 = false;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
+		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
+}
+
 /* only populated for TMIO_MMC_MIN_RCAR2 */
 static void renesas_sdhi_reset(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	u16 val;
 
-	if (priv->scc_ctl) {
-		renesas_sdhi_disable_scc(host->mmc);
-		renesas_sdhi_reset_hs400_mode(host, priv);
-		priv->needs_adjust_hs400 = false;
-
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
-			       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
-			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
-	}
+	if (priv->scc_ctl)
+		renesas_sdhi_scc_reset(host, priv);
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_ALL_RCAR2);
 
@@ -696,7 +700,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	ret = renesas_sdhi_select_tuning(host);
 	if (ret < 0)
-		renesas_sdhi_reset(host);
+		renesas_sdhi_scc_reset(host, priv);
 	return ret;
 }
 
-- 
2.17.1


