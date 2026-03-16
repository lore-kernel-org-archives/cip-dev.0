Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F1F506FD
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52447.1773673175962015446
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 3Cj3HxyLTwe4PihR3XLIrw==
X-CSE-MsgGUID: xOhGeL/CTNWEaPu2mxoiLw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:47 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 36BF941B7814;
	Mon, 16 Mar 2026 23:59:45 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/35] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/T2H and RZ/N2H SoCs
Date: Mon, 16 Mar 2026 14:58:54 +0000
Message-ID: <20260316145915.8580-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22409

commit d43ce98223496e68bf8f12b42325e39ea5ae7247 upstream.

Add device tree binding support for the Gigabit Ethernet MAC (GMAC) IP
on Renesas RZ/T2H and RZ/N2H SoCs. While these SoCs use the same
Synopsys DesignWare MAC version 5.20 as RZ/V2H, they are synthesized
with different hardware configurations.

Add new compatible strings "renesas,r9a09g077-gbeth" for RZ/T2H and
"renesas,r9a09g087-gbeth" for RZ/N2H, with the latter using RZ/T2H as
fallback since they share identical GMAC IP.

Update the schema to handle hardware differences between SoC variants.
RZ/T2H requires only 3 clocks compared to 7 on RZ/V2H, supports 8 RX/TX
queue pairs instead of 4, and needs 2 reset controls with reset-names
property versus a single unnamed reset. RZ/T2H also has the split header
feature enabled which is disabled on RZ/V2H.

Add support for an optional pcs-handle property to connect the GMAC to
the MIIC PCS converter on RZ/T2H. Use conditional schema validation to
enforce the correct clock, reset, and interrupt configurations per SoC
variant.

Extend the base snps,dwmac.yaml schema to accommodate the increased
interrupt count, supporting up to 19 interrupts and extending the
rx-queue and tx-queue interrupt name patterns to cover queues 0-7.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250908105901.3198975-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 178 ++++++++++++++----
 .../devicetree/bindings/net/snps,dwmac.yaml   |   9 +-
 2 files changed, 143 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index 23e39bcea96b..bd53ab300f50 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -17,63 +17,111 @@ select:
           - renesas,r9a09g047-gbeth
           - renesas,r9a09g056-gbeth
           - renesas,r9a09g057-gbeth
+          - renesas,r9a09g077-gbeth
+          - renesas,r9a09g087-gbeth
           - renesas,rzv2h-gbeth
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a09g047-gbeth # RZ/G3E
-          - renesas,r9a09g056-gbeth # RZ/V2N
-          - renesas,r9a09g057-gbeth # RZ/V2H(P)
-      - const: renesas,rzv2h-gbeth
-      - const: snps,dwmac-5.20
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a09g047-gbeth # RZ/G3E
+              - renesas,r9a09g056-gbeth # RZ/V2N
+              - renesas,r9a09g057-gbeth # RZ/V2H(P)
+          - const: renesas,rzv2h-gbeth
+          - const: snps,dwmac-5.20
+      - items:
+          - const: renesas,r9a09g077-gbeth # RZ/T2H
+          - const: snps,dwmac-5.20
+      - items:
+          - const: renesas,r9a09g087-gbeth # RZ/N2H
+          - const: renesas,r9a09g077-gbeth
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
 
   clocks:
-    items:
-      - description: CSR clock
-      - description: AXI system clock
-      - description: PTP clock
-      - description: TX clock
-      - description: RX clock
-      - description: TX clock phase-shifted by 180 degrees
-      - description: RX clock phase-shifted by 180 degrees
+    oneOf:
+      - items:
+          - description: CSR clock
+          - description: AXI system clock
+          - description: PTP clock
+          - description: TX clock
+          - description: RX clock
+          - description: TX clock phase-shifted by 180 degrees
+          - description: RX clock phase-shifted by 180 degrees
+      - items:
+          - description: CSR clock
+          - description: AXI system clock
+          - description: TX clock
 
   clock-names:
