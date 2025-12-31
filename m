Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73535EE645F
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: KouGZax0TbCu6TDLWmd7FA==
X-CSE-MsgGUID: 5iSamIvCQTecgIXWplymOw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:30 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6DF284023E88;
	Thu,  1 Jan 2026 02:00:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/17] dt-bindings: watchdog: renesas,wdt: Add support for RZ/T2H and RZ/N2H
Date: Wed, 31 Dec 2025 17:00:10 +0000
Message-ID: <20251231170026.17006-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21280

commit 5cacd26436a66e24b1f0335a5d2b71eed4ab0d74 upstream.

Extend the Renesas WDT device tree bindings to support the watchdog timer
found on the RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

The RZ/T2H WDT is mostly compatible with the one found on the RZ/V2H(P),
but includes an additional register and differs in the clock division
ratio settings for the WDTCR[CKS] field. To reflect these differences,
introduce a new compatible string, "renesas,r9a09g077-wdt".

The binding schema is updated accordingly. On RZ/T2H, the WDT does not
require the "resets" property. It also requires two register regions and
the presence of a "power-domains" property. The "clock-names" property is
limited to a single entry, "pclk", for this SoC.

The RZ/N2H SoC uses the same WDT IP as the RZ/T2H. It is supported by
using "renesas,r9a09g087-wdt" as the primary compatible string, with
"renesas,r9a09g077-wdt" listed as a fallback to describe the shared
hardware features.

Example:
    wdt0: watchdog@80082000 {
        compatible = "renesas,r9a09g077-wdt";
        reg = <0 0x80082000 0 0x400>,
              <0 0x81295100 0 0x04>;
        clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
        clock-names = "pclk";
        power-domains = <&cpg>;
        status = "disabled";
    };

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/watchdog/renesas,wdt.yaml        | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 78874b90c88c5..b6e60162c263c 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -81,10 +81,17 @@ properties:
               - renesas,r9a09g056-wdt # RZ/V2N
           - const: renesas,r9a09g057-wdt # RZ/V2H(P)
 
-      - const: renesas,r9a09g057-wdt       # RZ/V2H(P)
+      - enum:
+          - renesas,r9a09g057-wdt    # RZ/V2H(P)
+          - renesas,r9a09g077-wdt    # RZ/T2H
+
+      - items:
+          - const: renesas,r9a09g087-wdt # RZ/N2H
+          - const: renesas,r9a09g077-wdt # RZ/T2H
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     minItems: 1
@@ -132,6 +139,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - renesas,r9a09g077-wdt
                 - renesas,rza-wdt
                 - renesas,rzn1-wdt
     then:
@@ -183,7 +191,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a09g057-wdt
+            enum:
+              - renesas,r9a09g057-wdt
+              - renesas,r9a09g077-wdt
     then:
       properties:
         interrupts: false
@@ -192,6 +202,26 @@ allOf:
       required:
         - interrupts
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-wdt
+    then:
+      properties:
+        resets: false
+        clock-names:
+          maxItems: 1
+        reg:
+          minItems: 2
+      required:
+        - clock-names
+        - power-domains
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


