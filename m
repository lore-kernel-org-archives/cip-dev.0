From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:44 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 39/51] pinctrl: sh-pfc: r8a7796:
	Add TPU pins, groups and functions
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-40-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 32ba9f222edb92278ec8eadfc6100c7922dc2ad7 upstream.

Add pins, groups and functions for the 16-Bit Timer Pulse Unit outputs
on the R-Car M3-W and RZ/G2M SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 46 ++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 93e6bb4..169d8c0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -3896,6 +3896,36 @@ static const unsigned int tmu_tclk2_b_mux[] = {
 	TCLK2_B_MARK,
 };
 
+/* - TPU ------------------------------------------------------------------- */
+static const unsigned int tpu_to0_pins[] = {
+	/* TPU0TO0 */
+	RCAR_GP_PIN(6, 28),
+};
+static const unsigned int tpu_to0_mux[] = {
+	TPU0TO0_MARK,
+};
+static const unsigned int tpu_to1_pins[] = {
+	/* TPU0TO1 */
+	RCAR_GP_PIN(6, 29),
+};
+static const unsigned int tpu_to1_mux[] = {
+	TPU0TO1_MARK,
+};
+static const unsigned int tpu_to2_pins[] = {
+	/* TPU0TO2 */
+	RCAR_GP_PIN(6, 30),
+};
+static const unsigned int tpu_to2_mux[] = {
+	TPU0TO2_MARK,
+};
+static const unsigned int tpu_to3_pins[] = {
+	/* TPU0TO3 */
+	RCAR_GP_PIN(6, 31),
+};
+static const unsigned int tpu_to3_mux[] = {
+	TPU0TO3_MARK,
+};
+
 /* - USB0 ------------------------------------------------------------------- */
 static const unsigned int usb0_pins[] = {
 	/* PWEN, OVC */
@@ -4115,7 +4145,7 @@ static const unsigned int vin5_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[312];
+	struct sh_pfc_pin_group common[316];
 	struct sh_pfc_pin_group automotive[30];
 } pinmux_groups = {
 	.common = {
@@ -4402,6 +4432,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(tmu_tclk1_b),
 		SH_PFC_PIN_GROUP(tmu_tclk2_a),
 		SH_PFC_PIN_GROUP(tmu_tclk2_b),
+		SH_PFC_PIN_GROUP(tpu_to0),
+		SH_PFC_PIN_GROUP(tpu_to1),
+		SH_PFC_PIN_GROUP(tpu_to2),
+		SH_PFC_PIN_GROUP(tpu_to3),
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
@@ -4923,6 +4957,13 @@ static const char * const tmu_groups[] = {
 	"tmu_tclk2_b",
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
@@ -4968,7 +5009,7 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[49];
+	struct sh_pfc_function common[50];
 	struct sh_pfc_function automotive[4];
 } pinmux_functions = {
 	.common = {
@@ -5016,6 +5057,7 @@ static const struct {
 		SH_PFC_FUNCTION(sdhi3),
 		SH_PFC_FUNCTION(ssi),
 		SH_PFC_FUNCTION(tmu),
+		SH_PFC_FUNCTION(tpu),
 		SH_PFC_FUNCTION(usb0),
 		SH_PFC_FUNCTION(usb1),
 		SH_PFC_FUNCTION(usb30),
-- 
2.7.4
