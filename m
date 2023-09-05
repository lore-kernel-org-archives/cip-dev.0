Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE60C83F2C
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:07:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.25928.1693930064776618412
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="178810926"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2023 01:07:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5DD00401CC90;
	Wed,  6 Sep 2023 01:07:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/20] dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
Date: Tue,  5 Sep 2023 17:07:18 +0100
Message-Id: <20230905160737.167877-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12943

commit b1a90f510230afa9483e38fccbf9e4274c92aa8c upstream.

The RZ/G2L MIPI DSI TX is embedded in the Renesas RZ/G2L family SoC's. It
can operate in DSI mode, with up to four data lanes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/display/bridge/renesas,dsi.yaml  | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
new file mode 100644
index 000000000000..131d5b63ec4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/renesas,dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L MIPI DSI Encoder
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This binding describes the MIPI DSI encoder embedded in the Renesas
+  RZ/G2L alike family of SoC's. The encoder can operate in DSI mode, with
+  up to four data lanes.
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-mipi-dsi # RZ/G2{L,LC}
+      - const: renesas,rzg2l-mipi-dsi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Sequence operation channel 0 interrupt
+      - description: Sequence operation channel 1 interrupt
+      - description: Video-Input operation channel 1 interrupt
+      - description: DSI Packet Receive interrupt
+      - description: DSI Fatal Error interrupt
+      - description: DSI D-PHY PPI interrupt
+      - description: Debug interrupt
+
+  interrupt-names:
+    items:
+      - const: seq0
+      - const: seq1
+      - const: vin1
+      - const: rcv
+      - const: ferr
+      - const: ppi
+      - const: debug
+
+  clocks:
+    items:
+      - description: DSI D-PHY PLL multiplied clock
+      - description: DSI D-PHY system clock
+      - description: DSI AXI bus clock
+      - description: DSI Register access clock
+      - description: DSI Video clock
+      - description: DSI D-PHY Escape mode transmit clock
+
+  clock-names:
+    items:
+      - const: pllclk
+      - const: sysclk
+      - const: aclk
+      - const: pclk
+      - const: vclk
+      - const: lpclk
+
+  resets:
+    items:
+      - description: MIPI_DSI_CMN_RSTB
+      - description: MIPI_DSI_ARESET_N
+      - description: MIPI_DSI_PRESET_N
+
+  reset-names:
+    items:
+      - const: rst
+      - const: arst
+      - const: prst
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Parallel input port
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: DSI output port
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                description: array of physical DSI data lane indexes.
+                minItems: 1
+                items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+
+            required:
+              - data-lanes
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dsi0: dsi@10850000 {
+        compatible = "renesas,r9a07g044-mipi-dsi", "renesas,rzg2l-mipi-dsi";
+        reg = <0x10850000 0x20000>;
+        interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "seq0", "seq1", "vin1", "rcv",
+                          "ferr", "ppi", "debug";
+        clocks = <&cpg CPG_MOD R9A07G044_MIPI_DSI_PLLCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_SYSCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_ACLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_PCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_VCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_LPCLK>;
+        clock-names = "pllclk", "sysclk", "aclk", "pclk", "vclk", "lpclk";
+        resets = <&cpg R9A07G044_MIPI_DSI_CMN_RSTB>,
+                 <&cpg R9A07G044_MIPI_DSI_ARESET_N>,
+                 <&cpg R9A07G044_MIPI_DSI_PRESET_N>;
+        reset-names = "rst", "arst", "prst";
+        power-domains = <&cpg>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dsi0_in: endpoint {
+                    remote-endpoint = <&du_out_dsi0>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                dsi0_out: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    remote-endpoint = <&adv7535_in>;
+                };
+            };
+        };
+    };
+...
-- 
2.25.1


