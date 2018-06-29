From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:06 +0100
Subject: [cip-dev] [PATCH 65/86] ARM: dts: iwg22m: Add RTC support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-66-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for the bq32000 RTC to the iwg22m device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a7b8f48d2fa14330a1886f7fd640187c8b4470c5)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index afb1148..e306e7c 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -37,6 +37,11 @@
 		groups = "mmc_data8", "mmc_ctrl";
 		function = "mmc";
 	};
+
+	i2c3_pins: i2c3 {
+		groups = "i2c3_b";
+		function = "i2c3";
+	};
 };
 
 &mmcif0 {
@@ -48,3 +53,16 @@
 	non-removable;
 	status = "okay";
 };
+
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 68 {
+		compatible = "ti,bq32000";
+		reg = <0x68>;
+	};
+};
-- 
2.7.4
