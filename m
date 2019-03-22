From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:19:24 +0000
Subject: [cip-dev] [PATCH 3/9] pinctrl: sh-pfc: r8a77990: Add INTC-EX pins,
	groups and function
In-Reply-To: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
References: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553246370-60751-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add pins, groups, and function for the Interrupt Controller for
External Devices (INTC-EX) on the R-Car E3 SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ef26d96023a4c34b1bcc4294f570df2b63a1b952)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 64 +++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 663b8ce..1fdafa4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1595,6 +1595,50 @@ static const unsigned int i2c7_b_mux[] = {
 	SCL7_B_MARK, SDA7_B_MARK,
 };
 
+/* - INTC-EX ---------------------------------------------------------------- */
+static const unsigned int intc_ex_irq0_pins[] = {
+	/* IRQ0 */
+	RCAR_GP_PIN(1, 0),
+};
+static const unsigned int intc_ex_irq0_mux[] = {
+	IRQ0_MARK,
+};
+static const unsigned int intc_ex_irq1_pins[] = {
+	/* IRQ1 */
+	RCAR_GP_PIN(1, 1),
+};
+static const unsigned int intc_ex_irq1_mux[] = {
+	IRQ1_MARK,
+};
+static const unsigned int intc_ex_irq2_pins[] = {
+	/* IRQ2 */
+	RCAR_GP_PIN(1, 2),
+};
+static const unsigned int intc_ex_irq2_mux[] = {
+	IRQ2_MARK,
+};
+static const unsigned int intc_ex_irq3_pins[] = {
+	/* IRQ3 */
+	RCAR_GP_PIN(1, 9),
+};
+static const unsigned int intc_ex_irq3_mux[] = {
+	IRQ3_MARK,
+};
+static const unsigned int intc_ex_irq4_pins[] = {
+	/* IRQ4 */
+	RCAR_GP_PIN(1, 10),
+};
+static const unsigned int intc_ex_irq4_mux[] = {
+	IRQ4_MARK,
+};
+static const unsigned int intc_ex_irq5_pins[] = {
+	/* IRQ5 */
+	RCAR_GP_PIN(0, 7),
+};
+static const unsigned int intc_ex_irq5_mux[] = {
+	IRQ5_MARK,
+};
+
 /* - MSIOF0 ----------------------------------------------------------------- */
 static const unsigned int msiof0_clk_pins[] = {
 	/* SCK */
@@ -2390,7 +2434,7 @@ static const unsigned int usb30_id_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[117];
+	struct sh_pfc_pin_group common[123];
 	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
@@ -2425,6 +2469,12 @@ static const struct {
 		SH_PFC_PIN_GROUP(i2c6_b),
 		SH_PFC_PIN_GROUP(i2c7_a),
 		SH_PFC_PIN_GROUP(i2c7_b),
+		SH_PFC_PIN_GROUP(intc_ex_irq0),
+		SH_PFC_PIN_GROUP(intc_ex_irq1),
+		SH_PFC_PIN_GROUP(intc_ex_irq2),
+		SH_PFC_PIN_GROUP(intc_ex_irq3),
+		SH_PFC_PIN_GROUP(intc_ex_irq4),
+		SH_PFC_PIN_GROUP(intc_ex_irq5),
 		SH_PFC_PIN_GROUP(msiof0_clk),
 		SH_PFC_PIN_GROUP(msiof0_sync),
 		SH_PFC_PIN_GROUP(msiof0_ss1),
@@ -2569,6 +2619,15 @@ static const char * const i2c7_groups[] = {
 	"i2c7_b",
 };
 
+static const char * const intc_ex_groups[] = {
+	"intc_ex_irq0",
+	"intc_ex_irq1",
+	"intc_ex_irq2",
+	"intc_ex_irq3",
+	"intc_ex_irq4",
+	"intc_ex_irq5",
+};
+
 static const char * const msiof0_groups[] = {
 	"msiof0_clk",
 	"msiof0_sync",
@@ -2716,7 +2775,7 @@ static const char * const usb30_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[28];
+	struct sh_pfc_function common[29];
 	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
@@ -2728,6 +2787,7 @@ static const struct {
 		SH_PFC_FUNCTION(i2c5),
 		SH_PFC_FUNCTION(i2c6),
 		SH_PFC_FUNCTION(i2c7),
+		SH_PFC_FUNCTION(intc_ex),
 		SH_PFC_FUNCTION(msiof0),
 		SH_PFC_FUNCTION(msiof1),
 		SH_PFC_FUNCTION(msiof2),
-- 
2.7.4
