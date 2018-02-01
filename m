From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:28 +0000
Subject: [cip-dev] [PATCH 6/7] dt-bindings: i2c: sh_mobile: Document
	r8a7743/5 support
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document i2c Device Tree support for RZ/G1[ME]
(also known as r8a774[35]) SoCs. They are compatible with
R-Car Gen2 SoC family. No driver change is required as the
initialisation sequence is currently the same as for the
R-Car Gen2 fallback binding.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit 6c448f04c83713c49be7baf341ed6a04d7493a15)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 7716acc..4bfb89e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -4,6 +4,8 @@ Required properties:
 - compatible      :
 			- "renesas,iic-r8a73a4" (R-Mobile APE6)
 			- "renesas,iic-r8a7740" (R-Mobile A1)
+			- "renesas,iic-r8a7743" (RZ/G1M)
+			- "renesas,iic-r8a7745" (RZ/G1E)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
 			- "renesas,iic-r8a7792" (R-Car V2H)
@@ -11,7 +13,8 @@ Required properties:
 			- "renesas,iic-r8a7794" (R-Car E2)
 			- "renesas,iic-r8a7795" (R-Car H3)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
-			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 compatible device)
+			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
+							compatible device)
 			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
 			- "renesas,rmobile-iic" (generic device)
 
-- 
2.7.4
