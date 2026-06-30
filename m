Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A2C43327
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19078.1782820135429811272
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ouk6N8dD;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b77b150aso9577915e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820133; x=1783424933; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCZpaOAqH7IgkKsZUin+uQluU7RGxeUcXjNvhIbegNo=;
        b=Ouk6N8dDDd0Sg9g6GanDabm9bkW8n1wGuadESGG/rT1KM0jCwbz0y1KWI3G2ob8k4U
         dFYeHeMdnP1i6Kd8aE6CnNwOW5nL3oZEx3JuQzygtGvDvf663OTD6To7uyeSZXimExCj
         sRdM85lHcfEMiL2o38STb/wLmGDdhUghDpmhQ+d9jzTC5PUG61zTpTEoesCL1ds8YOS0
         K8+JRtP8Z3/kv8zSVt3ue0mzws3YksfRLWjnKzw5QaD8wxPs77uHHl+ryOA9mC8c7hIw
         pgWCdLCm2IpMXyaI4hXB+f4EOJqcBFln4kH8BvGe1D2rNMHqcmpHreP43YWC1Z3yVuyl
         qiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820133; x=1783424933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCZpaOAqH7IgkKsZUin+uQluU7RGxeUcXjNvhIbegNo=;
        b=TZ0AOyXZlWYv9Em+mpTe8oPh0SSQmAnkZNpmrlydK+IHzqkAAb3Us/fm3TC+Cc58O/
         eUHX7lksc4XnLqDAUCbUPKu1YxTEa84pIcwIrY/EO1a4EfexDimJIH9SrGD0aMNcK30X
         cXs8E6TmdLej5o7XdK9FxABJsSR3yWVoNnXb8F6PCkN8bb6OV02FiLFo/FKEzBH522Av
         UuXVdhu10wpdxd5RFkhRtPsYHVIgilisJ317RqpnwJaeFa+UuubJZttej38vCfKBiIU4
         /eCN0kXQygJg9VUIYaTEJ8lcwHUrV7j+A9f8EfLcHCNNLI29ZVRuKVuQEymsHa3qX4nz
         twzQ==
X-Gm-Message-State: AOJu0YxL4xRBI1Y0tpzNu8bKP71PA2w10SeDsxcek+1I5MHDK905Unvf
	RkUOVK77WbFbAyOVWVg6IhNFcoXURMV7NQRUghJtLSs+wtwqPqK6LNLZdxevacyw
X-Gm-Gg: AfdE7cmxrt+0lDSmGJC9OAMncjxyBLke6SgQTXDK5p1u1aA9CuLNIkFSOcNJSqLVP5D
	IsZ58MR/0ptztEvHJ9XGTe4roaIDjjCxgfbGl/CNMTwsOJ9O90ovy9YG+6Rxld2dGqIBHoIUDu2
	zu5ZsatQjza31ahYqpEI9PV7olNawqg/bFF+JtCE35BnmxogjUlB/scFiPthmP7JIZGyk6T1m2I
	5Q4A//xbNnu20O9XKCormtOn0tdjncDEsQjzcPuwss30ve3rtB4RQinPDeCe+b3cff55mIcCZHv
	WtNuI97eEZP5n+PrS0TC60/7bZjs0F8fAQVuEkA5qL+KMTmjinvpoKC5LMYxCS5R0wAeKD/zKct
	VN1aKAnNyp3T+gv392Ipi/OHplB49LfDv2CyE7WHR6IVlyIbv33/kcsuWpWeZFq+xLiulWP/oPh
	pr45TiawoysbI4V0Gqe/Ul3cbwf1A6zG+ZeaGBbA==
X-Received: by 2002:a05:600c:c3cb:20b0:493:ba40:ef39 with SMTP id 5b1f17b1804b1-493ba40f0cemr26497435e9.15.1782820133531;
        Tue, 30 Jun 2026 04:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/39] clk: renesas: rzg2l: Add support for enabling PLLs
Date: Tue, 30 Jun 2026 12:47:41 +0100
Message-ID: <20260630114813.92739-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23346

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 78db1faa6b681da20ec167268b28778ebb0f98b7 ]

Add support for enabling PLL clocks in the RZ/G3L CPG driver to turn off
some PLLs, if they are not in use (e.g. PLL6, PLL7).

Introduce .is_enabled() and .enable() callbacks to handle PLL state
transitions.  With the .enable() callback, the PLL will be turned ON
only when the PLL consumer device is enabled; otherwise, it will remain
off.  Define new macros for PLL standby and monitor registers to
facilitate this process.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326110648.29389-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 67 +++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index ac49eb8b4a30..92b36c856f36 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -58,6 +58,13 @@
 #define RZG3S_DIV_NF		GENMASK(12, 1)
 #define RZG3S_SEL_PLL		BIT(0)
 
