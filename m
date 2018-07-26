From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:20 +0100
Subject: [cip-dev] [PATCH 02/42] ARM: shmobile: Remove shmobile_boot_arg
	from shmobile_smp_apmu_setup_boot
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This commit removes shmobile_boot_arg from shmobile_smp_apmu_setup_boot
as not used anymore.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 067b252..66fe008 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -186,7 +186,6 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
-	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 }
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
-- 
2.7.4
