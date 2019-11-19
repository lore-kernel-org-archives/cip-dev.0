From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:35 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/17] dt-bindings: i2c: rcar: Document
	r8a7744 support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 8bca7089af56be53ecd87091b1f5bf81030e571b upstream.

Document i2c Device Tree support for RZ/G1N (R8A7744) SoC, which is
compatible with R-Car Gen2 SoC family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index f6cb9e5..0d1aa9e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -3,6 +3,7 @@ I2C for R-Car platforms
 Required properties:
 - compatible:
 	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
+	"renesas,i2c-r8a7744" if the device is a part of a R8A7744 SoC.
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
-- 
2.7.4
