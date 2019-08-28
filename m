From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:55 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 28/41] pinctrl: sh-pfc: rcar-gen3:
	Remove HDMI CEC pins, groups, and functions
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-29-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 5671f8e0270ad5e33e3088e5f0fa71af67129630 upstream.

The HDMI CEC function is not supported by the R-Car Gen3 Hardware Manual
Rev 1.00. Therefore, delete the corresponding pin groups and functions,
and rename the HDMI[01]_CEC definitions to match their GPIO
functionality.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Squashed several commits]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 44 ++++++--------------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 44 ++++++--------------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 27 +++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    |  8 +++---
 4 files changed, 26 insertions(+), 97 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index ab5a94e..157a8e9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -200,8 +200,8 @@
 #define GPSR6_0		F_(SSI_SCK01239,	IP13_23_20)
 
 /* GPSR7 */
-#define GPSR7_3		FM(HDMI1_CEC)
-#define GPSR7_2		FM(HDMI0_CEC)
+#define GPSR7_3		FM(GP7_03)
+#define GPSR7_2		FM(GP7_02)
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
@@ -574,8 +574,8 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_SINGLE(AVS1),
 	PINMUX_SINGLE(AVS2),
-	PINMUX_SINGLE(HDMI0_CEC),
-	PINMUX_SINGLE(HDMI1_CEC),
+	PINMUX_SINGLE(GP7_02),
+	PINMUX_SINGLE(GP7_03),
 	PINMUX_SINGLE(I2C_SEL_0_1),
 	PINMUX_SINGLE(I2C_SEL_3_1),
 	PINMUX_SINGLE(I2C_SEL_5_1),
@@ -2066,22 +2066,6 @@ static const unsigned int du_disp_pins[] = {
 static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
-/* - HDMI ------------------------------------------------------------------- */
-static const unsigned int hdmi0_cec_pins[] = {
-	/* HDMI0_CEC */
-	RCAR_GP_PIN(7, 2),
-};
-static const unsigned int hdmi0_cec_mux[] = {
-	HDMI0_CEC_MARK,
-};
-static const unsigned int hdmi1_cec_pins[] = {
-	/* HDMI1_CEC */
-	RCAR_GP_PIN(7, 3),
-};
-static const unsigned int hdmi1_cec_mux[] = {
-	HDMI1_CEC_MARK,
-};
-
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
 	/* RX, TX */
@@ -3911,8 +3895,6 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_oddf),
 	SH_PFC_PIN_GROUP(du_cde),
 	SH_PFC_PIN_GROUP(du_disp),
-	SH_PFC_PIN_GROUP(hdmi0_cec),
-	SH_PFC_PIN_GROUP(hdmi1_cec),
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
 	SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4263,14 +4245,6 @@ static const char * const du_groups[] = {
 	"du_disp",
 };
 
-static const char * const hdmi0_groups[] = {
-	"hdmi0_cec",
-};
-
-static const char * const hdmi1_groups[] = {
-	"hdmi1_cec",
-};
-
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
 	"hscif0_clk",
@@ -4646,8 +4620,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(drif2),
 	SH_PFC_FUNCTION(drif3),
 	SH_PFC_FUNCTION(du),
-	SH_PFC_FUNCTION(hdmi0),
-	SH_PFC_FUNCTION(hdmi1),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(hscif2),
@@ -5363,8 +5335,8 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(0, 15),   24, 3 },	/* D15 */
 		{ RCAR_GP_PIN(7,  0),   20, 3 },	/* AVS1 */
 		{ RCAR_GP_PIN(7,  1),   16, 3 },	/* AVS2 */
-		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* HDMI0_CEC */
-		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* HDMI1_CEC */
+		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* GP7_02 */
+		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* GP7_03 */
 		{ PIN_A_NUMBER('P', 7),  4, 2 },	/* DU_DOTCLKIN0 */
 		{ PIN_A_NUMBER('P', 8),  0, 2 },	/* DU_DOTCLKIN1 */
 	} },
@@ -5619,8 +5591,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[25] = RCAR_GP_PIN(0, 15),	/* D15 */
 		[26] = RCAR_GP_PIN(7,  0),	/* AVS1 */
 		[27] = RCAR_GP_PIN(7,  1),	/* AVS2 */
-		[28] = RCAR_GP_PIN(7,  2),	/* HDMI0_CEC */
-		[29] = RCAR_GP_PIN(7,  3),	/* HDMI1_CEC */
+		[28] = RCAR_GP_PIN(7,  2),	/* GP7_02 */
+		[29] = RCAR_GP_PIN(7,  3),	/* GP7_03 */
 		[30] = PIN_A_NUMBER('P', 7),	/* DU_DOTCLKIN0 */
 		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
 	} },
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index b1aa5c1..5e6df51 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -202,8 +202,8 @@
 #define GPSR6_0		F_(SSI_SCK01239,		IP14_23_20)
 
 /* GPSR7 */
