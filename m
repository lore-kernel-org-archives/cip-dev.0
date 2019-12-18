From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:39 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 29/39] pinctrl: sh-pfc: r8a77965: Add
	DRIF pins, groups and functions
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-30-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 79dbbdbeccc6784d5e189710adcca750c03d3bd4 upstream.

This patch adds DRIF{0,1,2,3} pins, groups and functions to the R8A77965
SoC.

Based on a similar patch of the R8A7796 PFC driver
by Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 350 ++++++++++++++++++++++++++++++++++
 1 file changed, 350 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 1908350..1ecb791 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1847,6 +1847,280 @@ static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
 
+/* - DRIF0 --------------------------------------------------------------- */
+static const unsigned int drif0_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 8), RCAR_GP_PIN(6, 9),
+};
+
+static const unsigned int drif0_ctrl_a_mux[] = {
+	RIF0_CLK_A_MARK, RIF0_SYNC_A_MARK,
+};
+
+static const unsigned int drif0_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 10),
+};
+
+static const unsigned int drif0_data0_a_mux[] = {
+	RIF0_D0_A_MARK,
+};
+
+static const unsigned int drif0_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 7),
+};
+
+static const unsigned int drif0_data1_a_mux[] = {
+	RIF0_D1_A_MARK,
+};
+
+static const unsigned int drif0_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 4),
+};
+
+static const unsigned int drif0_ctrl_b_mux[] = {
+	RIF0_CLK_B_MARK, RIF0_SYNC_B_MARK,
+};
+
+static const unsigned int drif0_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 1),
+};
+
+static const unsigned int drif0_data0_b_mux[] = {
+	RIF0_D0_B_MARK,
+};
+
+static const unsigned int drif0_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 2),
+};
+
+static const unsigned int drif0_data1_b_mux[] = {
+	RIF0_D1_B_MARK,
+};
+
+static const unsigned int drif0_ctrl_c_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 15),
+};
+
+static const unsigned int drif0_ctrl_c_mux[] = {
+	RIF0_CLK_C_MARK, RIF0_SYNC_C_MARK,
+};
+
+static const unsigned int drif0_data0_c_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 13),
+};
+
+static const unsigned int drif0_data0_c_mux[] = {
+	RIF0_D0_C_MARK,
+};
+
+static const unsigned int drif0_data1_c_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 14),
+};
+
+static const unsigned int drif0_data1_c_mux[] = {
+	RIF0_D1_C_MARK,
+};
+
+/* - DRIF1 --------------------------------------------------------------- */
+static const unsigned int drif1_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 17), RCAR_GP_PIN(6, 18),
+};
+
+static const unsigned int drif1_ctrl_a_mux[] = {
+	RIF1_CLK_A_MARK, RIF1_SYNC_A_MARK,
+};
+
+static const unsigned int drif1_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 19),
+};
+
+static const unsigned int drif1_data0_a_mux[] = {
+	RIF1_D0_A_MARK,
+};
+
+static const unsigned int drif1_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 20),
+};
+
+static const unsigned int drif1_data1_a_mux[] = {
+	RIF1_D1_A_MARK,
+};
+
+static const unsigned int drif1_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 3),
+};
+
+static const unsigned int drif1_ctrl_b_mux[] = {
+	RIF1_CLK_B_MARK, RIF1_SYNC_B_MARK,
+};
+
+static const unsigned int drif1_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 7),
+};
+
+static const unsigned int drif1_data0_b_mux[] = {
+	RIF1_D0_B_MARK,
+};
+
+static const unsigned int drif1_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 8),
+};
+
+static const unsigned int drif1_data1_b_mux[] = {
+	RIF1_D1_B_MARK,
+};
+
+static const unsigned int drif1_ctrl_c_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 11),
+};
+
+static const unsigned int drif1_ctrl_c_mux[] = {
+	RIF1_CLK_C_MARK, RIF1_SYNC_C_MARK,
+};
+
+static const unsigned int drif1_data0_c_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 6),
+};
+
+static const unsigned int drif1_data0_c_mux[] = {
+	RIF1_D0_C_MARK,
+};
+
+static const unsigned int drif1_data1_c_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 10),
+};
+
+static const unsigned int drif1_data1_c_mux[] = {
+	RIF1_D1_C_MARK,
+};
+
+/* - DRIF2 --------------------------------------------------------------- */
+static const unsigned int drif2_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 8), RCAR_GP_PIN(6, 9),
+};
+
+static const unsigned int drif2_ctrl_a_mux[] = {
+	RIF2_CLK_A_MARK, RIF2_SYNC_A_MARK,
+};
+
+static const unsigned int drif2_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 7),
+};
+
+static const unsigned int drif2_data0_a_mux[] = {
+	RIF2_D0_A_MARK,
+};
+
+static const unsigned int drif2_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 10),
+};
+
+static const unsigned int drif2_data1_a_mux[] = {
+	RIF2_D1_A_MARK,
+};
+
+static const unsigned int drif2_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 26), RCAR_GP_PIN(6, 27),
+};
+
+static const unsigned int drif2_ctrl_b_mux[] = {
+	RIF2_CLK_B_MARK, RIF2_SYNC_B_MARK,
+};
+
+static const unsigned int drif2_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 30),
+};
+
+static const unsigned int drif2_data0_b_mux[] = {
+	RIF2_D0_B_MARK,
+};
+
+static const unsigned int drif2_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 31),
+};
+
+static const unsigned int drif2_data1_b_mux[] = {
+	RIF2_D1_B_MARK,
+};
+
+/* - DRIF3 --------------------------------------------------------------- */
+static const unsigned int drif3_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 17), RCAR_GP_PIN(6, 18),
+};
+
+static const unsigned int drif3_ctrl_a_mux[] = {
+	RIF3_CLK_A_MARK, RIF3_SYNC_A_MARK,
+};
+
+static const unsigned int drif3_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 19),
+};
+
+static const unsigned int drif3_data0_a_mux[] = {
+	RIF3_D0_A_MARK,
+};
+
+static const unsigned int drif3_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 20),
+};
+
+static const unsigned int drif3_data1_a_mux[] = {
+	RIF3_D1_A_MARK,
+};
+
+static const unsigned int drif3_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(6, 24), RCAR_GP_PIN(6, 25),
+};
+
+static const unsigned int drif3_ctrl_b_mux[] = {
+	RIF3_CLK_B_MARK, RIF3_SYNC_B_MARK,
+};
+
+static const unsigned int drif3_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(6, 28),
+};
+
+static const unsigned int drif3_data0_b_mux[] = {
+	RIF3_D0_B_MARK,
+};
+
+static const unsigned int drif3_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(6, 29),
+};
+
+static const unsigned int drif3_data1_b_mux[] = {
+	RIF3_D1_B_MARK,
+};
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -4070,6 +4344,36 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(canfd0_data_a),
 	SH_PFC_PIN_GROUP(canfd0_data_b),
 	SH_PFC_PIN_GROUP(canfd1_data),
