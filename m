From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:38 +0100
Subject: [cip-dev] [PATCH 4.19y 01/10] pinctrl: sh-pfc: r8a77990: Add CAN
	pins, groups and functions
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit c1e5bd286fe501992165608551f889ec69f5901a upstream.

This patch adds CAN{0,1} pins, groups and functions to the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 51 +++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 6868753..2869a02 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1538,6 +1538,35 @@ static const unsigned int avb_avtp_capture_a_mux[] = {
 	AVB_AVTP_CAPTURE_A_MARK,
 };
 
+/* - CAN ------------------------------------------------------------------ */
+static const unsigned int can0_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+};
+
+static const unsigned int can0_data_mux[] = {
+	CAN0_TX_MARK, CAN0_RX_MARK,
+};
+
+static const unsigned int can1_data_pins[] = {
+	/* TX, RX */
+	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 7),
+};
+
+static const unsigned int can1_data_mux[] = {
+	CAN1_TX_MARK, CAN1_RX_MARK,
+};
+
+/* - CAN Clock -------------------------------------------------------------- */
+static const unsigned int can_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(0, 14),
+};
+
+static const unsigned int can_clk_mux[] = {
+	CAN_CLK_MARK,
+};
+
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3475,7 +3504,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[238];
+	struct sh_pfc_pin_group common[241];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -3504,6 +3533,9 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_avtp_pps),
 		SH_PFC_PIN_GROUP(avb_avtp_match_a),
 		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+		SH_PFC_PIN_GROUP(can0_data),
+		SH_PFC_PIN_GROUP(can1_data),
+		SH_PFC_PIN_GROUP(can_clk),
 		SH_PFC_PIN_GROUP(du_rgb666),
 		SH_PFC_PIN_GROUP(du_rgb888),
 		SH_PFC_PIN_GROUP(du_clk_in_0),
@@ -3751,6 +3783,18 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_a",
 };
 
+static const char * const can0_groups[] = {
+	"can0_data",
+};
+
+static const char * const can1_groups[] = {
+	"can1_data",
+};
+
+static const char * const can_clk_groups[] = {
+	"can_clk",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4082,12 +4126,15 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[41];
+	struct sh_pfc_function common[44];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
 		SH_PFC_FUNCTION(avb),
+		SH_PFC_FUNCTION(can0),
+		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
-- 
2.7.4
