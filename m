From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:45 +0100
Subject: [cip-dev] [PATCH 27/42] ARM: shmobile: rcar-gen2: Use ICRAM1 for
	jump stub on all SoCs
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently the different SoCs in the R-Car Gen2 family use different
types of on-chip RAM for the jump stub:
  - R-Car H2 uses Media RAM,
  - R-Car M2-W uses another type of optional On-chip RAM, as it doesn't
    have Media RAM,
  - R-Car M2-N uses Inter Connect RAM in Magnus Damm's "ARM: shmobile:
    r8a7793 boot address update".

As all R-Car Gen2 SoCs have 4 KiB of Inter Connect RAM, consolidate the
code by always using that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c94bc815f3c757df402d6f6a3e8d855b9168e6af)
(do not init boot_vector_addr for r8a7743 and r8a7745)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index cb7e764..6556134 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -37,8 +37,7 @@
 
 
 /* On-chip RAM */
-#define MERAM		0xe8080000
-#define RAM		0xe6300000
+#define ICRAM1		0xe63c0000	/* Inter Connect RAM1 (4 KiB) */
 
 static inline u32 phys_to_sbar(phys_addr_t addr)
 {
@@ -74,7 +73,7 @@ void __init rcar_gen2_pm_init(void)
 	struct device_node *np, *cpus;
 	bool has_a7 = false;
 	bool has_a15 = false;
-	phys_addr_t boot_vector_addr = 0;
+	phys_addr_t boot_vector_addr = ICRAM1;
 	u32 syscier = 0;
 
 	if (once++)
@@ -91,20 +90,14 @@ void __init rcar_gen2_pm_init(void)
 			has_a7 = true;
 	}
 
-	if (of_machine_is_compatible("renesas,r8a7790")) {
-		boot_vector_addr = MERAM;
+	if (of_machine_is_compatible("renesas,r8a7790"))
 		syscier = 0x013111ef;
-
-	} else if (of_machine_is_compatible("renesas,r8a7791")) {
-		boot_vector_addr = RAM;
+	else if (of_machine_is_compatible("renesas,r8a7791"))
 		syscier = 0x00111003;
-	} else if (of_machine_is_compatible("renesas,r8a7743")) {
-		boot_vector_addr = RAM;
+	else if (of_machine_is_compatible("renesas,r8a7743"))
 		syscier = 0x00101003;
-	} else if (of_machine_is_compatible("renesas,r8a7745")) {
-		boot_vector_addr = RAM;
+	else if (of_machine_is_compatible("renesas,r8a7745"))
 		syscier = 0x00300060;
-	}
 
 	/* RAM for jump stub, because BAR requires 256KB aligned address */
 	p = ioremap_nocache(boot_vector_addr, shmobile_boot_size);
-- 
2.7.4
