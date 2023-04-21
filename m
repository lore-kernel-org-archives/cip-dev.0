Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD7C77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6183.1682061521328276104
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156787065"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:48 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 779E841AA8A6;
	Fri, 21 Apr 2023 16:18:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 30/33] dt-bindings: pinctrl: Add DT bindings for Renesas RZ/V2M pinctrl
Date: Fri, 21 Apr 2023 08:17:26 +0100
Message-Id: <20230421071729.130347-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11303

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 34e3b69b1edc966f0f4dcdd880afba3a2dad8c09 upstream.

Add device tree binding documentation and header file for Renesas
RZ/V2M pinctrl.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220624084833.22605-2-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../pinctrl/renesas,rzv2m-pinctrl.yaml        | 170 ++++++++++++++++++
 include/dt-bindings/pinctrl/rzv2m-pinctrl.h   |  23 +++
 2 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/rzv2m-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
new file mode 100644
index 000000000000..eac6245db7dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/renesas,rzv2m-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M combined Pin and GPIO controller
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Phil Edworthy <phil.edworthy@renesas.com>
+
+description:
+  The Renesas RZ/V2M SoC features a combined Pin and GPIO controller.
+  Pin multiplexing and GPIO configuration is performed on a per-pin basis.
+  Each port features up to 16 pins, each of them configurable for GPIO function
+  (port mode) or in alternate function mode.
+  Up to 8 different alternate function modes exist for each single pin.
+
+properties:
+  compatible:
+    const: renesas,r9a09g011-pinctrl # RZ/V2M
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using the
+      RZV2M_GPIO() helper macro in <dt-bindings/pinctrl/rzv2m-pinctrl.h> and the
+      second cell represents consumer flag as mentioned in ../gpio/gpio.txt
+      E.g. "RZV2M_GPIO(8, 1)" for P8_1.
+
+  gpio-ranges:
+    maxItems: 1
+
+  interrupts:
+    description: INEXINT[0..38] corresponding to individual pin inputs.
+    maxItems: 39
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+additionalProperties:
+  anyOf:
+    - type: object
+      allOf:
+        - $ref: pincfg-node.yaml#
+        - $ref: pinmux-node.yaml#
+
+      description:
+        Pin controller client devices use pin configuration subnodes (children
+        and grandchildren) for desired pin configuration.
+        Client device subnodes use below standard properties.
+
+      properties:
+        phandle: true
+        pinmux:
+          description:
+            Values are constructed from GPIO port number, pin number, and
+            alternate function configuration number using the RZV2M_PORT_PINMUX()
+            helper macro in <dt-bindings/pinctrl/rzv2m-pinctrl.h>.
+        pins: true
+        bias-disable: true
+        bias-pull-down: true
+        bias-pull-up: true
+        drive-strength-microamp:
+          # Superset of supported values
+          enum: [ 1600, 1800, 2000, 3200, 3800, 4000, 6400, 7800, 8000,
+                  9000, 9600, 11000, 12000, 13000, 18000 ]
+        slew-rate:
+          description: 0 is slow slew rate, 1 is fast slew rate
+          enum: [ 0, 1 ]
+        gpio-hog: true
+        gpios: true
+        output-high: true
+        output-low: true
+        line-name: true
+
+    - type: object
+      properties:
+        phandle: true
+
+      additionalProperties:
+        $ref: "#/additionalProperties/anyOf/0"
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+  - interrupts
+  - clocks
+  - power-domains
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/rzv2m-pinctrl.h>
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pinctrl: pinctrl@b6250000 {
+            compatible = "renesas,r9a09g011-pinctrl";
+            reg = <0xb6250000 0x800>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl 0 0 352>;
+            interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD R9A09G011_PFC_PCLK>;
+            resets = <&cpg R9A09G011_PFC_PRESETN>;
+            power-domains = <&cpg>;
+
+            i2c2_pins: i2c2 {
+                    pinmux = <RZV2M_PORT_PINMUX(3, 8, 2)>, /* SDA */
+                             <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
+            };
+    };
diff --git a/include/dt-bindings/pinctrl/rzv2m-pinctrl.h b/include/dt-bindings/pinctrl/rzv2m-pinctrl.h
new file mode 100644
index 000000000000..525532cd15da
--- /dev/null
+++ b/include/dt-bindings/pinctrl/rzv2m-pinctrl.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/V2M pinctrl bindings.
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_RZV2M_PINCTRL_H
+#define __DT_BINDINGS_RZV2M_PINCTRL_H
+
+#define RZV2M_PINS_PER_PORT	16
+
+/*
+ * Create the pin index from its bank and position numbers and store in
+ * the upper 16 bits the alternate function identifier
+ */
+#define RZV2M_PORT_PINMUX(b, p, f)	((b) * RZV2M_PINS_PER_PORT + (p) | ((f) << 16))
+
+/* Convert a port and pin label to its global pin index */
+#define RZV2M_GPIO(port, pin)	((port) * RZV2M_PINS_PER_PORT + (pin))
+
+#endif /* __DT_BINDINGS_RZV2M_PINCTRL_H */
-- 
2.25.1


