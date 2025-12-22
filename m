Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A42E6749F
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78283.1766402237888739347
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kyggh5mx;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7eff205947so534032766b.1
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402236; x=1767007036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4pU34AFHE0E0dar1unKtE7IOWnCwO4BzgTGfnf5ozM=;
        b=kyggh5mxiHgpv105X6syKWwcW0iy6khV8hkt4cqwc5tezCg++BD+hc5q+/wF0l4EAN
         PlrrzsOYsEMS/HkEaA1LNGkIdfSLw7Kwmq8hPskfE7SE9m/LtELjohi0YJWubJ82LKcW
         Q4fqNlCyBURCzspB7EjqXgMxeu7XmNKwoYvVHaC8h64aRBZefBQmRoj9yxPBj+7AfAG/
         +Laih03RTO2xDCPrGLL5uIyKlpsXNwhHgxGT4HS3drWe4x11+y6msk0/nd7hpdOUH+/o
         H6u6qcVFT6EQg+Ur62t3fFtSsw88bt1lwuVJ6cxQk6Gpf+mh8z2jDjgbIzF5D8de55I7
         Cj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402236; x=1767007036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4pU34AFHE0E0dar1unKtE7IOWnCwO4BzgTGfnf5ozM=;
        b=lFWZklkz5vEE4RNTKyc41Hr69lahS0Si1jOLfd+ZRi0OkT/zcjDIixIXwgU/LckxBm
         sE1hQIEbp5Gar8jlM42oj/xkBMcfdSZbJs+POK7OeOhIMpp/LIQlSn+QJR0CdF0ThER0
         pKccaLoDzpv612dM7QQhVAcg+8kQmCZ4V//epc9dkvhpGPobyqQMDo2cD58zu5Hssz2l
         8g/ZV4OcfjEK9NfUILzSGUQ1xZKrn2uVbXQUpGKaEaa+ZdCtmNWSCj9AI1QQpKLPxKpe
         HmdWXVUM76TvF0f4CjVhoUBV3gUa8gv89LJpS3/yyt15ujNXVqamNTGhbND5NDZDQ/LH
         PuPQ==
X-Gm-Message-State: AOJu0Yy4DaaWXh8vg/ayL51rJD3cx9jRmwTTdIPAjmhZcHr7TZKlCB9B
	wT5r9vi2v7/AaXbV7cQexocEnSkCM40RGleyV9OIM7bpKeX98ixv/brVF1RtgQ==
X-Gm-Gg: AY/fxX75/m2XqFDCnwjWwgAa5tOvPzRLCKvIvj45LK8wCTqyuH1MdDrYHU/g4HAUy4h
	qWNVRLioTZd7+G+B4qeu3vNOqZXjCyQqMIR7AKydFd31Dm0Z4Nt03WiHNcDJrgHBBD5LjmvZxGa
	ob1EyUgesmrr/b6VwRfN6yMQo/tnpzjKFdVI7eL2tPeWmUTDU8N8TRaciUu1deaJP4UgImmaSWu
	SBXRmBoKTJA0JXFk5S55q6MFgRtG4gGSokN5DBrWdhOqFnyHEqrzMupbQTxYO2IRfs/5XL8B0zq
	53Yhmciy8AW8acfb2WtxDJ67T3MgjlskN9eiYT6ihRjc6VTeN3Oa+129wzoOQP5g/gLK1MvqAXm
	KpWXqEHkRBGR77FBZmftfakaUmh+nw0nCbiq1TFYRkHOxS+oakAbw89oh5R7ZyMLRZLSLWtCESJ
	gBwQ0MPRba1HwSowsxo4lB2EYXpEzAILcrDOA=
X-Google-Smtp-Source: AGHT+IGLpHxIwIDWrTkQ9cLB8Fm5tdMUYcR7AP1fe3HNyeBpfM84AewzToDQVAkIxCLTAeDi/Vc8Qw==
X-Received: by 2002:a17:907:9622:b0:b45:66f6:6a0a with SMTP id a640c23a62f3a-b80371801eemr1116705166b.44.1766402235952;
        Mon, 22 Dec 2025 03:17:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:15 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/24] can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
Date: Mon, 22 Dec 2025 11:16:51 +0000
Message-ID: <20251222111705.27028-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21205

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit eda3d6c8d784835cec86f42b3f8118c9eb0cc58c ]

Replace devm_clk_get_optional_enabled()->devm_clk_get_optional() as the
RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251124102837.106973-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3924e46e448a..6db17bcb6f73 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -468,6 +468,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1976,7 +1977,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2066,10 +2066,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
-	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
-	if (IS_ERR(clk_ram))
-		return dev_err_probe(dev, PTR_ERR(clk_ram),
-				     "cannot get enabled ram clock\n");
+	gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2135,10 +2135,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2190,6 +2198,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2214,6 +2224,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


