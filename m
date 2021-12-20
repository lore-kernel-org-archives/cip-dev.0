Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F94AC433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:31:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.5175.1640007108515707926
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:31:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104110960"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 22:31:52 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0199F4005E10;
	Mon, 20 Dec 2021 22:31:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/22] dt-bindings: i2c: renesas,riic: Convert to
 json-schema
Date: Mon, 20 Dec 2021 13:31:26 +0000
Message-Id: <20211220133139.21624-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:31:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7206

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 92b7716f4c54cb61b30e4680ea436a9e0cc6f4de upstream.

Convert the Renesas RZ/A I2C Bus Interface (RIIC) Device Tree binding
documentation to json-schema.

Document missing properties.
Update the example to match reality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.txt  | 32 --------
 .../devicetree/bindings/i2c/renesas,riic.yaml | 82 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 83 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/renesas,riic.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,riic.yaml

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.txt b/Documentation/devicetree/bindings/i2c/renesas,riic.txt
deleted file mode 100644
index e26fe3ad86a9..000000000000
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Device tree configuration for Renesas RIIC driver
-
-Required properties:
-- compatible      :
-	"renesas,riic-r7s72100" if the device is a part of a R7S72100 SoC.
-	"renesas,riic-r7s9210" if the device is a part of a R7S9210 SoC.
-	"renesas,riic-rz" for a generic RZ/A compatible device.
-- reg             : address start and address range size of device
-- interrupts      : 8 interrupts (TEI, RI, TI, SPI, STI, NAKI, ALI, TMOI)
-- clock-frequency : frequency of bus clock in Hz
-- #address-cells  : should be <1>
-- #size-cells     : should be <0>
-
-Pinctrl properties might be needed, too. See there.
-
-Example:
-
-	i2c0: i2c@fcfee000 {
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee000 0x44>;
-		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 158 IRQ_TYPE_EDGE_RISING>,
-			     <0 159 IRQ_TYPE_EDGE_RISING>,
-			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
-		clock-frequency = <100000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
new file mode 100644
index 000000000000..2d6378164958
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/renesas,riic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/A I2C Bus Interface (RIIC)
+
+maintainers:
+  - Chris Brandt <chris.brandt@renesas.com>
+  - Wolfram Sang <wsa+renesas@sang-engineering.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,riic-r7s72100 # RZ/A1H
+          - renesas,riic-r7s9210  # RZ/A2M
+      - const: renesas,riic-rz    # RZ/A
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Transmit End Interrupt (TEI)
+      - description: Receive Data Full Interrupt (RI)
+      - description: Transmit Data Empty Interrupt (TI)
+      - description: Stop Condition Detection Interrupt (SPI)
+      - description: Start Condition Detection Interrupt (STI)
+      - description: NACK Reception Interrupt (NAKI)
+      - description: Arbitration-Lost Interrupt (ALI)
+      - description: Timeout Interrupt (TMOI)
+
+  clock-frequency:
+    description:
+      Desired I2C bus clock frequency in Hz. The absence of this property
+      indicates the default frequency 100 kHz.
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-frequency
+  - power-domains
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r7s72100-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2c0: i2c@fcfee000 {
+            compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+            reg = <0xfcfee000 0x44>;
+            interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
+            clock-frequency = <100000>;
+            power-domains = <&cpg_clocks>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4fef10dd2975..591b401f4fbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14932,7 +14932,7 @@ F:	drivers/thermal/rcar_thermal.c
 RENESAS RIIC DRIVER
 M:	Chris Brandt <chris.brandt@renesas.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/i2c/renesas,riic.txt
+F:	Documentation/devicetree/bindings/i2c/renesas,riic.yaml
 F:	drivers/i2c/busses/i2c-riic.c
 
 RENESAS USB PHY DRIVER
-- 
2.17.1


