From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:48 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 38/39] arm64: dts: renesas: Add HiHope
	RZ/G2N main board support
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-39-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 83f7f812a8706aa9c23b02d945f670cdef116e2c upstream.

Basic support for the HiHope RZ/G2N main board:
  - Memory,
  - Main crystal,
  - Serial console

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1568725530-55241-5-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts     | 26 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index c216d4e..bfdb3b6 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
new file mode 100644
index 0000000..094b5ef
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2N main board
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774b1.dtsi"
+#include "hihope-common.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2N main board based on r8a774b1";
+	compatible = "hoperun,hihope-rzg2n", "renesas,r8a774b1";
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory at 480000000 {
+		device_type = "memory";
+		reg = <0x4 0x80000000 0x0 0x80000000>;
+	};
+};
-- 
2.7.4
