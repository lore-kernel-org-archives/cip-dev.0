Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C2C369D5
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.489.1745442302682817640
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 1PdTFN5URJeAoz4JNkLS0A==
X-CSE-MsgGUID: 9D56TAi1T9qRfCVW9t/+dg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:03 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 926B2401C946;
	Thu, 24 Apr 2025 06:05:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 1/8] i2c: riic: Introduce a separate variable for IRQ
Date: Wed, 23 Apr 2025 22:04:51 +0100
Message-ID: <20250423210458.14698-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18584

commit 76dc16296124ec478ec9ac011f0b9b52462c88d5 upstream.

Refactor the IRQ handling in riic_i2c_probe by introducing a local variable
`irq` to store IRQ numbers instead of assigning them to `ret`. This change
improves code readability and clarity.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 2c982199782f..0df5a024140b 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -464,11 +464,13 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
-		ret = platform_get_irq(pdev, riic_irqs[i].res_num);
-		if (ret < 0)
-			return ret;
+		int irq;
+
+		irq = platform_get_irq(pdev, riic_irqs[i].res_num);
+		if (irq < 0)
+			return irq;
 
-		ret = devm_request_irq(dev, ret, riic_irqs[i].isr,
+		ret = devm_request_irq(dev, irq, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
 		if (ret) {
 			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
-- 
2.43.0


