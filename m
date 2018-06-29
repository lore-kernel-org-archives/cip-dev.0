From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:23 +0100
Subject: [cip-dev] [PATCH 22/86] ARM: dts: iwg22d-sodimm: Add support for
	iWave G22D-SODIMM board
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for iWave RainboW-G22D-SODIMM board based on RZ/G1E.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a59eb272a4eae10eb4f7a3e7b15aa47d57b32699)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 22fc8ab..20ca8fc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -546,6 +546,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
+	r8a7745-iwg22d-sodimm.dtb \
 	r8a7778-bockw.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
new file mode 100644
index 0000000..cbc19fe
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -0,0 +1,29 @@
+/*
+ * Device Tree Source for the iWave-RZG1E SODIMM carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7745-iwg22m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G22D-SODIMM board based on RZ/G1E";
+	compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745";
+
+	aliases {
+		serial0 = &scif4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&scif4 {
+	status = "okay";
+};
-- 
2.7.4
