Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA599C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="115208938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E9CF40D4D0B;
	Thu, 31 Mar 2022 03:55:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/39] mmc: tmio: reenable card irqs after the
 reset callback
Date: Wed, 30 Mar 2022 19:54:39 +0100
Message-Id: <20220330185454.10887-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7875

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 90935eb303e0d12f3d3d0383262e65290321f5f6 upstream.

The reset callback may clear the internal card detect interrupts, so
make sure to reenable them if needed.

Fixes: b4d86f37eacb ("mmc: renesas_sdhi: do hard reset if possible")
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20211028195149.8003-1-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index bb5eb478b6cf..690094b0b6a8 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -195,6 +195,10 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 	host->sdcard_irq_mask = host->sdcard_irq_mask_all;
 
+	if (host->native_hotplug)
+		tmio_mmc_enable_mmc_irqs(host,
+				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+
 	tmio_mmc_set_bus_width(host, host->mmc->ios.bus_width);
 
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
@@ -954,8 +958,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
 		/* For R-Car Gen2+, we need to reset SDHI specific SCC */
-		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2) {
 			host->reset(host);
+
+			if (host->native_hotplug)
+				tmio_mmc_enable_mmc_irqs(host,
+						TMIO_STAT_CARD_REMOVE |
+						TMIO_STAT_CARD_INSERT);
+		}
+
 		host->set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
@@ -1192,10 +1203,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	_host->set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
-	if (_host->native_hotplug)
-		tmio_mmc_enable_mmc_irqs(_host,
-				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
-
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
 
-- 
2.17.1


