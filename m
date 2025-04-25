Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BECC369D7
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 09:11:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2723.1745572277578265580
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 02:11:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: /uU4impITOWneL5189mpZA==
X-CSE-MsgGUID: L6bdXLqmQKSdrAuPYmlTjQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 18:11:21 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B673241FE01A;
	Fri, 25 Apr 2025 18:11:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 10/15] i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
Date: Fri, 25 Apr 2025 10:10:52 +0100
Message-ID: <20250425091057.33752-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 09:11:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18614

commit e2aa2502e8067527e36dd7a3cad81b2004614a6c upstream.

Refactor error handling in the riic_i2c_probe() and riic_init_hw()
functions by replacing multiple dev_err() calls with dev_err_probe().

Additionally, update the riic_init_hw() function to use a local `dev`
pointer instead of `riic->adapter.dev` for dev_err_probe(), as the I2C
adapter is not initialized at this stage. Drop the cast to (unsigned long)
in the riic_init_hw() function when printing the bus frequency, and update
the error message to display the frequency in Hz, improving clarity.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 4fb910e0b3df3..ee48ec2f54cce 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -357,11 +357,9 @@ static int riic_init_hw(struct riic_dev *riic)
 		rate /= 2;
 	}
 
-	if (brl > (0x1F + 3)) {
-		dev_err(&riic->adapter.dev, "invalid speed (%lu). Too slow.\n",
-			(unsigned long)t->bus_freq_hz);
-		return -EINVAL;
-	}
+	if (brl > (0x1F + 3))
+		return dev_err_probe(dev, -EINVAL, "invalid speed (%uHz). Too slow.\n",
+				     t->bus_freq_hz);
 
 	brh = total_ticks - brl;
 
@@ -446,10 +444,9 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(riic->base);
 
 	riic->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(riic->clk)) {
-		dev_err(dev, "missing controller clock");
-		return PTR_ERR(riic->clk);
-	}
+	if (IS_ERR(riic->clk))
+		return dev_err_probe(dev, PTR_ERR(riic->clk),
+				     "missing controller clock");
 
 	riic->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(riic->rstc))
@@ -473,10 +470,9 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(dev, irq, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
-		if (ret) {
-			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request irq %s\n",
+					     riic_irqs[i].name);
 	}
 
 	riic->info = of_device_get_match_data(dev);
-- 
2.43.0


