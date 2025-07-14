Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE35C83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74789.1752487749111177872
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: OarlTtoKS3C6gjftKtgxbA==
X-CSE-MsgGUID: aPaDuGPpRNOSC4mo9N9I7g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05EAF41D4BDF;
	Mon, 14 Jul 2025 19:09:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 30/57] phy: Add devm_of_phy_optional_get() helper
Date: Mon, 14 Jul 2025 11:07:11 +0100
Message-ID: <20250714100802.80035-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19458

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d02aa181ee595c81738b6bd7ebad6025fbee035a upstream.

Add an optional variant of devm_of_phy_get() that also takes care of
printing real errors, so drivers no longer have to open-code this
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/4cd0069bcff424ffc5c3a102397c02370b91985b.1674584626.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/driver-api/phy/phy.rst | 17 ++++++++++------
 drivers/phy/phy-core.c               | 30 ++++++++++++++++++++++++++++
 include/linux/phy/phy.h              |  9 +++++++++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index b7f54a45ab65..75f90606377e 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -105,6 +105,11 @@ it. This framework provides the following APIs to get a reference to the PHY.
 	struct phy *devm_phy_get(struct device *dev, const char *string);
 	struct phy *devm_phy_optional_get(struct device *dev,
 					  const char *string);
+	struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
+				    const char *con_id);
+	struct phy *devm_of_phy_optional_get(struct device *dev,
+					     struct device_node *np,
+					     const char *con_id);
 	struct phy *devm_of_phy_get_by_index(struct device *dev,
 					     struct device_node *np,
 					     int index);
@@ -116,12 +121,12 @@ non-dt boot, it should contain the label of the PHY.  The two
 devm_phy_get associates the device with the PHY using devres on
 successful PHY get. On driver detach, release function is invoked on
 the devres data and devres data is freed.
-devm_phy_optional_get should be used when the phy is optional. This
-function will never return -ENODEV, but instead returns NULL when
-the phy cannot be found.Some generic drivers, such as ehci, may use multiple
-phys and for such drivers referencing phy(s) by name(s) does not make sense. In
-this case, devm_of_phy_get_by_index can be used to get a phy reference based on
-the index.
+The _optional_get variants should be used when the phy is optional. These
+functions will never return -ENODEV, but instead return NULL when
+the phy cannot be found.
+Some generic drivers, such as ehci, may use multiple phys. In this case,
+devm_of_phy_get or devm_of_phy_get_by_index can be used to get a phy
+reference based on name or index.
 
 It should be noted that NULL is a valid phy reference. All phy
 consumer calls on the NULL phy become NOPs. That is the release calls,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index c36cefb2d5c6..a5849120b82e 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -864,6 +864,36 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
 
+/**
+ * devm_of_phy_optional_get() - lookup and obtain a reference to an optional
+ * phy.
+ * @dev: device that requests this phy
+ * @np: node containing the phy
+ * @con_id: name of the phy from device's point of view
+ *
+ * Gets the phy using of_phy_get(), and associates a device with it using
+ * devres. On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed.  This differs to devm_of_phy_get() in
+ * that if the phy does not exist, it is not considered an error and
+ * -ENODEV will not be returned. Instead the NULL phy is returned,
+ * which can be passed to all other phy consumer calls.
+ */
+struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
+				     const char *con_id)
+{
+	struct phy *phy = devm_of_phy_get(dev, np, con_id);
+
+	if (PTR_ERR(phy) == -ENODEV)
+		phy = NULL;
+
+	if (IS_ERR(phy))
+		dev_err_probe(dev, PTR_ERR(phy), "failed to get PHY %pOF:%s",
+			      np, con_id);
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_optional_get);
+
 /**
  * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by index.
  * @dev: device that requests this phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 1b4f9be21e01..3a570bc59fc7 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -254,6 +254,8 @@ struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id);
+struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
+				     const char *con_id);
 struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index);
 void of_phy_put(struct phy *phy);
@@ -443,6 +445,13 @@ static inline struct phy *devm_of_phy_get(struct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct phy *devm_of_phy_optional_get(struct device *dev,
+						   struct device_node *np,
+						   const char *con_id)
+{
+	return NULL;
+}
+
 static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
 						   struct device_node *np,
 						   int index)
-- 
2.43.0


