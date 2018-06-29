From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:56 +0100
Subject: [cip-dev] [PATCH 55/86] ARM: shmobile: rcar-gen2: Make sure CNTVOFF
	is initialized on CA7/15
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-56-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On Cortex-A7, the arch timer CNTVOFF register is uninitialized.
Ideally it should be initialized by the boot loader, but it isn't.

For the boot CPU, CNTVOFF is initialized by Linux since commit
9ce3fa6816c2fb59 ("ARM: shmobile: rcar-gen2: Add CA7 arch_timer
initialization for r8a7794").
For secondary CPU cores, no such initialization is done.

Hence when enabling SMP on r8a7794, the kernel log is spammed with:

    WARNING: Underflow in clocksource 'arch_sys_counter' observed, time update ignored.
	     Please report this, consider using a different clocksource, if possible.
	     Your kernel is probably still fine.

As Marc Zyngier pointed out that Cortex-A15 and Cortex-A7 are similar with
respect to CNTVOFF, we have been very lucky this just worked on R-Car
Gen2 SoCs with Cortex-A15 cores.

To fix this:
  - Move the existing inline asm code to initialize CNTVOFF to an
    assembler source file (adding comments and replacing hardcoded
    constants by definitions in the process), so it can be reused,
  - Perform the initialization of CNTVOFF on the boot CPU (Cortex-A15 or
    Cortex-A7) on all R-Car Gen2 and RZ/G1 parts,
  - Wrap the standard secondary_startup() routine inside a routine which
    initializes CNTVOFF.

Based on patches by Hisashi Nakamura in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 3fd45a136ff61bb54deab70fb2d534a85e40481f)
(move back to virt_to_phys to keep the code consistent)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile          |  1 +
 arch/arm/mach-shmobile/common.h          |  2 ++
 arch/arm/mach-shmobile/headsmp-apmu.S    | 37 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c    |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 20 ++---------------
 5 files changed, 43 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/headsmp-apmu.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 4620202..13a4b38 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -22,6 +22,7 @@ cpu-y				:= platsmp.o headsmp.o
 # Shared SoC family objects
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
+obj-$(CONFIG_ARCH_RCAR_GEN2)	+= headsmp-apmu.o
 obj-$(CONFIG_ARCH_R8A7790)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 9cb1121..7b20b1b 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -1,6 +1,7 @@
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
+extern void shmobile_init_cntvoff(void);
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
@@ -11,6 +12,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
+extern void shmobile_boot_apmu(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
new file mode 100644
index 0000000..db4743d
--- /dev/null
+++ b/arch/arm/mach-shmobile/headsmp-apmu.S
@@ -0,0 +1,37 @@
+/*
+ * SMP support for APMU based systems with Cortex A7/A15
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+ENTRY(shmobile_init_cntvoff)
+	/*
+	 * CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
+	 * then it should be handled by the secure code
+	 */
+	cps	#MON_MODE
+	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
+	orr	r0, r1, #1
+	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
+	instr_sync
+	mov	r0, #0
+	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
+	instr_sync
+	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
+	instr_sync
+	cps	#SVC_MODE
+	ret	lr
+ENDPROC(shmobile_init_cntvoff)
+
+ENTRY(shmobile_boot_apmu)
+	bl	shmobile_init_cntvoff
+	b	secondary_startup
+ENDPROC(shmobile_boot_apmu)
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 331409a..ffae187 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -204,7 +204,7 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-	shmobile_smp_hook(cpu, virt_to_phys(secondary_startup), 0);
+	shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_apmu), 0);
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 549a66f..828ce09 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -58,27 +58,11 @@ void __init rcar_gen2_timer_init(void)
 	int extal_mhz = 0;
 	u32 freq;
 
+	shmobile_init_cntvoff();
+
 	if (of_machine_is_compatible("renesas,r8a7745") ||
 	    of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
-		/* CNTVOFF has to be initialized either from non-secure
-		 * Hypervisor mode or secure Monitor mode with SCR.NS==1.
-		 * If TrustZone is enabled then it should be handled by the
-		 * secure code.
-		 */
-		asm volatile(
-		"	cps	0x16\n"
-		"	mrc	p15, 0, r1, c1, c1, 0\n"
-		"	orr	r0, r1, #1\n"
-		"	mcr	p15, 0, r0, c1, c1, 0\n"
-		"	isb\n"
-		"	mov	r0, #0\n"
-		"	mcrr	p15, 4, r0, r0, c14\n"
-		"	isb\n"
-		"	mcr	p15, 0, r1, c1, c1, 0\n"
-		"	isb\n"
-		"	cps	0x13\n"
-			: : : "r0", "r1");
 	} else {
 		/* At Linux boot time the r8a7790 arch timer comes up
 		 * with the counter disabled. Moreover, it may also report
-- 
2.7.4
