From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:47 +0000
Subject: [cip-dev] [PATCH 02/10] ARM: shmobile: apmu: Move #ifdef CONFIG_SMP
	to cover more functions
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

shmobile_smp_apmu_prepare_cpus() is used only if CONFIG_SMP=y.

Hence move the #ifdef to cover shmobile_smp_apmu_prepare_cpus() and all
functions only called by it (apmu_init_cpu() and apmu_parse_cfg()).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit d3f3fb0cfdcf4cbf69af65e8bfdde65cedf4e53a)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 911884f..cff623f 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -74,6 +74,7 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
 	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
 }
 
+#ifdef CONFIG_SMP
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
 	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
@@ -129,7 +130,6 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
 }
 
-#ifdef CONFIG_SMP
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-- 
2.7.4
