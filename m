From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 12 Jul 2017 10:21:10 +0100
Subject: [cip-dev] [PATCH 5/6] ARM: shmobile: Consolidate R8A7743 and
	R8A779[234] machine definitions
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499851271-20037-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The four SoCs use identical machine operations, consolidate them into
two machine definitions in a single file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a0c4e2ccb31540f8972d8f36d32ace6b30e88e0f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Conflicts:
	arch/arm/mach-shmobile/Makefile
[modified]:arch/arm/mach-shmobile/setup-rcar-gen2.c
---
 arch/arm/mach-shmobile/Makefile          |  3 ---
 arch/arm/mach-shmobile/setup-r8a7743.c   | 34 --------------------------------
 arch/arm/mach-shmobile/setup-r8a7793.c   | 33 -------------------------------
 arch/arm/mach-shmobile/setup-r8a7794.c   | 33 -------------------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 32 ++++++++++++++++++++++++++++++
 5 files changed, 32 insertions(+), 103 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7743.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 2db5912..4620202 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -9,13 +9,10 @@ obj-y				:= timer.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
-obj-$(CONFIG_ARCH_R8A7743)	+= setup-r8a7743.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
-obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
-obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7743.c b/arch/arm/mach-shmobile/setup-r8a7743.c
deleted file mode 100644
index a7ecb82..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7743.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * r8a7743 processor support
- *
- * Copyright (C) 2016 Cogent Embedded, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation; of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "rcar-gen2.h"
-
-static const char * const r8a7743_boards_compat_dt[] __initconst = {
-	"renesas,r8a7743",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7743_DT, "Generic R8A7743 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7743_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
deleted file mode 100644
index 5fce87f..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7793.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * r8a7793 processor support
- *
- * Copyright (C) 2015  Ulrich Hecht
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "rcar-gen2.h"
-
-static const char * const r8a7793_boards_compat_dt[] __initconst = {
-	"renesas,r8a7793",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7793_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
deleted file mode 100644
index d2b0930..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * r8a7794 processor support
- *
- * Copyright (C) 2014  Renesas Electronics Corporation
- * Copyright (C) 2014  Ulrich Hecht
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/of_platform.h>
-#include "common.h"
-#include "rcar-gen2.h"
-#include <asm/mach/arch.h>
-
-static const char * const r8a7794_boards_compat_dt[] __initconst = {
-	"renesas,r8a7794",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_late	= shmobile_init_late,
-	.init_time	= rcar_gen2_timer_init,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7794_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 9eccde3..3b5f6ac 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
@@ -199,3 +200,34 @@ void __init rcar_gen2_reserve(void)
 					    &rcar_gen2_dma_contiguous, true);
 #endif
 }
+
+static const char * const rcar_gen2_boards_compat_dt[] __initconst = {
+	/*
+	 * R8A7790 and R8A7791 can't be handled here as long as they need SMP
+	 * initialization fallback.
+	 */
+	"renesas,r8a7793",
+	"renesas,r8a7794",
+	NULL,
+};
+
+DT_MACHINE_START(RCAR_GEN2_DT, "Generic R-Car Gen2 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
+	.dt_compat	= rcar_gen2_boards_compat_dt,
+MACHINE_END
+
+static const char * const rz_g1_boards_compat_dt[] __initconst = {
+	"renesas,r8a7743",
+	NULL,
+};
+
+DT_MACHINE_START(RZ_G1_DT, "Generic RZ/G1 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
+	.dt_compat	= rz_g1_boards_compat_dt,
+MACHINE_END
-- 
1.9.1
