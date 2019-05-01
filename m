From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:10 +0100
Subject: [cip-dev] [PATCH 4.19.y 16/29] arm64: dts: renesas: r8a774c0: Add
	VIN and CSI-2 device nodes
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e961ab42e034d4690ab4fd6a112b50209dec46ea upstream.

Add device nodes for VIN4, VIN5 and CSI40 to RZ/G2E (a.k.a. R8A774C0)
SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 88 +++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index ea730c6..0450fb2 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1061,6 +1061,62 @@
 			status = "disabled";
 		};
 
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a774c0";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin4csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin4>;
+					};
+				};
+			};
+		};
+
+		vin5: video at e6ef5000 {
+			compatible = "renesas,vin-r8a774c0";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 806>;
+			renesas,id = <5>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin5csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin5>;
+					};
+				};
+			};
+		};
+
 		xhci0: usb at ee000000 {
 			compatible = "renesas,xhci-r8a774c0",
 				     "renesas,rcar-gen3-xhci";
@@ -1200,6 +1256,38 @@
 			status = "disabled";
 		};
 
+		csi40: csi2 at feaa0000 {
+			compatible = "renesas,r8a774c0-csi2",
+				     "renesas,rcar-gen3-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin4: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin4csi40>;
+					};
+					csi40vin5: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin5csi40>;
+					};
+				};
+			};
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.7.4
