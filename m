Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35FC64EAF
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3726.1648842178937058012
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="116465336"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E08094011436;
	Sat,  2 Apr 2022 04:42:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 12/40] mmc: tmio: add hook for custom
 busy_wait calculation
Date: Fri,  1 Apr 2022 20:42:06 +0100
Message-Id: <20220401194234.14057-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7923

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 58959f89dd3d8cc8bedcd2d665496603098b29a2 upstream.

Newer SDHI variants can 'wait while busy' longer than the generic TMIO.
Provide a hook to get the maximum cycle count to wait for. If the hook
is not populated, fall back to a generic version which works well with
all older TMIO/SDHI variants.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201125213001.15003-3-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      |  1 +
 drivers/mmc/host/tmio_mmc_core.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 819198af17f4..f60559bc413a 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -181,6 +181,7 @@ struct tmio_mmc_host {
 	void (*reset)(struct tmio_mmc_host *host);
 	bool (*check_retune)(struct tmio_mmc_host *host);
 	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
+	unsigned int (*get_timeout_cycles)(struct tmio_mmc_host *host);
 
 	void (*prepare_hs400_tuning)(struct tmio_mmc_host *host);
 	void (*hs400_downgrade)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index a896595cf575..85dc5b9f4e60 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -885,16 +885,20 @@ static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
 }
 
-static void tmio_mmc_max_busy_timeout(struct tmio_mmc_host *host)
+static unsigned int tmio_mmc_get_timeout_cycles(struct tmio_mmc_host *host)
 {
 	u16 val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
-	unsigned int clk_rate = host->mmc->actual_clock ?: host->mmc->f_max;
-	unsigned int cycles;
 
 	val = (val & CARD_OPT_TOP_MASK) >> CARD_OPT_TOP_SHIFT;
-	cycles = 1 << (13 + val);
+	return 1 << (13 + val);
+}
+
+static void tmio_mmc_max_busy_timeout(struct tmio_mmc_host *host)
+{
+	unsigned int clk_rate = host->mmc->actual_clock ?: host->mmc->f_max;
 
-	host->mmc->max_busy_timeout = cycles / (clk_rate / MSEC_PER_SEC);
+	host->mmc->max_busy_timeout = host->get_timeout_cycles(host) /
+				      (clk_rate / MSEC_PER_SEC);
 }
 
 /* Set MMC clock / power.
@@ -1114,6 +1118,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		_host->write16_hook = NULL;
 
+	if (pdata->flags & TMIO_MMC_USE_BUSY_TIMEOUT && !_host->get_timeout_cycles)
+		_host->get_timeout_cycles = tmio_mmc_get_timeout_cycles;
+
 	_host->set_pwr = pdata->set_pwr;
 
 	ret = tmio_mmc_init_ocr(_host);
-- 
2.17.1


