From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 24 May 2019 11:43:33 +0100
Subject: [cip-dev] [PATCH 4.4.y 1/2] dt-bindings: apmu: Document r8a77470
	support
In-Reply-To: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1558694614-14062-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 4619ef4747c23818063c4e8480d63966a40297c6 upstream.

Document APMU and SMP enable method for RZ/G1C (also known as
r8a77470) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,apmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
index 342aa85..e80f5f6 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.txt
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -9,6 +9,7 @@ Required properties:
 	      Examples with soctypes are:
 		- "renesas,r8a7743-apmu" (RZ/G1M)
 		- "renesas,r8a7745-apmu" (RZ/G1E)
+		- "renesas,r8a77470-apmu" (RZ/G1C)
 		- "renesas,r8a7790-apmu" (R-Car H2)
 		- "renesas,r8a7791-apmu" (R-Car M2-W)
 
-- 
2.7.4
