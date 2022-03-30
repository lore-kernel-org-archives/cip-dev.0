Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D3C433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="115208944"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A7C9D40D4D0B;
	Thu, 31 Mar 2022 03:55:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/39] mmc: tmio: reinit card irqs in reset routine
Date: Wed, 30 Mar 2022 19:54:40 +0100
Message-Id: <20220330185454.10887-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7876

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e315b1f3a170f368da5618f8a598e68880302ed1 upstream.

Refactor the code so that card detect irqs are always reenabled after a
reset. This avoids doing it manually all over the code or forgetting to
do this in the future.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[wsa: added a comment when 'native_hotplug' has to be set]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20211103122646.64422-1-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 690094b0b6a8..79f237d754bd 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -958,14 +958,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
 		/* For R-Car Gen2+, we need to reset SDHI specific SCC */
-		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2) {
-			host->reset(host);
-
-			if (host->native_hotplug)
-				tmio_mmc_enable_mmc_irqs(host,
-						TMIO_STAT_CARD_REMOVE |
-						TMIO_STAT_CARD_INSERT);
-		}
+		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+			tmio_mmc_reset(host);
 
 		host->set_clock(host, 0);
 		break;
@@ -1173,6 +1167,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (mmc_can_gpio_cd(mmc))
 		_host->ops.get_cd = mmc_gpio_get_cd;
 
+	/* must be set before tmio_mmc_reset() */
 	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
@@ -1302,10 +1297,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	if (host->clk_cache)
 		host->set_clock(host, host->clk_cache);
 
-	if (host->native_hotplug)
-		tmio_mmc_enable_mmc_irqs(host,
-				TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
-
 	tmio_mmc_enable_dma(host, true);
 
 	return 0;
-- 
2.17.1


