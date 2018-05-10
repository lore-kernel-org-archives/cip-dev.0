From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:31 +0100
Subject: [cip-dev] [PATCH 42/62] ARM: dts: iwg20d-q7-common: Sound DMA
	support via DVC on DTS
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-43-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

DMA transfer uses DVC

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 0ed33948cb43193ba3dbdff8e521f84326669405)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 937c6fe..6920e3f 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -8,6 +8,29 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-SGTL5000
+ *
+ * This command is required when Playback/Capture
+ *
+ *      amixer set "DVC Out" 100%
+ *      amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *      amixer set "DVC Out Mute" on
+ *      amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *      amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *      amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *      amixer set "DVC Out Ramp" on
+ *      aplay xxx.wav &
+ *      amixer set "DVC Out"  80%  // Volume Down
+ *      amixer set "DVC Out" 100%  // Volume Up
+ */
+
 / {
 	aliases {
 		serial0 = &scif0;
@@ -202,8 +225,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi1 &src3>;
-			capture = <&ssi0 &src2>;
+			playback = <&ssi1 &src3 &dvc1>;
+			capture = <&ssi0 &src2 &dvc0>;
 		};
 	};
 };
-- 
2.7.4
