Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A516CA0EF8
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15343.1755679641016086371
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: biKctgXYSO6U+SH3Eo9cOg==
X-CSE-MsgGUID: OTNiTB4MQJq46JiQyEKe9g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E4A8B40138ED;
	Wed, 20 Aug 2025 17:47:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/23] dt-bindings: memory: Document RZ/G3E support
Date: Wed, 20 Aug 2025 09:45:59 +0100
Message-ID: <20250820084645.6988-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19808

commit b2d25905366b4e6791f60e6bc76a636d1b88e6f8 upstream.

Document support for the Expanded Serial Peripheral Interface (xSPI)
Controller in the Renesas RZ/G3E (R9A09G047) SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250424090000.136804-2-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../renesas,rzg3e-xspi.yaml                   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
new file mode 100644
index 0000000000000..2bfe63ec62dcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/renesas,rzg3e-xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Expanded Serial Peripheral Interface (xSPI)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  Renesas xSPI allows a SPI flash connected to the SoC to be accessed via
+  the memory-mapping or the manual command mode.
+
+  The flash chip itself should be represented by a subnode of the XSPI node.
+  The flash interface is selected based on the "compatible" property of this
+  subnode:
+  -  "jedec,spi-nor";
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-xspi  # RZ/G3E
+
+  reg:
+    items:
+      - description: xSPI registers
+      - description: direct mapping area
+
+  reg-names:
+    items:
+      - const: regs
+      - const: dirmap
+
+  interrupts:
+    items:
+      - description: Interrupt pulse signal by factors excluding errors
+      - description: Interrupt pulse signal by error factors
+
+  interrupt-names:
+    items:
+      - const: pulse
+      - const: err_pulse
+
+  clocks:
+    items:
+      - description: AHB clock
+      - description: AXI clock
+      - description: SPI clock
+      - description: Double speed SPI clock
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: axi
+      - const: spi
+      - const: spix2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Hardware reset
+      - description: AXI reset
+
+  reset-names:
+    items:
+      - const: hresetn
+      - const: aresetn
+
+  renesas,xspi-cs-addr-sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the system controller (sys) that allows to configure
+      xSPI CS0 and CS1 addresses.
+
+patternProperties:
+  "flash@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: jedec,spi-nor
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+    spi@11030000 {
+        compatible = "renesas,r9a09g047-xspi";
+        reg = <0x11030000 0x10000>, <0x20000000 0x10000000>;
+        reg-names = "regs", "dirmap";
+        interrupts = <GIC_SPI 228 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 229 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "pulse", "err_pulse";
+        clocks = <&cpg CPG_MOD 0x9f>, <&cpg CPG_MOD 0xa0>,
+                 <&cpg CPG_CORE 9>, <&cpg CPG_MOD 0xa1>;
+        clock-names = "ahb", "axi", "spi", "spix2";
+        power-domains = <&cpg>;
+        resets = <&cpg 0xa3>, <&cpg 0xa4>;
+        reset-names = "hresetn", "aresetn";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "jedec,spi-nor";
+          reg = <0>;
+          spi-max-frequency = <40000000>;
+          spi-tx-bus-width = <1>;
+          spi-rx-bus-width = <1>;
+        };
+    };
-- 
2.43.0


