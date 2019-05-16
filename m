From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:13 +0100
Subject: [cip-dev] [PATCH v2 01/52] ARM: shmobile: r8a77470: basic SoC
	support
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 0c1d543b75f242f08b08e7fb63a1df2ada025903 upstream.

Add minimal support for the RZ/G1C (R8A77470) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 arch/arm/mach-shmobile/Kconfig                     | 4 ++++
 arch/arm/mach-shmobile/pm-rcar-gen2.c              | 2 ++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index e27b38e..3b51d7e 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -17,6 +17,8 @@ SoCs:
     compatible = "renesas,r8a7743"
   - RZ/G1E (R8A77450)
     compatible = "renesas,r8a7745"
+  - RZ/G1C (R8A77470)
+    compatible = "renesas,r8a77470"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 602fc2d..31549b7 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -72,6 +72,10 @@ config ARCH_R8A7745
 	bool "RZ/G1E (R8A77450)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R8A77470
+	bool "RZ/G1C (R8A77470)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 0054561..419575e 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -101,6 +101,8 @@ void __init rcar_gen2_pm_init(void)
 		syscier = 0x00101003;
 	else if (of_machine_is_compatible("renesas,r8a7745"))
 		syscier = 0x00300060;
+	else if (of_machine_is_compatible("renesas,r8a77470"))
+		syscier = 0x00300060;
 
 	np = of_find_compatible_node(NULL, NULL, "renesas,smp-sram");
 	if (!np) {
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 50d7438..6e0c0ce 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -61,6 +61,7 @@ void __init rcar_gen2_timer_init(void)
 	shmobile_init_cntvoff();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
+	    of_machine_is_compatible("renesas,r8a77470") ||
 	    of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
 	} else {
@@ -208,6 +209,7 @@ MACHINE_END
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
 	"renesas,r8a7745",
+	"renesas,r8a77470",
 	NULL,
 };
 
-- 
2.7.4
