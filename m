Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22BFCB625
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:00:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73799.1772816410427106806
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:00:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: /7UgxAKNRN6gnXDfixLSaA==
X-CSE-MsgGUID: Il+3FdR5RQSPcGNRe+6qng==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:00:09 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 44CEC400BC0F;
	Sat,  7 Mar 2026 02:00:07 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/17] spi: dt-bindings: Document the RZ/V2H(P) RSPI
Date: Fri,  6 Mar 2026 18:59:02 +0200
Message-ID: <20260306165918.209377-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:00:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22107

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 44b91d61c505863b8ae90b7094aee5ca0dce808f upstream.

Add dt-bindings for the RSPI IP found inside the Renesas RZ/V2H(P)
SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Link: https://patch.msgid.link/20250704162036.468765-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
new file mode 100644
index 000000000000..ab27fefc3c3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,rzv2h-rspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-rspi # RZ/V2H(P)
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Idle Interrupt
+      - description: Error Interrupt
+      - description: Communication End Interrupt
+      - description: Receive Buffer Full Interrupt
+      - description: Transmit Buffer Empty Interrupt
+
+  interrupt-names:
+    items:
+      - const: idle
+      - const: error
+      - const: end
+      - const: rx
+      - const: tx
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: pclk_sfr
+      - const: tclk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
+
+  power-domains:
+    maxItems: 1
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
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+    spi@12800800 {
+        compatible = "renesas,r9a09g057-rspi";
+
+        reg = <0x12800800 0x400>;
+        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 504 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 505 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "idle", "error", "end", "rx", "tx";
+        clocks = <&cpg CPG_MOD 0x5a>,
+                 <&cpg CPG_MOD 0x5b>,
+                 <&cpg CPG_MOD 0x5c>;
+        clock-names = "pclk", "pclk_sfr", "tclk";
+        resets = <&cpg 0x7f>, <&cpg 0x80>;
+        reset-names = "presetn", "tresetn";
+        power-domains = <&cpg>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.53.0


