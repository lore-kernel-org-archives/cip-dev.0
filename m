From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:18 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/21] dt-bindings: reset: rcar-rst:
	Document r8a7744 reset module
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit f1ae799039bfd3fcc046041714eb0ac227505d0f upstream.

Document bindings for the RZ/G1N (R8A7744) reset module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index fb5f68e..270f54b 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -7,6 +7,7 @@ Required properties:
 		  - "renesas,<soctype>-rst" for R-Car Gen2 and RZ/G
 		Examples with soctypes are:
 		  - "renesas,r8a7743-rst" (RZ/G1M)
+		  - "renesas,r8a7744-rst" (RZ/G1N)
 		  - "renesas,r8a7745-rst" (RZ/G1E)
 		  - "renesas,r8a77470-rst" (RZ/G1C)
 		  - "renesas,r8a7790-rst" (R-Car H2)
-- 
2.7.4
