From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:07 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 02/51] pinctrl: sh-pfc: Validate
	pinmux tables at runtime when debugging
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6161b39a14380815f22851c753c00acf81cfa62a upstream.

Perform some basic sanity checks on all built-in pinmux tables when
DEBUG is defined, to help catching bugs early.

For now the following checks are included:
  - Check register and field widths in descriptors for config registers
    with variable-width fields,
  - Check relations between pin groups and functions:
      - All pin functions must refer to existing pin groups,
      - All pin groups must be referred to by a pin function,
      - Warn if a pin group is referred to by multiple pin functions
	(which is OK for backwards-compatibility aliases),
  - Provide suggestions for reducing table sizes: reserved fields of
    more than 3 bits can better be split in smaller subfields, as the
    storage need is proportional to the square of the width of the
    (sub)field,

Note that a dummy non-matching entry is added to the DT match table for
checking r8a7795es1_pinmux_info, as R-Car H3 ES1.0 is matched using
soc_device_match() in r8a7795_pinmux_init(), instead of by the DT match
table.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 310b0dd..2c8c7b2 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -568,6 +568,13 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.compatible = "renesas,pfc-r8a7795",
 		.data = &r8a7795_pinmux_info,
 	},
+#ifdef DEBUG
+	{
+		/* For sanity checks only (nothing matches against this) */
+		.compatible = "renesas,pfc-r8a77950",	/* R-Car H3 ES1.0 */
+		.data = &r8a7795es1_pinmux_info,
+	},
+#endif /* DEBUG */
 #endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7796
 	{
@@ -706,6 +713,122 @@ static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
 #define DEV_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
 
+#ifdef DEBUG
+static bool is0s(const u16 *enum_ids, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		if (enum_ids[i])
+			return false;
+
+	return true;
+}
+
+static unsigned int sh_pfc_errors;
+static unsigned int sh_pfc_warnings;
+
+static void sh_pfc_check_cfg_reg(const char *drvname,
+				 const struct pinmux_cfg_reg *cfg_reg)
+{
+	unsigned int i, n, rw, fw;
+
+	if (cfg_reg->field_width) {
+		/* Checked at build time */
+		return;
+	}
+
+	for (i = 0, n = 0, rw = 0; (fw = cfg_reg->var_field_width[i]); i++) {
+		if (fw > 3 && is0s(&cfg_reg->enum_ids[n], 1 << fw)) {
+			pr_warn("%s: reg 0x%x: reserved field [%u:%u] can be split to reduce table size\n",
+				drvname, cfg_reg->reg, rw, rw + fw - 1);
+			sh_pfc_warnings++;
+		}
+		n += 1 << fw;
+		rw += fw;
+	}
+
+	if (rw != cfg_reg->reg_width) {
+		pr_err("%s: reg 0x%x: var_field_width declares %u instead of %u bits\n",
+		       drvname, cfg_reg->reg, rw, cfg_reg->reg_width);
+		sh_pfc_errors++;
+	}
+}
+
+static void sh_pfc_check_info(const struct sh_pfc_soc_info *info)
+{
+	const struct sh_pfc_function *func;
+	const char *drvname = info->name;
+	unsigned int *refcnts;
+	unsigned int i, j, k;
+
+	pr_info("Checking %s\n", drvname);
+
+	/* Check groups and functions */
+	refcnts = kcalloc(info->nr_groups, sizeof(*refcnts), GFP_KERNEL);
+	if (!refcnts)
+		return;
+
+	for (i = 0; i < info->nr_functions; i++) {
+		func = &info->functions[i];
+		for (j = 0; j < func->nr_groups; j++) {
+			for (k = 0; k < info->nr_groups; k++) {
+				if (!strcmp(func->groups[j],
+					    info->groups[k].name)) {
+					refcnts[k]++;
+					break;
+				}
+			}
+
+			if (k == info->nr_groups) {
+				pr_err("%s: function %s: group %s not found\n",
+				       drvname, func->name, func->groups[j]);
+				sh_pfc_errors++;
+			}
+		}
+	}
+
+	for (i = 0; i < info->nr_groups; i++) {
+		if (!refcnts[i]) {
+			pr_err("%s: orphan group %s\n", drvname,
+			       info->groups[i].name);
+			sh_pfc_errors++;
+		} else if (refcnts[i] > 1) {
+			pr_err("%s: group %s referred by %u functions\n",
+			       drvname, info->groups[i].name, refcnts[i]);
+			sh_pfc_warnings++;
+		}
+	}
+
+	kfree(refcnts);
+
+	/* Check config register descriptions */
+	for (i = 0; info->cfg_regs && info->cfg_regs[i].reg; i++)
+		sh_pfc_check_cfg_reg(drvname, &info->cfg_regs[i]);
+}
+
+static void sh_pfc_check_driver(const struct platform_driver *pdrv)
+{
+	unsigned int i;
+
+	pr_warn("Checking builtin pinmux tables\n");
+
+	for (i = 0; pdrv->id_table[i].name[0]; i++)
+		sh_pfc_check_info((void *)pdrv->id_table[i].driver_data);
+
+#ifdef CONFIG_OF
+	for (i = 0; pdrv->driver.of_match_table[i].compatible[0]; i++)
+		sh_pfc_check_info(pdrv->driver.of_match_table[i].data);
+#endif
+
+	pr_warn("Detected %u errors and %u warnings\n", sh_pfc_errors,
+		sh_pfc_warnings);
+}
+
+#else /* !DEBUG */
+static inline void sh_pfc_check_driver(struct platform_driver *pdrv) {}
+#endif /* !DEBUG */
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
@@ -837,6 +960,7 @@ static struct platform_driver sh_pfc_driver = {
 
 static int __init sh_pfc_init(void)
 {
+	sh_pfc_check_driver(&sh_pfc_driver);
 	return platform_driver_register(&sh_pfc_driver);
 }
 postcore_initcall(sh_pfc_init);
-- 
2.7.4
