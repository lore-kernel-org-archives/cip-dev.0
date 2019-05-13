From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:33 +0100
Subject: [cip-dev] [PATCH 4.4.y 08/52] pinctrl: sh-pfc: r8a77470: Add DU0
	pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 469c1e97dcce926f4c41e438c75ac064a7cbf042 upstream.

Add DU0 pin groups and function to the R8A77470 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index dd54e99..a1eb68b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1222,6 +1222,93 @@ static const unsigned int avb_avtp_capture_b_pins[] = {
 static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
+/* - DU --------------------------------------------------------------------- */
+static const unsigned int du0_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+};
+static const unsigned int du0_rgb666_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK,
+};
+static const unsigned int du0_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 1),  RCAR_GP_PIN(2, 0),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 9),  RCAR_GP_PIN(2, 8),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 16),
+};
+static const unsigned int du0_rgb888_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK, DU0_DR1_MARK, DU0_DR0_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK, DU0_DG1_MARK, DU0_DG0_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK, DU0_DB1_MARK, DU0_DB0_MARK,
+};
+static const unsigned int du0_clk0_out_pins[] = {
+	/* DOTCLKOUT0 */
+	RCAR_GP_PIN(2, 25),
+};
+static const unsigned int du0_clk0_out_mux[] = {
+	DU0_DOTCLKOUT0_MARK
+};
+static const unsigned int du0_clk1_out_pins[] = {
+	/* DOTCLKOUT1 */
+	RCAR_GP_PIN(2, 26),
+};
+static const unsigned int du0_clk1_out_mux[] = {
+	DU0_DOTCLKOUT1_MARK
+};
+static const unsigned int du0_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(2, 24),
+};
+static const unsigned int du0_clk_in_mux[] = {
+	DU0_DOTCLKIN_MARK
+};
+static const unsigned int du0_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(2, 28), RCAR_GP_PIN(2, 27),
+};
+static const unsigned int du0_sync_mux[] = {
+	DU0_EXVSYNC_DU0_VSYNC_MARK, DU0_EXHSYNC_DU0_HSYNC_MARK
+};
+static const unsigned int du0_oddf_pins[] = {
+	/* EXODDF/ODDF/DISP/CDE */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int du0_oddf_mux[] = {
+	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du0_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(2, 31),
+};
+static const unsigned int du0_cde_mux[] = {
+	DU0_CDE_MARK,
+};
+static const unsigned int du0_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(2, 30),
+};
+static const unsigned int du0_disp_mux[] = {
+	DU0_DISP_MARK
+};
 /* - I2C4 ------------------------------------------------------------------- */
 static const unsigned int i2c4_a_pins[] = {
 	/* SCL, SDA */
@@ -1548,6 +1635,15 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 	SH_PFC_PIN_GROUP(avb_avtp_match_b),
 	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+	SH_PFC_PIN_GROUP(du0_rgb666),
+	SH_PFC_PIN_GROUP(du0_rgb888),
+	SH_PFC_PIN_GROUP(du0_clk0_out),
+	SH_PFC_PIN_GROUP(du0_clk1_out),
+	SH_PFC_PIN_GROUP(du0_clk_in),
+	SH_PFC_PIN_GROUP(du0_sync),
+	SH_PFC_PIN_GROUP(du0_oddf),
+	SH_PFC_PIN_GROUP(du0_cde),
+	SH_PFC_PIN_GROUP(du0_disp),
 	SH_PFC_PIN_GROUP(i2c4_a),
 	SH_PFC_PIN_GROUP(i2c4_b),
 	SH_PFC_PIN_GROUP(i2c4_c),
@@ -1608,6 +1704,18 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_b",
 };
 
+static const char * const du0_groups[] = {
+	"du0_rgb666",
+	"du0_rgb888",
+	"du0_clk0_out",
+	"du0_clk1_out",
+	"du0_clk_in",
+	"du0_sync",
+	"du0_oddf",
+	"du0_cde",
+	"du0_disp",
+};
+
 static const char * const i2c4_groups[] = {
 	"i2c4_a",
 	"i2c4_b",
@@ -1679,6 +1787,7 @@ static const char * const scif_clk_groups[] = {
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
+	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(scif0),
-- 
2.7.4
