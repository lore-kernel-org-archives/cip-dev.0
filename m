From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 16:22:12 +0000
Subject: [cip-dev] [PATCH 03/10] arm64: dts: renesas: Add Si-Linux CAT874
	board support
In-Reply-To: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
References: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553185339-26890-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Basic support for the Si-Linux board based on RZ/G2E:
  - Memory,
  - Main crystal,
  - Serial console

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit d828266bb19a901c14b9d5518043f3582629938f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile            |  1 +
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 9e2394b..3744f8d 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
new file mode 100644
index 0000000..6eababc
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Silicon Linux RZ/G2E 96board platform (CAT874)
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774c0.dtsi"
+
+/ {
+	model = "Silicon Linux RZ/G2E 96board platform (CAT874)";
+	compatible = "si-linux,cat874", "renesas,r8a774c0";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <48000000>;
+};
+
+&scif2 {
+	status = "okay";
+};
-- 
2.7.4
