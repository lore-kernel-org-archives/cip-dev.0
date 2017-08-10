From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:58 +0100
Subject: [cip-dev] [PATCH 05/11] pinctrl: sh-pfc: r8a7791: Add ADI pinconf
	support
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo@jmondi.org>

Add pin configuration support for Gyro-ADC, named ADI on r8a7791 SoC.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 07254d835dfc1e06a8cdfb565e7371176a4b93f9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 86 ++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 977707f..9884967 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1695,6 +1695,72 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - ADI -------------------------------------------------------------------- */
+static const unsigned int adi_common_pins[] = {
+	/* ADIDATA, ADICS/SAMP, ADICLK */
+	RCAR_GP_PIN(6, 24), RCAR_GP_PIN(6, 25), RCAR_GP_PIN(6, 26),
+};
+static const unsigned int adi_common_mux[] = {
+	/* ADIDATA, ADICS/SAMP, ADICLK */
+	ADIDATA_MARK, ADICS_SAMP_MARK, ADICLK_MARK,
+};
+static const unsigned int adi_chsel0_pins[] = {
+	/* ADICHS 0 */
+	RCAR_GP_PIN(6, 27),
+};
+static const unsigned int adi_chsel0_mux[] = {
+	/* ADICHS 0 */
+	ADICHS0_MARK,
+};
+static const unsigned int adi_chsel1_pins[] = {
+	/* ADICHS 1 */
+	RCAR_GP_PIN(6, 28),
+};
+static const unsigned int adi_chsel1_mux[] = {
+	/* ADICHS 1 */
+	ADICHS1_MARK,
+};
+static const unsigned int adi_chsel2_pins[] = {
+	/* ADICHS 2 */
+	RCAR_GP_PIN(6, 29),
+};
+static const unsigned int adi_chsel2_mux[] = {
+	/* ADICHS 2 */
+	ADICHS2_MARK,
+};
+static const unsigned int adi_common_b_pins[] = {
+	/* ADIDATA B, ADICS/SAMP B, ADICLK B */
+	RCAR_GP_PIN(5, 25), RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27),
+};
+static const unsigned int adi_common_b_mux[] = {
+	/* ADIDATA B, ADICS/SAMP B, ADICLK B */
+	ADIDATA_B_MARK, ADICS_SAMP_B_MARK, ADICLK_B_MARK,
+};
+static const unsigned int adi_chsel0_b_pins[] = {
+	/* ADICHS B 0 */
+	RCAR_GP_PIN(5, 28),
+};
+static const unsigned int adi_chsel0_b_mux[] = {
+	/* ADICHS B 0 */
+	ADICHS0_B_MARK,
+};
+static const unsigned int adi_chsel1_b_pins[] = {
+	/* ADICHS B 1 */
+	RCAR_GP_PIN(5, 29),
+};
+static const unsigned int adi_chsel1_b_mux[] = {
+	/* ADICHS B 1 */
+	ADICHS1_B_MARK,
+};
+static const unsigned int adi_chsel2_b_pins[] = {
+	/* ADICHS B 2 */
+	RCAR_GP_PIN(5, 30),
+};
+static const unsigned int adi_chsel2_b_mux[] = {
+	/* ADICHS B 2 */
+	ADICHS2_B_MARK,
+};
+
 /* - Audio Clock ------------------------------------------------------------ */
 static const unsigned int audio_clk_a_pins[] = {
 	/* CLK */
@@ -4347,6 +4413,14 @@ static const unsigned int vin2_clk_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(adi_common),
+	SH_PFC_PIN_GROUP(adi_chsel0),
+	SH_PFC_PIN_GROUP(adi_chsel1),
+	SH_PFC_PIN_GROUP(adi_chsel2),
+	SH_PFC_PIN_GROUP(adi_common_b),
+	SH_PFC_PIN_GROUP(adi_chsel0_b),
+	SH_PFC_PIN_GROUP(adi_chsel1_b),
+	SH_PFC_PIN_GROUP(adi_chsel2_b),
 	SH_PFC_PIN_GROUP(audio_clk_a),
 	SH_PFC_PIN_GROUP(audio_clk_b),
 	SH_PFC_PIN_GROUP(audio_clk_b_b),
@@ -4691,6 +4765,17 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin2_clk),
 };
 
+static const char * const adi_groups[] = {
+	"adi_common",
+	"adi_chsel0",
+	"adi_chsel1",
+	"adi_chsel2",
+	"adi_common_b",
+	"adi_chsel0_b",
+	"adi_chsel1_b",
+	"adi_chsel2_b",
+};
+
 static const char * const audio_clk_groups[] = {
 	"audio_clk_a",
 	"audio_clk_b",
@@ -5196,6 +5281,7 @@ static const char * const vin2_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(adi),
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(can0),
-- 
1.9.1
