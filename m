From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:49 +0000
Subject: [cip-dev] [PATCH 04/10] ARM: shmobile: apmu: Add debug resource
	reset for secondary CPU boot
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

In debug mode (MD21=1), reset requests derived from power-shutoff to the
AP-system CPU cores must be enabled before the AP-system CPU cores
resume from power-shutoff for the first time. Else resume may fail,
causing the system to hang during boot.

As setting these bits is a no-op in normal mode, there's no need to
check the actual state of MD21 first.

Inspired by CPU-specific patches in the BSP by Hisashi Nakamura
<hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 10f778a97845e8b10af8878af99c9cfe6c31baf9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	arch/arm/mach-shmobile/platsmp-apmu.c
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 444765e..81a687f 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -35,6 +35,13 @@ static struct {
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
 
+#define DBGRCR_OFFS	0x180		/* Debug Resource Reset Control Reg. */
+
+/* Debug Resource Reset Control Register */
+#define DBGCPUREN	BIT(24)		/* CPU Other Reset Request Enable */
+#define DBGCPUNREN(n)	BIT((n) + 20)	/* CPUn Reset Request Enable */
+#define DBGCPUPREN	BIT(19)		/* CPU Peripheral Reset Req. Enable */
+
 static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 {
 	/* request power on */
@@ -78,6 +85,8 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
 #ifdef CONFIG_SMP
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
+	u32 x;
+
 	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
 		return;
 
@@ -85,6 +94,11 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	apmu_cpus[cpu].bit = bit;
 
 	pr_debug("apmu ioremap %d %d %pr\n", cpu, bit, res);
+
+	/* Setup for debug mode */
+	x = readl(apmu_cpus[cpu].iomem + DBGRCR_OFFS);
+	x |= DBGCPUREN | DBGCPUNREN(bit) | DBGCPUPREN;
+	writel(x, apmu_cpus[cpu].iomem + DBGRCR_OFFS);
 }
 
 static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
-- 
2.7.4
