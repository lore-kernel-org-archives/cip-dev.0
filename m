From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:46 +0100
Subject: [cip-dev] [PATCH 28/42] ARM: shmobile: rcar-gen2: Obtain jump stub
	region from DT
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-29-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for obtaining from DT the SRAM region to store the jump stub
for CPU core bringup, according to the renesas,smp-sram DT bindings.

If no region is specified in DT, the code falls back to hardcoded ICRAM1
as before, to maintain backwards compatibility.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 816756962b15f469d467b09beeb702af015c55cc)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 6556134..7a34ec9 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -11,7 +11,9 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/smp.h>
 #include <asm/io.h>
 #include "common.h"
@@ -73,8 +75,9 @@ void __init rcar_gen2_pm_init(void)
 	struct device_node *np, *cpus;
 	bool has_a7 = false;
 	bool has_a15 = false;
-	phys_addr_t boot_vector_addr = ICRAM1;
+	struct resource res;
 	u32 syscier = 0;
+	int error;
 
 	if (once++)
 		return;
@@ -99,14 +102,38 @@ void __init rcar_gen2_pm_init(void)
 	else if (of_machine_is_compatible("renesas,r8a7745"))
 		syscier = 0x00300060;
 
+	np = of_find_compatible_node(NULL, NULL, "renesas,smp-sram");
+	if (!np) {
+		/* No smp-sram in DT, fall back to hardcoded address */
+		res = (struct resource)DEFINE_RES_MEM(ICRAM1,
+						      shmobile_boot_size);
+		goto map;
+	}
+
+	error = of_address_to_resource(np, 0, &res);
+	if (error) {
+		pr_err("Failed to get smp-sram address: %d\n", error);
+		return;
+	}
+
+map:
 	/* RAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(boot_vector_addr, shmobile_boot_size);
+	if (res.start & (256 * 1024 - 1) ||
+	    resource_size(&res) < shmobile_boot_size) {
+		pr_err("Invalid smp-sram region\n");
+		return;
+	}
+
+	p = ioremap(res.start, resource_size(&res));
+	if (!p)
+		return;
+
 	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
 	iounmap(p);
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-	bar = phys_to_sbar(boot_vector_addr);
+	bar = phys_to_sbar(res.start);
 	if (has_a15) {
 		writel_relaxed(bar, p + CA15BAR);
 		writel_relaxed(bar | SBAR_BAREN, p + CA15BAR);
-- 
2.7.4
