From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:32 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 07/17] dt-bindings: apmu: Document
	r8a7744 support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit fae210bb5bfbd29118e18881f7108c6bd59293b9 upstream.

Document APMU and SMP enable method for RZ/G1N (R8A7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,apmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
index e80f5f6..21157fb 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.txt
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
 	      Examples with soctypes are:
 		- "renesas,r8a7743-apmu" (RZ/G1M)
+		- "renesas,r8a7744-apmu" (RZ/G1N)
 		- "renesas,r8a7745-apmu" (RZ/G1E)
 		- "renesas,r8a77470-apmu" (RZ/G1C)
 		- "renesas,r8a7790-apmu" (R-Car H2)
-- 
2.7.4
