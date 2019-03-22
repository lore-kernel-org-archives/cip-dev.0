From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 10:28:48 +0000
Subject: [cip-dev] [PATCH 4/4] pinctrl: sh-pfc: r8a77990: Add HSCIF pins,
	groups, and functions
In-Reply-To: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
References: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553250528-42395-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds HSCIF{0,1,2,3,4} pins, groups and functions to
the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 5160063d567283cff1b85fdc1bcf843295b39eca)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 370 +++++++++++++++++++++++++++++++++-
 1 file changed, 368 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 5d6a13f..6868753 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1626,6 +1626,290 @@ static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
 
+/* - HSCIF0 --------------------------------------------------*/
+static const unsigned int hscif0_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 9),
+};
+
+static const unsigned int hscif0_data_a_mux[] = {
+	HRX0_A_MARK, HTX0_A_MARK,
+};
+
+static const unsigned int hscif0_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 7),
+};
+
+static const unsigned int hscif0_clk_a_mux[] = {
+	HSCK0_A_MARK,
+};
+
+static const unsigned int hscif0_ctrl_a_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 14),
+};
+
+static const unsigned int hscif0_ctrl_a_mux[] = {
+	HRTS0_N_A_MARK, HCTS0_N_A_MARK,
+};
+
+static const unsigned int hscif0_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(6, 11), RCAR_GP_PIN(6, 12),
+};
+
+static const unsigned int hscif0_data_b_mux[] = {
+	HRX0_B_MARK, HTX0_B_MARK,
+};
+
+static const unsigned int hscif0_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 13),
+};
+
+static const unsigned int hscif0_clk_b_mux[] = {
+	HSCK0_B_MARK,
+};
+
+/* - HSCIF1 ------------------------------------------------- */
+static const unsigned int hscif1_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+};
+
+static const unsigned int hscif1_data_a_mux[] = {
+	HRX1_A_MARK, HTX1_A_MARK,
+};
+
+static const unsigned int hscif1_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 0),
+};
+
+static const unsigned int hscif1_clk_a_mux[] = {
+	HSCK1_A_MARK,
+};
+
+static const unsigned int hscif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(3, 1), RCAR_GP_PIN(3, 2),
+};
+
+static const unsigned int hscif1_data_b_mux[] = {
+	HRX1_B_MARK, HTX1_B_MARK,
+};
+
+static const unsigned int hscif1_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(3, 0),
+};
+
+static const unsigned int hscif1_clk_b_mux[] = {
+	HSCK1_B_MARK,
+};
+
+static const unsigned int hscif1_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 3),
+};
+
+static const unsigned int hscif1_ctrl_b_mux[] = {
+	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
+};
+
+/* - HSCIF2 ------------------------------------------------- */
+static const unsigned int hscif2_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
+};
+
+static const unsigned int hscif2_data_a_mux[] = {
+	HRX2_A_MARK, HTX2_A_MARK,
+};
+
+static const unsigned int hscif2_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 14),
+};
+
+static const unsigned int hscif2_clk_a_mux[] = {
+	HSCK2_A_MARK,
+};
+
+static const unsigned int hscif2_ctrl_a_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(6, 16), RCAR_GP_PIN(6, 15),
+};
+
+static const unsigned int hscif2_ctrl_a_mux[] = {
+	HRTS2_N_A_MARK, HCTS2_N_A_MARK,
+};
+
+static const unsigned int hscif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+};
+
+static const unsigned int hscif2_data_b_mux[] = {
+	HRX2_B_MARK, HTX2_B_MARK,
+};
+
+/* - HSCIF3 ------------------------------------------------*/
+static const unsigned int hscif3_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+};
+
+static const unsigned int hscif3_data_a_mux[] = {
+	HRX3_A_MARK, HTX3_A_MARK,
+};
+
+static const unsigned int hscif3_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 5), RCAR_GP_PIN(0, 6),
+};
+
+static const unsigned int hscif3_data_b_mux[] = {
+	HRX3_B_MARK, HTX3_B_MARK,
+};
+
+static const unsigned int hscif3_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 4),
+};
+
+static const unsigned int hscif3_clk_b_mux[] = {
+	HSCK3_B_MARK,
+};
+
+static const unsigned int hscif3_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 9),
+};
+
+static const unsigned int hscif3_data_c_mux[] = {
+	HRX3_C_MARK, HTX3_C_MARK,
+};
+
+static const unsigned int hscif3_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 11),
+};
+
+static const unsigned int hscif3_clk_c_mux[] = {
+	HSCK3_C_MARK,
+};
+
+static const unsigned int hscif3_ctrl_c_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 12),
+};
+
+static const unsigned int hscif3_ctrl_c_mux[] = {
+	HRTS3_N_C_MARK, HCTS3_N_C_MARK,
+};
+
+static const unsigned int hscif3_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 0), RCAR_GP_PIN(1, 3),
+};
+
+static const unsigned int hscif3_data_d_mux[] = {
+	HRX3_D_MARK, HTX3_D_MARK,
+};
+
+static const unsigned int hscif3_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 9), RCAR_GP_PIN(0, 10),
+};
+
+static const unsigned int hscif3_data_e_mux[] = {
+	HRX3_E_MARK, HTX3_E_MARK,
+};
+
+static const unsigned int hscif3_ctrl_e_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 8),
+};
+
+static const unsigned int hscif3_ctrl_e_mux[] = {
+	HRTS3_N_E_MARK, HCTS3_N_E_MARK,
+};
+
+/* - HSCIF4 -------------------------------------------------- */
+static const unsigned int hscif4_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 3),
+};
+
+static const unsigned int hscif4_data_a_mux[] = {
+	HRX4_A_MARK, HTX4_A_MARK,
+};
+
+static const unsigned int hscif4_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 0),
+};
+
+static const unsigned int hscif4_clk_a_mux[] = {
+	HSCK4_A_MARK,
+};
+
+static const unsigned int hscif4_ctrl_a_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 1),
+};
+
+static const unsigned int hscif4_ctrl_a_mux[] = {
+	HRTS4_N_A_MARK, HCTS4_N_A_MARK,
+};
+
+static const unsigned int hscif4_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 8), RCAR_GP_PIN(2, 7),
+};
+
+static const unsigned int hscif4_data_b_mux[] = {
+	HRX4_B_MARK, HTX4_B_MARK,
+};
+
+static const unsigned int hscif4_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 6),
+};
+
+static const unsigned int hscif4_clk_b_mux[] = {
+	HSCK4_B_MARK,
+};
+
+static const unsigned int hscif4_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 11),
+};
+
+static const unsigned int hscif4_data_c_mux[] = {
+	HRX4_C_MARK, HTX4_C_MARK,
+};
+
+static const unsigned int hscif4_data_d_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 13), RCAR_GP_PIN(1, 14),
+};
+
+static const unsigned int hscif4_data_d_mux[] = {
+	HRX4_D_MARK, HTX4_D_MARK,
+};
+
+static const unsigned int hscif4_data_e_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 18), RCAR_GP_PIN(1, 19),
+};
+
+static const unsigned int hscif4_data_e_mux[] = {
+	HRX4_E_MARK, HTX4_E_MARK,
+};
+
 /* - I2C -------------------------------------------------------------------- */
 static const unsigned int i2c1_a_pins[] = {
 	/* SCL, SDA */
@@ -3191,7 +3475,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[207];
+	struct sh_pfc_pin_group common[238];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -3229,6 +3513,37 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_disp_cde),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
+		SH_PFC_PIN_GROUP(hscif0_data_a),
+		SH_PFC_PIN_GROUP(hscif0_clk_a),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_a),
+		SH_PFC_PIN_GROUP(hscif0_data_b),
+		SH_PFC_PIN_GROUP(hscif0_clk_b),
+		SH_PFC_PIN_GROUP(hscif1_data_a),
+		SH_PFC_PIN_GROUP(hscif1_clk_a),
+		SH_PFC_PIN_GROUP(hscif1_data_b),
+		SH_PFC_PIN_GROUP(hscif1_clk_b),
+		SH_PFC_PIN_GROUP(hscif1_ctrl_b),
+		SH_PFC_PIN_GROUP(hscif2_data_a),
+		SH_PFC_PIN_GROUP(hscif2_clk_a),
+		SH_PFC_PIN_GROUP(hscif2_ctrl_a),
+		SH_PFC_PIN_GROUP(hscif2_data_b),
+		SH_PFC_PIN_GROUP(hscif3_data_a),
+		SH_PFC_PIN_GROUP(hscif3_data_b),
+		SH_PFC_PIN_GROUP(hscif3_clk_b),
+		SH_PFC_PIN_GROUP(hscif3_data_c),
+		SH_PFC_PIN_GROUP(hscif3_clk_c),
+		SH_PFC_PIN_GROUP(hscif3_ctrl_c),
+		SH_PFC_PIN_GROUP(hscif3_data_d),
+		SH_PFC_PIN_GROUP(hscif3_data_e),
+		SH_PFC_PIN_GROUP(hscif3_ctrl_e),
+		SH_PFC_PIN_GROUP(hscif4_data_a),
+		SH_PFC_PIN_GROUP(hscif4_clk_a),
+		SH_PFC_PIN_GROUP(hscif4_ctrl_a),
+		SH_PFC_PIN_GROUP(hscif4_data_b),
+		SH_PFC_PIN_GROUP(hscif4_clk_b),
+		SH_PFC_PIN_GROUP(hscif4_data_c),
+		SH_PFC_PIN_GROUP(hscif4_data_d),
+		SH_PFC_PIN_GROUP(hscif4_data_e),
 		SH_PFC_PIN_GROUP(i2c1_a),
 		SH_PFC_PIN_GROUP(i2c1_b),
 		SH_PFC_PIN_GROUP(i2c1_c),
