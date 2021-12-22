Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9463BC433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.19377.1640181005005583785
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:12 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366647"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:50:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07959430FFE7;
	Wed, 22 Dec 2021 22:50:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/21] dt-bindings: can: rcar_canfd: Convert to
 json-schema
Date: Wed, 22 Dec 2021 13:49:44 +0000
Message-Id: <20211222134951.19432-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7248

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8a5e7d19c8c747e3e7bfa0283a54742b103afcb5 upstream.

Convert the Renesas R-Car CAN FD Controller Device Tree binding
documentation to json-schema.

Document missing properties.
The CANFD clock needs to be configured for the maximum frequency on
R-Car V3M and V3H, too.
Update the example to match reality.

Link: https://lore.kernel.org/r/905134c87f72e2d8e37c309e0ce28ecd7d4f3992.1620323639.git.geert+renesas@glider.be
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/can/rcar_canfd.txt           | 107 ---------------
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 122 ++++++++++++++++++
 2 files changed, 122 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/rcar_canfd.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
deleted file mode 100644
index 248c4ed97a0a..000000000000
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ /dev/null
@@ -1,107 +0,0 @@
-Renesas R-Car CAN FD controller Device Tree Bindings
-----------------------------------------------------
-
-Required properties:
-- compatible: Must contain one or more of the following:
-  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
-  - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
-  - "renesas,r8a774b1-canfd" for R8A774B1 (RZ/G2N) compatible controller.
-  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
-  - "renesas,r8a774e1-canfd" for R8A774E1 (RZ/G2H) compatible controller.
-  - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
-  - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
-  - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible controller.
-  - "renesas,r8a77970-canfd" for R8A77970 (R-Car V3M) compatible controller.
-  - "renesas,r8a77980-canfd" for R8A77980 (R-Car V3H) compatible controller.
-  - "renesas,r8a77990-canfd" for R8A77990 (R-Car E3) compatible controller.
-  - "renesas,r8a77995-canfd" for R8A77995 (R-Car D3) compatible controller.
-
-  When compatible with the generic version, nodes must list the
-  SoC-specific version corresponding to the platform first, followed by the
-  family-specific and/or generic versions.
-
-- reg: physical base address and size of the R-Car CAN FD register map.
-- interrupts: interrupt specifiers for the Channel & Global interrupts
-- clocks: phandles and clock specifiers for 3 clock inputs.
-- clock-names: 3 clock input name strings: "fck", "canfd", "can_clk".
-- pinctrl-0: pin control group to be used for this controller.
-- pinctrl-names: must be "default".
-
-Required child nodes:
-The controller supports two channels and each is represented as a child node.
-The name of the child nodes are "channel0" and "channel1" respectively. Each
-child node supports the "status" property only, which is used to
-enable/disable the respective channel.
-
-Required properties for R8A774A1, R8A774B1, R8A774C0, R8A774E1, R8A7795,
-R8A7796, R8A77965, R8A77990, and R8A77995:
-In the denoted SoCs, canfd clock is a div6 clock and can be used by both CAN
-and CAN FD controller at the same time. It needs to be scaled to maximum
-frequency if any of these controllers use it. This is done using the below
-properties:
-
-- assigned-clocks: phandle of canfd clock.
-- assigned-clock-rates: maximum frequency of this clock.
-
-Optional property:
-The controller can operate in either CAN FD only mode (default) or
-Classical CAN only mode. The mode is global to both the channels. In order to
-enable the later, define the following optional property.
- - renesas,no-can-fd: puts the controller in Classical CAN only mode.
-
-Example
--------
-
-SoC common .dtsi file:
-
-		canfd: can@e66c0000 {
-			compatible = "renesas,r8a7795-canfd",
-				     "renesas,rcar-gen3-canfd";
-			reg = <0 0xe66c0000 0 0x8000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 914>,
-			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "fck", "canfd", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&cpg>;
-			status = "disabled";
-
-			channel0 {
-				status = "disabled";
-			};
-
-			channel1 {
-				status = "disabled";
-			};
-		};
-
-Board specific .dts file:
-
-E.g. below enables Channel 1 alone in the board in Classical CAN only mode.
-
-&canfd {
-	pinctrl-0 = <&canfd1_pins>;
-	pinctrl-names = "default";
-	renesas,no-can-fd;
-	status = "okay";
-
-	channel1 {
-		status = "okay";
-	};
-};
-
-E.g. below enables Channel 0 alone in the board using External clock
-as fCAN clock.
-
-&canfd {
-	pinctrl-0 = <&canfd0_pins>, <&can_clk_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	channel0 {
-		status = "okay";
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
new file mode 100644
index 000000000000..0b33ba9ccb47
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/renesas,rcar-canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car CAN FD Controller
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r8a774a1-canfd     # RZ/G2M
+              - renesas,r8a774b1-canfd     # RZ/G2N
+              - renesas,r8a774c0-canfd     # RZ/G2E
+              - renesas,r8a774e1-canfd     # RZ/G2H
+              - renesas,r8a7795-canfd      # R-Car H3
+              - renesas,r8a7796-canfd      # R-Car M3-W
+              - renesas,r8a77965-canfd     # R-Car M3-N
+              - renesas,r8a77970-canfd     # R-Car V3M
+              - renesas,r8a77980-canfd     # R-Car V3H
+              - renesas,r8a77990-canfd     # R-Car E3
+              - renesas,r8a77995-canfd     # R-Car D3
+          - const: renesas,rcar-gen3-canfd # R-Car Gen3 and RZ/G2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Channel interrupt
+      - description: Global interrupt
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: fck
+      - const: canfd
+      - const: can_clk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  renesas,no-can-fd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The controller can operate in either CAN FD only mode (default) or
+      Classical CAN only mode.  The mode is global to both the channels.
+      Specify this property to put the controller in Classical CAN only mode.
+
+  assigned-clocks:
+    description:
+      Reference to the CANFD clock.  The CANFD clock is a div6 clock and can be
+      used by both CAN (if present) and CAN FD controllers at the same time.
+      It needs to be scaled to maximum frequency if any of these controllers
+      use it.
+
+  assigned-clock-rates:
+    description: Maximum frequency of the CANFD clock.
+
+patternProperties:
+  "^channel[01]$":
+    type: object
+    description:
+      The controller supports two channels and each is represented as a child
+      node.  Each child node supports the "status" property only, which
+      is used to enable/disable the respective channel.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - assigned-clocks
+  - assigned-clock-rates
+  - channel0
+  - channel1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7795-sysc.h>
+
+    canfd: can@e66c0000 {
+            compatible = "renesas,r8a7795-canfd",
+                         "renesas,rcar-gen3-canfd";
+            reg = <0xe66c0000 0x8000>;
+            interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD 914>,
+                     <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+                     <&can_clk>;
+            clock-names = "fck", "canfd", "can_clk";
+            assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+            assigned-clock-rates = <40000000>;
+            power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+            resets = <&cpg 914>;
+
+            channel0 {
+            };
+
+            channel1 {
+            };
+    };
-- 
2.17.1


