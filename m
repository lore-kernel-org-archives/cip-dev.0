From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:56 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 22/22] arm64: dts: renesas: r8a774a1:
	Add dynamic power coefficient
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-23-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 9e35f49cf7037c3fe3fe4d51aec6d492741cddbe upstream.

Describe the dynamic power coefficient of A57 and A53 CPUs.

Based on work by Gaku Inami <gaku.inami.xw@bp.renesas.com> and others.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 6f24ddd..bdf4292 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -135,6 +135,7 @@
 			power-domains = <&sysc R8A774A1_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <854>;
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
@@ -162,6 +163,7 @@
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			dynamic-power-coefficient = <277>;
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <560>;
-- 
2.7.4
