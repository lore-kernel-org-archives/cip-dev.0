From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:25 +0100
Subject: [cip-dev] [PATCH 24/86] pinctrl: sh-pfc: r8a7794: Add SCIF_CLK
	support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-25-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add pins, groups, and a function for SCIF_CLK, which is the external
clock source for the Baud Rate Generator for External Clock (BRG) on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit ed66700c031917be7b5527a41ac572a1c714f0ed)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 3324ee7..acd104b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -2644,6 +2644,21 @@ static const unsigned int scifb2_ctrl_pins[] = {
 static const unsigned int scifb2_ctrl_mux[] = {
 	SCIFB2_RTS_N_MARK, SCIFB2_CTS_N_MARK,
 };
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(1, 23),
+};
+static const unsigned int scif_clk_mux[] = {
+	SCIF_CLK_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(3, 29),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
@@ -3071,6 +3086,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb2_data),
 	SH_PFC_PIN_GROUP(scifb2_clk),
 	SH_PFC_PIN_GROUP(scifb2_ctrl),
+	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk_b),
 	SH_PFC_PIN_GROUP(sdhi0_data1),
 	SH_PFC_PIN_GROUP(sdhi0_data4),
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
@@ -3354,6 +3371,11 @@ static const char * const scifb2_groups[] = {
 	"scifb2_ctrl",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk",
+	"scif_clk_b",
+};
+
 static const char * const sdhi0_groups[] = {
 	"sdhi0_data1",
 	"sdhi0_data4",
@@ -3441,6 +3463,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
-- 
2.7.4
