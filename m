From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:32 +0100
Subject: [cip-dev] [PATCH 4.4.y 07/52] pinctrl: sh-pfc: r8a77470: Add I2C4
	pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e34ebe5a6b8318eb6d99d5476072e4eddf5c46f2 upstream.

Add I2C4 pin groups and function to the R8A77470 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 4526b0f..dd54e99 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1222,6 +1222,42 @@ static const unsigned int avb_avtp_capture_b_pins[] = {
 static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
+/* - I2C4 ------------------------------------------------------------------- */
+static const unsigned int i2c4_a_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 10), RCAR_GP_PIN(4, 11),
+};
+static const unsigned int i2c4_a_mux[] = {
+	SCL4_A_MARK, SDA4_A_MARK,
+};
+static const unsigned int i2c4_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 30), RCAR_GP_PIN(5, 31),
+};
+static const unsigned int i2c4_b_mux[] = {
+	SCL4_B_MARK, SDA4_B_MARK,
+};
+static const unsigned int i2c4_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 5),
+};
+static const unsigned int i2c4_c_mux[] = {
+	SCL4_C_MARK, SDA4_C_MARK,
+};
+static const unsigned int i2c4_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 17),
+};
+static const unsigned int i2c4_d_mux[] = {
+	SCL4_D_MARK, SDA4_D_MARK,
+};
+static const unsigned int i2c4_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 7), RCAR_GP_PIN(5, 6),
+};
+static const unsigned int i2c4_e_mux[] = {
+	SCL4_E_MARK, SDA4_E_MARK,
+};
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data1_pins[] = {
 	/* D0 */
@@ -1512,6 +1548,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 	SH_PFC_PIN_GROUP(avb_avtp_match_b),
 	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+	SH_PFC_PIN_GROUP(i2c4_a),
+	SH_PFC_PIN_GROUP(i2c4_b),
+	SH_PFC_PIN_GROUP(i2c4_c),
+	SH_PFC_PIN_GROUP(i2c4_d),
+	SH_PFC_PIN_GROUP(i2c4_e),
 	SH_PFC_PIN_GROUP(mmc_data1),
 	SH_PFC_PIN_GROUP(mmc_data4),
 	SH_PFC_PIN_GROUP(mmc_data8),
@@ -1566,6 +1607,15 @@ static const char * const avb_groups[] = {
 	"avb_avtp_match_b",
 	"avb_avtp_capture_b",
 };
+
+static const char * const i2c4_groups[] = {
+	"i2c4_a",
+	"i2c4_b",
+	"i2c4_c",
+	"i2c4_d",
+	"i2c4_e",
+};
+
 static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
@@ -1629,6 +1679,7 @@ static const char * const scif_clk_groups[] = {
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
+	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
-- 
2.7.4
