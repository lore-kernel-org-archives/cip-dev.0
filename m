From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:28 +0100
Subject: [cip-dev] [PATCH 27/86] pinctrl: sh-pfc: r8a7794: Add EtherAVB pin
	groups
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the EtherAVB pin groups to the R8A7794 PFC driver.

Based on the patches by Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 4c96cb027be5ceb2c7c0d4dc086d35fd0cfaf14b)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
(cherry picked from commit 47efdba5446b69a330d27422f67f742202d50986)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 123 +++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 4a3c7ab..abcf735 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1602,6 +1602,105 @@ static const unsigned int audio_clkout_c_pins[] = {
 static const unsigned int audio_clkout_c_mux[] = {
 	AUDIO_CLKOUT_C_MARK,
 };
+/* - AVB -------------------------------------------------------------------- */
+static const unsigned int avb_link_pins[] = {
+	RCAR_GP_PIN(3, 26),
+};
+static const unsigned int avb_link_mux[] = {
+	AVB_LINK_MARK,
+};
+static const unsigned int avb_magic_pins[] = {
+	RCAR_GP_PIN(3, 27),
+};
+static const unsigned int avb_magic_mux[] = {
+	AVB_MAGIC_MARK,
+};
+static const unsigned int avb_phy_int_pins[] = {
+	RCAR_GP_PIN(3, 28),
+};
+static const unsigned int avb_phy_int_mux[] = {
+	AVB_PHY_INT_MARK,
+};
+static const unsigned int avb_mdio_pins[] = {
+	RCAR_GP_PIN(3, 24), RCAR_GP_PIN(3, 25),
+};
+static const unsigned int avb_mdio_mux[] = {
+	AVB_MDC_MARK, AVB_MDIO_MARK,
+};
+static const unsigned int avb_mii_pins[] = {
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+	RCAR_GP_PIN(3, 17),
+
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3), RCAR_GP_PIN(3, 4),
+	RCAR_GP_PIN(3, 5),
+
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 22),
+	RCAR_GP_PIN(3, 13), RCAR_GP_PIN(3, 11),
+};
+static const unsigned int avb_mii_mux[] = {
+	AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
+	AVB_TXD3_MARK,
+
+	AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK,
+
+	AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
+	AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_ER_MARK,
+	AVB_TX_CLK_MARK, AVB_COL_MARK,
+};
+static const unsigned int avb_gmii_pins[] = {
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 16),
+	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 18), RCAR_GP_PIN(3, 19),
+	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 21),
+
+	RCAR_GP_PIN(3, 2), RCAR_GP_PIN(3, 3), RCAR_GP_PIN(3, 4),
+	RCAR_GP_PIN(3, 5), RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
+	RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
+	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 30),
+	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 13),
+	RCAR_GP_PIN(3, 11),
+};
+static const unsigned int avb_gmii_mux[] = {
+	AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
+	AVB_TXD3_MARK, AVB_TXD4_MARK, AVB_TXD5_MARK,
+	AVB_TXD6_MARK, AVB_TXD7_MARK,
+
+	AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
+	AVB_RXD3_MARK, AVB_RXD4_MARK, AVB_RXD5_MARK,
+	AVB_RXD6_MARK, AVB_RXD7_MARK,
+
+	AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
+	AVB_CRS_MARK, AVB_GTX_CLK_MARK, AVB_GTXREFCLK_MARK,
+	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
+	AVB_COL_MARK,
+};
+static const unsigned int avb_avtp_capture_pins[] = {
+	RCAR_GP_PIN(5, 11),
+};
+static const unsigned int avb_avtp_capture_mux[] = {
+	AVB_AVTP_CAPTURE_MARK,
+};
+static const unsigned int avb_avtp_match_pins[] = {
+	RCAR_GP_PIN(5, 12),
+};
+static const unsigned int avb_avtp_match_mux[] = {
+	AVB_AVTP_MATCH_MARK,
+};
+static const unsigned int avb_avtp_capture_b_pins[] = {
+	RCAR_GP_PIN(1, 1),
+};
+static const unsigned int avb_avtp_capture_b_mux[] = {
+	AVB_AVTP_CAPTURE_B_MARK,
+};
+static const unsigned int avb_avtp_match_b_pins[] = {
+	RCAR_GP_PIN(1, 2),
+};
+static const unsigned int avb_avtp_match_b_mux[] = {
+	AVB_AVTP_MATCH_B_MARK,
+};
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -3274,6 +3373,16 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(audio_clkout),
 	SH_PFC_PIN_GROUP(audio_clkout_b),
 	SH_PFC_PIN_GROUP(audio_clkout_c),
+	SH_PFC_PIN_GROUP(avb_link),
+	SH_PFC_PIN_GROUP(avb_magic),
+	SH_PFC_PIN_GROUP(avb_phy_int),
+	SH_PFC_PIN_GROUP(avb_mdio),
+	SH_PFC_PIN_GROUP(avb_mii),
+	SH_PFC_PIN_GROUP(avb_gmii),
+	SH_PFC_PIN_GROUP(avb_avtp_capture),
+	SH_PFC_PIN_GROUP(avb_avtp_match),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+	SH_PFC_PIN_GROUP(avb_avtp_match_b),
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
@@ -3519,6 +3628,19 @@ static const char * const audio_clk_groups[] = {
 	"audio_clkout_c",
 };
 
+static const char * const avb_groups[] = {
+	"avb_link",
+	"avb_magic",
+	"avb_phy_int",
+	"avb_mdio",
+	"avb_mii",
+	"avb_gmii",
+	"avb_avtp_capture",
+	"avb_avtp_match",
+	"avb_avtp_capture_b",
+	"avb_avtp_match_b",
+};
+
 static const char * const eth_groups[] = {
 	"eth_link",
 	"eth_magic",
@@ -3865,6 +3987,7 @@ static const char * const vin1_groups[] = {
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
+	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
-- 
2.7.4
