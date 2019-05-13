From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:14 +0100
Subject: [cip-dev] [PATCH 4.4.y 49/52] ARM: dts: r8a77470: Add EtherAVB
	support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-50-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit f70b0958c044a73188056a231d40a8af55c04dd2 upstream.

Define the generic R8A77470 part of the EtherAVB device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: reworked clocks and power-domains properties, removed
resets property]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 6f5fd91..3542678 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -260,6 +260,18 @@
 			dma-channels = <15>;
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a77470",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A77470_CLK_ETHERAVB>;
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77470", "renesas,scif";
 			reg = <0 0xe6e60000 0 0x40>;
-- 
2.7.4
