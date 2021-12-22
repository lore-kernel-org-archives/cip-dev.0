Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65060C433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.19262.1640181000080184146
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366610"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:50:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 60063430F434;
	Wed, 22 Dec 2021 22:49:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/21] dt-bindings: usb: renesas,usbhs: Document
 RZ/G2L bindings
Date: Wed, 22 Dec 2021 13:49:35 +0000
Message-Id: <20211222134951.19432-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7239

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 177cd475e1f12d256c9bf7de274fef7bea30cddb upstream.

Document RZ/G2L (R9A07G044L) SoC bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210727185527.19907-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/usb/renesas,usbhs.yaml           | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 737c1f47b7de..7ab36f81939c 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -17,7 +17,9 @@ properties:
           - const: renesas,rza1-usbhs
 
       - items:
-          - const: renesas,usbhs-r7s9210 # RZ/A2
+          - enum:
+              - renesas,usbhs-r7s9210   # RZ/A2
+              - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
           - const: renesas,rza2-usbhs
 
       - items:
@@ -60,7 +62,8 @@ properties:
       - description: USB 2.0 clock selector
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   renesas,buswait:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -113,6 +116,25 @@ required:
   - clocks
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,usbhs-r9a07g044
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: U2P_IXL_INT
+            - description: U2P_INT_DMA[0]
+            - description: U2P_INT_DMA[1]
+            - description: U2P_INT_DMAERR
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.17.1


