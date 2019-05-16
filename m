From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:29 +0100
Subject: [cip-dev] [PATCH v2 17/52] ARM: debug-ll: Add support for r8a77470
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-18-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 2f095c261a0fe15aacf1c3b2958b4d23a4735b4e upstream.

Enable low-level debugging support for RZ/G1C (r8a77470). RZ/G1C uses
SCIF1 for the debug console.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 arch/arm/Kconfig.debug | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c84f87b..e5c9e93 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -824,6 +824,13 @@ choice
 		  via SCIF0 on Renesas RZ/G1M (R8A7743), R-Car H2 (R8A7790),
 		  M2-W (R8A7791), or M2-N (R8A7793).
 
+	config DEBUG_RCAR_GEN2_SCIF1
+		bool "Kernel low-level debugging messages via SCIF1 on R8A77470"
+		depends on ARCH_R8A77470
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF1 on Renesas RZ/G1C (R8A77470).
+
 	config DEBUG_RCAR_GEN2_SCIF2
 		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
 		depends on ARCH_R8A7794
@@ -1340,6 +1347,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF0
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF0
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF1
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF4
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
@@ -1442,6 +1450,7 @@ config DEBUG_UART_PHYS
 	default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
 	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
+	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
@@ -1475,8 +1484,8 @@ config DEBUG_UART_PHYS
 		DEBUG_NETX_UART || \
 		DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
 		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
-		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
-		DEBUG_RCAR_GEN2_SCIF4 || \
+		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF1 || \
+		DEBUG_RCAR_GEN2_SCIF2 || DEBUG_RCAR_GEN2_SCIF4 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
-- 
2.7.4
