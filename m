From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:36 +0100
Subject: [cip-dev] [PATCH 35/86] pinctrl: sh-pfc: r8a7745: Add CAN[01]
	support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-36-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds PFC CAN0 and CAN1 pin groups and functions, enabling CAN
bus on the RZ/G1E.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 3f35221842305e82494e10fcfc1f5750c8bc682a)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 146 +++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 2d0dffb..d4cee24 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1625,6 +1625,116 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
 	AVB_COL_MARK,
 };
+
+/* - CAN -------------------------------------------------------------------- */
+static const unsigned int can0_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(6, 15), RCAR_GP_PIN(6, 14),
+};
+
+static const unsigned int can0_data_mux[] = {
+	CAN0_TX_MARK, CAN0_RX_MARK,
+};
+
+static const unsigned int can0_data_b_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(3, 16), RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int can0_data_b_mux[] = {
+	CAN0_TX_B_MARK, CAN0_RX_B_MARK,
+};
+
+static const unsigned int can0_data_c_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 16),
+};
+
+static const unsigned int can0_data_c_mux[] = {
+	CAN0_TX_C_MARK, CAN0_RX_C_MARK,
+};
+
+static const unsigned int can0_data_d_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 11),
+};
+
+static const unsigned int can0_data_d_mux[] = {
+	CAN0_TX_D_MARK, CAN0_RX_D_MARK,
+};
+
+static const unsigned int can1_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(6, 25), RCAR_GP_PIN(6, 24),
+};
+
+static const unsigned int can1_data_mux[] = {
+	CAN1_TX_MARK, CAN1_RX_MARK,
+};
+
+static const unsigned int can1_data_b_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 1),
+};
+
+static const unsigned int can1_data_b_mux[] = {
+	CAN1_TX_B_MARK, CAN1_RX_B_MARK,
+};
+
+static const unsigned int can1_data_c_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(5, 6), RCAR_GP_PIN(5, 5),
+};
+
+static const unsigned int can1_data_c_mux[] = {
+	CAN1_TX_C_MARK, CAN1_RX_C_MARK,
+};
+
+static const unsigned int can1_data_d_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(3, 31), RCAR_GP_PIN(3, 30),
+};
+
+static const unsigned int can1_data_d_mux[] = {
+	CAN1_TX_D_MARK, CAN1_RX_D_MARK,
+};
+
+static const unsigned int can_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(3, 31),
+};
+
+static const unsigned int can_clk_mux[] = {
+	CAN_CLK_MARK,
+};
+
+static const unsigned int can_clk_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(1, 23),
+};
+
+static const unsigned int can_clk_b_mux[] = {
+	CAN_CLK_B_MARK,
+};
+
+static const unsigned int can_clk_c_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(1, 0),
+};
+
+static const unsigned int can_clk_c_mux[] = {
+	CAN_CLK_C_MARK,
+};
+
+static const unsigned int can_clk_d_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(5, 0),
+};
+
+static const unsigned int can_clk_d_mux[] = {
+	CAN_CLK_D_MARK,
+};
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du0_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3476,6 +3586,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_mdio),
 	SH_PFC_PIN_GROUP(avb_mii),
 	SH_PFC_PIN_GROUP(avb_gmii),
+	SH_PFC_PIN_GROUP(can0_data),
+	SH_PFC_PIN_GROUP(can0_data_b),
+	SH_PFC_PIN_GROUP(can0_data_c),
+	SH_PFC_PIN_GROUP(can0_data_d),
+	SH_PFC_PIN_GROUP(can1_data),
+	SH_PFC_PIN_GROUP(can1_data_b),
+	SH_PFC_PIN_GROUP(can1_data_c),
+	SH_PFC_PIN_GROUP(can1_data_d),
+	SH_PFC_PIN_GROUP(can_clk),
+	SH_PFC_PIN_GROUP(can_clk_b),
+	SH_PFC_PIN_GROUP(can_clk_c),
+	SH_PFC_PIN_GROUP(can_clk_d),
 	SH_PFC_PIN_GROUP(du0_rgb666),
 	SH_PFC_PIN_GROUP(du0_rgb888),
 	SH_PFC_PIN_GROUP(du0_clk0_out),
@@ -3748,6 +3870,28 @@ static const char * const avb_groups[] = {
 	"avb_gmii",
 };
 
+static const char * const can0_groups[] = {
+	"can0_data",
+	"can0_data_b",
+	"can0_data_c",
+	"can0_data_d",
+	"can_clk",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
+static const char * const can1_groups[] = {
+	"can1_data",
+	"can1_data_b",
+	"can1_data_c",
+	"can1_data_d",
+	"can_clk",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
 static const char * const du0_groups[] = {
 	"du0_rgb666",
 	"du0_rgb888",
@@ -4119,6 +4263,8 @@ static const char * const vin1_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
+	SH_PFC_FUNCTION(can0),
+	SH_PFC_FUNCTION(can1),
 	SH_PFC_FUNCTION(du0),
 	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(eth),
-- 
2.7.4
