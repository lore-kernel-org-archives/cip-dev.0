From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:49 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 5/6] arm64: dts: renesas: r8a774c0:
	Remove invalid compatible value for CSI40
In-Reply-To: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200930-39297-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

commit 82ec009297bc573e6aace629181d13ed6ce3772f upstream.

The compatible value renesas,rcar-gen3-csi2 was used while prototyping
the R-Car CSI-2 driver but was removed before the driver was merged.

Fixes: e961ab42e034d469 ("arm64: dts: renesas: r8a774c0: Add VIN and CSI-2 device nodes")
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 169f18e..805042d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1668,8 +1668,7 @@
 		};
 
 		csi40: csi2 at feaa0000 {
-			compatible = "renesas,r8a774c0-csi2",
-				     "renesas,rcar-gen3-csi2";
+			compatible = "renesas,r8a774c0-csi2";
 			reg = <0 0xfeaa0000 0 0x10000>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 716>;
-- 
2.7.4
