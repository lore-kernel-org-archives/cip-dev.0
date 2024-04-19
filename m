Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20DEC04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:17 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.15301.1713514694212357960
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lmd0oXIX;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so709353e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514692; x=1714119492; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmjfW3gLAuiwFo4TBjIKxX7mrD4NENzgTfPQzyBWof0=;
        b=lmd0oXIXBDCsd8Q/FUmnzPDMcmXXWRArFVx74WCB0GOYWLIbNT4KMctQS9q2yqWEJW
         1jCg/B4hLoFZuA/PtxLQ12Y0bW7VRtNP6maCMaOENxg1f1vrU1go3GUVnIavlgEi3XRN
         H5E+HK98HbgyRAhHMVl+0nh8sPt7ucwg495dI0L/rBauwx6CeCOoRMb96AK6YIq7mUlh
         yNupyWpIiH5cHl6CBNwimyfzPGeCvDU9z5PKuQHpG0t6ZYeulJIBKO2vhrkYrdwo4W0D
         3Jj8CTNBgQoNeSx9Ahe1SVPRl/EWtnACMGmfPo9b93DQ8dqK2RxVSTxwRkFFGwY9vQyh
         Hkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514692; x=1714119492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmjfW3gLAuiwFo4TBjIKxX7mrD4NENzgTfPQzyBWof0=;
        b=QkSohycWhcjvuER3ncrU1izSiXZvrhO3lBAkpwOWkiDl4Ii5aZQEgwU6KgKkcGz4l0
         ywn96pW0G5nNpVBIyTfu39mSCsWZ/gufyrY9wJNWqccSFpqMyP6YxWkCkmN8RsGot88U
         EvQHB3FRN9ATDWz/DaMoQQRIrqnDXHTlNaDU62pVstI+yV7PnuJQGuljRavCaBlYk2+L
         RZusQhJRFUdIypzsrEf9VjvIO9P9nWS3nLrPYGgYLJN3idTttYTKR9IPGFtwX7d+GLJG
         KzFB2FEhcASYBHcXpmrO89JeLAoCQkOPsuUprhLPWLwTwH2LD3Mc/g4cYuyfqGIg9+dc
         Akjw==
X-Gm-Message-State: AOJu0Yw+R9phN6jWkwJMQ9gKZm9r7y3PqGDLK0ZYG3jq3xW9jQo5qGPN
	4Z3UkegVrii0hZxFdi2JeEbcyMofvg3jILBexJChj49FWWy8oTSXnJDmPxU/theb4w2gDgIDL6n
	f
X-Google-Smtp-Source: AGHT+IEqtDvwgnYD6oP8FNIPiUS0I/RS/jKKp1CJ2bLyBYgMSG1ATNob3fD8wlb7bNWHMSQBY8bJ/Q==
X-Received: by 2002:ac2:5504:0:b0:518:bd04:4faf with SMTP id j4-20020ac25504000000b00518bd044fafmr984381lfk.44.1713514692308;
        Fri, 19 Apr 2024 01:18:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 18/53] clk: renesas: rzg2l: Add struct clk_hw_data
Date: Fri, 19 Apr 2024 11:17:07 +0300
Message-Id: <20240419081742.3496709-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15605

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


