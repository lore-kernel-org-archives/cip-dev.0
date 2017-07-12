From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 12 Jul 2017 10:21:11 +0100
Subject: [cip-dev] [PATCH  6/6] ARM: shmobile: r8a7745: basic SoC support
In-Reply-To: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
References: <1499851271-20037-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499851271-20037-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add minimal support for the RZ/G1E (R8A7745) SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 47802fd7c7c4735ddaf004e0f61371dcaa86f4ad)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 arch/arm/mach-shmobile/Kconfig                     | 4 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 07b5818..b29d9c7 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -15,6 +15,8 @@ SoCs:
     compatible = "renesas,r8a7740"
   - RZ/G1M (R8A77430)
     compatible = "renesas,r8a7743"
+  - RZ/G1E (R8A77450)
+    compatible = "renesas,r8a7745"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 09929a3..602fc2d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -68,6 +68,10 @@ config ARCH_R8A7743
 	bool "RZ/G1M (R8A77430)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R8A7745
+	bool "RZ/G1E (R8A77450)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3b5f6ac..3911716 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -221,6 +221,7 @@ MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
 	"renesas,r8a7743",
+	"renesas,r8a7745",
 	NULL,
 };
 
-- 
1.9.1
