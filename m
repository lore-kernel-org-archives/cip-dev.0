From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:38 +0100
Subject: [cip-dev] [PATCH 37/86] pinctrl: sh-pfc: r8a7794: Add PWM[0123456]
	support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-38-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds PFC PWM[0123456] pin groups and functions, enabling
PWM on the r8a7794 and r8a7745.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 20796a2caf011b9a94763e26b89be7a13a2756f5)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 165 +++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 2380824..738f8bf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2563,6 +2563,109 @@ static const unsigned int msiof2_tx_b_pins[] = {
 static const unsigned int msiof2_tx_b_mux[] = {
 	MSIOF2_TXD_B_MARK,
 };
+/* - PWM -------------------------------------------------------------------- */
+static const unsigned int pwm0_pins[] = {
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int pwm0_mux[] = {
+	PWM0_MARK,
+};
+static const unsigned int pwm0_b_pins[] = {
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int pwm0_b_mux[] = {
+	PWM0_B_MARK,
+};
+static const unsigned int pwm1_pins[] = {
+	RCAR_GP_PIN(4, 5),
+};
+static const unsigned int pwm1_mux[] = {
+	PWM1_MARK,
+};
+static const unsigned int pwm1_b_pins[] = {
+	RCAR_GP_PIN(5, 10),
+};
+static const unsigned int pwm1_b_mux[] = {
+	PWM1_B_MARK,
+};
+static const unsigned int pwm1_c_pins[] = {
+	RCAR_GP_PIN(1, 18),
+};
+static const unsigned int pwm1_c_mux[] = {
+	PWM1_C_MARK,
+};
+static const unsigned int pwm2_pins[] = {
+	RCAR_GP_PIN(4, 10),
+};
+static const unsigned int pwm2_mux[] = {
+	PWM2_MARK,
+};
+static const unsigned int pwm2_b_pins[] = {
+	RCAR_GP_PIN(5, 17),
+};
+static const unsigned int pwm2_b_mux[] = {
+	PWM2_B_MARK,
+};
+static const unsigned int pwm2_c_pins[] = {
+	RCAR_GP_PIN(0, 13),
+};
+static const unsigned int pwm2_c_mux[] = {
+	PWM2_C_MARK,
+};
+static const unsigned int pwm3_pins[] = {
+	RCAR_GP_PIN(4, 13),
+};
+static const unsigned int pwm3_mux[] = {
+	PWM3_MARK,
+};
+static const unsigned int pwm3_b_pins[] = {
+	RCAR_GP_PIN(0, 16),
+};
+static const unsigned int pwm3_b_mux[] = {
+	PWM3_B_MARK,
+};
+static const unsigned int pwm4_pins[] = {
+	RCAR_GP_PIN(1, 3),
+};
+static const unsigned int pwm4_mux[] = {
+	PWM4_MARK,
+};
+static const unsigned int pwm4_b_pins[] = {
+	RCAR_GP_PIN(0, 21),
+};
+static const unsigned int pwm4_b_mux[] = {
+	PWM4_B_MARK,
+};
+static const unsigned int pwm5_pins[] = {
+	RCAR_GP_PIN(3, 30),
+};
+static const unsigned int pwm5_mux[] = {
+	PWM5_MARK,
+};
+static const unsigned int pwm5_b_pins[] = {
+	RCAR_GP_PIN(4, 0),
+};
+static const unsigned int pwm5_b_mux[] = {
+	PWM5_B_MARK,
+};
+static const unsigned int pwm5_c_pins[] = {
+	RCAR_GP_PIN(0, 10),
+};
+static const unsigned int pwm5_c_mux[] = {
+	PWM5_C_MARK,
+};
+static const unsigned int pwm6_pins[] = {
+	RCAR_GP_PIN(4, 8),
+};
+static const unsigned int pwm6_mux[] = {
+	PWM6_MARK,
+};
+static const unsigned int pwm6_b_pins[] = {
+	RCAR_GP_PIN(0, 7),
+};
+static const unsigned int pwm6_b_mux[] = {
+	PWM6_B_MARK,
+};
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -3706,6 +3809,23 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof2_ss2_b),
 	SH_PFC_PIN_GROUP(msiof2_rx_b),
 	SH_PFC_PIN_GROUP(msiof2_tx_b),
+	SH_PFC_PIN_GROUP(pwm0),
+	SH_PFC_PIN_GROUP(pwm0_b),
+	SH_PFC_PIN_GROUP(pwm1),
+	SH_PFC_PIN_GROUP(pwm1_b),
+	SH_PFC_PIN_GROUP(pwm1_c),
+	SH_PFC_PIN_GROUP(pwm2),
+	SH_PFC_PIN_GROUP(pwm2_b),
+	SH_PFC_PIN_GROUP(pwm2_c),
+	SH_PFC_PIN_GROUP(pwm3),
+	SH_PFC_PIN_GROUP(pwm3_b),
+	SH_PFC_PIN_GROUP(pwm4),
+	SH_PFC_PIN_GROUP(pwm4_b),
+	SH_PFC_PIN_GROUP(pwm5),
+	SH_PFC_PIN_GROUP(pwm5_b),
+	SH_PFC_PIN_GROUP(pwm5_c),
+	SH_PFC_PIN_GROUP(pwm6),
+	SH_PFC_PIN_GROUP(pwm6_b),
 	SH_PFC_PIN_GROUP(qspi_ctrl),
 	SH_PFC_PIN_GROUP(qspi_data2),
 	SH_PFC_PIN_GROUP(qspi_data4),
@@ -4067,6 +4187,44 @@ static const char * const msiof2_groups[] = {
 	"msiof2_tx_b",
 };
 
+static const char * const pwm0_groups[] = {
+	"pwm0",
+	"pwm0_b",
+};
+
+static const char * const pwm1_groups[] = {
+	"pwm1",
+	"pwm1_b",
+	"pwm1_c",
+};
+
+static const char * const pwm2_groups[] = {
+	"pwm2",
+	"pwm2_b",
+	"pwm2_c",
+};
+
+static const char * const pwm3_groups[] = {
+	"pwm3",
+	"pwm3_b",
+};
+
+static const char * const pwm4_groups[] = {
+	"pwm4",
+	"pwm4_b",
+};
+
+static const char * const pwm5_groups[] = {
+	"pwm5",
+	"pwm5_b",
+	"pwm5_c",
+};
+
+static const char * const pwm6_groups[] = {
+	"pwm6",
+	"pwm6_b",
+};
+
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
 	"qspi_data2",
@@ -4301,6 +4459,13 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
+	SH_PFC_FUNCTION(pwm0),
+	SH_PFC_FUNCTION(pwm1),
+	SH_PFC_FUNCTION(pwm2),
+	SH_PFC_FUNCTION(pwm3),
+	SH_PFC_FUNCTION(pwm4),
+	SH_PFC_FUNCTION(pwm5),
+	SH_PFC_FUNCTION(pwm6),
 	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
-- 
2.7.4
