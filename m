From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 07:49:35 +0000
Subject: [cip-dev] [PATCH V2] dt-bindings: watchdog: renesas-wdt: Document
	r8a77470 support
Message-ID: <1574322575-27007-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 59600d045ff411da193a8b5a2999681801ecd430 upstream.

RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car
Gen2, therefore add relevant documentation.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
---
V1-->V2
  * Rebased to latest 4.4.y-cip
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index a985fd5..050bcf0 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7744-wdt" (RZ/G1N)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
+		 - "renesas,r8a77470-wdt" (RZ/G1C)
 		The generic compatible string must be:
 		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
 
-- 
2.7.4
