Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D0D33A3C
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:42 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31322.1768466191982567874
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=E3mp6BSR;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso880174a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466190; x=1769070990; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uTOfsslG2X55Zuj85Pd6bjV0j9P6VxVVJ7XneeA18A=;
        b=E3mp6BSRslSUmxKarpN1YIHfEJnhWIcB7xpRuKiErh/NBuYn7Tu02dMGk3b/Qp8H8E
         JHn2lj+ChFZP4ciNAKs6l2tiFVl0NuRmgqAVaA657HzQK+imku9JFeH9fVLlD8q+tSQG
         x24zLSskcU5kzq2hn/kvCNwYPRo7Cks2A0m7I03VNX21CTLf0CzDQhSqw7WfTU+i+d3n
         QLGGg5GGbS3HKsMEF6z7kvlM12PepJR5xgeQTdHqdNmwIiKvSyItqXs8VyJNIsfo1y2H
         LIC+bBYQAg1MvRa5Eps1rc7GTjkRNZ3IBbANkAPf/mhqCxUXw9MgCRDx+AWs0qegBzQT
         4Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466190; x=1769070990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uTOfsslG2X55Zuj85Pd6bjV0j9P6VxVVJ7XneeA18A=;
        b=PKvbokfOPBq/M2ab219kDB81BAqwPRmhXdV6thhBWPpN1kvvIm+Hwb673GtDWM4T6x
         CvbCMNTWiioSjjSmn1bNWagO+U9Wi5hTYwqB8S8rvfCZHRdUdTg2rGV1igjEty8D5jGh
         nUit5Nj4AxMTYqDtPRQjz1ymkm8P5i7ksOrNflrdr6hU538eh4VH+qKNOlXc5p5wcWp1
         aEvp6L+61QN3BlZNv7RbC/71DC/826f4lli9pPt7igHDI2k2YfsyTuoZfMa1Kujo8TPM
         MSu0QuneAt2h6xNzCAtdWKEKkcDc5Jwz/ynNU1mQHLdjf8a/5ANqoejIcXP4ckxlviMG
         1fjw==
X-Gm-Message-State: AOJu0YyPNeQ6+b/UYQOtebHiF0lf9FU6xdGz94HCDYtRSekMVFoQpLKu
	YAh+PqRiZwq4Sq0IYo4PhG6BxFRsIcBw8VxZht8kmEMpa7IbEdgElXvVsosjzJwBK3gZBaUL+Qv
	IIfA3
X-Gm-Gg: AY/fxX6NoOJbSV0leX0FtU5sl+CPQ9RL3vaM2Wmc4qTqz7fHiKELKdqUh4mxwA5dQgh
	OMDrOnbljIVPWyeEUVBcgKxcMxdcrhGnlNEzBsluLBz0SWQ8Yl+xjmkITLp7OxFLjig0y4Bl+Gv
	EuwOs2pDSoiWvSrKIHOQZXb1/ZSVe0qdO3y0vZ5VS34T++5iWqdnl0vIKbQnMoiwiiJaI+JMLNi
	GPgPb+at7u6Jf0z6tOiWCNWDgjQD2giA2MeGPP8zMuHv6mgrDTh/mDzkBoiX7E4M2m3VGi4GMuJ
	CC3Wc9j/N0tNblRh2b3naZ/4yuBVwU1xDDmbhoVHtVxSBpsP51sSouy+Txzex4p/3mJkXkFsgzz
	0g3lY+p1ORt6m8H4vb/A2O7Ja7nk1fkIck3BANc5SwjSXBzJFzDB8Ixap/wBy8++1CDlKcu4OQK
	mKGhXpbCATbyfaWaPBculDdfhLPaF2BrNuG2azUOUFYsaO257TcFEnD8sUThW883cPVwXFiRnAt
	PKc
X-Received: by 2002:a17:906:7315:b0:b86:f0b4:4996 with SMTP id a640c23a62f3a-b87610cbdddmr471775166b.25.1768466190259;
        Thu, 15 Jan 2026 00:36:30 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 13/19] clk: renesas: rzg2l: Drop MSTOP based power domain support
Date: Thu, 15 Jan 2026 10:35:57 +0200
Message-ID: <20260115083604.1064260-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21613

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


