From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 14/32] drm: rcar-du: lvds: Add API to
	enable/disable clock output
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 02f2b30032c12b1b91abe5f2bd0d74ba1f700ea1 upstream.

On the D3 and E3 platforms, the LVDS internal PLL supplies the pixel
clock to the DU. This works automatically for LVDS outputs as the LVDS
encoder is enabled through the bridge API, enabling the internal PLL and
clock output. However, when using the DU DPAD output with the LVDS
outputs turned off, the LVDS PLL needs to be controlled manually. Add an
API to do so, to be called by the DU driver.

The drivers/gpu/drm/rcar-du/ directory has to be treated as obj-y
unconditionally, as the LVDS driver could be built-in while the DU
driver is compiled as a module.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/Makefile            |  2 +-
 drivers/gpu/drm/rcar-du/Kconfig     |  1 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 77 ++++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/rcar-du/rcar_lvds.h | 27 +++++++++++++
 4 files changed, 96 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_lvds.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index a6771ce..cde02d2 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_AST) += ast/
 obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
-obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
+obj-y			+= rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-y			+= omapdrm/
 obj-$(CONFIG_DRM_SUN4I) += sun4i/
diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index edde8d4..a9de227 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -3,6 +3,7 @@ config DRM_RCAR_DU
 	depends on DRM && OF
 	depends on ARM || ARM64
 	depends on ARCH_RENESAS || COMPILE_TEST
+	imply DRM_RCAR_LVDS
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 8b08d61..7f82bde 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -22,6 +22,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_panel.h>
 
+#include "rcar_lvds.h"
 #include "rcar_lvds_regs.h"
 
 struct rcar_lvds;
