From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:52 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 47/51] pinctrl: sh-pfc: r8a7791:
	Fix VIN1 versioned groups
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-48-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit b8ba194ca5f4ca238b05e1d1579404d4ff3de522 upstream.

The naming of the "b" versions of the VIN1 pin groups is a bit odd, in
that the "_b" appears in the middle of the names, instead of as a
suffix.

Increase consistency with other SoCs by making R-Car M2-W and M2-N, and
RZ/G1M and RZ/G1N, use the recently added optional "version" argument of
the VIN_DATA_PIN_GROUP() macro.

Note that this breaks backwards compatibility with existing DTBs, but
there are no upstream users of the "vin1_b_*" names.

Fixes: 8e32c9671f84acd8 ("pinctrl: sh-pfc: r8a7791: Add VIN pins")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 68 ++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index f9de61c..74f8b77 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4321,7 +4321,7 @@ static const unsigned int vin1_clk_pins[] = {
 static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
-static const union vin_data vin1_b_data_pins = {
+static const union vin_data vin1_data_b_pins = {
 	.data24 = {
 		/* B */
 		RCAR_GP_PIN(3, 0), RCAR_GP_PIN(3, 1),
@@ -4340,7 +4340,7 @@ static const union vin_data vin1_b_data_pins = {
 		RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
 	},
 };
-static const union vin_data vin1_b_data_mux = {
+static const union vin_data vin1_data_b_mux = {
 	.data24 = {
 		/* B */
 		VI1_DATA0_B_MARK, VI1_DATA1_B_MARK,
@@ -4359,7 +4359,7 @@ static const union vin_data vin1_b_data_mux = {
 		VI1_R6_B_MARK, VI1_R7_B_MARK,
 	},
 };
-static const unsigned int vin1_b_data18_pins[] = {
+static const unsigned int vin1_data18_b_pins[] = {
 	/* B */
 	RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
 	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 11),
@@ -4373,7 +4373,7 @@ static const unsigned int vin1_b_data18_pins[] = {
 	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 18),
 	RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 20),
 };
-static const unsigned int vin1_b_data18_mux[] = {
+static const unsigned int vin1_data18_b_mux[] = {
 	/* B */
 	VI1_DATA2_B_MARK, VI1_DATA3_B_MARK,
 	VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
@@ -4387,30 +4387,30 @@ static const unsigned int vin1_b_data18_mux[] = {
 	VI1_R4_B_MARK, VI1_R5_B_MARK,
 	VI1_R6_B_MARK, VI1_R7_B_MARK,
 };
-static const unsigned int vin1_b_sync_pins[] = {
+static const unsigned int vin1_sync_b_pins[] = {
 	RCAR_GP_PIN(3, 17), /* HSYNC */
 	RCAR_GP_PIN(3, 18), /* VSYNC */
 };
-static const unsigned int vin1_b_sync_mux[] = {
+static const unsigned int vin1_sync_b_mux[] = {
 	VI1_HSYNC_N_B_MARK,
 	VI1_VSYNC_N_B_MARK,
 };
-static const unsigned int vin1_b_field_pins[] = {
+static const unsigned int vin1_field_b_pins[] = {
 	RCAR_GP_PIN(3, 20),
 };
-static const unsigned int vin1_b_field_mux[] = {
+static const unsigned int vin1_field_b_mux[] = {
 	VI1_FIELD_B_MARK,
 };
-static const unsigned int vin1_b_clkenb_pins[] = {
+static const unsigned int vin1_clkenb_b_pins[] = {
 	RCAR_GP_PIN(3, 19),
 };
-static const unsigned int vin1_b_clkenb_mux[] = {
+static const unsigned int vin1_clkenb_b_mux[] = {
 	VI1_CLKENB_B_MARK,
 };
-static const unsigned int vin1_b_clk_pins[] = {
+static const unsigned int vin1_clk_b_pins[] = {
 	RCAR_GP_PIN(3, 16),
 };
-static const unsigned int vin1_b_clk_mux[] = {
+static const unsigned int vin1_clk_b_mux[] = {
 	VI1_CLK_B_MARK,
 };
 /* - VIN2 ----------------------------------------------------------------- */
@@ -4788,17 +4788,17 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin1_field),
 		SH_PFC_PIN_GROUP(vin1_clkenb),
 		SH_PFC_PIN_GROUP(vin1_clk),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 24),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 20),
-		SH_PFC_PIN_GROUP(vin1_b_data18),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 16),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 12),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 10),
-		VIN_DATA_PIN_GROUP(vin1_b_data, 8),
-		SH_PFC_PIN_GROUP(vin1_b_sync),
-		SH_PFC_PIN_GROUP(vin1_b_field),
-		SH_PFC_PIN_GROUP(vin1_b_clkenb),
-		SH_PFC_PIN_GROUP(vin1_b_clk),
+		VIN_DATA_PIN_GROUP(vin1_data, 24, _b),
+		VIN_DATA_PIN_GROUP(vin1_data, 20, _b),
+		SH_PFC_PIN_GROUP(vin1_data18_b),
+		VIN_DATA_PIN_GROUP(vin1_data, 16, _b),
+		VIN_DATA_PIN_GROUP(vin1_data, 12, _b),
+		VIN_DATA_PIN_GROUP(vin1_data, 10, _b),
+		VIN_DATA_PIN_GROUP(vin1_data, 8, _b),
+		SH_PFC_PIN_GROUP(vin1_sync_b),
+		SH_PFC_PIN_GROUP(vin1_field_b),
+		SH_PFC_PIN_GROUP(vin1_clkenb_b),
+		SH_PFC_PIN_GROUP(vin1_clk_b),
 		SH_PFC_PIN_GROUP(vin2_data8),
 		SH_PFC_PIN_GROUP(vin2_sync),
 		SH_PFC_PIN_GROUP(vin2_field),
@@ -5339,17 +5339,17 @@ static const char * const vin1_groups[] = {
 	"vin1_field",
 	"vin1_clkenb",
 	"vin1_clk",
-	"vin1_b_data24",
-	"vin1_b_data20",
-	"vin1_b_data18",
-	"vin1_b_data16",
-	"vin1_b_data12",
-	"vin1_b_data10",
-	"vin1_b_data8",
-	"vin1_b_sync",
-	"vin1_b_field",
-	"vin1_b_clkenb",
-	"vin1_b_clk",
+	"vin1_data24_b",
+	"vin1_data20_b",
+	"vin1_data18_b",
+	"vin1_data16_b",
+	"vin1_data12_b",
+	"vin1_data10_b",
+	"vin1_data8_b",
+	"vin1_sync_b",
+	"vin1_field_b",
+	"vin1_clkenb_b",
+	"vin1_clk_b",
 };
 
 static const char * const vin2_groups[] = {
-- 
2.7.4
