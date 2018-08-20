From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 20 Aug 2018 15:42:07 +0100
Subject: [cip-dev] [PATCH v2 05/42] soc: renesas: Add R-Car RST driver
In-Reply-To: <1534558024.3135.18.camel@codethink.co.uk>
References: <1534558024.3135.18.camel@codethink.co.uk>
Message-ID: <1534776127-30609-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a driver for the Renesas R-Car Gen1 RESET/WDT and R-Car Gen2/Gen3
and RZ/G RST module.

For now this driver just provides an API to obtain the state of the mode
pins, as latched at reset time.  As this is typically called from the
probe function of a clock driver, which can run much earlier than any
initcall, calling rcar_rst_read_mode_pins() just forces an early
initialization of the driver.

Despite the current simple and almost identical handling for all
supported SoCs, the driver matches against SoC-specific compatible
values, as the features provided by the hardware module differ a lot
across the various SoC families and members.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
(cherry picked from commit 527c02f66d263d2eeff237a2326c3278cfc03d3b
and squashed commit 69e0d1b8db8f8cc319f966ec3eb2fffce28c4f28 into it)
(Added renesas directory to driver/soc/Makefile. Modified
drivers/soc/renesas/Makefile to only compile rcar-rst.c for R-Car
Gen2. Removed R-Car Gen3 and R-Car Gen1 from rcar_rst_matches and
stripped read mode pins logic from the driver. Got rid of
rcar_rst_read_mode_pins, advertising rcar_rst_init instead)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v1->v2:
* deleted rcar_rst_gen1
* added reference to the upstream commit for configure operation to the
  changelog

 drivers/soc/Makefile                 |  1 +
 drivers/soc/renesas/Makefile         |  1 +
 drivers/soc/renesas/rcar-rst.c       | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/soc/renesas/rcar-rst.h |  6 +++
 4 files changed, 85 insertions(+)
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/rcar-rst.c
 create mode 100644 include/linux/soc/renesas/rcar-rst.h

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index f2ba2e9..c87aada 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
new file mode 100644
index 0000000..8751756
--- /dev/null
+++ b/drivers/soc/renesas/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_RCAR_GEN2)	+= rcar-rst.o
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
new file mode 100644
index 0000000..0622006
--- /dev/null
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -0,0 +1,77 @@
+/*
+ * R-Car Gen2 and RZ/G RST Driver
+ *
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/soc/renesas/rcar-rst.h>
+
+#define WDTRSTCR_RESET		0xA55A0002
+#define WDTRSTCR		0x0054
+
+static int rcar_rst_enable_wdt_reset(void __iomem *base)
+{
+	iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
+	return 0;
+}
+
+struct rst_config {
+	int (*configure)(void *base);	/* Platform specific configuration */
+};
+
+static const struct rst_config rcar_rst_gen2 __initconst = {
+	.configure = rcar_rst_enable_wdt_reset,
+};
+
+static const struct of_device_id rcar_rst_matches[] __initconst = {
+	/* RZ/G is handled like R-Car Gen2 */
+	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
+	/* R-Car Gen2 */
+	{ .compatible = "renesas,r8a7790-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7791-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7792-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7793-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a7794-rst", .data = &rcar_rst_gen2 },
+	{ /* sentinel */ }
+};
+
+static void __iomem *rcar_rst_base __initdata;
+
+void __init rcar_rst_init(void)
+{
+	const struct of_device_id *match;
+	const struct rst_config *cfg;
+	struct device_node *np;
+	void __iomem *base;
+
+	if (rcar_rst_base)
+		return;
+
+	np = of_find_matching_node_and_match(NULL, rcar_rst_matches, &match);
+	if (!np)
+		return;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("%s: Cannot map regs\n", np->full_name);
+		goto out_put;
+	}
+
+	rcar_rst_base = base;
+	cfg = match->data;
+	if (cfg->configure)
+		if (cfg->configure(base))
+			pr_warn("%pOF: Cannot run SoC specific configuration\n",
+				np);
+
+out_put:
+	of_node_put(np);
+}
diff --git a/include/linux/soc/renesas/rcar-rst.h b/include/linux/soc/renesas/rcar-rst.h
new file mode 100644
index 0000000..6b1f492
--- /dev/null
+++ b/include/linux/soc/renesas/rcar-rst.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_SOC_RENESAS_RCAR_RST_H__
+#define __LINUX_SOC_RENESAS_RCAR_RST_H__
+
+void rcar_rst_init(void);
+
+#endif /* __LINUX_SOC_RENESAS_RCAR_RST_H__ */
-- 
2.7.4
