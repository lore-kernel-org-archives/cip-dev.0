Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE8CC433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.19376.1640181004984683959
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104842220"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2021 22:50:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A7AB0430F436;
	Wed, 22 Dec 2021 22:50:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/21] dt-bindings: phy: renesas,usb2-phy: Document
 RZ/G2L phy bindings
Date: Wed, 22 Dec 2021 13:49:36 +0000
Message-Id: <20211222134951.19432-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7241

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 5711af410c28d2b9c99a91e8e6fe9ba6520771f0 upstream.

Document USB phy bindings for RZ/G2L SoC.

RZ/G2L USB2.0 phy uses line ctrl register for OTG_ID pin changes. It uses
a different OTG-BC interrupt bit for device recognition. Apart from this,
the PHY reset is controlled by USBPHY control IP and Document reset is a
required property.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210727185527.19907-3-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 829e8c7e467a..5bd85364f5de 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -30,6 +30,11 @@ properties:
               - renesas,usb2-phy-r8a77995 # R-Car D3
           - const: renesas,rcar-gen3-usb2-phy
 
+      - items:
+          - enum:
+              - renesas,usb2-phy-r9a07g044 # RZ/G2{L,LC}
+          - const: renesas,rzg2l-usb2-phy  # RZ/G2L family
+
   reg:
     maxItems: 1
 
@@ -94,6 +99,16 @@ required:
   - clocks
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-usb2-phy
+    then:
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
-- 
2.17.1


