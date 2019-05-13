From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:31 +0100
Subject: [cip-dev] [PATCH 4.4.y 06/52] pinctrl: sh-pfc: r8a77470: Add
	EtherAVB pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 491e9f585c97c857c52669244c2263cdc5e3e645 upstream.

Add EtherAVB groups and functions definitions for R8A77470 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 133 ++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 8973f61..4526b0f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1118,6 +1118,110 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
+/* - AVB -------------------------------------------------------------------- */
+static const unsigned int avb_col_pins[] = {
+	RCAR_GP_PIN(5, 18),
+};
+static const unsigned int avb_col_mux[] = {
+	AVB_COL_MARK,
+};
+static const unsigned int avb_crs_pins[] = {
+	RCAR_GP_PIN(5, 17),
+};
+static const unsigned int avb_crs_mux[] = {
+	AVB_CRS_MARK,
+};
+static const unsigned int avb_link_pins[] = {
+	RCAR_GP_PIN(5, 14),
+};
+static const unsigned int avb_link_mux[] = {
+	AVB_LINK_MARK,
+};
+static const unsigned int avb_magic_pins[] = {
+	RCAR_GP_PIN(5, 15),
+};
+static const unsigned int avb_magic_mux[] = {
+	AVB_MAGIC_MARK,
+};
+static const unsigned int avb_phy_int_pins[] = {
+	RCAR_GP_PIN(5, 16),
+};
+static const unsigned int avb_phy_int_mux[] = {
+	AVB_PHY_INT_MARK,
+};
+static const unsigned int avb_mdio_pins[] = {
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
+};
+static const unsigned int avb_mdio_mux[] = {
+	AVB_MDC_MARK, AVB_MDIO_MARK,
+};
+static const unsigned int avb_mii_tx_rx_pins[] = {
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
+	RCAR_GP_PIN(3, 16), RCAR_GP_PIN(3, 27), RCAR_GP_PIN(3, 13),
+
+	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 1),
+	RCAR_GP_PIN(3, 10),
+};
+static const unsigned int avb_mii_tx_rx_mux[] = {
+	AVB_TX_CLK_MARK, AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
+	AVB_TXD3_MARK, AVB_TX_EN_MARK,
+
+	AVB_RX_CLK_MARK, AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK, AVB_RX_DV_MARK, AVB_RX_ER_MARK,
+};
+static const unsigned int avb_mii_tx_er_pins[] = {
+	RCAR_GP_PIN(5, 23),
+};
+static const unsigned int avb_mii_tx_er_mux[] = {
+	AVB_TX_ER_MARK,
+};
+static const unsigned int avb_gmii_tx_rx_pins[] = {
+	RCAR_GP_PIN(4, 1), RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 12),
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+	RCAR_GP_PIN(3, 27), RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 29),
+	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(5, 22), RCAR_GP_PIN(3, 13),
+	RCAR_GP_PIN(5, 23),
+
+	RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3),
+	RCAR_GP_PIN(3, 4), RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 6),
+	RCAR_GP_PIN(3, 7), RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 1), RCAR_GP_PIN(3, 10),
+};
+static const unsigned int avb_gmii_tx_rx_mux[] = {
+	AVB_GTX_CLK_MARK, AVB_GTXREFCLK_MARK, AVB_TX_CLK_MARK, AVB_TXD0_MARK,
+	AVB_TXD1_MARK, AVB_TXD2_MARK, AVB_TXD3_MARK, AVB_TXD4_MARK,
+	AVB_TXD5_MARK, AVB_TXD6_MARK, AVB_TXD7_MARK, AVB_TX_EN_MARK,
+	AVB_TX_ER_MARK,
+
+	AVB_RX_CLK_MARK, AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK, AVB_RXD4_MARK, AVB_RXD5_MARK, AVB_RXD6_MARK,
+	AVB_RXD7_MARK, AVB_RX_DV_MARK, AVB_RX_ER_MARK,
+};
+static const unsigned int avb_avtp_match_a_pins[] = {
+	RCAR_GP_PIN(1, 15),
+};
+static const unsigned int avb_avtp_match_a_mux[] = {
+	AVB_AVTP_MATCH_A_MARK,
+};
+static const unsigned int avb_avtp_capture_a_pins[] = {
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int avb_avtp_capture_a_mux[] = {
+	AVB_AVTP_CAPTURE_A_MARK,
+};
+static const unsigned int avb_avtp_match_b_pins[] = {
+	RCAR_GP_PIN(5, 20),
+};
+static const unsigned int avb_avtp_match_b_mux[] = {
+	AVB_AVTP_MATCH_B_MARK,
+};
+static const unsigned int avb_avtp_capture_b_pins[] = {
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int avb_avtp_capture_b_mux[] = {
+	AVB_AVTP_CAPTURE_B_MARK,
+};
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data1_pins[] = {
 	/* D0 */
@@ -1395,6 +1499,19 @@ static const unsigned int scif_clk_b_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(avb_col),
+	SH_PFC_PIN_GROUP(avb_crs),
+	SH_PFC_PIN_GROUP(avb_link),
+	SH_PFC_PIN_GROUP(avb_magic),
+	SH_PFC_PIN_GROUP(avb_phy_int),
+	SH_PFC_PIN_GROUP(avb_mdio),
+	SH_PFC_PIN_GROUP(avb_mii_tx_rx),
+	SH_PFC_PIN_GROUP(avb_mii_tx_er),
+	SH_PFC_PIN_GROUP(avb_gmii_tx_rx),
+	SH_PFC_PIN_GROUP(avb_avtp_match_a),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+	SH_PFC_PIN_GROUP(avb_avtp_match_b),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
 	SH_PFC_PIN_GROUP(mmc_data1),
 	SH_PFC_PIN_GROUP(mmc_data4),
 	SH_PFC_PIN_GROUP(mmc_data8),
@@ -1434,6 +1551,21 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif_clk_b),
 };
 
+static const char * const avb_groups[] = {
+	"avb_col",
+	"avb_crs",
+	"avb_link",
+	"avb_magic",
+	"avb_phy_int",
+	"avb_mdio",
+	"avb_mii_tx_rx",
+	"avb_mii_tx_er",
+	"avb_gmii_tx_rx",
+	"avb_avtp_match_a",
+	"avb_avtp_capture_a",
+	"avb_avtp_match_b",
+	"avb_avtp_capture_b",
+};
 static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
@@ -1496,6 +1628,7 @@ static const char * const scif_clk_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
-- 
2.7.4
