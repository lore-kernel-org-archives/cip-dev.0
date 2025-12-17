Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D306D65531
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:05 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11751.1765967521002687529
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=X02ut4ZP;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b76b5afdf04so928375366b.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967519; x=1766572319; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkdoi9FMnjnBpnOBLzlQNKh6is6zrHt3Vd0jWbGGhdI=;
        b=X02ut4ZPg0XgXChy8bxv2G65iyqCw51tEceoBdilrfqs8sUUY5M/7DD6JKEL6Wqu79
         qjK+lBMD1krtY46+qBn4PpZsB2P2qHyQDJzsXNFieg9UlLz4U7m0/v6hDTsPjJ3nBCp3
         OZV0/PD2giv6MxVwNhqmhhyZJ2j65AMFIciFnUQ9Bi/hF7hJ96y5WFwkhVf3Gpi04aiG
         ma3iOP7hyTRosuFe8ucu4+wygIO3VYWgJmKS/jTnM53m3uhQ8rqpPZpQFGHqItODLkEs
         CJeB4s5Os3pvfht/NZzWJ7uJnPgsiru9dk6JDFzYWbn74ThHEX8Ujj/R2lkstfTJozdp
         a7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967519; x=1766572319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkdoi9FMnjnBpnOBLzlQNKh6is6zrHt3Vd0jWbGGhdI=;
        b=TaHFg+ai4JWAZRNUUJ2JXBs/6Uz1OlOwwgHFdl/U/LCW2iFv5MMtjnlOkhQuma9Xnc
         6jFQxfArZDy5S9TQEeTjoVui/eM2RpWCrTfUJpms54ThrUFAzn9nS/cyDSwxfeCDdt6l
         l+XPwLVU8IBmwhgyK0iTCujcB2kXDnWSvjQjhRhTkbIBYekkBfgVoXu4ieU1wdwoSO/D
         C7W/DmYiyOMx57N+OCKafMvURZYNHuQsS/G2rFeX1Vww9GopLc/lBK5J1eS6SN6MZskG
         fzuV45sAk/HlQWnhZqJkY6YnSuXdK4NAWd32UXcD6ahZZeB17UhW/uyEZuVTPCsw10vy
         bseQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcn3TeBcgigyQg0fePjNj2A8mZsKpOytnYM6wQvywOxPTBPlyM1YGT59XSCqTE7d4PqWcbaOZA@lists.cip-project.org
X-Gm-Message-State: AOJu0YzHR3Ymi259WsFCmFa7iy298v+Z/lwb+Ec9L4J/LgYNbDouRJYa
	Ups5t1n9rPD4otd+wIntsGAFR9nHCt5bH3KhiT1fXsTIgb3meKS1uD5E6Pxpk87z83U=
X-Gm-Gg: AY/fxX5l1N5EPvJOspBKA66J+vKD+n0vdFBckTN+dEKK6nKJTyiNmygw2cnvtURtgUY
	E1PRyvutc3Y0JhQ+HvnJ8409lZBuPS3IGNSp+dMDUHjyeNV4+RKH9Ex559CX2+6OmJs/Fa+3jLT
	KytkEFfc/Z8kw1l8u1xyUF67vFZhgt0TuEVz/kVarGGjv5MwjB05+5l7mE7PkYt5/OuHDFlEvkf
	20BfPiihBgjZ7YvorkjgjziHIJn4/+TnoklDwZKspUKrujyOgSMtRVImVQW09LmIQjG9hAawVk2
	64pjwdhszLzA7FdXur/GYTi/f2Wc+FfSU6wLZ0gT64aguCCzs68wyD5/HboesZHIl36wwFSpiOi
	cwyxwIsJGCvkr4U2aPnYTjSAElJTKrmDIX908/BN/WXjSuqvAMrtwahgGboOn/OP/xzMHaV0Ut2
	rlEq8EcN3EPMmtwgjEJKfiMNnkWaexYtFD8SCV/wzJ
X-Google-Smtp-Source: AGHT+IHT5BcrpYvZ1P5cFlXStjHOZcANFSfrnbG/vsQ11b7HC7qP+2ktoM5qwwqNfJXB+zBJYNO8Gg==
X-Received: by 2002:a17:906:ef09:b0:b73:853d:540e with SMTP id a640c23a62f3a-b7d238ba915mr1824067566b.30.1765967511813;
        Wed, 17 Dec 2025 02:31:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:31:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/7] clk: renesas: r8a08g045: Check the source of the CPU PLL settings
Date: Wed, 17 Dec 2025 12:31:42 +0200
Message-ID: <20251217103149.4182935-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21098

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
index 379292eb6fb1..bd1b121fb84a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -52,6 +52,7 @@
 #define RZG3S_DIV_M		GENMASK(25, 22)
 #define RZG3S_DIV_NI		GENMASK(21, 13)
 #define RZG3S_DIV_NF		GENMASK(12, 1)
+#define RZG3S_SEL_PLL		BIT(0)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
@@ -61,6 +62,7 @@
 #define GET_REG_OFFSET(val)		((val >> 20) & 0xfff)
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
+#define GET_REG_SAMPLL_SETTING(val)	((val) & 0xfff)
 
 #define CPG_WEN_BIT		BIT(16)
 
@@ -953,6 +955,7 @@ rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
 
 struct pll_clk {
 	struct clk_hw hw;
+	unsigned long default_rate;
 	unsigned int conf;
 	unsigned int type;
 	void __iomem *base;
@@ -990,12 +993,19 @@ static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
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
@@ -1049,6 +1059,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
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


