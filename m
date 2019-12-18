From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:31 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 21/39] pinctrl: sh-pfc: r8a77965: Add
	SATA pins, groups and functions
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit d06e3be6e86a5456a2b760952b7697e4a0d1fc02 upstream.

This patch adds SATA0 pin, group and function to the R8A77965 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[wsa: rebased to upstream base]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 96d45cb..eac6888 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -2904,6 +2904,25 @@ static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
 
+/* - SATA --------------------------------------------------------------------*/
+static const unsigned int sata0_devslp_a_pins[] = {
+	/* DEVSLP */
+	RCAR_GP_PIN(6, 16),
+};
+
+static const unsigned int sata0_devslp_a_mux[] = {
+	SATA_DEVSLP_A_MARK,
+};
+
+static const unsigned int sata0_devslp_b_pins[] = {
+	/* DEVSLP */
+	RCAR_GP_PIN(4, 6),
+};
+
+static const unsigned int sata0_devslp_b_mux[] = {
+	SATA_DEVSLP_B_MARK,
+};
+
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -3576,6 +3595,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pwm5_b),
 	SH_PFC_PIN_GROUP(pwm6_a),
 	SH_PFC_PIN_GROUP(pwm6_b),
+	SH_PFC_PIN_GROUP(sata0_devslp_a),
+	SH_PFC_PIN_GROUP(sata0_devslp_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -3874,6 +3895,11 @@ static const char * const pwm6_groups[] = {
 	"pwm6_b",
 };
 
+static const char * const sata0_groups[] = {
+	"sata0_devslp_a",
+	"sata0_devslp_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_clk",
@@ -3996,6 +4022,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(pwm4),
 	SH_PFC_FUNCTION(pwm5),
 	SH_PFC_FUNCTION(pwm6),
+	SH_PFC_FUNCTION(sata0),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.7.4
