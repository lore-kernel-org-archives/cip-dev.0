From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:38 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 11/41] pinctrl: sh-pfc: Validate
	enum IDs for regs with variable-width fields
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fa4d36712f20e2425171ab1f62341ebb6416d3ea upstream.

Add a run-time check to the PINMUX_CFG_REG_VAR() macro, to ensure the
number of provided enum IDs is correct.  This cannot be done at build
time, as the number of values depends on the variable-width fields in
the config register.

This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c   | 6 ++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 2c8c7b2..3ffd945 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -753,6 +753,12 @@ static void sh_pfc_check_cfg_reg(const char *drvname,
 		       drvname, cfg_reg->reg, rw, cfg_reg->reg_width);
 		sh_pfc_errors++;
 	}
+
+	if (n != cfg_reg->nr_enum_ids) {
+		pr_err("%s: reg 0x%x: enum_ids[] has %u instead of %u values\n",
+		       drvname, cfg_reg->reg, cfg_reg->nr_enum_ids, n);
+		sh_pfc_errors++;
+	}
 }
 
 static void sh_pfc_check_info(const struct sh_pfc_soc_info *info)
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index c02b095..499356d 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -114,6 +114,12 @@ struct pinmux_func {
 struct pinmux_cfg_reg {
 	u32 reg;
 	u8 reg_width, field_width;
+#ifdef DEBUG
+	u16 nr_enum_ids;	/* for variable width regs only */
+#define SET_NR_ENUM_IDS(n)	.nr_enum_ids = n,
+#else
+#define SET_NR_ENUM_IDS(n)
+#endif
 	const u16 *enum_ids;
 	const u8 *var_field_width;
 };
@@ -154,6 +160,7 @@ struct pinmux_cfg_reg {
 #define PINMUX_CFG_REG_VAR(name, r, r_width, f_widths, ids)		\
 	.reg = r, .reg_width = r_width,					\
 	.var_field_width = (const u8 []) { f_widths, 0 },		\
+	SET_NR_ENUM_IDS(sizeof((const u16 []) { ids }) / sizeof(u16))	\
 	.enum_ids = (const u16 []) { ids }
 
 struct pinmux_drive_reg_field {
-- 
2.7.4
