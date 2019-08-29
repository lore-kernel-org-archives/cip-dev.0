From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:42 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 37/51] pinctrl: sh-pfc: Move
	PIN_NONE to shared header file
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-38-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 4d1816cd6724dccc8e918f7181d2bd6a6ffb31b5 upstream.

Several drivers have identical definitions for PIN_NONE.
Provide a definition with a SH_PFC_ prefix for general use in sh_pfc.h,
and convert all drivers over to use it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 76 +++++++++++++--------------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 53 ++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 53 ++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 55 ++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 55 ++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 89 ++++++++++++++++----------------
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  2 +
 7 files changed, 189 insertions(+), 194 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 22700cd..82647d3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2929,8 +2929,6 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
-#define PIN_NONE	U16_MAX
-
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	{ PINMUX_BIAS_REG("PUPR0", 0x100, "N/A", 0) {
 		[ 0] = RCAR_GP_PIN(0,  6),	/* A0 */
@@ -2977,28 +2975,28 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 7] = RCAR_GP_PIN(1, 10),	/* DACK0	*/
 		[ 8] = RCAR_GP_PIN(1, 12),	/* IRQ0		*/
 		[ 9] = RCAR_GP_PIN(1, 13),	/* IRQ1		*/
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ PINMUX_BIAS_REG("PUPR2", 0x108, "N/A", 0) {
 		[ 0] = RCAR_GP_PIN(1, 22),	/* DU0_DR0	*/
@@ -3120,21 +3118,21 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[14] = RCAR_GP_PIN(4, 20),	/* ETH_MAGIC	*/
 		[15] = RCAR_GP_PIN(4, 25),	/* AVS1		*/
 		[16] = RCAR_GP_PIN(4, 26),	/* AVS2		*/
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index c77db750..d8404ca 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -1447,7 +1447,6 @@ static const u16 pinmux_data[] = {
 #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
 #define PIN_NUMBER(r, c) (((r) - 'A') * 39 + (c) + 300)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
-#define PIN_NONE U16_MAX
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
@@ -5604,7 +5603,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 5] = PIN_A_NUMBER('T', 27),	/* TCK */
 		[ 6] = PIN_A_NUMBER('R', 30),	/* TMS */
 		[ 7] = PIN_A_NUMBER('R', 29),	/* TDI */
-		[ 8] = PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
 		[ 9] = PIN_A_NUMBER('T', 30),	/* ASEBRK */
 		[10] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
 		[11] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
@@ -5705,31 +5704,31 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 4] = RCAR_GP_PIN(6, 29),	/* USB30_OVC */
 		[ 5] = RCAR_GP_PIN(6, 30),	/* USB31_PWEN */
 		[ 6] = RCAR_GP_PIN(6, 31),	/* USB31_OVC */
-		[ 7] = PIN_NONE,
-		[ 8] = PIN_NONE,
-		[ 9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[ 7] = SH_PFC_PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
+		[ 9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 0da9083..68c55ec 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -1508,7 +1508,6 @@ static const u16 pinmux_data[] = {
 #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
 #define PIN_NUMBER(r, c) (((r) - 'A') * 39 + (c) + 300)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
-#define PIN_NONE U16_MAX
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
@@ -5992,7 +5991,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 5] = PIN_A_NUMBER('T', 27),	/* TCK */
 		[ 6] = PIN_A_NUMBER('R', 30),	/* TMS */
 		[ 7] = PIN_A_NUMBER('R', 29),	/* TDI */
-		[ 8] = PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
 		[ 9] = PIN_A_NUMBER('T', 30),	/* ASEBRK */
 		[10] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
 		[11] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
@@ -6093,31 +6092,31 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 4] = RCAR_GP_PIN(6, 29),	/* USB30_OVC */
 		[ 5] = RCAR_GP_PIN(6, 30),	/* USB2_CH3_PWEN */
 		[ 6] = RCAR_GP_PIN(6, 31),	/* USB2_CH3_OVC */
-		[ 7] = PIN_NONE,
-		[ 8] = PIN_NONE,
-		[ 9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[ 7] = SH_PFC_PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
+		[ 9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 50af7a1..93e6bb4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -1524,7 +1524,6 @@ static const u16 pinmux_data[] = {
 #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
 #define PIN_NUMBER(r, c) (((r) - 'A') * 39 + (c) + 300)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
-#define PIN_NONE U16_MAX
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
@@ -5973,14 +5972,14 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	} },
 	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
 		[ 0] = PIN_A_NUMBER('R', 8),	/* DU_DOTCLKIN2 */
-		[ 1] = PIN_NONE,
+		[ 1] = SH_PFC_PIN_NONE,
 		[ 2] = PIN_A_NUMBER('D', 38),	/* FSCLKST */
 		[ 3] = PIN_A_NUMBER('D', 39),	/* EXTALR*/
 		[ 4] = PIN_A_NUMBER('R', 26),	/* TRST# */
 		[ 5] = PIN_A_NUMBER('T', 27),	/* TCK */
 		[ 6] = PIN_A_NUMBER('R', 30),	/* TMS */
 		[ 7] = PIN_A_NUMBER('R', 29),	/* TDI */
-		[ 8] = PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
 		[ 9] = PIN_A_NUMBER('T', 30),	/* ASEBRK */
 		[10] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
 		[11] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
@@ -6081,31 +6080,31 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 4] = RCAR_GP_PIN(6, 29),	/* USB30_OVC */
 		[ 5] = RCAR_GP_PIN(6, 30),	/* GP6_30 */
 		[ 6] = RCAR_GP_PIN(6, 31),	/* GP6_31 */
-		[ 7] = PIN_NONE,
-		[ 8] = PIN_NONE,
-		[ 9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[ 7] = SH_PFC_PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
+		[ 9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index b05a21a..96d45cb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1516,7 +1516,6 @@ static const u16 pinmux_data[] = {
 #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
 #define PIN_NUMBER(r, c) (((r) - 'A') * 39 + (c) + 300)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
-#define PIN_NONE U16_MAX
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
@@ -4953,14 +4952,14 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	} },
 	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
 		[ 0] = PIN_A_NUMBER('R', 8),	/* DU_DOTCLKIN2 */
-		[ 1] = PIN_NONE,
+		[ 1] = SH_PFC_PIN_NONE,
 		[ 2] = PIN_A_NUMBER('D', 38),	/* FSCLKST */
 		[ 3] = PIN_A_NUMBER('D', 39),	/* EXTALR*/
 		[ 4] = PIN_A_NUMBER('R', 26),	/* TRST# */
 		[ 5] = PIN_A_NUMBER('T', 27),	/* TCK */
 		[ 6] = PIN_A_NUMBER('R', 30),	/* TMS */
 		[ 7] = PIN_A_NUMBER('R', 29),	/* TDI */
-		[ 8] = PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
 		[ 9] = PIN_A_NUMBER('T', 30),	/* ASEBRK */
 		[10] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
 		[11] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
@@ -5061,31 +5060,31 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[ 4] = RCAR_GP_PIN(6, 29),	/* USB30_OVC */
 		[ 5] = RCAR_GP_PIN(6, 30),	/* GP6_30 */
 		[ 6] = RCAR_GP_PIN(6, 31),	/* GP6_31 */
-		[ 7] = PIN_NONE,
-		[ 8] = PIN_NONE,
-		[ 9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
-		[30] = PIN_NONE,
-		[31] = PIN_NONE,
+		[ 7] = SH_PFC_PIN_NONE,
+		[ 8] = SH_PFC_PIN_NONE,
+		[ 9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
+		[30] = SH_PFC_PIN_NONE,
+		[31] = SH_PFC_PIN_NONE,
 	} },
 	{ /* sentinel */ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 4db337a..1055ab9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1282,7 +1282,6 @@ static const u16 pinmux_data[] = {
 #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
 #define PIN_NUMBER(r, c) (((r) - 'A') * 25 + (c) + 300)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
-#define PIN_NONE U16_MAX
 
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
@@ -5084,8 +5083,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[25] = RCAR_GP_PIN(1,  2),	/* A2 */
 		[26] = RCAR_GP_PIN(1,  1),	/* A1 */
 		[27] = RCAR_GP_PIN(1,  0),	/* A0 */
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
 		[30] = RCAR_GP_PIN(2, 25),	/* PUEN_EX_WAIT0 */
 		[31] = RCAR_GP_PIN(2, 24),	/* PUEN_RD/WR# */
 	} },
@@ -5093,23 +5092,23 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		 [0] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
 		 [1] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
 		 [2] = PIN_NUMBER('H', 1),	/* ASEBRK */
-		 [3] = PIN_NONE,
+		 [3] = SH_PFC_PIN_NONE,
 		 [4] = PIN_NUMBER('G', 2),	/* TDI */
 		 [5] = PIN_NUMBER('F', 3),	/* TMS */
 		 [6] = PIN_NUMBER('F', 4),	/* TCK */
 		 [7] = PIN_NUMBER('F', 1),	/* TRST# */
-		 [8] = PIN_NONE,
-		 [9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
+		 [8] = SH_PFC_PIN_NONE,
+		 [9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
 		[15] = PIN_NUMBER('G', 3),	/* FSCLKST# */
 		[16] = RCAR_GP_PIN(0, 17),	/* SDA4 */
 		[17] = RCAR_GP_PIN(0, 16),	/* SCL4 */
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
 		[20] = PIN_A_NUMBER('D', 3),	/* PRESETOUT# */
 		[21] = RCAR_GP_PIN(0, 15),	/* D15 */
 		[22] = RCAR_GP_PIN(0, 14),	/* D14 */
@@ -5129,8 +5128,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		 [2] = RCAR_GP_PIN(5,  3),	/* CTS0#_A */
 		 [3] = RCAR_GP_PIN(5,  2),	/* TX0_A */
 		 [4] = RCAR_GP_PIN(5,  1),	/* RX0_A */
-		 [5] = PIN_NONE,
-		 [6] = PIN_NONE,
+		 [5] = SH_PFC_PIN_NONE,
+		 [6] = SH_PFC_PIN_NONE,
 		 [7] = RCAR_GP_PIN(3, 15),	/* SD1_WP */
 		 [8] = RCAR_GP_PIN(3, 14),	/* SD1_CD */
 		 [9] = RCAR_GP_PIN(3, 13),	/* SD0_WP */
@@ -5192,36 +5191,36 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[31] = RCAR_GP_PIN(5,  5),	/* RX1 */
 	} },
 	{ PINMUX_BIAS_REG("PUEN5", 0xe6060414, "PUD5", 0xe6060454) {
-		 [0] = PIN_NONE,
-		 [1] = PIN_NONE,
-		 [2] = PIN_NONE,
-		 [3] = PIN_NONE,
-		 [4] = PIN_NONE,
-		 [5] = PIN_NONE,
-		 [6] = PIN_NONE,
-		 [7] = PIN_NONE,
-		 [8] = PIN_NONE,
-		 [9] = PIN_NONE,
-		[10] = PIN_NONE,
-		[11] = PIN_NONE,
-		[12] = PIN_NONE,
-		[13] = PIN_NONE,
-		[14] = PIN_NONE,
-		[15] = PIN_NONE,
-		[16] = PIN_NONE,
-		[17] = PIN_NONE,
-		[18] = PIN_NONE,
-		[19] = PIN_NONE,
-		[20] = PIN_NONE,
-		[21] = PIN_NONE,
-		[22] = PIN_NONE,
-		[23] = PIN_NONE,
-		[24] = PIN_NONE,
-		[25] = PIN_NONE,
-		[26] = PIN_NONE,
-		[27] = PIN_NONE,
-		[28] = PIN_NONE,
-		[29] = PIN_NONE,
+		 [0] = SH_PFC_PIN_NONE,
+		 [1] = SH_PFC_PIN_NONE,
+		 [2] = SH_PFC_PIN_NONE,
+		 [3] = SH_PFC_PIN_NONE,
+		 [4] = SH_PFC_PIN_NONE,
+		 [5] = SH_PFC_PIN_NONE,
+		 [6] = SH_PFC_PIN_NONE,
+		 [7] = SH_PFC_PIN_NONE,
+		 [8] = SH_PFC_PIN_NONE,
+		 [9] = SH_PFC_PIN_NONE,
+		[10] = SH_PFC_PIN_NONE,
+		[11] = SH_PFC_PIN_NONE,
+		[12] = SH_PFC_PIN_NONE,
+		[13] = SH_PFC_PIN_NONE,
+		[14] = SH_PFC_PIN_NONE,
+		[15] = SH_PFC_PIN_NONE,
+		[16] = SH_PFC_PIN_NONE,
+		[17] = SH_PFC_PIN_NONE,
+		[18] = SH_PFC_PIN_NONE,
+		[19] = SH_PFC_PIN_NONE,
+		[20] = SH_PFC_PIN_NONE,
+		[21] = SH_PFC_PIN_NONE,
+		[22] = SH_PFC_PIN_NONE,
+		[23] = SH_PFC_PIN_NONE,
+		[24] = SH_PFC_PIN_NONE,
+		[25] = SH_PFC_PIN_NONE,
+		[26] = SH_PFC_PIN_NONE,
+		[27] = SH_PFC_PIN_NONE,
+		[28] = SH_PFC_PIN_NONE,
+		[29] = SH_PFC_PIN_NONE,
 		[30] = RCAR_GP_PIN(6,  9),	/* PUEN_USB30_OVC */
 		[31] = RCAR_GP_PIN(6, 17),	/* PUEN_USB30_PWEN */
 	} },
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 0b33108..c5bcb5e 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -24,6 +24,8 @@ enum {
 	PINMUX_TYPE_INPUT,
 };
 
+#define SH_PFC_PIN_NONE			U16_MAX
+
 #define SH_PFC_PIN_CFG_INPUT		(1 << 0)
 #define SH_PFC_PIN_CFG_OUTPUT		(1 << 1)
 #define SH_PFC_PIN_CFG_PULL_UP		(1 << 2)
-- 
2.7.4
