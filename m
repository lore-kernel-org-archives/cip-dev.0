From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 10:28:47 +0000
Subject: [cip-dev] [PATCH 3/4] pinctrl: sh-pfc: r8a77990: Add VIN[4|5]
	groups/functions
In-Reply-To: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
References: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553250528-42395-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add pin, mux and functions definitions for VIN4 and VIN5 for R-Car E3.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 60b7e5d98cdcb44db55333c5a145005fbb812928)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 300 +++++++++++++++++++++++++++++++++-
 1 file changed, 298 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index e6a0418..5d6a13f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2958,8 +2958,240 @@ static const unsigned int usb30_id_mux[] = {
 	USB3HS0_ID_MARK,
 };
 
+/* - VIN4 ------------------------------------------------------------------- */
+static const unsigned int vin4_data18_a_pins[] = {
+	RCAR_GP_PIN(2, 8),  RCAR_GP_PIN(2, 9),
+	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 10),
+	RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 16),
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+	RCAR_GP_PIN(1, 19), RCAR_GP_PIN(0, 1),
+};
+
+static const unsigned int vin4_data18_a_mux[] = {
+	VI4_DATA2_A_MARK, VI4_DATA3_A_MARK,
+	VI4_DATA4_A_MARK, VI4_DATA5_A_MARK,
+	VI4_DATA6_A_MARK, VI4_DATA7_A_MARK,
+	VI4_DATA10_MARK,  VI4_DATA11_MARK,
+	VI4_DATA12_MARK,  VI4_DATA13_MARK,
+	VI4_DATA14_MARK,  VI4_DATA15_MARK,
+	VI4_DATA18_MARK,  VI4_DATA19_MARK,
+	VI4_DATA20_MARK,  VI4_DATA21_MARK,
+	VI4_DATA22_MARK,  VI4_DATA23_MARK,
+};
+
+static const union vin_data vin4_data_a_pins = {
+	.data24 = {
+		RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 7),
+		RCAR_GP_PIN(2, 8),  RCAR_GP_PIN(2, 9),
+		RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11),
+		RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 13),
+		RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+		RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 10),
+		RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+		RCAR_GP_PIN(1, 9),  RCAR_GP_PIN(1, 12),
+		RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 16),
+		RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+		RCAR_GP_PIN(1, 19), RCAR_GP_PIN(0, 1),
+	},
+};
+
+static const union vin_data vin4_data_a_mux = {
+	.data24 = {
+		VI4_DATA0_A_MARK, VI4_DATA1_A_MARK,
+		VI4_DATA2_A_MARK, VI4_DATA3_A_MARK,
+		VI4_DATA4_A_MARK, VI4_DATA5_A_MARK,
+		VI4_DATA6_A_MARK, VI4_DATA7_A_MARK,
+		VI4_DATA8_MARK,   VI4_DATA9_MARK,
+		VI4_DATA10_MARK,  VI4_DATA11_MARK,
+		VI4_DATA12_MARK,  VI4_DATA13_MARK,
+		VI4_DATA14_MARK,  VI4_DATA15_MARK,
+		VI4_DATA16_MARK,  VI4_DATA17_MARK,
+		VI4_DATA18_MARK,  VI4_DATA19_MARK,
+		VI4_DATA20_MARK,  VI4_DATA21_MARK,
+		VI4_DATA22_MARK,  VI4_DATA23_MARK,
+	},
+};
+
+static const unsigned int vin4_data18_b_pins[] = {
+	RCAR_GP_PIN(1, 21), RCAR_GP_PIN(1, 22),
+	RCAR_GP_PIN(0, 5),  RCAR_GP_PIN(0, 6),
+	RCAR_GP_PIN(0, 16), RCAR_GP_PIN(0, 17),
+	RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 10),
+	RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 16),
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+	RCAR_GP_PIN(1, 19), RCAR_GP_PIN(0, 1),
+};
+
+static const unsigned int vin4_data18_b_mux[] = {
+	VI4_DATA2_B_MARK, VI4_DATA3_B_MARK,
+	VI4_DATA4_B_MARK, VI4_DATA5_B_MARK,
+	VI4_DATA6_B_MARK, VI4_DATA7_B_MARK,
+	VI4_DATA10_MARK,  VI4_DATA11_MARK,
+	VI4_DATA12_MARK,  VI4_DATA13_MARK,
+	VI4_DATA14_MARK,  VI4_DATA15_MARK,
+	VI4_DATA18_MARK,  VI4_DATA19_MARK,
+	VI4_DATA20_MARK,  VI4_DATA21_MARK,
+	VI4_DATA22_MARK,  VI4_DATA23_MARK,
+};
+
+static const union vin_data vin4_data_b_pins = {
+	.data24 = {
+		RCAR_GP_PIN(1, 8),  RCAR_GP_PIN(1, 11),
+		RCAR_GP_PIN(1, 21), RCAR_GP_PIN(1, 22),
+		RCAR_GP_PIN(0, 5),  RCAR_GP_PIN(0, 6),
+		RCAR_GP_PIN(0, 16), RCAR_GP_PIN(0, 17),
+		RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+		RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 10),
+		RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+		RCAR_GP_PIN(1, 9),  RCAR_GP_PIN(1, 12),
+		RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 16),
+		RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+		RCAR_GP_PIN(1, 19), RCAR_GP_PIN(0, 1),
+	},
+};
+
+static const union vin_data vin4_data_b_mux = {
+	.data24 = {
+		VI4_DATA0_B_MARK, VI4_DATA1_B_MARK,
+		VI4_DATA2_B_MARK, VI4_DATA3_B_MARK,
+		VI4_DATA4_B_MARK, VI4_DATA5_B_MARK,
+		VI4_DATA6_B_MARK, VI4_DATA7_B_MARK,
+		VI4_DATA8_MARK,   VI4_DATA9_MARK,
+		VI4_DATA10_MARK,  VI4_DATA11_MARK,
+		VI4_DATA12_MARK,  VI4_DATA13_MARK,
+		VI4_DATA14_MARK,  VI4_DATA15_MARK,
+		VI4_DATA16_MARK,  VI4_DATA17_MARK,
+		VI4_DATA18_MARK,  VI4_DATA19_MARK,
+		VI4_DATA20_MARK,  VI4_DATA21_MARK,
+		VI4_DATA22_MARK,  VI4_DATA23_MARK,
+	},
+};
+
+static const unsigned int vin4_sync_pins[] = {
+	/* HSYNC, VSYNC */
+	RCAR_GP_PIN(2, 25), RCAR_GP_PIN(2, 24),
+};
+
+static const unsigned int vin4_sync_mux[] = {
+	VI4_HSYNC_N_MARK, VI4_VSYNC_N_MARK,
+};
+
+static const unsigned int vin4_field_pins[] = {
+	RCAR_GP_PIN(2, 23),
+};
+
+static const unsigned int vin4_field_mux[] = {
+	VI4_FIELD_MARK,
+};
+
+static const unsigned int vin4_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 2),
+};
+
+static const unsigned int vin4_clkenb_mux[] = {
+	VI4_CLKENB_MARK,
+};
+
+static const unsigned int vin4_clk_pins[] = {
+	RCAR_GP_PIN(2, 22),
+};
+
+static const unsigned int vin4_clk_mux[] = {
+	VI4_CLK_MARK,
+};
+
+/* - VIN5 ------------------------------------------------------------------- */
+static const union vin_data16 vin5_data_a_pins = {
+	.data16 = {
+		RCAR_GP_PIN(1, 1),  RCAR_GP_PIN(1, 2),
+		RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 12),
+		RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 16),
+		RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+		RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+		RCAR_GP_PIN(0, 9),  RCAR_GP_PIN(0, 11),
+		RCAR_GP_PIN(0, 8),  RCAR_GP_PIN(0, 10),
+		RCAR_GP_PIN(0, 2),  RCAR_GP_PIN(0, 3),
+	},
+};
+
+static const union vin_data16 vin5_data_a_mux = {
+	.data16 = {
+		VI5_DATA0_A_MARK,  VI5_DATA1_A_MARK,
+		VI5_DATA2_A_MARK,  VI5_DATA3_A_MARK,
+		VI5_DATA4_A_MARK,  VI5_DATA5_A_MARK,
+		VI5_DATA6_A_MARK,  VI5_DATA7_A_MARK,
+		VI5_DATA8_A_MARK,  VI5_DATA9_A_MARK,
+		VI5_DATA10_A_MARK, VI5_DATA11_A_MARK,
+		VI5_DATA12_A_MARK, VI5_DATA13_A_MARK,
+		VI5_DATA14_A_MARK, VI5_DATA15_A_MARK,
+	},
+};
+
+static const unsigned int vin5_data8_b_pins[] = {
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(0, 4),
+	RCAR_GP_PIN(0, 7),  RCAR_GP_PIN(0, 12),
+	RCAR_GP_PIN(0, 13), RCAR_GP_PIN(0, 14),
+	RCAR_GP_PIN(0, 16), RCAR_GP_PIN(0, 17),
+};
+
+static const unsigned int vin5_data8_b_mux[] = {
+	VI5_DATA0_B_MARK,  VI5_DATA1_B_MARK,
+	VI5_DATA2_B_MARK,  VI5_DATA3_B_MARK,
+	VI5_DATA4_B_MARK,  VI5_DATA5_B_MARK,
+	VI5_DATA6_B_MARK,  VI5_DATA7_B_MARK,
+};
+
+static const unsigned int vin5_sync_a_pins[] = {
+	/* HSYNC_N, VSYNC_N */
+	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 9),
+};
+
+static const unsigned int vin5_sync_a_mux[] = {
+	VI5_HSYNC_N_A_MARK, VI5_VSYNC_N_A_MARK,
+};
+
+static const unsigned int vin5_field_a_pins[] = {
+	RCAR_GP_PIN(1, 10),
+};
+
+static const unsigned int vin5_field_a_mux[] = {
+	VI5_FIELD_A_MARK,
+};
+
+static const unsigned int vin5_clkenb_a_pins[] = {
+	RCAR_GP_PIN(0, 1),
+};
+
+static const unsigned int vin5_clkenb_a_mux[] = {
+	VI5_CLKENB_A_MARK,
+};
+
+static const unsigned int vin5_clk_a_pins[] = {
+	RCAR_GP_PIN(1, 0),
+};
+
+static const unsigned int vin5_clk_a_mux[] = {
+	VI5_CLK_A_MARK,
+};
+
+static const unsigned int vin5_clk_b_pins[] = {
+	RCAR_GP_PIN(2, 22),
+};
+
+static const unsigned int vin5_clk_b_mux[] = {
+	VI5_CLK_B_MARK,
+};
+
 static const struct {
-	struct sh_pfc_pin_group common[179];
+	struct sh_pfc_pin_group common[207];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -3142,6 +3374,34 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0_id),
 		SH_PFC_PIN_GROUP(usb30),
 		SH_PFC_PIN_GROUP(usb30_id),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _a),
