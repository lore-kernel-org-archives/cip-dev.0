From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:50 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 6/6] arm64: dts: renesas: r8a774c0:
	sort subnodes of the soc node
In-Reply-To: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200930-39297-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Sort subnodes of the soc node.
- The primary key is the bus address.
- The secondary key is the IP block.
- The tertiary key is the node name.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 248 +++++++++++++++---------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 805042d..b92c60c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -378,6 +378,71 @@
 			resets = <&cpg 407>;
 		};
 
+		tmu0: timer at e61e0000 {
+			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
+			reg = <0 0xe61e0000 0 0x30>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 125>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 125>;
+			status = "disabled";
+		};
+
+		tmu1: timer at e6fc0000 {
+			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
+			reg = <0 0xe6fc0000 0 0x30>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		tmu2: timer at e6fd0000 {
+			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
+			reg = <0 0xe6fd0000 0 0x30>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 123>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 123>;
+			status = "disabled";
+		};
+
+		tmu3: timer at e6fe0000 {
+			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
+			reg = <0 0xe6fe0000 0 0x30>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 122>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 122>;
+			status = "disabled";
+		};
+
+		tmu4: timer at ffc00000 {
+			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
+			reg = <0 0xffc00000 0 0x30>;
+			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 121>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 121>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at e6500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -521,71 +586,6 @@
 			status = "disabled";
 		};
 
-		tmu0: timer at e61e0000 {
-			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
-			reg = <0 0xe61e0000 0 0x30>;
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 125>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 125>;
-			status = "disabled";
-		};
-
-		tmu1: timer at e6fc0000 {
-			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
-			reg = <0 0xe6fc0000 0 0x30>;
-			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 124>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 124>;
-			status = "disabled";
-		};
-
-		tmu2: timer at e6fd0000 {
-			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
-			reg = <0 0xe6fd0000 0 0x30>;
-			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 123>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 123>;
-			status = "disabled";
-		};
-
-		tmu3: timer at e6fe0000 {
-			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
-			reg = <0 0xe6fe0000 0 0x30>;
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 122>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 122>;
-			status = "disabled";
-		};
-
-		tmu4: timer at ffc00000 {
-			compatible = "renesas,tmu-r8a774c0", "renesas,tmu";
-			reg = <0 0xffc00000 0 0x30>;
-			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 121>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 121>;
-			status = "disabled";
-		};
-
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a774c0",
 				     "renesas,rcar-gen3-hscif",
@@ -1279,65 +1279,6 @@
 			};
 		};
 
-		xhci0: usb at ee000000 {
-			compatible = "renesas,xhci-r8a774c0",
-				     "renesas,rcar-gen3-xhci";
-			reg = <0 0xee000000 0 0xc00>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
-			status = "disabled";
-		};
-
-		usb3_peri0: usb at ee020000 {
-			compatible = "renesas,r8a774c0-usb3-peri",
-				     "renesas,rcar-gen3-usb3-peri";
-			reg = <0 0xee020000 0 0x400>;
-			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
-			status = "disabled";
-		};
-
-		ohci0: usb at ee080000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee080000 0 0x100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 703>, <&cpg 704>;
-			status = "disabled";
-		};
-
-		ehci0: usb at ee080100 {
-			compatible = "generic-ehci";
-			reg = <0 0xee080100 0 0x100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
-			companion = <&ohci0>;
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 703>, <&cpg 704>;
-			status = "disabled";
-		};
-
-		usb2_phy0: usb-phy at ee080200 {
-			compatible = "renesas,usb2-phy-r8a774c0",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee080200 0 0x700>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
-			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-			resets = <&cpg 703>, <&cpg 704>;
-			#phy-cells = <0>;
-			status = "disabled";
-		};
-
 		rcar_sound: sound at ec500000 {
 			/*
 			 * #sound-dai-cells is required
@@ -1587,6 +1528,65 @@
 				 <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
 
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a774c0",
+				     "renesas,rcar-gen3-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a774c0-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
+			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			status = "disabled";
+		};
+
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			status = "disabled";
+		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a774c0",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a774c0",
 				     "renesas,rcar-gen3-sdhi";
-- 
2.7.4
