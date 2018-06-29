From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:35 +0100
Subject: [cip-dev] [PATCH 34/86] pinctrl: sh-pfc: r8a7794: Add R8A7745
	support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-35-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Renesas RZ/G1E (R8A7745) is pin compatible with R-Car E2 (R8A7794),
however it doesn't have several automotive specific peripherals.
Annotate all the items that only exist on the R-Car SoCs...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Rob Herring <robh@kernel.org>
[geert: Drop annotations, as they are implied by pin groups/functions]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

(cherry picked from commit c8bac70f079bb3ecaf9a716f141f3d85cef27231)
(purged any reference to r8a7794_pinmux_ops. moved extern declaration
for r8a7745_pinmux_info to file drivers/pinctrl/sh-pfc/core.h)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |  5 ++++
 drivers/pinctrl/sh-pfc/Makefile                    |  1 +
 drivers/pinctrl/sh-pfc/core.c                      |  6 +++++
 drivers/pinctrl/sh-pfc/core.h                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               | 27 ++++++++++++++++++++--
 6 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index 3989719..cf28bd4 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -14,6 +14,7 @@ Required Properties:
     - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
     - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
     - "renesas,pfc-r8a7743": for R8A7743 (RZ/G1M) compatible pin-controller.
+    - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 10d5513..2ba6d55 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -40,6 +40,11 @@ config PINCTRL_PFC_R8A7743
 	depends on ARCH_R8A7743
 	select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A7745
+        def_bool y
+        depends on ARCH_R8A7745
+        select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_R8A7778
 	def_bool y
 	depends on ARCH_R8A7778
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 9390500..7fd3bea 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PINCTRL_PFC_EMEV2)	+= pfc-emev2.o
 obj-$(CONFIG_PINCTRL_PFC_R8A73A4)	+= pfc-r8a73a4.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7740)	+= pfc-r8a7740.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7743)	+= pfc-r8a7791.o
+obj-$(CONFIG_PINCTRL_PFC_R8A7745)	+= pfc-r8a7794.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7778)	+= pfc-r8a7778.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7779)	+= pfc-r8a7779.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7790)	+= pfc-r8a7790.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index c71572c..0cd07df 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -459,6 +459,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7743_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7745
+	{
+		.compatible = "renesas,pfc-r8a7745",
+		.data = &r8a7745_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{
 		.compatible = "renesas,pfc-r8a7778",
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index d8d0edd..0822d9fe 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -70,6 +70,7 @@ extern const struct sh_pfc_soc_info emev2_pinmux_info;
 extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7743_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7745_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index b2e6c4b..2d0dffb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1,9 +1,9 @@
 /*
- * r8a7794 processor support - PFC hardware block.
+ * r8a7794/r8a7745 processor support - PFC hardware block.
  *
  * Copyright (C) 2014-2015 Renesas Electronics Corporation
  * Copyright (C) 2015 Renesas Solutions Corp.
- * Copyright (C) 2015-2016 Cogent Embedded, Inc., <source@cogentembedded.com>
+ * Copyright (C) 2015-2017 Cogent Embedded, Inc. <source@cogentembedded.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2
@@ -5088,6 +5088,28 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7745
+const struct sh_pfc_soc_info r8a7745_pinmux_info = {
+	.name = "r8a77450_pfc",
+	.unlock_reg = 0xe6060000, /* PMMR */
+
+	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
+
+	.pins = pinmux_pins,
+	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
+	.cfg_regs = pinmux_config_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A7794
 const struct sh_pfc_soc_info r8a7794_pinmux_info = {
 	.name = "r8a77940_pfc",
 	.unlock_reg = 0xe6060000, /* PMMR */
@@ -5106,3 +5128,4 @@ const struct sh_pfc_soc_info r8a7794_pinmux_info = {
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
-- 
2.7.4
