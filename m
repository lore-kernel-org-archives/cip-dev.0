From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 10:28:45 +0000
Subject: [cip-dev] [PATCH 1/4] pinctrl: sh-pfc: Reduce kernel size for
	narrow VIN channels
In-Reply-To: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
References: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553250528-42395-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Some VIN channels support less than 24 lanes.  As union vin_data always
consumes space for 24 lanes, this wastes memory.

Hence introduce new smaller unions vin_data12 and vin_data16, to
accommodate VIN channels with only 12 or 16 lanes.

This reduces the static pin controller driver size by 320 bytes for
R-Car V2H, and by 96 bytes for R-Car E2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
(cherry picked from commit 50f3f2d73e3426ba5aac0fe62098870579a0b357)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c | 16 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  4 ++--
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 17 +++++++++++++++--
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
index cc3597f..a3acfd6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
@@ -1477,7 +1477,7 @@ static const unsigned int vin1_clk_mux[] = {
 	VI1_CLK_MARK,
 };
 /* - VIN2 ------------------------------------------------------------------- */
-static const union vin_data vin2_data_pins = {
+static const union vin_data16 vin2_data_pins = {
 	.data16 = {
 		RCAR_GP_PIN(6, 4), RCAR_GP_PIN(6, 5),
 		RCAR_GP_PIN(6, 6), RCAR_GP_PIN(6, 7),
@@ -1489,7 +1489,7 @@ static const union vin_data vin2_data_pins = {
 		RCAR_GP_PIN(8, 11), RCAR_GP_PIN(8, 12),
 	},
 };
-static const union vin_data vin2_data_mux = {
+static const union vin_data16 vin2_data_mux = {
 	.data16 = {
 		VI2_D0_C0_MARK, VI2_D1_C1_MARK,
 		VI2_D2_C2_MARK,	VI2_D3_C3_MARK,
@@ -1527,7 +1527,7 @@ static const unsigned int vin2_clk_mux[] = {
 	VI2_CLK_MARK,
 };
 /* - VIN3 ------------------------------------------------------------------- */
-static const union vin_data vin3_data_pins = {
+static const union vin_data16 vin3_data_pins = {
 	.data16 = {
 		RCAR_GP_PIN(7, 4), RCAR_GP_PIN(7, 5),
 		RCAR_GP_PIN(7, 6), RCAR_GP_PIN(7, 7),
@@ -1539,7 +1539,7 @@ static const union vin_data vin3_data_pins = {
 		RCAR_GP_PIN(8, 15), RCAR_GP_PIN(8, 16),
 	},
 };
-static const union vin_data vin3_data_mux = {
+static const union vin_data16 vin3_data_mux = {
 	.data16 = {
 		VI3_D0_C0_MARK, VI3_D1_C1_MARK,
 		VI3_D2_C2_MARK,	VI3_D3_C3_MARK,
@@ -1577,7 +1577,7 @@ static const unsigned int vin3_clk_mux[] = {
 	VI3_CLK_MARK,
 };
 /* - VIN4 ------------------------------------------------------------------- */
-static const union vin_data vin4_data_pins = {
+static const union vin_data12 vin4_data_pins = {
 	.data12 = {
 		RCAR_GP_PIN(8, 4), RCAR_GP_PIN(8, 5),
 		RCAR_GP_PIN(8, 6), RCAR_GP_PIN(8, 7),
@@ -1587,7 +1587,7 @@ static const union vin_data vin4_data_pins = {
 		RCAR_GP_PIN(8, 14), RCAR_GP_PIN(8, 15),
 	},
 };
-static const union vin_data vin4_data_mux = {
+static const union vin_data12 vin4_data_mux = {
 	.data12 = {
 		VI4_D0_C0_MARK, VI4_D1_C1_MARK,
 		VI4_D2_C2_MARK, VI4_D3_C3_MARK,
@@ -1623,7 +1623,7 @@ static const unsigned int vin4_clk_mux[] = {
 	VI4_CLK_MARK,
 };
 /* - VIN5 ------------------------------------------------------------------- */
-static const union vin_data vin5_data_pins = {
+static const union vin_data12 vin5_data_pins = {
 	.data12 = {
 		RCAR_GP_PIN(9, 4), RCAR_GP_PIN(9, 5),
 		RCAR_GP_PIN(9, 6), RCAR_GP_PIN(9, 7),
@@ -1633,7 +1633,7 @@ static const union vin_data vin5_data_pins = {
 		RCAR_GP_PIN(9, 14), RCAR_GP_PIN(9, 15),
 	},
 };
-static const union vin_data vin5_data_mux = {
+static const union vin_data12 vin5_data_mux = {
 	.data12 = {
 		VI5_D0_C0_MARK, VI5_D1_C1_MARK,
 		VI5_D2_C2_MARK, VI5_D3_C3_MARK,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 1640024..bbb1a37 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -3707,7 +3707,7 @@ static const unsigned int vin0_clk_mux[] = {
 	VI0_CLK_MARK,
 };
 /* - VIN1 ------------------------------------------------------------------- */
-static const union vin_data vin1_data_pins = {
+static const union vin_data12 vin1_data_pins = {
 	.data12 = {
 		RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
 		RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
@@ -3717,7 +3717,7 @@ static const union vin_data vin1_data_pins = {
 		RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
 	},
 };
-static const union vin_data vin1_data_mux = {
+static const union vin_data12 vin1_data_mux = {
 	.data12 = {
 		VI1_DATA0_MARK, VI1_DATA1_MARK,
 		VI1_DATA2_MARK, VI1_DATA3_MARK,
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 15fbc4f..2a62fc7 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -56,8 +56,8 @@ struct sh_pfc_pin_group {
 };
 
 /*
- * Using union vin_data saves memory occupied by the VIN data pins.
- * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups
+ * Using union vin_data{,12,16} saves memory occupied by the VIN data pins.
+ * VIN_DATA_PIN_GROUP() is a macro used to describe the VIN pin groups
  * in this case.
  */
 #define VIN_DATA_PIN_GROUP(n, s)				\
@@ -68,6 +68,19 @@ struct sh_pfc_pin_group {
 		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
 	}
 
+union vin_data12 {
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+};
+
+union vin_data16 {
+	unsigned int data16[16];
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+};
+
 union vin_data {
 	unsigned int data24[24];
 	unsigned int data20[20];
-- 
2.7.4
