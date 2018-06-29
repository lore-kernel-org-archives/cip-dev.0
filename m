From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:40 +0100
Subject: [cip-dev] [PATCH 39/86] pinctrl: sh-pfc: r8a7794: Add i2c5 pin
	groups and function
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-40-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add i2c5 pin groups and function to r8a7745 PFC driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 0d68d46035a196c91ee70df2ba204ed708bba315)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index fb4ae85..1b8cb3b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2245,6 +2245,35 @@ static const unsigned int i2c4_e_pins[] = {
 static const unsigned int i2c4_e_mux[] = {
 	I2C4_SCL_E_MARK, I2C4_SDA_E_MARK,
 };
+/* - I2C5 ------------------------------------------------------------------- */
+static const unsigned int i2c5_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 15),
+};
+static const unsigned int i2c5_mux[] = {
+	I2C5_SCL_MARK, I2C5_SDA_MARK,
+};
+static const unsigned int i2c5_b_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+};
+static const unsigned int i2c5_b_mux[] = {
+	I2C5_SCL_B_MARK, I2C5_SDA_B_MARK,
+};
+static const unsigned int i2c5_c_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(4, 31), RCAR_GP_PIN(4, 30),
+};
+static const unsigned int i2c5_c_mux[] = {
+	I2C5_SCL_C_MARK, I2C5_SDA_C_MARK,
+};
+static const unsigned int i2c5_d_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 14),
+};
+static const unsigned int i2c5_d_mux[] = {
+	I2C5_SCL_D_MARK, I2C5_SDA_D_MARK,
+};
 /* - INTC ------------------------------------------------------------------- */
 static const unsigned int intc_irq0_pins[] = {
 	/* IRQ0 */
@@ -3838,6 +3867,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c4_c),
 	SH_PFC_PIN_GROUP(i2c4_d),
 	SH_PFC_PIN_GROUP(i2c4_e),
+	SH_PFC_PIN_GROUP(i2c5),
+	SH_PFC_PIN_GROUP(i2c5_b),
+	SH_PFC_PIN_GROUP(i2c5_c),
+	SH_PFC_PIN_GROUP(i2c5_d),
 	SH_PFC_PIN_GROUP(intc_irq0),
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
@@ -4213,6 +4246,13 @@ static const char * const i2c4_groups[] = {
 	"i2c4_e",
 };
 
+static const char * const i2c5_groups[] = {
+	"i2c5",
+	"i2c5_b",
+	"i2c5_c",
+	"i2c5_d",
+};
+
 static const char * const intc_groups[] = {
 	"intc_irq0",
 	"intc_irq1",
@@ -4554,6 +4594,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(i2c4),
+	SH_PFC_FUNCTION(i2c5),
 	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(msiof0),
-- 
2.7.4
