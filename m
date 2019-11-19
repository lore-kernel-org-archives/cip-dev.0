From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:40 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 15/17] dt-bindings: watchdog:
	renesas-wdt: Document r8a7744 support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit c54ed7c02bd79abe7a62943d308ecb51cf1d4ffe upstream.

RZ/G1N (R8A7744) watchdog implementation is compatible with R-Car
Gen2, therefore add relevant documentation.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: backported to the 4.4.y-cip]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 25b108e..a985fd5 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 		version.
 	       Examples with soctypes are:
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7744-wdt" (RZ/G1N)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		The generic compatible string must be:
 		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
-- 
2.7.4
