Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7EC7EE2E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34567.1685631857448189436
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816457"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 369274010DC0;
	Fri,  2 Jun 2023 00:04:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 04/19] dt-bindings: usb: renesas, usb3-peri: Document RZ/V2M r9a09g011 support
Date: Thu,  1 Jun 2023 16:03:55 +0100
Message-Id: <20230601150410.124773-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11734

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 3c3ce77c9dab7f9628a9a96e881d0afb50ed74a6 upstream.

Document the RZ/V2M SoC bindings.
The RZ/V2M SoC is a little different to the R-Car implementations.
A few DRD related registers and bits have moved, there is a separate
interrupt for DRD, an additional clock for register access and reset
lines for DRD and USBP.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220804192220.128601-2-phil.edworthy@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/usb/renesas,usb3-peri.yaml       | 99 ++++++++++++++++---
 1 file changed, 84 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
index 929a3f413b44..7a84f5922340 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
@@ -11,27 +11,55 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r8a774a1-usb3-peri # RZ/G2M
-          - renesas,r8a774b1-usb3-peri # RZ/G2N
-          - renesas,r8a774c0-usb3-peri # RZ/G2E
-          - renesas,r8a774e1-usb3-peri # RZ/G2H
-          - renesas,r8a7795-usb3-peri  # R-Car H3
-          - renesas,r8a7796-usb3-peri  # R-Car M3-W
-          - renesas,r8a77961-usb3-peri # R-Car M3-W+
-          - renesas,r8a77965-usb3-peri # R-Car M3-N
-          - renesas,r8a77990-usb3-peri # R-Car E3
-      - const: renesas,rcar-gen3-usb3-peri
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r8a774a1-usb3-peri # RZ/G2M
+              - renesas,r8a774b1-usb3-peri # RZ/G2N
+              - renesas,r8a774c0-usb3-peri # RZ/G2E
+              - renesas,r8a774e1-usb3-peri # RZ/G2H
+              - renesas,r8a7795-usb3-peri  # R-Car H3
+              - renesas,r8a7796-usb3-peri  # R-Car M3-W
+              - renesas,r8a77961-usb3-peri # R-Car M3-W+
+              - renesas,r8a77965-usb3-peri # R-Car M3-N
+              - renesas,r8a77990-usb3-peri # R-Car E3
+          - const: renesas,rcar-gen3-usb3-peri
+
+      - items:
+          - enum:
+              - renesas,r9a09g011-usb3-peri # RZ/V2M
+          - const: renesas,rzv2m-usb3-peri
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Combined interrupt for DMA, SYS and ERR
+      - description: Dual Role Device (DRD)
+      - description: Battery Charging
+      - description: Global Purpose Input
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: all_p
+      - const: drd
+      - const: bc
+      - const: gpi
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Main clock
+      - description: Register access clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: aclk
+      - const: reg
 
   phys:
     maxItems: 1
@@ -43,7 +71,15 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Peripheral reset
+      - description: DRD reset
+
+  reset-names:
+    items:
+      - const: aresetn_p
+      - const: drd_reset
 
   usb-role-switch:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -77,6 +113,39 @@ required:
   - interrupts
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rzv2m-usb3-peri
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+        interrupts:
+          minItems: 4
+        interrupt-names:
+          minItems: 4
+        resets:
+          minItems: 2
+      required:
+        - clock-names
+        - interrupt-names
+        - resets
+        - reset-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        resets:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


