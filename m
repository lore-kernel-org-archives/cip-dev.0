Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A82C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.10317.1746783134387287788
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pPqHJ0Lp;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3474175a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783133; x=1747387933; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFtQfBPFJXaEBLSilMpXd8oF7WR2M6kVWyECiy5/h7s=;
        b=pPqHJ0LpZzjBGzPJ+9b82qQvWJTxv0BEbTIpF1NV8rETa/NuGEU2F7dGIUyOM4FEHc
         Gw2SwVYJpRRLoaeUWbQGxI49J/ELzdw6lNH4GrWRllYptXIDp/4uYDRQ4fWrjdPaQW4V
         Xwx9sq33BiJE2EbPkEOLZvpsznmL+vOuNZTizq09DIVPKB5TI5yrY2FmXtqj9HzlDs8e
         fXdQIVmU9uW3y1M5c2zd6p+skR7dFzUf8pYs9PxneaPYwCQi7lTOyYYQJnpgXeNAlhMW
         oWhXdly5mNbVCm6w9i/ACTqcVNTu9hMjqD0I4kPdhQrrwzsIDpuTTt/7tpKThFq/XCFv
         Hodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783133; x=1747387933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFtQfBPFJXaEBLSilMpXd8oF7WR2M6kVWyECiy5/h7s=;
        b=wK2pmncpQdRQJbxgEHgfFRlRXQc8hNmVQ4TTYMajPhyD+HhQXK7LEuOxvecfW9UPyr
         TKLO+x4GqH/etKO4Wh+hDa8gvVRTYsrfSnPRNakfi3aLTqANqAYMlPAkJtU3GPgvOW0Q
         qk/NJWXPd9UTft9hvOaY6ZNgZpWqXhiXOe6HJ6i9rH1olZ22U516nS+YJnd9a1RGj4NP
         mZovM8yhr/c8SE1Qur6/fmpdRnKowrPb5pxJTY4/j75Pn8PqVrwQIZLQJTVtQzLmgmlO
         fbLmWEqLZEVH0snqbwsdlXODuTq5KuNy0abAbjE4uMO9v6QcByYYtu5TnBUDY1qU1zOj
         UCbA==
X-Forwarded-Encrypted: i=1; AJvYcCVYPfgsIln5nPYswfxLUi73S8JxxAPATSpg0DSViGX/nUYu25sUFJ8HvvzJvytsEkuOOYXOa/Zm@lists.cip-project.org
X-Gm-Message-State: AOJu0YwS3PCaKUa2fJ7E5Y2o0Gvwtlwos0/XrhN6fq1GkhN4qP1Zifmw
	tOSj+fW9NYMn2/TgECo6Z08K+CYn4T3ESwqgj9eBwm/fJP0cnDF7XRrgmtnfw00=
X-Gm-Gg: ASbGncsdBc5wAGS1x5p7KpQC9y27YNvpm2av5Yln4AvvyAWAnrotl3LjvvmOewCFyMG
	WKn4VIkO82uuxZxM7kqKaavYyTxOeUdbfmouOuRRn9PR8V41hnSI4eJ2TTJouDiWm1yU+weVkpO
	Kwsejt7IrfC4yPMe0qZl/ypxCRDkGOjOvGcgkRkRD09zi+cY42jOPhtw+vTlMnccgqGrp8DwZdP
	UtGtXvQw53o0hM4bfkpKCS6CoUPS/ISVbsI+B2BpSgYHxdJJysO2493AJ5Rwy0qRoLF3InThblC
	fZDvOUtxEbDBOSA1XiBa87JS/KTK1YIpM7gY5YNBH4eBLcI44rCM9lM8mUeZcDImFZALJw==
X-Google-Smtp-Source: AGHT+IGXVeOlCdhD+3Uk0Plfv6eVn2r24JuEtSvd2cYX0kdbosbw1/gai0llynAMG7O1vxpxuaSweg==
X-Received: by 2002:a05:6402:254f:b0:5f8:d18f:5689 with SMTP id 4fb4d7f45d1cf-5fca075e247mr2061503a12.13.1746783132780;
        Fri, 09 May 2025 02:32:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 06/29] clk: versaclock3: Prepare for the addition of 5L35023 device
Date: Fri,  9 May 2025 12:31:40 +0300
Message-ID: <20250509093203.4014750-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18793

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
index 76d7ea1964c3..1398d16df5d0 100644
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
 
@@ -680,8 +686,10 @@ static struct vc3_hw_data clk_pll[] = {
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
@@ -698,8 +706,6 @@ static struct vc3_hw_data clk_pll[] = {
 			.num = VC3_PLL2,
 			.int_div_msb_offs = VC3_PLL2_FB_INT_DIV_MSB,
 			.int_div_lsb_offs = VC3_PLL2_FB_INT_DIV_LSB,
-			.vco_min = VC3_PLL2_VCO_MIN,
-			.vco_max = VC3_PLL2_VCO_MAX
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "pll2",
@@ -716,8 +722,10 @@ static struct vc3_hw_data clk_pll[] = {
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
@@ -901,7 +909,6 @@ static struct vc3_hw_data clk_mux[] = {
 	[VC3_SE2_MUX] = {
 		.data = &(struct vc3_clk_data) {
 			.offs = VC3_SE2_CTRL_REG0,
-			.bitmsk = VC3_SE2_CTRL_REG0_SE2_CLK_SEL
 		},
 		.hw.init = &(struct clk_init_data) {
 			.name = "se2_mux",
@@ -982,6 +989,7 @@ static int vc3_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	u8 settings[NUM_CONFIG_REGISTERS];
+	const struct vc3_hw_cfg *data;
 	struct regmap *regmap;
 	const char *name;
 	int ret, i;
@@ -1029,9 +1037,16 @@ static int vc3_probe(struct i2c_client *client)
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
@@ -1059,6 +1074,11 @@ static int vc3_probe(struct i2c_client *client)
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
@@ -1108,8 +1128,13 @@ static int vc3_probe(struct i2c_client *client)
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


