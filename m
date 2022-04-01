Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48867C41535
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3615.1648842199155839517
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="116465385"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CEEC640061B8;
	Sat,  2 Apr 2022 04:43:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 29/40] clk: renesas: rzg2l: Check return
 value of pm_genpd_init()
Date: Fri,  1 Apr 2022 20:42:23 +0100
Message-Id: <20220401194234.14057-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7940

commit 27527a3d3b162e4512798c058c0e8a216c721187 upstream.

Make sure we check the return value of pm_genpd_init() which might fail.
Also add a devres action to remove the power-domain in-case the probe
callback fails further down in the code flow.

Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211117115101.28281-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a77cb47b75e7..1b1555deb20b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -851,10 +851,16 @@ static void rzg2l_cpg_detach_dev(struct generic_pm_domain *unused, struct device
 		pm_clk_destroy(dev);
 }
 
+static void rzg2l_cpg_genpd_remove(void *data)
+{
+	pm_genpd_remove(data);
+}
+
 static int __init rzg2l_cpg_add_clk_domain(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	genpd = devm_kzalloc(dev, sizeof(*genpd), GFP_KERNEL);
 	if (!genpd)
@@ -865,7 +871,13 @@ static int __init rzg2l_cpg_add_clk_domain(struct device *dev)
 		       GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = rzg2l_cpg_attach_dev;
 	genpd->detach_dev = rzg2l_cpg_detach_dev;
-	pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, genpd);
+	if (ret)
+		return ret;
 
 	of_genpd_add_provider_simple(np, genpd);
 	return 0;
-- 
2.17.1


