From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 07:42:17 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 1/5] dt-bindings: spi: rspi: Add r8a7744
	to the compatible list
In-Reply-To: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
References: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563259341-37180-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 6cee4afdec51b04b56e0942fd008006bf1b17497 upstream.

Document RZ/G1N (r8a7744) SoC specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index 3b02b3a..a7cb47e 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -12,6 +12,7 @@ Required properties:
 		        - "renesas,rspi-sh7757" (SH)
 			- "renesas,rspi-r7s72100" (RZ/A1H)
 			- "renesas,qspi-r8a7743" (RZ/G1M)
+			- "renesas,qspi-r8a7744" (RZ/G1N)
 			- "renesas,qspi-r8a7745" (RZ/G1E)
 			- "renesas,qspi-r8a7790" (R-Car H2)
 			- "renesas,qspi-r8a7791" (R-Car M2-W)
-- 
2.7.4
