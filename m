Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610AEC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.10292.1746783215665432845
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UDD02JKM;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbe7a65609so3216779a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783214; x=1747388014; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEzMMt/t+2HZ3eK3lg6fbaCqkTLpMAG8NPYBWE3MtCw=;
        b=UDD02JKMql6eR++Ol7SCrWxMAILe3tARfwvW8qp9N8FKxfq6Wci+rySPV05MNdX159
         vyr6jq3QqE43DCWuzsK4JoRa658zX1f9ZMv1nK3AnJj+jHqSXbbn1fEq33UuCFVWLc0X
         pQWY9HwT2c3mxr2Tf4iDUSCZvRbeu0F9EK2NEUEnKZNkIa9Kx6ApWCDdoHSHT64GWE10
         djy2SWs0ElfTejHjyu/2qdt+MqKEYCS9mZfrHMLq6AK7+/oFiUk3b9ePXXp81fHZyxV3
         7al9uWFQSnRfjw3hnh4rtPMAAhs2Cgxdun1UTCXunlcl2XpjHBrbkJWcScB+92LOdBit
         PUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783214; x=1747388014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEzMMt/t+2HZ3eK3lg6fbaCqkTLpMAG8NPYBWE3MtCw=;
        b=LB+yc5ZFCelS0UdX3FoVYsL0yiE0/ncpXgmDvrZ92waR+Lzjdbc/gAyPmERrMzf4mv
         Vdjd8YUVk5Zj6CdUI/hWJBg8y8O7oQ9WhcOO2YxAyTPxz0VuWF2rkfZtGonGFQR9sJnt
         WPYhe0LOlq/zmSmctsdPbF/MIuJa74AvPZEA6qJBS5Lr8aCSskGRSsPkp8z6lIL08c7l
         pS4iA3p7M88R2lP28A+U7dhoLZBG2wqZS1FuXg3eaJE6CLnnKEqDN8veFK4hFFFN9uvY
         UVNhbRBHEhc2Xhii084wNu/uqWVFj/w6gJ4UQVIcjB+MIi3P9rPEwURf1ijCtyMZBySV
         xFZg==
X-Forwarded-Encrypted: i=1; AJvYcCXAAdzgG71NJd0E/jQPfK7qmOIf0CkpPKTqaRC6/GSNlTgWwHoUVS9n/BNnne8jFtIWw3V4Ma+N@lists.cip-project.org
X-Gm-Message-State: AOJu0YxyQhAYByKRnP9Ua0o/mLVC2TFnTfg6e1Oh6iPWqggkPdkKfEbJ
	dcadSXeov8eGY64334zr6enqi6CX9xg5ret6DRI83CrD9y90GxKasfUKJb2QlNk=
X-Gm-Gg: ASbGnct7ZYKl+fWe9SPRSS+dJu2fyxY5ty7R/emIG5BtInKXg1Bhm6tEGT11/ahhd5s
	F8+zfd4Uf/LMyczo0P30bFnTg4AICJ0HZVIar18PmsAbvJlKrg9XbkuC+wkEwNtIqOMXXCVr4X5
	3yDessronI70bkTCOisozlLiG1mZ4NDni2CMut8O6ZkzCSgrp3f0ZCPr1+FoV5GXtzVGehnozq5
	nTt4JItB7jX5x+8ghhhoNMrRqDb4f0IQx2Qdmt2a4e5GrYa8r6M298jIeoHuH8OK738z4Cr0RmU
	Ufq5XoYXEHuCyVJd2FGABU26bMG6pYc1L++GGNfYGSPR2I+x2zZ3PQ7bS8bV7R4FgF4WSA==
X-Google-Smtp-Source: AGHT+IHxsH7Sgep33IZ9I/2q8HTgKR33twekyWtd51Co+zt06byJwK7odNyFn7VW5ch3onS56LM0rA==
X-Received: by 2002:a05:6402:354e:b0:5f7:eaf0:8849 with SMTP id 4fb4d7f45d1cf-5fca0770858mr2061388a12.16.1746783213977;
        Fri, 09 May 2025 02:33:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 11/34] clk: versaclock3: Prepare for the addition of 5L35023 device
Date: Fri,  9 May 2025 12:32:55 +0300
Message-ID: <20250509093318.4014916-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18828

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ae6040cd7c7f8e80deefe5a49691734480f97409 upstream.

The 5P35023 and 5L35035 Versa 3 clock generator variants are different but
the versaclock3 driver could be used with small adjustments. The features
that are implemented in driver and differs b/w variants are the PLL2 Fvco
and clock sel bit for SE2 clock. Adjust the driver to prepare for the
addition of 5L35023 device.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241210170953.2936724-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 61 ++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index f0222b63755d..c3e33d210689 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -78,9 +78,6 @@
 #define VC3_PLL1_VCO_MIN		300000000UL
 #define VC3_PLL1_VCO_MAX		600000000UL
 
-#define VC3_PLL2_VCO_MIN		400000000UL
-#define VC3_PLL2_VCO_MAX		1200000000UL
-
 #define VC3_PLL3_VCO_MIN		300000000UL
 #define VC3_PLL3_VCO_MAX		800000000UL
 
@@ -147,9 +144,13 @@ struct vc3_pfd_data {
 	u8 mdiv2_bitmsk;
 };
 
