From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 24 May 2019 11:43:34 +0100
Subject: [cip-dev] [PATCH 4.4.y 2/2] ARM: dts: r8a77470: Add SMP support
In-Reply-To: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1558694614-14062-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1558694614-14062-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a21efdbc744c999d79ba86629a5ae35e2cba1e13 upstream.

Add DT node for the Advanced Power Management Unit (APMU), add the
second CPU core, and use "renesas,apmu" as "enable-method".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: reworked clocks property, removed power-domains property]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 3542678..8cc15e6 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -17,6 +17,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -27,6 +28,14 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clock-frequency = <1000000000>;
+			clocks = <&z2_clk>;
+			next-level-cache = <&L2_CA7>;
+		};
 
 		L2_CA7: cache-controller-0 {
 			compatible = "cache";
@@ -149,6 +158,12 @@
 			reg = <0 0xe6060000 0 0x118>;
 		};
 
+		apmu at e6151000 {
+			compatible = "renesas,r8a77470-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
 		rst: reset-controller at e6160000 {
 			compatible = "renesas,r8a77470-rst";
 			reg = <0 0xe6160000 0 0x100>;
-- 
2.7.4
