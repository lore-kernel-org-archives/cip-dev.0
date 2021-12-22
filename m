Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFCC4332F
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.19377.1640181005005583785
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366622"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:50:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EFC8E430FFE0;
	Wed, 22 Dec 2021 22:50:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/21] phy: renesas: convert to
 devm_platform_ioremap_resource
Date: Wed, 22 Dec 2021 13:49:37 +0000
Message-Id: <20211222134951.19432-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7240

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 0b5604affbec0241d72996924b2f5a33d96b860a upstream.

Use devm_platform_ioremap_resource to simplify code

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/1604642930-29019-12-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen2.c      | 4 +---
 drivers/phy/renesas/phy-rcar-gen3-pcie.c | 4 +---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 4 +---
 drivers/phy/renesas/phy-rcar-gen3-usb3.c | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 2e279ac0fa4d..c375a4676a3d 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -339,7 +339,6 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 	struct rcar_gen2_phy_driver *drv;
 	struct phy_provider *provider;
 	struct device_node *np;
-	struct resource *res;
 	void __iomem *base;
 	struct clk *clk;
 	const struct rcar_gen2_phy_data *data;
@@ -357,8 +356,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c4e4aa216936..4dc721eb9577 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -76,7 +76,6 @@ static int rcar_gen3_phy_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *provider;
 	struct rcar_gen3_phy *phy;
-	struct resource *res;
 	void __iomem *base;
 	int error;
 
@@ -86,8 +85,7 @@ static int rcar_gen3_phy_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 2cb949f931b6..fbc55232120e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -611,7 +611,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
-	struct resource *res;
 	const struct phy_ops *phy_usb2_ops;
 	int ret = 0, i;
 
@@ -624,8 +623,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (!channel)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	channel->base = devm_ioremap_resource(dev, res);
+	channel->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(channel->base))
 		return PTR_ERR(channel->base);
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb3.c b/drivers/phy/renesas/phy-rcar-gen3-usb3.c
index 566b4cf4ff38..f27d6f471629 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb3.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb3.c
@@ -133,7 +133,6 @@ static int rcar_gen3_phy_usb3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_gen3_usb3 *r;
 	struct phy_provider *provider;
-	struct resource *res;
 	int ret = 0;
 	struct clk *clk;
 
@@ -146,8 +145,7 @@ static int rcar_gen3_phy_usb3_probe(struct platform_device *pdev)
 	if (!r)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	r->base = devm_ioremap_resource(dev, res);
+	r->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(r->base))
 		return PTR_ERR(r->base);
 
-- 
2.17.1


