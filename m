Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B10FCC048
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: 8ZNO3c8dSsihIW2USuq5vg==
X-CSE-MsgGUID: StMP1RpwSByea08mdGp5vg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:37 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 22AD74031C01;
	Sat,  7 Mar 2026 02:18:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 07/17] spi: rzv2h-rspi: make clocks chip-specific
Date: Fri,  6 Mar 2026 19:17:25 +0200
Message-ID: <20260306171735.226034-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22132

commit ebd7d6ae0dc7d65e21460c928519f40ccf95f3b9 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different clocks compared to RZ/V2H. Set the number of clocks and the
name of the transfer clock in the chip-specific structure to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-4-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 7a7a576c17dd..a1f17ec8727b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -66,10 +66,11 @@
 #define RSPI_SPSRC_CLEAR	0xfd80
 
 #define RSPI_RESET_NUM		2
-#define RSPI_CLK_NUM		3
 
 struct rzv2h_rspi_info {
+	const char *tclk_name;
 	unsigned int fifo_size;
+	unsigned int num_clks;
 };
 
 struct rzv2h_rspi_priv {
@@ -373,11 +374,11 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 		return PTR_ERR(rspi->base);
 
 	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
-	if (ret != RSPI_CLK_NUM)
+	if (ret != rspi->info->num_clks)
 		return dev_err_probe(dev, ret >= 0 ? -EINVAL : ret,
 				     "cannot get clocks\n");
-	for (i = 0; i < RSPI_CLK_NUM; i++) {
-		if (!strcmp(clks[i].id, "tclk")) {
+	for (i = 0; i < rspi->info->num_clks; i++) {
+		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
 			rspi->tclk = clks[i].clk;
 			break;
 		}
@@ -452,7 +453,9 @@ static void rzv2h_rspi_remove(struct platform_device *pdev)
 }
 
 static const struct rzv2h_rspi_info rzv2h_info = {
+	.tclk_name = "tclk",
 	.fifo_size = 16,
+	.num_clks = 3,
 };
 
 static const struct of_device_id rzv2h_rspi_match[] = {
-- 
2.53.0

