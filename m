From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Tue, 14 May 2019 09:19:26 +0900
Subject: [cip-dev] [PATCH 4.4.y 33/52] ARM: dts: r8a77470: Add clocks
In-Reply-To: <1557761837-24993-34-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-34-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190514001926.nf3raktws3to44d4@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On Mon, May 13, 2019 at 04:36:58PM +0100, Fabrizio Castro wrote:
> Declare all core clocks, DIV6 clocks, and MSTP clocks.
> Also, hook up clocks within cpu0, scif1, and gic nodes.
> 

Please write a reason to no backport patch.

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a77470.dtsi | 384 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 384 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
> index a126bf5..09c4d66 100644
> --- a/arch/arm/boot/dts/r8a77470.dtsi
> +++ b/arch/arm/boot/dts/r8a77470.dtsi
> @@ -23,6 +23,7 @@
>  			compatible = "arm,cortex-a7";
>  			reg = <0>;
>  			clock-frequency = <1000000000>;
> +			clocks = <&z2_clk>;
>  			next-level-cache = <&L2_CA7>;
>  		};
>  
> @@ -90,6 +91,10 @@
>  			compatible = "renesas,scif-r8a77470", "renesas,scif";
>  			reg = <0 0xe6e68000 0 0x40>;
>  			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&mstp7_clks R8A77470_CLK_SCIF1>,
> +				 <&zs_clk>, <&scif_clk>;
> +			clock-names = "sci_ick", "brg_int", "scif_clk";
> +			power-domains = <&cpg_clocks>;
>  			status = "disabled";
>  		};
>  
> @@ -101,6 +106,385 @@
>  			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
>  			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
>  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&mstp4_clks R8A77470_CLK_INTC_SYS>;
> +			clock-names = "clk";
> +			power-domains = <&cpg_clocks>;
> +		};
> +
> +		clocks {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			/* Special CPG clocks */
> +			cpg_clocks: cpg_clocks at e6150000 {
> +				compatible = "renesas,r8a77470-cpg-clocks",
> +					     "renesas,rcar-gen2-cpg-clocks";
> +				reg = <0 0xe6150000 0 0x1000>;
> +				clocks = <&extal_clk &usb_extal_clk>;
> +				#clock-cells = <1>;
> +				clock-output-names = "main", "pll0", "pll1",
> +						     "pll3", "lb", "qspi",
> +						     "sdh", "sd0", "sd1",
> +						     "rcan";
> +				#power-domain-cells = <0>;
> +			};
> +
> +			/* Variable factor clocks */
> +			sd2_clk: sd2_clk at e6150078 {
> +				compatible = "renesas,r8a77470-div6-clock",
> +					     "renesas,cpg-div6-clock";
> +				reg = <0 0xe6150078 0 4>;
> +				clocks = <&pll1_div2_clk>;
> +				#clock-cells = <0>;
> +				clock-output-names = "sd2";
> +			};
> +
> +			/* Fixed factor clocks */
> +			pll1_div2_clk: pll1_div2_clk {
> +				compatible = "fixed-factor-clock";
> +				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
> +				#clock-cells = <0>;
> +				clock-div = <2>;
> +				clock-mult = <1>;
> +				clock-output-names = "pll1_div2";
> +			};
> +			z2_clk: z2 {

z2 -> z2_clk?

Best regards,
  Nobuhiro
