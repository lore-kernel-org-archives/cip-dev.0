Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED3C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="115208920"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:16 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B8B1940D4D0B;
	Thu, 31 Mar 2022 03:55:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/39] mmc: renesas_sdhi: Add a condition of
 cmd/data timeout for retune
Date: Wed, 30 Mar 2022 19:54:30 +0100
Message-Id: <20220330185454.10887-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7866

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit ed2fab9a8229cc70fe03032e48d0ec375df6013e upstream.

According to the datasheet, this controller needs retune when
cmd or data timeout happens. So, add a condition into .check_retune().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1608708622-29668-3-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 16 +++++++++++++---
 drivers/mmc/host/tmio_mmc.h          |  2 +-
 drivers/mmc/host/tmio_mmc_core.c     |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8306a5b5b06e..622e293420f6 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -773,10 +773,12 @@ static bool renesas_sdhi_auto_correction(struct tmio_mmc_host *host)
 	return false;
 }
 
-static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
+static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host,
+					 struct mmc_request *mrq)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	bool use_4tap = priv->quirks && priv->quirks->hs400_4taps;
+	bool ret = false;
 
 	/*
 	 * Skip checking SCC errors when running on 4 taps in HS400 mode as
@@ -790,11 +792,19 @@ static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 	if (mmc_doing_tune(host->mmc))
 		return false;
 
+	if (((mrq->cmd->error == -ETIMEDOUT) ||
+	     (mrq->data && mrq->data->error == -ETIMEDOUT)) &&
+	    ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
+	     (host->ops.get_cd && host->ops.get_cd(host->mmc))))
+		ret |= true;
+
 	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
 	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN)
-		return renesas_sdhi_auto_correction(host);
+		ret |= renesas_sdhi_auto_correction(host);
+	else
+		ret |= renesas_sdhi_manual_correction(host, use_4tap);
 
-	return renesas_sdhi_manual_correction(host, use_4tap);
+	return ret;
 }
 
 static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host, u32 bit)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 784fa6ed5843..2d1db9396d4a 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -181,7 +181,7 @@ struct tmio_mmc_host {
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*reset)(struct tmio_mmc_host *host);
-	bool (*check_retune)(struct tmio_mmc_host *host);
+	bool (*check_retune)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 	unsigned int (*get_timeout_cycles)(struct tmio_mmc_host *host);
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index e694d98faed1..92d1ed07cebe 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -802,7 +802,7 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		tmio_mmc_abort_dma(host);
 
 	/* Error means retune, but executed command was still successful */
-	if (host->check_retune && host->check_retune(host))
+	if (host->check_retune && host->check_retune(host, mrq))
 		mmc_retune_needed(host->mmc);
 
 	/* If SET_BLOCK_COUNT, continue with main command */
-- 
2.17.1


