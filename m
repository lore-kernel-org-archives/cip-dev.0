From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:39 +0100
Subject: [cip-dev] [PATCH 4.4.y 14/52] pinctrl: sh-pfc: r8a77470: Add VIN
	pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 610d662ac3d38ef0acad2c1128e6a9a547fd8c0f upstream.

Add VIN[01] pin groups and functions to the RZ/G1C (a.k.a.
R8A77470) pinctrl driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 184 ++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 81ef3af..f23042e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1922,6 +1922,146 @@ static const unsigned int usb1_mux[] = {
 	USB1_PWEN_MARK,
 	USB1_OVC_MARK,
 };
+/* - VIN0 ------------------------------------------------------------------- */
+static const union vin_data vin0_data_pins = {
+	.data24 = {
+		/* B */
+		RCAR_GP_PIN(5, 20), RCAR_GP_PIN(5, 21),
+		RCAR_GP_PIN(5, 22), RCAR_GP_PIN(5, 23),
+		RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
+		RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27),
+		/* G */
+		RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 3),
+		RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+		RCAR_GP_PIN(4, 6), RCAR_GP_PIN(5, 8),
+		RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 10),
+		/* R */
+		RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 12),
+		RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 14),
+		RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+		RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 19),
+	},
+};
+static const union vin_data vin0_data_mux = {
+	.data24 = {
+		/* B */
+		VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK,
+		VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+		VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+		VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+		/* G */
+		VI0_G0_MARK, VI0_G1_MARK,
+		VI0_G2_MARK, VI0_G3_MARK,
+		VI0_G4_MARK, VI0_G5_MARK,
+		VI0_G6_MARK, VI0_G7_MARK,
+		/* R */
+		VI0_R0_MARK, VI0_R1_MARK,
+		VI0_R2_MARK, VI0_R3_MARK,
+		VI0_R4_MARK, VI0_R5_MARK,
+		VI0_R6_MARK, VI0_R7_MARK,
+	},
+};
+static const unsigned int vin0_data18_pins[] = {
+	/* B */
+	RCAR_GP_PIN(5, 22), RCAR_GP_PIN(5, 23),
+	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
+	RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27),
+	/* G */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 6), RCAR_GP_PIN(5, 8),
+	RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 10),
+	/* R */
+	RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 14),
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 19),
+};
+static const unsigned int vin0_data18_mux[] = {
+	/* B */
+	VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
+	VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
+	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
+	/* G */
+	VI0_G2_MARK, VI0_G3_MARK,
+	VI0_G4_MARK, VI0_G5_MARK,
+	VI0_G6_MARK, VI0_G7_MARK,
+	/* R */
+	VI0_R2_MARK, VI0_R3_MARK,
+	VI0_R4_MARK, VI0_R5_MARK,
+	VI0_R6_MARK, VI0_R7_MARK,
+};
+static const unsigned int vin0_sync_pins[] = {
+	RCAR_GP_PIN(5, 30), /* HSYNC */
+	RCAR_GP_PIN(5, 31), /* VSYNC */
+};
+static const unsigned int vin0_sync_mux[] = {
+	VI0_HSYNC_N_MARK,
+	VI0_VSYNC_N_MARK,
+};
+static const unsigned int vin0_field_pins[] = {
+	RCAR_GP_PIN(5, 29),
+};
+static const unsigned int vin0_field_mux[] = {
+	VI0_FIELD_MARK,
+};
+static const unsigned int vin0_clkenb_pins[] = {
+	RCAR_GP_PIN(5, 28),
+};
+static const unsigned int vin0_clkenb_mux[] = {
+	VI0_CLKENB_MARK,
+};
+static const unsigned int vin0_clk_pins[] = {
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int vin0_clk_mux[] = {
+	VI0_CLK_MARK,
+};
+/* - VIN1 ------------------------------------------------------------------- */
+static const union vin_data vin1_data_pins = {
+	.data12 = {
+		RCAR_GP_PIN(3,  1), RCAR_GP_PIN(3, 2),
+		RCAR_GP_PIN(3,  3), RCAR_GP_PIN(3, 4),
+		RCAR_GP_PIN(3,  5), RCAR_GP_PIN(3, 6),
+		RCAR_GP_PIN(3,  7), RCAR_GP_PIN(3, 8),
+		RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
+		RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+	},
+};
+static const union vin_data vin1_data_mux = {
+	.data12 = {
+		VI1_DATA0_MARK, VI1_DATA1_MARK,
+		VI1_DATA2_MARK, VI1_DATA3_MARK,
+		VI1_DATA4_MARK, VI1_DATA5_MARK,
+		VI1_DATA6_MARK, VI1_DATA7_MARK,
+		VI1_DATA8_MARK, VI1_DATA9_MARK,
+		VI1_DATA10_MARK, VI1_DATA11_MARK,
+	},
+};
+static const unsigned int vin1_sync_pins[] = {
+	RCAR_GP_PIN(3, 11), /* HSYNC */
+	RCAR_GP_PIN(3, 12), /* VSYNC */
+};
+static const unsigned int vin1_sync_mux[] = {
+	VI1_HSYNC_N_MARK,
+	VI1_VSYNC_N_MARK,
+};
+static const unsigned int vin1_field_pins[] = {
+	RCAR_GP_PIN(3, 10),
+};
+static const unsigned int vin1_field_mux[] = {
+	VI1_FIELD_MARK,
+};
+static const unsigned int vin1_clkenb_pins[] = {
+	RCAR_GP_PIN(3, 9),
+};
+static const unsigned int vin1_clkenb_mux[] = {
+	VI1_CLKENB_MARK,
+};
+static const unsigned int vin1_clk_pins[] = {
+	RCAR_GP_PIN(3, 0),
+};
+static const unsigned int vin1_clk_mux[] = {
+	VI1_CLK_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_col),
@@ -2026,6 +2166,24 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_wp),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
+	VIN_DATA_PIN_GROUP(vin0_data, 24),
+	VIN_DATA_PIN_GROUP(vin0_data, 20),
+	SH_PFC_PIN_GROUP(vin0_data18),
+	VIN_DATA_PIN_GROUP(vin0_data, 16),
+	VIN_DATA_PIN_GROUP(vin0_data, 12),
+	VIN_DATA_PIN_GROUP(vin0_data, 10),
+	VIN_DATA_PIN_GROUP(vin0_data, 8),
+	SH_PFC_PIN_GROUP(vin0_sync),
+	SH_PFC_PIN_GROUP(vin0_field),
+	SH_PFC_PIN_GROUP(vin0_clkenb),
+	SH_PFC_PIN_GROUP(vin0_clk),
+	VIN_DATA_PIN_GROUP(vin1_data, 12),
+	VIN_DATA_PIN_GROUP(vin1_data, 10),
+	VIN_DATA_PIN_GROUP(vin1_data, 8),
+	SH_PFC_PIN_GROUP(vin1_sync),
+	SH_PFC_PIN_GROUP(vin1_field),
+	SH_PFC_PIN_GROUP(vin1_clkenb),
+	SH_PFC_PIN_GROUP(vin1_clk),
 };
 
 static const char * const avb_groups[] = {
@@ -2190,6 +2348,30 @@ static const char * const usb1_groups[] = {
 	"usb1",
 };
 
+static const char * const vin0_groups[] = {
+	"vin0_data24",
+	"vin0_data20",
+	"vin0_data18",
+	"vin0_data16",
+	"vin0_data12",
+	"vin0_data10",
+	"vin0_data8",
+	"vin0_sync",
+	"vin0_field",
+	"vin0_clkenb",
+	"vin0_clk",
+};
+
+static const char * const vin1_groups[] = {
+	"vin1_data12",
+	"vin1_data10",
+	"vin1_data8",
+	"vin1_sync",
+	"vin1_field",
+	"vin1_clkenb",
+	"vin1_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(du0),
@@ -2211,6 +2393,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
+	SH_PFC_FUNCTION(vin0),
+	SH_PFC_FUNCTION(vin1),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.7.4
