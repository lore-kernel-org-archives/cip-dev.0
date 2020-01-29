From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:30:01 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 08/12] arm64: dts: renesas: r8a774b1:
	Add INTC-EX device node
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 04360e4112c3e0e35c08b7fd8d0b2f6e68be4935 upstream.

Add support for the Interrupt Controller for External Devices
(INTC-EX) on RZ/G2N.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Link: https://lore.kernel.org/r/1570531132-21856-11-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 2e6bca7..46578de 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -282,6 +282,22 @@
 			#power-domain-cells = <1>;
 		};
 
+		intc_ex: interrupt-controller at e61c0000 {
+			compatible = "renesas,intc-ex-r8a774b1", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
+		};
+
 		i2c4: i2c at e66d8000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
