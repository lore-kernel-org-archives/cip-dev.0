From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:38 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 28/39] pinctrl: sh-pfc: r8a77965: Add
	TMU pins, groups and functions
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-29-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 729257d674bc2e68bf051af5c7202d882bccafe0 upstream.

This patch adds TMU TCLK{1,2} pins, groups and functions to
the R8A77965 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 61b33f7..1908350 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -3757,6 +3757,42 @@ static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
 
+/* - TMU -------------------------------------------------------------------- */
+static const unsigned int tmu_tclk1_a_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(6, 23),
+};
+
+static const unsigned int tmu_tclk1_a_mux[] = {
+	TCLK1_A_MARK,
+};
+
+static const unsigned int tmu_tclk1_b_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(5, 19),
+};
+
+static const unsigned int tmu_tclk1_b_mux[] = {
+	TCLK1_B_MARK,
+};
+
+static const unsigned int tmu_tclk2_a_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(6, 19),
+};
+
+static const unsigned int tmu_tclk2_a_mux[] = {
+	TCLK2_A_MARK,
+};
+
+static const unsigned int tmu_tclk2_b_pins[] = {
+	/* TCLK */
+	RCAR_GP_PIN(6, 28),
+};
+
+static const unsigned int tmu_tclk2_b_mux[] = {
+	TCLK2_B_MARK,
+};
 
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
@@ -4277,6 +4313,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi9_data_b),
 	SH_PFC_PIN_GROUP(ssi9_ctrl_a),
 	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+	SH_PFC_PIN_GROUP(tmu_tclk1_a),
+	SH_PFC_PIN_GROUP(tmu_tclk1_b),
+	SH_PFC_PIN_GROUP(tmu_tclk2_a),
+	SH_PFC_PIN_GROUP(tmu_tclk2_b),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb30),
@@ -4708,6 +4748,13 @@ static const char * const ssi_groups[] = {
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
 	"usb0",
 };
@@ -4794,6 +4841,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(sdhi3),
 	SH_PFC_FUNCTION(ssi),
+	SH_PFC_FUNCTION(tmu),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
 	SH_PFC_FUNCTION(usb30),
-- 
2.7.4
