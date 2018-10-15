From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Mon, 15 Oct 2018 11:23:28 +0100
Subject: [cip-dev] [PATCH 2/2] ARM: dts: r8a7743: Add PMU device node
In-Reply-To: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1539599008-8382-3-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit fe60e933b053f00e53cd01fe323f25ebe8fecd52 upstream.

Enable support for the ARM Performance Monitor Units in the Cortex-A15
CPU cores on RZ/G1M by adding a device node for the PMU.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[Backport to CIP]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index c78de96..264c8e0 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -76,6 +76,13 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.7.4
