From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:39 +0100
Subject: [cip-dev] [PATCH 4.19y 02/10] pinctrl: sh-pfc: r8a77990: Add CAN FD
	pins, groups and functions
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit b5ff38f15c3e3f5533c530a725140e9994c6011d upstream.

This patch adds CAN FD{0,1} pins, groups and functions to the R8A77990
SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
[geert: Move canfd from common to automotive]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 39 +++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 2869a02..8c06d72 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1567,6 +1567,25 @@ static const unsigned int can_clk_mux[] = {
 	CAN_CLK_MARK,
 };
 
+/* - CAN FD --------------------------------------------------------------- */
+static const unsigned int canfd0_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+};
+
+static const unsigned int canfd0_data_mux[] = {
+	CANFD0_TX_MARK, CANFD0_RX_MARK,
+};
+
+static const unsigned int canfd1_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 7),
+};
+
+static const unsigned int canfd1_data_mux[] = {
+	CANFD1_TX_MARK, CANFD1_RX_MARK,
+};
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3505,7 +3524,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[241];
-	struct sh_pfc_pin_group automotive[0];
+	struct sh_pfc_pin_group automotive[2];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a),
@@ -3749,6 +3768,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clkenb_a),
 		SH_PFC_PIN_GROUP(vin5_clk_a),
 		SH_PFC_PIN_GROUP(vin5_clk_b),
+	},
+	.automotive = {
+		SH_PFC_PIN_GROUP(canfd0_data),
+		SH_PFC_PIN_GROUP(canfd1_data),
 	}
 };
 
@@ -3795,6 +3818,14 @@ static const char * const can_clk_groups[] = {
 	"can_clk",
 };
 
+static const char * const canfd0_groups[] = {
+	"canfd0_data",
+};
+
+static const char * const canfd1_groups[] = {
+	"canfd1_data",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4127,7 +4158,7 @@ static const char * const vin5_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[44];
-	struct sh_pfc_function automotive[0];
+	struct sh_pfc_function automotive[2];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -4174,6 +4205,10 @@ static const struct {
 		SH_PFC_FUNCTION(usb30),
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
+	},
+	.automotive = {
+		SH_PFC_FUNCTION(canfd0),
+		SH_PFC_FUNCTION(canfd1),
 	}
 };
 
-- 
2.7.4