-    items:
-      - const: stmmaceth
-      - const: pclk
-      - const: ptp_ref
-      - const: tx
-      - const: rx
-      - const: tx-180
-      - const: rx-180
-
-  interrupts:
-    minItems: 11
+    oneOf:
+      - items:
+          - const: stmmaceth
+          - const: pclk
+          - const: ptp_ref
+          - const: tx
+          - const: rx
+          - const: tx-180
+          - const: rx-180
+      - items:
+          - const: stmmaceth
+          - const: pclk
+          - const: tx
 
   interrupt-names:
-    items:
-      - const: macirq
-      - const: eth_wake_irq
-      - const: eth_lpi
-      - const: rx-queue-0
-      - const: rx-queue-1
-      - const: rx-queue-2
-      - const: rx-queue-3
-      - const: tx-queue-0
-      - const: tx-queue-1
-      - const: tx-queue-2
-      - const: tx-queue-3
+    oneOf:
+      - items:
+          - const: macirq
+          - const: eth_wake_irq
+          - const: eth_lpi
+          - const: rx-queue-0
+          - const: rx-queue-1
+          - const: rx-queue-2
+          - const: rx-queue-3
+          - const: tx-queue-0
+          - const: tx-queue-1
+          - const: tx-queue-2
+          - const: tx-queue-3
+      - items:
+          - const: macirq
+          - const: eth_wake_irq
+          - const: eth_lpi
+          - const: rx-queue-0
+          - const: rx-queue-1
+          - const: rx-queue-2
+          - const: rx-queue-3
+          - const: rx-queue-4
+          - const: rx-queue-5
+          - const: rx-queue-6
+          - const: rx-queue-7
+          - const: tx-queue-0
+          - const: tx-queue-1
+          - const: tx-queue-2
+          - const: tx-queue-3
+          - const: tx-queue-4
+          - const: tx-queue-5
+          - const: tx-queue-6
+          - const: tx-queue-7
 
   resets:
-    items:
-      - description: AXI power-on system reset
+    oneOf:
+      - items:
+          - description: AXI power-on system reset
+      - items:
+          - description: AXI power-on system reset
+          - description: AHB reset
+
+  pcs-handle:
+    description:
+      phandle pointing to a PCS sub-node compatible with
+      Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml#
+      (Refer RZ/T2H portion in the DT-binding file)
 
 required:
   - compatible
@@ -87,6 +135,56 @@ required:
 allOf:
   - $ref: snps,dwmac.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-gbeth
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+
+        clock-names:
+          maxItems: 3
+
+        interrupts:
+          minItems: 19
+
+        interrupt-names:
+          minItems: 19
+
+        resets:
+          minItems: 2
+
+        reset-names:
+          minItems: 2
+
+      required:
+        - reset-names
+    else:
+      properties:
+        clocks:
+          minItems: 7
+
+        clock-names:
+          minItems: 7
+
+        interrupts:
+          minItems: 11
+          maxItems: 11
+
+        interrupt-names:
+          minItems: 11
+          maxItems: 11
+
+        resets:
+          maxItems: 1
+
+        pcs-handle: false
+
+        reset-names: false
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 073b9dcc7c9e..68f8da626d47 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -71,6 +71,7 @@ properties:
         - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
+        - renesas,r9a09g077-gbeth
         - renesas,rzn1-gmac
         - renesas,rzv2h-gbeth
         - rockchip,px30-gmac
@@ -107,11 +108,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 11
+    maxItems: 19
 
   interrupt-names:
     minItems: 1
-    maxItems: 11
+    maxItems: 19
     items:
       oneOf:
         - description: Combined signal for various interrupt events
@@ -123,9 +124,9 @@ properties:
         - description: The interrupt that occurs when HW safety error triggered
           const: sfty
         - description: Per channel receive completion interrupt
-          pattern: '^rx-queue-[0-3]$'
+          pattern: '^rx-queue-[0-7]$'
         - description: Per channel transmit completion interrupt
-          pattern: '^tx-queue-[0-3]$'
+          pattern: '^tx-queue-[0-7]$'
 
   clocks:
     minItems: 1
-- 
2.43.0


