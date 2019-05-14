From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 14 May 2019 10:10:14 +0000
Subject: [cip-dev] [PATCH 4.4.y 33/52] ARM: dts: r8a77470: Add clocks
In-Reply-To: <20190514001926.nf3raktws3to44d4@toshiba.co.jp>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-34-git-send-email-fabrizio.castro@bp.renesas.com>
	<20190514001926.nf3raktws3to44d4@toshiba.co.jp>
Message-ID: <TY1PR01MB1770C040C08B23E47D3E0963C0080@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Nobuhiro-san,

Thank you for your feedback!

> From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 14 May 2019 01:19
> Subject: Re: [cip-dev] [PATCH 4.4.y 33/52] ARM: dts: r8a77470: Add clocks
> 
> Hi,
> 
> On Mon, May 13, 2019 at 04:36:58PM +0100, Fabrizio Castro wrote:
> > Declare all core clocks, DIV6 clocks, and MSTP clocks.
> > Also, hook up clocks within cpu0, scif1, and gic nodes.
> >
> 
> Please write a reason to no backport patch.

The driver architecture for the clocks has changed dramatically over time, as such
backporting is not an option here, we decided to go with something similar to:
* 0aeeb1555cad ("ARM: dts: r8a7745: Add clocks")
* 687a64a66d93 ("ARM: dts: r8a7743: Add clocks")
Both commits have been specifically made for the 4.4.y-CIP kernel.

Could you please suggest a format you would be comfortable with for new commits?

> 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a77470.dtsi | 384 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 384 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
> > index a126bf5..09c4d66 100644
> > --- a/arch/arm/boot/dts/r8a77470.dtsi
> > +++ b/arch/arm/boot/dts/r8a77470.dtsi
> > @@ -23,6 +23,7 @@
> >  			compatible = "arm,cortex-a7";
> >  			reg = <0>;
> >  			clock-frequency = <1000000000>;
> > +			clocks = <&z2_clk>;
> >  			next-level-cache = <&L2_CA7>;
> >  		};
> >
> > @@ -90,6 +91,10 @@
> >  			compatible = "renesas,scif-r8a77470", "renesas,scif";
> >  			reg = <0 0xe6e68000 0 0x40>;
> >  			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&mstp7_clks R8A77470_CLK_SCIF1>,
> > +				 <&zs_clk>, <&scif_clk>;
> > +			clock-names = "sci_ick", "brg_int", "scif_clk";
> > +			power-domains = <&cpg_clocks>;
> >  			status = "disabled";
> >  		};
> >
> > @@ -101,6 +106,385 @@
> >  			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
> >  			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
> >  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> > +			clocks = <&mstp4_clks R8A77470_CLK_INTC_SYS>;
> > +			clock-names = "clk";
> > +			power-domains = <&cpg_clocks>;
> > +		};
> > +
> > +		clocks {
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			/* Special CPG clocks */
> > +			cpg_clocks: cpg_clocks at e6150000 {
> > +				compatible = "renesas,r8a77470-cpg-clocks",
> > +					     "renesas,rcar-gen2-cpg-clocks";
> > +				reg = <0 0xe6150000 0 0x1000>;
> > +				clocks = <&extal_clk &usb_extal_clk>;
> > +				#clock-cells = <1>;
> > +				clock-output-names = "main", "pll0", "pll1",
> > +						     "pll3", "lb", "qspi",
> > +						     "sdh", "sd0", "sd1",
> > +						     "rcan";
> > +				#power-domain-cells = <0>;
> > +			};
> > +
> > +			/* Variable factor clocks */
> > +			sd2_clk: sd2_clk at e6150078 {
> > +				compatible = "renesas,r8a77470-div6-clock",
> > +					     "renesas,cpg-div6-clock";
> > +				reg = <0 0xe6150078 0 4>;
> > +				clocks = <&pll1_div2_clk>;
> > +				#clock-cells = <0>;
> > +				clock-output-names = "sd2";
> > +			};
> > +
> > +			/* Fixed factor clocks */
> > +			pll1_div2_clk: pll1_div2_clk {
> > +				compatible = "fixed-factor-clock";
> > +				clocks = <&cpg_clocks R8A77470_CLK_PLL1>;
> > +				#clock-cells = <0>;
> > +				clock-div = <2>;
> > +				clock-mult = <1>;
> > +				clock-output-names = "pll1_div2";
> > +			};
> > +			z2_clk: z2 {
> 
> z2 -> z2_clk?

We tried to be compliant with what we did for the r8a7745:
0aeeb1555cad ("ARM: dts: r8a7745: Add clocks")

I could send a patch for s/z2/z2_clk/ for both the r8a77470 and the r8a7745.dtsi if you would like?
Just let me know.

Thanks,
Fab

> 
> Best regards,
>   Nobuhiro
