From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:22 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 17/51] pinctrl: sh-pfc: Mark
	run-time debug code __init
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-18-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 80cde64f68ff09617f89e78dfadf5a6873be87a8 upstream.

All run-time debug code is called from sh_pfc_init(), which is __init.

Fixes: 6161b39a14380815 ("pinctrl: sh-pfc: Validate pinmux tables at runtime when debugging")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 09b58eb..5c4f441 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -714,7 +714,7 @@ static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
 #endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
 
 #ifdef DEBUG
-static bool is0s(const u16 *enum_ids, unsigned int n)
+static bool __init is0s(const u16 *enum_ids, unsigned int n)
 {
 	unsigned int i;
 
@@ -725,11 +725,11 @@ static bool is0s(const u16 *enum_ids, unsigned int n)
 	return true;
 }
 
-static unsigned int sh_pfc_errors;
-static unsigned int sh_pfc_warnings;
+static unsigned int sh_pfc_errors __initdata = 0;
+static unsigned int sh_pfc_warnings __initdata = 0;
 
-static void sh_pfc_check_cfg_reg(const char *drvname,
-				 const struct pinmux_cfg_reg *cfg_reg)
+static void __init sh_pfc_check_cfg_reg(const char *drvname,
+					const struct pinmux_cfg_reg *cfg_reg)
 {
 	unsigned int i, n, rw, fw;
 
@@ -761,7 +761,7 @@ static void sh_pfc_check_cfg_reg(const char *drvname,
 	}
 }
 
-static void sh_pfc_check_info(const struct sh_pfc_soc_info *info)
+static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 {
 	const struct sh_pfc_function *func;
 	const char *drvname = info->name;
@@ -813,7 +813,7 @@ static void sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 		sh_pfc_check_cfg_reg(drvname, &info->cfg_regs[i]);
 }
 
-static void sh_pfc_check_driver(const struct platform_driver *pdrv)
+static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
 {
 	unsigned int i;
 
-- 
2.7.4
