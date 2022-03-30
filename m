Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2680C433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="115208970"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A0C7F40D4D0B;
	Thu, 31 Mar 2022 03:55:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 34/39] dt-bindings: mmc: renesas,sdhi: Document
 RZ/G2L bindings
Date: Wed, 30 Mar 2022 19:54:49 +0100
Message-Id: <20220330185454.10887-35-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7885

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bfadee4554c3782bfbc5943866bd2ad44d631e50 upstream.

Document RZ/G2L SDHI controller bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210817090313.31858-3-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 71 +++++++++++++------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 16050b29bc89..77b1bb907497 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -44,18 +44,19 @@ properties:
           - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
       - items:
           - enum:
-              - renesas,sdhi-r8a774a1 # RZ/G2M
-              - renesas,sdhi-r8a774b1 # RZ/G2N
-              - renesas,sdhi-r8a774c0 # RZ/G2E
-              - renesas,sdhi-r8a774e1 # RZ/G2H
-              - renesas,sdhi-r8a7795  # R-Car H3
-              - renesas,sdhi-r8a7796  # R-Car M3-W
-              - renesas,sdhi-r8a77961 # R-Car M3-W+
-              - renesas,sdhi-r8a77965 # R-Car M3-N
-              - renesas,sdhi-r8a77970 # R-Car V3M
-              - renesas,sdhi-r8a77980 # R-Car V3H
-              - renesas,sdhi-r8a77990 # R-Car E3
-              - renesas,sdhi-r8a77995 # R-Car D3
+              - renesas,sdhi-r8a774a1  # RZ/G2M
+              - renesas,sdhi-r8a774b1  # RZ/G2N
+              - renesas,sdhi-r8a774c0  # RZ/G2E
+              - renesas,sdhi-r8a774e1  # RZ/G2H
+              - renesas,sdhi-r8a7795   # R-Car H3
+              - renesas,sdhi-r8a7796   # R-Car M3-W
+              - renesas,sdhi-r8a77961  # R-Car M3-W+
+              - renesas,sdhi-r8a77965  # R-Car M3-N
+              - renesas,sdhi-r8a77970  # R-Car V3M
+              - renesas,sdhi-r8a77980  # R-Car V3H
+              - renesas,sdhi-r8a77990  # R-Car E3
+              - renesas,sdhi-r8a77995  # R-Car D3
+              - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
 
   reg:
@@ -65,15 +66,9 @@ properties:
     minItems: 1
     maxItems: 3
 
-  clocks:
-    minItems: 1
-    maxItems: 2
+  clocks: true
 
-  clock-names:
-    minItems: 1
-    items:
-      - const: core
-      - const: cd
+  clock-names: true
 
   dmas:
     minItems: 4
@@ -107,6 +102,42 @@ properties:
 allOf:
   - $ref: "mmc-controller.yaml"
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,sdhi-r9a07g044
+    then:
+      properties:
+        clocks:
+          items:
+            - description: IMCLK, SDHI channel main clock1.
+            - description: IMCLK2, SDHI channel main clock2. When this clock is
+                           turned off, external SD card detection cannot be
+                           detected.
+            - description: CLK_HS, SDHI channel High speed clock which operates
+                           4 times that of SDHI channel main clock1.
+            - description: ACLK, SDHI channel bus clock.
+        clock-names:
+          items:
+            - const: imclk
+            - const: imclk2
+            - const: clk_hs
+            - const: aclk
+      required:
+        - clock-names
+        - resets
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+        clock-names:
+          minItems: 1
+          items:
+            - const: core
+            - const: cd
+
   - if:
       properties:
         compatible:
-- 
2.17.1


