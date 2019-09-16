From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:41 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 27/32] arm64: dts: renesas: r8a774a1:
	Add FDP1 instance
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 466f475f63d1889c192c751f53ab1030e4dd829c upstream.

The r8a774a1 has a single FDP1 instance similar to r8a7796.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index da3230b..ceff224 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1843,6 +1843,16 @@
 			status = "disabled";
 		};
 
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A774A1_PD_A3VC>;
+			resets = <&cpg 119>;
+			renesas,fcp = <&fcpf0>;
+		};
+
 		fcpf0: fcp at fe950000 {
 			compatible = "renesas,fcpf";
 			reg = <0 0xfe950000 0 0x200>;
-- 
2.7.4