+	SH_PFC_PIN_GROUP(drif0_ctrl_a),
+	SH_PFC_PIN_GROUP(drif0_data0_a),
+	SH_PFC_PIN_GROUP(drif0_data1_a),
+	SH_PFC_PIN_GROUP(drif0_ctrl_b),
+	SH_PFC_PIN_GROUP(drif0_data0_b),
+	SH_PFC_PIN_GROUP(drif0_data1_b),
+	SH_PFC_PIN_GROUP(drif0_ctrl_c),
+	SH_PFC_PIN_GROUP(drif0_data0_c),
+	SH_PFC_PIN_GROUP(drif0_data1_c),
+	SH_PFC_PIN_GROUP(drif1_ctrl_a),
+	SH_PFC_PIN_GROUP(drif1_data0_a),
+	SH_PFC_PIN_GROUP(drif1_data1_a),
+	SH_PFC_PIN_GROUP(drif1_ctrl_b),
+	SH_PFC_PIN_GROUP(drif1_data0_b),
+	SH_PFC_PIN_GROUP(drif1_data1_b),
+	SH_PFC_PIN_GROUP(drif1_ctrl_c),
+	SH_PFC_PIN_GROUP(drif1_data0_c),
+	SH_PFC_PIN_GROUP(drif1_data1_c),
+	SH_PFC_PIN_GROUP(drif2_ctrl_a),
+	SH_PFC_PIN_GROUP(drif2_data0_a),
+	SH_PFC_PIN_GROUP(drif2_data1_a),
+	SH_PFC_PIN_GROUP(drif2_ctrl_b),
+	SH_PFC_PIN_GROUP(drif2_data0_b),
+	SH_PFC_PIN_GROUP(drif2_data1_b),
+	SH_PFC_PIN_GROUP(drif3_ctrl_a),
+	SH_PFC_PIN_GROUP(drif3_data0_a),
+	SH_PFC_PIN_GROUP(drif3_data1_a),
+	SH_PFC_PIN_GROUP(drif3_ctrl_b),
+	SH_PFC_PIN_GROUP(drif3_data0_b),
+	SH_PFC_PIN_GROUP(drif3_data1_b),
 	SH_PFC_PIN_GROUP(du_rgb666),
 	SH_PFC_PIN_GROUP(du_rgb888),
 	SH_PFC_PIN_GROUP(du_clk_out_0),
@@ -4404,6 +4708,48 @@ static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
 
+static const char * const drif0_groups[] = {
+	"drif0_ctrl_a",
+	"drif0_data0_a",
+	"drif0_data1_a",
+	"drif0_ctrl_b",
+	"drif0_data0_b",
+	"drif0_data1_b",
+	"drif0_ctrl_c",
+	"drif0_data0_c",
+	"drif0_data1_c",
+};
+
+static const char * const drif1_groups[] = {
+	"drif1_ctrl_a",
+	"drif1_data0_a",
+	"drif1_data1_a",
+	"drif1_ctrl_b",
+	"drif1_data0_b",
+	"drif1_data1_b",
+	"drif1_ctrl_c",
+	"drif1_data0_c",
+	"drif1_data1_c",
+};
+
+static const char * const drif2_groups[] = {
+	"drif2_ctrl_a",
+	"drif2_data0_a",
+	"drif2_data1_a",
+	"drif2_ctrl_b",
+	"drif2_data0_b",
+	"drif2_data1_b",
+};
+
+static const char * const drif3_groups[] = {
+	"drif3_ctrl_a",
+	"drif3_data0_a",
+	"drif3_data1_a",
+	"drif3_ctrl_b",
+	"drif3_data0_b",
+	"drif3_data1_b",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4807,6 +5153,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(can_clk),
 	SH_PFC_FUNCTION(canfd0),
 	SH_PFC_FUNCTION(canfd1),
+	SH_PFC_FUNCTION(drif0),
+	SH_PFC_FUNCTION(drif1),
+	SH_PFC_FUNCTION(drif2),
+	SH_PFC_FUNCTION(drif3),
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
-- 
2.7.4
