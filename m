From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Mar 2019 12:13:01 +0000
Subject: [cip-dev] [PATCH 4.19.y 1/9] i2c: sh_mobile: document support for
	r8a77990 (R-Car E3)
In-Reply-To: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553688789-43441-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Document support for the IIC code for the r8a77990 (R-Car E3).

It is not considered compatible with existing fallback bindings
due to the documented absence of automatic transmission registers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit fca34b910ddc556c51294d58287f7c33863dddef)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index 872673a..cc62577 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -15,6 +15,7 @@ Required properties:
 			- "renesas,iic-r8a7795" (R-Car H3)
 			- "renesas,iic-r8a7796" (R-Car M3-W)
 			- "renesas,iic-r8a77965" (R-Car M3-N)
+			- "renesas,iic-r8a77990" (R-Car E3)
 			- "renesas,iic-sh73a0" (SH-Mobile AG5)
 			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
 							compatible device)
@@ -27,7 +28,13 @@ Required properties:
 			the platform first followed by the generic R-Car
 			version.
 
-			renesas,rmobile-iic must always follow.
+			When compatible with "renesas,rmobile-iic" it should
+			be the last compatibility string listed.
+
+			The r8a77990 (R-Car E3) controller is not
+			considered compatible with "renesas,rcar-gen3-iic"
+			or "renesas,rmobile-iic" due to the absence of
+			automatic transmission registers.
 
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
-- 
2.7.4
