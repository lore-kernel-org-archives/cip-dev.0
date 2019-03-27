From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Mar 2019 12:13:05 +0000
Subject: [cip-dev] [PATCH 4.19.y 5/9] dt-bindings: i2c: rcar: Add r8a774c0
	support
In-Reply-To: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553688789-43441-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document RZ/G2E (R8A774C0) I2C compatibility with the relevant device
dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
(cherry picked from commit 1ccf1980e3e4853ecf11804774ef6ac071911150)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 39cd21d..c6367d0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -5,6 +5,7 @@ Required properties:
 	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
+	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
-- 
2.7.4