-#define GPSR7_3		FM(HDMI1_CEC)
-#define GPSR7_2		FM(HDMI0_CEC)
+#define GPSR7_3		FM(GP7_03)
+#define GPSR7_2		FM(GP7_02)
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
@@ -588,8 +588,8 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(AVS1),
 	PINMUX_SINGLE(AVS2),
 	PINMUX_SINGLE(CLKOUT),
-	PINMUX_SINGLE(HDMI0_CEC),
-	PINMUX_SINGLE(HDMI1_CEC),
+	PINMUX_SINGLE(GP7_02),
+	PINMUX_SINGLE(GP7_03),
 	PINMUX_SINGLE(I2C_SEL_0_1),
 	PINMUX_SINGLE(I2C_SEL_3_1),
 	PINMUX_SINGLE(I2C_SEL_5_1),
@@ -2126,22 +2126,6 @@ static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
 
-/* - HDMI ------------------------------------------------------------------- */
-static const unsigned int hdmi0_cec_pins[] = {
-	/* HDMI0_CEC */
-	RCAR_GP_PIN(7, 2),
-};
-static const unsigned int hdmi0_cec_mux[] = {
-	HDMI0_CEC_MARK,
-};
-static const unsigned int hdmi1_cec_pins[] = {
-	/* HDMI1_CEC */
-	RCAR_GP_PIN(7, 3),
-};
-static const unsigned int hdmi1_cec_mux[] = {
-	HDMI1_CEC_MARK,
-};
-
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
 	/* RX, TX */
@@ -4230,8 +4214,6 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(du_oddf),
 	SH_PFC_PIN_GROUP(du_cde),
 	SH_PFC_PIN_GROUP(du_disp),
-	SH_PFC_PIN_GROUP(hdmi0_cec),
-	SH_PFC_PIN_GROUP(hdmi1_cec),
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
 	SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4613,14 +4595,6 @@ static const char * const du_groups[] = {
 	"du_disp",
 };
 
-static const char * const hdmi0_groups[] = {
-	"hdmi0_cec",
-};
-
-static const char * const hdmi1_groups[] = {
-	"hdmi1_cec",
-};
-
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
 	"hscif0_clk",
@@ -5027,8 +5001,6 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(drif2),
 	SH_PFC_FUNCTION(drif3),
 	SH_PFC_FUNCTION(du),
-	SH_PFC_FUNCTION(hdmi0),
-	SH_PFC_FUNCTION(hdmi1),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
 	SH_PFC_FUNCTION(hscif2),
@@ -5752,8 +5724,8 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(0, 15),   24, 3 },	/* D15 */
 		{ RCAR_GP_PIN(7,  0),   20, 3 },	/* AVS1 */
 		{ RCAR_GP_PIN(7,  1),   16, 3 },	/* AVS2 */
-		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* HDMI0_CEC */
-		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* HDMI1_CEC */
+		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* GP7_02 */
+		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* GP7_03 */
 		{ PIN_A_NUMBER('P', 7),  4, 2 },	/* DU_DOTCLKIN0 */
 		{ PIN_A_NUMBER('P', 8),  0, 2 },	/* DU_DOTCLKIN1 */
 	} },
@@ -6007,8 +5979,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[25] = RCAR_GP_PIN(0, 15),	/* D15 */
 		[26] = RCAR_GP_PIN(7,  0),	/* AVS1 */
 		[27] = RCAR_GP_PIN(7,  1),	/* AVS2 */
-		[28] = RCAR_GP_PIN(7,  2),	/* HDMI0_CEC */
-		[29] = RCAR_GP_PIN(7,  3),	/* HDMI1_CEC */
+		[28] = RCAR_GP_PIN(7,  2),	/* GP7_02 */
+		[29] = RCAR_GP_PIN(7,  3),	/* GP7_03 */
 		[30] = PIN_A_NUMBER('P', 7),	/* DU_DOTCLKIN0 */
 		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
 	} },
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index aedb431..e3da9ba 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -208,7 +208,7 @@
 
 /* GPSR7 */
 #define GPSR7_3		FM(GP7_03)
-#define GPSR7_2		FM(HDMI0_CEC)
+#define GPSR7_2		FM(GP7_02)
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
@@ -599,7 +599,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(AVS2),
 	PINMUX_SINGLE(CLKOUT),
 	PINMUX_SINGLE(GP7_03),
-	PINMUX_SINGLE(HDMI0_CEC),
+	PINMUX_SINGLE(GP7_02),
 	PINMUX_SINGLE(MSIOF0_RXD),
 	PINMUX_SINGLE(MSIOF0_SCK),
 	PINMUX_SINGLE(MSIOF0_TXD),
@@ -2142,15 +2142,6 @@ static const unsigned int du_disp_mux[] = {
 	DU_DISP_MARK,
 };
 
