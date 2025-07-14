Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB90C83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: xrkTQdrzS/mQEYFqDAb5aQ==
X-CSE-MsgGUID: u/292AZORMCAo2u+v2L+dQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E7E0541D4BF2;
	Mon, 14 Jul 2025 19:09:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 29/57] phy: Remove unused phy_optional_get()
Date: Mon, 14 Jul 2025 11:07:10 +0100
Message-ID: <20250714100802.80035-30-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19457

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1bd9a7b4afd5e0b938868a90b16d514c19808e6c upstream.

There were never any upstream users of this function since its
introduction almost 10 years ago.

Besides, the dummy for phy_optional_get() should have returned NULL
instead of an error code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/df61992b1d66bccf4e6e1eafae94a7f7d7629f34.1674584626.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/driver-api/phy/phy.rst | 11 +++++------
 drivers/phy/phy-core.c               | 21 ---------------------
 include/linux/phy/phy.h              |  7 -------
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index 8fc1ce0bb905..b7f54a45ab65 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -102,7 +102,6 @@ it. This framework provides the following APIs to get a reference to the PHY.
 ::
 
 	struct phy *phy_get(struct device *dev, const char *string);
-	struct phy *phy_optional_get(struct device *dev, const char *string);
 	struct phy *devm_phy_get(struct device *dev, const char *string);
 	struct phy *devm_phy_optional_get(struct device *dev,
 					  const char *string);
@@ -110,15 +109,15 @@ it. This framework provides the following APIs to get a reference to the PHY.
 					     struct device_node *np,
 					     int index);
 
-phy_get, phy_optional_get, devm_phy_get and devm_phy_optional_get can
-be used to get the PHY. In the case of dt boot, the string arguments
+phy_get, devm_phy_get and devm_phy_optional_get can be used to get the PHY.
+In the case of dt boot, the string arguments
 should contain the phy name as given in the dt data and in the case of
 non-dt boot, it should contain the label of the PHY.  The two
 devm_phy_get associates the device with the PHY using devres on
 successful PHY get. On driver detach, release function is invoked on
-the devres data and devres data is freed. phy_optional_get and
-devm_phy_optional_get should be used when the phy is optional. These
-two functions will never return -ENODEV, but instead returns NULL when
+the devres data and devres data is freed.
+devm_phy_optional_get should be used when the phy is optional. This
+function will never return -ENODEV, but instead returns NULL when
 the phy cannot be found.Some generic drivers, such as ehci, may use multiple
 phys and for such drivers referencing phy(s) by name(s) does not make sense. In
 this case, devm_of_phy_get_by_index can be used to get a phy reference based on
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 069bcf49ee8f..c36cefb2d5c6 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -772,27 +772,6 @@ struct phy *phy_get(struct device *dev, const char *string)
 }
 EXPORT_SYMBOL_GPL(phy_get);
 
-/**
- * phy_optional_get() - lookup and obtain a reference to an optional phy.
- * @dev: device that requests this phy
- * @string: the phy name as given in the dt data or the name of the controller
- * port for non-dt case
- *
- * Returns the phy driver, after getting a refcount to it; or
- * NULL if there is no such phy.  The caller is responsible for
- * calling phy_put() to release that count.
- */
-struct phy *phy_optional_get(struct device *dev, const char *string)
-{
-	struct phy *phy = phy_get(dev, string);
-
-	if (PTR_ERR(phy) == -ENODEV)
-		phy = NULL;
-
-	return phy;
-}
-EXPORT_SYMBOL_GPL(phy_optional_get);
-
 /**
  * devm_phy_get() - lookup and obtain a reference to a phy.
  * @dev: device that requests this phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b1413757fcc3..1b4f9be21e01 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -250,7 +250,6 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	phy->attrs.bus_width = bus_width;
 }
 struct phy *phy_get(struct device *dev, const char *string);
-struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
@@ -426,12 +425,6 @@ static inline struct phy *phy_get(struct device *dev, const char *string)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline struct phy *phy_optional_get(struct device *dev,
-					   const char *string)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.43.0


