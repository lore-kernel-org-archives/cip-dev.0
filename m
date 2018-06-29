From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:39 +0100
Subject: [cip-dev] [PATCH 38/86] pinctrl: sh-pfc: r8a7794: Add tpu groups
	and function
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-39-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds tpu groups and function to r8a7745/r8a7794.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 64dbebc87d5f91435bf4fb8b04a688f570121b7f)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 738f8bf..fb4ae85 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -3510,6 +3510,79 @@ static const unsigned int ssi9_ctrl_b_pins[] = {
 static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
+/* - TPU -------------------------------------------------------------------- */
+static const unsigned int tpu_to0_pins[] = {
+	RCAR_GP_PIN(3, 31),
+};
+static const unsigned int tpu_to0_mux[] = {
+	TPUTO0_MARK,
+};
+static const unsigned int tpu_to0_b_pins[] = {
+	RCAR_GP_PIN(3, 30),
+};
+static const unsigned int tpu_to0_b_mux[] = {
+	TPUTO0_B_MARK,
+};
+static const unsigned int tpu_to0_c_pins[] = {
+	RCAR_GP_PIN(1, 18),
+};
+static const unsigned int tpu_to0_c_mux[] = {
+	TPUTO0_C_MARK,
+};
+static const unsigned int tpu_to1_pins[] = {
+	RCAR_GP_PIN(4, 9),
+};
+static const unsigned int tpu_to1_mux[] = {
+	TPUTO1_MARK,
+};
+static const unsigned int tpu_to1_b_pins[] = {
+	RCAR_GP_PIN(4, 0),
+};
+static const unsigned int tpu_to1_b_mux[] = {
+	TPUTO1_B_MARK,
+};
+static const unsigned int tpu_to1_c_pins[] = {
+	RCAR_GP_PIN(4, 4),
+};
+static const unsigned int tpu_to1_c_mux[] = {
+	TPUTO1_C_MARK,
+};
+static const unsigned int tpu_to2_pins[] = {
+	RCAR_GP_PIN(1, 3),
+};
+static const unsigned int tpu_to2_mux[] = {
+	TPUTO2_MARK,
+};
+static const unsigned int tpu_to2_b_pins[] = {
+	RCAR_GP_PIN(1, 0),
+};
+static const unsigned int tpu_to2_b_mux[] = {
+	TPUTO2_B_MARK,
+};
+static const unsigned int tpu_to2_c_pins[] = {
+	RCAR_GP_PIN(0, 22),
+};
+static const unsigned int tpu_to2_c_mux[] = {
+	TPUTO2_C_MARK,
+};
+static const unsigned int tpu_to3_pins[] = {
+	RCAR_GP_PIN(1, 14),
+};
+static const unsigned int tpu_to3_mux[] = {
+	TPUTO3_MARK,
+};
+static const unsigned int tpu_to3_b_pins[] = {
+	RCAR_GP_PIN(1, 13),
+};
+static const unsigned int tpu_to3_b_mux[] = {
+	TPUTO3_B_MARK,
+};
+static const unsigned int tpu_to3_c_pins[] = {
+	RCAR_GP_PIN(0, 21),
+};
+static const unsigned int tpu_to3_c_mux[] = {
+	TPUTO3_C_MARK,
+};
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
 	RCAR_GP_PIN(5, 24), /* PWEN */
@@ -3943,6 +4016,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi9_ctrl),
 	SH_PFC_PIN_GROUP(ssi9_data_b),
 	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+	SH_PFC_PIN_GROUP(tpu_to0),
+	SH_PFC_PIN_GROUP(tpu_to0_b),
+	SH_PFC_PIN_GROUP(tpu_to0_c),
+	SH_PFC_PIN_GROUP(tpu_to1),
+	SH_PFC_PIN_GROUP(tpu_to1_b),
+	SH_PFC_PIN_GROUP(tpu_to1_c),
+	SH_PFC_PIN_GROUP(tpu_to2),
+	SH_PFC_PIN_GROUP(tpu_to2_b),
+	SH_PFC_PIN_GROUP(tpu_to2_c),
+	SH_PFC_PIN_GROUP(tpu_to3),
+	SH_PFC_PIN_GROUP(tpu_to3_b),
+	SH_PFC_PIN_GROUP(tpu_to3_c),
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	VIN_DATA_PIN_GROUP(vin0_data, 24),
@@ -4405,6 +4490,21 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_b",
 };
 
+static const char * const tpu_groups[] = {
+	"tpu_to0",
+	"tpu_to0_b",
+	"tpu_to0_c",
+	"tpu_to1",
+	"tpu_to1_b",
+	"tpu_to1_c",
+	"tpu_to2",
+	"tpu_to2_b",
+	"tpu_to2_c",
+	"tpu_to3",
+	"tpu_to3_b",
+	"tpu_to3_c",
+};
+
 static const char * const usb0_groups[] = {
 	"usb0",
 };
@@ -4487,6 +4587,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
 	SH_PFC_FUNCTION(ssi),
+	SH_PFC_FUNCTION(tpu),
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
 	SH_PFC_FUNCTION(vin0),
-- 
2.7.4
