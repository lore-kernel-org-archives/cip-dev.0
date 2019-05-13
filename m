From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:38 +0100
Subject: [cip-dev] [PATCH 4.4.y 13/52] pinctrl: sh-pfc: r8a77470: Add DU1
	pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 5c9258bca9ace0a25614b635fc1c2836ee4d8c96 upstream.

Add DU1 pin groups and function to the RZ/G1C (a.k.a. R8A77470)
pinctrl driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 108 ++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 3ca236a..81ef3af 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1309,6 +1309,92 @@ static const unsigned int du0_disp_pins[] = {
 static const unsigned int du0_disp_mux[] = {
 	DU0_DISP_MARK
 };
+static const unsigned int du1_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 8),  RCAR_GP_PIN(4, 7),
+	RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),  RCAR_GP_PIN(4, 4),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 15),
+	RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 12),
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 23),
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21), RCAR_GP_PIN(4, 20),
+};
+static const unsigned int du1_rgb666_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK,
+};
+static const unsigned int du1_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 8),  RCAR_GP_PIN(4, 7),
+	RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),  RCAR_GP_PIN(4, 4),
+	RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 15),
+	RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 12),
+	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 23),
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21), RCAR_GP_PIN(4, 20),
+	RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int du1_rgb888_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK, DU1_DR1_MARK, DU1_DR0_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK, DU1_DG1_MARK, DU1_DG0_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
+};
+static const unsigned int du1_clk0_out_pins[] = {
+	/* DOTCLKOUT0 */
+	RCAR_GP_PIN(5, 2),
+};
+static const unsigned int du1_clk0_out_mux[] = {
+	DU1_DOTCLKOUT0_MARK
+};
+static const unsigned int du1_clk1_out_pins[] = {
+	/* DOTCLKOUT1 */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int du1_clk1_out_mux[] = {
+	DU1_DOTCLKOUT1_MARK
+};
+static const unsigned int du1_clk_in_pins[] = {
+	/* DOTCLKIN */
+	RCAR_GP_PIN(5, 1),
+};
+static const unsigned int du1_clk_in_mux[] = {
+	DU1_DOTCLKIN_MARK
+};
+static const unsigned int du1_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 4),
+};
+static const unsigned int du1_sync_mux[] = {
+	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
+};
+static const unsigned int du1_oddf_pins[] = {
+	/* EXODDF/ODDF/DISP/CDE */
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int du1_oddf_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du1_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(5, 7),
+};
+static const unsigned int du1_cde_mux[] = {
+	DU1_CDE_MARK
+};
+static const unsigned int du1_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(5, 6),
+};
+static const unsigned int du1_disp_mux[] = {
+	DU1_DISP_MARK
+};
 /* - I2C0 ------------------------------------------------------------------- */
 static const unsigned int i2c0_a_pins[] = {
 	/* SCL, SDA */
@@ -1860,6 +1946,15 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_oddf),
 	SH_PFC_PIN_GROUP(du0_cde),
 	SH_PFC_PIN_GROUP(du0_disp),
+	SH_PFC_PIN_GROUP(du1_rgb666),
+	SH_PFC_PIN_GROUP(du1_rgb888),
+	SH_PFC_PIN_GROUP(du1_clk0_out),
+	SH_PFC_PIN_GROUP(du1_clk1_out),
+	SH_PFC_PIN_GROUP(du1_clk_in),
+	SH_PFC_PIN_GROUP(du1_sync),
+	SH_PFC_PIN_GROUP(du1_oddf),
+	SH_PFC_PIN_GROUP(du1_cde),
+	SH_PFC_PIN_GROUP(du1_disp),
 	SH_PFC_PIN_GROUP(i2c0_a),
 	SH_PFC_PIN_GROUP(i2c0_b),
 	SH_PFC_PIN_GROUP(i2c0_c),
@@ -1961,6 +2056,18 @@ static const char * const du0_groups[] = {
 	"du0_disp",
 };
 
+static const char * const du1_groups[] = {
+	"du1_rgb666",
+	"du1_rgb888",
+	"du1_clk0_out",
+	"du1_clk1_out",
+	"du1_clk_in",
+	"du1_sync",
+	"du1_oddf",
+	"du1_cde",
+	"du1_disp",
+};
+
 static const char * const i2c0_groups[] = {
 	"i2c0_a",
 	"i2c0_b",
@@ -2086,6 +2193,7 @@ static const char * const usb1_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(du0),
+	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(i2c0),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
-- 
2.7.4
