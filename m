From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:45 +0100
Subject: [cip-dev] [PATCH v2 33/52] ARM: dts: r8a77470: Add clocks
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-34-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Declare all core clocks, DIV6 clocks, and MSTP clocks.
Also, hook up clocks within cpu0, scif1, and gic nodes.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* Changed commit message to explain why we can't backport this
---
 arch/arm/boot/dts/r8a77470.dtsi | 384 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 384 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index a126bf5..09c4d66 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -23,6 +23,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			clocks = <&z2_clk>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -90,6 +91,10 @@
 			compatible = "renesas,scif-r8a77470", "renesas,scif";
 			reg = <0 0xe6e68000 0 0x40>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF1>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
 
@@ -101,6 +106,385 @@
 			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
 			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&mstp4_clks R8A77470_CLK_INTC_SYS>;
+			clock-names = "clk";
+			power-domains = <&cpg_clocks>;
+		};
+
+		clocks {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			/* Special CPG clocks */
+			cpg_clocks: cpg_clocks at e6150000 {
+				compatible = "renesas,r8a77470-cpg-clocks",
+					     "renesas,rcar-gen2-cpg-clocks";
+				reg = <0 0xe6150000 0 0x1000>;
+				clocks = <&extal_clk &usb_extal_clk>;
+				#clock-cells = <1>;
+				clock-output-names = "main", "pll0", "pll1",
+						     "pll3", "lb", "qspi",
+						     "sdh", "sd0", "sd1",
+						     "rcan";
+				#power-domain-cells = <0>;
+			};
+
+			/* Variable factor clocks */
+			sd2_clk: sd2_clk at e6150078 {
+				compatible = "renesas,r8a77470-div6-clock",
+					     "renesas,cpg-div6-clock";
+				reg = <0 0xe6150078 0 4>;
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-output-names = "sd2";
+			};
+
+			/* Fixed factor clocks */
+			pll1_div2_clk: pll1_div2_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+				clock-output-names = "pll1_div2";
+			};
+			z2_clk: z2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL0>;
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clock-output-names = "z2";
+			};
+			zx_clk: zx_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <3>;
+				clock-mult = <1>;
+				clock-output-names = "zx";
+			};
+			zs_clk: zs_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <6>;
+				clock-mult = <1>;
+				clock-output-names = "zs";
+			};
+			hp_clk: hp_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <12>;
+				clock-mult = <1>;
+				clock-output-names = "hp";
+			};
+			b_clk: b_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <12>;
+				clock-mult = <1>;
+				clock-output-names = "b";
+			};
+			p_clk: p_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <24>;
+				clock-mult = <1>;
+				clock-output-names = "p";
+			};
+			cl_clk: cl_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <48>;
+				clock-mult = <1>;
+				clock-output-names = "cl";
+			};
+			cp_clk: cp_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <48>;
+				clock-mult = <1>;
+				clock-output-names = "cp";
+			};
+			m2_clk: m2_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <8>;
+				clock-mult = <1>;
+				clock-output-names = "m2";
+			};
+			zb3_clk: zb3_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL3>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+				clock-output-names = "zb3";
+			};
+			mp_clk: mp_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <15>;
+				clock-mult = <1>;
+				clock-output-names = "mp";
+			};
+			cpex_clk: cpex_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&extal_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+				clock-output-names = "cpex";
+			};
+			rclk_clk: rclk_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <(48 * 1024)>;
+				clock-mult = <1>;
+				clock-output-names = "rclk";
+			};
+			oscclk_clk: oscclk_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <(12 * 1024)>;
+				clock-mult = <1>;
+				clock-output-names = "oscclk";
+			};
+
+			/* Gate clocks */
+			mstp0_clks: mstp0_clks at e6150130 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+				clocks = <&mp_clk>;
+				#clock-cells = <1>;
+				clock-indices = <R8A77470_CLK_MSIOF0>;
+				clock-output-names = "msiof0";
+			};
+			mstp1_clks: mstp1_clks at e6150134 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+				clocks = <&zs_clk>, <&zs_clk>, <&p_clk>,
+					 <&zs_clk>, <&zs_clk>, <&zs_clk>,
+					 <&p_clk>, <&p_clk>, <&rclk_clk>,
+					 <&zs_clk>, <&zs_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_VCP0 R8A77470_CLK_VPC0
+					R8A77470_CLK_TMU1 R8A77470_CLK_3DG
+					R8A77470_CLK_2DDMAC R8A77470_CLK_FDP1_0
+					R8A77470_CLK_TMU3 R8A77470_CLK_TMU2
+					R8A77470_CLK_CMT0 R8A77470_CLK_VSP1DU0
+					R8A77470_CLK_VSP1_SY
+				>;
+				clock-output-names =
+					"vcp0", "vpc0", "tmu1",
+					"3dg", "2d-dmac", "fdp1-0",
+					"tmu3", "tmu2", "cmt0",
+					"vsp1du0", "vsp1-sy";
+			};
+			mstp2_clks: mstp2_clks at e6150138 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+				clocks = <&mp_clk>, <&mp_clk>, <&zs_clk>,
+					 <&zs_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_MSIOF2
+					R8A77470_CLK_MSIOF1
+					R8A77470_CLK_SYS_DMAC1
+					R8A77470_CLK_SYS_DMAC0
+				>;
+				clock-output-names =
+					"msiof2", "msiof1", "sys-dmac1",
+					"sys-dmac0";
+			};
+			mstp3_clks: mstp3_clks at e615013c {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+				clocks = <&sd2_clk>,
+					 <&cpg_clocks R8A77470_CLK_SD1>,
+					 <&cpg_clocks R8A77470_CLK_SD0>,
+					 <&hp_clk>, <&hp_clk>, <&rclk_clk>,
+					 <&hp_clk>, <&hp_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_SDHI2
+					R8A77470_CLK_SDHI1
+					R8A77470_CLK_SDHI0
+					R8A77470_CLK_USBHS_DMAC0_CH1
+					R8A77470_CLK_USBHS_DMAC1_CH1
+					R8A77470_CLK_CMT1
+					R8A77470_CLK_USBHS_DMAC0_CH0
+					R8A77470_CLK_USBHS_DMAC1_CH0
+				>;
+				clock-output-names =
+					"sdhi2", "sdhi1", "sdhi0",
+					"usbhs-dmac0-ch1", "usbhs-dmac1-ch1",
+					"cmt1", "usbhs-dmac0-ch0",
+					"usbhs-dmac1-ch0";
+			};
+			mstp4_clks: mstp4_clks at e6150140 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+				clocks = <&rclk_clk>, <&cp_clk>, <&zs_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_RWDT R8A77470_CLK_IRQC
+					R8A77470_CLK_INTC_SYS
+				>;
+				clock-output-names = "rwdt", "irqc", "intc-sys";
+			};
+			mstp5_clks: mstp5_clks at e6150144 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+				clocks = <&hp_clk>, <&p_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_AUDIO_DMAC0
+					R8A77470_CLK_PWM
+				>;
+				clock-output-names = "audio-dmac0", "pwm";
+			};
+			mstp7_clks: mstp7_clks at e615014c {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+				clocks = <&mp_clk>, <&hp_clk>, <&mp_clk>,
+					 <&hp_clk>, <&zs_clk>, <&p_clk>,
+					 <&p_clk>, <&zs_clk>, <&zs_clk>,
+					 <&p_clk>, <&p_clk>, <&p_clk>,
+					 <&p_clk>, <&zx_clk>, <&zx_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_USB_EHCI_0
+					R8A77470_CLK_USBHS0
+					R8A77470_CLK_USB_EHCI_1
+					R8A77470_CLK_USBHS1 R8A77470_CLK_HSCIF2
+					R8A77470_CLK_SCIF5 R8A77470_CLK_SCIF4
+					R8A77470_CLK_HSCIF1 R8A77470_CLK_HSCIF0
+					R8A77470_CLK_SCIF3 R8A77470_CLK_SCIF2
+					R8A77470_CLK_SCIF1 R8A77470_CLK_SCIF0
+					R8A77470_CLK_DU1 R8A77470_CLK_DU0
+				>;
+				clock-output-names =
+					"usb-ehci-0", "usbhs-0", "usb-ehci-1",
+					"usbhs-1", "hscif2", "scif5", "scif4",
+					"hscif1", "hscif0", "scif3", "scif2",
+					"scif1", "scif0", "du1", "du0";
+			};
+			mstp8_clks: mstp8_clks at e6150990 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+				clocks = <&zx_clk>, <&hp_clk>, <&p_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_IPMMU_SGX
+					R8A77470_CLK_ETHERAVB R8A77470_CLK_ETHER
+				>;
+				clock-output-names =
+					"ipmmu-sgx", "etheravb", "ether";
+			};
+			mstp9_clks: mstp9_clks at e6150994 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+				clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+					 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+					 <&p_clk>, <&p_clk>,
+					 <&cpg_clocks R8A77470_CLK_QSPI>,
+					 <&cpg_clocks R8A77470_CLK_QSPI>,
+					 <&hp_clk>, <&hp_clk>, <&hp_clk>,
+					 <&hp_clk>, <&hp_clk>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_GPIO5 R8A77470_CLK_GPIO4
+					R8A77470_CLK_GPIO3 R8A77470_CLK_GPIO2
+					R8A77470_CLK_GPIO1 R8A77470_CLK_GPIO0
+					R8A77470_CLK_CAN1 R8A77470_CLK_CAN0
+					R8A77470_CLK_QUAD_SPI1
+					R8A77470_CLK_QUAD_SPI0
+					R8A77470_CLK_I2C4 R8A77470_CLK_I2C3
+					R8A77470_CLK_I2C2 R8A77470_CLK_I2C1
+					R8A77470_CLK_I2C0
+				>;
+				clock-output-names =
+					"gpio5", "gpio4", "gpio3", "gpio2",
+					"gpio1", "gpio0", "can1", "can0",
+					"qspi_mod-1", "qspi_mod-0", "i2c4",
+					"i2c3", "i2c2", "i2c1", "i2c0";
+			};
+			mstp10_clks: mstp10_clks at e6150998 {
+				compatible = "renesas,r8a77470-mstp-clocks",
+					     "renesas,cpg-mstp-clocks";
+				reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+				clocks = <&p_clk>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SSI_ALL>,
+					 <&p_clk>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>,
+					 <&mstp10_clks R8A77470_CLK_SCU_ALL>;
+				#clock-cells = <1>;
+				clock-indices = <
+					R8A77470_CLK_SSI_ALL R8A77470_CLK_SSI9
+					R8A77470_CLK_SSI8 R8A77470_CLK_SSI7
+					R8A77470_CLK_SSI6 R8A77470_CLK_SSI5
+					R8A77470_CLK_SSI4 R8A77470_CLK_SSI3
+					R8A77470_CLK_SSI2 R8A77470_CLK_SSI1
+					R8A77470_CLK_SSI0 R8A77470_CLK_SCU_ALL
+					R8A77470_CLK_SCU_DVC1
+					R8A77470_CLK_SCU_DVC0
+					R8A77470_CLK_SCU_CTU1_MIX1
+					R8A77470_CLK_SCU_CTU0_MIX0
+					R8A77470_CLK_SCU_SRC6
+					R8A77470_CLK_SCU_SRC5
+					R8A77470_CLK_SCU_SRC4
+					R8A77470_CLK_SCU_SRC3
+					R8A77470_CLK_SCU_SRC2
+					R8A77470_CLK_SCU_SRC1
+				>;
+				clock-output-names =
+					"ssi-all", "ssi9", "ssi8", "ssi7",
+					"ssi6",	"ssi5",	"ssi4",	"ssi3",	"ssi2",
+					"ssi1",	"ssi0",	"scu-all", "scu-dvc1",
+					"scu-dvc0", "scu-ctu1-mix1",
+					"scu-ctu0-mix0", "scu-src6", "scu-src5",
+					"scu-src4", "scu-src3", "scu-src2",
+					"scu-src1";
+			};
 		};
 	};
 
-- 
2.7.4
