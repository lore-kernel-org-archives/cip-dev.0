From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:01 +0000
Subject: [cip-dev] [PATCH 02/11] pinctrl: sh-pfc: r8a77990: Add Audio SSI
	pins, groups and functions
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Audio SSI{0,1,2,3,4,5,6,7,8,9} pins, groups
and functions to the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: rebase]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

(cherry picked from commit ccb44a8a5bbaaed1368e426e738591d7c41997c2)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 240 +++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 4e37222..9232616 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2549,6 +2549,196 @@ static const unsigned int scif_clk_b_mux[] = {
 	SCIF_CLK_B_MARK,
 };
 
+/* - SSI -------------------------------------------------------------------- */
+static const unsigned int ssi0_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 2),
+};
+
+static const unsigned int ssi0_data_mux[] = {
+	SSI_SDATA0_MARK,
+};
+
+static const unsigned int ssi01239_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1),
+};
+
+static const unsigned int ssi01239_ctrl_mux[] = {
+	SSI_SCK01239_MARK, SSI_WS01239_MARK,
+};
+
+static const unsigned int ssi1_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 3),
+};
+
+static const unsigned int ssi1_data_mux[] = {
+	SSI_SDATA1_MARK,
+};
+
+static const unsigned int ssi1_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int ssi1_ctrl_mux[] = {
+	SSI_SCK1_MARK, SSI_WS1_MARK,
+};
+
+static const unsigned int ssi2_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 4),
+};
+
+static const unsigned int ssi2_data_mux[] = {
+	SSI_SDATA2_MARK,
+};
+
+static const unsigned int ssi2_ctrl_a_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+};
+
+static const unsigned int ssi2_ctrl_a_mux[] = {
+	SSI_SCK2_A_MARK, SSI_WS2_A_MARK,
+};
+
+static const unsigned int ssi2_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int ssi2_ctrl_b_mux[] = {
+	SSI_SCK2_B_MARK, SSI_WS2_B_MARK,
+};
+
+static const unsigned int ssi3_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 7),
+};
+
+static const unsigned int ssi3_data_mux[] = {
+	SSI_SDATA3_MARK,
+};
+
+static const unsigned int ssi349_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(6, 5), RCAR_GP_PIN(6, 6),
+};
+
+static const unsigned int ssi349_ctrl_mux[] = {
+	SSI_SCK349_MARK, SSI_WS349_MARK,
+};
+
+static const unsigned int ssi4_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 10),
+};
+
+static const unsigned int ssi4_data_mux[] = {
+	SSI_SDATA4_MARK,
+};
+
+static const unsigned int ssi4_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
+};
+
+static const unsigned int ssi4_ctrl_mux[] = {
+	SSI_SCK4_MARK, SSI_WS4_MARK,
+};
+
+static const unsigned int ssi5_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 13),
+};
+
+static const unsigned int ssi5_data_mux[] = {
+	SSI_SDATA5_MARK,
+};
+
+static const unsigned int ssi5_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(6, 11), RCAR_GP_PIN(6, 12),
+};
+
+static const unsigned int ssi5_ctrl_mux[] = {
+	SSI_SCK5_MARK, SSI_WS5_MARK,
+};
+
+static const unsigned int ssi6_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(6, 16),
+};
+
+static const unsigned int ssi6_data_mux[] = {
+	SSI_SDATA6_MARK,
+};
+
+static const unsigned int ssi6_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(6, 14), RCAR_GP_PIN(6, 15),
+};
+
+static const unsigned int ssi6_ctrl_mux[] = {
+	SSI_SCK6_MARK, SSI_WS6_MARK,
+};
+
+static const unsigned int ssi7_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(5, 12),
+};
+
+static const unsigned int ssi7_data_mux[] = {
+	SSI_SDATA7_MARK,
+};
+
+static const unsigned int ssi78_ctrl_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 10), RCAR_GP_PIN(5, 11),
+};
+
+static const unsigned int ssi78_ctrl_mux[] = {
+	SSI_SCK78_MARK, SSI_WS78_MARK,
+};
+
+static const unsigned int ssi8_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(5, 13),
+};
+
+static const unsigned int ssi8_data_mux[] = {
+	SSI_SDATA8_MARK,
+};
+
+static const unsigned int ssi9_data_pins[] = {
+	/* SDATA */
+	RCAR_GP_PIN(5, 16),
+};
+
+static const unsigned int ssi9_data_mux[] = {
+	SSI_SDATA9_MARK,
+};
+
+static const unsigned int ssi9_ctrl_a_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(6, 4), RCAR_GP_PIN(6, 10),
+};
+
+static const unsigned int ssi9_ctrl_a_mux[] = {
+	SSI_SCK9_A_MARK, SSI_WS9_A_MARK,
+};
+
+static const unsigned int ssi9_ctrl_b_pins[] = {
+	/* SCK, WS */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+};
+
+static const unsigned int ssi9_ctrl_b_mux[] = {
+	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
+};
+
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_a_pins[] = {
 	/* PWEN, OVC */
@@ -2597,7 +2787,7 @@ static const unsigned int usb30_id_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[141];
+	struct sh_pfc_pin_group common[162];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -2737,6 +2927,27 @@ static const struct {
 		SH_PFC_PIN_GROUP(scif5_data_c),
 		SH_PFC_PIN_GROUP(scif_clk_a),
 		SH_PFC_PIN_GROUP(scif_clk_b),
+		SH_PFC_PIN_GROUP(ssi0_data),
+		SH_PFC_PIN_GROUP(ssi01239_ctrl),
+		SH_PFC_PIN_GROUP(ssi1_data),
+		SH_PFC_PIN_GROUP(ssi1_ctrl),
+		SH_PFC_PIN_GROUP(ssi2_data),
+		SH_PFC_PIN_GROUP(ssi2_ctrl_a),
+		SH_PFC_PIN_GROUP(ssi2_ctrl_b),
+		SH_PFC_PIN_GROUP(ssi3_data),
+		SH_PFC_PIN_GROUP(ssi349_ctrl),
+		SH_PFC_PIN_GROUP(ssi4_data),
+		SH_PFC_PIN_GROUP(ssi4_ctrl),
+		SH_PFC_PIN_GROUP(ssi5_data),
+		SH_PFC_PIN_GROUP(ssi5_ctrl),
+		SH_PFC_PIN_GROUP(ssi6_data),
+		SH_PFC_PIN_GROUP(ssi6_ctrl),
+		SH_PFC_PIN_GROUP(ssi7_data),
+		SH_PFC_PIN_GROUP(ssi78_ctrl),
+		SH_PFC_PIN_GROUP(ssi8_data),
+		SH_PFC_PIN_GROUP(ssi9_data),
+		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
+		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
 		SH_PFC_PIN_GROUP(usb0_a),
 		SH_PFC_PIN_GROUP(usb0_b),
 		SH_PFC_PIN_GROUP(usb0_id),
@@ -2965,6 +3176,30 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk_b",
 };
 
+static const char * const ssi_groups[] = {
+	"ssi0_data",
+	"ssi01239_ctrl",
+	"ssi1_data",
+	"ssi1_ctrl",
+	"ssi2_data",
+	"ssi2_ctrl_a",
+	"ssi2_ctrl_b",
+	"ssi3_data",
+	"ssi349_ctrl",
+	"ssi4_data",
+	"ssi4_ctrl",
+	"ssi5_data",
+	"ssi5_ctrl",
+	"ssi6_data",
+	"ssi6_ctrl",
+	"ssi7_data",
+	"ssi78_ctrl",
+	"ssi8_data",
+	"ssi9_data",
+	"ssi9_ctrl_a",
+	"ssi9_ctrl_b",
+};
+
 static const char * const usb0_groups[] = {
 	"usb0_a",
 	"usb0_b",
@@ -2977,7 +3212,7 @@ static const char * const usb30_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[30];
+	struct sh_pfc_function common[31];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
@@ -3009,6 +3244,7 @@ static const struct {
 		SH_PFC_FUNCTION(scif4),
 		SH_PFC_FUNCTION(scif5),
 		SH_PFC_FUNCTION(scif_clk),
+		SH_PFC_FUNCTION(ssi),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb30),
 	}
-- 
2.7.4
