From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 Aug 2017 15:34:20 +0100
Subject: [cip-dev] [PATCH v2 15/18] ARM: dts: iwg20m: Add iWave RZG1M Qseven
	SOM
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504190063-61519-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for iWave RZG1M Qseven System On Module.
http://www.iwavesystems.com/rz-g1m-qseven-module.html

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit aabf13bac0046a1add4a3c39881ffb0abe692542)
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
new file mode 100644
index 0000000..001ca91
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -0,0 +1,29 @@
+/*
+ * Device Tree Source for the iWave-RZG1M-20M Qseven SOM
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "r8a7743.dtsi"
+
+/ {
+	compatible = "iwave,g20m", "renesas,r8a7743";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x20000000>;
+	};
+
+	memory at 200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x20000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
-- 
1.9.1
