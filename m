Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F332C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:10 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.18437.1713526740236951108
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fgJVLy+q;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so2240474a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526738; x=1714131538; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crWfIaVyz2slnAzlQast5vbjAXs1OwXJA6IeTLjBbc0=;
        b=fgJVLy+qwC6BfnzcleUHMeo57s1BSoJ4BtrZnbG8K3mGJ7VOZ/n+moTRYjl7+B4u09
         30/EWIeqDVfhsg4AnI3HnxnYY/vIc9fl67FX01vFSBcTMGZERYxer3qdYO5DkYmQ3pO+
         Fd4R9vRbO9P8NoBBOr/H0bRLpBBfsbppWPLWyVoc5N8JIPz3LaF9xOzxIJ7PeslpkhJ/
         AT7BDJf/RqKh7haMNhT56tBMz8l7I/l27gvImmXIB+1NyBVVk4mBhNBgQlOjsUFLKj8+
         nx723C/oKXJ8luQlOcM2o/TZh8qPAc+bZiuxEeaCc93EeahZZLsemrD4LG8lJtWzMjIc
         vd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526738; x=1714131538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crWfIaVyz2slnAzlQast5vbjAXs1OwXJA6IeTLjBbc0=;
        b=XPW7GtXCQrM20K1k46KfMcPBIZ9udwKFDrZPOWjI0Hb+oH6Bwl5woKfdm0v1qpCTiC
         LuB1KT+eURQd0g4z5lLHdz8FLRulOSRaWHIc444ySmT3QJf+r9z+hTAu/3SBFlQ8lO8/
         WVGiJVj/knwjOUbrNJICQGJTCMwGP/CEvHmxbauaA+xoqHhUOLop/y6sgaRU5IQanzMa
         +HKUp6VWGt53bdDS9DOJGDxvXreGRNOIOouIkrbgh7SPQ0v1fL+P5Jl5L3noH1on7MAP
         Er2SoPCvph6w53zZd5mPwGGeCit8+0PD3TP5ImRJMJKd87lGOTJtMa9e/2xEcPKwrsYK
         YUNQ==
X-Gm-Message-State: AOJu0YyDetBXb/YCqPR6DOeukXa5h97sVSsytMlkb7Gy3B+q3eOjPZTy
	DZOaG3/iLKMP1aok6v2UTd4Hk6r4enF/g/o0nMFQIqzx0QjwjJqoW3/Fq7cN+tU=
X-Google-Smtp-Source: AGHT+IE+3diB5yx1//5wlymALd/Qls6ZLx8YhpbZyYg70ft8odHHOf4s4lGo3Va6t1r392jzb71+vA==
X-Received: by 2002:a50:999c:0:b0:570:2418:3607 with SMTP id m28-20020a50999c000000b0057024183607mr1820082edb.36.1713526738637;
        Fri, 19 Apr 2024 04:38:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 10/44] clk: renesas: rzg2l: Add support for RZ/G3S PLL
Date: Fri, 19 Apr 2024 14:38:08 +0300
Message-Id: <20240419113842.3675543-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15661

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


