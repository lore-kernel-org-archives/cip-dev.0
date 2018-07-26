From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:47 +0100
Subject: [cip-dev] [PATCH 29/42] ARM: shmobile: rcar-gen2: Add watchdog
	support
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-30-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds watchdog support by installing shmobile_boot_vector_gen2
to ICRAM1 when enough memory is available, in which case we also keep a
copy of MPIDR to complete the reset vector logic.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 01d675f159e0f0792947fb823cf2425da4d747ad)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 66fe008..4153d5a 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -186,6 +186,7 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+	shmobile_boot_fn_gen2 = shmobile_boot_fn;
 }
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 7a34ec9..0054561 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <asm/io.h>
+#include <asm/cputype.h>
 #include "common.h"
 #include "pm-rcar.h"
 #include "rcar-gen2.h"
@@ -37,7 +38,6 @@
 #define CA7RESCNT_CODE	0x5a5a0000
 #define CA7RESCNT_CPUS	0xf		/* CPU0-3 */
 
-
 /* On-chip RAM */
 #define ICRAM1		0xe63c0000	/* Inter Connect RAM1 (4 KiB) */
 
@@ -127,8 +127,17 @@ map:
 	p = ioremap(res.start, resource_size(&res));
 	if (!p)
 		return;
-
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	/*
+	 * install the reset vector, use the largest version if we have enough
+	 * memory available
+	 */
+	if (resource_size(&res) >= shmobile_boot_size_gen2) {
+		shmobile_boot_cpu_gen2 = read_cpuid_mpidr();
+		memcpy_toio(p, shmobile_boot_vector_gen2,
+			    shmobile_boot_size_gen2);
+	} else {
+		memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	}
 	iounmap(p);
 
 	/* setup reset vectors */
-- 
2.7.4
