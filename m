From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:52 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/14] dt-bindings: i2c: sh_mobile: Add
	r8a774b1 support
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 2a0cfc2f83e857e26ceb2021a0feb0dde0be1239 upstream.

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,iic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,iic.txt b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
index 392162a..a139e58 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,iic.txt
+++ b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
@@ -7,6 +7,7 @@ Required properties:
 			- "renesas,iic-r8a7743" (RZ/G1M)
 			- "renesas,iic-r8a7745" (RZ/G1E)
 			- "renesas,iic-r8a774a1" (RZ/G2M)
+			- "renesas,iic-r8a774b1" (RZ/G2N)
 			- "renesas,iic-r8a774c0" (RZ/G2E)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
-- 
2.7.4
