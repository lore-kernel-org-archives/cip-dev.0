Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E6C61D9C
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20658.1700663304421656546
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187743092"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2970C4010DF6;
	Wed, 22 Nov 2023 23:28:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/11] clk: fixed-factor: Introduce devm_clk_hw_register_fixed_factor_index()
Date: Wed, 22 Nov 2023 14:28:12 +0000
Message-Id: <20231122142819.203737-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13616

From: Marek Vasut <marex@denx.de>

commit 0c125f87a84097c182c481be7497af9f816e5db5 upstream.

Add an API for a fixed factor clk that uses an index for the parent
instead of a string name. This allows us to move drivers away from the
string based method of describing parents and use the DT/firmware based
method instead.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org
Link: https://lore.kernel.org/r/20220226040723.143705-2-marex@denx.de
[sboyd@kernel.org: Expose a new API instead of internal function]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-fixed-factor.c | 22 ++++++++++++++++++++++
 include/linux/clk-provider.h   |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 4f7bf3929d6d..b65f027dd40c 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -124,6 +124,28 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	return hw;
 }
 
+/**
+ * devm_clk_hw_register_fixed_factor_index - Register a fixed factor clock with
+ * parent from DT index
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @index: index of phandle in @dev 'clocks' property
+ * @flags: fixed factor flags
+ * @mult: multiplier
+ * @div: divider
+ *
+ * Return: Pointer to fixed factor clk_hw structure that was registered or
+ * an error pointer.
+ */
+struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
+		const char *name, unsigned int index, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, index,
+					      flags, mult, div, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
+
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59dc4d73b6a3..0b0055359bbb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -957,6 +957,9 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
 struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
+		const char *name, unsigned int index, unsigned long flags,
+		unsigned int mult, unsigned int div);
 /**
  * struct clk_fractional_divider - adjustable fractional divider clock
  *
-- 
2.25.1


