From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:32 +0100
Subject: [cip-dev] [PATCH 43/62] pinctrl: sh-pfc: r8a7791: Add tpu groups
	and function
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-44-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds tpu groups and function to r8a7743/r8a7791/r8a7793.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 21047d5736918b19a3efe11e8ace856cb1b4b403)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 39fc9ad..4f971a9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4149,6 +4149,32 @@ static const unsigned int ssi9_ctrl_b_mux[] = {
 	SSI_SCK9_B_MARK, SSI_WS9_B_MARK,
 };
 
+/* - TPU -------------------------------------------------------------------- */
+static const unsigned int tpu_to0_pins[] = {
+	RCAR_GP_PIN(6, 14),
+};
+static const unsigned int tpu_to0_mux[] = {
+	TPU_TO0_MARK,
+};
+static const unsigned int tpu_to1_pins[] = {
+	RCAR_GP_PIN(1, 17),
+};
+static const unsigned int tpu_to1_mux[] = {
+	TPU_TO1_MARK,
+};
+static const unsigned int tpu_to2_pins[] = {
+	RCAR_GP_PIN(1, 18),
+};
+static const unsigned int tpu_to2_mux[] = {
+	TPU_TO2_MARK,
+};
+static const unsigned int tpu_to3_pins[] = {
+	RCAR_GP_PIN(1, 24),
+};
+static const unsigned int tpu_to3_mux[] = {
+	TPU_TO3_MARK,
+};
+
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
 	RCAR_GP_PIN(7, 23), /* PWEN */
@@ -4435,7 +4461,7 @@ static const unsigned int vin2_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[342];
+	struct sh_pfc_pin_group common[346];
 	struct sh_pfc_pin_group r8a779x[9];
 } pinmux_groups = {
 	.common = {
@@ -4747,6 +4773,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(ssi9_data_b),
 		SH_PFC_PIN_GROUP(ssi9_ctrl),
 		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+		SH_PFC_PIN_GROUP(tpu_to0),
+		SH_PFC_PIN_GROUP(tpu_to1),
+		SH_PFC_PIN_GROUP(tpu_to2),
+		SH_PFC_PIN_GROUP(tpu_to3),
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		VIN_DATA_PIN_GROUP(vin0_data, 24),
@@ -5282,6 +5312,13 @@ static const char * const ssi_groups[] = {
 	"ssi9_ctrl_b",
 };
 
+static const char * const tpu_groups[] = {
+	"tpu_to0",
+	"tpu_to1",
+	"tpu_to2",
+	"tpu_to3",
+};
+
 static const char * const usb0_groups[] = {
 	"usb0",
 };
@@ -5331,7 +5368,7 @@ static const char * const vin2_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[57];
+	struct sh_pfc_function common[58];
 	struct sh_pfc_function r8a779x[2];
 } pinmux_functions = {
 	.common = {
@@ -5387,6 +5424,7 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi1),
 		SH_PFC_FUNCTION(sdhi2),
 		SH_PFC_FUNCTION(ssi),
+		SH_PFC_FUNCTION(tpu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(vin0),
-- 
2.7.4
