Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EBBC7EE31
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34990.1685631875240749930
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816476"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:34 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8A6B040078AA;
	Fri,  2 Jun 2023 00:04:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 08/19] dt-bindings: usb: Add RZ/V2M USB3DRD binding
Date: Thu,  1 Jun 2023 16:03:59 +0100
Message-Id: <20230601150410.124773-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11738

commit 9486e56c49be7dc771ecae9bf67b1034cd440d10 upstream.

Add device tree bindings for the RZ/V2{M, MA} USB3DRD module.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230121145853.4792-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/usb/renesas,rzv2m-usb3drd.yaml   | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml b/Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml
new file mode 100644
index 000000000000..ff625600d9af
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,rzv2m-usb3drd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2M USB 3.1 DRD controller
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  The RZ/V2{M, MA} USB3.1 DRD module supports the following functions
+  * Role swapping function by the ID pin of the Micro-AB receptacle
+  * Battery Charging Specification Revision 1.2
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a09g011-usb3drd  # RZ/V2M
+          - renesas,r9a09g055-usb3drd  # RZ/V2MA
+      - const: renesas,rzv2m-usb3drd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Dual Role Device (DRD)
+      - description: Battery Charging
+      - description: Global Purpose Input
+
+  interrupt-names:
+    items:
+      - const: drd
+      - const: bc
+      - const: gpi
+
+  clocks:
+    items:
+      - description: Peripheral AXI clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: axi
+      - const: reg
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+patternProperties:
+  "^usb3peri@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/usb/renesas,usb3-peri.yaml
+
+  "^usb@[0-9a-f]+$":
+    type: object
+    $ref: renesas,usb-xhci.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a09g011-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb3drd: usb@85070400 {
+        compatible = "renesas,r9a09g011-usb3drd", "renesas,rzv2m-usb3drd";
+        reg = <0x85070400 0x100>;
+        interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "drd", "bc", "gpi";
+        clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_P>,
+                 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+        clock-names = "axi", "reg";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A09G011_USB_DRD_RESET>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        usb3host: usb@85060000 {
+           compatible = "renesas,r9a09g011-xhci",
+                        "renesas,rzv2m-xhci";
+           reg = <0x85060000 0x2000>;
+           interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+           clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_H>,
+                    <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+           clock-names = "axi", "reg";
+           power-domains = <&cpg>;
+           resets = <&cpg R9A09G011_USB_ARESETN_H>;
+        };
+
+        usb3peri: usb3peri@85070000 {
+           compatible = "renesas,r9a09g011-usb3-peri",
+                        "renesas,rzv2m-usb3-peri";
+           reg = <0x85070000 0x400>;
+           interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+           clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_P>,
+                    <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+           clock-names = "axi", "reg";
+           power-domains = <&cpg>;
+           resets = <&cpg R9A09G011_USB_ARESETN_P>;
+        };
+    };
-- 
2.25.1


