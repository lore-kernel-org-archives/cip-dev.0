From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:22 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/21] ARM: shmobile: r8a7744: Basic SoC
	support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit bc8871536246e489407a7114a597c0a2a72de895 upstream.

Add minimal support for the RZ/G1N (R8A7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ removed compatible string renesas,r8a7744-cpg-mssr ]
---
 arch/arm/mach-shmobile/Kconfig           | 5 +++++
 arch/arm/mach-shmobile/pm-rcar-gen2.c    | 2 ++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 31549b7..79b66a1 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -68,6 +68,11 @@ config ARCH_R8A7743
 	bool "RZ/G1M (R8A77430)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R8A7744
+	bool "RZ/G1N (R8A77440)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+
 config ARCH_R8A7745
 	bool "RZ/G1E (R8A77450)"
 	select ARCH_RCAR_GEN2
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 419575e..dd1c9e0 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -99,6 +99,8 @@ void __init rcar_gen2_pm_init(void)
 		syscier = 0x00111003;
 	else if (of_machine_is_compatible("renesas,r8a7743"))
 		syscier = 0x00101003;
+	else if (of_machine_is_compatible("renesas,r8a7744"))
+		syscier = 0x00101003;
 	else if (of_machine_is_compatible("renesas,r8a7745"))
 		syscier = 0x00300060;
 	else if (of_machine_is_compatible("renesas,r8a77470"))
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 6e0c0ce..50c57c8 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -208,6 +208,7 @@ MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
+	"renesas,r8a7744",
 	"renesas,r8a7745",
 	"renesas,r8a77470",
 	NULL,
-- 
2.7.4
