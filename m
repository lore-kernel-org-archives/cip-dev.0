Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F33F013FA
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:56 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: iZ2hr9g9RayZwooBQ6tDRw==
X-CSE-MsgGUID: 5A/IDDRbQTmaxHnyiZAvWg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:52 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6A4A241B7814;
	Mon, 16 Mar 2026 23:59:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/35] dt-bindings: net: pcs: renesas,rzn1-miic: Add RZ/T2H and RZ/N2H support
Date: Mon, 16 Mar 2026 14:58:57 +0000
Message-ID: <20260316145915.8580-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22412

commit 8c01cc2382bc351672c8eb946c16f567cfffef60 upstream.

Add device tree binding support for RZ/T2H and RZ/N2H SoCs to the
existing RZ/N1 MIIC converter binding. These SoCs share similar MIIC
functionality but have architectural differences that require schema
updates.

Add new compatible strings "renesas,r9a09g077-miic" for RZ/T2H and
"renesas,r9a09g087-miic" for RZ/N2H, with the latter falling back to
the RZ/T2H variant. The new SoCs require reset support with two reset
lines for converter register reset and converter reset, which are not
present on RZ/N1.

Update port configurations to accommodate the different architectures.
RZ/N1 supports 5 ports numbered 1-5 with complex input mappings
covering indices 0-13, while RZ/T2H and RZ/N2H support 4 ports
numbered 0-3 with simplified input mappings covering indices 0-8.
Extend the switch port configuration property to support value 0 for
the new SoCs.

Add a new dt-bindings header file with media interface connection
matrix constants that map GMAC, ESC, and ETHSW ports to numeric
identifiers for use with RZ/T2H and RZ/N2H device trees.

Update DT schema validation to ensure proper port numbering and input
mappings per SoC variant.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20250910204132.319975-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/pcs/renesas,rzn1-miic.yaml   | 177 +++++++++++++-----
 .../net/renesas,r9a09g077-pcs-miic.h          |  36 ++++
 2 files changed, 165 insertions(+), 48 deletions(-)
 create mode 100644 include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h

diff --git a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
index 2d33bbab7163..3adbcf56d2be 100644
--- a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
@@ -4,14 +4,15 @@
 $id: http://devicetree.org/schemas/net/pcs/renesas,rzn1-miic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/N1 MII converter
+title: Renesas RZ/N1, RZ/N2H and RZ/T2H MII converter
 
 maintainers:
   - Clément Léger <clement.leger@bootlin.com>
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
 description: |
-  This MII converter is present on the Renesas RZ/N1 SoC family. It is
-  responsible to do MII passthrough or convert it to RMII/RGMII.
+  This MII converter is present on the Renesas RZ/N1, RZ/N2H and RZ/T2H SoC
+  families. It is responsible to do MII passthrough or convert it to RMII/RGMII.
 
 properties:
   '#address-cells':
@@ -21,10 +22,16 @@ properties:
     const: 0
 
   compatible:
-    items:
-      - enum:
-          - renesas,r9a06g032-miic
-      - const: renesas,rzn1-miic
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-miic
+          - const: renesas,rzn1-miic
+      - items:
+          - const: renesas,r9a09g077-miic # RZ/T2H
+      - items:
+          - const: renesas,r9a09g087-miic # RZ/N2H
+          - const: renesas,r9a09g077-miic
 
   reg:
     maxItems: 1
@@ -43,11 +50,22 @@ properties:
       - const: rmii_ref
       - const: hclk
 
+  resets:
+    items:
+      - description: Converter register reset
+      - description: Converter reset
+
+  reset-names:
+    items:
+      - const: rst
+      - const: crst
+
   renesas,miic-switch-portin:
     description: MII Switch PORTIN configuration. This value should use one of
-      the values defined in dt-bindings/net/pcs-rzn1-miic.h.
+      the values defined in dt-bindings/net/pcs-rzn1-miic.h for RZ/N1 SoC and
+      include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h for RZ/N2H, RZ/T2H SoCs.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2]
+    enum: [0, 1, 2]
 
   power-domains:
     maxItems: 1
@@ -60,11 +78,12 @@ patternProperties:
     properties:
       reg:
         description: MII Converter port number.
-        enum: [1, 2, 3, 4, 5]
+        enum: [0, 1, 2, 3, 4, 5]
 
       renesas,miic-input:
         description: Converter input port configuration. This value should use
-          one of the values defined in dt-bindings/net/pcs-rzn1-miic.h.
+          one of the values defined in dt-bindings/net/pcs-rzn1-miic.h for RZ/N1 SoC
+          and include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h for RZ/N2H, RZ/T2H SoCs.
         $ref: /schemas/types.yaml#/definitions/uint32
 
     required:
