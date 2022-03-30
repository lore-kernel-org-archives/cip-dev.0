Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8231C433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="115208923"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0D71540D4D0B;
	Thu, 31 Mar 2022 03:55:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/39] mmc: tmio: support custom irq masks
Date: Wed, 30 Mar 2022 19:54:31 +0100
Message-Id: <20220330185454.10887-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7867

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0d856c4c68c639f96cb12c26aaeb906353b9a76e upstream.

SDHI Gen2+ has a different value for TMIO_MASK_ALL, so add a member to
support that. If the member is not used, the previous default value is
applied.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20210223100830.25125-2-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 2d1db9396d4a..7d5201d6a006 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -164,6 +164,7 @@ struct tmio_mmc_host {
 	u32			sdio_irq_mask;
 	unsigned int		clk_cache;
 	u32			sdcard_irq_setbit_mask;
+	u32			sdcard_irq_mask_all;
 
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 92d1ed07cebe..48083acdb077 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1182,7 +1182,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
-	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+	if (!_host->sdcard_irq_mask_all)
+		_host->sdcard_irq_mask_all = TMIO_MASK_ALL;
+	tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
 
 	if (_host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(_host,
@@ -1236,7 +1238,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
@@ -1266,7 +1268,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->clk_cache)
 		host->set_clock(host, 0);
-- 
2.17.1


