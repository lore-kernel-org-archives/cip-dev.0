From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:47 +0100
Subject: [cip-dev] [PATCH 4.19y 10/10] pinctrl: sh-pfc: r8a77990: Add DRIF
	pins, groups and functions
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit fdbbd6b74c9278f65302af113e73cf61d36d3037 upstream.

This patch adds DRIF{0,1,2,3} pins, groups and functions to the R8A77990
SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 255 +++++++++++++++++++++++++++++++++-
 1 file changed, 253 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 0a9aa62..151640c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1599,6 +1599,199 @@ static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK, CANFD1_RX_MARK,
 };
 
+/* - DRIF0 --------------------------------------------------------------- */
+static const unsigned int drif0_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 7), RCAR_GP_PIN(5, 19),
+};
+
+static const unsigned int drif0_ctrl_a_mux[] = {
+	RIF0_CLK_A_MARK, RIF0_SYNC_A_MARK,
+};
+
+static const unsigned int drif0_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 17),
+};
+
+static const unsigned int drif0_data0_a_mux[] = {
+	RIF0_D0_A_MARK,
+};
+
+static const unsigned int drif0_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 18),
+};
+
+static const unsigned int drif0_data1_a_mux[] = {
+	RIF0_D1_A_MARK,
+};
+
+static const unsigned int drif0_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int drif0_ctrl_b_mux[] = {
+	RIF0_CLK_B_MARK, RIF0_SYNC_B_MARK,
+};
+
+static const unsigned int drif0_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int drif0_data0_b_mux[] = {
+	RIF0_D0_B_MARK,
+};
+
+static const unsigned int drif0_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(3, 14),
+};
+
+static const unsigned int drif0_data1_b_mux[] = {
+	RIF0_D1_B_MARK,
+};
+
+/* - DRIF1 --------------------------------------------------------------- */
+static const unsigned int drif1_ctrl_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 1),
+};
+
+static const unsigned int drif1_ctrl_mux[] = {
+	RIF1_CLK_MARK, RIF1_SYNC_MARK,
+};
+
+static const unsigned int drif1_data0_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(5, 2),
+};
+
+static const unsigned int drif1_data0_mux[] = {
+	RIF1_D0_MARK,
+};
+
+static const unsigned int drif1_data1_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(5, 3),
+};
+
+static const unsigned int drif1_data1_mux[] = {
+	RIF1_D1_MARK,
+};
+
+/* - DRIF2 --------------------------------------------------------------- */
+static const unsigned int drif2_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+};
+
+static const unsigned int drif2_ctrl_a_mux[] = {
+	RIF2_CLK_A_MARK, RIF2_SYNC_A_MARK,
+};
+
+static const unsigned int drif2_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(2, 8),
+};
+
+static const unsigned int drif2_data0_a_mux[] = {
+	RIF2_D0_A_MARK,
+};
+
+static const unsigned int drif2_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(2, 9),
+};
+
+static const unsigned int drif2_data1_a_mux[] = {
+	RIF2_D1_A_MARK,
+};
+
+static const unsigned int drif2_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+};
+
+static const unsigned int drif2_ctrl_b_mux[] = {
+	RIF2_CLK_B_MARK, RIF2_SYNC_B_MARK,
+};
+
+static const unsigned int drif2_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(1, 6),
+};
+
+static const unsigned int drif2_data0_b_mux[] = {
+	RIF2_D0_B_MARK,
+};
+
+static const unsigned int drif2_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(1, 7),
+};
+
+static const unsigned int drif2_data1_b_mux[] = {
+	RIF2_D1_B_MARK,
+};
+
+/* - DRIF3 --------------------------------------------------------------- */
+static const unsigned int drif3_ctrl_a_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11),
+};
+
+static const unsigned int drif3_ctrl_a_mux[] = {
+	RIF3_CLK_A_MARK, RIF3_SYNC_A_MARK,
+};
+
+static const unsigned int drif3_data0_a_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(2, 12),
+};
+
+static const unsigned int drif3_data0_a_mux[] = {
+	RIF3_D0_A_MARK,
+};
+
+static const unsigned int drif3_data1_a_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(2, 13),
+};
+
+static const unsigned int drif3_data1_a_mux[] = {
+	RIF3_D1_A_MARK,
+};
+
+static const unsigned int drif3_ctrl_b_pins[] = {
+	/* CLK, SYNC */
+	RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9),
+};
+
+static const unsigned int drif3_ctrl_b_mux[] = {
+	RIF3_CLK_B_MARK, RIF3_SYNC_B_MARK,
+};
+
+static const unsigned int drif3_data0_b_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(0, 10),
+};
+
+static const unsigned int drif3_data0_b_mux[] = {
+	RIF3_D0_B_MARK,
+};
+
+static const unsigned int drif3_data1_b_pins[] = {
+	/* D1 */
+	RCAR_GP_PIN(0, 11),
+};
+
+static const unsigned int drif3_data1_b_mux[] = {
+	RIF3_D1_B_MARK,
+};
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3574,7 +3767,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[245];
-	struct sh_pfc_pin_group automotive[2];
+	struct sh_pfc_pin_group automotive[23];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a),
@@ -3826,6 +4019,27 @@ static const struct {
 	.automotive = {
 		SH_PFC_PIN_GROUP(canfd0_data),
 		SH_PFC_PIN_GROUP(canfd1_data),
+		SH_PFC_PIN_GROUP(drif0_ctrl_a),
+		SH_PFC_PIN_GROUP(drif0_data0_a),
+		SH_PFC_PIN_GROUP(drif0_data1_a),
+		SH_PFC_PIN_GROUP(drif0_ctrl_b),
+		SH_PFC_PIN_GROUP(drif0_data0_b),
+		SH_PFC_PIN_GROUP(drif0_data1_b),
+		SH_PFC_PIN_GROUP(drif1_ctrl),
+		SH_PFC_PIN_GROUP(drif1_data0),
+		SH_PFC_PIN_GROUP(drif1_data1),
+		SH_PFC_PIN_GROUP(drif2_ctrl_a),
+		SH_PFC_PIN_GROUP(drif2_data0_a),
+		SH_PFC_PIN_GROUP(drif2_data1_a),
+		SH_PFC_PIN_GROUP(drif2_ctrl_b),
+		SH_PFC_PIN_GROUP(drif2_data0_b),
+		SH_PFC_PIN_GROUP(drif2_data1_b),
+		SH_PFC_PIN_GROUP(drif3_ctrl_a),
+		SH_PFC_PIN_GROUP(drif3_data0_a),
+		SH_PFC_PIN_GROUP(drif3_data1_a),
+		SH_PFC_PIN_GROUP(drif3_ctrl_b),
+		SH_PFC_PIN_GROUP(drif3_data0_b),
+		SH_PFC_PIN_GROUP(drif3_data1_b),
 	}
 };
 
@@ -3880,6 +4094,39 @@ static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
 
+static const char * const drif0_groups[] = {
+	"drif0_ctrl_a",
+	"drif0_data0_a",
+	"drif0_data1_a",
+	"drif0_ctrl_b",
+	"drif0_data0_b",
+	"drif0_data1_b",
+};
+
+static const char * const drif1_groups[] = {
+	"drif1_ctrl",
+	"drif1_data0",
+	"drif1_data1",
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
@@ -4219,7 +4466,7 @@ static const char * const vin5_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[45];
-	struct sh_pfc_function automotive[2];
+	struct sh_pfc_function automotive[6];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -4271,6 +4518,10 @@ static const struct {
 	.automotive = {
 		SH_PFC_FUNCTION(canfd0),
 		SH_PFC_FUNCTION(canfd1),
+		SH_PFC_FUNCTION(drif0),
+		SH_PFC_FUNCTION(drif1),
+		SH_PFC_FUNCTION(drif2),
+		SH_PFC_FUNCTION(drif3),
 	}
 };
 
-- 
2.7.4
