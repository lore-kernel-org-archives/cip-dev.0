Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D904BC433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31207.1643631563602998327
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906320"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:34 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A59D04347FCA;
	Mon, 31 Jan 2022 21:19:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/27] dt-bindings: serial: renesas,sci: Document
 RZ/G2L SoC
Date: Mon, 31 Jan 2022 12:18:58 +0000
Message-Id: <20220131121903.8620-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7543

commit e1c0fc101340716fc1786b89f627425ecc6e5420 upstream.

Add SCI binding documentation for Renesas RZ/G2L SoC.

Also update the example node with RZ/G2L SCI0 node.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211110232920.19198-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/serial/renesas,sci.yaml          | 46 ++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
index 22ed2f0b1dc3..f00b1d38e9a5 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
@@ -14,7 +14,14 @@ allOf:
 
 properties:
   compatible:
-    const: renesas,sci
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-sci     # RZ/G2{L,LC}
+          - const: renesas,sci            # generic SCI compatible UART
+
+      - items:
+          - const: renesas,sci            # generic SCI compatible UART
 
   reg:
     maxItems: 1
@@ -54,18 +61,45 @@ required:
   - clocks
   - clock-names
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r9a07g044-sci
+then:
+  properties:
+    resets:
+      maxItems: 1
+
+    power-domains:
+      maxItems: 1
+
+  required:
+    - resets
+    - power-domains
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     aliases {
             serial0 = &sci0;
     };
 
-    sci0: serial@ffff78 {
-            compatible = "renesas,sci";
-            reg = <0xffff78 8>;
-            interrupts = <88 0>, <89 0>, <90 0>, <91 0>;
-            clocks = <&fclk>;
+    sci0: serial@1004d000 {
+            compatible = "renesas,r9a07g044-sci", "renesas,sci";
+            reg = <0x1004d000 0x400>;
+            interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "eri", "rxi", "txi", "tei";
+            clocks = <&cpg CPG_MOD R9A07G044_SCI0_CLKP>;
             clock-names = "fck";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_SCI0_RST>;
     };
-- 
2.17.1


