From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:00 +0100
Subject: [cip-dev] [PATCH 4.4.y 35/52] ARM: dts: iwg23s-sbc: Add support for
	iWave G23S-SBC based on RZ/G1C
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-36-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit f922fb5af1584c35bcd8bf661738b16dd4f65441 upstream.

Add support for iWave iW-RainboW-G23S single board computer based on
 RZ/G1C.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 35 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9871a7f..28fbcdb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -548,6 +548,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
+	r8a77470-iwg23s-sbc.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
new file mode 100644
index 0000000..d21baad
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave-RZ/G1C single board computer
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a77470.dtsi"
+/ {
+	model = "iWave iW-RainboW-G23S single board computer based on RZ/G1C";
+	compatible = "iwave,g23s", "renesas,r8a77470";
+
+	aliases {
+		serial1 = &scif1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x20000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&scif1 {
+	status = "okay";
+};
-- 
2.7.4
