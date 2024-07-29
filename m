Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60753C3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59142.1722267074879486248
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908935"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 57F8E4006A90;
	Tue, 30 Jul 2024 00:31:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/13] regulator: core: Add helper for allow HW access to enable/disable regulator
Date: Mon, 29 Jul 2024 16:30:41 +0100
Message-ID: <20240729153109.510325-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16656

commit 1cb7d29157603561af4c38535e936850ceb99f0f upstream.

Add a helper function that allow regulator consumers to allow low-level
HW access, in order to enable/disable regulator in atomic context.

The use-case for RZ/G2L SoC is to enable VBUS selection register based
on vbus detection that happens in interrupt context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20240616105402.45211-4-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/power/regulator/consumer.rst |  6 +++++
 drivers/regulator/core.c                   | 28 ++++++++++++++++++++++
 include/linux/regulator/consumer.h         |  7 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/power/regulator/consumer.rst b/Documentation/power/regulator/consumer.rst
index 0cd8cc1275a7..ebc4c8076711 100644
--- a/Documentation/power/regulator/consumer.rst
+++ b/Documentation/power/regulator/consumer.rst
@@ -227,3 +227,9 @@ directly written to the voltage selector register, use::
 
 	int regulator_list_hardware_vsel(struct regulator *regulator,
 					 unsigned selector);
+
+To access the hardware for enabling/disabling the regulator, consumers must
+use regulator_get_exclusive(), as it can't work if there's more than one
+consumer. To enable/disable regulator use::
+
+	int regulator_hardware_enable(struct regulator *regulator, bool enable);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 518b64b2d69b..80a5e4dc1e6a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3402,6 +3402,34 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_list_hardware_vsel);
 
+/**
+ * regulator_hardware_enable - access the HW for enable/disable regulator
+ * @regulator: regulator source
+ * @enable: true for enable, false for disable
+ *
+ * Request that the regulator be enabled/disabled with the regulator output at
+ * the predefined voltage or current value.
+ *
+ * On success 0 is returned, otherwise a negative errno is returned.
+ */
+int regulator_hardware_enable(struct regulator *regulator, bool enable)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int ret = -EOPNOTSUPP;
+
+	if (!rdev->exclusive || !ops || !ops->enable || !ops->disable)
+		return ret;
+
+	if (enable)
+		ret = ops->enable(rdev);
+	else
+		ret = ops->disable(rdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_hardware_enable);
+
 /**
  * regulator_get_linear_step - return the voltage step size between VSEL values
  * @regulator: regulator source
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index a9ca87a8f4e6..7766a6e2da18 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -290,6 +290,7 @@ int regulator_get_hardware_vsel_register(struct regulator *regulator,
 					 unsigned *vsel_mask);
 int regulator_list_hardware_vsel(struct regulator *regulator,
 				 unsigned selector);
+int regulator_hardware_enable(struct regulator *regulator, bool enable);
 
 /* regulator notifier block */
 int regulator_register_notifier(struct regulator *regulator,
@@ -599,6 +600,12 @@ static inline int regulator_list_hardware_vsel(struct regulator *regulator,
 	return -EOPNOTSUPP;
 }
 
+static inline int regulator_hardware_enable(struct regulator *regulator,
+					    bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb)
 {
-- 
2.43.0


