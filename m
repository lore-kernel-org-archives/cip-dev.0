From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:54 +0100
Subject: [cip-dev] [PATCH 4.4.y 29/52] ARM: dts: r8a77470: Initial SoC
	device tree
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-30-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 6929dfc5918049272e07653b1760b0b305f098e6 upstream.

The initial R8A77470 SoC device tree including CPU0, GIC, timer, SYSC, RST,
CPG, and the required clock descriptions.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: replaced renesas-cpg-mssr.h with r8a77470-clock.h,
taken out clocks, clock-names, power-domains, and resets properties,
and also taken out cpg, prr, and sysc nodes]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 121 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
new file mode 100644
index 0000000..a126bf5
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a77470 SoC
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r8a77470-clock.h>
+
+/ {
+	compatible = "renesas,r8a77470";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1000000000>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+
+		L2_CA7: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77470-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram at 0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x100>;
+			};
+		};
+
+		icram2:	sram at e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x20000>;
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a77470", "renesas,scif";
+			reg = <0 0xe6e68000 0 0x40>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+};
-- 
2.7.4
