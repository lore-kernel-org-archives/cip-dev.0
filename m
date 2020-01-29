From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:29:55 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 02/12] dt-bindings: watchdog: Rename
	bindings documentation file
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 3265c3d8f70f0cb98dc7a7a3865200a7b19f654b upstream.

For consistency with the naming of (most) other documentation files for DT
bindings for Renesas IP blocks rename the Renesas WDT documentation file
from renesas-wdt.txt to renesas,wdt.txt.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
(dropped compatible strings which didnt exist)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/watchdog/renesas,wdt.txt   | 45 ++++++++++++++++++++++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   | 45 ----------------------
 2 files changed, 45 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
new file mode 100644
index 0000000..2c0b03a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
@@ -0,0 +1,45 @@
+Renesas Watchdog Timer (WDT) Controller
+
+Required properties:
+ - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
+		fallback compatible string when compatible with the generic
+		version.
+	       Examples with soctypes are:
+		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7745-wdt" (RZ/G1E)
+		 - "renesas,r8a774a1-wdt" (RZ/G2M)
+		 - "renesas,r8a774c0-wdt" (RZ/G2E)
+	         - "renesas,r8a7790-wdt" (R-Car H2)
+	         - "renesas,r8a7791-wdt" (R-Car M2-W)
+	         - "renesas,r8a7792-wdt" (R-Car V2H)
+	         - "renesas,r8a7793-wdt" (R-Car M2-N)
+	         - "renesas,r8a7794-wdt" (R-Car E2)
+	         - "renesas,r8a7795-wdt" (R-Car H3)
+	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+		 - "renesas,r8a77965-wdt" (R-Car M3-N)
+	         - "renesas,r8a77970-wdt" (R-Car V3M)
+	         - "renesas,r8a77990-wdt" (R-Car E3)
+	         - "renesas,r8a77995-wdt" (R-Car D3)
+	         - "renesas,r7s72100-wdt" (RZ/A1)
+		The generic compatible string must be:
+		 - "renesas,rza-wdt" for RZ/A
+		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
+		 - "renesas,rcar-gen3-wdt" for R-Car Gen3 and RZ/G2
+
+- reg : Should contain WDT registers location and length
+- clocks : the clock feeding the watchdog timer.
+
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+- power-domains : the power domain the WDT belongs to
+- interrupts: Some WDTs have an interrupt when used in interval timer mode
+
+Examples:
+
+	wdt0: watchdog at e6020000 {
+		compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
+		reg = <0 0xe6020000 0 0x0c>;
+		clocks = <&cpg CPG_MOD 402>;
+		power-domains = <&cpg>;
+		timeout-sec = <60>;
+	};
diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
deleted file mode 100644
index 2c0b03a..0000000
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Renesas Watchdog Timer (WDT) Controller
-
-Required properties:
- - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
-		fallback compatible string when compatible with the generic
-		version.
-	       Examples with soctypes are:
-		 - "renesas,r8a7743-wdt" (RZ/G1M)
-		 - "renesas,r8a7745-wdt" (RZ/G1E)
-		 - "renesas,r8a774a1-wdt" (RZ/G2M)
-		 - "renesas,r8a774c0-wdt" (RZ/G2E)
-	         - "renesas,r8a7790-wdt" (R-Car H2)
-	         - "renesas,r8a7791-wdt" (R-Car M2-W)
-	         - "renesas,r8a7792-wdt" (R-Car V2H)
-	         - "renesas,r8a7793-wdt" (R-Car M2-N)
-	         - "renesas,r8a7794-wdt" (R-Car E2)
-	         - "renesas,r8a7795-wdt" (R-Car H3)
-	         - "renesas,r8a7796-wdt" (R-Car M3-W)
-		 - "renesas,r8a77965-wdt" (R-Car M3-N)
-	         - "renesas,r8a77970-wdt" (R-Car V3M)
-	         - "renesas,r8a77990-wdt" (R-Car E3)
-	         - "renesas,r8a77995-wdt" (R-Car D3)
-	         - "renesas,r7s72100-wdt" (RZ/A1)
-		The generic compatible string must be:
-		 - "renesas,rza-wdt" for RZ/A
-		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G1
-		 - "renesas,rcar-gen3-wdt" for R-Car Gen3 and RZ/G2
-
-- reg : Should contain WDT registers location and length
-- clocks : the clock feeding the watchdog timer.
-
-Optional properties:
-- timeout-sec : Contains the watchdog timeout in seconds
-- power-domains : the power domain the WDT belongs to
-- interrupts: Some WDTs have an interrupt when used in interval timer mode
-
-Examples:
-
-	wdt0: watchdog at e6020000 {
-		compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
-		reg = <0 0xe6020000 0 0x0c>;
-		clocks = <&cpg CPG_MOD 402>;
-		power-domains = <&cpg>;
-		timeout-sec = <60>;
-	};
-- 
2.7.4
