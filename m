Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCCC05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:17 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.15300.1713514692438391827
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eCivuULx;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.181, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db17e8767cso25094471fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514690; x=1714119490; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crWfIaVyz2slnAzlQast5vbjAXs1OwXJA6IeTLjBbc0=;
        b=eCivuULxkfui42TMfW0w/NYH6d9VBvbn8oP0h2hZU2o98G7+94Rqpoio7p0dZFumd7
         Z62nf3Czasng34eBOlEuLO2ikjNdyUID6L59+Xn0EprhwCb4khhR5/XXJnSZ5xk6y9fc
         qYXR5ufX1hjH9ax4Uc6VrUrZXHm4+9p/ugWoeEGdeRGRZ0tA3xbbMvH/Nn3HWnOOW5BI
         34P0wFabJPrq8M5+q/5Dg4dyEXyDJLEx0Qqi2kA3pdkbLItfyM8QDH2MbyHWf2DeA4D+
         OMNATMaxJ9kD4zmAmr6AhT5KMafKmnbG7cL7/T5bNpPf8dJVNDPLvYwDUvH2L3T2a4+g
         IHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514690; x=1714119490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crWfIaVyz2slnAzlQast5vbjAXs1OwXJA6IeTLjBbc0=;
        b=iAxCUT5GdcIrDty6MzF5zZZ8gbuFxh+utB6yMKntnDCPGZOc5jCbGV+xNaR8a13JA8
         VuL7zLIXUeiXdcA4oIedYjlWDtA45JbXXZhFVJ/qta7jB56h4+PBwHktrAxmJhEjy6Lz
         VOdAm/2gA1wHGhV+EwqsQKiuXWZjZrRNjP7Ef+kvOXepDp3Gs3VBXwtWD3jd7z7iKkZi
         puG6qI8t/8RioL6BQ6js70vlgXAj01Nc8WC2fZ4yR2HVV4R+4rBI50s/V2r9AMmfaMdt
         aLuXTs8Xx6qWIeJSTQtu1wgsiEyWnDElNRJVdmarTPYkhVnUorcMLt4r0sFspeJ7a1a8
         uBCw==
X-Gm-Message-State: AOJu0Yw6uQ/u2OGor4jEd7JYF8aEWT9svYLfi0x90SzMPpjW+Wz+mfWY
	YXFXJiQYxkfnCxw94acjaXasHbLT/j6iIZtg5ZIXnwBKUz+lBa0JUytenkfNnj51mv3C8HU0itA
	C
X-Google-Smtp-Source: AGHT+IHs6zSCSyHnnA4dGZWTvnaDLuL2J0K4lyVw3fNZt5EW3gV6VBkhYNtxOOlcCOtXPwmhkvYFnQ==
X-Received: by 2002:a19:5e11:0:b0:519:7b00:d371 with SMTP id s17-20020a195e11000000b005197b00d371mr805421lfb.7.1713514690633;
        Fri, 19 Apr 2024 01:18:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 17/53] clk: renesas: rzg2l: Add support for RZ/G3S PLL
Date: Fri, 19 Apr 2024 11:17:06 +0300
Message-Id: <20240419081742.3496709-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15604

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 01eabef547e63d80086acd3f247d36c5f9f92456 upstream.

Add support for reading the frequency of PLL1/4/6 as available on
RZ/G3S.  The computation formula for the PLL frequency is as follows:

    Fout = (nir + nfr / 4096) * Fin / (mr * pr)

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-8-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 49 ++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h |  3 ++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index b280a468c4a8..1a928828baac 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -48,6 +48,11 @@
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
+#define RZG3S_DIV_P		GENMASK(28, 26)
+#define RZG3S_DIV_M		GENMASK(25, 22)
+#define RZG3S_DIV_NI		GENMASK(21, 13)
+#define RZG3S_DIV_NF		GENMASK(12, 1)
+
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
 #define CLK_RST_R(reg)		(reg)
@@ -714,11 +719,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops = {
 	.recalc_rate = rzg2l_cpg_pll_clk_recalc_rate,
 };
 
+static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzg2l_cpg_priv *priv = pll_clk->priv;
+	u32 nir, nfr, mr, pr, val;
+	u64 rate;
+
+	if (pll_clk->type != CLK_TYPE_G3S_PLL)
+		return parent_rate;
+
+	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
+
+	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
+	/* Hardware interprets values higher than 8 as p = 16. */
+	if (pr > 8)
+		pr = 16;
+
+	mr  = FIELD_GET(RZG3S_DIV_M, val) + 1;
+	nir = FIELD_GET(RZG3S_DIV_NI, val) + 1;
+	nfr = FIELD_GET(RZG3S_DIV_NF, val);
+
+	rate = mul_u64_u32_shr(parent_rate, 4096 * nir + nfr, 12);
+
+	return DIV_ROUND_CLOSEST_ULL(rate, (mr * pr));
+}
+
+static const struct clk_ops rzg3s_cpg_pll_ops = {
+	.recalc_rate = rzg3s_cpg_pll_clk_recalc_rate,
+};
+
 static struct clk * __init
 rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
 			   void __iomem *base,
-			   struct rzg2l_cpg_priv *priv)
+			   struct rzg2l_cpg_priv *priv,
+			   const struct clk_ops *ops)
 {
 	struct device *dev = priv->dev;
 	const struct clk *parent;
@@ -736,7 +773,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 
 	parent_name = __clk_get_name(parent);
 	init.name = core->name;
-	init.ops = &rzg2l_cpg_pll_ops;
+	init.ops = ops;
 	init.flags = 0;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -831,8 +868,12 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 						core->mult, div);
 		break;
 	case CLK_TYPE_SAM_PLL:
-		clk = rzg2l_cpg_pll_clk_register(core, priv->clks,
-						 priv->base, priv);
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg2l_cpg_pll_ops);
+		break;
+	case CLK_TYPE_G3S_PLL:
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg3s_cpg_pll_ops);
 		break;
 	case CLK_TYPE_SIPLL5:
 		clk = rzg2l_cpg_sipll5_register(core, priv->clks, priv);
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 097fd8f61680..20da0c620b90 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -102,6 +102,7 @@ enum clk_types {
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_SAM_PLL,
+	CLK_TYPE_G3S_PLL,
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
@@ -129,6 +130,8 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3S_PLL(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
-- 
2.39.2


