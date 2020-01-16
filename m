From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:22 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 12/12] arm64: dts: renesas: r8a774c0:
	cat874: Sort nodes
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

commit 63a0f811558b9a5587a8c52978a57a8b528b074a upstream.

Sort nodes.

If node address is present
   * Sort by node address, grouping all nodes with the same compat string
     and sorting the group alphabetically.
Else
   * Sort alphabetically

This should not have any run-time effect.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 160b176..5be3bad 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -82,13 +82,13 @@
 		simple-audio-card,bitclock-master = <&sndcpu>;
 		simple-audio-card,frame-master = <&sndcpu>;
 
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
 		sndcodec: simple-audio-card,codec {
 			sound-dai = <&tda19988>;
 		};
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
 	};
 
 	vcc_sdhi0: regulator-vcc-sdhi0 {
@@ -255,16 +255,16 @@
 		function = "du";
 	};
 
-	i2c1_pins: i2c1 {
-		groups = "i2c1_b";
-		function = "i2c1";
-	};
-
 	hscif2_pins: hscif2 {
 		groups = "hscif2_data_a", "hscif2_ctrl_a";
 		function = "hscif2";
 	};
 
+	i2c1_pins: i2c1 {
+		groups = "i2c1_b";
+		function = "i2c1";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
@@ -288,15 +288,15 @@
 		power-source = <1800>;
 	};
 
-	sound_pins: sound {
-		groups = "ssi01239_ctrl", "ssi0_data";
-		function = "ssi";
-	};
-
 	sound_clk_pins: sound_clk {
 		groups = "audio_clkout1_a";
 		function = "audio_clk";
 	};
+
+	sound_pins: sound {
+		groups = "ssi01239_ctrl", "ssi0_data";
+		function = "ssi";
+	};
 };
 
 &rcar_sound {
-- 
2.7.4
