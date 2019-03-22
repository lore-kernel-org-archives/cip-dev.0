From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:56:20 +0000
Subject: [cip-dev] [PATCH 4/5] dt-bindings: watchdog: renesas-wdt: Document
	r8a774c0 support
In-Reply-To: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
References: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553248581-64466-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
Gen3, therefore add relevant documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
(cherry picked from commit 6797f292e4f59211c1763de87a69c9a55fd9caef)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 9407212..2c0b03a 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
+		 - "renesas,r8a774c0-wdt" (RZ/G2E)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
 	         - "renesas,r8a7792-wdt" (R-Car V2H)
-- 
2.7.4
