From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:28 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 12/21] ARM: debug-ll: Add support for
	r8a7744
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit abf3bf537d298db18ad929ceb71c0353d6794f42 upstream.

Enable low-level debugging support for RZ/G1N (R8A7744). RZ/G1N uses
SCIF0 for the debug console.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[biju: Removed ARCH_R8A7792]
---
 arch/arm/Kconfig.debug | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e5c9e93..c4ac149 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -818,11 +818,12 @@ choice
 
 	config DEBUG_RCAR_GEN2_SCIF0
 		bool "Kernel low-level debugging messages via SCIF0 on R-Car Gen2 and RZ/G1"
-		depends on ARCH_R8A7743 || ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793
+		depends on ARCH_R8A7743 || ARCH_R8A7744 || ARCH_R8A7790 || \
+			ARCH_R8A7791 || ARCH_R8A7793
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
-		  M2-W (R8A7791), or M2-N (R8A7793).
+		  via SCIF0 on Renesas RZ/G1M (R8A7743), RZ/G1N (R8A7744),
+		  R-Car H2 (R8A7790), M2-W (R8A7791), or M2-N (R8A7793).
 
 	config DEBUG_RCAR_GEN2_SCIF1
 		bool "Kernel low-level debugging messages via SCIF1 on R8A77470"
-- 
2.7.4
