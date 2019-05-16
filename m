From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:24 +0100
Subject: [cip-dev] [PATCH v2 12/52] pinctrl: sh-pfc: r8a77470: Add remaining
	I2C pin groups
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 80ef7d09104424120c5a9e531f6c41ecb14b023c upstream.

This patch adds I2C[0123] groups and functions to the RZ/G1C
(a.k.a. R8A77470) pinctrl driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1->v2:
* No change
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 191 ++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 283217f..3ca236a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1309,6 +1309,143 @@ static const unsigned int du0_disp_pins[] = {
 static const unsigned int du0_disp_mux[] = {
 	DU0_DISP_MARK
 };
+/* - I2C0 ------------------------------------------------------------------- */
+static const unsigned int i2c0_a_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
+};
+static const unsigned int i2c0_a_mux[] = {
+	SCL0_A_MARK, SDA0_A_MARK,
+};
+static const unsigned int i2c0_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 28), RCAR_GP_PIN(5, 29),
+};
+static const unsigned int i2c0_b_mux[] = {
+	SCL0_B_MARK, SDA0_B_MARK,
+};
+static const unsigned int i2c0_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 12),
+};
+static const unsigned int i2c0_c_mux[] = {
+	SCL0_C_MARK, SDA0_C_MARK,
+};
+static const unsigned int i2c0_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+};
+static const unsigned int i2c0_d_mux[] = {
+	SCL0_D_MARK, SDA0_D_MARK,
+};
+static const unsigned int i2c0_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+};
+static const unsigned int i2c0_e_mux[] = {
+	SCL0_E_MARK, SDA0_E_MARK,
+};
+/* - I2C1 ------------------------------------------------------------------- */
+static const unsigned int i2c1_a_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 2), RCAR_GP_PIN(4, 3),
+};
+static const unsigned int i2c1_a_mux[] = {
+	SCL1_A_MARK, SDA1_A_MARK,
+};
+static const unsigned int i2c1_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
+};
+static const unsigned int i2c1_b_mux[] = {
+	SCL1_B_MARK, SDA1_B_MARK,
+};
+static const unsigned int i2c1_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 23),
+};
+static const unsigned int i2c1_c_mux[] = {
+	SCL1_C_MARK, SDA1_C_MARK,
+};
+static const unsigned int i2c1_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int i2c1_d_mux[] = {
+	SCL1_D_MARK, SDA1_D_MARK,
+};
+static const unsigned int i2c1_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 17),
+};
+static const unsigned int i2c1_e_mux[] = {
+	SCL1_E_MARK, SDA1_E_MARK,
+};
+/* - I2C2 ------------------------------------------------------------------- */
+static const unsigned int i2c2_a_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 25),
+};
+static const unsigned int i2c2_a_mux[] = {
+	SCL2_A_MARK, SDA2_A_MARK,
+};
+static const unsigned int i2c2_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
+};
+static const unsigned int i2c2_b_mux[] = {
+	SCL2_B_MARK, SDA2_B_MARK,
+};
+static const unsigned int i2c2_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+};
+static const unsigned int i2c2_c_mux[] = {
+	SCL2_C_MARK, SDA2_C_MARK,
+};
+static const unsigned int i2c2_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+};
+static const unsigned int i2c2_d_mux[] = {
+	SCL2_D_MARK, SDA2_D_MARK,
+};
+/* - I2C3 ------------------------------------------------------------------- */
+static const unsigned int i2c3_a_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 9), RCAR_GP_PIN(3, 10),
+};
+static const unsigned int i2c3_a_mux[] = {
+	SCL3_A_MARK, SDA3_A_MARK,
+};
+static const unsigned int i2c3_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(1, 0), RCAR_GP_PIN(1, 1),
+};
+static const unsigned int i2c3_b_mux[] = {
+	SCL3_B_MARK, SDA3_B_MARK,
+};
+static const unsigned int i2c3_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+};
+static const unsigned int i2c3_c_mux[] = {
+	SCL3_C_MARK, SDA3_C_MARK,
+};
+static const unsigned int i2c3_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 8), RCAR_GP_PIN(2, 9),
+};
+static const unsigned int i2c3_d_mux[] = {
+	SCL3_D_MARK, SDA3_D_MARK,
+};
+static const unsigned int i2c3_e_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(5, 25), RCAR_GP_PIN(5, 26),
+};
+static const unsigned int i2c3_e_mux[] = {
+	SCL3_E_MARK, SDA3_E_MARK,
+};
 /* - I2C4 ------------------------------------------------------------------- */
 static const unsigned int i2c4_a_pins[] = {
 	/* SCL, SDA */
@@ -1723,6 +1860,25 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du0_oddf),
 	SH_PFC_PIN_GROUP(du0_cde),
 	SH_PFC_PIN_GROUP(du0_disp),
+	SH_PFC_PIN_GROUP(i2c0_a),
+	SH_PFC_PIN_GROUP(i2c0_b),
+	SH_PFC_PIN_GROUP(i2c0_c),
+	SH_PFC_PIN_GROUP(i2c0_d),
+	SH_PFC_PIN_GROUP(i2c0_e),
+	SH_PFC_PIN_GROUP(i2c1_a),
+	SH_PFC_PIN_GROUP(i2c1_b),
+	SH_PFC_PIN_GROUP(i2c1_c),
+	SH_PFC_PIN_GROUP(i2c1_d),
+	SH_PFC_PIN_GROUP(i2c1_e),
+	SH_PFC_PIN_GROUP(i2c2_a),
+	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c2_c),
+	SH_PFC_PIN_GROUP(i2c2_d),
+	SH_PFC_PIN_GROUP(i2c3_a),
+	SH_PFC_PIN_GROUP(i2c3_b),
+	SH_PFC_PIN_GROUP(i2c3_c),
+	SH_PFC_PIN_GROUP(i2c3_d),
+	SH_PFC_PIN_GROUP(i2c3_e),
 	SH_PFC_PIN_GROUP(i2c4_a),
 	SH_PFC_PIN_GROUP(i2c4_b),
 	SH_PFC_PIN_GROUP(i2c4_c),
@@ -1805,6 +1961,37 @@ static const char * const du0_groups[] = {
 	"du0_disp",
 };
 
+static const char * const i2c0_groups[] = {
+	"i2c0_a",
+	"i2c0_b",
+	"i2c0_c",
+	"i2c0_d",
+	"i2c0_e",
+};
+
+static const char * const i2c1_groups[] = {
+	"i2c1_a",
+	"i2c1_b",
+	"i2c1_c",
+	"i2c1_d",
+	"i2c1_e",
+};
+
+static const char * const i2c2_groups[] = {
+	"i2c2_a",
+	"i2c2_b",
+	"i2c2_c",
+	"i2c2_d",
+};
+
+static const char * const i2c3_groups[] = {
+	"i2c3_a",
+	"i2c3_b",
+	"i2c3_c",
+	"i2c3_d",
+	"i2c3_e",
+};
+
 static const char * const i2c4_groups[] = {
 	"i2c4_a",
 	"i2c4_b",
@@ -1899,6 +2086,10 @@ static const char * const usb1_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(du0),
+	SH_PFC_FUNCTION(i2c0),
+	SH_PFC_FUNCTION(i2c1),
+	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(qspi0),
-- 
2.7.4
