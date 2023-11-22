Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74CC61D9D
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20716.1700663316842413541
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="183887320"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 931254010DF3;
	Wed, 22 Nov 2023 23:28:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/11] clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
Date: Wed, 22 Nov 2023 14:28:14 +0000
Message-Id: <20231122142819.203737-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13618

From: Marijn Suijten <marijn.suijten@somainline.org>

commit 6ebd5247ad2aa210b3ff4481c6ed8aa32a032b12 upstream.

Add the devres and non-devres variant of
clk_hw_register_fixed_factor_parent_hw() for registering a fixed factor
clock with clk_hw parent pointer instead of parent name.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/r/20220629225331.357308-4-marijn.suijten@somainline.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-fixed-factor.c | 45 ++++++++++++++++++++++++++++++----
 include/linux/clk-provider.h   |  8 ++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 67229bfec4c0..bf55b9b71c6a 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -71,7 +71,8 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
 
 static struct clk_hw *
 __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
-		const char *name, const char *parent_name, int index,
+		const char *name, const char *parent_name,
+		const struct clk_hw *parent_hw, int index,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		bool devm)
 {
@@ -103,6 +104,8 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	init.flags = flags;
 	if (parent_name)
 		init.parent_names = &parent_name;
+	else if (parent_hw)
+		init.parent_hws = &parent_hw;
 	else
 		init.parent_data = &pdata;
 	init.num_parents = 1;
@@ -141,16 +144,48 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, index,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, index,
 					      flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
 
+/**
+ * devm_clk_hw_register_fixed_factor_parent_hw - Register a fixed factor clock with
+ * pointer to parent clock
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: fixed factor flags
+ * @mult: multiplier
+ * @div: divider
+ *
+ * Return: Pointer to fixed factor clk_hw structure that was registered or
+ * an error pointer.
+ */
+struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+					      -1, flags, mult, div, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
+
+struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
+					      parent_hw, -1, flags, mult, div,
+					      false);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
+
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
 					      flags, mult, div, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
@@ -197,7 +232,7 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
 			flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
@@ -224,7 +259,7 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
 					    0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0b0055359bbb..c002f80e885a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -960,6 +960,14 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div);
+
+struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div);
+
+struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div);
 /**
  * struct clk_fractional_divider - adjustable fractional divider clock
  *
-- 
2.25.1