@@ -3448,6 +3763,52 @@ static const char * const du_groups[] = {
 	"du_disp",
 };
 
+static const char * const hscif0_groups[] = {
+	"hscif0_data_a",
+	"hscif0_clk_a",
+	"hscif0_ctrl_a",
+	"hscif0_data_b",
+	"hscif0_clk_b",
+};
+
+static const char * const hscif1_groups[] = {
+	"hscif1_data_a",
+	"hscif1_clk_a",
+	"hscif1_data_b",
+	"hscif1_clk_b",
+	"hscif1_ctrl_b",
+};
+
+static const char * const hscif2_groups[] = {
+	"hscif2_data_a",
+	"hscif2_clk_a",
+	"hscif2_ctrl_a",
+	"hscif2_data_b",
+};
+
+static const char * const hscif3_groups[] = {
+	"hscif3_data_a",
+	"hscif3_data_b",
+	"hscif3_clk_b",
+	"hscif3_data_c",
+	"hscif3_clk_c",
+	"hscif3_ctrl_c",
+	"hscif3_data_d",
+	"hscif3_data_e",
+	"hscif3_ctrl_e",
+};
+
+static const char * const hscif4_groups[] = {
+	"hscif4_data_a",
+	"hscif4_clk_a",
+	"hscif4_ctrl_a",
+	"hscif4_data_b",
+	"hscif4_clk_b",
+	"hscif4_data_c",
+	"hscif4_data_d",
+	"hscif4_data_e",
+};
+
 static const char * const i2c1_groups[] = {
 	"i2c1_a",
 	"i2c1_b",
@@ -3721,13 +4082,18 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[36];
+	struct sh_pfc_function common[41];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
 		SH_PFC_FUNCTION(avb),
 		SH_PFC_FUNCTION(du),
+		SH_PFC_FUNCTION(hscif0),
+		SH_PFC_FUNCTION(hscif1),
+		SH_PFC_FUNCTION(hscif2),
+		SH_PFC_FUNCTION(hscif3),
+		SH_PFC_FUNCTION(hscif4),
 		SH_PFC_FUNCTION(i2c1),
 		SH_PFC_FUNCTION(i2c2),
 		SH_PFC_FUNCTION(i2c4),
-- 
2.7.4
