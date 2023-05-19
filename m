Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43699C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963151"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:19 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 68A05419E25B;
	Fri, 19 May 2023 17:21:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 07/23] dt-bindings: watchdog: renesas,wdt: Add r9a09g011 (RZ/V2M) support
Date: Fri, 19 May 2023 09:20:42 +0100
Message-Id: <20230519082058.109760-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11539

From: Phil Edworthy <phil.edworthy@renesas.com>

commit d59913b0a5b6b8c52c8fbceca910d4aedbbd4cf1 upstream.

Add the documentation for the r9a09g011 SoC, but in doing so also
reorganise the doc to make it easier to read.
Additionally, make the binding require an interrupt to be specified.
Whilst the driver does not need an interrupt, all of the SoCs that use
this binding actually provide one.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220823093233.8577-2-phil.edworthy@renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/watchdog/renesas,wdt.yaml        | 73 +++++++++++++------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index b06c4219b8b9..ba0769d8308d 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -26,6 +26,11 @@ properties:
               - renesas,r9a07g054-wdt    # RZ/V2L
           - const: renesas,rzg2l-wdt
 
+      - items:
+          - enum:
+              - renesas,r9a09g011-wdt    # RZ/V2M
+          - const: renesas,rzv2m-wdt     # RZ/V2M
+
       - items:
           - enum:
               - renesas,r8a7742-wdt      # RZ/G1H
@@ -59,13 +64,29 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
-
-  interrupt-names: true
-
-  clocks: true
-
-  clock-names: true
+  interrupts:
+    minItems: 1
+    items:
+      - description: Timeout
+      - description: Parity error
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: wdt
+      - const: perrout
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Register access clock
+      - description: Main clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pclk
+      - const: oscclk
 
   power-domains:
     maxItems: 1
@@ -78,6 +99,7 @@ properties:
 required:
   - compatible
   - reg
+  - interrupts
   - clocks
 
 allOf:
@@ -101,31 +123,38 @@ allOf:
           contains:
             enum:
               - renesas,rzg2l-wdt
+              - renesas,rzv2m-wdt
     then:
       properties:
-        interrupts:
-          maxItems: 2
-        interrupt-names:
-          items:
-            - const: wdt
-            - const: perrout
         clocks:
-          items:
-            - description: Register access clock
-            - description: Main clock
+          minItems: 2
         clock-names:
-          items:
-            - const: pclk
-            - const: oscclk
+          minItems: 2
       required:
         - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rzg2l-wdt
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+        interrupt-names:
+          minItems: 2
+      required:
         - interrupt-names
     else:
       properties:
         interrupts:
           maxItems: 1
-        clocks:
-          maxItems: 1
 
 additionalProperties: false
 
@@ -133,9 +162,11 @@ examples:
   - |
     #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
     #include <dt-bindings/power/r8a7795-sysc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     wdt0: watchdog@e6020000 {
             compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
             reg = <0xe6020000 0x0c>;
+            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&cpg CPG_MOD 402>;
             power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
             resets = <&cpg 402>;
-- 
2.25.1


