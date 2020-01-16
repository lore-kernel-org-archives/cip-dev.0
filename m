From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:19 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 09/12] arm64: dts: renesas: Update
	'vsps' properties for readability
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit 38290431d56d7d3928ac89e9f8d3d6b3c8df4c6e upstream.

Update the 'vsps' property in the R-Car Gen3 SoC device tree files to
match what's in the documentation example.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[fab: Dropped changes to r8a77990.dtsi as not applicable]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 3f5b659..cf25dbb 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1813,7 +1813,7 @@
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>;
 			clock-names = "du.0", "du.1";
-			vsps = <&vspd0 0 &vspd1 0>;
+			vsps = <&vspd0 0>, <&vspd1 0>;
 			status = "disabled";
 
 			ports {
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c87eed7..b9edb71 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2795,7 +2795,7 @@
 				 <&cpg CPG_MOD 721>,
 				 <&cpg CPG_MOD 727>;
 			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
-			vsps = <&vspd0 0 &vspd1 0 &vspd2 0 &vspd0 1>;
+			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd2 0>, <&vspd0 1>;
 			status = "disabled";
 
 			ports {
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index f1dfd174..7de6edf 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1839,7 +1839,7 @@
 			clock-names = "du.0", "du.1", "du.3";
 			status = "disabled";
 
-			vsps = <&vspd0 0 &vspd1 0 &vspd0 1>;
+			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd0 1>;
 
 			ports {
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index fe77bc4..db0c8ad 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -944,7 +944,7 @@
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>;
 			clock-names = "du.0", "du.1";
-			vsps = <&vspd0 0 &vspd1 0>;
+			vsps = <&vspd0 0>, <&vspd1 0>;
 			status = "disabled";
 
 			ports {
-- 
2.7.4
