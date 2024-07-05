Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D60C3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 12:52:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.16471.1720183957853784969
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 05:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="210416226"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2024 21:52:37 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9147844B8E96;
	Fri,  5 Jul 2024 21:52:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/10] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts
Date: Fri,  5 Jul 2024 13:52:22 +0100
Message-Id: <20240705125230.125392-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 12:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16397

commit 392703b6a18bbecbb2ae652619a705454f0fa0d6 upstream.

All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
supported by the IRQC block, reflect the same in DT binding doc.

- R9A07G043U              - RZ/G2UL
- R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
- R9A07G054               - RZ/V2L
- R9A08G045               - RZ/G3S

For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into single
interrupt so we just use the below to represent them:
- ec7tie1-0
- ec7tie2-0
- ec7tiovf-0

Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
support these interrupts. Therefore, mark the 'interrupt-names' property
as required for all the SoCs and update the example node in the binding
document.

Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index d3b5aec0a3f74..daef4ee06f4ed 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -44,7 +44,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    minItems: 41
+    minItems: 45
     items:
       - description: NMI interrupt
       - description: IRQ0 interrupt
@@ -88,9 +88,15 @@ properties:
       - description: GPIO interrupt, TINT30
       - description: GPIO interrupt, TINT31
       - description: Bus error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 1bit error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 2bit error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 error overflow interrupt
+      - description: ECCRAM1 1bit error interrupt
+      - description: ECCRAM1 2bit error interrupt
+      - description: ECCRAM1 error overflow interrupt
 
   interrupt-names:
-    minItems: 41
+    minItems: 45
     items:
       - const: nmi
       - const: irq0
@@ -134,6 +140,12 @@ properties:
       - const: tint30
       - const: tint31
       - const: bus-err
+      - const: ec7tie1-0
+      - const: ec7tie2-0
+      - const: ec7tiovf-0
+      - const: ec7tie1-1
+      - const: ec7tie2-1
+      - const: ec7tiovf-1
 
   clocks:
     maxItems: 2
@@ -156,6 +168,7 @@ required:
   - interrupt-controller
   - reg
   - interrupts
+  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -169,16 +182,19 @@ allOf:
         compatible:
           contains:
             enum:
-              - renesas,r9a07g043u-irqc
               - renesas,r9a08g045-irqc
     then:
       properties:
         interrupts:
-          minItems: 42
+          maxItems: 45
         interrupt-names:
-          minItems: 42
-      required:
-        - interrupt-names
+          maxItems: 45
+    else:
+      properties:
+        interrupts:
+          minItems: 48
+        interrupt-names:
+          minItems: 48
 
 unevaluatedProperties: false
 
@@ -233,7 +249,14 @@ examples:
                      <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
         interrupt-names = "nmi",
                           "irq0", "irq1", "irq2", "irq3",
                           "irq4", "irq5", "irq6", "irq7",
@@ -244,7 +267,10 @@ examples:
                           "tint16", "tint17", "tint18", "tint19",
                           "tint20", "tint21", "tint22", "tint23",
                           "tint24", "tint25", "tint26", "tint27",
-                          "tint28", "tint29", "tint30", "tint31";
+                          "tint28", "tint29", "tint30", "tint31",
+                          "bus-err", "ec7tie1-0", "ec7tie2-0",
+                          "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+                          "ec7tiovf-1";
         clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
                  <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
         clock-names = "clk", "pclk";
-- 
2.34.1


