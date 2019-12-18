From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:32 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 22/39] pinctrl: sh-pfc: r8a77965: Add
	Audio clock pin support
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-23-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

commit ada9a3d98facdc0489de52aa24fd8630ba2ec847 upstream.

Add Audio clock pin support for r8a77965.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 160 ++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index eac6888..498e222 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1572,6 +1572,128 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
 
+/* - AUDIO CLOCK ------------------------------------------------------------ */
+static const unsigned int audio_clk_a_a_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(6, 22),
+};
+static const unsigned int audio_clk_a_a_mux[] = {
+	AUDIO_CLKA_A_MARK,
+};
+static const unsigned int audio_clk_a_b_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int audio_clk_a_b_mux[] = {
+	AUDIO_CLKA_B_MARK,
+};
+static const unsigned int audio_clk_a_c_pins[] = {
+	/* CLK A */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int audio_clk_a_c_mux[] = {
+	AUDIO_CLKA_C_MARK,
+};
+static const unsigned int audio_clk_b_a_pins[] = {
+	/* CLK B */
+	RCAR_GP_PIN(5, 12),
+};
+static const unsigned int audio_clk_b_a_mux[] = {
+	AUDIO_CLKB_A_MARK,
+};
+static const unsigned int audio_clk_b_b_pins[] = {
+	/* CLK B */
+	RCAR_GP_PIN(6, 23),
+};
+static const unsigned int audio_clk_b_b_mux[] = {
+	AUDIO_CLKB_B_MARK,
+};
+static const unsigned int audio_clk_c_a_pins[] = {
+	/* CLK C */
+	RCAR_GP_PIN(5, 21),
+};
+static const unsigned int audio_clk_c_a_mux[] = {
+	AUDIO_CLKC_A_MARK,
+};
+static const unsigned int audio_clk_c_b_pins[] = {
+	/* CLK C */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int audio_clk_c_b_mux[] = {
+	AUDIO_CLKC_B_MARK,
+};
+static const unsigned int audio_clkout_a_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int audio_clkout_a_mux[] = {
+	AUDIO_CLKOUT_A_MARK,
+};
+static const unsigned int audio_clkout_b_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(6, 28),
+};
+static const unsigned int audio_clkout_b_mux[] = {
+	AUDIO_CLKOUT_B_MARK,
+};
+static const unsigned int audio_clkout_c_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(5, 3),
+};
+static const unsigned int audio_clkout_c_mux[] = {
+	AUDIO_CLKOUT_C_MARK,
+};
+static const unsigned int audio_clkout_d_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(5, 21),
+};
+static const unsigned int audio_clkout_d_mux[] = {
+	AUDIO_CLKOUT_D_MARK,
+};
+static const unsigned int audio_clkout1_a_pins[] = {
+	/* CLKOUT1 */
+	RCAR_GP_PIN(5, 15),
+};
+static const unsigned int audio_clkout1_a_mux[] = {
+	AUDIO_CLKOUT1_A_MARK,
+};
+static const unsigned int audio_clkout1_b_pins[] = {
+	/* CLKOUT1 */
+	RCAR_GP_PIN(6, 29),
+};
+static const unsigned int audio_clkout1_b_mux[] = {
+	AUDIO_CLKOUT1_B_MARK,
+};
+static const unsigned int audio_clkout2_a_pins[] = {
+	/* CLKOUT2 */
+	RCAR_GP_PIN(5, 16),
+};
+static const unsigned int audio_clkout2_a_mux[] = {
+	AUDIO_CLKOUT2_A_MARK,
+};
+static const unsigned int audio_clkout2_b_pins[] = {
+	/* CLKOUT2 */
+	RCAR_GP_PIN(6, 30),
+};
+static const unsigned int audio_clkout2_b_mux[] = {
+	AUDIO_CLKOUT2_B_MARK,
+};
+
+static const unsigned int audio_clkout3_a_pins[] = {
+	/* CLKOUT3 */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int audio_clkout3_a_mux[] = {
+	AUDIO_CLKOUT3_A_MARK,
+};
+static const unsigned int audio_clkout3_b_pins[] = {
+	/* CLKOUT3 */
+	RCAR_GP_PIN(6, 31),
+};
+static const unsigned int audio_clkout3_b_mux[] = {
+	AUDIO_CLKOUT3_B_MARK,
+};
+
 /* - EtherAVB --------------------------------------------------------------- */
 static const unsigned int avb_link_pins[] = {
 	/* AVB_LINK */
@@ -3423,6 +3545,23 @@ static const unsigned int usb30_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(audio_clk_a_a),
+	SH_PFC_PIN_GROUP(audio_clk_a_b),
+	SH_PFC_PIN_GROUP(audio_clk_a_c),
+	SH_PFC_PIN_GROUP(audio_clk_b_a),
+	SH_PFC_PIN_GROUP(audio_clk_b_b),
+	SH_PFC_PIN_GROUP(audio_clk_c_a),
+	SH_PFC_PIN_GROUP(audio_clk_c_b),
+	SH_PFC_PIN_GROUP(audio_clkout_a),
+	SH_PFC_PIN_GROUP(audio_clkout_b),
+	SH_PFC_PIN_GROUP(audio_clkout_c),
+	SH_PFC_PIN_GROUP(audio_clkout_d),
+	SH_PFC_PIN_GROUP(audio_clkout1_a),
+	SH_PFC_PIN_GROUP(audio_clkout1_b),
+	SH_PFC_PIN_GROUP(audio_clkout2_a),
+	SH_PFC_PIN_GROUP(audio_clkout2_b),
+	SH_PFC_PIN_GROUP(audio_clkout3_a),
+	SH_PFC_PIN_GROUP(audio_clkout3_b),
 	SH_PFC_PIN_GROUP(avb_link),
 	SH_PFC_PIN_GROUP(avb_magic),
 	SH_PFC_PIN_GROUP(avb_phy_int),
@@ -3657,6 +3796,26 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb30),
 };
 
+static const char * const audio_clk_groups[] = {
+	"audio_clk_a_a",
+	"audio_clk_a_b",
+	"audio_clk_a_c",
+	"audio_clk_b_a",
+	"audio_clk_b_b",
+	"audio_clk_c_a",
+	"audio_clk_c_b",
+	"audio_clkout_a",
+	"audio_clkout_b",
+	"audio_clkout_c",
+	"audio_clkout_d",
+	"audio_clkout1_a",
+	"audio_clkout1_b",
+	"audio_clkout2_a",
+	"audio_clkout2_b",
+	"audio_clkout3_a",
+	"audio_clkout3_b",
+};
+
 static const char * const avb_groups[] = {
 	"avb_link",
 	"avb_magic",
@@ -4000,6 +4159,7 @@ static const char * const usb30_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(hscif0),
-- 
2.7.4