+#define RZG3L_PLL_STBY_OFFSET(x)	(GET_REG_SAMPLL_CLK1(x) - 0x4)
+#define RZG3L_PLL_STBY_RESETB		BIT(0)
+#define RZG3L_PLL_STBY_RESETB_WEN	BIT(16)
+#define RZG3L_PLL_MON_OFFSET(x)		(GET_REG_SAMPLL_CLK1(x) + 0x8)
+#define RZG3L_PLL_MON_RESETB		BIT(0)
+#define RZG3L_PLL_MON_LOCK		BIT(4)
+
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
 #define CLK_RST_R(reg)		(reg)
@@ -1176,6 +1183,63 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	return pll_clk->hw.clk;
 }
 
+static int rzg3l_cpg_pll_clk_is_enabled(struct clk_hw *hw)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzg2l_cpg_priv *priv = pll_clk->priv;
+	u32 val = readl(priv->base + RZG3L_PLL_MON_OFFSET(pll_clk->conf));
+	u32 mon_val = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
+
+	/* Ensure both RESETB and LOCK bits are set */
+	return (mon_val == (val & mon_val));
+}
+
+static int rzg3l_cpg_pll_clk_endisable(struct clk_hw *hw, bool enable)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzg2l_cpg_priv *priv = pll_clk->priv;
+	u32 stby_offset, mon_offset;
+	u32 val, mon_val;
+	int ret;
+
+	stby_offset = RZG3L_PLL_STBY_OFFSET(pll_clk->conf);
+	mon_offset = RZG3L_PLL_MON_OFFSET(pll_clk->conf);
+
+	if (enable) {
+		val = RZG3L_PLL_STBY_RESETB_WEN | RZG3L_PLL_STBY_RESETB;
+		mon_val = RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK;
+	} else {
+		val = RZG3L_PLL_STBY_RESETB_WEN;
+		mon_val = 0;
+	}
+
+	writel(val, priv->base + stby_offset);
+
+	/* ensure PLL is in normal/standby mode */
+	ret = readl_poll_timeout_atomic(priv->base + mon_offset, val, mon_val ==
+					(val & (RZG3L_PLL_MON_RESETB | RZG3L_PLL_MON_LOCK)),
+					10, 100);
+	if (ret)
+		dev_err(priv->dev, "Failed to %s PLL 0x%x/%pC\n", enable ?
+			"enable" : "disable", stby_offset, hw->clk);
+
+	return ret;
+}
+
+static int rzg3l_cpg_pll_clk_enable(struct clk_hw *hw)
+{
+	if (rzg3l_cpg_pll_clk_is_enabled(hw))
+		return 0;
+
+	return rzg3l_cpg_pll_clk_endisable(hw, true);
+}
+
+static const struct clk_ops rzg3l_cpg_pll_ops = {
+	.is_enabled = rzg3l_cpg_pll_clk_is_enabled,
+	.enable = rzg3l_cpg_pll_clk_enable,
+	.recalc_rate = rzg3s_cpg_pll_clk_recalc_rate,
+};
+
 static struct clk
 *rzg2l_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
 			       void *data)
@@ -1259,6 +1323,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 	case CLK_TYPE_SAM_PLL:
 		clk = rzg2l_cpg_pll_clk_register(core, priv, &rzg2l_cpg_pll_ops);
 		break;
+	case CLK_TYPE_G3L_PLL:
+		clk = rzg2l_cpg_pll_clk_register(core, priv, &rzg3l_cpg_pll_ops);
+		break;
 	case CLK_TYPE_G3S_PLL:
 		clk = rzg2l_cpg_pll_clk_register(core, priv, &rzg3s_cpg_pll_ops);
 		break;
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 10baf9e71a6e..ebd612d117c0 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -123,6 +123,7 @@ enum clk_types {
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_SAM_PLL,
+	CLK_TYPE_G3L_PLL,
 	CLK_TYPE_G3S_PLL,
 
 	/* Clock with divider */
@@ -152,6 +153,9 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3L_PLL(_name, _id, _parent, _conf, _default_rate) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3L_PLL, .parent = _parent, .conf = _conf, \
+		 .default_rate = _default_rate)
 #define DEF_G3S_PLL(_name, _id, _parent, _conf, _default_rate) \
 	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf, \
 		 .default_rate = _default_rate)
-- 
2.43.0


