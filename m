From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:36 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 20/21] ARM: dts: r8a7744-iwg20m: Add
	iWave RZ/G1N Qseven SOM
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-21-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 3c248aefe73b5586347dae74b0a8d40aea1018b3 upstream.

Add support for iWave RZ/G1N Qseven System On Module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20m.dtsi

diff --git a/arch/arm/boot/dts/r8a7744-iwg20m.dtsi b/arch/arm/boot/dts/r8a7744-iwg20m.dtsi
new file mode 100644
index 0000000..6166ae0
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7744-iwg20m.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave RZ/G1N Qseven SOM
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+#include "r8a7744.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "iwave,g20m", "renesas,r8a7744";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
-- 
2.7.4
