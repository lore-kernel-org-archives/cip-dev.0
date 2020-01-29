From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:29:56 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/12] dt-bindings: watchdog:
	renesas-wdt: Document r8a774b1 support
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 758622581489b159286eeb9b9cc8d24382a610ec upstream.

RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
with R-Car Gen3, therefore add the relevant documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
index 2c0b03a..71f419d 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
+		 - "renesas,r8a774b1-wdt" (RZ/G2N)
 		 - "renesas,r8a774c0-wdt" (RZ/G2E)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
-- 
2.7.4
