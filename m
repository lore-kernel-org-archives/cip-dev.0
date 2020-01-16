From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:16 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 06/12] arm64: dts: renesas: r8a774c0:
	Clean up CPU compatibles
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Robin Murphy <robin.murphy@arm.com>

commit 11290c09e29600f45684113d78209d1df1c22aba upstream.

Apparently this DTS crossed over with commit 31af04cd60d3 ("arm64: dts:
Remove inconsistent use of 'arm,armv8' compatible string") and missed
out on the cleanup, so put it right.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 1e8b8af..cb1b71d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -70,7 +70,7 @@
 		#size-cells = <0>;
 
 		a53_0: cpu at 0 {
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <0>;
 			device_type = "cpu";
 			#cooling-cells = <2>;
@@ -83,7 +83,7 @@
 		};
 
 		a53_1: cpu at 1 {
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <1>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
-- 
2.7.4
