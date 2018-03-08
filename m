From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:54:39 +0000
Subject: [cip-dev] [PATCH 3/3] ARM: dts: iwg20m: Add SPI NOR support
In-Reply-To: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520531679-9452-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520531679-9452-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for the SPI NOR device used to boot up the system
to the System on Module DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 781e923a5fe4751d3aaa740ca3de0f9d179c34ef)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 4119737..75a8ca5 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -44,6 +44,11 @@
 		function = "mmc";
 	};
 
+	qspi_pins: qspi {
+		groups = "qspi_ctrl", "qspi_data2";
+		function = "qspi";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
@@ -61,6 +66,27 @@
 	status = "okay";
 };
 
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* WARNING - This device contains the bootloader. Handle with care. */
+	flash: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+	};
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
