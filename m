From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:15 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog: renesas-wdt:
	Document r8a77470 support
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574268440-33507-2-git-send-email-biju.das@bp.renesas.com>
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
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 25b108e..010f109 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -7,6 +7,7 @@ Required properties:
 	       Examples with soctypes are:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
+		 - "renesas,r8a77470-wdt" (RZ/G1C)
 		The generic compatible string must be:
 		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
 
-- 
2.7.4
