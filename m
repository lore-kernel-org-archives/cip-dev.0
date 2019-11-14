From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 14/21] pinctrl: sh-pfc: r8a7791: Add
	r8a7744 support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d7097b97e91362ded242e5516f8d97b985f60941 upstream.

Renesas RZ/G1N (R8A7744) is pin compatible with R-Car M2-W/N (R8A7791/3)
and RZ/G1M.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/Kconfig       |  5 +++++
 drivers/pinctrl/sh-pfc/Makefile      |  1 +
 drivers/pinctrl/sh-pfc/core.c        |  6 ++++++
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 21 +++++++++++++++++++++
 5 files changed, 34 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index ab15d19..eef770b 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -40,6 +40,11 @@ config PINCTRL_PFC_R8A7743
 	depends on ARCH_R8A7743
 	select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A7744
+	def_bool y
+	depends on ARCH_R8A7744
+	select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_R8A7745
         def_bool y
         depends on ARCH_R8A7745
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index e9ef2cc..5310c07 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PINCTRL_PFC_EMEV2)	+= pfc-emev2.o
 obj-$(CONFIG_PINCTRL_PFC_R8A73A4)	+= pfc-r8a73a4.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7740)	+= pfc-r8a7740.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7743)	+= pfc-r8a7791.o
+obj-$(CONFIG_PINCTRL_PFC_R8A7744)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7745)	+= pfc-r8a7794.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77470)	+= pfc-r8a77470.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7778)	+= pfc-r8a7778.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index c3a3283..6827a39 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -459,6 +459,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7743_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7744
+	{
+		.compatible = "renesas,pfc-r8a7744",
+		.data = &r8a7744_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7745
 	{
 		.compatible = "renesas,pfc-r8a7745",
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 37acc88..5675ecf 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -70,6 +70,7 @@ extern const struct sh_pfc_soc_info emev2_pinmux_info;
 extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7743_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7744_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7745_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77470_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 4f971a9..f8bbc70 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -6623,6 +6623,27 @@ const struct sh_pfc_soc_info r8a7743_pinmux_info = {
 };
 #endif
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7744
+const struct sh_pfc_soc_info r8a7744_pinmux_info = {
+	.name = "r8a77440_pfc",
+	.unlock_reg = 0xe6060000, /* PMMR */
+
+	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
+
+	.pins = pinmux_pins,
+	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups.common,
+	.nr_groups = ARRAY_SIZE(pinmux_groups.common),
+	.functions = pinmux_functions.common,
+	.nr_functions = ARRAY_SIZE(pinmux_functions.common),
+
+	.cfg_regs = pinmux_config_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
+
 #ifdef CONFIG_PINCTRL_PFC_R8A7791
 const struct sh_pfc_soc_info r8a7791_pinmux_info = {
 	.name = "r8a77910_pfc",
-- 
2.7.4
