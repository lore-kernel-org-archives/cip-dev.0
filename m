Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B97EEB563
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:43 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88807.1767200439989639331
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: AEhbfBC0SyiY/9LxvMmXlA==
X-CSE-MsgGUID: Kgevz1oGTSC/FgNqbc39OA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:39 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 21F85402412E;
	Thu,  1 Jan 2026 02:00:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/17] dt-bindings: mmc: renesas,sdhi: Document RZ/T2H and RZ/N2H support
Date: Wed, 31 Dec 2025 17:00:15 +0000
Message-ID: <20251231170026.17006-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21285

commit b93d8b1cab299bc76f574f9e3cb8aafcfafc0037 upstream.

Add SDHI bindings for the Renesas RZ/T2H (a.k.a R9A09G077) and RZ/N2H
(a.k.a R9A09G087) SoCs. Use `renesas,sdhi-r9a09g057` as a fallback since
the SD/MMC block on these SoCs is identical to the one on RZ/V2H(P),
allowing reuse of the existing driver without modifications.

Update the binding schema to reflect differences: unlike RZ/V2H(P),
RZ/T2H and RZ/N2H do not require the `resets` property and use only a
two clocks instead of four.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250617164914.158091-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 85 ++++++++++++-------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 7563623876fc0..ba15ccbda61ab 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -72,6 +72,8 @@ properties:
           - enum:
               - renesas,sdhi-r9a09g047 # RZ/G3E
               - renesas,sdhi-r9a09g056 # RZ/V2N
+              - renesas,sdhi-r9a09g077 # RZ/T2H
+              - renesas,sdhi-r9a09g087 # RZ/N2H
           - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
 
   reg:
@@ -129,59 +131,78 @@ allOf:
         compatible:
           contains:
             enum:
-              - renesas,sdhi-r9a09g057
-              - renesas,rzg2l-sdhi
+              - renesas,sdhi-r9a09g077
+              - renesas,sdhi-r9a09g087
     then:
       properties:
+        resets: false
         clocks:
           items:
-            - description: IMCLK, SDHI channel main clock1.
-            - description: CLK_HS, SDHI channel High speed clock which operates
-                           4 times that of SDHI channel main clock1.
-            - description: IMCLK2, SDHI channel main clock2. When this clock is
-                           turned off, external SD card detection cannot be
-                           detected.
-            - description: ACLK, SDHI channel bus clock.
+            - description: ACLK, IMCLK, SDHI channel bus and main clocks.
+            - description: CLK_HS, SDHI channel High speed clock.
         clock-names:
           items:
-            - const: core
-            - const: clkh
-            - const: cd
             - const: aclk
-      required:
-        - clock-names
-        - resets
+            - const: clkh
     else:
       if:
         properties:
           compatible:
             contains:
               enum:
-                - renesas,rcar-gen2-sdhi
-                - renesas,rcar-gen3-sdhi
-                - renesas,rcar-gen4-sdhi
+                - renesas,sdhi-r9a09g057
+                - renesas,rzg2l-sdhi
       then:
         properties:
           clocks:
-            minItems: 1
-            maxItems: 3
-          clock-names:
-            minItems: 1
-            uniqueItems: true
             items:
-              - const: core
-              - enum: [ clkh, cd ]
-              - const: cd
-      else:
-        properties:
-          clocks:
-            minItems: 1
-            maxItems: 2
+              - description: IMCLK, SDHI channel main clock1.
+              - description: CLK_HS, SDHI channel High speed clock which operates
+                             4 times that of SDHI channel main clock1.
+              - description: IMCLK2, SDHI channel main clock2. When this clock is
+                             turned off, external SD card detection cannot be
+                             detected.
+              - description: ACLK, SDHI channel bus clock.
           clock-names:
-            minItems: 1
             items:
               - const: core
+              - const: clkh
               - const: cd
+              - const: aclk
+        required:
+          - clock-names
+          - resets
+      else:
+        if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - renesas,rcar-gen2-sdhi
+                  - renesas,rcar-gen3-sdhi
+                  - renesas,rcar-gen4-sdhi
+        then:
+          properties:
+            clocks:
+              minItems: 1
+              maxItems: 3
+            clock-names:
+              minItems: 1
+              uniqueItems: true
+              items:
+                - const: core
+                - enum: [ clkh, cd ]
+                - const: cd
+        else:
+          properties:
+            clocks:
+              minItems: 1
+              maxItems: 2
+            clock-names:
+              minItems: 1
+              items:
+                - const: core
+                - const: cd
 
   - if:
       properties:
-- 
2.43.0


