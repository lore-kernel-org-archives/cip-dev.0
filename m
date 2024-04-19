Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E5FC05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.15304.1713514699782911652
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ac6VR8Ms;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571d7b39c30so127277a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514698; x=1714119498; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW9hFzvzbTr7gZWfISlthgT79ZUg72qLKS8Ey3B9dPA=;
        b=Ac6VR8Ms8gOPw3/zjVNl9mPZM9psblSlAkORpUAOnecsEn7h4nPLnzLaup6SL+M+p0
         WeASkxlgU6COXiz538rsmANMYlgZEzJQHoB4c7wi+jE03fzG0AjTfdTTT5u5ynWKE9LE
         eg9XmMwW8U/L8s2wmRwSOyMM8K65Ybq5zBuggQxTFqZb9Out/zXI/OocVOHOvQYKQkA8
         nDTK86sqYNWHZ5NMh8/ShNCaNIXz6H1rL1DRPD29JEr2QbfrNzYLQDcDTf+WJo9Ui4LG
         j59VZAZih+Ts3+jYsxXISW9IpFolsQUmDkrYRAlAsCMATG8EfLh5BEcnTYuYSfLXNV2m
         9qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514698; x=1714119498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW9hFzvzbTr7gZWfISlthgT79ZUg72qLKS8Ey3B9dPA=;
        b=fWlCajQQhpTVSYNJdzalr26KjS0l9BDrP0sQA3RexoR48zNxsTU/hjwqcavUQRmDKO
         bPdk3de9nsun6zYO+bkj0cFRQ4fpod64GEKqN9dMLTpeGORaJZUTRXNcLey8SRhustdT
         VMZgGcRoPVpB4ycFeEiGl4Ki2eVXTBtAiZpiQAqHsfUsL62KnFUs9Mo3Ks6KAthWsJSM
         xOLV24fYoUGKXlii9fT21j6JKSbALD/m+H7P0dTqrBThbSKFp3zuOEr1KpuwJgPSdlPM
         smJiT2wW1OE+INrx/jwMMeqrOopixw+71FhqHQvidsD6tA9J6nWauRvlG9SJKHMhyKM4
         tMBA==
X-Gm-Message-State: AOJu0YzDO73cu6LCEBtevUfT7ylNoqFukXPtNsc2qIQ1xw+3cHgePoDm
	teIuWrjmFPvvO98KOeaFUbwoaxqV5TyZYtwfnctFBi65lOJeJYjPs25CCjNKDRY=
X-Google-Smtp-Source: AGHT+IHmIrzFJbDoQOFGsP0RU0y6cXAp3IFoCcKbkGVMzJp2qesp8RlDGXAzTswCiS9619WJb48f3w==
X-Received: by 2002:a17:906:f119:b0:a55:8c17:a8d1 with SMTP id gv25-20020a170906f11900b00a558c17a8d1mr313429ejb.18.1713514698222;
        Fri, 19 Apr 2024 01:18:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 22/53] clk: renesas: rzg2l: Add divider clock for RZ/G3S
Date: Fri, 19 Apr 2024 11:17:11 +0300
Message-Id: <20240419081742.3496709-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15609

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 62b1feac485866494f111e3a6aa4a9ae03a7a2b9 upstream.

Add a divider clock driver for RZ/G3S.  This will be used on RZ/G3S for
the SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, and P3 core clocks.
The divider has some limitation for SDHI, OCTA and SPI clocks:
  - SDHI div cannot be 1 if parent rate is 800MHz,
  - OCTA, SPI div cannot be 1 if parent rate is 400MHz.
To handle these limitations, a notifier is registered from platform
specific clock driver, which makes sure proper actions are taken before
the clock rate is changed, when needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231006103959.197485-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 186 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  11 ++
 2 files changed, 197 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 9054ad40063f..3b691445bf52 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -94,6 +94,24 @@ struct sd_mux_hw_data {
 
 #define to_sd_mux_hw_data(_hw)	container_of(_hw, struct sd_mux_hw_data, hw_data)
 
+/**
+ * struct div_hw_data - divider clock hardware data
+ * @hw_data: clock hw data
+ * @dtable: pointer to divider table
+ * @invalid_rate: invalid rate for divider
+ * @max_rate: maximum rate for divider
+ * @width: divider width
+ */
+struct div_hw_data {
+	struct clk_hw_data hw_data;
+	const struct clk_div_table *dtable;
+	unsigned long invalid_rate;
+	unsigned long max_rate;
+	u32 width;
+};
+
+#define to_div_hw_data(_hw)	container_of(_hw, struct div_hw_data, hw_data)
+
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
 	u8 pl5_refdiv;
@@ -202,6 +220,53 @@ int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event
 	return notifier_from_errno(ret);
 }
 
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event,
+			       void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	unsigned long flags;
+	int ret = 0;
+	u32 val;
+
+	if (event != PRE_RATE_CHANGE || !div_hw_data->invalid_rate ||
+	    div_hw_data->invalid_rate % cnd->new_rate)
+		return NOTIFY_DONE;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+
+	val = readl(priv->base + off);
+	val >>= shift;
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+
+	/*
+	 * There are different constraints for the user of this notifiers as follows:
+	 * 1/ SD div cannot be 1 (val == 0) if parent rate is 800MHz
+	 * 2/ OCTA / SPI div cannot be 1 (val == 0) if parent rate is 400MHz
+	 * As SD can have only one parent having 800MHz and OCTA div can have
+	 * only one parent having 400MHz we took into account the parent rate
+	 * at the beginning of function (by checking invalid_rate % new_rate).
+	 * Now it is time to check the hardware divider and update it accordingly.
+	 */
+	if (!val) {
+		writel((CPG_WEN_BIT | 1) << shift, priv->base + off);
+		/* Wait for the update done. */
+		ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	}
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "Failed to downgrade the div\n");
+
+	return notifier_from_errno(ret);
+}
+
 static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
 				   struct rzg2l_cpg_priv *priv)
 {
@@ -219,6 +284,124 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
 	return clk_notifier_register(hw->clk, nb);
 }
 
