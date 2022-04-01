Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52A3C64EC0
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.3452.1648842186562425330
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453849"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 02AC04011436;
	Sat,  2 Apr 2022 04:43:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 20/40] mmc: tmio: restore bus width when
 resetting
Date: Fri,  1 Apr 2022 20:42:14 +0100
Message-Id: <20220401194234.14057-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7931

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit 0a446288aa9f28ab00a31b8b51fdb005953f9f99 upstream.

Resetting the IP core will lose the bus width information and not all
code paths recover it. So, make sure the latest bus width gets restored
in the reset routine. For that, tmio_mmc_set_bus_width() is moved, but
not modified.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[wsa: reworded commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210316085717.7276-2-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0c752b4348de..ee9dc175e444 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -164,6 +164,21 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
+				   unsigned char bus_width)
+{
+	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
+				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
+
+	/* reg now applies to MMC_BUS_WIDTH_4 */
+	if (bus_width == MMC_BUS_WIDTH_1)
+		reg |= CARD_OPT_WIDTH;
+	else if (bus_width == MMC_BUS_WIDTH_8)
+		reg |= CARD_OPT_WIDTH8;
+
+	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
+}
+
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -177,6 +192,8 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	if (host->reset)
 		host->reset(host);
 
+	tmio_mmc_set_bus_width(host, host->mmc->ios.bus_width);
+
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
@@ -872,21 +889,6 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
 		host->set_pwr(host->pdev, 0);
 }
 
-static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
-				   unsigned char bus_width)
-{
-	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
-				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
-
-	/* reg now applies to MMC_BUS_WIDTH_4 */
-	if (bus_width == MMC_BUS_WIDTH_1)
-		reg |= CARD_OPT_WIDTH;
-	else if (bus_width == MMC_BUS_WIDTH_8)
-		reg |= CARD_OPT_WIDTH8;
-
-	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
-}
-
 static unsigned int tmio_mmc_get_timeout_cycles(struct tmio_mmc_host *host)
 {
 	u16 val = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
-- 
2.17.1


