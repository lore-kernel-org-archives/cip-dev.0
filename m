From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:02 +0000
Subject: [cip-dev] [PATCH 03/11] pinctrl: sh-pfc: r8a77990: Add SDHI pins,
	groups and functions
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds SDHI{0,1,3} pins, groups and functions to the R8A77990
SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 21ac0d58bb2de14f0898871399f88177be2c0438)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 218 +++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 9232616..903460a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2549,6 +2549,174 @@ static const unsigned int scif_clk_b_mux[] = {
 	SCIF_CLK_B_MARK,
 };
 
+/* - SDHI0 ------------------------------------------------------------------ */
+static const unsigned int sdhi0_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(3, 2),
+};
+
+static const unsigned int sdhi0_data1_mux[] = {
+	SD0_DAT0_MARK,
+};
+
+static const unsigned int sdhi0_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 5),
+};
+
+static const unsigned int sdhi0_data4_mux[] = {
+	SD0_DAT0_MARK, SD0_DAT1_MARK,
+	SD0_DAT2_MARK, SD0_DAT3_MARK,
+};
+
+static const unsigned int sdhi0_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+};
+
+static const unsigned int sdhi0_ctrl_mux[] = {
+	SD0_CLK_MARK, SD0_CMD_MARK,
+};
+
+static const unsigned int sdhi0_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(3, 12),
+};
+
+static const unsigned int sdhi0_cd_mux[] = {
+	SD0_CD_MARK,
+};
+
+static const unsigned int sdhi0_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int sdhi0_wp_mux[] = {
+	SD0_WP_MARK,
+};
+
+/* - SDHI1 ------------------------------------------------------------------ */
+static const unsigned int sdhi1_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(3, 8),
+};
+
+static const unsigned int sdhi1_data1_mux[] = {
+	SD1_DAT0_MARK,
+};
+
+static const unsigned int sdhi1_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(3, 8),  RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
+};
+
+static const unsigned int sdhi1_data4_mux[] = {
+	SD1_DAT0_MARK, SD1_DAT1_MARK,
+	SD1_DAT2_MARK, SD1_DAT3_MARK,
+};
+
+static const unsigned int sdhi1_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
+};
+
+static const unsigned int sdhi1_ctrl_mux[] = {
+	SD1_CLK_MARK, SD1_CMD_MARK,
+};
+
+static const unsigned int sdhi1_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(3, 14),
+};
+
+static const unsigned int sdhi1_cd_mux[] = {
+	SD1_CD_MARK,
+};
+
+static const unsigned int sdhi1_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int sdhi1_wp_mux[] = {
+	SD1_WP_MARK,
+};
+
+/* - SDHI3 ------------------------------------------------------------------ */
+static const unsigned int sdhi3_data1_pins[] = {
+	/* D0 */
+	RCAR_GP_PIN(4, 2),
+};
+
+static const unsigned int sdhi3_data1_mux[] = {
+	SD3_DAT0_MARK,
+};
+
+static const unsigned int sdhi3_data4_pins[] = {
+	/* D[0:3] */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 3),
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+};
+
+static const unsigned int sdhi3_data4_mux[] = {
+	SD3_DAT0_MARK, SD3_DAT1_MARK,
+	SD3_DAT2_MARK, SD3_DAT3_MARK,
+};
+
+static const unsigned int sdhi3_data8_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 3),
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 6), RCAR_GP_PIN(4, 7),
+	RCAR_GP_PIN(4, 8), RCAR_GP_PIN(4, 9),
+};
+
+static const unsigned int sdhi3_data8_mux[] = {
+	SD3_DAT0_MARK, SD3_DAT1_MARK,
+	SD3_DAT2_MARK, SD3_DAT3_MARK,
+	SD3_DAT4_MARK, SD3_DAT5_MARK,
+	SD3_DAT6_MARK, SD3_DAT7_MARK,
+};
+
+static const unsigned int sdhi3_ctrl_pins[] = {
+	/* CLK, CMD */
+	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
+};
+
+static const unsigned int sdhi3_ctrl_mux[] = {
+	SD3_CLK_MARK, SD3_CMD_MARK,
+};
+
+static const unsigned int sdhi3_cd_pins[] = {
+	/* CD */
+	RCAR_GP_PIN(3, 12),
+};
+
+static const unsigned int sdhi3_cd_mux[] = {
+	SD3_CD_MARK,
+};
+
+static const unsigned int sdhi3_wp_pins[] = {
+	/* WP */
+	RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int sdhi3_wp_mux[] = {
+	SD3_WP_MARK,
+};
+
+static const unsigned int sdhi3_ds_pins[] = {
+	/* DS */
+	RCAR_GP_PIN(4, 10),
+};
+
+static const unsigned int sdhi3_ds_mux[] = {
+	SD3_DS_MARK,
+};
+
 /* - SSI -------------------------------------------------------------------- */
 static const unsigned int ssi0_data_pins[] = {
 	/* SDATA */
@@ -2787,7 +2955,7 @@ static const unsigned int usb30_id_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[162];
+	struct sh_pfc_pin_group common[179];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -2927,6 +3095,23 @@ static const struct {
 		SH_PFC_PIN_GROUP(scif5_data_c),
 		SH_PFC_PIN_GROUP(scif_clk_a),
 		SH_PFC_PIN_GROUP(scif_clk_b),
+		SH_PFC_PIN_GROUP(sdhi0_data1),
+		SH_PFC_PIN_GROUP(sdhi0_data4),
+		SH_PFC_PIN_GROUP(sdhi0_ctrl),
+		SH_PFC_PIN_GROUP(sdhi0_cd),
+		SH_PFC_PIN_GROUP(sdhi0_wp),
+		SH_PFC_PIN_GROUP(sdhi1_data1),
+		SH_PFC_PIN_GROUP(sdhi1_data4),
+		SH_PFC_PIN_GROUP(sdhi1_ctrl),
+		SH_PFC_PIN_GROUP(sdhi1_cd),
+		SH_PFC_PIN_GROUP(sdhi1_wp),
+		SH_PFC_PIN_GROUP(sdhi3_data1),
+		SH_PFC_PIN_GROUP(sdhi3_data4),
+		SH_PFC_PIN_GROUP(sdhi3_data8),
+		SH_PFC_PIN_GROUP(sdhi3_ctrl),
+		SH_PFC_PIN_GROUP(sdhi3_cd),
+		SH_PFC_PIN_GROUP(sdhi3_wp),
+		SH_PFC_PIN_GROUP(sdhi3_ds),
 		SH_PFC_PIN_GROUP(ssi0_data),
 		SH_PFC_PIN_GROUP(ssi01239_ctrl),
 		SH_PFC_PIN_GROUP(ssi1_data),
@@ -3176,6 +3361,32 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk_b",
 };
 
+static const char * const sdhi0_groups[] = {
+	"sdhi0_data1",
+	"sdhi0_data4",
+	"sdhi0_ctrl",
+	"sdhi0_cd",
+	"sdhi0_wp",
+};
+
+static const char * const sdhi1_groups[] = {
+	"sdhi1_data1",
+	"sdhi1_data4",
+	"sdhi1_ctrl",
+	"sdhi1_cd",
+	"sdhi1_wp",
+};
+
+static const char * const sdhi3_groups[] = {
+	"sdhi3_data1",
+	"sdhi3_data4",
+	"sdhi3_data8",
+	"sdhi3_ctrl",
+	"sdhi3_cd",
+	"sdhi3_wp",
+	"sdhi3_ds",
+};
+
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi01239_ctrl",
@@ -3212,7 +3423,7 @@ static const char * const usb30_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[31];
+	struct sh_pfc_function common[34];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
@@ -3244,6 +3455,9 @@ static const struct {
 		SH_PFC_FUNCTION(scif4),
 		SH_PFC_FUNCTION(scif5),
 		SH_PFC_FUNCTION(scif_clk),
+		SH_PFC_FUNCTION(sdhi0),
+		SH_PFC_FUNCTION(sdhi1),
+		SH_PFC_FUNCTION(sdhi3),
 		SH_PFC_FUNCTION(ssi),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb30),
-- 
2.7.4