+		SH_PFC_PIN_GROUP(vin4_data18_a),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _b),
+		SH_PFC_PIN_GROUP(vin4_data18_b),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _b),
+		SH_PFC_PIN_GROUP(vin4_sync),
+		SH_PFC_PIN_GROUP(vin4_field),
+		SH_PFC_PIN_GROUP(vin4_clkenb),
+		SH_PFC_PIN_GROUP(vin4_clk),
+		VIN_DATA_PIN_GROUP(vin5_data, 8, _a),
+		VIN_DATA_PIN_GROUP(vin5_data, 10, _a),
+		VIN_DATA_PIN_GROUP(vin5_data, 12, _a),
+		VIN_DATA_PIN_GROUP(vin5_data, 16, _a),
+		SH_PFC_PIN_GROUP(vin5_data8_b),
+		SH_PFC_PIN_GROUP(vin5_sync_a),
+		SH_PFC_PIN_GROUP(vin5_field_a),
+		SH_PFC_PIN_GROUP(vin5_clkenb_a),
+		SH_PFC_PIN_GROUP(vin5_clk_a),
+		SH_PFC_PIN_GROUP(vin5_clk_b),
 	}
 };
 
@@ -3426,8 +3686,42 @@ static const char * const usb30_groups[] = {
 	"usb30_id",
 };
 
