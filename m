From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:37 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 11/35] arm64: dts: renesas:
	hihope-common: Move du clk properties out of common dtsi
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit fbdcdb9c86218a917174892aa7e9aac7cc498ca1 upstream.

RZ/G2N board is pin compatible with RZ/G2M board. However on the SoC
side RZ/G2N uses DU3 where as RZ/G2M uses DU2 for the DPAD. In order to
reuse the common dtsi for both the boards, it is required to move du clock
properties from common dtsi to board specific dts.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1570029619-43238-2-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi        |  8 --------
 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts | 11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 3e376d2..355d0a2 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -142,14 +142,6 @@
 };
 
 &du {
-	clocks = <&cpg CPG_MOD 724>,
-		 <&cpg CPG_MOD 723>,
-		 <&cpg CPG_MOD 722>,
-		 <&versaclock5 1>,
-		 <&x302_clk>,
-		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2",
-		      "dclkin.0", "dclkin.1", "dclkin.2";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
index 93ca973..96f2fb0 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
@@ -24,3 +24,14 @@
 		reg = <0x6 0x00000000 0x0 0x80000000>;
 	};
 };
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 722>,
+		 <&versaclock5 1>,
+		 <&x302_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.2",
+		      "dclkin.0", "dclkin.1", "dclkin.2";
+};
-- 
2.7.4
