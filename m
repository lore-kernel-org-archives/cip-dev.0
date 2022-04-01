Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B95C64EC5
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3730.1648842183742553017
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="116465345"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB1A240061B8;
	Sat,  2 Apr 2022 04:43:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 15/40] mmc: tmio: Add data timeout error
 detection
Date: Fri,  1 Apr 2022 20:42:09 +0100
Message-Id: <20220401194234.14057-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7926

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

commit 35cdcd1268f654f55e2308767349c44bd25d8009 upstream.

Currently, busy timeout is not checked for data transfer command. But,
if the temperature condition changes, the data cannot be acquired
correctly and timeout may occur. Also, we could reproduce an issue by
using mmc_test driver (e.g. "Correct xfer_size at write (start
failure)"). Therefore, this adds timeout error check.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[saito: rework commit message.]
Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[shimoda: rebase, add commit description]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1608708622-29668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 85dc5b9f4e60..e694d98faed1 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -477,8 +477,10 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 	if (!data)
 		goto out;
 
-	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
-	    stat & TMIO_STAT_TXUNDERRUN)
+	if (stat & TMIO_STAT_DATATIMEOUT)
+		data->error = -ETIMEDOUT;
+	else if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
+		 stat & TMIO_STAT_TXUNDERRUN)
 		data->error = -EILSEQ;
 	if (host->dma_on && (data->flags & MMC_DATA_WRITE)) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
-- 
2.17.1


