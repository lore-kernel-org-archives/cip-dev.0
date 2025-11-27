Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE0D116EA
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 11:30:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16539.1764243017745651992
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 03:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: WpVECnxSRsaXqfmLJMYf7A==
X-CSE-MsgGUID: JKVO5OwDRCCfh6vgPlX0MQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Nov 2025 20:30:17 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.131])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 030FC401109B;
	Thu, 27 Nov 2025 20:30:15 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/5] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
Date: Thu, 27 Nov 2025 11:30:08 +0000
Message-ID: <20251127113012.55325-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
References: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 11:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20750

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 22228b933ce2639d67168fd35423c1be196edab0 upstream.

Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
Renesas RZ/G2L family of SoCs, but there are some differences:
* It only uses one register area
* It only uses one clock
* It only uses one reset
* Instead of using MID/IRD it uses REQ No
* It is connected to the Interrupt Control Unit (ICU)

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250423143422.3747702-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[OP: Added "allOf:" section and adjusted "required:" list to match
mainline code]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 102 ++++++++++++++----
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index ca24cf48769f..52c247dc5fde 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -9,23 +9,24 @@ title: Renesas RZ/{G2L,G2UL,V2L} DMA Controller
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
-          - renesas,r9a07g054-dmac # RZ/V2L
-          - renesas,r9a08g045-dmac # RZ/G3S
-      - const: renesas,rz-dmac
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-dmac # RZ/G2{L,LC}
+              - renesas,r9a07g054-dmac # RZ/V2L
+              - renesas,r9a08g045-dmac # RZ/G3S
+          - const: renesas,rz-dmac
+
+      - const: renesas,r9a09g057-dmac # RZ/V2H(P)
 
   reg:
     items:
       - description: Control and channel register block
       - description: DMA extended resource selector block
+    minItems: 1
 
   interrupts:
     maxItems: 17
@@ -54,6 +55,7 @@ properties:
     items:
       - description: DMA main clock
       - description: DMA register access clock
+    minItems: 1
 
   clock-names:
     items:
@@ -63,10 +65,10 @@ properties:
   '#dma-cells':
     const: 1
     description:
-      The cell specifies the encoded MID/RID values of the DMAC port
-      connected to the DMA client and the slave channel configuration
-      parameters.
-      bits[0:9] - Specifies MID/RID value
+      The cell specifies the encoded MID/RID or the REQ No values of
+      the DMAC port connected to the DMA client and the slave channel
+      configuration parameters.
+      bits[0:9] - Specifies the MID/RID or the REQ No value
       bit[10] - Specifies DMA request high enable (HIEN)
       bit[11] - Specifies DMA request detection type (LVL)
       bits[12:14] - Specifies DMAACK output mode (AM)
@@ -82,24 +84,86 @@ properties:
     items:
       - description: Reset for DMA ARESETN reset terminal
       - description: Reset for DMA RST_ASYNC reset terminal
+    minItems: 1
 
   reset-names:
     items:
       - const: arst
       - const: rst_async
 
+  renesas,icu:
+    description:
+      It must contain the phandle to the ICU and the index of the DMAC as seen
+      from the ICU.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the ICU node.
+          - description:
+              The number of the DMAC as seen from the ICU, i.e. parameter k from
+              register ICU_DMkSELy. This may differ from the actual DMAC instance
+              number.
+
 required:
   - compatible
   - reg
   - interrupts
   - interrupt-names
-  - clocks
-  - clock-names
   - '#dma-cells'
   - dma-channels
-  - power-domains
-  - resets
-  - reset-names
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g043-dmac
+              - renesas,r9a07g044-dmac
+              - renesas,r9a07g054-dmac
+              - renesas,r9a08g045-dmac
+    then:
+      properties:
+        reg:
+          minItems: 2
+        clocks:
+          minItems: 2
+        resets:
+          minItems: 2
+
+        renesas,icu: false
+
+      required:
+        - clocks
+        - clock-names
+        - power-domains
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-dmac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          maxItems: 1
+        resets:
+          maxItems: 1
+
+        clock-names: false
+        reset-names: false
+
+      required:
+        - clocks
+        - power-domains
+        - renesas,icu
+        - resets
 
 additionalProperties: false
 
-- 
2.51.0


