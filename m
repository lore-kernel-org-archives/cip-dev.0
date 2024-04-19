Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E88C07E8D
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.18431.1713526730983952397
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hyrl+sOX;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571c25a329eso2108628a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526729; x=1714131529; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+12yoewu+EuhV/PhSYYrajBBFZiS0E/KqhorbqwRyk=;
        b=hyrl+sOX5+QnYQqoghQHtM4adxr1W1lq6RO5lz3S58Gtkp+3acgi+jMftf4Mu0+i55
         5iQE9gxc5oV+bM2RG5W/yY2zjcbDtvfDJoRx9ehOb/K/AtAijeEkD4lKc/r0rXSCPEPR
         UOYGxgJR9zi8RVrHuDR0mA38zsmUmenTd06uiUb0nwglihc1It21KBA2PEdMhMp34YTG
         vr+5FBRtM5YgCqQIt8qVOfjahdxBBEKQKOJlTFBhnY/2hBL5Ed99pPtF1YDwTRsrMgdo
         2Hw+jF2DcGcMqYSI0SEPYuDZBN9Xnt8CzwCnl1rYIgz45SnbDR+Coqm2EuKFQF24IYCW
         RHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526729; x=1714131529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+12yoewu+EuhV/PhSYYrajBBFZiS0E/KqhorbqwRyk=;
        b=gl2T3SrRVybDaMfILHDdeNaPCy67LyR7mhlBIehjJ3y39sl99Pd3SSLpTNA4LqnFxq
         J+VZNc+RwammNNqbR4x3BJHLfVeR6qYIJyIEkqe5MdrfnZsGO7Fs0tlgtqjmr43OuBoc
         fIP9V0oYGo5tfEgb8Vky0fLzSTNhaVaLalrvRcZXQH13e4vQQ266IuUu7+HeyZtrgR7P
         s1qZBmHOkxeMdzNJuWo5j4eZseYu2YUySy+cwIGVsHi8ZYqBvF+oKn7D1ZN1ESxm6npI
         L28GhQuwloDGsBGBQgtX9EGiyFG7XqVJ3gbVpiiAzWByH9uZmiCJq2833jFDGxq6BDn/
         /eRA==
X-Gm-Message-State: AOJu0Yw5Dw0YiQJvTjDJxK16eUlDPIXVoa+16QfEq5awe89LR8I8lOC9
	IXQYQal7iemPF7sJJMgv0cIL0WR/1vZ5vAIEJCqLfAJ+4PNLzJYYj+6MAbocKVc=
X-Google-Smtp-Source: AGHT+IFg6bc4lsJvzvvZCm9E1Ks3AKZmrwtVS6uyf+EfrhJUzeQWgLvZ9OT/JPnX14JbuS/HX5Bmlg==
X-Received: by 2002:a05:6402:13d2:b0:571:b82b:4831 with SMTP id a18-20020a05640213d200b00571b82b4831mr5911958edx.7.1713526729217;
        Fri, 19 Apr 2024 04:38:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 03/44] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
Date: Fri, 19 Apr 2024 14:38:01 +0300
Message-Id: <20240419113842.3675543-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15654

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
[claudiu.beznea: fixed conflict in the documentation of struct rzg2l_cpg_priv]
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


