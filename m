From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:25 +0100
Subject: [cip-dev] [PATCH  36/62] ARM: dts: r8a7743: Add sound support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-37-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Define the generic r8a7743(RZ/G1M) part of  the sound device node.

This patch is based on the r8a7791 sound work by Kuninori Morimoto.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit de812613376a202d70c8ce37211044a29aae33b2)
(updated clock, power-domains property. Removed resets and
reset-names properties. Also changed the rcar_sound,module children
names (for eg:- ssi-0 to ssi at 0) for similarity with other r-car
gen2 devices present in 4.4 kernel)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 179 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 625d5ac..73c658b 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1549,6 +1549,185 @@
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
+
+		rcar_sound: sound at ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a7743",
+				     "renesas,rcar_sound-gen2";
+			reg = <0 0xec500000 0 0x1000>, /* SCU */
+			      <0 0xec5a0000 0 0x100>,  /* ADG */
+			      <0 0xec540000 0 0x1000>, /* SSIU */
+			      <0 0xec541000 0 0x280>,  /* SSI */
+			      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&mstp10_clks R8A7743_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7743_CLK_SSI9>, <&mstp10_clks R8A7743_CLK_SSI8>,
+				 <&mstp10_clks R8A7743_CLK_SSI7>, <&mstp10_clks R8A7743_CLK_SSI6>,
+				 <&mstp10_clks R8A7743_CLK_SSI5>, <&mstp10_clks R8A7743_CLK_SSI4>,
+				 <&mstp10_clks R8A7743_CLK_SSI3>, <&mstp10_clks R8A7743_CLK_SSI2>,
+				 <&mstp10_clks R8A7743_CLK_SSI1>, <&mstp10_clks R8A7743_CLK_SSI0>,
+				 <&mstp10_clks R8A7743_CLK_SCU_SRC9>, <&mstp10_clks R8A7743_CLK_SCU_SRC8>,
+				 <&mstp10_clks R8A7743_CLK_SCU_SRC7>, <&mstp10_clks R8A7743_CLK_SCU_SRC6>,
+				 <&mstp10_clks R8A7743_CLK_SCU_SRC5>, <&mstp10_clks R8A7743_CLK_SCU_SRC4>,
+				 <&mstp10_clks R8A7743_CLK_SCU_SRC3>, <&mstp10_clks R8A7743_CLK_SCU_SRC2>,
+				 <&mstp10_clks R8A7743_CLK_SCU_SRC1>, <&mstp10_clks R8A7743_CLK_SCU_SRC0>,
+				 <&mstp10_clks R8A7743_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7743_CLK_SCU_CTU1_MIX1>,
+				 <&mstp10_clks R8A7743_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7743_CLK_SCU_CTU1_MIX1>,
+				 <&mstp10_clks R8A7743_CLK_SCU_DVC0>, <&mstp10_clks R8A7743_CLK_SCU_DVC1>,
+				 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+				 <&m2_clk>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+				      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+				      "src.9", "src.8", "src.7", "src.6", "src.5",
+				      "src.4", "src.3", "src.2", "src.1", "src.0",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&cpg_clocks>;
+
+			status = "disabled";
+
+			rcar_sound,dvc {
+				dvc0: dvc at 0 {
+					dmas = <&audma1 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc at 1 {
+					dmas = <&audma1 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
+			rcar_sound,mix {
+				mix0: mix at 0 { };
+				mix1: mix at 1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu at 0 { };
+				ctu01: ctu at 1 { };
+				ctu02: ctu at 2 { };
+				ctu03: ctu at 3 { };
+				ctu10: ctu at 4 { };
+				ctu11: ctu at 5 { };
+				ctu12: ctu at 6 { };
+				ctu13: ctu at 7 { };
+			};
+
+			rcar_sound,src {
+				src0: src at 0 {
+					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x85>, <&audma1 0x9a>;
+					dma-names = "rx", "tx";
+				};
+				src1: src at 1 {
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma1 0x9c>;
+					dma-names = "rx", "tx";
+				};
+				src2: src at 2 {
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma1 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src at 3 {
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src at 4 {
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src at 5 {
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src at 6 {
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma1 0xb4>;
+					dma-names = "rx", "tx";
+				};
+				src7: src at 7 {
+					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x93>, <&audma1 0xb6>;
+					dma-names = "rx", "tx";
+				};
+				src8: src at 8 {
+					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x95>, <&audma1 0xb8>;
+					dma-names = "rx", "tx";
+				};
+				src9: src at 9 {
+					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x97>, <&audma1 0xba>;
+					dma-names = "rx", "tx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi at 0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi at 1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi at 2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi at 3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi at 4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi at 5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi at 6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi7: ssi at 7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi at 8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi at 9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+			};
+		};
 	};
 
 	/* External root clock */
-- 
2.7.4
