Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA9CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:24 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10068.1762416674221229060
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YYVGMavD;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775ae77516so7462525e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416672; x=1763021472; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uTOfsslG2X55Zuj85Pd6bjV0j9P6VxVVJ7XneeA18A=;
        b=YYVGMavDCkrlUkOHSNMar54hYdE1zX51dZyOjxq0ac/V0iE05cAyePxIKUGbvZSZNL
         G/nJgXspUOBamobXdZSIkxhrkt6wRIn4cjAOecbfo9/Z69/kEeQTlnV55ePTcn2hOO6t
         6batVTQJWiDtqutaE6JW9JXGF6vPUon9u5lI2k4qPbxQb+Hal8KK277UU5QzPyXbf2Bw
         AX3vzPD2PRQOy3wFi3dGn8zDdr8YU9YCiqVvRugj+Q7eip0ZdIF/A31MStvRojP3piEo
         IzRFFNnkvhDzoZ9LN4k4FmBB1OKJ4zv7ye9qa9DAVYzWJxTLS7abZ6LTjrmh+bT9APgX
         V5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416673; x=1763021473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uTOfsslG2X55Zuj85Pd6bjV0j9P6VxVVJ7XneeA18A=;
        b=dEk4gl8+Oyw2/JrxUhnXYJS2kLsnhHQ6PvdMeYHrotGVDopARXv8jItUV/t7RiNCx8
         t+xCESqoFm9UXwCakxK9FQCmPDau3itZX6hAR+fW8Hrek1oqMPlfo2kJxkDMqM7k3eVw
         3LhLHXm6bTRKXT7KsvFF6swEJNPOCZjYV91CM0rIohcriTJEjtJqXLikWCmszrye46GX
         nvqP4l98s5giUE4ZFSAdynlfMViNdWhUBMGUh3fePntnQhNOJuxGKATNxSjm85MoY6ES
         fElRGoojhHaMvX7OcoIHo7+iWeyomnFJuZPQ3y3ENoSNEx65qwh0vIEMAgc620g8N+Pn
         zWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3fX42Orz0ZeTE2zGfMauK0zza1P0bxAwSXYMpOyvBEC+a+IZwNcggbVO+t2Gy/0jkv6ZoxbIv@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6VR8u6FOz1nZC7PrKvH0d8f7pkJgwKMMWbZAGMMQjS0dmr2tc
	PGEgMAtSKc5H8Z/tUGHx+7ePeK7pt3QEIkpsa2GG6tSlJwrqG9HfseBjIMqHCvn0SzQ=
X-Gm-Gg: ASbGnctJ0dLbgWV2Sbp2lFKXI/HlmxtxE3lD2r0i0CDepkzCq1JtLRAA8n0FtM/Aplq
	x+Jog1Chq9DOxjlnUKZoBuxunR53pJ37KANt3EQcCf1RavLRZtw97ztG9HstMHSOtSXzbFVcitB
	jrT0pv9k/HQTVREMZJgtNUJz2IN9vIM8JIFa7xkNmNCr46qV4Ilr4nbqaF3NQN2+BxUqr3T0ZBm
	DlAxWdsJn85whmd42grc6YPGXIjGuf6iWJDtaMOcianuVofqZcgvtWsdmMA7dfx6pxCOcKCchXc
	s+2JJZB1SyllcWng3WyOK8TuC6qBH9J+RXjBzOZxz28EX77stnnFHFl3/ViKx0HBcEfBPhbxcmJ
	GGUpXE+EqyGsTKYXuUvc6BA7+9b8wD07HJyq03021OkD4kn2kySz6dXYnUxsA7jzM9R9kYkivRl
	7bB2SQmAmyzMDIceZS7rZJvY2OA4t5qg==
X-Google-Smtp-Source: AGHT+IFRl9pyLHavtLZmF//nToC8RtUT729THrB38efxPjbP2XqYmhyMyqjC077rgnKa03g+Txe2QQ==
X-Received: by 2002:a05:6000:2681:b0:429:bb4c:9589 with SMTP id ffacd0b85a97d-429e3276a4emr4940849f8f.0.1762416672587;
        Thu, 06 Nov 2025 00:11:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 16/23] clk: renesas: rzg2l: Drop MSTOP based power domain support
Date: Thu,  6 Nov 2025 10:10:41 +0200
Message-ID: <20251106081048.2574345-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20385

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 26a301a244dd011f4b928cbe2b6f4b4b666ba2cb upstream.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain core code.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping all the MSTOP specific power
 domain code]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 205 +++-----------------------------
 drivers/clk/renesas/rzg2l-cpg.h |  55 ---------
 2 files changed, 17 insertions(+), 243 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index ba96d8eb7cef..50e7bce23493 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -148,6 +148,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
