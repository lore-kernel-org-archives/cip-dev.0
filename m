From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:56 +0100
Subject: [cip-dev] [PATCH 03/11] pinctrl: sh-pfc: r8a7791: Add SCIF_CLK
	support
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add pins, groups, and a function for SCIF_CLK, which is the external
clock source for the Baud Rate Generator for External Clock (BRG) on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit a4c8a6d2f6ed3686ce0cc789ed9213f579ebd4ad)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index ebadd28..74704b0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -3602,6 +3602,23 @@ static const unsigned int scifb2_data_d_pins[] = {
 static const unsigned int scifb2_data_d_mux[] = {
 	SCIFB2_RXD_D_MARK, SCIFB2_TXD_D_MARK,
 };
+
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int scif_clk_mux[] = {
+	SCIF_CLK_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(7, 19),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
+
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
@@ -4510,6 +4527,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb2_data_c),
 	SH_PFC_PIN_GROUP(scifb2_clk_c),
 	SH_PFC_PIN_GROUP(scifb2_data_d),
+	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk_b),
 	SH_PFC_PIN_GROUP(sdhi0_data1),
 	SH_PFC_PIN_GROUP(sdhi0_data4),
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
@@ -4976,6 +4995,11 @@ static const char * const scifb2_groups[] = {
 	"scifb2_data_d",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk",
+	"scif_clk_b",
+};
+
 static const char * const sdhi0_groups[] = {
 	"sdhi0_data1",
 	"sdhi0_data4",
@@ -5126,6 +5150,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
-- 
1.9.1
