From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Mon, 15 Oct 2018 11:23:27 +0100
Subject: [cip-dev] [PATCH 1/2] ARM: dts: r8a7745: Add PMU device node
In-Reply-To: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1539599008-8382-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1539599008-8382-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 9562a6b1d0f6a287f5dda16a4538526c59408927 upstream.

Enable support for the ARM Performance Monitor Units in the Cortex-A7
CPU cores on RZ/G1E by adding a device node for the PMU.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[Backport to CIP]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 69b383c..54b556b 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -93,6 +93,13 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.7.4
