Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E9DE92FF3
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ESQdlfRjQgaO2lbdubyStA==
X-CSE-MsgGUID: IYR2C0XYRcCKwktR4XYBgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:28 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF4734005037;
	Tue, 30 Dec 2025 07:39:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/17] i2c: riic: Make use of devres helper to request deasserted reset line
Date: Mon, 29 Dec 2025 22:39:02 +0000
Message-ID: <20251229223911.8663-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21266

commit 3d9e63c3aba479ec2f669cbc410754a2b1cf38fb upstream.

Simplify the `riic_i2c_probe()` function by using the
`devm_reset_control_get_optional_exclusive_deasserted()` API to request a
deasserted reset line. This eliminates the need to manually deassert the
reset control and the additional cleanup.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 79540179fbd8f..28ca8b9bfa2bb 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -447,11 +447,6 @@ static const struct riic_irq_desc riic_irqs[] = {
 	{ .res_num = 5, .isr = riic_tend_isr, .name = "riic-nack" },
 };
 
-static void riic_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static int riic_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -472,18 +467,10 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(riic->clk),
 				     "missing controller clock");
 
-	riic->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	riic->rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(riic->rstc))
 		return dev_err_probe(dev, PTR_ERR(riic->rstc),
-				     "Error: missing reset ctrl\n");
-
-	ret = reset_control_deassert(riic->rstc);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, riic_reset_control_assert, riic->rstc);
-	if (ret)
-		return ret;
+				     "failed to acquire deasserted reset\n");
 
 	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
 		int irq;
-- 
2.43.0


