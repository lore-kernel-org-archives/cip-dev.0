From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  9 Sep 2019 09:52:04 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/4] arm64: dts: renesas: r8a774a1: Fix
	USB 2.0 clocks
In-Reply-To: <1568019126-45985-1-git-send-email-biju.das@bp.renesas.com>
References: <1568019126-45985-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1568019126-45985-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a573cb676d54ce314f58e129f8d69ff09c9a92cf upstream.

Similarly to what done for the r8a7796 with commit 737e05bf034e
("arm64: dts: renesas: revise properties for R-Car Gen3 SoCs'
usb 2.0"), this patch lists the clock for the USB High-Speed Module
(HS-USB) with the USB2.0 Host (EHCI/OHCI) IP DT node, and it lists
the clock for the USB2.0 Host IP with the HS-USB module DT node.

Fixes: 4c2c2fb99876 ("arm64: dts: renesas: r8a774a1: Add USB2.0 phy and host(EHCI/OHCI) device nodes")
Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index bdf4292..892db7d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -821,7 +821,7 @@
 				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 			       <&usb_dmac1 0>, <&usb_dmac1 1>;
 			dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -829,7 +829,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 704>, <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1655,11 +1655,11 @@
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1679,12 +1679,12 @@
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1706,9 +1706,9 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 703>, <&cpg 704>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.7.4
