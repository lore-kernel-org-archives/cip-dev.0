From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 07:42:18 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 2/5] spi: rspi: Add r8a77470 to the
	compatible list
In-Reply-To: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
References: <1563259341-37180-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563259341-37180-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit df80e0478972260bf285c5ed33f99b2424fba2af upstream.

Add r8a77470 to the list of examples with soctypes.
No driver change is needed as "renesas,qspi" will activate
the right code within the corresponding driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index a7cb47e..2f1a3dc 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -14,6 +14,7 @@ Required properties:
 			- "renesas,qspi-r8a7743" (RZ/G1M)
 			- "renesas,qspi-r8a7744" (RZ/G1N)
 			- "renesas,qspi-r8a7745" (RZ/G1E)
+			- "renesas,qspi-r8a77470" (RZ/G1C)
 			- "renesas,qspi-r8a7790" (R-Car H2)
 			- "renesas,qspi-r8a7791" (R-Car M2-W)
 			- "renesas,qspi-r8a7792" (R-Car V2H)
-- 
2.7.4
