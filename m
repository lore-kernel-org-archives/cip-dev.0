From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Mar 2019 12:13:02 +0000
Subject: [cip-dev] [PATCH 4.19.y 2/9] dt-bindings: i2c: sh_mobile: Add
	r8a774c0 support
In-Reply-To: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553688789-43441-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit 3f74383f29ca2e0c7d9362c4c65a7c2cb4e1fd5f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index cc62577..392162a 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -7,6 +7,7 @@ Required properties:
 			- "renesas,iic-r8a7743" (RZ/G1M)
 			- "renesas,iic-r8a7745" (RZ/G1E)
 			- "renesas,iic-r8a774a1" (RZ/G2M)
+			- "renesas,iic-r8a774c0" (RZ/G2E)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
 			- "renesas,iic-r8a7792" (R-Car V2H)
@@ -31,10 +32,10 @@ Required properties:
 			When compatible with "renesas,rmobile-iic" it should
 			be the last compatibility string listed.
 
-			The r8a77990 (R-Car E3) controller is not
-			considered compatible with "renesas,rcar-gen3-iic"
-			or "renesas,rmobile-iic" due to the absence of
-			automatic transmission registers.
+			The r8a77990 (R-Car E3) and r8a774c0 (RZ/G2E)
+			controllers are not considered compatible with
+			"renesas,rcar-gen3-iic" or "renesas,rmobile-iic"
+			due to the absence of automatic transmission registers.
 
 - reg             : address start and address range size of device
 - interrupts      : interrupt of device
-- 
2.7.4
