Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC2AFCC054
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: CUEvRb/xSz+8GRa+8giNjA==
X-CSE-MsgGUID: meXLRL9NTnmi8A9WmqngCQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:51 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E9C54031C01;
	Sat,  7 Mar 2026 02:18:49 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 15/17] spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
Date: Fri,  6 Mar 2026 19:17:33 +0200
Message-ID: <20260306171735.226034-16-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22140

commit e93d7b2d8b349f659fa9456048ee86e10eb422f9 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
peripherals.

Compared to the previously supported RZ/V2H, these SoCs have a smaller
FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
being the clock from which the SPI transfer clock is generated, is the
equivalent of the TCLK from V2H.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251119161434.595677-11-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 62 ++++++++++++++++---
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index ab27fefc3c3a..4331df3e3d47 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -9,12 +9,15 @@ title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
-    const: renesas,r9a09g057-rspi # RZ/V2H(P)
+    oneOf:
+      - enum:
+          - renesas,r9a09g057-rspi # RZ/V2H(P)
+          - renesas,r9a09g077-rspi # RZ/T2H
+      - items:
+          - const: renesas,r9a09g087-rspi # RZ/N2H
+          - const: renesas,r9a09g077-rspi # RZ/T2H
 
   reg:
     maxItems: 1
@@ -36,13 +39,12 @@ properties:
       - const: tx
 
   clocks:
+    minItems: 2
     maxItems: 3
 
   clock-names:
-    items:
-      - const: pclk
-      - const: pclk_sfr
-      - const: tclk
+    minItems: 2
+    maxItems: 3
 
   resets:
     maxItems: 2
@@ -62,12 +64,52 @@ required:
   - interrupt-names
   - clocks
   - clock-names
-  - resets
-  - reset-names
   - power-domains
   - '#address-cells'
   - '#size-cells'
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g057-rspi
+    then:
+      properties:
+        clocks:
+          minItems: 3
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: pclk_sfr
+            - const: tclk
+
+      required:
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g077-rspi
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: pclkspi
+
+        resets: false
+        reset-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

