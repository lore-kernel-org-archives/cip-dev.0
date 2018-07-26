From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:21 +0100
Subject: [cip-dev] [PATCH 03/42] ARM: shmobile: r8a7779: Remove remainings
	of removed SCU boot setup code
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 0ca2894b5a900709 ("ARM: shmobile: Use shared SCU SMP boot code on
r8a7779") obsoleted the r8a7779-specific SCU boot code, but forgot to
remove the setup of shmobile_boot_fn and shmobile_boot_arg, which is
overwritten by shmobile_smp_scu_prepare_cpus().

Note that shmobile_scu_base wasn't initialized at that point yet anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit b1568d80123a7e7ab528f587ef6896b2d5413b61)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 353562b8..5c2d80f 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -92,8 +92,6 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
 	__raw_writel(__pa(shmobile_boot_vector), AVECR);
-	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
-	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* setup r8a7779 specific SCU bits */
 	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
-- 
2.7.4