+static const char * const vin4_groups[] = {
+	"vin4_data8_a",
+	"vin4_data10_a",
+	"vin4_data12_a",
+	"vin4_data16_a",
+	"vin4_data18_a",
+	"vin4_data20_a",
+	"vin4_data24_a",
+	"vin4_data8_b",
+	"vin4_data10_b",
+	"vin4_data12_b",
+	"vin4_data16_b",
+	"vin4_data18_b",
+	"vin4_data20_b",
+	"vin4_data24_b",
+	"vin4_sync",
+	"vin4_field",
+	"vin4_clkenb",
+	"vin4_clk",
+};
+
+static const char * const vin5_groups[] = {
+	"vin5_data8_a",
+	"vin5_data10_a",
+	"vin5_data12_a",
+	"vin5_data16_a",
+	"vin5_data8_b",
+	"vin5_sync_a",
+	"vin5_field_a",
+	"vin5_clkenb_a",
+	"vin5_clk_a",
+	"vin5_clk_b",
+};
+
 static const struct {
-	struct sh_pfc_function common[34];
+	struct sh_pfc_function common[36];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
@@ -3465,6 +3759,8 @@ static const struct {
 		SH_PFC_FUNCTION(ssi),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb30),
+		SH_PFC_FUNCTION(vin4),
+		SH_PFC_FUNCTION(vin5),
 	}
 };
 
-- 
2.7.4
