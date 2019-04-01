From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:46 +0100
Subject: [cip-dev] [PATCH 4.19y 09/10] pinctrl: sh-pfc: r8a77990: Add TMU
	pins, groups and functions
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-10-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 16978e7d40f73bed462ca991ce3565d133b0c6cd upstream.

This patch adds TMU TCLK{1,2} pins, groups and functions to
the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 3ce1b24..0a9aa62 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -3256,6 +3256,43 @@ static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
 
+/* - TMU -------------------------------------------------------------------- */
+static const unsigned int tmu_tclk1_a_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(3, 12),
+};
+
+static const unsigned int tmu_tclk1_a_mux[] = {
+	TCLK1_A_MARK,
+};
+
+static const unsigned int tmu_tclk1_b_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(5, 17),
+};
+
+static const unsigned int tmu_tclk1_b_mux[] = {
+	TCLK1_B_MARK,
+};
+
+static const unsigned int tmu_tclk2_a_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(3, 13),
+};
+
+static const unsigned int tmu_tclk2_a_mux[] = {
+	TCLK2_A_MARK,
+};
+
+static const unsigned int tmu_tclk2_b_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(5, 18),
+};
+
+static const unsigned int tmu_tclk2_b_mux[] = {
+	TCLK2_B_MARK,
+};
+
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_a_pins[] = {
 	/* PWEN, OVC */
@@ -3536,7 +3573,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[241];
+	struct sh_pfc_pin_group common[245];
 	struct sh_pfc_pin_group automotive[2];
 } pinmux_groups = {
 	.common = {
@@ -3748,6 +3785,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+		SH_PFC_PIN_GROUP(tmu_tclk1_a),
+		SH_PFC_PIN_GROUP(tmu_tclk1_b),
+		SH_PFC_PIN_GROUP(tmu_tclk2_a),
+		SH_PFC_PIN_GROUP(tmu_tclk2_b),
 		SH_PFC_PIN_GROUP(usb0_a),
 		SH_PFC_PIN_GROUP(usb0_b),
 		SH_PFC_PIN_GROUP(usb0_id),
@@ -4124,6 +4165,13 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_b",
 };
 
+static const char * const tmu_groups[] = {
+	"tmu_tclk1_a",
+	"tmu_tclk1_b",
+	"tmu_tclk2_a",
+	"tmu_tclk2_b",
+};
+
 static const char * const usb0_groups[] = {
 	"usb0_a",
 	"usb0_b",
@@ -4170,7 +4218,7 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[44];
+	struct sh_pfc_function common[45];
 	struct sh_pfc_function automotive[2];
 } pinmux_functions = {
 	.common = {
@@ -4214,6 +4262,7 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi3),
 		SH_PFC_FUNCTION(ssi),
+		SH_PFC_FUNCTION(tmu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb30),
 		SH_PFC_FUNCTION(vin4),
-- 
2.7.4