@@ -182,8 +183,9 @@ struct pll_info {
 
 static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 				     unsigned long target, struct pll_info *pll,
-				     u32 clksel)
+				     u32 clksel, bool dot_clock_only)
 {
+	unsigned int div7 = dot_clock_only ? 1 : 7;
 	unsigned long output;
 	unsigned long fin;
 	unsigned int m_min;
@@ -217,9 +219,9 @@ static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 	 *                     `------------> | |
 	 *                                    |/
 	 *
-	 * The /7 divider is optional when the LVDS PLL is used to generate a
-	 * dot clock for the DU RGB output, without using the LVDS encoder. We
-	 * don't support this configuration yet.
+	 * The /7 divider is optional, it is enabled when the LVDS PLL is used
+	 * to drive the LVDS encoder, and disabled when  used to generate a dot
+	 * clock for the DU RGB output, without using the LVDS encoder.
 	 *
 	 * The PLL allowed input frequency range is 12 MHz to 192 MHz.
 	 */
@@ -279,7 +281,7 @@ static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 				 * the PLL, followed by a an optional fixed /7
 				 * divider.
 				 */
-				fout = fvco / (1 << e) / 7;
+				fout = fvco / (1 << e) / div7;
 				div = DIV_ROUND_CLOSEST(fout, target);
 				diff = abs(fout / div - target);
 
@@ -300,7 +302,7 @@ static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 
 done:
 	output = fin * pll->pll_n / pll->pll_m / (1 << pll->pll_e)
-	       / 7 / pll->div;
+	       / div7 / pll->div;
 	error = (long)(output - target) * 10000 / (long)target;
 
 	dev_dbg(lvds->dev,
@@ -310,17 +312,18 @@ static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 		pll->pll_m, pll->pll_n, pll->pll_e, pll->div);
 }
 
-static void rcar_lvds_pll_setup_d3_e3(struct rcar_lvds *lvds, unsigned int freq)
+static void __rcar_lvds_pll_setup_d3_e3(struct rcar_lvds *lvds,
+					unsigned int freq, bool dot_clock_only)
 {
 	struct pll_info pll = { .diff = (unsigned long)-1 };
 	u32 lvdpllcr;
 
 	rcar_lvds_d3_e3_pll_calc(lvds, lvds->clocks.dotclkin[0], freq, &pll,
-				 LVDPLLCR_CKSEL_DU_DOTCLKIN(0));
+				 LVDPLLCR_CKSEL_DU_DOTCLKIN(0), dot_clock_only);
 	rcar_lvds_d3_e3_pll_calc(lvds, lvds->clocks.dotclkin[1], freq, &pll,
-				 LVDPLLCR_CKSEL_DU_DOTCLKIN(1));
+				 LVDPLLCR_CKSEL_DU_DOTCLKIN(1), dot_clock_only);
 	rcar_lvds_d3_e3_pll_calc(lvds, lvds->clocks.extal, freq, &pll,
-				 LVDPLLCR_CKSEL_EXTAL);
+				 LVDPLLCR_CKSEL_EXTAL, dot_clock_only);
 
 	lvdpllcr = LVDPLLCR_PLLON | pll.clksel | LVDPLLCR_CLKOUT
 		 | LVDPLLCR_PLLN(pll.pll_n - 1) | LVDPLLCR_PLLM(pll.pll_m - 1);
@@ -329,6 +332,9 @@ static void rcar_lvds_pll_setup_d3_e3(struct rcar_lvds *lvds, unsigned int freq)
 		lvdpllcr |= LVDPLLCR_STP_CLKOUTE | LVDPLLCR_OUTCLKSEL
 			 |  LVDPLLCR_PLLE(pll.pll_e - 1);
 
+	if (dot_clock_only)
+		lvdpllcr |= LVDPLLCR_OCKSEL;
+
 	rcar_lvds_write(lvds, LVDPLLCR, lvdpllcr);
 
 	if (pll.div > 1)
@@ -342,6 +348,57 @@ static void rcar_lvds_pll_setup_d3_e3(struct rcar_lvds *lvds, unsigned int freq)
 		rcar_lvds_write(lvds, LVDDIV, 0);
 }
 
+static void rcar_lvds_pll_setup_d3_e3(struct rcar_lvds *lvds, unsigned int freq)
+{
+	__rcar_lvds_pll_setup_d3_e3(lvds, freq, false);
+}
+
+/* -----------------------------------------------------------------------------
+ * Clock - D3/E3 only
+ */
+
+int rcar_lvds_clk_enable(struct drm_bridge *bridge, unsigned long freq)
+{
+	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
+	int ret;
+
+	if (WARN_ON(!(lvds->info->quirks & RCAR_LVDS_QUIRK_EXT_PLL)))
+		return -ENODEV;
+
+	dev_dbg(lvds->dev, "enabling LVDS PLL, freq=%luHz\n", freq);
+
+	WARN_ON(lvds->enabled);
+
+	ret = clk_prepare_enable(lvds->clocks.mod);
+	if (ret < 0)
+		return ret;
+
+	__rcar_lvds_pll_setup_d3_e3(lvds, freq, true);
+
+	lvds->enabled = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rcar_lvds_clk_enable);
+
+void rcar_lvds_clk_disable(struct drm_bridge *bridge)
+{
+	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
+
+	if (WARN_ON(!(lvds->info->quirks & RCAR_LVDS_QUIRK_EXT_PLL)))
+		return;
+
+	dev_dbg(lvds->dev, "disabling LVDS PLL\n");
+
+	WARN_ON(!lvds->enabled);
+
+	rcar_lvds_write(lvds, LVDPLLCR, 0);
+
+	clk_disable_unprepare(lvds->clocks.mod);
+
+	lvds->enabled = false;
+}
+EXPORT_SYMBOL_GPL(rcar_lvds_clk_disable);
+
 /* -----------------------------------------------------------------------------
  * Bridge
  */
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.h b/drivers/gpu/drm/rcar-du/rcar_lvds.h
new file mode 100644
index 0000000..a709cae
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * rcar_lvds.h  --  R-Car LVDS Encoder
+ *
+ * Copyright (C) 2013-2018 Renesas Electronics Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart at ideasonboard.com)
+ */
+
+#ifndef __RCAR_LVDS_H__
+#define __RCAR_LVDS_H__
+
+struct drm_bridge;
+
+#if IS_ENABLED(CONFIG_DRM_RCAR_LVDS)
+int rcar_lvds_clk_enable(struct drm_bridge *bridge, unsigned long freq);
+void rcar_lvds_clk_disable(struct drm_bridge *bridge);
+#else
+static inline int rcar_lvds_clk_enable(struct drm_bridge *bridge,
+				       unsigned long freq)
+{
+	return -ENOSYS;
+}
+static inline void rcar_lvds_clk_disable(struct drm_bridge *bridge) { }
+#endif /* CONFIG_DRM_RCAR_LVDS */
+
+#endif /* __RCAR_LVDS_H__ */
-- 
2.7.4