+struct vc3_vco {
+	unsigned long min;
+	unsigned long max;
+};
+
 struct vc3_pll_data {
-	unsigned long vco_min;
-	unsigned long vco_max;
+	struct vc3_vco vco;
 	u8 num;
 	u8 int_div_msb_offs;
 	u8 int_div_lsb_offs;
@@ -166,12 +167,17 @@ struct vc3_div_data {
 struct vc3_hw_data {
 	struct clk_hw hw;
 	struct regmap *regmap;
-	const void *data;
+	void *data;
 
 	u32 div_int;
 	u32 div_frc;
 };
 
+struct vc3_hw_cfg {
+	struct vc3_vco pll2_vco;
+	u32 se2_clk_sel_msk;
+};
+
 static const struct clk_div_table div1_divs[] = {
 	{ .val = 0, .div = 1, }, { .val = 1, .div = 4, },
 	{ .val = 2, .div = 5, }, { .val = 3, .div = 6, },
@@ -386,10 +392,10 @@ static long vc3_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	const struct vc3_pll_data *pll = vc3->data;
 	u64 div_frc;
 
-	if (rate < pll->vco_min)
-		rate = pll->vco_min;
-	if (rate > pll->vco_max)
-		rate = pll->vco_max;
+	if (rate < pll->vco.min)
+		rate = pll->vco.min;
+	if (rate > pll->vco.max)
+		rate = pll->vco.max;
 
 	vc3->div_int = rate / *parent_rate;
 
@@ -686,8 +692,10 @@ static struct vc3_hw_data clk_pll[] = {
 			.num = VC3_PLL1,
 			.int_div_msb_offs = VC3_PLL1_LOOP_FILTER_N_DIV_MSB,
 			.int_div_lsb_offs = VC3_PLL1_VCO_N_DIVIDER,
-			.vco_min = VC3_PLL1_VCO_MIN,
-			.vco_max = VC3_PLL1_VCO_MAX
+			.vco = {
+				.min = VC3_PLL1_VCO_MIN,
+				.max = VC3_PLL1_VCO_MAX
+			}
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "pll1",
@@ -704,8 +712,6 @@ static struct vc3_hw_data clk_pll[] = {
 			.num = VC3_PLL2,
 			.int_div_msb_offs = VC3_PLL2_FB_INT_DIV_MSB,
 			.int_div_lsb_offs = VC3_PLL2_FB_INT_DIV_LSB,
-			.vco_min = VC3_PLL2_VCO_MIN,
-			.vco_max = VC3_PLL2_VCO_MAX
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "pll2",
@@ -722,8 +728,10 @@ static struct vc3_hw_data clk_pll[] = {
 			.num = VC3_PLL3,
 			.int_div_msb_offs = VC3_PLL3_LOOP_FILTER_N_DIV_MSB,
 			.int_div_lsb_offs = VC3_PLL3_N_DIVIDER,
-			.vco_min = VC3_PLL3_VCO_MIN,
-			.vco_max = VC3_PLL3_VCO_MAX
+			.vco = {
+				.min = VC3_PLL3_VCO_MIN,
+				.max = VC3_PLL3_VCO_MAX
+			}
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "pll3",
@@ -907,7 +915,6 @@ static struct vc3_hw_data clk_mux[] = {
 	[VC3_SE2_MUX] = {
 		.data = &(struct vc3_clk_data) {
 			.offs = VC3_SE2_CTRL_REG0,
-			.bitmsk = VC3_SE2_CTRL_REG0_SE2_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "se2_mux",
@@ -988,6 +995,7 @@ static int vc3_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	u8 settings[NUM_CONFIG_REGISTERS];
+	const struct vc3_hw_cfg *data;
 	struct regmap *regmap;
 	const char *name;
 	int ret, i;
@@ -1035,9 +1043,16 @@ static int vc3_probe(struct i2c_client *client)
 					     clk_pfd[i].hw.init->name);
 	}
 
+	data = i2c_get_match_data(client);
+
 	/* Register pll's */
 	for (i = 0; i < ARRAY_SIZE(clk_pll); i++) {
 		clk_pll[i].regmap = regmap;
+		if (i == VC3_PLL2) {
+			struct vc3_pll_data *pll_data = clk_pll[i].data;
+
+			pll_data->vco = data->pll2_vco;
+		}
 		ret = devm_clk_hw_register(dev, &clk_pll[i].hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "%s failed\n",
@@ -1065,6 +1080,11 @@ static int vc3_probe(struct i2c_client *client)
 	/* Register clk muxes */
 	for (i = 0; i < ARRAY_SIZE(clk_mux); i++) {
 		clk_mux[i].regmap = regmap;
+		if (i == VC3_SE2_MUX) {
+			struct vc3_clk_data *clk_data = clk_mux[i].data;
+
+			clk_data->bitmsk = data->se2_clk_sel_msk;
+		}
 		ret = devm_clk_hw_register(dev, &clk_mux[i].hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "%s failed\n",
@@ -1114,8 +1134,13 @@ static int vc3_probe(struct i2c_client *client)
 	return ret;
 }
 
+static const struct vc3_hw_cfg vc3_5p = {
+	.pll2_vco = { .min = 400000000UL, .max = 1200000000UL },
+	.se2_clk_sel_msk = BIT(6),
+};
+
 static const struct of_device_id dev_ids[] = {
-	{ .compatible = "renesas,5p35023" },
+	{ .compatible = "renesas,5p35023", .data = &vc3_5p },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
-- 
2.43.0


