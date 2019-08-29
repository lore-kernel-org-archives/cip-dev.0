From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:15 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 10/51] pinctrl: sh-pfc: Validate
	enum IDs for regs with fixed-width fields
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c481c8178420b8cc8b188807fe6eee8b069ce2d8 upstream.

Add build-time checks to the PINMUX_CFG_REG() and PINMUX_DATA_REG()
macros, to ensure the number of provided enum IDs is correct.

This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e97d0a4..c02b095 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -133,7 +133,9 @@ struct pinmux_cfg_reg {
  */
 #define PINMUX_CFG_REG(name, r, r_width, f_width, ids)			\
 	.reg = r, .reg_width = r_width,					\
-	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width),	\
+	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width) +	\
+	BUILD_BUG_ON_ZERO(sizeof((const u16 []) { ids }) / sizeof(u16) != \
+			  (r_width / f_width) * (1 << f_width)),	\
 	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])	\
 		{ ids }
 
@@ -199,7 +201,9 @@ struct pinmux_data_reg {
  *          enum ID must be specified, all wrapped using the GROUP() macro.
  */
 #define PINMUX_DATA_REG(name, r, r_width, ids)				\
-	.reg = r, .reg_width = r_width,					\
+	.reg = r, .reg_width = r_width +				\
+	BUILD_BUG_ON_ZERO(sizeof((const u16 []) { ids }) / sizeof(u16) != \
+			  r_width),					\
 	.enum_ids = (const u16 [r_width]) { ids }
 
 struct pinmux_irq {
-- 
2.7.4