+static unsigned long rzg3s_div_clk_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val;
+
+	val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+
+	return divider_recalc_rate(hw, parent_rate, val, div_hw_data->dtable,
+				   CLK_DIVIDER_ROUND_CLOSEST, div_hw_data->width);
+}
+
+static int rzg3s_div_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+
+	if (div_hw_data->max_rate && req->rate > div_hw_data->max_rate)
+		req->rate = div_hw_data->max_rate;
+
+	return divider_determine_rate(hw, req, div_hw_data->dtable, div_hw_data->width,
+				      CLK_DIVIDER_ROUND_CLOSEST);
+}
+
+static int rzg3s_div_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	val = divider_get_val(rate, parent_rate, div_hw_data->dtable, div_hw_data->width,
+			      CLK_DIVIDER_ROUND_CLOSEST);
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	writel((CPG_WEN_BIT | val) << shift, priv->base + off);
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops rzg3s_div_clk_ops = {
+	.recalc_rate = rzg3s_div_clk_recalc_rate,
+	.determine_rate = rzg3s_div_clk_determine_rate,
+	.set_rate = rzg3s_div_clk_set_rate,
+};
+
+static struct clk * __init
+rzg3s_cpg_div_clk_register(const struct cpg_core_clk *core, struct clk **clks,
+			   void __iomem *base, struct rzg2l_cpg_priv *priv)
+{
+	struct div_hw_data *div_hw_data;
+	struct clk_init_data init = {};
+	const struct clk_div_table *clkt;
+	struct clk_hw *clk_hw;
+	const struct clk *parent;
+	const char *parent_name;
+	u32 max = 0;
+	int ret;
+
+	parent = clks[core->parent & 0xffff];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	parent_name = __clk_get_name(parent);
+
+	div_hw_data = devm_kzalloc(priv->dev, sizeof(*div_hw_data), GFP_KERNEL);
+	if (!div_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = core->name;
+	init.flags = core->flag;
+	init.ops = &rzg3s_div_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	/* Get the maximum divider to retrieve div width. */
+	for (clkt = core->dtable; clkt->div; clkt++) {
+		if (max < clkt->div)
+			max = clkt->div;
+	}
+
+	div_hw_data->hw_data.priv = priv;
+	div_hw_data->hw_data.conf = core->conf;
+	div_hw_data->hw_data.sconf = core->sconf;
+	div_hw_data->dtable = core->dtable;
+	div_hw_data->invalid_rate = core->invalid_rate;
+	div_hw_data->max_rate = core->max_rate;
+	div_hw_data->width = fls(max) - 1;
+
+	clk_hw = &div_hw_data->hw_data.hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(priv->dev, clk_hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = rzg2l_register_notifier(clk_hw, core, priv);
+	if (ret) {
+		dev_err(priv->dev, "Failed to register notifier for %s\n",
+			core->name);
+		return ERR_PTR(ret);
+	}
+
+	return clk_hw->clk;
+}
+
 static struct clk * __init
 rzg2l_cpg_div_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
@@ -964,6 +1147,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		clk = rzg2l_cpg_div_clk_register(core, priv->clks,
 						 priv->base, priv);
 		break;
+	case CLK_TYPE_G3S_DIV:
+		clk = rzg3s_cpg_div_clk_register(core, priv->clks, priv->base, priv);
+		break;
 	case CLK_TYPE_MUX:
 		clk = rzg2l_cpg_mux_clk_register(core, priv->base, priv);
 		break;
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index f1910913b29a..4755befaf38e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -89,6 +89,8 @@ struct cpg_core_clk {
 	unsigned int sconf;
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
+	const unsigned long invalid_rate;
+	const unsigned long max_rate;
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -105,6 +107,7 @@ enum clk_types {
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
+	CLK_TYPE_G3S_DIV,
 
 	/* Clock with clock source selector */
 	CLK_TYPE_MUX,
@@ -143,6 +146,13 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, \
 		 .flag = CLK_DIVIDER_READ_ONLY)
+#define DEF_G3S_DIV(_name, _id, _parent, _conf, _sconf, _dtable, _invalid_rate, \
+		    _max_rate, _clk_flags, _notif) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_DIV, .conf = _conf, .sconf = _sconf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .invalid_rate = _invalid_rate, \
+		 .max_rate = _max_rate, .flag = (_clk_flags), \
+		 .notifier = _notif)
 #define DEF_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
@@ -277,5 +287,6 @@ extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
 
 #endif
-- 
2.39.2


