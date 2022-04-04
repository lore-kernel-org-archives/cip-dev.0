Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2249EC38A2C
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34385.1649075759683192518
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115671992"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9C25F428553C;
	Mon,  4 Apr 2022 21:36:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/29] dt-bindings: watchdog: renesas,wdt: Add
 support for RZ/G2L
Date: Mon,  4 Apr 2022 13:35:33 +0100
Message-Id: <20220404123553.25851-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7972

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ab02a00c9e32a5eb1525689b990ad9d345f0832e upstream.

Describe the WDT hardware in the RZ/G2L series.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20211130195357.18626-2-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/watchdog/renesas,wdt.yaml        | 75 ++++++++++++++-----
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 6933005b52bd..74bca0b838df 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Wolfram Sang <wsa+renesas@sang-engineering.com>
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: "watchdog.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -22,6 +19,11 @@ properties:
               - renesas,r7s9210-wdt      # RZ/A2
           - const: renesas,rza-wdt       # RZ/A
 
+      - items:
+          - enum:
+              - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
+          - const: renesas,rzg2l-wdt     # RZ/G2L
+
       - items:
           - enum:
               - renesas,r8a7742-wdt      # RZ/G1H
@@ -55,11 +57,13 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
+  interrupts: true
 
-  clocks:
-    maxItems: 1
+  interrupt-names: true
+
+  clocks: true
+
+  clock-names: true
 
   power-domains:
     maxItems: 1
@@ -74,17 +78,52 @@ required:
   - reg
   - clocks
 
-if:
-  not:
-    properties:
-      compatible:
-        contains:
-          enum:
-            - renesas,rza-wdt
-then:
-  required:
-    - power-domains
-    - resets
+allOf:
+  - $ref: "watchdog.yaml#"
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,rza-wdt
+    then:
+      required:
+        - power-domains
+        - resets
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
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: wdt
+            - const: perrout
+        clocks:
+          items:
+            - description: Register access clock
+            - description: Main clock
+        clock-names:
+          items:
+            - const: pclk
+            - const: oscclk
+      required:
+        - clock-names
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        clocks:
+          maxItems: 1
 
 additionalProperties: false
 
-- 
2.17.1


