Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9BCD6553A
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11759.1765967535320812393
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fg3+Z44T;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so80909666b.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967534; x=1766572334; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqN6koPFcrVj4IRl7yzs9GDyC0SN7MeceAgCjTYlFyg=;
        b=fg3+Z44TzjiXsyNrw9TziBum7i2TCFDOGu65DnhxcjWUXPEZLCUZ9b9WtIjs+i+zsv
         YQxZuJhV2OYSQoqq/5sZxNFbeDhrBpmIq3pYfVQzSUN4//hRAzM4IXdwlb2cx4GG1y+T
         /Z5E0YLU5tyb5YWFwhF1J9dcwAk2r5kWeed2e/+U3IUlwHNgHMP2gn5AqA0imvgc1T53
         3MyVdWmxcCxozrEWBadIx0OIuoUsV2epwTXOXVegO6/oot3/iQzt/hPTFlz4hw+tBWtZ
         h6bStZ/iJzLPGX8RTFCePBHVRq4eXRRQFc+NqWlorMVRctLyikj3iC41Lx+JQHb1y3dj
         VoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967534; x=1766572334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqN6koPFcrVj4IRl7yzs9GDyC0SN7MeceAgCjTYlFyg=;
        b=hXeq9hAkF5tTRo+SE+wmPrDXm/aEhOPxZvyA+OCaYiM3Ke+DA6COrNJGkzjaniXfju
         vROTzAhw64NEo64smwcu/ktFHpdwbtlgqkwDohUx32frCpJAnHdh13/LjhxPslYGper9
         bwFoFP0O7gvRGvRQ1MjpK3DWYRGh/4B/HgZ6W8sZZHJtcrgvCGQT32ypTlN2U04wTZMw
         LFDaz/ELGtvo+sjdB2UfGLrcpehy5KGNkZP+MSz3gQ5qhVICoIMA1pyus2xO63OIVvMM
         hzhZdqp/Hvb7+KKgvUnX5th27TWC4vi4Txf6IJfLwHXvpS/ef0QLlbbfusItTjE1AuGu
         ha+A==
X-Forwarded-Encrypted: i=1; AJvYcCV1C8E6dLQsaJS19CymEWkykITZ63+WkTTtHRvH5UJ3clApGmpf7e1xptdfvAJZyQEb6X9jEbBk@lists.cip-project.org
X-Gm-Message-State: AOJu0YybNSydGQKPPiFBiWM8nbiVSudXgSC+DBJyuk+dW7GBoF4B+IuR
	0zkrzhIx7tHfpWjs48MaVb6NGjwnpg9flIc0TZMGhix2b3Q9AlXYH6EDeLe/Kid634lSBpxiwmr
	ODbs4
X-Gm-Gg: AY/fxX4mfdNeJ4S2HPmxvYdoLEg6RQQOM7EoOdYT631Ywia4duAfTc1WGitw0WghxPa
	kV5QB8G05sa5X/yqlxatOcg6l0lAWziMUsshXdu/bHmxco/xhm/Grt/UctPeKN8S32I6XRbKXly
	qm7mDAyqcwbfjw+L+CvmJXwXYRvWMbC1UkJlMD0Y3HnWB34OGHu4/3UIDmPy9z/jNax4CDHsn8/
	ER3iOeGREt8uw1di7WSavdpVHRyrspX244TJQ3BTcurdI7zj8s+4/8VEZk686Z574ZNv9SlJiuQ
	+PXuQYUC35Gpy9pgE2l4SHhGz2pMyO8PbPEWoV1BjxMqJK87BEDkDAiywyS4963EVtX4oSoz8dP
	eouy4X6pIBTxoL5bJr/MMLkj47abqM8DVGlvVhaKD9A0gMy03k00JSGyVPxw6u10me9SM8lvsS1
	M+6JnKVk0FyMFLAwFWyv2s0fbdIt4Q3qt6FKpg/+Wb
