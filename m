From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:30:43 +0000
Subject: [cip-dev] [PATCH 7/7] pinctrl: sh-pfc: r8a77990: Add R8A774C0 PFC
	support
In-Reply-To: <1553182243-50724-1-git-send-email-biju.das@bp.renesas.com>
References: <1553182243-50724-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553182243-50724-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Renesas RZ/G2E (a.k.a. r8a774c0) is pin compatible with R-Car
E3 (a.k.a. r8a77990), however it doesn't have several automotive
specific peripherals. Add a r8a77990 specific pin groups/functions
along with common pin groups/functions for supporting both r8a77990
and r8a774c0 SoCs.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 9f2b76a2db3c43872048cbca1269f3fc5fbcd75d)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/Kconfig        |   5 +
 drivers/pinctrl/sh-pfc/Makefile       |   1 +
 drivers/pinctrl/sh-pfc/core.c         |   6 +
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 339 +++++++++++++++++++---------------
 drivers/pinctrl/sh-pfc/sh_pfc.h       |   1 +
 5 files changed, 201 insertions(+), 151 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 6a7254c..ff981e2 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -54,6 +54,11 @@ config PINCTRL_PFC_R8A774A1
         depends on ARCH_R8A774A1
         select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A774C0
+        def_bool y
+        depends on ARCH_R8A774C0
+        select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_R8A7778
 	def_bool y
 	depends on ARCH_R8A7778
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 9510a48..f430200 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_PFC_R8A7743)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7745)	+= pfc-r8a7794.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77470)	+= pfc-r8a77470.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774A1)	+= pfc-r8a7796.o
+obj-$(CONFIG_PINCTRL_PFC_R8A774C0)	+= pfc-r8a77990.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7778)	+= pfc-r8a7778.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7779)	+= pfc-r8a7779.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7790)	+= pfc-r8a7790.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 0122471..4f835b6 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -515,6 +515,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a774a1_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A774C0
+	{
+		.compatible = "renesas,pfc-r8a774c0",
+		.data = &r8a774c0_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{
 		.compatible = "renesas,pfc-r8a7778",
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 97becb2..76ac77a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2389,124 +2389,129 @@ static const unsigned int usb30_id_mux[] = {
 	USB3HS0_ID_MARK,
 };
 
-static const struct sh_pfc_pin_group pinmux_groups[] = {
-	SH_PFC_PIN_GROUP(avb_link),
-	SH_PFC_PIN_GROUP(avb_magic),
-	SH_PFC_PIN_GROUP(avb_phy_int),
-	SH_PFC_PIN_GROUP(avb_mii),
-	SH_PFC_PIN_GROUP(avb_avtp_pps),
-	SH_PFC_PIN_GROUP(avb_avtp_match_a),
-	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
-	SH_PFC_PIN_GROUP(du_rgb666),
-	SH_PFC_PIN_GROUP(du_rgb888),
-	SH_PFC_PIN_GROUP(du_clk_in_0),
-	SH_PFC_PIN_GROUP(du_clk_in_1),
-	SH_PFC_PIN_GROUP(du_clk_out_0),
-	SH_PFC_PIN_GROUP(du_sync),
-	SH_PFC_PIN_GROUP(du_disp_cde),
-	SH_PFC_PIN_GROUP(du_cde),
-	SH_PFC_PIN_GROUP(du_disp),
-	SH_PFC_PIN_GROUP(i2c1_a),
-	SH_PFC_PIN_GROUP(i2c1_b),
-	SH_PFC_PIN_GROUP(i2c1_c),
-	SH_PFC_PIN_GROUP(i2c1_d),
-	SH_PFC_PIN_GROUP(i2c2_a),
-	SH_PFC_PIN_GROUP(i2c2_b),
-	SH_PFC_PIN_GROUP(i2c2_c),
-	SH_PFC_PIN_GROUP(i2c2_d),
-	SH_PFC_PIN_GROUP(i2c2_e),
-	SH_PFC_PIN_GROUP(i2c4),
-	SH_PFC_PIN_GROUP(i2c5),
-	SH_PFC_PIN_GROUP(i2c6_a),
-	SH_PFC_PIN_GROUP(i2c6_b),
-	SH_PFC_PIN_GROUP(i2c7_a),
-	SH_PFC_PIN_GROUP(i2c7_b),
-	SH_PFC_PIN_GROUP(msiof0_clk),
-	SH_PFC_PIN_GROUP(msiof0_sync),
-	SH_PFC_PIN_GROUP(msiof0_ss1),
-	SH_PFC_PIN_GROUP(msiof0_ss2),
-	SH_PFC_PIN_GROUP(msiof0_txd),
-	SH_PFC_PIN_GROUP(msiof0_rxd),
-	SH_PFC_PIN_GROUP(msiof1_clk),
-	SH_PFC_PIN_GROUP(msiof1_sync),
-	SH_PFC_PIN_GROUP(msiof1_ss1),
-	SH_PFC_PIN_GROUP(msiof1_ss2),
-	SH_PFC_PIN_GROUP(msiof1_txd),
-	SH_PFC_PIN_GROUP(msiof1_rxd),
-	SH_PFC_PIN_GROUP(msiof2_clk_a),
-	SH_PFC_PIN_GROUP(msiof2_sync_a),
-	SH_PFC_PIN_GROUP(msiof2_ss1_a),
-	SH_PFC_PIN_GROUP(msiof2_ss2_a),
-	SH_PFC_PIN_GROUP(msiof2_txd_a),
-	SH_PFC_PIN_GROUP(msiof2_rxd_a),
-	SH_PFC_PIN_GROUP(msiof2_clk_b),
-	SH_PFC_PIN_GROUP(msiof2_sync_b),
-	SH_PFC_PIN_GROUP(msiof2_ss1_b),
-	SH_PFC_PIN_GROUP(msiof2_ss2_b),
-	SH_PFC_PIN_GROUP(msiof2_txd_b),
-	SH_PFC_PIN_GROUP(msiof2_rxd_b),
-	SH_PFC_PIN_GROUP(msiof3_clk_a),
-	SH_PFC_PIN_GROUP(msiof3_sync_a),
-	SH_PFC_PIN_GROUP(msiof3_ss1_a),
-	SH_PFC_PIN_GROUP(msiof3_ss2_a),
-	SH_PFC_PIN_GROUP(msiof3_txd_a),
-	SH_PFC_PIN_GROUP(msiof3_rxd_a),
-	SH_PFC_PIN_GROUP(msiof3_clk_b),
-	SH_PFC_PIN_GROUP(msiof3_sync_b),
-	SH_PFC_PIN_GROUP(msiof3_ss1_b),
-	SH_PFC_PIN_GROUP(msiof3_txd_b),
-	SH_PFC_PIN_GROUP(msiof3_rxd_b),
-	SH_PFC_PIN_GROUP(pwm0_a),
-	SH_PFC_PIN_GROUP(pwm0_b),
-	SH_PFC_PIN_GROUP(pwm1_a),
-	SH_PFC_PIN_GROUP(pwm1_b),
-	SH_PFC_PIN_GROUP(pwm2_a),
-	SH_PFC_PIN_GROUP(pwm2_b),
-	SH_PFC_PIN_GROUP(pwm2_c),
-	SH_PFC_PIN_GROUP(pwm3_a),
-	SH_PFC_PIN_GROUP(pwm3_b),
-	SH_PFC_PIN_GROUP(pwm3_c),
-	SH_PFC_PIN_GROUP(pwm4_a),
-	SH_PFC_PIN_GROUP(pwm4_b),
-	SH_PFC_PIN_GROUP(pwm5_a),
-	SH_PFC_PIN_GROUP(pwm5_b),
-	SH_PFC_PIN_GROUP(pwm6_a),
-	SH_PFC_PIN_GROUP(pwm6_b),
-	SH_PFC_PIN_GROUP(scif0_data_a),
-	SH_PFC_PIN_GROUP(scif0_clk_a),
-	SH_PFC_PIN_GROUP(scif0_ctrl_a),
-	SH_PFC_PIN_GROUP(scif0_data_b),
-	SH_PFC_PIN_GROUP(scif0_clk_b),
-	SH_PFC_PIN_GROUP(scif1_data),
-	SH_PFC_PIN_GROUP(scif1_clk),
-	SH_PFC_PIN_GROUP(scif1_ctrl),
-	SH_PFC_PIN_GROUP(scif2_data_a),
-	SH_PFC_PIN_GROUP(scif2_clk_a),
-	SH_PFC_PIN_GROUP(scif2_data_b),
-	SH_PFC_PIN_GROUP(scif3_data_a),
-	SH_PFC_PIN_GROUP(scif3_clk_a),
-	SH_PFC_PIN_GROUP(scif3_ctrl_a),
-	SH_PFC_PIN_GROUP(scif3_data_b),
-	SH_PFC_PIN_GROUP(scif3_data_c),
-	SH_PFC_PIN_GROUP(scif3_clk_c),
-	SH_PFC_PIN_GROUP(scif4_data_a),
-	SH_PFC_PIN_GROUP(scif4_clk_a),
-	SH_PFC_PIN_GROUP(scif4_ctrl_a),
-	SH_PFC_PIN_GROUP(scif4_data_b),
-	SH_PFC_PIN_GROUP(scif4_clk_b),
-	SH_PFC_PIN_GROUP(scif4_data_c),
-	SH_PFC_PIN_GROUP(scif4_ctrl_c),
-	SH_PFC_PIN_GROUP(scif5_data_a),
-	SH_PFC_PIN_GROUP(scif5_clk_a),
-	SH_PFC_PIN_GROUP(scif5_data_b),
-	SH_PFC_PIN_GROUP(scif5_data_c),
-	SH_PFC_PIN_GROUP(scif_clk_a),
-	SH_PFC_PIN_GROUP(scif_clk_b),
-	SH_PFC_PIN_GROUP(usb0_a),
-	SH_PFC_PIN_GROUP(usb0_b),
-	SH_PFC_PIN_GROUP(usb0_id),
-	SH_PFC_PIN_GROUP(usb30),
-	SH_PFC_PIN_GROUP(usb30_id),
+static const struct {
+	struct sh_pfc_pin_group common[117];
+	struct sh_pfc_pin_group r8a77990[0];
+} pinmux_groups = {
+	.common = {
+		SH_PFC_PIN_GROUP(avb_link),
+		SH_PFC_PIN_GROUP(avb_magic),
+		SH_PFC_PIN_GROUP(avb_phy_int),
+		SH_PFC_PIN_GROUP(avb_mii),
+		SH_PFC_PIN_GROUP(avb_avtp_pps),
+		SH_PFC_PIN_GROUP(avb_avtp_match_a),
+		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+		SH_PFC_PIN_GROUP(du_rgb666),
+		SH_PFC_PIN_GROUP(du_rgb888),
+		SH_PFC_PIN_GROUP(du_clk_in_0),
+		SH_PFC_PIN_GROUP(du_clk_in_1),
+		SH_PFC_PIN_GROUP(du_clk_out_0),
+		SH_PFC_PIN_GROUP(du_sync),
+		SH_PFC_PIN_GROUP(du_disp_cde),
+		SH_PFC_PIN_GROUP(du_cde),
+		SH_PFC_PIN_GROUP(du_disp),
+		SH_PFC_PIN_GROUP(i2c1_a),
+		SH_PFC_PIN_GROUP(i2c1_b),
+		SH_PFC_PIN_GROUP(i2c1_c),
+		SH_PFC_PIN_GROUP(i2c1_d),
+		SH_PFC_PIN_GROUP(i2c2_a),
+		SH_PFC_PIN_GROUP(i2c2_b),
+		SH_PFC_PIN_GROUP(i2c2_c),
+		SH_PFC_PIN_GROUP(i2c2_d),
+		SH_PFC_PIN_GROUP(i2c2_e),
+		SH_PFC_PIN_GROUP(i2c4),
+		SH_PFC_PIN_GROUP(i2c5),
+		SH_PFC_PIN_GROUP(i2c6_a),
+		SH_PFC_PIN_GROUP(i2c6_b),
+		SH_PFC_PIN_GROUP(i2c7_a),
+		SH_PFC_PIN_GROUP(i2c7_b),
+		SH_PFC_PIN_GROUP(msiof0_clk),
+		SH_PFC_PIN_GROUP(msiof0_sync),
+		SH_PFC_PIN_GROUP(msiof0_ss1),
+		SH_PFC_PIN_GROUP(msiof0_ss2),
+		SH_PFC_PIN_GROUP(msiof0_txd),
+		SH_PFC_PIN_GROUP(msiof0_rxd),
+		SH_PFC_PIN_GROUP(msiof1_clk),
+		SH_PFC_PIN_GROUP(msiof1_sync),
+		SH_PFC_PIN_GROUP(msiof1_ss1),
+		SH_PFC_PIN_GROUP(msiof1_ss2),
+		SH_PFC_PIN_GROUP(msiof1_txd),
+		SH_PFC_PIN_GROUP(msiof1_rxd),
+		SH_PFC_PIN_GROUP(msiof2_clk_a),
+		SH_PFC_PIN_GROUP(msiof2_sync_a),
+		SH_PFC_PIN_GROUP(msiof2_ss1_a),
+		SH_PFC_PIN_GROUP(msiof2_ss2_a),
+		SH_PFC_PIN_GROUP(msiof2_txd_a),
+		SH_PFC_PIN_GROUP(msiof2_rxd_a),
+		SH_PFC_PIN_GROUP(msiof2_clk_b),
+		SH_PFC_PIN_GROUP(msiof2_sync_b),
+		SH_PFC_PIN_GROUP(msiof2_ss1_b),
+		SH_PFC_PIN_GROUP(msiof2_ss2_b),
+		SH_PFC_PIN_GROUP(msiof2_txd_b),
+		SH_PFC_PIN_GROUP(msiof2_rxd_b),
+		SH_PFC_PIN_GROUP(msiof3_clk_a),
+		SH_PFC_PIN_GROUP(msiof3_sync_a),
+		SH_PFC_PIN_GROUP(msiof3_ss1_a),
+		SH_PFC_PIN_GROUP(msiof3_ss2_a),
+		SH_PFC_PIN_GROUP(msiof3_txd_a),
+		SH_PFC_PIN_GROUP(msiof3_rxd_a),
+		SH_PFC_PIN_GROUP(msiof3_clk_b),
+		SH_PFC_PIN_GROUP(msiof3_sync_b),
+		SH_PFC_PIN_GROUP(msiof3_ss1_b),
+		SH_PFC_PIN_GROUP(msiof3_txd_b),
+		SH_PFC_PIN_GROUP(msiof3_rxd_b),
+		SH_PFC_PIN_GROUP(pwm0_a),
+		SH_PFC_PIN_GROUP(pwm0_b),
+		SH_PFC_PIN_GROUP(pwm1_a),
+		SH_PFC_PIN_GROUP(pwm1_b),
+		SH_PFC_PIN_GROUP(pwm2_a),
+		SH_PFC_PIN_GROUP(pwm2_b),
+		SH_PFC_PIN_GROUP(pwm2_c),
+		SH_PFC_PIN_GROUP(pwm3_a),
+		SH_PFC_PIN_GROUP(pwm3_b),
+		SH_PFC_PIN_GROUP(pwm3_c),
+		SH_PFC_PIN_GROUP(pwm4_a),
+		SH_PFC_PIN_GROUP(pwm4_b),
+		SH_PFC_PIN_GROUP(pwm5_a),
+		SH_PFC_PIN_GROUP(pwm5_b),
+		SH_PFC_PIN_GROUP(pwm6_a),
+		SH_PFC_PIN_GROUP(pwm6_b),
+		SH_PFC_PIN_GROUP(scif0_data_a),
+		SH_PFC_PIN_GROUP(scif0_clk_a),
+		SH_PFC_PIN_GROUP(scif0_ctrl_a),
+		SH_PFC_PIN_GROUP(scif0_data_b),
+		SH_PFC_PIN_GROUP(scif0_clk_b),
+		SH_PFC_PIN_GROUP(scif1_data),
+		SH_PFC_PIN_GROUP(scif1_clk),
+		SH_PFC_PIN_GROUP(scif1_ctrl),
+		SH_PFC_PIN_GROUP(scif2_data_a),
+		SH_PFC_PIN_GROUP(scif2_clk_a),
+		SH_PFC_PIN_GROUP(scif2_data_b),
+		SH_PFC_PIN_GROUP(scif3_data_a),
+		SH_PFC_PIN_GROUP(scif3_clk_a),
+		SH_PFC_PIN_GROUP(scif3_ctrl_a),
+		SH_PFC_PIN_GROUP(scif3_data_b),
+		SH_PFC_PIN_GROUP(scif3_data_c),
+		SH_PFC_PIN_GROUP(scif3_clk_c),
+		SH_PFC_PIN_GROUP(scif4_data_a),
+		SH_PFC_PIN_GROUP(scif4_clk_a),
+		SH_PFC_PIN_GROUP(scif4_ctrl_a),
+		SH_PFC_PIN_GROUP(scif4_data_b),
+		SH_PFC_PIN_GROUP(scif4_clk_b),
+		SH_PFC_PIN_GROUP(scif4_data_c),
+		SH_PFC_PIN_GROUP(scif4_ctrl_c),
+		SH_PFC_PIN_GROUP(scif5_data_a),
+		SH_PFC_PIN_GROUP(scif5_clk_a),
+		SH_PFC_PIN_GROUP(scif5_data_b),
+		SH_PFC_PIN_GROUP(scif5_data_c),
+		SH_PFC_PIN_GROUP(scif_clk_a),
+		SH_PFC_PIN_GROUP(scif_clk_b),
+		SH_PFC_PIN_GROUP(usb0_a),
+		SH_PFC_PIN_GROUP(usb0_b),
+		SH_PFC_PIN_GROUP(usb0_id),
+		SH_PFC_PIN_GROUP(usb30),
+		SH_PFC_PIN_GROUP(usb30_id),
+	}
 };
 
 static const char * const avb_groups[] = {
@@ -2710,35 +2715,40 @@ static const char * const usb30_groups[] = {
 	"usb30_id",
 };
 
-static const struct sh_pfc_function pinmux_functions[] = {
-	SH_PFC_FUNCTION(avb),
-	SH_PFC_FUNCTION(du),
-	SH_PFC_FUNCTION(i2c1),
-	SH_PFC_FUNCTION(i2c2),
-	SH_PFC_FUNCTION(i2c4),
-	SH_PFC_FUNCTION(i2c5),
-	SH_PFC_FUNCTION(i2c6),
-	SH_PFC_FUNCTION(i2c7),
-	SH_PFC_FUNCTION(msiof0),
-	SH_PFC_FUNCTION(msiof1),
-	SH_PFC_FUNCTION(msiof2),
-	SH_PFC_FUNCTION(msiof3),
-	SH_PFC_FUNCTION(pwm0),
-	SH_PFC_FUNCTION(pwm1),
-	SH_PFC_FUNCTION(pwm2),
-	SH_PFC_FUNCTION(pwm3),
-	SH_PFC_FUNCTION(pwm4),
-	SH_PFC_FUNCTION(pwm5),
-	SH_PFC_FUNCTION(pwm6),
-	SH_PFC_FUNCTION(scif0),
-	SH_PFC_FUNCTION(scif1),
-	SH_PFC_FUNCTION(scif2),
-	SH_PFC_FUNCTION(scif3),
-	SH_PFC_FUNCTION(scif4),
-	SH_PFC_FUNCTION(scif5),
-	SH_PFC_FUNCTION(scif_clk),
-	SH_PFC_FUNCTION(usb0),
-	SH_PFC_FUNCTION(usb30),
+static const struct {
+	struct sh_pfc_function common[28];
+	struct sh_pfc_function r8a77990[0];
+} pinmux_functions = {
+	.common = {
+		SH_PFC_FUNCTION(avb),
+		SH_PFC_FUNCTION(du),
+		SH_PFC_FUNCTION(i2c1),
+		SH_PFC_FUNCTION(i2c2),
+		SH_PFC_FUNCTION(i2c4),
+		SH_PFC_FUNCTION(i2c5),
+		SH_PFC_FUNCTION(i2c6),
+		SH_PFC_FUNCTION(i2c7),
+		SH_PFC_FUNCTION(msiof0),
+		SH_PFC_FUNCTION(msiof1),
+		SH_PFC_FUNCTION(msiof2),
+		SH_PFC_FUNCTION(msiof3),
+		SH_PFC_FUNCTION(pwm0),
+		SH_PFC_FUNCTION(pwm1),
+		SH_PFC_FUNCTION(pwm2),
+		SH_PFC_FUNCTION(pwm3),
+		SH_PFC_FUNCTION(pwm4),
+		SH_PFC_FUNCTION(pwm5),
+		SH_PFC_FUNCTION(pwm6),
+		SH_PFC_FUNCTION(scif0),
+		SH_PFC_FUNCTION(scif1),
+		SH_PFC_FUNCTION(scif2),
+		SH_PFC_FUNCTION(scif3),
+		SH_PFC_FUNCTION(scif4),
+		SH_PFC_FUNCTION(scif5),
+		SH_PFC_FUNCTION(scif_clk),
+		SH_PFC_FUNCTION(usb0),
+		SH_PFC_FUNCTION(usb30),
+	}
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
@@ -3464,6 +3474,30 @@ static const struct sh_pfc_soc_operations r8a77990_pinmux_ops = {
 	.set_bias = r8a77990_pinmux_set_bias,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A774C0
+const struct sh_pfc_soc_info r8a774c0_pinmux_info = {
+	.name = "r8a774c0_pfc",
+	.ops = &r8a77990_pinmux_ops,
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
+	.bias_regs = pinmux_bias_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A77990
 const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 	.name = "r8a77990_pfc",
 	.ops = &r8a77990_pinmux_ops,
@@ -3473,10 +3507,12 @@ const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
-	.groups = pinmux_groups,
-	.nr_groups = ARRAY_SIZE(pinmux_groups),
-	.functions = pinmux_functions,
-	.nr_functions = ARRAY_SIZE(pinmux_functions),
+	.groups = pinmux_groups.common,
+	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
+		ARRAY_SIZE(pinmux_groups.r8a77990),
+	.functions = pinmux_functions.common,
+	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
+		ARRAY_SIZE(pinmux_functions.r8a77990),
 
 	.cfg_regs = pinmux_config_regs,
 	.bias_regs = pinmux_bias_regs,
@@ -3484,3 +3520,4 @@ const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 1d491d1..15fbc4f 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -276,6 +276,7 @@ extern const struct sh_pfc_soc_info r8a7743_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7745_pinmux_info;
 extern const struct sh_pfc_soc_info r8a77470_pinmux_info;
 extern const struct sh_pfc_soc_info r8a774a1_pinmux_info;
+extern const struct sh_pfc_soc_info r8a774c0_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
-- 
2.7.4