-/* - HDMI ------------------------------------------------------------------- */
-static const unsigned int hdmi0_cec_pins[] = {
-	/* HDMI0_CEC */
-	RCAR_GP_PIN(7, 2),
-};
-static const unsigned int hdmi0_cec_mux[] = {
-	HDMI0_CEC_MARK,
-};
-
 /* - HSCIF0 ----------------------------------------------------------------- */
 static const unsigned int hscif0_data_pins[] = {
 	/* RX, TX */
@@ -4126,7 +4117,7 @@ static const unsigned int vin5_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[313];
+	struct sh_pfc_pin_group common[312];
 	struct sh_pfc_pin_group automotive[30];
 } pinmux_groups = {
 	.common = {
@@ -4173,7 +4164,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(du_oddf),
 		SH_PFC_PIN_GROUP(du_cde),
 		SH_PFC_PIN_GROUP(du_disp),
-		SH_PFC_PIN_GROUP(hdmi0_cec),
 		SH_PFC_PIN_GROUP(hscif0_data),
 		SH_PFC_PIN_GROUP(hscif0_clk),
 		SH_PFC_PIN_GROUP(hscif0_ctrl),
@@ -4587,10 +4577,6 @@ static const char * const du_groups[] = {
 	"du_disp",
 };
 
-static const char * const hdmi0_groups[] = {
-	"hdmi0_cec",
-};
-
 static const char * const hscif0_groups[] = {
 	"hscif0_data",
 	"hscif0_clk",
@@ -4984,7 +4970,7 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[50];
+	struct sh_pfc_function common[49];
 	struct sh_pfc_function automotive[4];
 } pinmux_functions = {
 	.common = {
@@ -4996,7 +4982,6 @@ static const struct {
 		SH_PFC_FUNCTION(canfd0),
 		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(du),
-		SH_PFC_FUNCTION(hdmi0),
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
 		SH_PFC_FUNCTION(hscif2),
@@ -5726,7 +5711,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(0, 15),   24, 3 },	/* D15 */
 		{ RCAR_GP_PIN(7,  0),   20, 3 },	/* AVS1 */
 		{ RCAR_GP_PIN(7,  1),   16, 3 },	/* AVS2 */
-		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* HDMI0_CEC */
+		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* GP7_02 */
 		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* GP7_03 */
 		{ PIN_A_NUMBER('P', 7),  4, 2 },	/* DU_DOTCLKIN0 */
 		{ PIN_A_NUMBER('P', 8),  0, 2 },	/* DU_DOTCLKIN1 */
@@ -5982,7 +5967,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[25] = RCAR_GP_PIN(0, 15),	/* D15 */
 		[26] = RCAR_GP_PIN(7,  0),	/* AVS1 */
 		[27] = RCAR_GP_PIN(7,  1),	/* AVS2 */
-		[28] = RCAR_GP_PIN(7,  2),	/* HDMI0_CEC */
+		[28] = RCAR_GP_PIN(7,  2),	/* GP7_02 */
 		[29] = RCAR_GP_PIN(7,  3),	/* GP7_03 */
 		[30] = PIN_A_NUMBER('P', 7),	/* DU_DOTCLKIN0 */
 		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 3ebfd85..6f800de 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -206,7 +206,7 @@
 
 /* GPSR7 */
 #define GPSR7_3		FM(GP7_03)
-#define GPSR7_2		FM(HDMI0_CEC)
+#define GPSR7_2		FM(GP7_02)
 #define GPSR7_1		FM(AVS2)
 #define GPSR7_0		FM(AVS1)
 
@@ -593,7 +593,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(AVS2),
 	PINMUX_SINGLE(CLKOUT),
 	PINMUX_SINGLE(GP7_03),
-	PINMUX_SINGLE(HDMI0_CEC),
+	PINMUX_SINGLE(GP7_02),
 	PINMUX_SINGLE(MSIOF0_RXD),
 	PINMUX_SINGLE(MSIOF0_SCK),
 	PINMUX_SINGLE(MSIOF0_TXD),
@@ -4693,7 +4693,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(0, 15),   24, 3 },	/* D15 */
 		{ RCAR_GP_PIN(7,  0),   20, 3 },	/* AVS1 */
 		{ RCAR_GP_PIN(7,  1),   16, 3 },	/* AVS2 */
-		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* HDMI0_CEC */
+		{ RCAR_GP_PIN(7,  2),   12, 3 },	/* GP7_02 */
 		{ RCAR_GP_PIN(7,  3),    8, 3 },	/* GP7_03 */
 		{ PIN_A_NUMBER('P', 7),  4, 2 },	/* DU_DOTCLKIN0 */
 		{ PIN_A_NUMBER('P', 8),  0, 2 },	/* DU_DOTCLKIN1 */
@@ -4947,7 +4947,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[25] = RCAR_GP_PIN(0, 15),	/* D15 */
 		[26] = RCAR_GP_PIN(7,  0),	/* AVS1 */
 		[27] = RCAR_GP_PIN(7,  1),	/* AVS2 */
-		[28] = RCAR_GP_PIN(7,  2),	/* HDMI0_CEC */
+		[28] = RCAR_GP_PIN(7,  2),	/* GP7_02 */
 		[29] = RCAR_GP_PIN(7,  3),	/* GP7_03 */
 		[30] = PIN_A_NUMBER('P', 7),	/* DU_DOTCLKIN0 */
 		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
-- 
2.7.4