+ * @genpd: PM domain
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
@@ -164,6 +165,8 @@ struct rzg2l_cpg_priv {
 
 	const struct rzg2l_cpg_info *info;
 
+	struct generic_pm_domain genpd;
+
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
@@ -1773,39 +1776,14 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
-/**
- * struct rzg2l_cpg_pm_domains - RZ/G2L PM domains data structure
- * @onecell_data: cell data
- * @domains: generic PM domains
- */
-struct rzg2l_cpg_pm_domains {
-	struct genpd_onecell_data onecell_data;
-	struct generic_pm_domain *domains[];
-};
-
-/**
- * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
- * @genpd: generic PM domain
- * @priv: pointer to CPG private data structure
- * @conf: CPG PM domain configuration info
- * @id: RZ/G2L power domain ID
- */
-struct rzg2l_cpg_pd {
-	struct generic_pm_domain genpd;
-	struct rzg2l_cpg_priv *priv;
-	struct rzg2l_cpg_pm_domain_conf conf;
-	u16 id;
-};
-
-static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_pd *pd,
+static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_priv *priv,
 				const struct of_phandle_args *clkspec)
 {
-	if (clkspec->np != pd->genpd.dev.of_node || clkspec->args_count != 2)
+	if (clkspec->np != priv->genpd.dev.of_node || clkspec->args_count != 2)
 		return false;
 
 	switch (clkspec->args[0]) {
 	case CPG_MOD: {
-		struct rzg2l_cpg_priv *priv = pd->priv;
 		const struct rzg2l_cpg_info *info = priv->info;
 		unsigned int id = clkspec->args[1];
 
@@ -1830,7 +1808,7 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_pd *pd,
 
 static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 {
-	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
+	struct rzg2l_cpg_priv *priv = container_of(domain, struct rzg2l_cpg_priv, genpd);
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
 	bool once = true;
@@ -1839,7 +1817,7 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *domain, struct device
 	int error;
 
 	for (i = 0; !of_parse_phandle_with_args(np, "clocks", "#clock-cells", i, &clkspec); i++) {
-		if (!rzg2l_cpg_is_pm_clk(pd, &clkspec)) {
+		if (!rzg2l_cpg_is_pm_clk(priv, &clkspec)) {
 			of_node_put(clkspec.np);
 			continue;
 		}
@@ -1884,180 +1862,31 @@ static void rzg2l_cpg_detach_dev(struct generic_pm_domain *unused, struct device
 }
 
 static void rzg2l_cpg_genpd_remove(void *data)
-{
-	struct genpd_onecell_data *celldata = data;
-
-	for (unsigned int i = 0; i < celldata->num_domains; i++)
-		pm_genpd_remove(celldata->domains[i]);
-}
-
-static void rzg2l_cpg_genpd_remove_simple(void *data)
 {
 	pm_genpd_remove(data);
 }
 
-static int rzg2l_cpg_power_on(struct generic_pm_domain *domain)
-{
-	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
-	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
-	struct rzg2l_cpg_priv *priv = pd->priv;
-
-	/* Set MSTOP. */
-	if (mstop.mask)
-		writel(mstop.mask << 16, priv->base + mstop.off);
-
-	return 0;
-}
-
-static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
-{
-	struct rzg2l_cpg_pd *pd = container_of(domain, struct rzg2l_cpg_pd, genpd);
-	struct rzg2l_cpg_reg_conf mstop = pd->conf.mstop;
-	struct rzg2l_cpg_priv *priv = pd->priv;
-
-	/* Set MSTOP. */
-	if (mstop.mask)
-		writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
-
-	return 0;
-}
-
-static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
-{
-	struct dev_power_governor *governor;
-
-	pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
-	pd->genpd.attach_dev = rzg2l_cpg_attach_dev;
-	pd->genpd.detach_dev = rzg2l_cpg_detach_dev;
-	if (always_on) {
-		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
-		governor = &pm_domain_always_on_gov;
-	} else {
-		pd->genpd.power_on = rzg2l_cpg_power_on;
-		pd->genpd.power_off = rzg2l_cpg_power_off;
-		governor = &simple_qos_governor;
-	}
-
-	return pm_genpd_init(&pd->genpd, governor, !always_on);
-}
-
 static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 {
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct rzg2l_cpg_pd *pd;
+	struct generic_pm_domain *genpd = &priv->genpd;
 	int ret;
 
-	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-	if (!pd)
-		return -ENOMEM;
-
-	pd->genpd.name = np->name;
-	pd->priv = priv;
-	ret = rzg2l_cpg_pd_setup(pd, true);
+	genpd->name = np->name;
+	genpd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ALWAYS_ON |
+		       GENPD_FLAG_ACTIVE_WAKEUP;
+	genpd->attach_dev = rzg2l_cpg_attach_dev;
+	genpd->detach_dev = rzg2l_cpg_detach_dev;
+	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove_simple, &pd->genpd);
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, genpd);
 	if (ret)
 		return ret;
 
-	return of_genpd_add_provider_simple(np, &pd->genpd);
-}
-
-static struct generic_pm_domain *
-rzg2l_cpg_pm_domain_xlate(const struct of_phandle_args *spec, void *data)
-{
-	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
-	struct genpd_onecell_data *genpd = data;
-
-	if (spec->args_count != 1)
-		return ERR_PTR(-EINVAL);
-
-	for (unsigned int i = 0; i < genpd->num_domains; i++) {
-		struct rzg2l_cpg_pd *pd = container_of(genpd->domains[i], struct rzg2l_cpg_pd,
-						       genpd);
-
-		if (pd->id == spec->args[0]) {
-			domain = &pd->genpd;
-			break;
-		}
-	}
-
-	return domain;
-}
-
-static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
-{
-	const struct rzg2l_cpg_info *info = priv->info;
-	struct device *dev = priv->dev;
-	struct device_node *np = dev->of_node;
-	struct rzg2l_cpg_pm_domains *domains;
-	struct generic_pm_domain *parent;
-	u32 ncells;
-	int ret;
-
-	ret = of_property_read_u32(np, "#power-domain-cells", &ncells);
-	if (ret)
-		return ret;
-
-	/* For backward compatibility. */
-	if (!ncells)
-		return rzg2l_cpg_add_clk_domain(priv);
-
-	domains = devm_kzalloc(dev, struct_size(domains, domains, info->num_pm_domains),
-			       GFP_KERNEL);
-	if (!domains)
-		return -ENOMEM;
-
-	domains->onecell_data.domains = domains->domains;
-	domains->onecell_data.num_domains = info->num_pm_domains;
-	domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
-
-	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
-	if (ret)
-		return ret;
-
-	for (unsigned int i = 0; i < info->num_pm_domains; i++) {
-		bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
-		struct rzg2l_cpg_pd *pd;
-
-		pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-		if (!pd)
-			return -ENOMEM;
-
-		pd->genpd.name = info->pm_domains[i].name;
-		pd->conf = info->pm_domains[i].conf;
-		pd->id = info->pm_domains[i].id;
-		pd->priv = priv;
-
-		ret = rzg2l_cpg_pd_setup(pd, always_on);
-		if (ret)
-			return ret;
-
-		if (always_on) {
-			ret = rzg2l_cpg_power_on(&pd->genpd);
-			if (ret)
-				return ret;
-		}
-
-		domains->domains[i] = &pd->genpd;
-		/* Parent should be on the very first entry of info->pm_domains[]. */
-		if (!i) {
-			parent = &pd->genpd;
-			continue;
-		}
-
-		ret = pm_genpd_add_subdomain(parent, &pd->genpd);
-		if (ret)
-			return ret;
-	}
-
-	ret = of_genpd_add_provider_onecell(np, &domains->onecell_data);
-	if (ret)
-		return ret;
-
-	return 0;
+	return of_genpd_add_provider_simple(np, genpd);
 }
 
 static int __init rzg2l_cpg_probe(struct platform_device *pdev)
@@ -2120,7 +1949,7 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = rzg2l_cpg_add_pm_domains(priv);
+	error = rzg2l_cpg_add_clk_domain(priv);
 	if (error)
 		return error;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index bff904d5ae3a..0a71c5ec24b6 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -257,55 +257,6 @@ struct rzg2l_reset {
 #define DEF_RST(_id, _off, _bit)	\
 	DEF_RST_MON(_id, _off, _bit, -1)
 
-/**
- * struct rzg2l_cpg_reg_conf - RZ/G2L register configuration data structure
- * @off: register offset
- * @mask: register mask
- */
-struct rzg2l_cpg_reg_conf {
-	u16 off;
-	u16 mask;
-};
-
-#define DEF_REG_CONF(_off, _mask) ((struct rzg2l_cpg_reg_conf) { .off = (_off), .mask = (_mask) })
-
-/**
- * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data structure
- * @mstop: MSTOP register configuration
- */
-struct rzg2l_cpg_pm_domain_conf {
-	struct rzg2l_cpg_reg_conf mstop;
-};
-
-/**
- * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
- * @name: PM domain name
- * @conf: PM domain configuration
- * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
- * @id: PM domain ID (similar to the ones defined in
- *      include/dt-bindings/clock/<soc-id>-cpg.h)
- */
-struct rzg2l_cpg_pm_domain_init_data {
-	const char * const name;
-	struct rzg2l_cpg_pm_domain_conf conf;
-	u32 flags;
-	u16 id;
-};
-
-#define DEF_PD(_name, _id, _mstop_conf, _flags) \
-	{ \
-		.name = (_name), \
-		.id = (_id), \
-		.conf = { \
-			.mstop = (_mstop_conf), \
-		}, \
-		.flags = (_flags), \
-	}
-
-/* Power domain flags. */
-#define RZG2L_PD_F_ALWAYS_ON	BIT(0)
-#define RZG2L_PD_F_NONE		(0)
-
 /**
  * struct rzg2l_cpg_info - SoC-specific CPG Description
  *
@@ -324,8 +275,6 @@ struct rzg2l_cpg_pm_domain_init_data {
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
- * @pm_domains: PM domains init data array
- * @num_pm_domains: Number of PM domains
  * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
  */
 struct rzg2l_cpg_info {
@@ -352,10 +301,6 @@ struct rzg2l_cpg_info {
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
 
-	/* Power domain. */
-	const struct rzg2l_cpg_pm_domain_init_data *pm_domains;
-	unsigned int num_pm_domains;
-
 	bool has_clk_mon_regs;
 };
 
-- 
2.43.0


