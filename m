From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:24:05 +0000
Subject: [cip-dev] [PATCH 07/18] arm64: Add Renesas R8A774C0 support
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add configuration option for the RZ/G2E (R8A774C0) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 692dce77dfb71b5eaf896d3cdc7ef72f70631b14)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 531ea50..71ae51d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -192,6 +192,12 @@ config ARCH_R8A774A1
 	help
 	  This enables support for the Renesas RZ/G2M SoC.
 
+config ARCH_R8A774C0
+	bool "Renesas RZ/G2E SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/G2E SoC.
+
 config ARCH_R8A7795
 	bool "Renesas R-Car H3 SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.7.4
