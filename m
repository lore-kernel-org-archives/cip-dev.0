Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933AEC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:10 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.18439.1713526741605709202
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=plC2B6qD;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so4777612a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526740; x=1714131540; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmjfW3gLAuiwFo4TBjIKxX7mrD4NENzgTfPQzyBWof0=;
        b=plC2B6qDr361w9fRsIfuv9yYtG/S3g20v+QMsRvFBVCnJMA5Vy0NqkXwwW8xvDwbO1
         0CZz2MVp8hUOud339c+kqKx01x3euSv73LVQie9KvqCQCEW5R39ilYqOz1k4sVf72SKN
         4mI6wrXMZf7B0FpF2SWPaJ+4mg0bjqjAd/i6TxrGf+3kaQx96939uki1Nb5Aez/57e3P
         Vl+M/MnU/3n+MTl4Qown2mJmEmu8uf/yrJ17xiXkIki2Geu6WYGaff2lPn4t2/V8oXWW
         WVSXTR79W4NAAc78GcQH8lnAiPiuLQ21UAT7EBCcj5GcCBFPEtB+6OGgYXs6UMeGr5CO
         N7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526740; x=1714131540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmjfW3gLAuiwFo4TBjIKxX7mrD4NENzgTfPQzyBWof0=;
        b=GsQW4uF5wKHpCTY5B7QFl5qzk+W+xAosjFUwsKumNAvH4NDt7nTOVe1EEjCSMPfg89
         RPFvGLhDSOXL/D9mj+zjUtyBSaO88Gi1lCQja1VsEFelyTTyEcmAG6Q49/oj8Zu/Y4gQ
         GaMxApEsiA3XyVhSmHAwNmF6N6Z6cylEO6NfJur2Ih2Yb30kxK7ORfSTOu0ID+pV9dgo
         wkr84opCLGp7Rj6K4CfMwgW5/JOThLecIgjMNXdZo0MLXLFAWOCQVDCpPq4XQtiJkbnn
         08Lu6hvq1FxzVZs87GhiddkLk5HUMpUdIeReYQxAe2/49ngk3MP+KMXpAPg34JO/gHc6
         8LoA==
X-Gm-Message-State: AOJu0YwQx2kP2Bpx9sYkP8cxggLgESkP+/OMCcmJ1ZPZsPHaglE6NauH
	dfXUMY8mFQ0ugpr4k5idmA6mzoIHtvW+TzI0L218DkplguOvoGd274BKT7pu9Dg=
X-Google-Smtp-Source: AGHT+IHeD94Us7rNhDKqbCaxaLe6iMEusfeNY4ypS03qxPUHKxdTSoxEEocl7HDQ6h+p/Bwj9kBodg==
X-Received: by 2002:a50:d4c3:0:b0:571:b82f:630d with SMTP id e3-20020a50d4c3000000b00571b82f630dmr1782241edj.0.1713526740008;
        Fri, 19 Apr 2024 04:39:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 11/44] clk: renesas: rzg2l: Add struct clk_hw_data
Date: Fri, 19 Apr 2024 14:38:09 +0300
Message-Id: <20240419113842.3675543-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15662

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 97c1c4ccda76d2919775d748cf223637cf0e82ae upstream.

Add clk_hw_data struct that keeps the core part of the clock data.
sd_hw_data embeds a member of type struct clk_hw_data along with other
members (in the next commits).  This commit prepares the field for
refactoring the SD MUX clock driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-9-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 52 +++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1a928828baac..fa492813f127 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -64,13 +64,29 @@
 
 #define MAX_VCLK_FREQ		(148500000)
 
-struct sd_hw_data {
+/**
+ * struct clk_hw_data - clock hardware data
+ * @hw: clock hw
+ * @conf: clock configuration (register offset, shift, width)
+ * @priv: CPG private data structure
+ */
+struct clk_hw_data {
 	struct clk_hw hw;
 	u32 conf;
 	struct rzg2l_cpg_priv *priv;
 };
 
-#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw)
+#define to_clk_hw_data(_hw)	container_of(_hw, struct clk_hw_data, hw)
+
+/**
+ * struct sd_hw_data - SD clock hardware data
+ * @hw_data: clock hw data
+ */
+struct sd_hw_data {
+	struct clk_hw_data hw_data;
+};
+
+#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw_data)
 
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
@@ -189,10 +205,10 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 off = GET_REG_OFFSET(hwdata->conf);
-	u32 shift = GET_SHIFT(hwdata->conf);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
 	const u32 clk_src_266 = 2;
 	u32 msk, val, bitmask;
 	unsigned long flags;
@@ -209,7 +225,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
 	 * the index to value mapping is done by adding 1 to the index.
 	 */
-	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
+	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
 	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 	if (index != clk_src_266) {
@@ -238,12 +254,12 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 
 static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 val = readl(priv->base + GET_REG_OFFSET(hwdata->conf));
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
 
-	val >>= GET_SHIFT(hwdata->conf);
-	val &= GENMASK(GET_WIDTH(hwdata->conf) - 1, 0);
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
 
 	return val ? val - 1 : 0;
 }
@@ -259,17 +275,17 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 			      void __iomem *base,
 			      struct rzg2l_cpg_priv *priv)
 {
-	struct sd_hw_data *clk_hw_data;
+	struct sd_hw_data *sd_hw_data;
 	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
-	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
-	if (!clk_hw_data)
+	sd_hw_data = devm_kzalloc(priv->dev, sizeof(*sd_hw_data), GFP_KERNEL);
+	if (!sd_hw_data)
 		return ERR_PTR(-ENOMEM);
 
-	clk_hw_data->priv = priv;
-	clk_hw_data->conf = core->conf;
+	sd_hw_data->hw_data.priv = priv;
+	sd_hw_data->hw_data.conf = core->conf;
 
 	init.name = core->name;
 	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
@@ -277,7 +293,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 	init.num_parents = core->num_parents;
 	init.parent_names = core->parent_names;
 
-	clk_hw = &clk_hw_data->hw;
+	clk_hw = &sd_hw_data->hw_data.hw;
 	clk_hw->init = &init;
 
 	ret = devm_clk_hw_register(priv->dev, clk_hw);
-- 
2.39.2


