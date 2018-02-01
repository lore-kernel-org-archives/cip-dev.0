From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:25 +0000
Subject: [cip-dev] [PATCH 3/7] dt-bindings: i2c: Document r8a7743/5 support
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document i2c Device Tree support for RZ/G1[ME]
(also known as r8aA774[35]) SoCs. They are compatible with
R-Car Gen2 SoC family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit 4523656ff6cba7a217d44e5e8f726ccca2736473)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index e26f224..f6cb9e5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -2,6 +2,8 @@ I2C for R-Car platforms
 
 Required properties:
 - compatible:
+	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
+	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
@@ -11,7 +13,8 @@ Required properties:
 	"renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
 	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
 	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
-	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 compatible device.
+	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
+				device.
 	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
 	"renesas,i2c-rcar" (deprecated)
 
-- 
2.7.4
