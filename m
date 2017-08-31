From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 Aug 2017 15:34:21 +0100
Subject: [cip-dev] [PATCH v2 16/18] ARM: dts: iwg20d-q7: Add support for
	iWave G20D-Q7 board based on RZ/G1M
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504190063-61519-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for iWave RainboW-G20D-Qseven board based on RZ/G1M.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ad2c0558d0494b420cadd6e887ddab2cd4e27e48)

Conflicts:
	arch/arm/boot/dts/Makefile
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..f8fd692 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -544,6 +544,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r7s72100-genmai.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7743-iwg20d-q7.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
new file mode 100644
index 0000000..9b54783
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -0,0 +1,25 @@
+/*
+ * Device Tree Source for the iWave-RZG1M Qseven carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7743-iwg20m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
+
+	aliases {
+		serial0 = &scif0;
+	};
+};
+
+&scif0 {
+	status = "okay";
+};
-- 
1.9.1
