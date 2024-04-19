Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4141C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.15290.1713514681672847244
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lvoReHVh;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso228898e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514680; x=1714119480; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LfpRKe3/TAeWMaDuaWyTBgLyfTaQW/LF/lmg///XDU=;
        b=lvoReHVh7dBtZheXf1cqhOIxw8BYkiu8W3ftx21bowt1nHG18pvdxPCs18JSdocXRn
         3q/QVvLKmehGxPYeAABmrp6TAADbWCrUdQghrJeO0n6Ag38WmeEas1i1n/XewMdWeZWo
         9rS8qtXL1Wht5PRf6ZA9u80jF4U97+J8p/T4vpoL6ootKpdtpLjzSOPjbtJse1Z0ycgW
         efeMPmIp1BBkqzyRta/LlasiiGLSLovV2IbeS2ne2jwp2TOEK+5Q0A7a7HHHhiLwxZj3
         Vsw4a/lZYCiPKuEewDXzUbZ2xb6cJ8IFQc6otYcoooikvukvd20Ir568mMP9CWcR9Fj5
         JkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514680; x=1714119480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LfpRKe3/TAeWMaDuaWyTBgLyfTaQW/LF/lmg///XDU=;
        b=gVWQy6VSG9szXuOl+15wRQT/SNIbTCyP7dLPpeX8grnBW/sA7KxRmQbLs3He64NVqE
         V1LM7sBrzCVntLE8n5qEm8GflSX73P1mFrE05kT9rNlj47DgrekvVwLYDT6Zdky22fcM
         yoVlOODDzp89/R5/3gZIianN3Vri07lNbj6TKhNl+M4NnHDnWuG84MAXlSbA+vcU4b+z
         Q3ncvEJRbmsWkh857dfCZtcYtBZF/2Xpev2DT3Hlr/nAqS8+tTF2aDrC8JNrhY5Vo10x
         3kQQwDDY36Ik4d80y/lmjjmG24KvEYUNatPQpiQI/sO5tmF3KJZhTuLfq3e1QRzVYoAo
         mEqA==
X-Gm-Message-State: AOJu0Yx+qbS3T66Wn+Gq2+1CZo1drLvdELBc3asr7PdPOop2MBONUG5D
	FQWH6+U07TQbfhvde+UQG2VWrG3bFB7Pzlmv5gWJknVfvT/FvUx5xFk08rxaplvy8/ZvrE82k4b
	R
X-Google-Smtp-Source: AGHT+IFzny8u4UYsJ3kij3ga5jF2HkhxklgG0USjEOXl3qsPhTmNXeDL27tGKDp8I1CGvPvjem6rsQ==
X-Received: by 2002:a05:6512:49c:b0:515:d038:5548 with SMTP id v28-20020a056512049c00b00515d0385548mr923243lfq.31.1713514679752;
        Fri, 19 Apr 2024 01:17:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 10/53] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
Date: Fri, 19 Apr 2024 11:16:59 +0300
Message-Id: <20240419081742.3496709-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15597

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3702cff6d9385565b1ea2670a5623f9695412019 upstream.

There are cases where not all CPG_MOD clocks should be assumed to support
PM. For example on the CRU block there is a particular sequence that needs
to be followed to initialize the CSI-2 D-PHY in which individual clocks
need to be turned ON/OFF, due to which Runtime PM support wasn't used by
the CRU CSI-2 driver.

This patch adds support to allow indicating if PM is not supported by the
CPG_MOD clocks. Two new members no_pm_mod_clks and num_no_pm_mod_clks are
added to struct rzg2l_cpg_info so that MOD clocks which do not support PM
can be passed by no_pm_mod_clks[] array and when the driver uses Runtime
PM support the clk ID is matched against the no_pm_mod_clks[] array to see
if the clk is needed to be included as part of Runtime PM.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20221026014227.162121-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict in the documentation of struct
 rzg2l_cpg_priv]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 41 ++++++++++++++++++++-------------
 drivers/clk/renesas/rzg2l-cpg.h |  4 ++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 491fb64b1a3c..2262c70fb383 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -95,7 +95,8 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
- * @pll5_mux_dsi_div_params: pll5 mux and dsi div parameters
+ * @genpd: PM domain
+ * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
 	struct reset_controller_dev rcdev;
@@ -111,6 +112,8 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
+	struct generic_pm_domain genpd;
+
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1242,22 +1245,31 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
-static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
+static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
+				const struct of_phandle_args *clkspec)
 {
+	const struct rzg2l_cpg_info *info = priv->info;
+	unsigned int id;
+	unsigned int i;
+
 	if (clkspec->args_count != 2)
 		return false;
 
-	switch (clkspec->args[0]) {
-	case CPG_MOD:
-		return true;
-
-	default:
+	if (clkspec->args[0] != CPG_MOD)
 		return false;
+
+	id = clkspec->args[1] + info->num_total_core_clks;
+	for (i = 0; i < info->num_no_pm_mod_clks; i++) {
+		if (info->no_pm_mod_clks[i] == id)
+			return false;
 	}
+
+	return true;
 }
 
-static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)
+static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 {
+	struct rzg2l_cpg_priv *priv = container_of(domain, struct rzg2l_cpg_priv, genpd);
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once = true;
@@ -1267,7 +1279,7 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device
 
 	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
 					   &clkspec)) {
-		if (rzg2l_cpg_is_pm_clk(&clkspec)) {
+		if (rzg2l_cpg_is_pm_clk(priv, &clkspec)) {
 			if (once) {
 				once = false;
 				error = pm_clk_create(dev);
@@ -1317,16 +1329,13 @@ static void rzg2l_cpg_genpd_remove(void *data)
 	pm_genpd_remove(data);
 }
 
-static int __init rzg2l_cpg_add_clk_domain(struct device *dev)
+static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 {
+	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct generic_pm_domain *genpd;
+	struct generic_pm_domain *genpd = &priv->genpd;
 	int ret;
 
-	genpd = devm_kzalloc(dev, sizeof(*genpd), GFP_KERNEL);
-	if (!genpd)
-		return -ENOMEM;
-
 	genpd->name = np->name;
 	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
 		       GENPD_FLAG_ACTIVE_WAKEUP;
@@ -1396,7 +1405,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = rzg2l_cpg_add_clk_domain(dev);
+	error = rzg2l_cpg_add_clk_domain(priv);
 	if (error)
 		return error;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index aefa53a90059..91e9c2569f80 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -253,6 +253,10 @@ struct rzg2l_cpg_info {
 	unsigned int num_mod_clks;
 	unsigned int num_hw_mod_clks;
 
+	/* No PM Module Clocks */
+	const unsigned int *no_pm_mod_clks;
+	unsigned int num_no_pm_mod_clks;
+
 	/* Resets */
 	const struct rzg2l_reset *resets;
 	unsigned int num_resets;
-- 
2.39.2


