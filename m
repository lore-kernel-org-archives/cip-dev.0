From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:13 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/39] soc: renesas: Add Renesas
	R8A774B1 config option
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d634055c4b0f8c24269959f64b7d4a1a8d87d630 upstream.

Add configuration option for the RZ/G2N (R8A774B1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1567675844-19247-4-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Backported to 4.19-cip kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a6f9b64..b624cce 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -195,6 +195,12 @@ config ARCH_R8A774A1
 	help
 	  This enables support for the Renesas RZ/G2M SoC.
 
+config ARCH_R8A774B1
+	bool "Renesas RZ/G2N SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/G2N SoC.
+
 config ARCH_R8A774C0
 	bool "Renesas RZ/G2E SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.7.4
