From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:28 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 12/12] ARM: dts:
	r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera DB
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 7fbbfe07b588cd81c1046a1846345a5cf614589a upstream.

This patch adds support for the camera daughter board which is
connected to iWave's RZ/G1N Qseven carrier board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 88c3f12..147c66b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -547,6 +547,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7744-iwg20d-q7.dtb \
+	r8a7744-iwg20d-q7-dbcm-ca.dtb \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
 	r8a77470-iwg23s-sbc.dtb \
diff --git a/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
new file mode 100644
index 0000000..3e58c2e9
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave Systems RZ/G1N Qseven board development
+ * platform with camera daughter board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a7744-iwg20m.dtsi"
+#include "iwg20d-q7-common.dtsi"
+#include "iwg20d-q7-dbcm-ca.dtsi"
+
+/ {
+	model = "iWave Systems RZ/G1N Qseven development platform with camera add-on";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7744";
+};
-- 
2.7.4