X-Google-Smtp-Source: AGHT+IE6M1CfdKlNjQ2poQX/mNNlGtEyZMKjhMq9/5yAm4lgBc+ljGdYYF49nArwzpr0ShlhI946OQ==
X-Received: by 2002:a17:907:6e8f:b0:b77:1a33:1669 with SMTP id a640c23a62f3a-b7d23a954b7mr1887482666b.57.1765967533575;
        Wed, 17 Dec 2025 02:32:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 1/7] clk: renesas: r8a08g045: Check the source of the CPU PLL settings
Date: Wed, 17 Dec 2025 12:32:04 +0200
Message-ID: <20251217103210.4183025-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21106

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dc0f16c1b76293ac942a783e960abfd19e95fdf5 upstream.

On the RZ/G3S SoC, the CPU PLL settings can be set and retrieved through
the CPG_PLL1_CLK1 and CPG_PLL1_CLK2 registers.  However, these settings
are applied only when CPG_PLL1_SETTING.SEL_PLL1 is set to 0.
Otherwise, the CPU PLL operates at the default frequency of 1.1 GHz.
Hence add support to the PLL driver for returning the 1.1 GHz frequency
when the CPU PLL is configured with the default frequency.

Fixes: 01eabef547e6 ("clk: renesas: rzg2l: Add support for RZ/G3S PLL")
Fixes: de60a3ebe410 ("clk: renesas: Add minimal boot support for RZ/G3S SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115142059.1833063-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c |  5 +++--
 drivers/clk/renesas/rzg2l-cpg.c     | 13 ++++++++++++-
 drivers/clk/renesas/rzg2l-cpg.h     | 10 +++++++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 89d6f361a5d3..eddf6cad8d35 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -50,7 +50,7 @@
 #define G3S_SEL_SDHI2		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 8, 2)
 
 /* PLL 1/4/6 configuration registers macro. */
-#define G3S_PLL146_CONF(clk1, clk2)	((clk1) << 22 | (clk2) << 12)
+#define G3S_PLL146_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
 
 #define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
@@ -133,7 +133,8 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 
 	/* Internal Core Clocks */
 	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
-	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8)),
+	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8, 0x100),
+		    1100000000UL),
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll4", CLK_PLL4, CLK_EXTAL, 100, 3),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0d7e0fa73fff..0f7f876b352a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -53,6 +53,7 @@
 #define RZG3S_DIV_M		GENMASK(25, 22)
 #define RZG3S_DIV_NI		GENMASK(21, 13)
 #define RZG3S_DIV_NF		GENMASK(12, 1)
+#define RZG3S_SEL_PLL		BIT(0)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
@@ -62,6 +63,7 @@
 #define GET_REG_OFFSET(val)		((val >> 20) & 0xfff)
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
+#define GET_REG_SAMPLL_SETTING(val)	((val) & 0xfff)
 
 #define CPG_WEN_BIT		BIT(16)
 
@@ -954,6 +956,7 @@ rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
 
 struct pll_clk {
 	struct clk_hw hw;
+	unsigned long default_rate;
 	unsigned int conf;
 	unsigned int type;
 	void __iomem *base;
@@ -991,12 +994,19 @@ static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
-	u32 nir, nfr, mr, pr, val;
+	u32 nir, nfr, mr, pr, val, setting;
 	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_G3S_PLL)
 		return parent_rate;
 
+	setting = GET_REG_SAMPLL_SETTING(pll_clk->conf);
+	if (setting) {
+		val = readl(priv->base + setting);
+		if (val & RZG3S_SEL_PLL)
+			return pll_clk->default_rate;
+	}
+
 	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 
 	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
@@ -1050,6 +1060,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	pll_clk->base = base;
 	pll_clk->priv = priv;
 	pll_clk->type = core->type;
+	pll_clk->default_rate = core->default_rate;
 
 	return clk_register(NULL, &pll_clk->hw);
 }
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index d9be4317e587..118610936194 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -92,7 +92,10 @@ struct cpg_core_clk {
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
 	const unsigned long invalid_rate;
-	const unsigned long max_rate;
+	union {
+		const unsigned long max_rate;
+		const unsigned long default_rate;
+	};
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -134,8 +137,9 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
-#define DEF_G3S_PLL(_name, _id, _parent, _conf) \
-	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3S_PLL(_name, _id, _parent, _conf, _default_rate) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf, \
+		 .default_rate = _default_rate)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
-- 
2.43.0


