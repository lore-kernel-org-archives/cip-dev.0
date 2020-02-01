From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:50 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 02/14] dt-bindings: i2c: rcar: Add
	r8a774b1 support
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit b803376824c6a3544638bc1dc24e33737dfd9b6b upstream.

Document RZ/G2N (R8A774B1) I2C compatibility with the relevant driver
dt-bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,i2c.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,i2c.txt b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
index c6367d0..efb1c11 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
@@ -5,6 +5,7 @@ Required properties:
 	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
+	"renesas,i2c-r8a774b1" if the device is a part of a R8A774B1 SoC.
 	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
-- 
2.7.4
