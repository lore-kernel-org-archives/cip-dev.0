From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:48 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 22/35] arm64: dts: renesas: r8a774a1:
	Remove audio port node
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-23-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit a381325812691f57aece60aaee76938ac8fc6619 upstream.

This patch removes audio port node from SoC device tree and
fixes the below dtb warning

    Warning (unit_address_vs_reg): /soc/sound at ec500000/ports/port at 0: node has a unit name, but no reg property

Fixes: e2f04248fcd4 ("arm64: dts: renesas: r8a774a1: Add audio support")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1570200761-884-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(dropped deleting ports node from r8a774a1.dtsi as it doesnt exist)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 355d0a2..2c942a7 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -86,7 +86,7 @@
 
 		label = "rcar-sound";
 
-		dais = <&rsnd_port0>;
+		dais = <&rsnd_port>;
 	};
 
 	vbus0_usb2: regulator-vbus0-usb2 {
@@ -183,7 +183,7 @@
 		port at 2 {
 			reg = <2>;
 			dw_hdmi0_snd_in: endpoint {
-				remote-endpoint = <&rsnd_endpoint0>;
+				remote-endpoint = <&rsnd_endpoint>;
 			};
 		};
 	};
@@ -319,17 +319,15 @@
 	/* Single DAI */
 	#sound-dai-cells = <0>;
 
-	ports {
-		rsnd_port0: port at 0 {
-			rsnd_endpoint0: endpoint {
-				remote-endpoint = <&dw_hdmi0_snd_in>;
+	rsnd_port: port {
+		rsnd_endpoint: endpoint {
+			remote-endpoint = <&dw_hdmi0_snd_in>;
 
-				dai-format = "i2s";
-				bitclock-master = <&rsnd_endpoint0>;
-				frame-master = <&rsnd_endpoint0>;
+			dai-format = "i2s";
+			bitclock-master = <&rsnd_endpoint>;
+			frame-master = <&rsnd_endpoint>;
 
-				playback = <&ssi2>;
-			};
+			playback = <&ssi2>;
 		};
 	};
 };
-- 
2.7.4
