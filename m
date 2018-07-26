From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:19 +0100
Subject: [cip-dev] [PATCH 01/42] ARM: shmobile: Remove shmobile_boot_arg
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

CPU boot configuration writes to shmobile_boot_arg, which is located in
the .text section, and thus should not be written to.

As of commit 1d33a354bbb618ba ("ARM: shmobile: Per-CPU SMP boot / sleep
code for SCU SoCs"), and ignoring accidental remainings,
shmobile_boot_arg is always set to MPIDR_HWID_BITMASK by C code.
Hence we can just hardcode this in the assembler code, and remove the
variable, and thus also remove the need to write to this variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 901c5ffaaed117a38be9d0c29247c4888d6c8636)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/common.h       | 1 -
 arch/arm/mach-shmobile/headsmp.S      | 8 ++------
 arch/arm/mach-shmobile/platsmp-apmu.c | 1 -
 arch/arm/mach-shmobile/platsmp-scu.c  | 1 -
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 7b20b1b..f1ffff7 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -5,7 +5,6 @@ extern void shmobile_init_cntvoff(void);
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
-extern unsigned long shmobile_boot_arg;
 extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 94d86ed..32e0bf6 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -24,7 +24,6 @@
 	.arm
 	.align  12
 ENTRY(shmobile_boot_vector)
-	ldr     r0, 2f
 	ldr     r1, 1f
 	bx	r1
 
@@ -34,9 +33,6 @@ ENDPROC(shmobile_boot_vector)
 	.globl	shmobile_boot_fn
 shmobile_boot_fn:
 1:	.space	4
-	.globl	shmobile_boot_arg
-shmobile_boot_arg:
-2:	.space	4
 	.globl	shmobile_boot_size
 shmobile_boot_size:
 	.long	. - shmobile_boot_vector
@@ -46,9 +42,9 @@ shmobile_boot_size:
  */
 
 ENTRY(shmobile_smp_boot)
-						@ r0 = MPIDR_HWID_BITMASK
 	mrc	p15, 0, r1, c0, c0, 5		@ r1 = MPIDR
-	and	r0, r1, r0			@ r0 = cpu_logical_map() value
+	and	r0, r1, #0xffffff		@ MPIDR_HWID_BITMASK
+						@ r0 = cpu_logical_map() value
 	mov	r1, #0				@ r1 = CPU index
 	adr	r2, 1f
 	ldmia	r2, {r5, r6, r7}
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ffae187..067b252 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -195,7 +195,6 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 {
 	/* install boot code shared by all CPUs */
 	shmobile_smp_apmu_setup_boot();
-	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* perform per-cpu setup */
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 6466311..1f2e2e8 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -41,7 +41,6 @@ void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
-	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* enable SCU and cache coherency on booting CPU */
 	scu_enable(shmobile_scu_base);
-- 
2.7.4
