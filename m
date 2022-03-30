Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F56C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.2209.1648666508225964836
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211115"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C465440D5446;
	Thu, 31 Mar 2022 03:55:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/39] mmc: tmio: always flag retune when resetting
 and a card is present
Date: Wed, 30 Mar 2022 19:54:37 +0100
Message-Id: <20220330185454.10887-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7873

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6e5c951b4c3a0bd9aa5838ecec98f3c795c83ff1 upstream.

After reset, we manually flagged retune in runtime resume, but missed it
in the workqueue. To fix that and avoid the problem in the future, let's
flag retune in the reset handler directly whenever a card is present.

Reported-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210316085717.7276-3-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ee9dc175e444..59372de733b2 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -198,6 +198,9 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
 	}
+
+	if (host->mmc->card)
+		mmc_retune_needed(host->mmc);
 }
 
 static void tmio_mmc_reset_work(struct work_struct *work)
@@ -1297,8 +1300,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
-	mmc_retune_needed(host->mmc);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
-- 
2.17.1