@@ -73,47 +92,109 @@ patternProperties:
 
     additionalProperties: false
 
-    allOf:
-      - if:
-          properties:
-            reg:
-              const: 1
-        then:
-          properties:
-            renesas,miic-input:
-              const: 0
-      - if:
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzn1-miic
+    then:
+      properties:
+        renesas,miic-switch-portin:
+          enum: [1, 2]
+        resets: false
+        reset-names: false
+      patternProperties:
+        "^mii-conv@[0-5]$":
           properties:
             reg:
-              const: 2
-        then:
-          properties:
-            renesas,miic-input:
-              enum: [1, 11]
-      - if:
-          properties:
-            reg:
-              const: 3
-        then:
-          properties:
-            renesas,miic-input:
-              enum: [7, 10]
-      - if:
+              enum: [1, 2, 3, 4, 5]
+          allOf:
+            - if:
+                properties:
+                  reg:
+                    const: 1
+              then:
+                properties:
+                  renesas,miic-input:
+                    const: 0
+            - if:
+                properties:
+                  reg:
+                    const: 2
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [1, 11]
+            - if:
+                properties:
+                  reg:
+                    const: 3
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [7, 10]
+            - if:
+                properties:
+                  reg:
+                    const: 4
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [4, 6, 9, 13]
+            - if:
+                properties:
+                  reg:
+                    const: 5
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [3, 5, 8, 12]
+    else:
+      properties:
+        renesas,miic-switch-portin:
+          const: 0
+      required:
+        - resets
+        - reset-names
+      patternProperties:
+        "^mii-conv@[0-5]$":
           properties:
             reg:
-              const: 4
-        then:
-          properties:
-            renesas,miic-input:
-              enum: [4, 6, 9, 13]
-      - if:
-          properties:
-            reg:
-              const: 5
-        then:
-          properties:
-            renesas,miic-input:
-              enum: [3, 5, 8, 12]
+              enum: [0, 1, 2, 3]
+          allOf:
+            - if:
+                properties:
+                  reg:
+                    const: 0
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [0, 3, 6]
+            - if:
+                properties:
+                  reg:
+                    const: 1
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [1, 4, 7]
+            - if:
+                properties:
+                  reg:
+                    const: 2
+              then:
+                properties:
+                  renesas,miic-input:
+                    enum: [2, 5, 8]
+            - if:
+                properties:
+                  reg:
+                    const: 3
+              then:
+                properties:
+                  renesas,miic-input:
+                    const: 1
 
 required:
   - '#address-cells'
diff --git a/include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h b/include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h
new file mode 100644
index 000000000000..43a2b5743a63
--- /dev/null
+++ b/include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corporation.
+ */
+
+#ifndef _DT_BINDINGS_RENASAS_R9A09G077_PCS_MIIC_H
+#define _DT_BINDINGS_RENASAS_R9A09G077_PCS_MIIC_H
+
+/*
+ * Media Interface Connection Matrix
+ * ===========================================================
+ *
+ * Selects the function of the Media interface of the MAC to be used
+ *
+ * SW_MODE[2:0] | Port 0      | Port 1      | Port 2      | Port 3
+ * -------------|-------------|-------------|-------------|-------------
+ * 000b         | ETHSW Port0 | ETHSW Port1 | ETHSW Port2 | GMAC1
+ * 001b         | ESC Port0   | ESC Port1   | GMAC2       | GMAC1
+ * 010b         | ESC Port0   | ESC Port1   | ETHSW Port2 | GMAC1
+ * 011b         | ESC Port0   | ESC Port1   | ESC Port2   | GMAC1
+ * 100b         | ETHSW Port0 | ESC Port1   | ESC Port2   | GMAC1
+ * 101b         | ETHSW Port0 | ESC Port1   | ETHSW Port2 | GMAC1
+ * 110b         | ETHSW Port0 | ETHSW Port1 | GMAC2       | GMAC1
+ * 111b         | GMAC0       | GMAC1       | GMAC2       | -
+ */
+#define ETHSS_GMAC0_PORT		0
+#define ETHSS_GMAC1_PORT		1
+#define ETHSS_GMAC2_PORT		2
+#define ETHSS_ESC_PORT0			3
+#define ETHSS_ESC_PORT1			4
+#define ETHSS_ESC_PORT2			5
+#define ETHSS_ETHSW_PORT0		6
+#define ETHSS_ETHSW_PORT1		7
+#define ETHSS_ETHSW_PORT2		8
+
+#endif
-- 
2.43.0


