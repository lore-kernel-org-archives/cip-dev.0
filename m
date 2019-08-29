From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:12 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 07/51] pinctrl: sh-pfc: Absorb
	enum IDs in PINMUX_CFG_REG() macro
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit efca8da0c5fcc7f5617bab769faa595f7efdc593 upstream.

Currently the PINMUX_CFG_REG() macro must be followed by initialization
data, specifying all enum IDs.  Hence the macro itself does not know
anything about the enum IDs, preventing the macro from performing any
validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence the enum IDs are wrapped using a new macro
GROUPS().

No functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[fab: backported to 4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c     |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  16 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    |  24 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     |  28 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     |  24 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     |  32 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     |  48 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     |  28 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 104 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 108 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 108 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 108 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |  60 ++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |  68 +++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  92 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    |  84 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7203.c      | 124 +++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7264.c      | 184 ++++++++++++++--------------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c      | 204 +++++++++++++++----------------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  12 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c      |  72 +++++------
 drivers/pinctrl/sh-pfc/pfc-sh7722.c      | 128 +++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c      | 108 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c      | 112 ++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      |  43 ++++---
 drivers/pinctrl/sh-pfc/pfc-sh7757.c      | 140 ++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c      |  72 +++++------
 drivers/pinctrl/sh-pfc/pfc-sh7786.c      |  44 +++----
 drivers/pinctrl/sh-pfc/pfc-shx3.c        |  16 +--
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  14 ++-
 32 files changed, 1137 insertions(+), 1128 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c b/drivers/pinctrl/sh-pfc/pfc-emev2.c
index 1cbbe04..6151b44 100644
--- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
+++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
@@ -1416,7 +1416,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xe0140200, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe0140200, 32, 1, GROUP(
 		0, PORT31_FN,				/* PIN: J18  */
 		0, PORT30_FN,				/* PIN: H18  */
 		0, PORT29_FN,				/* PIN: G18  */
@@ -1449,9 +1449,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_JT_SEL, PORT2_FN,			/* PIN: V9   */
 		0, PORT1_FN,				/* PIN: U10  */
 		0, PORT0_FN,				/* PIN: V10  */
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe0140204, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe0140204, 32, 1, GROUP(
 		FN_SDI1_CMD, PORT63_FN,			/* PIN: AC21 */
 		FN_SDI1_CKI, PORT62_FN,			/* PIN: AA23 */
 		FN_SDI1_CKO, PORT61_FN,			/* PIN: AB22 */
@@ -1484,9 +1484,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD3_R2, PORT34_FN,			/* PIN: A19  */
 		FN_LCD3_R1, PORT33_FN,			/* PIN: B20  */
 		FN_LCD3_R0, PORT32_FN,			/* PIN: A20  */
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe0140208, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe0140208, 32, 1, GROUP(
 		FN_AB_1_0_PORT95, PORT95_FN,		/* PIN: L21  */
 		FN_AB_1_0_PORT94, PORT94_FN,		/* PIN: K21  */
 		FN_AB_1_0_PORT93, PORT93_FN,		/* PIN: J21  */
@@ -1519,9 +1519,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SDI1_DATA2, PORT66_FN,		/* PIN: AB19 */
 		FN_SDI1_DATA1, PORT65_FN,		/* PIN: AB20 */
 		FN_SDI1_DATA0, PORT64_FN,		/* PIN: AB21 */
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe014020c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe014020c, 32, 1, GROUP(
 		FN_NTSC_DATA4, PORT127_FN,		/* PIN: T20  */
 		FN_NTSC_DATA3, PORT126_FN,		/* PIN: R18  */
 		FN_NTSC_DATA2, PORT125_FN,		/* PIN: R20  */
@@ -1554,9 +1554,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_AB_9_8_PORT98, PORT98_FN,		/* PIN: M20  */
 		FN_AB_9_8_PORT97, PORT97_FN,		/* PIN: N21  */
 		FN_AB_A20, PORT96_FN,			/* PIN: M21  */
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe0140210, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe0140210, 32, 1, GROUP(
 		0, 0,
 		FN_UART_1_0_PORT158, PORT158_FN,	/* PIN: AB10 */
 		FN_UART_1_0_PORT157, PORT157_FN,	/* PIN: AA10 */
@@ -1589,7 +1589,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_NTSC_DATA7, PORT130_FN,		/* PIN: U18  */
 		FN_NTSC_DATA6, PORT129_FN,		/* PIN: U20  */
 		FN_NTSC_DATA5, PORT128_FN,		/* PIN: T18  */
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_LCD3", 0xe0140284, 32,
 			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index ff5655d..92b3cdf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2297,7 +2297,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(328, 0xe6053148),
 	PORTCR(329, 0xe6053149),
 
-	{ PINMUX_CFG_REG("MSEL1CR", 0xe605800c, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL1CR", 0xe605800c, 32, 1, GROUP(
 			MSEL1CR_31_0, MSEL1CR_31_1,
 			0, 0,
 			0, 0,
@@ -2330,9 +2330,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL1CR_02_0, MSEL1CR_02_1,
 			MSEL1CR_01_0, MSEL1CR_01_1,
 			MSEL1CR_00_0, MSEL1CR_00_1,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL3CR", 0xe6058020, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL3CR", 0xe6058020, 32, 1, GROUP(
 			MSEL3CR_31_0, MSEL3CR_31_1,
 			0, 0,
 			0, 0,
@@ -2365,9 +2365,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0,
 			MSEL3CR_01_0, MSEL3CR_01_1,
 			MSEL3CR_00_0, MSEL3CR_00_1,
-			}
+			))
 	},
-	{ PINMUX_CFG_REG("MSEL4CR", 0xe6058024, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL4CR", 0xe6058024, 32, 1, GROUP(
 			0, 0,
 			MSEL4CR_30_0, MSEL4CR_30_1,
 			MSEL4CR_29_0, MSEL4CR_29_1,
@@ -2400,9 +2400,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0,
 			MSEL4CR_01_0, MSEL4CR_01_1,
 			0, 0,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL5CR", 0xe6058028, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL5CR", 0xe6058028, 32, 1, GROUP(
 			MSEL5CR_31_0, MSEL5CR_31_1,
 			MSEL5CR_30_0, MSEL5CR_30_1,
 			MSEL5CR_29_0, MSEL5CR_29_1,
@@ -2435,9 +2435,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0,
 			0, 0,
 			0, 0,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL8CR", 0xe6058034, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL8CR", 0xe6058034, 32, 1, GROUP(
 			0, 0,
 			0, 0,
 			0, 0,
@@ -2470,7 +2470,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0,
 			MSEL8CR_01_0, MSEL8CR_01_1,
 			MSEL8CR_00_0, MSEL8CR_00_1,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 35f436b..4a372860 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3448,7 +3448,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(210,	0xe60530d2), /* PORT210CR */
 	PORTCR(211,	0xe60530d3), /* PORT211CR */
 
-	{ PINMUX_CFG_REG("MSEL1CR", 0xe605800c, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL1CR", 0xe605800c, 32, 1, GROUP(
 			MSEL1CR_31_0,	MSEL1CR_31_1,
 			MSEL1CR_30_0,	MSEL1CR_30_1,
 			MSEL1CR_29_0,	MSEL1CR_29_1,
@@ -3473,9 +3473,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL1CR_2_0,	MSEL1CR_2_1,
 			0, 0,
 			MSEL1CR_0_0,	MSEL1CR_0_1,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL3CR", 0xE6058020, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL3CR", 0xE6058020, 32, 1, GROUP(
 			0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0,
@@ -3486,9 +3486,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL3CR_6_0,	MSEL3CR_6_1,
 			0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0,
-			}
+			))
 	},
-	{ PINMUX_CFG_REG("MSEL4CR", 0xE6058024, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL4CR", 0xE6058024, 32, 1, GROUP(
 			0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0,
@@ -3505,9 +3505,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0, 0, 0,
 			MSEL4CR_1_0,	MSEL4CR_1_1,
 			0, 0,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL5CR", 0xE6058028, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL5CR", 0xE6058028, 32, 1, GROUP(
 			MSEL5CR_31_0,	MSEL5CR_31_1,
 			MSEL5CR_30_0,	MSEL5CR_30_1,
 			MSEL5CR_29_0,	MSEL5CR_29_1,
@@ -3540,7 +3540,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL5CR_2_0,	MSEL5CR_2_1,
 			0, 0,
 			MSEL5CR_0_0,	MSEL5CR_0_1,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index 9d3ed43..bad95b0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1482,7 +1482,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1514,9 +1514,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_USB1_OVC,
 		GP_0_2_FN, FN_USB1_PWEN,
 		GP_0_1_FN, FN_USB0_OVC,
-		GP_0_0_FN, FN_USB0_PWEN, }
+		GP_0_0_FN, FN_USB0_PWEN, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1548,9 +1548,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP1_23_20,
 		GP_1_2_FN, FN_IP1_19_16,
 		GP_1_1_FN, FN_IP1_15_12,
-		GP_1_0_FN, FN_IP1_11_8, }
+		GP_1_0_FN, FN_IP1_11_8, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP8_3_0,
 		GP_2_30_FN, FN_IP7_31_28,
 		GP_2_29_FN, FN_IP7_27_24,
@@ -1582,9 +1582,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP4_19_16,
 		GP_2_2_FN, FN_IP4_15_12,
 		GP_2_1_FN, FN_IP4_11_8,
-		GP_2_0_FN, FN_IP4_7_4, }
+		GP_2_0_FN, FN_IP4_7_4, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		GP_3_29_FN, FN_IP10_19_16,
@@ -1616,9 +1616,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP8_19_16,
 		GP_3_2_FN, FN_IP8_15_12,
 		GP_3_1_FN, FN_IP8_11_8,
-		GP_3_0_FN, FN_IP8_7_4, }
+		GP_3_0_FN, FN_IP8_7_4, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1650,9 +1650,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP11_3_0,
 		GP_4_2_FN, FN_IP10_31_28,
 		GP_4_1_FN, FN_IP10_27_24,
-		GP_4_0_FN, FN_IP10_23_20, }
+		GP_4_0_FN, FN_IP10_23_20, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		GP_5_31_FN, FN_IP17_27_24,
 		GP_5_30_FN, FN_IP17_23_20,
 		GP_5_29_FN, FN_IP17_19_16,
@@ -1684,7 +1684,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IP14_11_8,
 		GP_5_2_FN, FN_IP14_7_4,
 		GP_5_1_FN, FN_IP14_3_0,
-		GP_5_0_FN, FN_IP13_31_28, }
+		GP_5_0_FN, FN_IP13_31_28, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060040, 32,
 			     4, 4, 4, 4, 4, 4, 4, 4) {
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 00d61d1..5a1ab20 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2112,7 +2112,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xfffc0004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xfffc0004, 32, 1, GROUP(
 		GP_0_31_FN,	FN_IP1_14_11,
 		GP_0_30_FN,	FN_IP1_10_8,
 		GP_0_29_FN,	FN_IP1_7_5,
@@ -2144,9 +2144,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	FN_IP0_4_2,
 		GP_0_2_FN,	FN_PENC1,
 		GP_0_1_FN,	FN_PENC0,
-		GP_0_0_FN,	FN_IP0_1_0 }
+		GP_0_0_FN,	FN_IP0_1_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xfffc0008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xfffc0008, 32, 1, GROUP(
 		GP_1_31_FN,	FN_IP4_6_4,
 		GP_1_30_FN,	FN_IP4_3_1,
 		GP_1_29_FN,	FN_IP4_0,
@@ -2178,9 +2178,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	FN_IP1_27_25,
 		GP_1_2_FN,	FN_IP1_24,
 		GP_1_1_FN,	FN_WE0,
-		GP_1_0_FN,	FN_IP1_23_21 }
+		GP_1_0_FN,	FN_IP1_23_21 ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xfffc000c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xfffc000c, 32, 1, GROUP(
 		GP_2_31_FN,	FN_IP6_7,
 		GP_2_30_FN,	FN_IP6_6_5,
 		GP_2_29_FN,	FN_IP6_4_2,
@@ -2212,9 +2212,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	FN_IP4_12_11,
 		GP_2_2_FN,	FN_IP4_10_9,
 		GP_2_1_FN,	FN_IP4_8,
-		GP_2_0_FN,	FN_IP4_7 }
+		GP_2_0_FN,	FN_IP4_7 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xfffc0010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xfffc0010, 32, 1, GROUP(
 		GP_3_31_FN,	FN_IP8_10_9,
 		GP_3_30_FN,	FN_IP8_8_6,
 		GP_3_29_FN,	FN_IP8_5_3,
@@ -2246,9 +2246,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	FN_IP6_10,
 		GP_3_2_FN,	FN_SSI_SCK34,
 		GP_3_1_FN,	FN_IP6_9,
-		GP_3_0_FN,	FN_IP6_8 }
+		GP_3_0_FN,	FN_IP6_8 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xfffc0014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xfffc0014, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2280,7 +2280,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	FN_IP8_21_19,
 		GP_4_2_FN,	FN_IP8_18_16,
 		GP_4_1_FN,	FN_IP8_15_14,
-		GP_4_0_FN,	FN_IP8_13_11 }
+		GP_4_0_FN,	FN_IP8_13_11 ))
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xfffc0020, 32,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 5bef934..249e758 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -3048,7 +3048,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xfffc0004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xfffc0004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP3_31_29,
 		GP_0_30_FN, FN_IP3_26_24,
 		GP_0_29_FN, FN_IP3_22_21,
@@ -3080,9 +3080,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_A17,
 		GP_0_2_FN, FN_IP0_7_6,
 		GP_0_1_FN, FN_AVS2,
-		GP_0_0_FN, FN_AVS1 }
+		GP_0_0_FN, FN_AVS1 ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xfffc0008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xfffc0008, 32, 1, GROUP(
 		GP_1_31_FN, FN_IP5_23_21,
 		GP_1_30_FN, FN_IP5_20_17,
 		GP_1_29_FN, FN_IP5_16_15,
@@ -3114,9 +3114,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP4_10_8,
 		GP_1_2_FN, FN_IP4_7_5,
 		GP_1_1_FN, FN_IP4_4_2,
-		GP_1_0_FN, FN_IP4_1_0 }
+		GP_1_0_FN, FN_IP4_1_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xfffc000c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xfffc000c, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP10_28_26,
 		GP_2_30_FN, FN_IP10_25_24,
 		GP_2_29_FN, FN_IP10_23_21,
@@ -3148,9 +3148,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP8_24_23,
 		GP_2_2_FN, FN_IP8_22_21,
 		GP_2_1_FN, FN_IP8_20,
-		GP_2_0_FN, FN_IP5_27_24 }
+		GP_2_0_FN, FN_IP5_27_24 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xfffc0010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xfffc0010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP6_3_2,
 		GP_3_30_FN, FN_IP6_1_0,
 		GP_3_29_FN, FN_IP5_30_29,
@@ -3182,9 +3182,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP11_8_6,
 		GP_3_2_FN, FN_IP11_5_3,
 		GP_3_1_FN, FN_IP11_2_0,
-		GP_3_0_FN, FN_IP10_31_29 }
+		GP_3_0_FN, FN_IP10_31_29 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xfffc0014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xfffc0014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP8_19,
 		GP_4_30_FN, FN_IP8_18,
 		GP_4_29_FN, FN_IP8_17_16,
@@ -3216,9 +3216,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP6_11_9,
 		GP_4_2_FN, FN_IP6_8,
 		GP_4_1_FN, FN_IP6_7_6,
-		GP_4_0_FN, FN_IP6_5_4 }
+		GP_4_0_FN, FN_IP6_5_4 ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xfffc0018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xfffc0018, 32, 1, GROUP(
 		GP_5_31_FN, FN_IP3_5,
 		GP_5_30_FN, FN_IP3_4,
 		GP_5_29_FN, FN_IP3_3,
@@ -3250,9 +3250,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_A4,
 		GP_5_2_FN, FN_A3,
 		GP_5_1_FN, FN_A2,
-		GP_5_0_FN, FN_A1 }
+		GP_5_0_FN, FN_A1 ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xfffc001c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xfffc001c, 32, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -3267,7 +3267,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN, FN_IP3_15,
 		GP_6_2_FN, FN_IP3_8,
 		GP_6_1_FN, FN_IP3_7,
-		GP_6_0_FN, FN_IP3_6 }
+		GP_6_0_FN, FN_IP3_6 ))
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xfffc0020, 32,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index f6332f2..4c20966 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -4755,7 +4755,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP3_17_15,
 		GP_0_30_FN, FN_IP3_14_12,
 		GP_0_29_FN, FN_IP3_11_8,
@@ -4787,9 +4787,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP0_11_9,
 		GP_0_2_FN, FN_IP0_8_6,
 		GP_0_1_FN, FN_IP0_5_3,
-		GP_0_0_FN, FN_IP0_2_0 }
+		GP_0_0_FN, FN_IP0_2_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		GP_1_29_FN, FN_IP6_13_11,
@@ -4821,9 +4821,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP3_28_26,
 		GP_1_2_FN, FN_IP3_25_23,
 		GP_1_1_FN, FN_IP3_22_20,
-		GP_1_0_FN, FN_IP3_19_18, }
+		GP_1_0_FN, FN_IP3_19_18, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		GP_2_29_FN, FN_IP7_15_13,
@@ -4855,9 +4855,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP8_3_2,
 		GP_2_2_FN, FN_IP8_1_0,
 		GP_2_1_FN, FN_IP7_30_29,
-		GP_2_0_FN, FN_IP7_28_27 }
+		GP_2_0_FN, FN_IP7_28_27 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP11_21_18,
 		GP_3_30_FN, FN_IP11_17_15,
 		GP_3_29_FN, FN_IP11_14_13,
@@ -4889,9 +4889,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP9_3_2,
 		GP_3_2_FN, FN_IP9_1_0,
 		GP_3_1_FN, FN_IP8_30_29,
-		GP_3_0_FN, FN_IP8_28 }
+		GP_3_0_FN, FN_IP8_28 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP14_18_16,
 		GP_4_30_FN, FN_IP14_15_12,
 		GP_4_29_FN, FN_IP14_11_9,
@@ -4923,9 +4923,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP11_31_30,
 		GP_4_2_FN, FN_IP11_29_27,
 		GP_4_1_FN, FN_IP11_26_24,
-		GP_4_0_FN, FN_IP11_23_22 }
+		GP_4_0_FN, FN_IP11_23_22 ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		GP_5_31_FN, FN_IP7_24_22,
 		GP_5_30_FN, FN_IP7_21_19,
 		GP_5_29_FN, FN_IP7_18_16,
@@ -4957,7 +4957,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IP14_30_28,
 		GP_5_2_FN, FN_IP14_27_25,
 		GP_5_1_FN, FN_IP14_24_22,
-		GP_5_0_FN, FN_IP14_21_19 }
+		GP_5_0_FN, FN_IP14_21_19 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
 			     1, 4, 4, 3, 4, 4, 3, 3, 3, 3) {
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index c5144de..aab38d4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5434,7 +5434,7 @@ static const struct {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP1_22_20,
 		GP_0_30_FN, FN_IP1_19_17,
 		GP_0_29_FN, FN_IP1_16_14,
@@ -5466,9 +5466,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP0_3,
 		GP_0_2_FN, FN_IP0_2,
 		GP_0_1_FN, FN_IP0_1,
-		GP_0_0_FN, FN_IP0_0, }
+		GP_0_0_FN, FN_IP0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5500,9 +5500,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP2_2_0,
 		GP_1_2_FN, FN_IP1_31_29,
 		GP_1_1_FN, FN_IP1_28_26,
-		GP_1_0_FN, FN_IP1_25_23, }
+		GP_1_0_FN, FN_IP1_25_23, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP6_7_6,
 		GP_2_30_FN, FN_IP6_5_3,
 		GP_2_29_FN, FN_IP6_2_0,
@@ -5534,9 +5534,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP4_4_2,
 		GP_2_2_FN, FN_IP4_1_0,
 		GP_2_1_FN, FN_IP3_30_28,
-		GP_2_0_FN, FN_IP3_27_25 }
+		GP_2_0_FN, FN_IP3_27_25 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP9_18_17,
 		GP_3_30_FN, FN_IP9_16,
 		GP_3_29_FN, FN_IP9_15_13,
@@ -5568,9 +5568,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP7_12_11,
 		GP_3_2_FN, FN_IP7_10_9,
 		GP_3_1_FN, FN_IP7_8_6,
-		GP_3_0_FN, FN_IP7_5_3 }
+		GP_3_0_FN, FN_IP7_5_3 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP15_5_4,
 		GP_4_30_FN, FN_IP15_3_2,
 		GP_4_29_FN, FN_IP15_1_0,
@@ -5602,9 +5602,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP9_24_23,
 		GP_4_2_FN, FN_IP9_22_21,
 		GP_4_1_FN, FN_IP9_20_19,
-		GP_4_0_FN, FN_VI0_CLK }
+		GP_4_0_FN, FN_VI0_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		GP_5_31_FN, FN_IP3_24_22,
 		GP_5_30_FN, FN_IP13_9_7,
 		GP_5_29_FN, FN_IP13_6_5,
@@ -5636,9 +5636,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IP11_18_17,
 		GP_5_2_FN, FN_IP11_16_15,
 		GP_5_1_FN, FN_IP11_14_12,
-		GP_5_0_FN, FN_IP11_11_9 }
+		GP_5_0_FN, FN_IP11_11_9 ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1, GROUP(
 		GP_6_31_FN, FN_DU0_DOTCLKIN,
 		GP_6_30_FN, FN_USB1_OVC,
 		GP_6_29_FN, FN_IP14_31_29,
@@ -5670,9 +5670,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN, FN_IP13_13,
 		GP_6_2_FN, FN_IP13_12,
 		GP_6_1_FN, FN_IP13_11,
-		GP_6_0_FN, FN_IP13_10 }
+		GP_6_0_FN, FN_IP13_10 ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5704,7 +5704,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, FN_IP15_26_24,
 		GP_7_2_FN, FN_IP15_23_21,
 		GP_7_1_FN, FN_IP15_20_18,
-		GP_7_0_FN, FN_IP15_17_15 }
+		GP_7_0_FN, FN_IP15_17_15 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
 			     1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
index a3acfd6..300c76a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
@@ -1990,7 +1990,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2022,9 +2022,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP0_3,
 		GP_0_2_FN, FN_IP0_2,
 		GP_0_1_FN, FN_IP0_1,
-		GP_0_0_FN, FN_IP0_0 }
+		GP_0_0_FN, FN_IP0_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2056,9 +2056,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP1_8,
 		GP_1_2_FN, FN_IP1_7,
 		GP_1_1_FN, FN_IP1_6,
-		GP_1_0_FN, FN_IP1_5, }
+		GP_1_0_FN, FN_IP1_5, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_A15,
 		GP_2_30_FN, FN_A14,
 		GP_2_29_FN, FN_A13,
@@ -2090,9 +2090,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_D3,
 		GP_2_2_FN, FN_D2,
 		GP_2_1_FN, FN_D1,
-		GP_2_0_FN, FN_D0 }
+		GP_2_0_FN, FN_D0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2124,9 +2124,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_A19,
 		GP_3_2_FN, FN_A18,
 		GP_3_1_FN, FN_A17,
-		GP_3_0_FN, FN_A16 }
+		GP_3_0_FN, FN_A16 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2158,9 +2158,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_VI0_VSYNC_N,
 		GP_4_2_FN, FN_VI0_HSYNC_N,
 		GP_4_1_FN, FN_VI0_CLKENB,
-		GP_4_0_FN, FN_VI0_CLK }
+		GP_4_0_FN, FN_VI0_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2192,9 +2192,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_VI1_VSYNC_N,
 		GP_5_2_FN, FN_VI1_HSYNC_N,
 		GP_5_1_FN, FN_VI1_CLKENB,
-		GP_5_0_FN, FN_VI1_CLK }
+		GP_5_0_FN, FN_VI1_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2226,9 +2226,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN, FN_IP2_3,
 		GP_6_2_FN, FN_IP2_2,
 		GP_6_1_FN, FN_IP2_1,
-		GP_6_0_FN, FN_IP2_0 }
+		GP_6_0_FN, FN_IP2_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xE6060020, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xE6060020, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2260,9 +2260,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, FN_IP3_3,
 		GP_7_2_FN, FN_IP3_2,
 		GP_7_1_FN, FN_IP3_1,
-		GP_7_0_FN, FN_IP3_0 }
+		GP_7_0_FN, FN_IP3_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR8", 0xE6060024, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR8", 0xE6060024, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2294,9 +2294,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_8_3_FN, FN_IP4_3_2,
 		GP_8_2_FN, FN_IP4_1,
 		GP_8_1_FN, FN_IP4_0,
-		GP_8_0_FN, FN_VI4_CLK }
+		GP_8_0_FN, FN_VI4_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR9", 0xE6060028, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR9", 0xE6060028, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2328,9 +2328,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_9_3_FN, FN_IP5_2,
 		GP_9_2_FN, FN_IP5_1,
 		GP_9_1_FN, FN_IP5_0,
-		GP_9_0_FN, FN_VI5_CLK }
+		GP_9_0_FN, FN_VI5_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR10", 0xE606002C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR10", 0xE606002C, 32, 1, GROUP(
 		GP_10_31_FN, FN_CAN1_RX,
 		GP_10_30_FN, FN_CAN1_TX,
 		GP_10_29_FN, FN_CAN_CLK,
@@ -2362,9 +2362,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_10_3_FN, FN_IP6_2,
 		GP_10_2_FN, FN_HRTS0_N,
 		GP_10_1_FN, FN_IP6_1,
-		GP_10_0_FN, FN_IP6_0 }
+		GP_10_0_FN, FN_IP6_0 ))
 	},
-	{ PINMUX_CFG_REG("GPSR11", 0xE6060030, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR11", 0xE6060030, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		GP_11_29_FN, FN_AVS2,
@@ -2396,7 +2396,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_11_3_FN, FN_IP7_6,
 		GP_11_2_FN, FN_IP7_5_4,
 		GP_11_1_FN, FN_IP7_3_2,
-		GP_11_0_FN, FN_IP7_1_0 }
+		GP_11_0_FN, FN_IP7_1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060040, 32,
 			     4, 4,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index bbb1a37..923b7b2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4619,7 +4619,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP2_17_16,
 		GP_0_30_FN, FN_IP2_15_14,
 		GP_0_29_FN, FN_IP2_13_12,
@@ -4651,9 +4651,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP0_27_26,
 		GP_0_2_FN, FN_IP0_25,
 		GP_0_1_FN, FN_IP0_24,
-		GP_0_0_FN, FN_IP0_23_22, }
+		GP_0_0_FN, FN_IP0_23_22, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4685,9 +4685,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP2_29_27,
 		GP_1_2_FN, FN_IP2_26_24,
 		GP_1_1_FN, FN_IP2_23_21,
-		GP_1_0_FN, FN_IP2_20_18, }
+		GP_1_0_FN, FN_IP2_20_18, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP6_7_6,
 		GP_2_30_FN, FN_IP6_5_4,
 		GP_2_29_FN, FN_IP6_3_2,
@@ -4719,9 +4719,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP4_11_10,
 		GP_2_2_FN, FN_IP4_9_8,
 		GP_2_1_FN, FN_IP4_7_5,
-		GP_2_0_FN, FN_IP4_4_2 }
+		GP_2_0_FN, FN_IP4_4_2 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP8_22_20,
 		GP_3_30_FN, FN_IP8_19_17,
 		GP_3_29_FN, FN_IP8_16_15,
@@ -4753,9 +4753,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP6_11,
 		GP_3_2_FN, FN_IP6_10,
 		GP_3_1_FN, FN_IP6_9,
-		GP_3_0_FN, FN_IP6_8 }
+		GP_3_0_FN, FN_IP6_8 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP11_17_16,
 		GP_4_30_FN, FN_IP11_15_14,
 		GP_4_29_FN, FN_IP11_13_11,
@@ -4787,9 +4787,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP9_2_0,
 		GP_4_2_FN, FN_IP8_31_29,
 		GP_4_1_FN, FN_IP8_28_26,
-		GP_4_0_FN, FN_IP8_25_23 }
+		GP_4_0_FN, FN_IP8_25_23 ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4821,9 +4821,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IP11_29_27,
 		GP_5_2_FN, FN_IP11_26_24,
 		GP_5_1_FN, FN_IP11_23_21,
-		GP_5_0_FN, FN_IP11_20_18 }
+		GP_5_0_FN, FN_IP11_20_18 ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4855,7 +4855,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN, FN_SD0_DATA1,
 		GP_6_2_FN, FN_SD0_DATA0,
 		GP_6_1_FN, FN_SD0_CMD,
-		GP_6_0_FN, FN_SD0_CLK }
+		GP_6_0_FN, FN_SD0_CLK ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
 			     2, 2, 2, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index a6c5d50..2085f2b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -4695,7 +4695,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4727,9 +4727,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4761,9 +4761,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4795,9 +4795,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4829,9 +4829,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4863,9 +4863,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4897,9 +4897,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		GP_6_31_FN,	GPSR6_31,
 		GP_6_30_FN,	GPSR6_30,
 		GP_6_29_FN,	GPSR6_29,
@@ -4931,9 +4931,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4965,14 +4965,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, GPSR7_3,
 		GP_7_2_FN, GPSR7_2,
 		GP_7_1_FN, GPSR7_1,
-		GP_7_0_FN, GPSR7_0, }
+		GP_7_0_FN, GPSR7_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -4980,9 +4980,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -4990,9 +4990,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -5000,9 +5000,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -5010,9 +5010,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -5020,9 +5020,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -5030,9 +5030,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -5040,9 +5040,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -5050,9 +5050,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP7_15_12
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -5060,9 +5060,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -5070,9 +5070,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -5080,9 +5080,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -5090,9 +5090,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -5100,9 +5100,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		IP13_31_28
 		IP13_27_24
 		IP13_23_20
@@ -5110,9 +5110,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP13_15_12
 		IP13_11_8
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4, GROUP(
 		IP14_31_28
 		IP14_27_24
 		IP14_23_20
@@ -5120,9 +5120,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP14_15_12
 		IP14_11_8
 		IP14_7_4
-		IP14_3_0 }
+		IP14_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4, GROUP(
 		IP15_31_28
 		IP15_27_24
 		IP15_23_20
@@ -5130,9 +5130,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP15_15_12
 		IP15_11_8
 		IP15_7_4
-		IP15_3_0 }
+		IP15_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4, GROUP(
 		IP16_31_28
 		IP16_27_24
 		IP16_23_20
@@ -5140,9 +5140,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP16_15_12
 		IP16_11_8
 		IP16_7_4
-		IP16_3_0 }
+		IP16_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4, GROUP(
 		/* IP17_31_28 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP17_27_24 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP17_23_20 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -5150,7 +5150,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP17_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP17_11_8  */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP17_7_4
-		IP17_3_0 }
+		IP17_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 4f55b15..03b0a16 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5076,7 +5076,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5108,9 +5108,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5142,9 +5142,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5176,9 +5176,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5210,9 +5210,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5244,9 +5244,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5278,9 +5278,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		GP_6_31_FN,	GPSR6_31,
 		GP_6_30_FN,	GPSR6_30,
 		GP_6_29_FN,	GPSR6_29,
@@ -5312,9 +5312,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5346,14 +5346,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, GPSR7_3,
 		GP_7_2_FN, GPSR7_2,
 		GP_7_1_FN, GPSR7_1,
-		GP_7_0_FN, GPSR7_0, }
+		GP_7_0_FN, GPSR7_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -5361,9 +5361,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -5371,9 +5371,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -5381,9 +5381,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -5391,9 +5391,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -5401,9 +5401,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -5411,9 +5411,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -5421,9 +5421,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -5431,9 +5431,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -5441,9 +5441,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -5451,9 +5451,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -5461,9 +5461,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -5471,9 +5471,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -5481,9 +5481,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		IP13_31_28
 		IP13_27_24
 		IP13_23_20
@@ -5491,9 +5491,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP13_15_12
 		IP13_11_8
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4, GROUP(
 		IP14_31_28
 		IP14_27_24
 		IP14_23_20
@@ -5501,9 +5501,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP14_15_12
 		IP14_11_8
 		IP14_7_4
-		IP14_3_0 }
+		IP14_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4, GROUP(
 		IP15_31_28
 		IP15_27_24
 		IP15_23_20
@@ -5511,9 +5511,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP15_15_12
 		IP15_11_8
 		IP15_7_4
-		IP15_3_0 }
+		IP15_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4, GROUP(
 		IP16_31_28
 		IP16_27_24
 		IP16_23_20
@@ -5521,9 +5521,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP16_15_12
 		IP16_11_8
 		IP16_7_4
-		IP16_3_0 }
+		IP16_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4, GROUP(
 		IP17_31_28
 		IP17_27_24
 		IP17_23_20
@@ -5531,9 +5531,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP17_15_12
 		IP17_11_8
 		IP17_7_4
-		IP17_3_0 }
+		IP17_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4, GROUP(
 		/* IP18_31_28 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_27_24 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_23_20 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -5541,7 +5541,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP18_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_11_8  */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP18_7_4
-		IP18_3_0 }
+		IP18_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index aa378e4..f4e2dc2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -5033,7 +5033,7 @@ static const struct {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5065,9 +5065,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5099,9 +5099,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5133,9 +5133,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5167,9 +5167,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5201,9 +5201,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5235,9 +5235,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		GP_6_31_FN,	GPSR6_31,
 		GP_6_30_FN,	GPSR6_30,
 		GP_6_29_FN,	GPSR6_29,
@@ -5269,9 +5269,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5303,14 +5303,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, GPSR7_3,
 		GP_7_2_FN, GPSR7_2,
 		GP_7_1_FN, GPSR7_1,
-		GP_7_0_FN, GPSR7_0, }
+		GP_7_0_FN, GPSR7_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -5318,9 +5318,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -5328,9 +5328,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -5338,9 +5338,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -5348,9 +5348,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -5358,9 +5358,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -5368,9 +5368,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -5378,9 +5378,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -5388,9 +5388,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -5398,9 +5398,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -5408,9 +5408,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -5418,9 +5418,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -5428,9 +5428,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -5438,9 +5438,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		IP13_31_28
 		IP13_27_24
 		IP13_23_20
@@ -5448,9 +5448,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP13_15_12
 		IP13_11_8
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4, GROUP(
 		IP14_31_28
 		IP14_27_24
 		IP14_23_20
@@ -5458,9 +5458,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP14_15_12
 		IP14_11_8
 		IP14_7_4
-		IP14_3_0 }
+		IP14_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4, GROUP(
 		IP15_31_28
 		IP15_27_24
 		IP15_23_20
@@ -5468,9 +5468,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP15_15_12
 		IP15_11_8
 		IP15_7_4
-		IP15_3_0 }
+		IP15_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4, GROUP(
 		IP16_31_28
 		IP16_27_24
 		IP16_23_20
@@ -5478,9 +5478,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP16_15_12
 		IP16_11_8
 		IP16_7_4
-		IP16_3_0 }
+		IP16_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4, GROUP(
 		IP17_31_28
 		IP17_27_24
 		IP17_23_20
@@ -5488,9 +5488,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP17_15_12
 		IP17_11_8
 		IP17_7_4
-		IP17_3_0 }
+		IP17_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4, GROUP(
 		/* IP18_31_28 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_27_24 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_23_20 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -5498,7 +5498,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP18_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_11_8  */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP18_7_4
-		IP18_3_0 }
+		IP18_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index cfd7de6..e07f2a5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -4018,7 +4018,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4050,9 +4050,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4084,9 +4084,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4118,9 +4118,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4152,9 +4152,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4186,9 +4186,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4220,9 +4220,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		GP_6_31_FN,	GPSR6_31,
 		GP_6_30_FN,	GPSR6_30,
 		GP_6_29_FN,	GPSR6_29,
@@ -4254,9 +4254,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xe606011c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4288,14 +4288,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, GPSR7_3,
 		GP_7_2_FN, GPSR7_2,
 		GP_7_1_FN, GPSR7_1,
-		GP_7_0_FN, GPSR7_0, }
+		GP_7_0_FN, GPSR7_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -4303,9 +4303,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -4313,9 +4313,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -4323,9 +4323,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -4333,9 +4333,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -4343,9 +4343,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -4353,9 +4353,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -4363,9 +4363,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -4373,9 +4373,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -4383,9 +4383,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -4393,9 +4393,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -4403,9 +4403,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -4413,9 +4413,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -4423,9 +4423,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		IP13_31_28
 		IP13_27_24
 		IP13_23_20
@@ -4433,9 +4433,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP13_15_12
 		IP13_11_8
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4, GROUP(
 		IP14_31_28
 		IP14_27_24
 		IP14_23_20
@@ -4443,9 +4443,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP14_15_12
 		IP14_11_8
 		IP14_7_4
-		IP14_3_0 }
+		IP14_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4, GROUP(
 		IP15_31_28
 		IP15_27_24
 		IP15_23_20
@@ -4453,9 +4453,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP15_15_12
 		IP15_11_8
 		IP15_7_4
-		IP15_3_0 }
+		IP15_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR16", 0xe6060240, 32, 4, GROUP(
 		IP16_31_28
 		IP16_27_24
 		IP16_23_20
@@ -4463,9 +4463,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP16_15_12
 		IP16_11_8
 		IP16_7_4
-		IP16_3_0 }
+		IP16_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR17", 0xe6060244, 32, 4, GROUP(
 		IP17_31_28
 		IP17_27_24
 		IP17_23_20
@@ -4473,9 +4473,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP17_15_12
 		IP17_11_8
 		IP17_7_4
-		IP17_3_0 }
+		IP17_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR18", 0xe6060248, 32, 4, GROUP(
 		/* IP18_31_28 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_27_24 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_23_20 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -4483,7 +4483,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP18_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP18_11_8  */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP18_7_4
-		IP18_3_0 }
+		IP18_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index eeb58b3..f5265e0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -2049,7 +2049,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2081,9 +2081,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2115,9 +2115,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2149,9 +2149,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2183,9 +2183,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2217,9 +2217,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2251,14 +2251,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -2266,9 +2266,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -2276,9 +2276,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -2286,9 +2286,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -2296,9 +2296,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -2306,9 +2306,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -2316,9 +2316,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -2326,9 +2326,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -2336,9 +2336,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP7_15_12
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -2346,7 +2346,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 3f69673..904c506 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -2426,7 +2426,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2458,9 +2458,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2492,9 +2492,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		GP_2_29_FN,	GPSR2_29,
@@ -2526,9 +2526,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2560,9 +2560,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2594,9 +2594,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2628,14 +2628,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -2643,9 +2643,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -2653,9 +2653,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -2663,9 +2663,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -2673,9 +2673,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -2683,9 +2683,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -2693,9 +2693,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -2703,9 +2703,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -2713,9 +2713,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP7_15_12
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -2723,9 +2723,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -2733,9 +2733,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -2743,7 +2743,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 151640c..f72d97b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -4528,7 +4528,7 @@ static const struct {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4560,9 +4560,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4594,9 +4594,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4628,9 +4628,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4662,9 +4662,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4696,9 +4696,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4730,9 +4730,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -4764,14 +4764,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -4779,9 +4779,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -4789,9 +4789,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -4799,9 +4799,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -4809,9 +4809,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -4819,9 +4819,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -4829,9 +4829,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -4839,9 +4839,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -4849,9 +4849,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP7_15_12
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -4859,9 +4859,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -4869,9 +4869,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -4879,9 +4879,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -4889,9 +4889,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -4899,9 +4899,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		IP13_31_28
 		IP13_27_24
 		IP13_23_20
@@ -4909,9 +4909,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP13_15_12
 		IP13_11_8
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR14", 0xe6060238, 32, 4, GROUP(
 		IP14_31_28
 		IP14_27_24
 		IP14_23_20
@@ -4919,9 +4919,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP14_15_12
 		IP14_11_8
 		IP14_7_4
-		IP14_3_0 }
+		IP14_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR15", 0xe606023c, 32, 4, GROUP(
 		IP15_31_28
 		IP15_27_24
 		IP15_23_20
@@ -4929,7 +4929,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP15_15_12
 		IP15_11_8
 		IP15_7_4
-		IP15_3_0 }
+		IP15_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index adade5b..5baa948 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -2015,7 +2015,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	FN_##y
 #define FM(x)		FN_##x
-	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xe6060100, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2047,9 +2047,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN,	GPSR0_3,
 		GP_0_2_FN,	GPSR0_2,
 		GP_0_1_FN,	GPSR0_1,
-		GP_0_0_FN,	GPSR0_0, }
+		GP_0_0_FN,	GPSR0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xe6060104, 32, 1, GROUP(
 		GP_1_31_FN,	GPSR1_31,
 		GP_1_30_FN,	GPSR1_30,
 		GP_1_29_FN,	GPSR1_29,
@@ -2081,9 +2081,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN,	GPSR1_3,
 		GP_1_2_FN,	GPSR1_2,
 		GP_1_1_FN,	GPSR1_1,
-		GP_1_0_FN,	GPSR1_0, }
+		GP_1_0_FN,	GPSR1_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xe6060108, 32, 1, GROUP(
 		GP_2_31_FN,	GPSR2_31,
 		GP_2_30_FN,	GPSR2_30,
 		GP_2_29_FN,	GPSR2_29,
@@ -2115,9 +2115,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN,	GPSR2_3,
 		GP_2_2_FN,	GPSR2_2,
 		GP_2_1_FN,	GPSR2_1,
-		GP_2_0_FN,	GPSR2_0, }
+		GP_2_0_FN,	GPSR2_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xe606010c, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2149,9 +2149,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN,	GPSR3_3,
 		GP_3_2_FN,	GPSR3_2,
 		GP_3_1_FN,	GPSR3_1,
-		GP_3_0_FN,	GPSR3_0, }
+		GP_3_0_FN,	GPSR3_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xe6060110, 32, 1, GROUP(
 		GP_4_31_FN,	GPSR4_31,
 		GP_4_30_FN,	GPSR4_30,
 		GP_4_29_FN,	GPSR4_29,
@@ -2183,9 +2183,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN,	GPSR4_3,
 		GP_4_2_FN,	GPSR4_2,
 		GP_4_1_FN,	GPSR4_1,
-		GP_4_0_FN,	GPSR4_0, }
+		GP_4_0_FN,	GPSR4_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xe6060114, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2217,9 +2217,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN,	GPSR5_3,
 		GP_5_2_FN,	GPSR5_2,
 		GP_5_1_FN,	GPSR5_1,
-		GP_5_0_FN,	GPSR5_0, }
+		GP_5_0_FN,	GPSR5_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xe6060118, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2251,14 +2251,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN,	GPSR6_3,
 		GP_6_2_FN,	GPSR6_2,
 		GP_6_1_FN,	GPSR6_1,
-		GP_6_0_FN,	GPSR6_0, }
+		GP_6_0_FN,	GPSR6_0, ))
 	},
 #undef F_
 #undef FM
 
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
-	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR0", 0xe6060200, 32, 4, GROUP(
 		IP0_31_28
 		IP0_27_24
 		IP0_23_20
@@ -2266,9 +2266,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP0_15_12
 		IP0_11_8
 		IP0_7_4
-		IP0_3_0 }
+		IP0_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR1", 0xe6060204, 32, 4, GROUP(
 		IP1_31_28
 		IP1_27_24
 		IP1_23_20
@@ -2276,9 +2276,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP1_15_12
 		IP1_11_8
 		IP1_7_4
-		IP1_3_0 }
+		IP1_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR2", 0xe6060208, 32, 4, GROUP(
 		IP2_31_28
 		IP2_27_24
 		IP2_23_20
@@ -2286,9 +2286,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP2_15_12
 		IP2_11_8
 		IP2_7_4
-		IP2_3_0 }
+		IP2_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR3", 0xe606020c, 32, 4, GROUP(
 		IP3_31_28
 		IP3_27_24
 		IP3_23_20
@@ -2296,9 +2296,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP3_15_12
 		IP3_11_8
 		IP3_7_4
-		IP3_3_0 }
+		IP3_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR4", 0xe6060210, 32, 4, GROUP(
 		IP4_31_28
 		IP4_27_24
 		IP4_23_20
@@ -2306,9 +2306,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP4_15_12
 		IP4_11_8
 		IP4_7_4
-		IP4_3_0 }
+		IP4_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR5", 0xe6060214, 32, 4, GROUP(
 		IP5_31_28
 		IP5_27_24
 		IP5_23_20
@@ -2316,9 +2316,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP5_15_12
 		IP5_11_8
 		IP5_7_4
-		IP5_3_0 }
+		IP5_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR6", 0xe6060218, 32, 4, GROUP(
 		IP6_31_28
 		IP6_27_24
 		IP6_23_20
@@ -2326,9 +2326,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP6_15_12
 		IP6_11_8
 		IP6_7_4
-		IP6_3_0 }
+		IP6_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR7", 0xe606021c, 32, 4, GROUP(
 		IP7_31_28
 		IP7_27_24
 		IP7_23_20
@@ -2336,9 +2336,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP7_15_12
 		IP7_11_8
 		IP7_7_4
-		IP7_3_0 }
+		IP7_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR8", 0xe6060220, 32, 4, GROUP(
 		IP8_31_28
 		IP8_27_24
 		IP8_23_20
@@ -2346,9 +2346,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP8_15_12
 		IP8_11_8
 		IP8_7_4
-		IP8_3_0 }
+		IP8_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR9", 0xe6060224, 32, 4, GROUP(
 		IP9_31_28
 		IP9_27_24
 		IP9_23_20
@@ -2356,9 +2356,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP9_15_12
 		IP9_11_8
 		IP9_7_4
-		IP9_3_0 }
+		IP9_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR10", 0xe6060228, 32, 4, GROUP(
 		IP10_31_28
 		IP10_27_24
 		IP10_23_20
@@ -2366,9 +2366,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP10_15_12
 		IP10_11_8
 		IP10_7_4
-		IP10_3_0 }
+		IP10_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR11", 0xe606022c, 32, 4, GROUP(
 		IP11_31_28
 		IP11_27_24
 		IP11_23_20
@@ -2376,9 +2376,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP11_15_12
 		IP11_11_8
 		IP11_7_4
-		IP11_3_0 }
+		IP11_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR12", 0xe6060230, 32, 4, GROUP(
 		IP12_31_28
 		IP12_27_24
 		IP12_23_20
@@ -2386,9 +2386,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		IP12_15_12
 		IP12_11_8
 		IP12_7_4
-		IP12_3_0 }
+		IP12_3_0 ))
 	},
-	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4) {
+	{ PINMUX_CFG_REG("IPSR13", 0xe6060234, 32, 4, GROUP(
 		/* IP13_31_28 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP13_27_24 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP13_23_20 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2396,7 +2396,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP13_15_12 */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP13_11_8  */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		IP13_7_4
-		IP13_3_0 }
+		IP13_3_0 ))
 	},
 #undef F_
 #undef FM
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index 61b27ec..c64de8f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -1076,7 +1076,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PBIORL", 0xfffe3886, 16, 1) {
+	{ PINMUX_CFG_REG("PBIORL", 0xfffe3886, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1092,9 +1092,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0 }
+		0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCRL4", 0xfffe3890, 16, 4) {
+	{ PINMUX_CFG_REG("PBCRL4", 0xfffe3890, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1102,9 +1102,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB12MD_00, PB12MD_01, PB12MD_10, PB12MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCRL3", 0xfffe3892, 16, 4) {
+	{ PINMUX_CFG_REG("PBCRL3", 0xfffe3892, 16, 4, GROUP(
 		PB11MD_0, PB11MD_1,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1115,9 +1115,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB8MD_00, PB8MD_01, PB8MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCRL2", 0xfffe3894, 16, 4) {
+	{ PINMUX_CFG_REG("PBCRL2", 0xfffe3894, 16, 4, GROUP(
 		PB7MD_00, PB7MD_01, PB7MD_10, PB7MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1128,9 +1128,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB4MD_00, PB4MD_01, PB4MD_10, PB4MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCRL1", 0xfffe3896, 16, 4) {
+	{ PINMUX_CFG_REG("PBCRL1", 0xfffe3896, 16, 4, GROUP(
 		PB3MD_00, PB3MD_01, PB3MD_10, PB3MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1141,9 +1141,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB0MD_00, PB0MD_01, PB0MD_10, PB0MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("IFCR", 0xfffe38a2, 16, 4) {
+	{ PINMUX_CFG_REG("IFCR", 0xfffe38a2, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1151,9 +1151,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB12IRQ_00, PB12IRQ_01, PB12IRQ_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCIORL", 0xfffe3906, 16, 1) {
+	{ PINMUX_CFG_REG("PCIORL", 0xfffe3906, 16, 1, GROUP(
 		0, 0,
 		PC14_IN, PC14_OUT,
 		PC13_IN, PC13_OUT,
@@ -1169,9 +1169,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC3_IN, PC3_OUT,
 		PC2_IN, PC2_OUT,
 		PC1_IN, PC1_OUT,
-		PC0_IN, PC0_OUT }
+		PC0_IN, PC0_OUT ))
 	},
-	{ PINMUX_CFG_REG("PCCRL4", 0xfffe3910, 16, 4) {
+	{ PINMUX_CFG_REG("PCCRL4", 0xfffe3910, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC14MD_0, PC14MD_1,
@@ -1181,9 +1181,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC12MD_0, PC12MD_1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCRL3", 0xfffe3912, 16, 4) {
+	{ PINMUX_CFG_REG("PCCRL3", 0xfffe3912, 16, 4, GROUP(
 		PC11MD_00, PC11MD_01, PC11MD_10, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1194,9 +1194,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC8MD_0, PC8MD_1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCRL2", 0xfffe3914, 16, 4) {
+	{ PINMUX_CFG_REG("PCCRL2", 0xfffe3914, 16, 4, GROUP(
 		PC7MD_0, PC7MD_1,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1207,9 +1207,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC4MD_0, PC4MD_1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCRL1", 0xfffe3916, 16, 4) {
+	{ PINMUX_CFG_REG("PCCRL1", 0xfffe3916, 16, 4, GROUP(
 		PC3MD_0, PC3MD_1,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1220,9 +1220,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC0MD_00, PC0MD_01, PC0MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDIORL", 0xfffe3986, 16, 1) {
+	{ PINMUX_CFG_REG("PDIORL", 0xfffe3986, 16, 1, GROUP(
 		PD15_IN, PD15_OUT,
 		PD14_IN, PD14_OUT,
 		PD13_IN, PD13_OUT,
@@ -1238,9 +1238,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_IN, PD3_OUT,
 		PD2_IN, PD2_OUT,
 		PD1_IN, PD1_OUT,
-		PD0_IN, PD0_OUT }
+		PD0_IN, PD0_OUT ))
 	},
-	{ PINMUX_CFG_REG("PDCRL4", 0xfffe3990, 16, 4) {
+	{ PINMUX_CFG_REG("PDCRL4", 0xfffe3990, 16, 4, GROUP(
 		PD15MD_000, PD15MD_001, PD15MD_010, 0,
 		PD15MD_100, PD15MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1255,9 +1255,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PD12MD_000, PD12MD_001, PD12MD_010, 0,
 		PD12MD_100, PD12MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCRL3", 0xfffe3992, 16, 4) {
+	{ PINMUX_CFG_REG("PDCRL3", 0xfffe3992, 16, 4, GROUP(
 		PD11MD_000, PD11MD_001, PD11MD_010, 0,
 		PD11MD_100, PD11MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1272,9 +1272,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PD8MD_000, PD8MD_001, PD8MD_010, 0,
 		PD8MD_100, PD8MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCRL2", 0xfffe3994, 16, 4) {
+	{ PINMUX_CFG_REG("PDCRL2", 0xfffe3994, 16, 4, GROUP(
 		PD7MD_000, PD7MD_001, PD7MD_010, PD7MD_011,
 		PD7MD_100, PD7MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1289,9 +1289,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PD4MD_000, PD4MD_001, PD4MD_010, PD4MD_011,
 		PD4MD_100, PD4MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCRL1", 0xfffe3996, 16, 4) {
+	{ PINMUX_CFG_REG("PDCRL1", 0xfffe3996, 16, 4, GROUP(
 		PD3MD_000, PD3MD_001, PD3MD_010, PD3MD_011,
 		PD3MD_100, PD3MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1306,9 +1306,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PD0MD_000, PD0MD_001, PD0MD_010, PD0MD_011,
 		PD0MD_100, PD0MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PEIORL", 0xfffe3a06, 16, 1) {
+	{ PINMUX_CFG_REG("PEIORL", 0xfffe3a06, 16, 1, GROUP(
 		PE15_IN, PE15_OUT,
 		PE14_IN, PE14_OUT,
 		PE13_IN, PE13_OUT,
@@ -1324,9 +1324,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE3_IN, PE3_OUT,
 		PE2_IN, PE2_OUT,
 		PE1_IN, PE1_OUT,
-		PE0_IN, PE0_OUT }
+		PE0_IN, PE0_OUT ))
 	},
-	{ PINMUX_CFG_REG("PECRL4", 0xfffe3a10, 16, 4) {
+	{ PINMUX_CFG_REG("PECRL4", 0xfffe3a10, 16, 4, GROUP(
 		PE15MD_00, PE15MD_01, 0, PE15MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1337,9 +1337,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PE12MD_00, 0, 0, PE12MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECRL3", 0xfffe3a12, 16, 4) {
+	{ PINMUX_CFG_REG("PECRL3", 0xfffe3a12, 16, 4, GROUP(
 		PE11MD_000, PE11MD_001, PE11MD_010, 0,
 		PE11MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1352,9 +1352,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PE8MD_00, PE8MD_01, PE8MD_10, PE8MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECRL2", 0xfffe3a14, 16, 4) {
+	{ PINMUX_CFG_REG("PECRL2", 0xfffe3a14, 16, 4, GROUP(
 		PE7MD_000, PE7MD_001, PE7MD_010, PE7MD_011,
 		PE7MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1369,9 +1369,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PE4MD_000, PE4MD_001, PE4MD_010, PE4MD_011,
 		PE4MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECRL1", 0xfffe3a16, 16, 4) {
+	{ PINMUX_CFG_REG("PECRL1", 0xfffe3a16, 16, 4, GROUP(
 		PE3MD_00, PE3MD_01, 0, PE3MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1383,9 +1383,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PE0MD_000, PE0MD_001, 0, PE0MD_011,
 		PE0MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFIORH", 0xfffe3a84, 16, 1) {
+	{ PINMUX_CFG_REG("PFIORH", 0xfffe3a84, 16, 1, GROUP(
 		0, 0,
 		PF30_IN, PF30_OUT,
 		PF29_IN, PF29_OUT,
@@ -1401,9 +1401,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF19_IN, PF19_OUT,
 		PF18_IN, PF18_OUT,
 		PF17_IN, PF17_OUT,
-		PF16_IN, PF16_OUT }
+		PF16_IN, PF16_OUT ))
 	},
-	{ PINMUX_CFG_REG("PFIORL", 0xfffe3a86, 16, 1) {
+	{ PINMUX_CFG_REG("PFIORL", 0xfffe3a86, 16, 1, GROUP(
 		PF15_IN, PF15_OUT,
 		PF14_IN, PF14_OUT,
 		PF13_IN, PF13_OUT,
@@ -1419,9 +1419,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_IN, PF3_OUT,
 		PF2_IN, PF2_OUT,
 		PF1_IN, PF1_OUT,
-		PF0_IN, PF0_OUT }
+		PF0_IN, PF0_OUT ))
 	},
-	{ PINMUX_CFG_REG("PFCRH4", 0xfffe3a88, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRH4", 0xfffe3a88, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF30MD_0, PF30MD_1,
@@ -1431,9 +1431,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF28MD_0, PF28MD_1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRH3", 0xfffe3a8a, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRH3", 0xfffe3a8a, 16, 4, GROUP(
 		PF27MD_0, PF27MD_1,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1444,9 +1444,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF24MD_0, PF24MD_1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRH2", 0xfffe3a8c, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRH2", 0xfffe3a8c, 16, 4, GROUP(
 		PF23MD_00, PF23MD_01, PF23MD_10, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1457,9 +1457,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF20MD_00, PF20MD_01, PF20MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRH1", 0xfffe3a8e, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRH1", 0xfffe3a8e, 16, 4, GROUP(
 		PF19MD_00, PF19MD_01, PF19MD_10, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1470,9 +1470,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF16MD_00, PF16MD_01, PF16MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRL4", 0xfffe3a90, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRL4", 0xfffe3a90, 16, 4, GROUP(
 		PF15MD_00, PF15MD_01, PF15MD_10, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1483,9 +1483,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF12MD_00, PF12MD_01, PF12MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRL3", 0xfffe3a92, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRL3", 0xfffe3a92, 16, 4, GROUP(
 		PF11MD_00, PF11MD_01, PF11MD_10, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1496,9 +1496,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF8MD_00, PF8MD_01, PF8MD_10, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRL2", 0xfffe3a94, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRL2", 0xfffe3a94, 16, 4, GROUP(
 		PF7MD_00, PF7MD_01, PF7MD_10, PF7MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1509,9 +1509,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF4MD_00, PF4MD_01, PF4MD_10, PF4MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCRL1", 0xfffe3a96, 16, 4) {
+	{ PINMUX_CFG_REG("PFCRL1", 0xfffe3a96, 16, 4, GROUP(
 		PF3MD_00, PF3MD_01, PF3MD_10, PF3MD_11,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -1522,7 +1522,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF0MD_00, PF0MD_01, PF0MD_10, PF0MD_11,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 8070765..df952f6c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1469,17 +1469,17 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PAIOR0", 0xfffe3812, 16, 1) {
+	{ PINMUX_CFG_REG("PAIOR0", 0xfffe3812, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PA3_IN, PA3_OUT,
 		PA2_IN, PA2_OUT,
 		PA1_IN, PA1_OUT,
-		PA0_IN,	PA0_OUT }
+		PA0_IN,	PA0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PBCR5", 0xfffe3824, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR5", 0xfffe3824, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PB22MD_00, PB22MD_01, PB22MD_10, 0, 0, 0, 0, 0,
@@ -1487,10 +1487,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB21MD_0, PB21MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB20MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 
 	},
-	{ PINMUX_CFG_REG("PBCR4", 0xfffe3826, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR4", 0xfffe3826, 16, 4, GROUP(
 		0, PB19MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB18MD_01, 0, 0, 0, 0, 0, 0,
@@ -1498,9 +1498,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PB17MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB16MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR3", 0xfffe3828, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR3", 0xfffe3828, 16, 4, GROUP(
 		0, PB15MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB14MD_01, 0, 0, 0, 0, 0, 0,
@@ -1508,9 +1508,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PB13MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB12MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR2", 0xfffe382a, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR2", 0xfffe382a, 16, 4, GROUP(
 		0, PB11MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB10MD_01, 0, 0, 0, 0, 0, 0,
@@ -1518,9 +1518,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PB9MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB8MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR1", 0xfffe382c, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR1", 0xfffe382c, 16, 4, GROUP(
 		0, PB7MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB6MD_01, 0, 0, 0, 0, 0, 0,
@@ -1528,9 +1528,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PB5MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB4MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR0", 0xfffe382e, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR0", 0xfffe382e, 16, 4, GROUP(
 		0, PB3MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PB2MD_1, 0, 0, 0, 0, 0, 0,
@@ -1538,10 +1538,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PB1MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PBIOR1", 0xfffe3830, 16, 1) {
+	{ PINMUX_CFG_REG("PBIOR1", 0xfffe3830, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0,
@@ -1551,10 +1551,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB19_IN, PB19_OUT,
 		PB18_IN, PB18_OUT,
 		PB17_IN, PB17_OUT,
-		PB16_IN, PB16_OUT }
+		PB16_IN, PB16_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PBIOR0", 0xfffe3832, 16, 1) {
+	{ PINMUX_CFG_REG("PBIOR0", 0xfffe3832, 16, 1, GROUP(
 		PB15_IN, PB15_OUT,
 		PB14_IN, PB14_OUT,
 		PB13_IN, PB13_OUT,
@@ -1570,10 +1570,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB3_IN, PB3_OUT,
 		PB2_IN, PB2_OUT,
 		PB1_IN, PB1_OUT,
-		0, 0 }
+		0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PCCR2", 0xfffe384a, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR2", 0xfffe384a, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC10MD_0, PC10MD_1, 0, 0, 0, 0, 0, 0,
@@ -1581,9 +1581,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC9MD_0, PC9MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC8MD_00, PC8MD_01, PC8MD_10, PC8MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR1", 0xfffe384c, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR1", 0xfffe384c, 16, 4, GROUP(
 		PC7MD_00, PC7MD_01, PC7MD_10, PC7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC6MD_00, PC6MD_01, PC6MD_10, PC6MD_11, 0, 0, 0, 0,
@@ -1591,9 +1591,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC5MD_00, PC5MD_01, PC5MD_10, PC5MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC4MD_0, PC4MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR0", 0xfffe384e, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR0", 0xfffe384e, 16, 4, GROUP(
 		PC3MD_0, PC3MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC2MD_0, PC2MD_1, 0, 0, 0, 0, 0, 0,
@@ -1601,10 +1601,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC1MD_0, PC1MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PC0MD_0, PC0MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1) {
+	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PC10_IN, PC10_OUT,
 		PC9_IN, PC9_OUT,
@@ -1617,10 +1617,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC2_IN, PC2_OUT,
 		PC1_IN, PC1_OUT,
 		PC0_IN, PC0_OUT
-	 }
+	 ))
 	},
 
-	{ PINMUX_CFG_REG("PDCR3", 0xfffe3868, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR3", 0xfffe3868, 16, 4, GROUP(
 		0, PD15MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD14MD_01, 0, 0, 0, 0, 0, 0,
@@ -1628,9 +1628,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PD13MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD12MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR2", 0xfffe386a, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR2", 0xfffe386a, 16, 4, GROUP(
 		0, PD11MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD10MD_01, 0, 0, 0, 0, 0, 0,
@@ -1638,9 +1638,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PD9MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD8MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR1", 0xfffe386c, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR1", 0xfffe386c, 16, 4, GROUP(
 		0, PD7MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD6MD_01, 0, 0, 0, 0, 0, 0,
@@ -1648,9 +1648,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PD5MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD4MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR0", 0xfffe386e, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR0", 0xfffe386e, 16, 4, GROUP(
 		0, PD3MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD2MD_01, 0, 0, 0, 0, 0, 0,
@@ -1658,10 +1658,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, PD1MD_01, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, PD0MD_01, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PDIOR0", 0xfffe3872, 16, 1) {
+	{ PINMUX_CFG_REG("PDIOR0", 0xfffe3872, 16, 1, GROUP(
 		PD15_IN, PD15_OUT,
 		PD14_IN, PD14_OUT,
 		PD13_IN, PD13_OUT,
@@ -1677,10 +1677,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_IN, PD3_OUT,
 		PD2_IN, PD2_OUT,
 		PD1_IN, PD1_OUT,
-		PD0_IN, PD0_OUT }
+		PD0_IN, PD0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PECR1", 0xfffe388c, 16, 4) {
+	{ PINMUX_CFG_REG("PECR1", 0xfffe388c, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1688,10 +1688,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE5MD_00, PE5MD_01, 0, PE5MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PE4MD_00, PE4MD_01, 0, PE4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PECR0", 0xfffe388e, 16, 4) {
+	{ PINMUX_CFG_REG("PECR0", 0xfffe388e, 16, 4, GROUP(
 		PE3MD_00, PE3MD_01, 0, PE3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PE2MD_00, PE2MD_01, 0, PE2MD_11, 0, 0, 0, 0,
@@ -1700,10 +1700,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE1MD_100, PE1MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PE0MD_00, PE0MD_01, PE0MD_10, PE0MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PEIOR0", 0xfffe3892, 16, 1) {
+	{ PINMUX_CFG_REG("PEIOR0", 0xfffe3892, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1712,16 +1712,16 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE3_IN, PE3_OUT,
 		PE2_IN, PE2_OUT,
 		PE1_IN, PE1_OUT,
-		PE0_IN, PE0_OUT }
+		PE0_IN, PE0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4, GROUP(
 		PF12MD_000, PF12MD_001, 0, PF12MD_011,
 		PF12MD_100, PF12MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PFCR2", 0xfffe38aa, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR2", 0xfffe38aa, 16, 4, GROUP(
 		PF11MD_000, PF11MD_001, PF11MD_010, PF11MD_011,
 		PF11MD_100, PF11MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1732,10 +1732,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF9MD_100, PF9MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF8MD_00, PF8MD_01, PF8MD_10, PF8MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PFCR1", 0xfffe38ac, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR1", 0xfffe38ac, 16, 4, GROUP(
 		PF7MD_000, PF7MD_001, PF7MD_010, PF7MD_011,
 		PF7MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1747,10 +1747,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF4MD_000, PF4MD_001, PF4MD_010, PF4MD_011,
 		PF4MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PFCR0", 0xfffe38ae, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR0", 0xfffe38ae, 16, 4, GROUP(
 		PF3MD_000, PF3MD_001, PF3MD_010, PF3MD_011,
 		PF3MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1759,11 +1759,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF1MD_000, PF1MD_001, PF1MD_010, PF1MD_011,
 		PF1MD_100, PF1MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	 }
 	},
 
-	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1) {
+	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0,
 		PF12_IN, PF12_OUT,
 		PF11_IN, PF11_OUT,
@@ -1777,10 +1777,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_IN, PF3_OUT,
 		PF2_IN, PF2_OUT,
 		PF1_IN, PF1_OUT,
-		PF0_IN, PF0_OUT }
+		PF0_IN, PF0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR7", 0xfffe38c0, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR7", 0xfffe38c0, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1789,10 +1789,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG0MD_000, PG0MD_001, PG0MD_010, PG0MD_011,
 		PG0MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR6", 0xfffe38c2, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR6", 0xfffe38c2, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1800,10 +1800,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG24MD_00, PG24MD_01, PG24MD_10, PG24MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR5", 0xfffe38c4, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR5", 0xfffe38c4, 16, 4, GROUP(
 		PG23MD_00, PG23MD_01, PG23MD_10, PG23MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG22MD_00, PG22MD_01, PG22MD_10, PG22MD_11, 0, 0, 0, 0,
@@ -1812,10 +1812,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG20MD_000, PG20MD_001, PG20MD_010, PG20MD_011,
 		PG20MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR4", 0xfffe38c6, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR4", 0xfffe38c6, 16, 4, GROUP(
 		PG19MD_000, PG19MD_001, PG19MD_010, PG19MD_011,
 		PG19MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1827,10 +1827,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG16MD_000, PG16MD_001, PG16MD_010, PG16MD_011,
 		PG16MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR3", 0xfffe38c8, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR3", 0xfffe38c8, 16, 4, GROUP(
 		PG15MD_000, PG15MD_001, PG15MD_010, PG15MD_011,
 		PG15MD_100, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1842,9 +1842,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG12MD_000, PG12MD_001, PG12MD_010, 0,
 		PG12MD_100, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR2", 0xfffe38ca, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR2", 0xfffe38ca, 16, 4, GROUP(
 		PG11MD_000, PG11MD_001, PG11MD_010, PG11MD_011,
 		PG11MD_100, PG11MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1856,10 +1856,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG8MD_000, PG8MD_001, PG8MD_010, PG8MD_011,
 		PG8MD_100, PG8MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR1", 0xfffe38cc, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR1", 0xfffe38cc, 16, 4, GROUP(
 		PG7MD_00, PG7MD_01, PG7MD_10, PG7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG6MD_00, PG6MD_01, PG6MD_10, PG6MD_11, 0, 0, 0, 0,
@@ -1867,9 +1867,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG5MD_00, PG5MD_01, PG5MD_10, PG5MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG4MD_00, PG4MD_01, PG4MD_10, PG4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR0", 0xfffe38ce, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR0", 0xfffe38ce, 16, 4, GROUP(
 		PG3MD_00, PG3MD_01, PG3MD_10, PG3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG2MD_00, PG2MD_01, PG2MD_10, PG2MD_11, 0, 0, 0, 0,
@@ -1877,9 +1877,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG1MD_00, PG1MD_01, PG1MD_10, PG1MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGIOR1", 0xfffe38d0, 16, 1) {
+	{ PINMUX_CFG_REG("PGIOR1", 0xfffe38d0, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0,
 		PG24_IN, PG24_OUT,
@@ -1890,10 +1890,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG19_IN, PG19_OUT,
 		PG18_IN, PG18_OUT,
 		PG17_IN, PG17_OUT,
-		PG16_IN, PG16_OUT }
+		PG16_IN, PG16_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PGIOR0", 0xfffe38d2, 16, 1) {
+	{ PINMUX_CFG_REG("PGIOR0", 0xfffe38d2, 16, 1, GROUP(
 		PG15_IN, PG15_OUT,
 		PG14_IN, PG14_OUT,
 		PG13_IN, PG13_OUT,
@@ -1910,10 +1910,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG2_IN, PG2_OUT,
 		PG1_IN, PG1_OUT,
 		PG0_IN, PG0_OUT
-	 }
+	 ))
 	},
 
-	{ PINMUX_CFG_REG("PHCR1", 0xfffe38ec, 16, 4) {
+	{ PINMUX_CFG_REG("PHCR1", 0xfffe38ec, 16, 4, GROUP(
 		PH7MD_0, PH7MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PH6MD_0, PH6MD_1, 0, 0, 0, 0, 0, 0,
@@ -1921,10 +1921,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PH5MD_0, PH5MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PH4MD_0, PH4MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PHCR0", 0xfffe38ee, 16, 4) {
+	{ PINMUX_CFG_REG("PHCR0", 0xfffe38ee, 16, 4, GROUP(
 		PH3MD_0, PH3MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PH2MD_0, PH2MD_1, 0, 0, 0, 0, 0, 0,
@@ -1932,10 +1932,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PH1MD_0, PH1MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PH0MD_0, PH0MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PJCR2", 0xfffe390a, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR2", 0xfffe390a, 16, 4, GROUP(
 		PJ11MD_00, PJ11MD_01, PJ11MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ10MD_00, PJ10MD_01, PJ10MD_10, 0, 0, 0, 0, 0,
@@ -1943,9 +1943,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ9MD_00, PJ9MD_01, PJ9MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ8MD_00, PJ8MD_01, PJ8MD_10, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR1", 0xfffe390c, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR1", 0xfffe390c, 16, 4, GROUP(
 		PJ7MD_00, PJ7MD_01, PJ7MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ6MD_00, PJ6MD_01, PJ6MD_10, 0, 0, 0, 0, 0,
@@ -1953,9 +1953,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ5MD_00, PJ5MD_01, PJ5MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ4MD_00, PJ4MD_01, PJ4MD_10, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR0", 0xfffe390e, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR0", 0xfffe390e, 16, 4, GROUP(
 		PJ3MD_00, PJ3MD_01, PJ3MD_10, PJ3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ2MD_000, PJ2MD_001, PJ2MD_010, PJ2MD_011,
@@ -1966,9 +1966,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ0MD_000, PJ0MD_001, PJ0MD_010, PJ0MD_011,
 		PJ0MD_100, PJ0MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PJIOR0", 0xfffe3912, 16, 1) {
+	{ PINMUX_CFG_REG("PJIOR0", 0xfffe3912, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ11_IN, PJ11_OUT,
 		PJ10_IN, PJ10_OUT,
@@ -1981,10 +1981,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ3_IN, PJ3_OUT,
 		PJ2_IN, PJ2_OUT,
 		PJ1_IN, PJ1_OUT,
-		PJ0_IN, PJ0_OUT }
+		PJ0_IN, PJ0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PKCR2", 0xfffe392a, 16, 4) {
+	{ PINMUX_CFG_REG("PKCR2", 0xfffe392a, 16, 4, GROUP(
 		PK11MD_00, PK11MD_01, PK11MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK10MD_00, PK10MD_01, PK10MD_10, 0, 0, 0, 0, 0,
@@ -1992,10 +1992,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PK9MD_00, PK9MD_01, PK9MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK8MD_00, PK8MD_01, PK8MD_10, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PKCR1", 0xfffe392c, 16, 4) {
+	{ PINMUX_CFG_REG("PKCR1", 0xfffe392c, 16, 4, GROUP(
 		PK7MD_00, PK7MD_01, PK7MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK6MD_00, PK6MD_01, PK6MD_10, 0,  0, 0, 0, 0,
@@ -2003,9 +2003,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PK5MD_00, PK5MD_01, PK5MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK4MD_00, PK4MD_01, PK4MD_10, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PKCR0", 0xfffe392e, 16, 4) {
+	{ PINMUX_CFG_REG("PKCR0", 0xfffe392e, 16, 4, GROUP(
 		PK3MD_00, PK3MD_01, PK3MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK2MD_00, PK2MD_01, PK2MD_10, 0, 0, 0, 0, 0,
@@ -2013,10 +2013,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PK1MD_00, PK1MD_01, PK1MD_10, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PK0MD_00, PK0MD_01, PK0MD_10, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PKIOR0", 0xfffe3932, 16, 1) {
+	{ PINMUX_CFG_REG("PKIOR0", 0xfffe3932, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PJ11_IN, PJ11_OUT,
 		PJ10_IN, PJ10_OUT,
@@ -2029,7 +2029,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ3_IN, PJ3_OUT,
 		PJ2_IN, PJ2_OUT,
 		PJ1_IN, PJ1_OUT,
-		PJ0_IN, PJ0_OUT }
+		PJ0_IN, PJ0_OUT ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index a50d22b..69409c9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -1954,13 +1954,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	/* where Field_Width is 1 for single mode registers or 4 for upto 16
 	   mode registers and modes are described in assending order [0..16] */
 
-	{ PINMUX_CFG_REG("PAIOR0", 0xfffe3812, 16, 1) {
+	{ PINMUX_CFG_REG("PAIOR0", 0xfffe3812, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, PA1_IN, PA1_OUT,
 		0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, PA0_IN, PA0_OUT }
+		0, 0, 0, 0, 0, 0, PA0_IN, PA0_OUT ))
 	},
-	{ PINMUX_CFG_REG("PBCR5", 0xfffe3824, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR5", 0xfffe3824, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB22MD_000, PB22MD_001, PB22MD_010, PB22MD_011,
@@ -1972,9 +1972,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PB20MD_000, PB20MD_001, PB20MD_010, PB20MD_011,
 		PB20MD_100, PB20MD_101, PB20MD_110, PB20MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR4", 0xfffe3826, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR4", 0xfffe3826, 16, 4, GROUP(
 		PB19MD_000, PB19MD_001, PB19MD_010, PB19MD_011,
 		PB19MD_100, PB19MD_101, PB19MD_110, PB19MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1989,9 +1989,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PB16MD_000, PB16MD_001, PB16MD_010, PB16MD_011,
 		PB16MD_100, PB16MD_101, PB16MD_110, PB16MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR3", 0xfffe3828, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR3", 0xfffe3828, 16, 4, GROUP(
 		PB15MD_000, PB15MD_001, PB15MD_010, PB15MD_011,
 		PB15MD_100, PB15MD_101, PB15MD_110, PB15MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2005,9 +2005,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB12MD_00, PB12MD_01, PB12MD_10, PB12MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR2", 0xfffe382a, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR2", 0xfffe382a, 16, 4, GROUP(
 		PB11MD_00, PB11MD_01, PB11MD_10, PB11MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2018,9 +2018,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB8MD_00, PB8MD_01, PB8MD_10, PB8MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR1", 0xfffe382c, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR1", 0xfffe382c, 16, 4, GROUP(
 		PB7MD_00, PB7MD_01, PB7MD_10, PB7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2031,9 +2031,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PB4MD_00, PB4MD_01, PB4MD_10, PB4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR0", 0xfffe382e, 16, 4) {
+	{ PINMUX_CFG_REG("PBCR0", 0xfffe382e, 16, 4, GROUP(
 		PB3MD_00, PB3MD_01, PB3MD_10, PB3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2043,10 +2043,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB1MD_00, PB1MD_01, PB1MD_10, PB1MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PBIOR1", 0xfffe3830, 16, 1) {
+	{ PINMUX_CFG_REG("PBIOR1", 0xfffe3830, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0,
@@ -2056,9 +2056,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB19_IN, PB19_OUT,
 		PB18_IN, PB18_OUT,
 		PB17_IN, PB17_OUT,
-		PB16_IN, PB16_OUT }
+		PB16_IN, PB16_OUT ))
 	},
-	{ PINMUX_CFG_REG("PBIOR0", 0xfffe3832, 16, 1) {
+	{ PINMUX_CFG_REG("PBIOR0", 0xfffe3832, 16, 1, GROUP(
 		PB15_IN, PB15_OUT,
 		PB14_IN, PB14_OUT,
 		PB13_IN, PB13_OUT,
@@ -2074,10 +2074,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB3_IN, PB3_OUT,
 		PB2_IN, PB2_OUT,
 		PB1_IN, PB1_OUT,
-		0, 0 }
+		0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PCCR2", 0xfffe384a, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR2", 0xfffe384a, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2086,9 +2086,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PC8MD_000, PC8MD_001, PC8MD_010, PC8MD_011,
 		PC8MD_100, PC8MD_101, PC8MD_110, PC8MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR1", 0xfffe384c, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR1", 0xfffe384c, 16, 4, GROUP(
 		PC7MD_000, PC7MD_001, PC7MD_010, PC7MD_011,
 		PC7MD_100, PC7MD_101, PC7MD_110, PC7MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2102,9 +2102,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC4MD_00, PC4MD_01, PC4MD_10, PC4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR0", 0xfffe384e, 16, 4) {
+	{ PINMUX_CFG_REG("PCCR0", 0xfffe384e, 16, 4, GROUP(
 		PC3MD_00, PC3MD_01, PC3MD_10, PC3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2115,10 +2115,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PC0MD_0, PC0MD_1, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1) {
+	{ PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PC8_IN, PC8_OUT,
 		PC7_IN, PC7_OUT,
@@ -2128,10 +2128,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC3_IN, PC3_OUT,
 		PC2_IN, PC2_OUT,
 		PC1_IN, PC1_OUT,
-		PC0_IN, PC0_OUT }
+		PC0_IN, PC0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PDCR3", 0xfffe3868, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR3", 0xfffe3868, 16, 4, GROUP(
 		PD15MD_00, PD15MD_01, PD15MD_10, PD15MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2142,9 +2142,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PD12MD_00, PD12MD_01, PD12MD_10, PD12MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR2", 0xfffe386a, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR2", 0xfffe386a, 16, 4, GROUP(
 		PD11MD_00, PD11MD_01, PD11MD_10, PD11MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2155,9 +2155,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PD8MD_00, PD8MD_01, PD8MD_10, PD8MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR1", 0xfffe386c, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR1", 0xfffe386c, 16, 4, GROUP(
 		PD7MD_00, PD7MD_01, PD7MD_10, PD7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2168,9 +2168,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PD4MD_00, PD4MD_01, PD4MD_10, PD4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR0", 0xfffe386e, 16, 4) {
+	{ PINMUX_CFG_REG("PDCR0", 0xfffe386e, 16, 4, GROUP(
 		PD3MD_00, PD3MD_01, PD3MD_10, PD3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2181,10 +2181,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PD0MD_00, PD0MD_01, PD0MD_10, PD0MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PDIOR0", 0xfffe3872, 16, 1) {
+	{ PINMUX_CFG_REG("PDIOR0", 0xfffe3872, 16, 1, GROUP(
 		PD15_IN, PD15_OUT,
 		PD14_IN, PD14_OUT,
 		PD13_IN, PD13_OUT,
@@ -2200,10 +2200,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_IN, PD3_OUT,
 		PD2_IN, PD2_OUT,
 		PD1_IN, PD1_OUT,
-		PD0_IN, PD0_OUT }
+		PD0_IN, PD0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PECR1", 0xfffe388c, 16, 4) {
+	{ PINMUX_CFG_REG("PECR1", 0xfffe388c, 16, 4, GROUP(
 		PE7MD_00, PE7MD_01, PE7MD_10, PE7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2214,9 +2214,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PE4MD_00, PE4MD_01, PE4MD_10, PE4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECR0", 0xfffe388e, 16, 4) {
+	{ PINMUX_CFG_REG("PECR0", 0xfffe388e, 16, 4, GROUP(
 		PE3MD_000, PE3MD_001, PE3MD_010, PE3MD_011,
 		PE3MD_100, PE3MD_101, PE3MD_110, PE3MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2230,9 +2230,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PE0MD_00, PE0MD_01, PE0MD_10, PE0MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PEIOR0", 0xfffe3892, 16, 1) {
+	{ PINMUX_CFG_REG("PEIOR0", 0xfffe3892, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PE7_IN, PE7_OUT,
@@ -2242,10 +2242,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE3_IN, PE3_OUT,
 		PE2_IN, PE2_OUT,
 		PE1_IN, PE1_OUT,
-		PE0_IN, PE0_OUT }
+		PE0_IN, PE0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PFCR6", 0xfffe38a2, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR6", 0xfffe38a2, 16, 4, GROUP(
 		PF23MD_000, PF23MD_001, PF23MD_010, PF23MD_011,
 		PF23MD_100, PF23MD_101, PF23MD_110, PF23MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2260,9 +2260,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF20MD_000, PF20MD_001, PF20MD_010, PF20MD_011,
 		PF20MD_100, PF20MD_101, PF20MD_110, PF20MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR5", 0xfffe38a4, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR5", 0xfffe38a4, 16, 4, GROUP(
 		PF19MD_000, PF19MD_001, PF19MD_010, PF19MD_011,
 		PF19MD_100, PF19MD_101, PF19MD_110, PF19MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2277,9 +2277,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF16MD_000, PF16MD_001, PF16MD_010, PF16MD_011,
 		PF16MD_100, PF16MD_101, PF16MD_110, PF16MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR4", 0xfffe38a6, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR4", 0xfffe38a6, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2288,9 +2288,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF15MD_000, PF15MD_001, PF15MD_010, PF15MD_011,
 		PF15MD_100, PF15MD_101, PF15MD_110, PF15MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 
 		PF14MD_000, PF14MD_001, PF14MD_010, PF14MD_011,
@@ -2303,9 +2303,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF12MD_000, PF12MD_001, PF12MD_010, PF12MD_011,
 		PF12MD_100, PF12MD_101, PF12MD_110, PF12MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR2", 0xfffe38aa, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR2", 0xfffe38aa, 16, 4, GROUP(
 		PF11MD_000, PF11MD_001, PF11MD_010, PF11MD_011,
 		PF11MD_100, PF11MD_101, PF11MD_110, PF11MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2320,9 +2320,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF8MD_000, PF8MD_001, PF8MD_010, PF8MD_011,
 		PF8MD_100, PF8MD_101, PF8MD_110, PF8MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR1", 0xfffe38ac, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR1", 0xfffe38ac, 16, 4, GROUP(
 		PF7MD_000, PF7MD_001, PF7MD_010, PF7MD_011,
 		PF7MD_100, PF7MD_101, PF7MD_110, PF7MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2337,9 +2337,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF4MD_000, PF4MD_001, PF4MD_010, PF4MD_011,
 		PF4MD_100, PF4MD_101, PF4MD_110, PF4MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR0", 0xfffe38ae, 16, 4) {
+	{ PINMUX_CFG_REG("PFCR0", 0xfffe38ae, 16, 4, GROUP(
 		PF3MD_000, PF3MD_001, PF3MD_010, PF3MD_011,
 		PF3MD_100, PF3MD_101, PF3MD_110, PF3MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2354,10 +2354,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PF0MD_000, PF0MD_001, PF0MD_010, PF0MD_011,
 		PF0MD_100, PF0MD_101, PF0MD_110, PF0MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PFIOR1", 0xfffe38b0, 16, 1) {
+	{ PINMUX_CFG_REG("PFIOR1", 0xfffe38b0, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF23_IN, PF23_OUT,
@@ -2367,9 +2367,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF19_IN, PF19_OUT,
 		PF18_IN, PF18_OUT,
 		PF17_IN, PF17_OUT,
-		PF16_IN, PF16_OUT }
+		PF16_IN, PF16_OUT ))
 	},
-	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1) {
+	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1, GROUP(
 		PF15_IN, PF15_OUT,
 		PF14_IN, PF14_OUT,
 		PF13_IN, PF13_OUT,
@@ -2385,10 +2385,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_IN, PF3_OUT,
 		PF2_IN, PF2_OUT,
 		PF1_IN, PF1_OUT,
-		PF0_IN, PF0_OUT }
+		PF0_IN, PF0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR6", 0xfffe38c2, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR6", 0xfffe38c2, 16, 4, GROUP(
 		PG27MD_00, PG27MD_01, PG27MD_10, PG27MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2399,9 +2399,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PG24MD_00, PG24MD_01, PG24MD_10, PG24MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR5", 0xfffe38c4, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR5", 0xfffe38c4, 16, 4, GROUP(
 		PG23MD_000, PG23MD_001, PG23MD_010, PG23MD_011,
 		PG23MD_100, PG23MD_101, PG23MD_110, PG23MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2416,9 +2416,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PG20MD_000, PG20MD_001, PG20MD_010, PG20MD_011,
 		PG20MD_100, PG20MD_101, PG20MD_110, PG20MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR4", 0xfffe38c6, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR4", 0xfffe38c6, 16, 4, GROUP(
 		PG19MD_000, PG19MD_001, PG19MD_010, PG19MD_011,
 		PG19MD_100, PG19MD_101, PG19MD_110, PG19MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2431,9 +2431,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PG16MD_00, PG16MD_01, PG16MD_10, PG16MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR3", 0xfffe38c8, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR3", 0xfffe38c8, 16, 4, GROUP(
 		PG15MD_00, PG15MD_01, PG15MD_10, PG15MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2444,9 +2444,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PG12MD_00, PG12MD_01, PG12MD_10, PG12MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR2", 0xfffe38ca, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR2", 0xfffe38ca, 16, 4, GROUP(
 		PG11MD_000, PG11MD_001, PG11MD_010, PG11MD_011,
 		PG11MD_100, PG11MD_101, PG11MD_110, PG11MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2461,10 +2461,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PG8MD_000, PG8MD_001, PG8MD_010, PG8MD_011,
 		PG8MD_100, PG8MD_101, PG8MD_110, PG8MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGCR1", 0xfffe38cc, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR1", 0xfffe38cc, 16, 4, GROUP(
 		PG7MD_000, PG7MD_001, PG7MD_010, PG7MD_011,
 		PG7MD_100, PG7MD_101, PG7MD_110, PG7MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2479,9 +2479,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PG4MD_000, PG4MD_001, PG4MD_010, PG4MD_011,
 		PG4MD_100, PG4MD_101, PG4MD_110, PG4MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR0", 0xfffe38ce, 16, 4) {
+	{ PINMUX_CFG_REG("PGCR0", 0xfffe38ce, 16, 4, GROUP(
 		PG3MD_000, PG3MD_001, PG3MD_010, PG3MD_011,
 		PG3MD_100, PG3MD_101, PG3MD_110, PG3MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2496,10 +2496,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PG0MD_000, PG0MD_001, PG0MD_010, PG0MD_011,
 		PG0MD_100, PG0MD_101, PG0MD_110, PG0MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PGIOR1", 0xfffe38d0, 16, 1) {
+	{ PINMUX_CFG_REG("PGIOR1", 0xfffe38d0, 16, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PG27_IN, PG27_OUT,
 		PG26_IN, PG26_OUT,
@@ -2512,9 +2512,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG19_IN, PG19_OUT,
 		PG18_IN, PG18_OUT,
 		PG17_IN, PG17_OUT,
-		PG16_IN, PG16_OUT }
+		PG16_IN, PG16_OUT ))
 	},
-	{ PINMUX_CFG_REG("PGIOR0", 0xfffe38d2, 16, 1) {
+	{ PINMUX_CFG_REG("PGIOR0", 0xfffe38d2, 16, 1, GROUP(
 		PG15_IN, PG15_OUT,
 		PG14_IN, PG14_OUT,
 		PG13_IN, PG13_OUT,
@@ -2530,10 +2530,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG3_IN, PG3_OUT,
 		PG2_IN, PG2_OUT,
 		PG1_IN, PG1_OUT,
-		PG0_IN, PG0_OUT }
+		PG0_IN, PG0_OUT ))
 	},
 
-	{ PINMUX_CFG_REG("PHCR1", 0xfffe38ec, 16, 4) {
+	{ PINMUX_CFG_REG("PHCR1", 0xfffe38ec, 16, 4, GROUP(
 		PH7MD_00, PH7MD_01, PH7MD_10, PH7MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2544,10 +2544,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PH4MD_00, PH4MD_01, PH4MD_10, PH4MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PHCR0", 0xfffe38ee, 16, 4) {
+	{ PINMUX_CFG_REG("PHCR0", 0xfffe38ee, 16, 4, GROUP(
 		PH3MD_00, PH3MD_01, PH3MD_10, PH3MD_11, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2558,10 +2558,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 
 		PH0MD_00, PH0MD_01, PH0MD_10, PH0MD_11, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PJCR7", 0xfffe3900, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR7", 0xfffe3900, 16, 4, GROUP(
 		PJ31MD_0, PJ31MD_1, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
 
@@ -2575,9 +2575,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ28MD_000, PJ28MD_001, PJ28MD_010, PJ28MD_011,
 		PJ28MD_100, PJ28MD_101, PJ28MD_110, PJ28MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR6", 0xfffe3902, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR6", 0xfffe3902, 16, 4, GROUP(
 		PJ27MD_000, PJ27MD_001, PJ27MD_010, PJ27MD_011,
 		PJ27MD_100, PJ27MD_101, PJ27MD_110, PJ27MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2592,9 +2592,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ24MD_000, PJ24MD_001, PJ24MD_010, PJ24MD_011,
 		PJ24MD_100, PJ24MD_101, PJ24MD_110, PJ24MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR5", 0xfffe3904, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR5", 0xfffe3904, 16, 4, GROUP(
 		PJ23MD_000, PJ23MD_001, PJ23MD_010, PJ23MD_011,
 		PJ23MD_100, PJ23MD_101, PJ23MD_110, PJ23MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2609,9 +2609,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ20MD_000, PJ20MD_001, PJ20MD_010, PJ20MD_011,
 		PJ20MD_100, PJ20MD_101, PJ20MD_110, PJ20MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR4", 0xfffe3906, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR4", 0xfffe3906, 16, 4, GROUP(
 		PJ19MD_000, PJ19MD_001, PJ19MD_010, PJ19MD_011,
 		PJ19MD_100, PJ19MD_101, PJ19MD_110, PJ19MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2626,9 +2626,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ16MD_000, PJ16MD_001, PJ16MD_010, PJ16MD_011,
 		PJ16MD_100, PJ16MD_101, PJ16MD_110, PJ16MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR3", 0xfffe3908, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR3", 0xfffe3908, 16, 4, GROUP(
 		PJ15MD_000, PJ15MD_001, PJ15MD_010, PJ15MD_011,
 		PJ15MD_100, PJ15MD_101, PJ15MD_110, PJ15MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2643,9 +2643,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ12MD_000, PJ12MD_001, PJ12MD_010, PJ12MD_011,
 		PJ12MD_100, PJ12MD_101, PJ12MD_110, PJ12MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR2", 0xfffe390a, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR2", 0xfffe390a, 16, 4, GROUP(
 		PJ11MD_000, PJ11MD_001, PJ11MD_010, PJ11MD_011,
 		PJ11MD_100, PJ11MD_101, PJ11MD_110, PJ11MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2660,9 +2660,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ8MD_000, PJ8MD_001, PJ8MD_010, PJ8MD_011,
 		PJ8MD_100, PJ8MD_101, PJ8MD_110, PJ8MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR1", 0xfffe390c, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR1", 0xfffe390c, 16, 4, GROUP(
 		PJ7MD_000, PJ7MD_001, PJ7MD_010, PJ7MD_011,
 		PJ7MD_100, PJ7MD_101, PJ7MD_110, PJ7MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2677,9 +2677,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ4MD_000, PJ4MD_001, PJ4MD_010, PJ4MD_011,
 		PJ4MD_100, PJ4MD_101, PJ4MD_110, PJ4MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR0", 0xfffe390e, 16, 4) {
+	{ PINMUX_CFG_REG("PJCR0", 0xfffe390e, 16, 4, GROUP(
 		PJ3MD_000, PJ3MD_001, PJ3MD_010, PJ3MD_011,
 		PJ3MD_100, PJ3MD_101, PJ3MD_110, PJ3MD_111,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -2694,10 +2694,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 		PJ0MD_000, PJ0MD_001, PJ0MD_010, PJ0MD_011,
 		PJ0MD_100, PJ0MD_101, PJ0MD_110, PJ0MD_111,
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PJIOR1", 0xfffe3910, 16, 1) {
+	{ PINMUX_CFG_REG("PJIOR1", 0xfffe3910, 16, 1, GROUP(
 		PJ31_IN, PJ31_OUT,
 		PJ30_IN, PJ30_OUT,
 		PJ29_IN, PJ29_OUT,
@@ -2713,9 +2713,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ19_IN, PJ19_OUT,
 		PJ18_IN, PJ18_OUT,
 		PJ17_IN, PJ17_OUT,
-		PJ16_IN, PJ16_OUT }
+		PJ16_IN, PJ16_OUT ))
 	},
-	{ PINMUX_CFG_REG("PJIOR0", 0xfffe3912, 16, 1) {
+	{ PINMUX_CFG_REG("PJIOR0", 0xfffe3912, 16, 1, GROUP(
 		PJ15_IN, PJ15_OUT,
 		PJ14_IN, PJ14_OUT,
 		PJ13_IN, PJ13_OUT,
@@ -2731,7 +2731,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ3_IN, PJ3_OUT,
 		PJ2_IN, PJ2_OUT,
 		PJ1_IN, PJ1_OUT,
-		PJ0_IN, PJ0_OUT }
+		PJ0_IN, PJ0_OUT ))
 	},
 
 	{}
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index d25e6f6..69da689 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3982,7 +3982,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(308, 0xe6052134), /* PORT308CR */
 	PORTCR(309, 0xe6052135), /* PORT309CR */
 
-	{ PINMUX_CFG_REG("MSEL2CR", 0xe605801c, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL2CR", 0xe605801c, 32, 1, GROUP(
 			0, 0,
 			0, 0,
 			0, 0,
@@ -4015,9 +4015,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL2CR_MSEL2_0, MSEL2CR_MSEL2_1,
 			MSEL2CR_MSEL1_0, MSEL2CR_MSEL1_1,
 			MSEL2CR_MSEL0_0, MSEL2CR_MSEL0_1,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL3CR", 0xe6058020, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL3CR", 0xe6058020, 32, 1, GROUP(
 			0, 0,
 			0, 0,
 			0, 0,
@@ -4050,9 +4050,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			MSEL3CR_MSEL2_0, MSEL3CR_MSEL2_1,
 			0, 0,
 			0, 0,
-		}
+		))
 	},
-	{ PINMUX_CFG_REG("MSEL4CR", 0xe6058024, 32, 1) {
+	{ PINMUX_CFG_REG("MSEL4CR", 0xe6058024, 32, 1, GROUP(
 			0, 0,
 			0, 0,
 			MSEL4CR_MSEL29_0, MSEL4CR_MSEL29_1,
@@ -4085,7 +4085,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0,
 			MSEL4CR_MSEL1_0, MSEL4CR_MSEL1_1,
 			0, 0,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index e07a82d..ce00198 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -928,7 +928,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2, GROUP(
 		PTA7_FN, PTA7_OUT, 0, PTA7_IN,
 		PTA6_FN, PTA6_OUT, 0, PTA6_IN,
 		PTA5_FN, PTA5_OUT, 0, PTA5_IN,
@@ -936,9 +936,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTA3_FN, PTA3_OUT, 0, PTA3_IN,
 		PTA2_FN, PTA2_OUT, 0, PTA2_IN,
 		PTA1_FN, PTA1_OUT, 0, PTA1_IN,
-		PTA0_FN, PTA0_OUT, 0, PTA0_IN }
+		PTA0_FN, PTA0_OUT, 0, PTA0_IN ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2, GROUP(
 		PTB7_FN, PTB7_OUT, 0, PTB7_IN,
 		PTB6_FN, PTB6_OUT, 0, PTB6_IN,
 		PTB5_FN, PTB5_OUT, 0, PTB5_IN,
@@ -946,9 +946,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTB3_FN, PTB3_OUT, 0, PTB3_IN,
 		PTB2_FN, PTB2_OUT, 0, PTB2_IN,
 		PTB1_FN, PTB1_OUT, 0, PTB1_IN,
-		PTB0_FN, PTB0_OUT, 0, PTB0_IN }
+		PTB0_FN, PTB0_OUT, 0, PTB0_IN ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2, GROUP(
 		PTC7_FN, PTC7_OUT, 0, PTC7_IN,
 		PTC6_FN, PTC6_OUT, 0, PTC6_IN,
 		PTC5_FN, PTC5_OUT, 0, PTC5_IN,
@@ -956,9 +956,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTC3_FN, PTC3_OUT, 0, PTC3_IN,
 		PTC2_FN, PTC2_OUT, 0, PTC2_IN,
 		PTC1_FN, PTC1_OUT, 0, PTC1_IN,
-		PTC0_FN, PTC0_OUT, 0, PTC0_IN }
+		PTC0_FN, PTC0_OUT, 0, PTC0_IN ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2, GROUP(
 		PTD7_FN, PTD7_OUT, 0, PTD7_IN,
 		PTD6_FN, PTD6_OUT, 0, PTD6_IN,
 		PTD5_FN, PTD5_OUT, 0, PTD5_IN,
@@ -966,9 +966,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTD3_FN, PTD3_OUT, 0, PTD3_IN,
 		PTD2_FN, PTD2_OUT, 0, PTD2_IN,
 		PTD1_FN, PTD1_OUT, 0, PTD1_IN,
-		PTD0_FN, PTD0_OUT, 0, PTD0_IN }
+		PTD0_FN, PTD0_OUT, 0, PTD0_IN ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTE6_FN, 0, 0, PTE6_IN,
 		PTE5_FN, 0, 0, PTE5_IN,
@@ -976,9 +976,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTE3_FN, PTE3_OUT, 0, PTE3_IN,
 		PTE2_FN, PTE2_OUT, 0, PTE2_IN,
 		PTE1_FN, PTE1_OUT, 0, PTE1_IN,
-		PTE0_FN, PTE0_OUT, 0, PTE0_IN }
+		PTE0_FN, PTE0_OUT, 0, PTE0_IN ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTF6_FN, 0, 0, PTF6_IN,
 		PTF5_FN, 0, 0, PTF5_IN,
@@ -986,9 +986,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTF3_FN, 0, 0, PTF3_IN,
 		PTF2_FN, 0, 0, PTF2_IN,
 		PTF1_FN, 0, 0, PTF1_IN,
-		PTF0_FN, 0, 0, PTF0_IN }
+		PTF0_FN, 0, 0, PTF0_IN ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTG6_FN, PTG6_OUT, 0, PTG6_IN,
 		PTG5_FN, PTG5_OUT, 0, PTG5_IN,
@@ -996,9 +996,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTG3_FN, PTG3_OUT, 0, PTG3_IN,
 		PTG2_FN, PTG2_OUT, 0, PTG2_IN,
 		PTG1_FN, PTG1_OUT, 0, PTG1_IN,
-		PTG0_FN, PTG0_OUT, 0, PTG0_IN }
+		PTG0_FN, PTG0_OUT, 0, PTG0_IN ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTH6_FN, PTH6_OUT, 0, PTH6_IN,
 		PTH5_FN, PTH5_OUT, 0, PTH5_IN,
@@ -1006,9 +1006,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTH3_FN, PTH3_OUT, 0, PTH3_IN,
 		PTH2_FN, PTH2_OUT, 0, PTH2_IN,
 		PTH1_FN, PTH1_OUT, 0, PTH1_IN,
-		PTH0_FN, PTH0_OUT, 0, PTH0_IN }
+		PTH0_FN, PTH0_OUT, 0, PTH0_IN ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTJ6_FN, PTJ6_OUT, 0, PTJ6_IN,
 		PTJ5_FN, PTJ5_OUT, 0, PTJ5_IN,
@@ -1016,9 +1016,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTJ3_FN, PTJ3_OUT, 0, PTJ3_IN,
 		PTJ2_FN, PTJ2_OUT, 0, PTJ2_IN,
 		PTJ1_FN, PTJ1_OUT, 0, PTJ1_IN,
-		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN }
+		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1026,9 +1026,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTK3_FN, PTK3_OUT, 0, PTK3_IN,
 		PTK2_FN, PTK2_OUT, 0, PTK2_IN,
 		PTK1_FN, PTK1_OUT, 0, PTK1_IN,
-		PTK0_FN, PTK0_OUT, 0, PTK0_IN }
+		PTK0_FN, PTK0_OUT, 0, PTK0_IN ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2, GROUP(
 		PTL7_FN, PTL7_OUT, 0, PTL7_IN,
 		PTL6_FN, PTL6_OUT, 0, PTL6_IN,
 		PTL5_FN, PTL5_OUT, 0, PTL5_IN,
@@ -1036,9 +1036,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTL3_FN, PTL3_OUT, 0, PTL3_IN,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2, GROUP(
 		PTM7_FN, PTM7_OUT, 0, PTM7_IN,
 		PTM6_FN, PTM6_OUT, 0, PTM6_IN,
 		PTM5_FN, PTM5_OUT, 0, PTM5_IN,
@@ -1046,9 +1046,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTM3_FN, PTM3_OUT, 0, PTM3_IN,
 		PTM2_FN, PTM2_OUT, 0, PTM2_IN,
 		PTM1_FN, PTM1_OUT, 0, PTM1_IN,
-		PTM0_FN, PTM0_OUT, 0, PTM0_IN }
+		PTM0_FN, PTM0_OUT, 0, PTM0_IN ))
 	},
-	{ PINMUX_CFG_REG("PPCR", 0xa4050118, 16, 2) {
+	{ PINMUX_CFG_REG("PPCR", 0xa4050118, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1056,9 +1056,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTP3_FN, PTP3_OUT, 0, PTP3_IN,
 		PTP2_FN, PTP2_OUT, 0, PTP2_IN,
 		PTP1_FN, PTP1_OUT, 0, PTP1_IN,
-		PTP0_FN, PTP0_OUT, 0, PTP0_IN }
+		PTP0_FN, PTP0_OUT, 0, PTP0_IN ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xa405011a, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xa405011a, 16, 2, GROUP(
 		PTR7_FN, PTR7_OUT, 0, PTR7_IN,
 		PTR6_FN, PTR6_OUT, 0, PTR6_IN,
 		PTR5_FN, PTR5_OUT, 0, PTR5_IN,
@@ -1066,9 +1066,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTR3_FN, PTR3_OUT, 0, PTR3_IN,
 		PTR2_FN, PTR2_OUT, 0, PTR2_IN,
 		PTR1_FN, PTR1_OUT, 0, PTR1_IN,
-		PTR0_FN, PTR0_OUT, 0, PTR0_IN }
+		PTR0_FN, PTR0_OUT, 0, PTR0_IN ))
 	},
-	{ PINMUX_CFG_REG("PSCR", 0xa405011c, 16, 2) {
+	{ PINMUX_CFG_REG("PSCR", 0xa405011c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1076,9 +1076,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTS3_FN, PTS3_OUT, 0, PTS3_IN,
 		PTS2_FN, PTS2_OUT, 0, PTS2_IN,
 		PTS1_FN, PTS1_OUT, 0, PTS1_IN,
-		PTS0_FN, PTS0_OUT, 0, PTS0_IN }
+		PTS0_FN, PTS0_OUT, 0, PTS0_IN ))
 	},
-	{ PINMUX_CFG_REG("PTCR", 0xa405011e, 16, 2) {
+	{ PINMUX_CFG_REG("PTCR", 0xa405011e, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1086,9 +1086,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTT3_FN, PTT3_OUT, 0, PTT3_IN,
 		PTT2_FN, PTT2_OUT, 0, PTT2_IN,
 		PTT1_FN, PTT1_OUT, 0, PTT1_IN,
-		PTT0_FN, PTT0_OUT, 0, PTT0_IN }
+		PTT0_FN, PTT0_OUT, 0, PTT0_IN ))
 	},
-	{ PINMUX_CFG_REG("PUCR", 0xa4050120, 16, 2) {
+	{ PINMUX_CFG_REG("PUCR", 0xa4050120, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1096,9 +1096,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTU3_FN, PTU3_OUT, 0, PTU3_IN,
 		PTU2_FN, PTU2_OUT, 0, PTU2_IN,
 		PTU1_FN, PTU1_OUT, 0, PTU1_IN,
-		PTU0_FN, PTU0_OUT, 0, PTU0_IN }
+		PTU0_FN, PTU0_OUT, 0, PTU0_IN ))
 	},
-	{ PINMUX_CFG_REG("PVCR", 0xa4050122, 16, 2) {
+	{ PINMUX_CFG_REG("PVCR", 0xa4050122, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1106,7 +1106,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTV3_FN, PTV3_OUT, 0, PTV3_IN,
 		PTV2_FN, PTV2_OUT, 0, PTV2_IN,
 		PTV1_FN, PTV1_OUT, 0, PTV1_IN,
-		PTV0_FN, PTV0_OUT, 0, PTV0_IN }
+		PTV0_FN, PTV0_OUT, 0, PTV0_IN ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index 0e733bff..7d5d614 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -1237,7 +1237,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2, GROUP(
 		VIO_D7_SCIF1_SCK, PTA7_OUT, 0, PTA7_IN,
 		VIO_D6_SCIF1_RXD, 0, 0, PTA6_IN,
 		VIO_D5_SCIF1_TXD, PTA5_OUT, 0, PTA5_IN,
@@ -1245,9 +1245,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		VIO_D3, 0, 0, PTA3_IN,
 		VIO_D2, 0, 0, PTA2_IN,
 		VIO_D1, 0, 0, PTA1_IN,
-		VIO_D0_LCDLCLK, 0, 0, PTA0_IN }
+		VIO_D0_LCDLCLK, 0, 0, PTA0_IN ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2, GROUP(
 		HPD55, PTB7_OUT, 0, PTB7_IN,
 		HPD54, PTB6_OUT, 0, PTB6_IN,
 		HPD53, PTB5_OUT, 0, PTB5_IN,
@@ -1255,9 +1255,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		HPD51, PTB3_OUT, 0, PTB3_IN,
 		HPD50, PTB2_OUT, 0, PTB2_IN,
 		HPD49, PTB1_OUT, 0, PTB1_IN,
-		HPD48, PTB0_OUT, 0, PTB0_IN }
+		HPD48, PTB0_OUT, 0, PTB0_IN ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2, GROUP(
 		0, 0, 0, PTC7_IN,
 		0, 0, 0, 0,
 		IOIS16, 0, 0, PTC5_IN,
@@ -1265,9 +1265,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		HPDQM6, PTC3_OUT, 0, PTC3_IN,
 		HPDQM5, PTC2_OUT, 0, PTC2_IN,
 		0, 0, 0, 0,
-		HPDQM4, PTC0_OUT, 0, PTC0_IN }
+		HPDQM4, PTC0_OUT, 0, PTC0_IN ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2, GROUP(
 		SDHICD, 0, 0, PTD7_IN,
 		SDHIWP, PTD6_OUT, 0, PTD6_IN,
 		SDHID3, PTD5_OUT, 0, PTD5_IN,
@@ -1275,9 +1275,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		SDHID1, PTD3_OUT, 0, PTD3_IN,
 		SDHID0, PTD2_OUT, 0, PTD2_IN,
 		SDHICMD, PTD1_OUT, 0, PTD1_IN,
-		SDHICLK, PTD0_OUT, 0, 0 }
+		SDHICLK, PTD0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2, GROUP(
 		A25, PTE7_OUT, 0, PTE7_IN,
 		A24, PTE6_OUT, 0, PTE6_IN,
 		A23, PTE5_OUT, 0, PTE5_IN,
@@ -1285,9 +1285,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		IRQ5, PTE1_OUT, 0, PTE1_IN,
-		IRQ4_BS, PTE0_OUT, 0, PTE0_IN }
+		IRQ4_BS, PTE0_OUT, 0, PTE0_IN ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTF6, PTF6_OUT, 0, PTF6_IN,
 		SIOSCK_SIUBOBT, PTF5_OUT, 0, PTF5_IN,
@@ -1295,9 +1295,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		SIOSTRB0_SIUBIBT, PTF3_OUT, 0, PTF3_IN,
 		SIOD_SIUBILR, PTF2_OUT, 0, PTF2_IN,
 		SIORXD_SIUBISLD, 0, 0, PTF1_IN,
-		SIOTXD_SIUBOSLD, PTF0_OUT, 0, 0 }
+		SIOTXD_SIUBOSLD, PTF0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1305,9 +1305,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		AUDATA3, PTG3_OUT, 0, 0,
 		AUDATA2, PTG2_OUT, 0, 0,
 		AUDATA1, PTG1_OUT, 0, 0,
-		AUDATA0, PTG0_OUT, 0, 0 }
+		AUDATA0, PTG0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2, GROUP(
 		LCDVCPWC_LCDVCPWC2, PTH7_OUT, 0, 0,
 		LCDVSYN2_DACK, PTH6_OUT, 0, PTH6_IN,
 		LCDVSYN, PTH5_OUT, 0, PTH5_IN,
@@ -1315,9 +1315,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		LCDHSYN_LCDCS, PTH3_OUT, 0, 0,
 		LCDDON_LCDDON2, PTH2_OUT, 0, 0,
 		LCDD17_DV_HSYNC, PTH1_OUT, 0, PTH1_IN,
-		LCDD16_DV_VSYNC, PTH0_OUT, 0, PTH0_IN }
+		LCDD16_DV_VSYNC, PTH0_OUT, 0, PTH0_IN ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2, GROUP(
 		STATUS0, PTJ7_OUT, 0, 0,
 		0, PTJ6_OUT, 0, 0,
 		PDSTATUS, PTJ5_OUT, 0, 0,
@@ -1325,9 +1325,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		IRQ1, PTJ1_OUT, 0, PTJ1_IN,
-		IRQ0, PTJ0_OUT, 0, PTJ0_IN }
+		IRQ0, PTJ0_OUT, 0, PTJ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2, GROUP(
 		0, 0, 0, 0,
 		SIUAILR_SIOF1_SS2, PTK6_OUT, 0, PTK6_IN,
 		SIUAIBT_SIOF1_SS1, PTK5_OUT, 0, PTK5_IN,
@@ -1335,9 +1335,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		SIUAOBT_SIOF1_SCK, PTK3_OUT, 0, PTK3_IN,
 		SIUAISLD_SIOF1_RXD, 0, 0, PTK2_IN,
 		SIUAOSLD_SIOF1_TXD, PTK1_OUT, 0, 0,
-		PTK0, PTK0_OUT, 0, PTK0_IN }
+		PTK0, PTK0_OUT, 0, PTK0_IN ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2, GROUP(
 		LCDD15_DV_D15, PTL7_OUT, 0, PTL7_IN,
 		LCDD14_DV_D14, PTL6_OUT, 0, PTL6_IN,
 		LCDD13_DV_D13, PTL5_OUT, 0, PTL5_IN,
@@ -1345,9 +1345,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		LCDD11_DV_D11, PTL3_OUT, 0, PTL3_IN,
 		LCDD10_DV_D10, PTL2_OUT, 0, PTL2_IN,
 		LCDD9_DV_D9, PTL1_OUT, 0, PTL1_IN,
-		LCDD8_DV_D8, PTL0_OUT, 0, PTL0_IN }
+		LCDD8_DV_D8, PTL0_OUT, 0, PTL0_IN ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2, GROUP(
 		LCDD7_DV_D7, PTM7_OUT, 0, PTM7_IN,
 		LCDD6_DV_D6, PTM6_OUT, 0, PTM6_IN,
 		LCDD5_DV_D5, PTM5_OUT, 0, PTM5_IN,
@@ -1355,9 +1355,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		LCDD3_DV_D3, PTM3_OUT, 0, PTM3_IN,
 		LCDD2_DV_D2, PTM2_OUT, 0, PTM2_IN,
 		LCDD1_DV_D1, PTM1_OUT, 0, PTM1_IN,
-		LCDD0_DV_D0, PTM0_OUT, 0, PTM0_IN }
+		LCDD0_DV_D0, PTM0_OUT, 0, PTM0_IN ))
 	},
-	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2) {
+	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2, GROUP(
 		HPD63, PTN7_OUT, 0, PTN7_IN,
 		HPD62, PTN6_OUT, 0, PTN6_IN,
 		HPD61, PTN5_OUT, 0, PTN5_IN,
@@ -1365,9 +1365,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		HPD59, PTN3_OUT, 0, PTN3_IN,
 		HPD58, PTN2_OUT, 0, PTN2_IN,
 		HPD57, PTN1_OUT, 0, PTN1_IN,
-		HPD56, PTN0_OUT, 0, PTN0_IN }
+		HPD56, PTN0_OUT, 0, PTN0_IN ))
 	},
-	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2) {
+	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		SIOF0_SS2_SIM_RST, PTQ6_OUT, 0, 0,
 		SIOF0_SS1_TS_SPSYNC, PTQ5_OUT, 0, PTQ5_IN,
@@ -1375,9 +1375,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		SIOF0_SCK_TS_SCK, PTQ3_OUT, 0, PTQ3_IN,
 		PTQ2, 0, 0, PTQ2_IN,
 		PTQ1, PTQ1_OUT, 0, 0,
-		PTQ0, PTQ0_OUT, 0, PTQ0_IN }
+		PTQ0, PTQ0_OUT, 0, PTQ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1385,9 +1385,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		CS6B_CE1B_LCDCS2, PTR3_OUT, 0, 0,
 		WAIT, 0, 0, PTR2_IN,
 		LCDDCK_LCDWR, PTR1_OUT, 0, 0,
-		LCDVEPWC_LCDVEPWC2, PTR0_OUT, 0, 0 }
+		LCDVEPWC_LCDVEPWC2, PTR0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2) {
+	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1395,9 +1395,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		SCIF0_RTS_SIUAOSPD, PTS3_OUT, 0, 0,
 		SCIF0_SCK_TPUTO, PTS2_OUT, 0, PTS2_IN,
 		SCIF0_RXD, 0, 0, PTS1_IN,
-		SCIF0_TXD, PTS0_OUT, 0, 0 }
+		SCIF0_TXD, PTS0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2) {
+	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1405,9 +1405,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FWE, PTT3_OUT, 0, PTT3_IN,
 		FSC, PTT2_OUT, 0, PTT2_IN,
 		DREQ0, 0, 0, PTT1_IN,
-		FCDE, PTT0_OUT, 0, 0 }
+		FCDE, PTT0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2) {
+	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1415,9 +1415,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		NAF1_VIO_D9, PTU3_OUT, 0, PTU3_IN,
 		NAF0_VIO_D8, PTU2_OUT, 0, PTU2_IN,
 		FRB_VIO_CLK2, 0, 0, PTU1_IN,
-		FCE_VIO_HD2, PTU0_OUT, 0, PTU0_IN }
+		FCE_VIO_HD2, PTU0_OUT, 0, PTU0_IN ))
 	},
-	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2) {
+	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1425,9 +1425,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		NAF6_VIO_D14, PTV3_OUT, 0, PTV3_IN,
 		NAF5_VIO_D13, PTV2_OUT, 0, PTV2_IN,
 		NAF4_VIO_D12, PTV1_OUT, 0, PTV1_IN,
-		NAF3_VIO_D11, PTV0_OUT, 0, PTV0_IN }
+		NAF3_VIO_D11, PTV0_OUT, 0, PTV0_IN ))
 	},
-	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2) {
+	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2, GROUP(
 		0, 0, 0, 0,
 		VIO_FLD_SCIF2_CTS, 0, 0, PTW6_IN,
 		VIO_CKO_SCIF2_RTS, PTW5_OUT, 0, 0,
@@ -1435,9 +1435,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		VIO_STEM_SCIF2_TXD, PTW3_OUT, 0, PTW3_IN,
 		VIO_HD_SCIF2_RXD, PTW2_OUT, 0, PTW2_IN,
 		VIO_VD_SCIF1_CTS, PTW1_OUT, 0, PTW1_IN,
-		VIO_CLK_SCIF1_RTS, PTW0_OUT, 0, PTW0_IN }
+		VIO_CLK_SCIF1_RTS, PTW0_OUT, 0, PTW0_IN ))
 	},
-	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2) {
+	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2, GROUP(
 		0, 0, 0, 0,
 		CS6A_CE2B, PTX6_OUT, 0, PTX6_IN,
 		LCDD23, PTX5_OUT, 0, PTX5_IN,
@@ -1445,9 +1445,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		LCDD21, PTX3_OUT, 0, PTX3_IN,
 		LCDD20, PTX2_OUT, 0, PTX2_IN,
 		LCDD19_DV_CLKI, PTX1_OUT, 0, PTX1_IN,
-		LCDD18_DV_CLK, PTX0_OUT, 0, PTX0_IN }
+		LCDD18_DV_CLK, PTX0_OUT, 0, PTX0_IN ))
 	},
-	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2) {
+	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		KEYOUT5_IN5, PTY5_OUT, 0, PTY5_IN,
@@ -1455,9 +1455,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		KEYOUT3, PTY3_OUT, 0, PTY3_IN,
 		KEYOUT2, PTY2_OUT, 0, PTY2_IN,
 		KEYOUT1, PTY1_OUT, 0, 0,
-		KEYOUT0, PTY0_OUT, 0, PTY0_IN }
+		KEYOUT0, PTY0_OUT, 0, PTY0_IN ))
 	},
-	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2) {
+	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		KEYIN4_IRQ7, 0, 0, PTZ5_IN,
@@ -1465,9 +1465,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		KEYIN2, 0, 0, PTZ3_IN,
 		KEYIN1, 0, 0, PTZ2_IN,
 		KEYIN0_IRQ6, 0, 0, PTZ1_IN,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 1) {
+	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 1, GROUP(
 		PSA15_KEYIN0, PSA15_IRQ6,
 		PSA14_KEYIN4, PSA14_IRQ7,
 		0, 0,
@@ -1483,9 +1483,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0 }
+		0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 1) {
+	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 1, GROUP(
 		PSB15_SIOTXD, PSB15_SIUBOSLD,
 		PSB14_SIORXD, PSB14_SIUBISLD,
 		PSB13_SIOD, PSB13_SIUBILR,
@@ -1501,9 +1501,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSB3_SIOF0_SS1, PSB3_TS_SPSYNC,
 		PSB2_SIOF0_SS2, PSB2_SIM_RST,
 		PSB1_SIUMCKA, PSB1_SIOF1_MCK,
-		PSB0_SIUAOSLD, PSB0_SIOF1_TXD }
+		PSB0_SIUAOSLD, PSB0_SIOF1_TXD ))
 	},
-	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 1) {
+	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 1, GROUP(
 		PSC15_SIUAISLD, PSC15_SIOF1_RXD,
 		PSC14_SIUAOBT, PSC14_SIOF1_SCK,
 		PSC13_SIUAOLR, PSC13_SIOF1_SYNC,
@@ -1519,9 +1519,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		PSC0_NAF, PSC0_VIO }
+		PSC0_NAF, PSC0_VIO ))
 	},
-	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 1) {
+	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		PSD13_VIO, PSD13_SCIF2,
@@ -1537,9 +1537,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSD3_LCDVEPWC_LCDVCPWC, PSD3_LCDVEPWC2_LCDVCPWC2,
 		PSD2_LCDDON, PSD2_LCDDON2,
 		0, 0,
-		PSD0_LCDD19_LCDD0, PSD0_DV }
+		PSD0_LCDD19_LCDD0, PSD0_DV ))
 	},
-	{ PINMUX_CFG_REG("PSELE", 0xa4050156, 16, 1) {
+	{ PINMUX_CFG_REG("PSELE", 0xa4050156, 16, 1, GROUP(
 		PSE15_SIOF0_MCK_IRQ3, PSE15_SIM_D,
 		PSE14_SIOF0_TXD_IRDA_OUT, PSE14_SIM_CLK,
 		PSE13_SIOF0_RXD_IRDA_IN, PSE13_TS_SDAT,
@@ -1555,9 +1555,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSE3_FLCTL, PSE3_VIO,
 		PSE2_NAF2, PSE2_VIO_D10,
 		PSE1_NAF1, PSE1_VIO_D9,
-		PSE0_NAF0, PSE0_VIO_D8 }
+		PSE0_NAF0, PSE0_VIO_D8 ))
 	},
-	{ PINMUX_CFG_REG("HIZCRA", 0xa4050158, 16, 1) {
+	{ PINMUX_CFG_REG("HIZCRA", 0xa4050158, 16, 1, GROUP(
 		0, 0,
 		HIZA14_KEYSC, HIZA14_HIZ,
 		0, 0,
@@ -1573,9 +1573,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0 }
+		0, 0 ))
 	},
-	{ PINMUX_CFG_REG("HIZCRB", 0xa405015a, 16, 1) {
+	{ PINMUX_CFG_REG("HIZCRB", 0xa405015a, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1591,9 +1591,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		HIZB1_VIO, HIZB1_HIZ,
-		HIZB0_VIO, HIZB0_HIZ }
+		HIZB0_VIO, HIZB0_HIZ ))
 	},
-	{ PINMUX_CFG_REG("HIZCRC", 0xa405015c, 16, 1) {
+	{ PINMUX_CFG_REG("HIZCRC", 0xa405015c, 16, 1, GROUP(
 		HIZC15_IRQ7, HIZC15_HIZ,
 		HIZC14_IRQ6, HIZC14_HIZ,
 		HIZC13_IRQ5, HIZC13_HIZ,
@@ -1609,9 +1609,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0 }
+		0, 0 ))
 	},
-	{ PINMUX_CFG_REG("MSELCRB", 0xa4050182, 16, 1) {
+	{ PINMUX_CFG_REG("MSELCRB", 0xa4050182, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1627,7 +1627,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0 }
+		0, 0 ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 8ea18df..6d6b82b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -1510,7 +1510,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2, GROUP(
 		PTA7_FN, PTA7_OUT, 0, PTA7_IN,
 		PTA6_FN, PTA6_OUT, 0, PTA6_IN,
 		PTA5_FN, PTA5_OUT, 0, PTA5_IN,
@@ -1518,9 +1518,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTA3_FN, PTA3_OUT, 0, PTA3_IN,
 		PTA2_FN, PTA2_OUT, 0, PTA2_IN,
 		PTA1_FN, PTA1_OUT, 0, PTA1_IN,
-		PTA0_FN, PTA0_OUT, 0, PTA0_IN }
+		PTA0_FN, PTA0_OUT, 0, PTA0_IN ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2, GROUP(
 		PTB7_FN, PTB7_OUT, 0, PTB7_IN,
 		PTB6_FN, PTB6_OUT, 0, PTB6_IN,
 		PTB5_FN, PTB5_OUT, 0, PTB5_IN,
@@ -1528,9 +1528,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTB3_FN, PTB3_OUT, 0, PTB3_IN,
 		PTB2_FN, PTB2_OUT, 0, PTB2_IN,
 		PTB1_FN, PTB1_OUT, 0, PTB1_IN,
-		PTB0_FN, PTB0_OUT, 0, PTB0_IN }
+		PTB0_FN, PTB0_OUT, 0, PTB0_IN ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2, GROUP(
 		PTC7_FN, PTC7_OUT, 0, PTC7_IN,
 		PTC6_FN, PTC6_OUT, 0, PTC6_IN,
 		PTC5_FN, PTC5_OUT, 0, PTC5_IN,
@@ -1538,9 +1538,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTC3_FN, PTC3_OUT, 0, PTC3_IN,
 		PTC2_FN, PTC2_OUT, 0, PTC2_IN,
 		PTC1_FN, PTC1_OUT, 0, PTC1_IN,
-		PTC0_FN, PTC0_OUT, 0, PTC0_IN }
+		PTC0_FN, PTC0_OUT, 0, PTC0_IN ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2, GROUP(
 		PTD7_FN, PTD7_OUT, 0, PTD7_IN,
 		PTD6_FN, PTD6_OUT, 0, PTD6_IN,
 		PTD5_FN, PTD5_OUT, 0, PTD5_IN,
@@ -1548,9 +1548,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTD3_FN, PTD3_OUT, 0, PTD3_IN,
 		PTD2_FN, PTD2_OUT, 0, PTD2_IN,
 		PTD1_FN, PTD1_OUT, 0, PTD1_IN,
-		PTD0_FN, PTD0_OUT, 0, PTD0_IN }
+		PTD0_FN, PTD0_OUT, 0, PTD0_IN ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PTE5_FN, PTE5_OUT, 0, PTE5_IN,
@@ -1558,9 +1558,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTE3_FN, PTE3_OUT, 0, PTE3_IN,
 		PTE2_FN, PTE2_OUT, 0, PTE2_IN,
 		PTE1_FN, PTE1_OUT, 0, PTE1_IN,
-		PTE0_FN, PTE0_OUT, 0, PTE0_IN }
+		PTE0_FN, PTE0_OUT, 0, PTE0_IN ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2, GROUP(
 		PTF7_FN, PTF7_OUT, 0, PTF7_IN,
 		PTF6_FN, PTF6_OUT, 0, PTF6_IN,
 		PTF5_FN, PTF5_OUT, 0, PTF5_IN,
@@ -1568,9 +1568,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTF3_FN, PTF3_OUT, 0, PTF3_IN,
 		PTF2_FN, PTF2_OUT, 0, PTF2_IN,
 		PTF1_FN, PTF1_OUT, 0, PTF1_IN,
-		PTF0_FN, PTF0_OUT, 0, PTF0_IN }
+		PTF0_FN, PTF0_OUT, 0, PTF0_IN ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PTG5_FN, PTG5_OUT, 0, 0,
@@ -1578,9 +1578,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTG3_FN, PTG3_OUT, 0, 0,
 		PTG2_FN, PTG2_OUT, 0, 0,
 		PTG1_FN, PTG1_OUT, 0, 0,
-		PTG0_FN, PTG0_OUT, 0, 0 }
+		PTG0_FN, PTG0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2, GROUP(
 		PTH7_FN, PTH7_OUT, 0, PTH7_IN,
 		PTH6_FN, PTH6_OUT, 0, PTH6_IN,
 		PTH5_FN, PTH5_OUT, 0, PTH5_IN,
@@ -1588,9 +1588,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTH3_FN, PTH3_OUT, 0, PTH3_IN,
 		PTH2_FN, PTH2_OUT, 0, PTH2_IN,
 		PTH1_FN, PTH1_OUT, 0, PTH1_IN,
-		PTH0_FN, PTH0_OUT, 0, PTH0_IN }
+		PTH0_FN, PTH0_OUT, 0, PTH0_IN ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2, GROUP(
 		PTJ7_FN, PTJ7_OUT, 0, 0,
 		0, 0, 0, 0,
 		PTJ5_FN, PTJ5_OUT, 0, 0,
@@ -1598,9 +1598,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTJ3_FN, PTJ3_OUT, 0, PTJ3_IN,
 		PTJ2_FN, PTJ2_OUT, 0, PTJ2_IN,
 		PTJ1_FN, PTJ1_OUT, 0, PTJ1_IN,
-		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN }
+		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2, GROUP(
 		PTK7_FN, PTK7_OUT, 0, PTK7_IN,
 		PTK6_FN, PTK6_OUT, 0, PTK6_IN,
 		PTK5_FN, PTK5_OUT, 0, PTK5_IN,
@@ -1608,9 +1608,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTK3_FN, PTK3_OUT, 0, PTK3_IN,
 		PTK2_FN, PTK2_OUT, 0, PTK2_IN,
 		PTK1_FN, PTK1_OUT, 0, PTK1_IN,
-		PTK0_FN, PTK0_OUT, 0, PTK0_IN }
+		PTK0_FN, PTK0_OUT, 0, PTK0_IN ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2, GROUP(
 		PTL7_FN, PTL7_OUT, 0, PTL7_IN,
 		PTL6_FN, PTL6_OUT, 0, PTL6_IN,
 		PTL5_FN, PTL5_OUT, 0, PTL5_IN,
@@ -1618,9 +1618,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTL3_FN, PTL3_OUT, 0, PTL3_IN,
 		PTL2_FN, PTL2_OUT, 0, PTL2_IN,
 		PTL1_FN, PTL1_OUT, 0, PTL1_IN,
-		PTL0_FN, PTL0_OUT, 0, PTL0_IN }
+		PTL0_FN, PTL0_OUT, 0, PTL0_IN ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2, GROUP(
 		PTM7_FN, PTM7_OUT, 0, PTM7_IN,
 		PTM6_FN, PTM6_OUT, 0, PTM6_IN,
 		PTM5_FN, PTM5_OUT, 0, PTM5_IN,
@@ -1628,9 +1628,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTM3_FN, PTM3_OUT, 0, PTM3_IN,
 		PTM2_FN, PTM2_OUT, 0, PTM2_IN,
 		PTM1_FN, PTM1_OUT, 0, PTM1_IN,
-		PTM0_FN, PTM0_OUT, 0, PTM0_IN }
+		PTM0_FN, PTM0_OUT, 0, PTM0_IN ))
 	},
-	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2) {
+	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2, GROUP(
 		PTN7_FN, PTN7_OUT, 0, PTN7_IN,
 		PTN6_FN, PTN6_OUT, 0, PTN6_IN,
 		PTN5_FN, PTN5_OUT, 0, PTN5_IN,
@@ -1638,9 +1638,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTN3_FN, PTN3_OUT, 0, PTN3_IN,
 		PTN2_FN, PTN2_OUT, 0, PTN2_IN,
 		PTN1_FN, PTN1_OUT, 0, PTN1_IN,
-		PTN0_FN, PTN0_OUT, 0, PTN0_IN }
+		PTN0_FN, PTN0_OUT, 0, PTN0_IN ))
 	},
-	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2) {
+	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1648,9 +1648,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTQ3_FN, 0, 0, PTQ3_IN,
 		PTQ2_FN, 0, 0, PTQ2_IN,
 		PTQ1_FN, 0, 0, PTQ1_IN,
-		PTQ0_FN, 0, 0, PTQ0_IN }
+		PTQ0_FN, 0, 0, PTQ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2, GROUP(
 		PTR7_FN, PTR7_OUT, 0, PTR7_IN,
 		PTR6_FN, PTR6_OUT, 0, PTR6_IN,
 		PTR5_FN, PTR5_OUT, 0, PTR5_IN,
@@ -1658,9 +1658,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTR3_FN, 0, 0, PTR3_IN,
 		PTR2_FN, 0, 0, PTR2_IN,
 		PTR1_FN, PTR1_OUT, 0, PTR1_IN,
-		PTR0_FN, PTR0_OUT, 0, PTR0_IN }
+		PTR0_FN, PTR0_OUT, 0, PTR0_IN ))
 	},
-	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2) {
+	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2, GROUP(
 		PTS7_FN, PTS7_OUT, 0, PTS7_IN,
 		PTS6_FN, PTS6_OUT, 0, PTS6_IN,
 		PTS5_FN, PTS5_OUT, 0, PTS5_IN,
@@ -1668,9 +1668,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTS3_FN, PTS3_OUT, 0, PTS3_IN,
 		PTS2_FN, PTS2_OUT, 0, PTS2_IN,
 		PTS1_FN, PTS1_OUT, 0, PTS1_IN,
-		PTS0_FN, PTS0_OUT, 0, PTS0_IN }
+		PTS0_FN, PTS0_OUT, 0, PTS0_IN ))
 	},
-	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2) {
+	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PTT5_FN, PTT5_OUT, 0, PTT5_IN,
@@ -1678,9 +1678,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTT3_FN, PTT3_OUT, 0, PTT3_IN,
 		PTT2_FN, PTT2_OUT, 0, PTT2_IN,
 		PTT1_FN, PTT1_OUT, 0, PTT1_IN,
-		PTT0_FN, PTT0_OUT, 0, PTT0_IN }
+		PTT0_FN, PTT0_OUT, 0, PTT0_IN ))
 	},
-	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2) {
+	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PTU5_FN, PTU5_OUT, 0, PTU5_IN,
@@ -1688,9 +1688,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTU3_FN, PTU3_OUT, 0, PTU3_IN,
 		PTU2_FN, PTU2_OUT, 0, PTU2_IN,
 		PTU1_FN, PTU1_OUT, 0, PTU1_IN,
-		PTU0_FN, PTU0_OUT, 0, PTU0_IN }
+		PTU0_FN, PTU0_OUT, 0, PTU0_IN ))
 	},
-	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2) {
+	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2, GROUP(
 		PTV7_FN, PTV7_OUT, 0, PTV7_IN,
 		PTV6_FN, PTV6_OUT, 0, PTV6_IN,
 		PTV5_FN, PTV5_OUT, 0, PTV5_IN,
@@ -1698,9 +1698,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTV3_FN, PTV3_OUT, 0, PTV3_IN,
 		PTV2_FN, PTV2_OUT, 0, PTV2_IN,
 		PTV1_FN, PTV1_OUT, 0, PTV1_IN,
-		PTV0_FN, PTV0_OUT, 0, PTV0_IN }
+		PTV0_FN, PTV0_OUT, 0, PTV0_IN ))
 	},
-	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2) {
+	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2, GROUP(
 		PTW7_FN, PTW7_OUT, 0, PTW7_IN,
 		PTW6_FN, PTW6_OUT, 0, PTW6_IN,
 		PTW5_FN, PTW5_OUT, 0, PTW5_IN,
@@ -1708,9 +1708,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTW3_FN, PTW3_OUT, 0, PTW3_IN,
 		PTW2_FN, PTW2_OUT, 0, PTW2_IN,
 		PTW1_FN, PTW1_OUT, 0, PTW1_IN,
-		PTW0_FN, PTW0_OUT, 0, PTW0_IN }
+		PTW0_FN, PTW0_OUT, 0, PTW0_IN ))
 	},
-	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2) {
+	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2, GROUP(
 		PTX7_FN, PTX7_OUT, 0, PTX7_IN,
 		PTX6_FN, PTX6_OUT, 0, PTX6_IN,
 		PTX5_FN, PTX5_OUT, 0, PTX5_IN,
@@ -1718,9 +1718,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTX3_FN, PTX3_OUT, 0, PTX3_IN,
 		PTX2_FN, PTX2_OUT, 0, PTX2_IN,
 		PTX1_FN, PTX1_OUT, 0, PTX1_IN,
-		PTX0_FN, PTX0_OUT, 0, PTX0_IN }
+		PTX0_FN, PTX0_OUT, 0, PTX0_IN ))
 	},
-	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2) {
+	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2, GROUP(
 		PTY7_FN, PTY7_OUT, 0, PTY7_IN,
 		PTY6_FN, PTY6_OUT, 0, PTY6_IN,
 		PTY5_FN, PTY5_OUT, 0, PTY5_IN,
@@ -1728,9 +1728,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTY3_FN, PTY3_OUT, 0, PTY3_IN,
 		PTY2_FN, PTY2_OUT, 0, PTY2_IN,
 		PTY1_FN, PTY1_OUT, 0, PTY1_IN,
-		PTY0_FN, PTY0_OUT, 0, PTY0_IN }
+		PTY0_FN, PTY0_OUT, 0, PTY0_IN ))
 	},
-	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2) {
+	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2, GROUP(
 		PTZ7_FN, PTZ7_OUT, 0, PTZ7_IN,
 		PTZ6_FN, PTZ6_OUT, 0, PTZ6_IN,
 		PTZ5_FN, PTZ5_OUT, 0, PTZ5_IN,
@@ -1738,9 +1738,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTZ3_FN, PTZ3_OUT, 0, PTZ3_IN,
 		PTZ2_FN, PTZ2_OUT, 0, PTZ2_IN,
 		PTZ1_FN, PTZ1_OUT, 0, PTZ1_IN,
-		PTZ0_FN, PTZ0_OUT, 0, PTZ0_IN }
+		PTZ0_FN, PTZ0_OUT, 0, PTZ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 2) {
+	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 2, GROUP(
 		PSA15_PSA14_FN1, PSA15_PSA14_FN2, 0, 0,
 		PSA13_PSA12_FN1, PSA13_PSA12_FN2, 0, 0,
 		PSA11_PSA10_FN1, PSA11_PSA10_FN2, 0, 0,
@@ -1748,9 +1748,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		PSA5_PSA4_FN1, PSA5_PSA4_FN2, PSA5_PSA4_FN3, 0,
 		PSA3_PSA2_FN1, PSA3_PSA2_FN2, 0, 0,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 2) {
+	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 2, GROUP(
 		PSB15_PSB14_FN1, PSB15_PSB14_FN2, 0, 0,
 		PSB13_PSB12_LCDC_RGB, PSB13_PSB12_LCDC_SYS, 0, 0,
 		0, 0, 0, 0,
@@ -1758,9 +1758,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSB7_PSB6_FN1, PSB7_PSB6_FN2, 0, 0,
 		PSB5_PSB4_FN1, PSB5_PSB4_FN2, 0, 0,
 		PSB3_PSB2_FN1, PSB3_PSB2_FN2, 0, 0,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 2) {
+	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 2, GROUP(
 		PSC15_PSC14_FN1, PSC15_PSC14_FN2, 0, 0,
 		PSC13_PSC12_FN1, PSC13_PSC12_FN2, 0, 0,
 		PSC11_PSC10_FN1, PSC11_PSC10_FN2, PSC11_PSC10_FN3, 0,
@@ -1768,9 +1768,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSC7_PSC6_FN1, PSC7_PSC6_FN2, PSC7_PSC6_FN3, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 2) {
+	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 2, GROUP(
 		PSD15_PSD14_FN1, PSD15_PSD14_FN2, 0, 0,
 		PSD13_PSD12_FN1, PSD13_PSD12_FN2, 0, 0,
 		PSD11_PSD10_FN1, PSD11_PSD10_FN2, PSD11_PSD10_FN3, 0,
@@ -1778,7 +1778,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSD7_PSD6_FN1, PSD7_PSD6_FN2, 0, 0,
 		PSD5_PSD4_FN1, PSD5_PSD4_FN2, 0, 0,
 		PSD3_PSD2_FN1, PSD3_PSD2_FN2, 0, 0,
-		PSD1_PSD0_FN1, PSD1_PSD0_FN2, 0, 0 }
+		PSD1_PSD0_FN1, PSD1_PSD0_FN2, 0, 0 ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 7f6c36c..e9e70d7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -1742,7 +1742,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xa4050100, 16, 2, GROUP(
 		PTA7_FN, PTA7_OUT, 0, PTA7_IN,
 		PTA6_FN, PTA6_OUT, 0, PTA6_IN,
 		PTA5_FN, PTA5_OUT, 0, PTA5_IN,
@@ -1750,9 +1750,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTA3_FN, PTA3_OUT, 0, PTA3_IN,
 		PTA2_FN, PTA2_OUT, 0, PTA2_IN,
 		PTA1_FN, PTA1_OUT, 0, PTA1_IN,
-		PTA0_FN, PTA0_OUT, 0, PTA0_IN }
+		PTA0_FN, PTA0_OUT, 0, PTA0_IN ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xa4050102, 16, 2, GROUP(
 		PTB7_FN, PTB7_OUT, 0, PTB7_IN,
 		PTB6_FN, PTB6_OUT, 0, PTB6_IN,
 		PTB5_FN, PTB5_OUT, 0, PTB5_IN,
@@ -1760,9 +1760,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTB3_FN, PTB3_OUT, 0, PTB3_IN,
 		PTB2_FN, PTB2_OUT, 0, PTB2_IN,
 		PTB1_FN, PTB1_OUT, 0, PTB1_IN,
-		PTB0_FN, PTB0_OUT, 0, PTB0_IN }
+		PTB0_FN, PTB0_OUT, 0, PTB0_IN ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xa4050104, 16, 2, GROUP(
 		PTC7_FN, PTC7_OUT, 0, PTC7_IN,
 		PTC6_FN, PTC6_OUT, 0, PTC6_IN,
 		PTC5_FN, PTC5_OUT, 0, PTC5_IN,
@@ -1770,9 +1770,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTC3_FN, PTC3_OUT, 0, PTC3_IN,
 		PTC2_FN, PTC2_OUT, 0, PTC2_IN,
 		PTC1_FN, PTC1_OUT, 0, PTC1_IN,
-		PTC0_FN, PTC0_OUT, 0, PTC0_IN }
+		PTC0_FN, PTC0_OUT, 0, PTC0_IN ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xa4050106, 16, 2, GROUP(
 		PTD7_FN, PTD7_OUT, 0, PTD7_IN,
 		PTD6_FN, PTD6_OUT, 0, PTD6_IN,
 		PTD5_FN, PTD5_OUT, 0, PTD5_IN,
@@ -1780,9 +1780,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTD3_FN, PTD3_OUT, 0, PTD3_IN,
 		PTD2_FN, PTD2_OUT, 0, PTD2_IN,
 		PTD1_FN, PTD1_OUT, 0, PTD1_IN,
-		PTD0_FN, PTD0_OUT, 0, PTD0_IN }
+		PTD0_FN, PTD0_OUT, 0, PTD0_IN ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xa4050108, 16, 2, GROUP(
 		PTE7_FN, PTE7_OUT, 0, PTE7_IN,
 		PTE6_FN, PTE6_OUT, 0, PTE6_IN,
 		PTE5_FN, PTE5_OUT, 0, PTE5_IN,
@@ -1790,9 +1790,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTE3_FN, PTE3_OUT, 0, PTE3_IN,
 		PTE2_FN, PTE2_OUT, 0, PTE2_IN,
 		PTE1_FN, PTE1_OUT, 0, PTE1_IN,
-		PTE0_FN, PTE0_OUT, 0, PTE0_IN }
+		PTE0_FN, PTE0_OUT, 0, PTE0_IN ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xa405010a, 16, 2, GROUP(
 		PTF7_FN, PTF7_OUT, 0, PTF7_IN,
 		PTF6_FN, PTF6_OUT, 0, PTF6_IN,
 		PTF5_FN, PTF5_OUT, 0, PTF5_IN,
@@ -1800,9 +1800,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTF3_FN, PTF3_OUT, 0, PTF3_IN,
 		PTF2_FN, PTF2_OUT, 0, PTF2_IN,
 		PTF1_FN, PTF1_OUT, 0, PTF1_IN,
-		PTF0_FN, PTF0_OUT, 0, PTF0_IN }
+		PTF0_FN, PTF0_OUT, 0, PTF0_IN ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xa405010c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PTG5_FN, PTG5_OUT, 0, 0,
@@ -1810,9 +1810,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTG3_FN, PTG3_OUT, 0, 0,
 		PTG2_FN, PTG2_OUT, 0, 0,
 		PTG1_FN, PTG1_OUT, 0, 0,
-		PTG0_FN, PTG0_OUT, 0, 0 }
+		PTG0_FN, PTG0_OUT, 0, 0 ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xa405010e, 16, 2, GROUP(
 		PTH7_FN, PTH7_OUT, 0, PTH7_IN,
 		PTH6_FN, PTH6_OUT, 0, PTH6_IN,
 		PTH5_FN, PTH5_OUT, 0, PTH5_IN,
@@ -1820,9 +1820,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTH3_FN, PTH3_OUT, 0, PTH3_IN,
 		PTH2_FN, PTH2_OUT, 0, PTH2_IN,
 		PTH1_FN, PTH1_OUT, 0, PTH1_IN,
-		PTH0_FN, PTH0_OUT, 0, PTH0_IN }
+		PTH0_FN, PTH0_OUT, 0, PTH0_IN ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xa4050110, 16, 2, GROUP(
 		PTJ7_FN, PTJ7_OUT, 0, 0,
 		PTJ6_FN, PTJ6_OUT, 0, 0,
 		PTJ5_FN, PTJ5_OUT, 0, 0,
@@ -1830,9 +1830,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTJ3_FN, PTJ3_OUT, 0, PTJ3_IN,
 		PTJ2_FN, PTJ2_OUT, 0, PTJ2_IN,
 		PTJ1_FN, PTJ1_OUT, 0, PTJ1_IN,
-		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN }
+		PTJ0_FN, PTJ0_OUT, 0, PTJ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xa4050112, 16, 2, GROUP(
 		PTK7_FN, PTK7_OUT, 0, PTK7_IN,
 		PTK6_FN, PTK6_OUT, 0, PTK6_IN,
 		PTK5_FN, PTK5_OUT, 0, PTK5_IN,
@@ -1840,9 +1840,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTK3_FN, PTK3_OUT, 0, PTK3_IN,
 		PTK2_FN, PTK2_OUT, 0, PTK2_IN,
 		PTK1_FN, PTK1_OUT, 0, PTK1_IN,
-		PTK0_FN, PTK0_OUT, 0, PTK0_IN }
+		PTK0_FN, PTK0_OUT, 0, PTK0_IN ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xa4050114, 16, 2, GROUP(
 		PTL7_FN, PTL7_OUT, 0, PTL7_IN,
 		PTL6_FN, PTL6_OUT, 0, PTL6_IN,
 		PTL5_FN, PTL5_OUT, 0, PTL5_IN,
@@ -1850,9 +1850,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTL3_FN, PTL3_OUT, 0, PTL3_IN,
 		PTL2_FN, PTL2_OUT, 0, PTL2_IN,
 		PTL1_FN, PTL1_OUT, 0, PTL1_IN,
-		PTL0_FN, PTL0_OUT, 0, PTL0_IN }
+		PTL0_FN, PTL0_OUT, 0, PTL0_IN ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xa4050116, 16, 2, GROUP(
 		PTM7_FN, PTM7_OUT, 0, PTM7_IN,
 		PTM6_FN, PTM6_OUT, 0, PTM6_IN,
 		PTM5_FN, PTM5_OUT, 0, PTM5_IN,
@@ -1860,9 +1860,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTM3_FN, PTM3_OUT, 0, PTM3_IN,
 		PTM2_FN, PTM2_OUT, 0, PTM2_IN,
 		PTM1_FN, PTM1_OUT, 0, PTM1_IN,
-		PTM0_FN, PTM0_OUT, 0, PTM0_IN }
+		PTM0_FN, PTM0_OUT, 0, PTM0_IN ))
 	},
-	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2) {
+	{ PINMUX_CFG_REG("PNCR", 0xa4050118, 16, 2, GROUP(
 		PTN7_FN, PTN7_OUT, 0, PTN7_IN,
 		PTN6_FN, PTN6_OUT, 0, PTN6_IN,
 		PTN5_FN, PTN5_OUT, 0, PTN5_IN,
@@ -1870,9 +1870,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTN3_FN, PTN3_OUT, 0, PTN3_IN,
 		PTN2_FN, PTN2_OUT, 0, PTN2_IN,
 		PTN1_FN, PTN1_OUT, 0, PTN1_IN,
-		PTN0_FN, PTN0_OUT, 0, PTN0_IN }
+		PTN0_FN, PTN0_OUT, 0, PTN0_IN ))
 	},
-	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2) {
+	{ PINMUX_CFG_REG("PQCR", 0xa405011a, 16, 2, GROUP(
 		PTQ7_FN, PTQ7_OUT, 0, PTQ7_IN,
 		PTQ6_FN, PTQ6_OUT, 0, PTQ6_IN,
 		PTQ5_FN, PTQ5_OUT, 0, PTQ5_IN,
@@ -1880,9 +1880,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTQ3_FN, PTQ3_OUT, 0, PTQ3_IN,
 		PTQ2_FN, PTQ2_OUT, 0, PTQ2_IN,
 		PTQ1_FN, PTQ1_OUT, 0, PTQ1_IN,
-		PTQ0_FN, PTQ0_OUT, 0, PTQ0_IN }
+		PTQ0_FN, PTQ0_OUT, 0, PTQ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xa405011c, 16, 2, GROUP(
 		PTR7_FN, PTR7_OUT, 0, PTR7_IN,
 		PTR6_FN, PTR6_OUT, 0, PTR6_IN,
 		PTR5_FN, PTR5_OUT, 0, PTR5_IN,
@@ -1890,9 +1890,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTR3_FN, 0,        0, PTR3_IN,
 		PTR2_FN, 0,        0, PTR2_IN,
 		PTR1_FN, PTR1_OUT, 0, PTR1_IN,
-		PTR0_FN, PTR0_OUT, 0, PTR0_IN }
+		PTR0_FN, PTR0_OUT, 0, PTR0_IN ))
 	},
-	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2) {
+	{ PINMUX_CFG_REG("PSCR", 0xa405011e, 16, 2, GROUP(
 		0, 0, 0, 0,
 		PTS6_FN, PTS6_OUT, 0, PTS6_IN,
 		PTS5_FN, PTS5_OUT, 0, PTS5_IN,
@@ -1900,9 +1900,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTS3_FN, PTS3_OUT, 0, PTS3_IN,
 		PTS2_FN, PTS2_OUT, 0, PTS2_IN,
 		PTS1_FN, PTS1_OUT, 0, PTS1_IN,
-		PTS0_FN, PTS0_OUT, 0, PTS0_IN }
+		PTS0_FN, PTS0_OUT, 0, PTS0_IN ))
 	},
-	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2) {
+	{ PINMUX_CFG_REG("PTCR", 0xa4050140, 16, 2, GROUP(
 		PTT7_FN, PTT7_OUT, 0, PTT7_IN,
 		PTT6_FN, PTT6_OUT, 0, PTT6_IN,
 		PTT5_FN, PTT5_OUT, 0, PTT5_IN,
@@ -1910,9 +1910,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTT3_FN, PTT3_OUT, 0, PTT3_IN,
 		PTT2_FN, PTT2_OUT, 0, PTT2_IN,
 		PTT1_FN, PTT1_OUT, 0, PTT1_IN,
-		PTT0_FN, PTT0_OUT, 0, PTT0_IN }
+		PTT0_FN, PTT0_OUT, 0, PTT0_IN ))
 	},
-	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2) {
+	{ PINMUX_CFG_REG("PUCR", 0xa4050142, 16, 2, GROUP(
 		PTU7_FN, PTU7_OUT, 0, PTU7_IN,
 		PTU6_FN, PTU6_OUT, 0, PTU6_IN,
 		PTU5_FN, PTU5_OUT, 0, PTU5_IN,
@@ -1920,9 +1920,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTU3_FN, PTU3_OUT, 0, PTU3_IN,
 		PTU2_FN, PTU2_OUT, 0, PTU2_IN,
 		PTU1_FN, PTU1_OUT, 0, PTU1_IN,
-		PTU0_FN, PTU0_OUT, 0, PTU0_IN }
+		PTU0_FN, PTU0_OUT, 0, PTU0_IN ))
 	},
-	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2) {
+	{ PINMUX_CFG_REG("PVCR", 0xa4050144, 16, 2, GROUP(
 		PTV7_FN, PTV7_OUT, 0, PTV7_IN,
 		PTV6_FN, PTV6_OUT, 0, PTV6_IN,
 		PTV5_FN, PTV5_OUT, 0, PTV5_IN,
@@ -1930,9 +1930,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTV3_FN, PTV3_OUT, 0, PTV3_IN,
 		PTV2_FN, PTV2_OUT, 0, PTV2_IN,
 		PTV1_FN, PTV1_OUT, 0, PTV1_IN,
-		PTV0_FN, PTV0_OUT, 0, PTV0_IN }
+		PTV0_FN, PTV0_OUT, 0, PTV0_IN ))
 	},
-	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2) {
+	{ PINMUX_CFG_REG("PWCR", 0xa4050146, 16, 2, GROUP(
 		PTW7_FN, PTW7_OUT, 0, PTW7_IN,
 		PTW6_FN, PTW6_OUT, 0, PTW6_IN,
 		PTW5_FN, PTW5_OUT, 0, PTW5_IN,
@@ -1940,9 +1940,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTW3_FN, PTW3_OUT, 0, PTW3_IN,
 		PTW2_FN, PTW2_OUT, 0, PTW2_IN,
 		PTW1_FN, PTW1_OUT, 0, PTW1_IN,
-		PTW0_FN, PTW0_OUT, 0, PTW0_IN }
+		PTW0_FN, PTW0_OUT, 0, PTW0_IN ))
 	},
-	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2) {
+	{ PINMUX_CFG_REG("PXCR", 0xa4050148, 16, 2, GROUP(
 		PTX7_FN, PTX7_OUT, 0, PTX7_IN,
 		PTX6_FN, PTX6_OUT, 0, PTX6_IN,
 		PTX5_FN, PTX5_OUT, 0, PTX5_IN,
@@ -1950,9 +1950,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTX3_FN, PTX3_OUT, 0, PTX3_IN,
 		PTX2_FN, PTX2_OUT, 0, PTX2_IN,
 		PTX1_FN, PTX1_OUT, 0, PTX1_IN,
-		PTX0_FN, PTX0_OUT, 0, PTX0_IN }
+		PTX0_FN, PTX0_OUT, 0, PTX0_IN ))
 	},
-	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2) {
+	{ PINMUX_CFG_REG("PYCR", 0xa405014a, 16, 2, GROUP(
 		PTY7_FN, PTY7_OUT, 0, PTY7_IN,
 		PTY6_FN, PTY6_OUT, 0, PTY6_IN,
 		PTY5_FN, PTY5_OUT, 0, PTY5_IN,
@@ -1960,9 +1960,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTY3_FN, PTY3_OUT, 0, PTY3_IN,
 		PTY2_FN, PTY2_OUT, 0, PTY2_IN,
 		PTY1_FN, PTY1_OUT, 0, PTY1_IN,
-		PTY0_FN, PTY0_OUT, 0, PTY0_IN }
+		PTY0_FN, PTY0_OUT, 0, PTY0_IN ))
 	},
-	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2) {
+	{ PINMUX_CFG_REG("PZCR", 0xa405014c, 16, 2, GROUP(
 		PTZ7_FN, PTZ7_OUT, 0, PTZ7_IN,
 		PTZ6_FN, PTZ6_OUT, 0, PTZ6_IN,
 		PTZ5_FN, PTZ5_OUT, 0, PTZ5_IN,
@@ -1970,9 +1970,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTZ3_FN, PTZ3_OUT, 0, PTZ3_IN,
 		PTZ2_FN, PTZ2_OUT, 0, PTZ2_IN,
 		PTZ1_FN, PTZ1_OUT, 0, PTZ1_IN,
-		PTZ0_FN, PTZ0_OUT, 0, PTZ0_IN }
+		PTZ0_FN, PTZ0_OUT, 0, PTZ0_IN ))
 	},
-	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 1) {
+	{ PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 1, GROUP(
 		PSA15_0, PSA15_1,
 		PSA14_0, PSA14_1,
 		PSA13_0, PSA13_1,
@@ -1988,9 +1988,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSA3_0,  PSA3_1,
 		PSA2_0,  PSA2_1,
 		PSA1_0,  PSA1_1,
-		PSA0_0,  PSA0_1}
+		PSA0_0,  PSA0_1))
 	},
-	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 1) {
+	{ PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 1, GROUP(
 		0, 0,
 		PSB14_0, PSB14_1,
 		PSB13_0, PSB13_1,
@@ -2006,9 +2006,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSB3_0,  PSB3_1,
 		PSB2_0,  PSB2_1,
 		PSB1_0,  PSB1_1,
-		PSB0_0,  PSB0_1}
+		PSB0_0,  PSB0_1))
 	},
-	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 1) {
+	{ PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 1, GROUP(
 		PSC15_0, PSC15_1,
 		PSC14_0, PSC14_1,
 		PSC13_0, PSC13_1,
@@ -2024,9 +2024,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		PSC2_0,  PSC2_1,
 		PSC1_0,  PSC1_1,
-		PSC0_0,  PSC0_1}
+		PSC0_0,  PSC0_1))
 	},
-	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 1) {
+	{ PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 1, GROUP(
 		PSD15_0, PSD15_1,
 		PSD14_0, PSD14_1,
 		PSD13_0, PSD13_1,
@@ -2042,9 +2042,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSD3_0,  PSD3_1,
 		PSD2_0,  PSD2_1,
 		PSD1_0,  PSD1_1,
-		PSD0_0,  PSD0_1}
+		PSD0_0,  PSD0_1))
 	},
-	{ PINMUX_CFG_REG("PSELE", 0xa4050156, 16, 1) {
+	{ PINMUX_CFG_REG("PSELE", 0xa4050156, 16, 1, GROUP(
 		PSE15_0, PSE15_1,
 		PSE14_0, PSE14_1,
 		PSE13_0, PSE13_1,
@@ -2060,7 +2060,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PSE3_0,  PSE3_1,
 		PSE2_0,  PSE2_1,
 		PSE1_0,  PSE1_1,
-		PSE0_0,  PSE0_1}
+		PSE0_0,  PSE0_1))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 6502e67..3174ffb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -1638,7 +1638,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xFFFC0004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xFFFC0004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP2_2_0,
 		GP_0_30_FN, FN_IP1_31_29,
 		GP_0_29_FN, FN_IP1_28_26,
@@ -1670,9 +1670,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP1_15_14,
 		GP_0_2_FN, FN_IP1_13_12,
 		GP_0_1_FN, FN_IP1_11_10,
-		GP_0_0_FN, FN_IP1_9_8 }
+		GP_0_0_FN, FN_IP1_9_8 ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xFFFC0008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xFFFC0008, 32, 1, GROUP(
 		GP_1_31_FN, FN_IP11_25_23,
 		GP_1_30_FN, FN_IP2_13_11,
 		GP_1_29_FN, FN_IP2_10_8,
@@ -1704,9 +1704,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP11_22_21,
 		GP_1_2_FN, FN_IP11_20_19,
 		GP_1_1_FN, FN_IP3_29_27,
-		GP_1_0_FN, FN_IP3_20 }
+		GP_1_0_FN, FN_IP3_20 ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xFFFC000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xFFFC000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP4_31_30,
 		GP_2_30_FN, FN_IP5_2_0,
 		GP_2_29_FN, FN_IP5_5_3,
@@ -1738,9 +1738,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP4_2_0,
 		GP_2_2_FN, FN_IP11_11_10,
 		GP_2_1_FN, FN_IP11_9_7,
-		GP_2_0_FN, FN_IP11_6_4 }
+		GP_2_0_FN, FN_IP11_6_4 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xFFFC0010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xFFFC0010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP9_1_0,
 		GP_3_30_FN, FN_IP8_19_18,
 		GP_3_29_FN, FN_IP8_17_16,
@@ -1772,10 +1772,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP6_9_8,
 		GP_3_2_FN, FN_IP6_7_6,
 		GP_3_1_FN, FN_IP6_5_3,
-		GP_3_0_FN, FN_IP6_2_0 }
+		GP_3_0_FN, FN_IP6_2_0 ))
 	},
 
-	{ PINMUX_CFG_REG("GPSR4", 0xFFFC0014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xFFFC0014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP10_24_23,
 		GP_4_30_FN, FN_IP10_22,
 		GP_4_29_FN, FN_IP11_18_16,
@@ -1807,9 +1807,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP9_25_24,
 		GP_4_2_FN, FN_IP9_23_22,
 		GP_4_1_FN, FN_IP9_21_20,
-		GP_4_0_FN, FN_IP9_19_18 }
+		GP_4_0_FN, FN_IP9_19_18 ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xFFFC0018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xFFFC0018, 32, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, /* 31 - 28 */
 		0, 0, 0, 0, 0, 0, 0, 0, /* 27 - 24 */
 		0, 0, 0, 0, 0, 0, 0, 0, /* 23 - 20 */
@@ -1822,7 +1822,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IRQ3_B,
 		GP_5_2_FN, FN_IRQ2_B,
 		GP_5_1_FN, FN_IP11_3,
-		GP_5_0_FN, FN_IP10_25 }
+		GP_5_0_FN, FN_IP10_25 ))
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xFFFC001C, 32,
@@ -2381,12 +2381,17 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_SCIF_CLK_0, FN_SEL_SCIF_CLK_1, FN_SEL_SCIF_CLK_2, 0  }
 	},
 	/* GPIO 0 - 5*/
-	{ PINMUX_CFG_REG("INOUTSEL0", 0xFFC40004, 32, 1) { GP_INOUTSEL(0) } },
-	{ PINMUX_CFG_REG("INOUTSEL1", 0xFFC41004, 32, 1) { GP_INOUTSEL(1) } },
-	{ PINMUX_CFG_REG("INOUTSEL2", 0xFFC42004, 32, 1) { GP_INOUTSEL(2) } },
-	{ PINMUX_CFG_REG("INOUTSEL3", 0xFFC43004, 32, 1) { GP_INOUTSEL(3) } },
-	{ PINMUX_CFG_REG("INOUTSEL4", 0xFFC44004, 32, 1) { GP_INOUTSEL(4) } },
-	{ PINMUX_CFG_REG("INOUTSEL5", 0xffc45004, 32, 1) {
+	{ PINMUX_CFG_REG("INOUTSEL0", 0xFFC40004, 32, 1, GROUP(GP_INOUTSEL(0)))
+	},
+	{ PINMUX_CFG_REG("INOUTSEL1", 0xFFC41004, 32, 1, GROUP(GP_INOUTSEL(1)))
+	},
+	{ PINMUX_CFG_REG("INOUTSEL2", 0xFFC42004, 32, 1, GROUP(GP_INOUTSEL(2)))
+	},
+	{ PINMUX_CFG_REG("INOUTSEL3", 0xFFC43004, 32, 1, GROUP(GP_INOUTSEL(3)))
+	},
+	{ PINMUX_CFG_REG("INOUTSEL4", 0xFFC44004, 32, 1, GROUP(GP_INOUTSEL(4)))
+	},
+	{ PINMUX_CFG_REG("INOUTSEL5", 0xffc45004, 32, 1, GROUP(
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* 31 - 24 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* 23 - 16 */
 		0, 0, 0, 0, 0, 0, 0, 0, /* 15 - 12 */
@@ -2401,7 +2406,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_IN, GP_5_3_OUT,
 		GP_5_2_IN, GP_5_2_OUT,
 		GP_5_1_IN, GP_5_1_OUT,
-		GP_5_0_IN, GP_5_0_OUT }
+		GP_5_0_IN, GP_5_0_OUT ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index 6d8c31c..075ee48 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -1686,7 +1686,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xffec0000, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xffec0000, 16, 2, GROUP(
 		PTA7_FN, PTA7_OUT, PTA7_IN, 0,
 		PTA6_FN, PTA6_OUT, PTA6_IN, 0,
 		PTA5_FN, PTA5_OUT, PTA5_IN, 0,
@@ -1694,9 +1694,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTA3_FN, PTA3_OUT, PTA3_IN, 0,
 		PTA2_FN, PTA2_OUT, PTA2_IN, 0,
 		PTA1_FN, PTA1_OUT, PTA1_IN, 0,
-		PTA0_FN, PTA0_OUT, PTA0_IN, 0 }
+		PTA0_FN, PTA0_OUT, PTA0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xffec0002, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xffec0002, 16, 2, GROUP(
 		PTB7_FN, PTB7_OUT, PTB7_IN, 0,
 		PTB6_FN, PTB6_OUT, PTB6_IN, 0,
 		PTB5_FN, PTB5_OUT, PTB5_IN, 0,
@@ -1704,9 +1704,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTB3_FN, PTB3_OUT, PTB3_IN, 0,
 		PTB2_FN, PTB2_OUT, PTB2_IN, 0,
 		PTB1_FN, PTB1_OUT, PTB1_IN, 0,
-		PTB0_FN, PTB0_OUT, PTB0_IN, 0 }
+		PTB0_FN, PTB0_OUT, PTB0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xffec0004, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xffec0004, 16, 2, GROUP(
 		PTC7_FN, PTC7_OUT, PTC7_IN, 0,
 		PTC6_FN, PTC6_OUT, PTC6_IN, 0,
 		PTC5_FN, PTC5_OUT, PTC5_IN, 0,
@@ -1714,9 +1714,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTC3_FN, PTC3_OUT, PTC3_IN, 0,
 		PTC2_FN, PTC2_OUT, PTC2_IN, 0,
 		PTC1_FN, PTC1_OUT, PTC1_IN, 0,
-		PTC0_FN, PTC0_OUT, PTC0_IN, 0 }
+		PTC0_FN, PTC0_OUT, PTC0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xffec0006, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xffec0006, 16, 2, GROUP(
 		PTD7_FN, PTD7_OUT, PTD7_IN, 0,
 		PTD6_FN, PTD6_OUT, PTD6_IN, 0,
 		PTD5_FN, PTD5_OUT, PTD5_IN, 0,
@@ -1724,9 +1724,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTD3_FN, PTD3_OUT, PTD3_IN, 0,
 		PTD2_FN, PTD2_OUT, PTD2_IN, 0,
 		PTD1_FN, PTD1_OUT, PTD1_IN, 0,
-		PTD0_FN, PTD0_OUT, PTD0_IN, 0 }
+		PTD0_FN, PTD0_OUT, PTD0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xffec0008, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xffec0008, 16, 2, GROUP(
 		PTE7_FN, PTE7_OUT, PTE7_IN, 0,
 		PTE6_FN, PTE6_OUT, PTE6_IN, 0,
 		PTE5_FN, PTE5_OUT, PTE5_IN, 0,
@@ -1734,9 +1734,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTE3_FN, PTE3_OUT, PTE3_IN, 0,
 		PTE2_FN, PTE2_OUT, PTE2_IN, 0,
 		PTE1_FN, PTE1_OUT, PTE1_IN, 0,
-		PTE0_FN, PTE0_OUT, PTE0_IN, 0 }
+		PTE0_FN, PTE0_OUT, PTE0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xffec000a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xffec000a, 16, 2, GROUP(
 		PTF7_FN, PTF7_OUT, PTF7_IN, 0,
 		PTF6_FN, PTF6_OUT, PTF6_IN, 0,
 		PTF5_FN, PTF5_OUT, PTF5_IN, 0,
@@ -1744,9 +1744,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTF3_FN, PTF3_OUT, PTF3_IN, 0,
 		PTF2_FN, PTF2_OUT, PTF2_IN, 0,
 		PTF1_FN, PTF1_OUT, PTF1_IN, 0,
-		PTF0_FN, PTF0_OUT, PTF0_IN, 0 }
+		PTF0_FN, PTF0_OUT, PTF0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xffec000c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xffec000c, 16, 2, GROUP(
 		PTG7_FN, PTG7_OUT, PTG7_IN, 0,
 		PTG6_FN, PTG6_OUT, PTG6_IN, 0,
 		PTG5_FN, PTG5_OUT, PTG5_IN, 0,
@@ -1754,9 +1754,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTG3_FN, PTG3_OUT, PTG3_IN, 0,
 		PTG2_FN, PTG2_OUT, PTG2_IN, 0,
 		PTG1_FN, PTG1_OUT, PTG1_IN, 0,
-		PTG0_FN, PTG0_OUT, PTG0_IN, 0 }
+		PTG0_FN, PTG0_OUT, PTG0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xffec000e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xffec000e, 16, 2, GROUP(
 		PTH7_FN, PTH7_OUT, PTH7_IN, 0,
 		PTH6_FN, PTH6_OUT, PTH6_IN, 0,
 		PTH5_FN, PTH5_OUT, PTH5_IN, 0,
@@ -1764,9 +1764,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTH3_FN, PTH3_OUT, PTH3_IN, 0,
 		PTH2_FN, PTH2_OUT, PTH2_IN, 0,
 		PTH1_FN, PTH1_OUT, PTH1_IN, 0,
-		PTH0_FN, PTH0_OUT, PTH0_IN, 0 }
+		PTH0_FN, PTH0_OUT, PTH0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PICR", 0xffec0010, 16, 2) {
+	{ PINMUX_CFG_REG("PICR", 0xffec0010, 16, 2, GROUP(
 		PTI7_FN, PTI7_OUT, PTI7_IN, 0,
 		PTI6_FN, PTI6_OUT, PTI6_IN, 0,
 		PTI5_FN, PTI5_OUT, PTI5_IN, 0,
@@ -1774,9 +1774,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTI3_FN, PTI3_OUT, PTI3_IN, 0,
 		PTI2_FN, PTI2_OUT, PTI2_IN, 0,
 		PTI1_FN, PTI1_OUT, PTI1_IN, 0,
-		PTI0_FN, PTI0_OUT, PTI0_IN, 0 }
+		PTI0_FN, PTI0_OUT, PTI0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xffec0012, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xffec0012, 16, 2, GROUP(
 		0, 0, 0, 0,	/* reserved: always set 1 */
 		PTJ6_FN, PTJ6_OUT, PTJ6_IN, 0,
 		PTJ5_FN, PTJ5_OUT, PTJ5_IN, 0,
@@ -1784,9 +1784,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTJ3_FN, PTJ3_OUT, PTJ3_IN, 0,
 		PTJ2_FN, PTJ2_OUT, PTJ2_IN, 0,
 		PTJ1_FN, PTJ1_OUT, PTJ1_IN, 0,
-		PTJ0_FN, PTJ0_OUT, PTJ0_IN, 0 }
+		PTJ0_FN, PTJ0_OUT, PTJ0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xffec0014, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xffec0014, 16, 2, GROUP(
 		PTK7_FN, PTK7_OUT, PTK7_IN, 0,
 		PTK6_FN, PTK6_OUT, PTK6_IN, 0,
 		PTK5_FN, PTK5_OUT, PTK5_IN, 0,
@@ -1794,9 +1794,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTK3_FN, PTK3_OUT, PTK3_IN, 0,
 		PTK2_FN, PTK2_OUT, PTK2_IN, 0,
 		PTK1_FN, PTK1_OUT, PTK1_IN, 0,
-		PTK0_FN, PTK0_OUT, PTK0_IN, 0 }
+		PTK0_FN, PTK0_OUT, PTK0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xffec0016, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xffec0016, 16, 2, GROUP(
 		0, 0, 0, 0,	/* reserved: always set 1 */
 		PTL6_FN, PTL6_OUT, PTL6_IN, 0,
 		PTL5_FN, PTL5_OUT, PTL5_IN, 0,
@@ -1804,9 +1804,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTL3_FN, PTL3_OUT, PTL3_IN, 0,
 		PTL2_FN, PTL2_OUT, PTL2_IN, 0,
 		PTL1_FN, PTL1_OUT, PTL1_IN, 0,
-		PTL0_FN, PTL0_OUT, PTL0_IN, 0 }
+		PTL0_FN, PTL0_OUT, PTL0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xffec0018, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xffec0018, 16, 2, GROUP(
 		PTM7_FN, PTM7_OUT, PTM7_IN, 0,
 		PTM6_FN, PTM6_OUT, PTM6_IN, 0,
 		PTM5_FN, PTM5_OUT, PTM5_IN, 0,
@@ -1814,9 +1814,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTM3_FN, PTM3_OUT, PTM3_IN, 0,
 		PTM2_FN, PTM2_OUT, PTM2_IN, 0,
 		PTM1_FN, PTM1_OUT, PTM1_IN, 0,
-		PTM0_FN, PTM0_OUT, PTM0_IN, 0 }
+		PTM0_FN, PTM0_OUT, PTM0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PNCR", 0xffec001a, 16, 2) {
+	{ PINMUX_CFG_REG("PNCR", 0xffec001a, 16, 2, GROUP(
 		0, 0, 0, 0,	/* reserved: always set 1 */
 		PTN6_FN, PTN6_OUT, PTN6_IN, 0,
 		PTN5_FN, PTN5_OUT, PTN5_IN, 0,
@@ -1824,9 +1824,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTN3_FN, PTN3_OUT, PTN3_IN, 0,
 		PTN2_FN, PTN2_OUT, PTN2_IN, 0,
 		PTN1_FN, PTN1_OUT, PTN1_IN, 0,
-		PTN0_FN, PTN0_OUT, PTN0_IN, 0 }
+		PTN0_FN, PTN0_OUT, PTN0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("POCR", 0xffec001c, 16, 2) {
+	{ PINMUX_CFG_REG("POCR", 0xffec001c, 16, 2, GROUP(
 		PTO7_FN, PTO7_OUT, PTO7_IN, 0,
 		PTO6_FN, PTO6_OUT, PTO6_IN, 0,
 		PTO5_FN, PTO5_OUT, PTO5_IN, 0,
@@ -1834,10 +1834,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTO3_FN, PTO3_OUT, PTO3_IN, 0,
 		PTO2_FN, PTO2_OUT, PTO2_IN, 0,
 		PTO1_FN, PTO1_OUT, PTO1_IN, 0,
-		PTO0_FN, PTO0_OUT, PTO0_IN, 0 }
+		PTO0_FN, PTO0_OUT, PTO0_IN, 0 ))
 	},
 #if 0	/* FIXME: Remove it? */
-	{ PINMUX_CFG_REG("PPCR", 0xffec001e, 16, 2) {
+	{ PINMUX_CFG_REG("PPCR", 0xffec001e, 16, 2, GROUP(
 		0, 0, 0, 0,	/* reserved: always set 1 */
 		PTP6_FN, PTP6_OUT, PTP6_IN, 0,
 		PTP5_FN, PTP5_OUT, PTP5_IN, 0,
@@ -1845,10 +1845,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTP3_FN, PTP3_OUT, PTP3_IN, 0,
 		PTP2_FN, PTP2_OUT, PTP2_IN, 0,
 		PTP1_FN, PTP1_OUT, PTP1_IN, 0,
-		PTP0_FN, PTP0_OUT, PTP0_IN, 0 }
+		PTP0_FN, PTP0_OUT, PTP0_IN, 0 ))
 	},
 #endif
-	{ PINMUX_CFG_REG("PQCR", 0xffec0020, 16, 2) {
+	{ PINMUX_CFG_REG("PQCR", 0xffec0020, 16, 2, GROUP(
 		0, 0, 0, 0,	/* reserved: always set 1 */
 		PTQ6_FN, PTQ6_OUT, PTQ6_IN, 0,
 		PTQ5_FN, PTQ5_OUT, PTQ5_IN, 0,
@@ -1856,9 +1856,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTQ3_FN, PTQ3_OUT, PTQ3_IN, 0,
 		PTQ2_FN, PTQ2_OUT, PTQ2_IN, 0,
 		PTQ1_FN, PTQ1_OUT, PTQ1_IN, 0,
-		PTQ0_FN, PTQ0_OUT, PTQ0_IN, 0 }
+		PTQ0_FN, PTQ0_OUT, PTQ0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xffec0022, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xffec0022, 16, 2, GROUP(
 		PTR7_FN, PTR7_OUT, PTR7_IN, 0,
 		PTR6_FN, PTR6_OUT, PTR6_IN, 0,
 		PTR5_FN, PTR5_OUT, PTR5_IN, 0,
@@ -1866,9 +1866,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTR3_FN, PTR3_OUT, PTR3_IN, 0,
 		PTR2_FN, PTR2_OUT, PTR2_IN, 0,
 		PTR1_FN, PTR1_OUT, PTR1_IN, 0,
-		PTR0_FN, PTR0_OUT, PTR0_IN, 0 }
+		PTR0_FN, PTR0_OUT, PTR0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PSCR", 0xffec0024, 16, 2) {
+	{ PINMUX_CFG_REG("PSCR", 0xffec0024, 16, 2, GROUP(
 		PTS7_FN, PTS7_OUT, PTS7_IN, 0,
 		PTS6_FN, PTS6_OUT, PTS6_IN, 0,
 		PTS5_FN, PTS5_OUT, PTS5_IN, 0,
@@ -1876,9 +1876,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTS3_FN, PTS3_OUT, PTS3_IN, 0,
 		PTS2_FN, PTS2_OUT, PTS2_IN, 0,
 		PTS1_FN, PTS1_OUT, PTS1_IN, 0,
-		PTS0_FN, PTS0_OUT, PTS0_IN, 0 }
+		PTS0_FN, PTS0_OUT, PTS0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PTCR", 0xffec0026, 16, 2) {
+	{ PINMUX_CFG_REG("PTCR", 0xffec0026, 16, 2, GROUP(
 		PTT7_FN, PTT7_OUT, PTT7_IN, 0,
 		PTT6_FN, PTT6_OUT, PTT6_IN, 0,
 		PTT5_FN, PTT5_OUT, PTT5_IN, 0,
@@ -1886,9 +1886,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTT3_FN, PTT3_OUT, PTT3_IN, 0,
 		PTT2_FN, PTT2_OUT, PTT2_IN, 0,
 		PTT1_FN, PTT1_OUT, PTT1_IN, 0,
-		PTT0_FN, PTT0_OUT, PTT0_IN, 0 }
+		PTT0_FN, PTT0_OUT, PTT0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PUCR", 0xffec0028, 16, 2) {
+	{ PINMUX_CFG_REG("PUCR", 0xffec0028, 16, 2, GROUP(
 		PTU7_FN, PTU7_OUT, PTU7_IN, 0,
 		PTU6_FN, PTU6_OUT, PTU6_IN, 0,
 		PTU5_FN, PTU5_OUT, PTU5_IN, 0,
@@ -1896,9 +1896,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTU3_FN, PTU3_OUT, PTU3_IN, 0,
 		PTU2_FN, PTU2_OUT, PTU2_IN, 0,
 		PTU1_FN, PTU1_OUT, PTU1_IN, 0,
-		PTU0_FN, PTU0_OUT, PTU0_IN, 0 }
+		PTU0_FN, PTU0_OUT, PTU0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PVCR", 0xffec002a, 16, 2) {
+	{ PINMUX_CFG_REG("PVCR", 0xffec002a, 16, 2, GROUP(
 		PTV7_FN, PTV7_OUT, PTV7_IN, 0,
 		PTV6_FN, PTV6_OUT, PTV6_IN, 0,
 		PTV5_FN, PTV5_OUT, PTV5_IN, 0,
@@ -1906,9 +1906,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTV3_FN, PTV3_OUT, PTV3_IN, 0,
 		PTV2_FN, PTV2_OUT, PTV2_IN, 0,
 		PTV1_FN, PTV1_OUT, PTV1_IN, 0,
-		PTV0_FN, PTV0_OUT, PTV0_IN, 0 }
+		PTV0_FN, PTV0_OUT, PTV0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PWCR", 0xffec002c, 16, 2) {
+	{ PINMUX_CFG_REG("PWCR", 0xffec002c, 16, 2, GROUP(
 		PTW7_FN, PTW7_OUT, PTW7_IN, 0,
 		PTW6_FN, PTW6_OUT, PTW6_IN, 0,
 		PTW5_FN, PTW5_OUT, PTW5_IN, 0,
@@ -1916,9 +1916,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTW3_FN, PTW3_OUT, PTW3_IN, 0,
 		PTW2_FN, PTW2_OUT, PTW2_IN, 0,
 		PTW1_FN, PTW1_OUT, PTW1_IN, 0,
-		PTW0_FN, PTW0_OUT, PTW0_IN, 0 }
+		PTW0_FN, PTW0_OUT, PTW0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PXCR", 0xffec002e, 16, 2) {
+	{ PINMUX_CFG_REG("PXCR", 0xffec002e, 16, 2, GROUP(
 		PTX7_FN, PTX7_OUT, PTX7_IN, 0,
 		PTX6_FN, PTX6_OUT, PTX6_IN, 0,
 		PTX5_FN, PTX5_OUT, PTX5_IN, 0,
@@ -1926,9 +1926,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTX3_FN, PTX3_OUT, PTX3_IN, 0,
 		PTX2_FN, PTX2_OUT, PTX2_IN, 0,
 		PTX1_FN, PTX1_OUT, PTX1_IN, 0,
-		PTX0_FN, PTX0_OUT, PTX0_IN, 0 }
+		PTX0_FN, PTX0_OUT, PTX0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PYCR", 0xffec0030, 16, 2) {
+	{ PINMUX_CFG_REG("PYCR", 0xffec0030, 16, 2, GROUP(
 		PTY7_FN, PTY7_OUT, PTY7_IN, 0,
 		PTY6_FN, PTY6_OUT, PTY6_IN, 0,
 		PTY5_FN, PTY5_OUT, PTY5_IN, 0,
@@ -1936,9 +1936,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTY3_FN, PTY3_OUT, PTY3_IN, 0,
 		PTY2_FN, PTY2_OUT, PTY2_IN, 0,
 		PTY1_FN, PTY1_OUT, PTY1_IN, 0,
-		PTY0_FN, PTY0_OUT, PTY0_IN, 0 }
+		PTY0_FN, PTY0_OUT, PTY0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PZCR", 0xffec0032, 16, 2) {
+	{ PINMUX_CFG_REG("PZCR", 0xffec0032, 16, 2, GROUP(
 		PTZ7_FN, PTZ7_OUT, PTZ7_IN, 0,
 		PTZ6_FN, PTZ6_OUT, PTZ6_IN, 0,
 		PTZ5_FN, PTZ5_OUT, PTZ5_IN, 0,
@@ -1946,10 +1946,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PTZ3_FN, PTZ3_OUT, PTZ3_IN, 0,
 		PTZ2_FN, PTZ2_OUT, PTZ2_IN, 0,
 		PTZ1_FN, PTZ1_OUT, PTZ1_IN, 0,
-		PTZ0_FN, PTZ0_OUT, PTZ0_IN, 0 }
+		PTZ0_FN, PTZ0_OUT, PTZ0_IN, 0 ))
 	},
 
-	{ PINMUX_CFG_REG("PSEL0", 0xffec0070, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL0", 0xffec0070, 16, 1, GROUP(
 		PS0_15_FN1, PS0_15_FN2,
 		PS0_14_FN1, PS0_14_FN2,
 		PS0_13_FN1, PS0_13_FN2,
@@ -1965,9 +1965,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PS0_3_FN1, PS0_3_FN2,
 		PS0_2_FN1, PS0_2_FN2,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PSEL1", 0xffec0072, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL1", 0xffec0072, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1983,9 +1983,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		PS1_2_FN1, PS1_2_FN2,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PSEL2", 0xffec0074, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL2", 0xffec0074, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		PS2_13_FN1, PS2_13_FN2,
@@ -2001,9 +2001,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		PS2_2_FN1, PS2_2_FN2,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PSEL3", 0xffec0076, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL3", 0xffec0076, 16, 1, GROUP(
 		PS3_15_FN1, PS3_15_FN2,
 		PS3_14_FN1, PS3_14_FN2,
 		PS3_13_FN1, PS3_13_FN2,
@@ -2019,10 +2019,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		PS3_2_FN1, PS3_2_FN2,
 		PS3_1_FN1, PS3_1_FN2,
-		0, 0, }
+		0, 0, ))
 	},
 
-	{ PINMUX_CFG_REG("PSEL4", 0xffec0078, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL4", 0xffec0078, 16, 1, GROUP(
 		0, 0,
 		PS4_14_FN1, PS4_14_FN2,
 		PS4_13_FN1, PS4_13_FN2,
@@ -2038,9 +2038,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PS4_3_FN1, PS4_3_FN2,
 		PS4_2_FN1, PS4_2_FN2,
 		PS4_1_FN1, PS4_1_FN2,
-		PS4_0_FN1, PS4_0_FN2, }
+		PS4_0_FN1, PS4_0_FN2, ))
 	},
-	{ PINMUX_CFG_REG("PSEL5", 0xffec007a, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL5", 0xffec007a, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -2056,9 +2056,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PS5_3_FN1, PS5_3_FN2,
 		PS5_2_FN1, PS5_2_FN2,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PSEL6", 0xffec007c, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL6", 0xffec007c, 16, 1, GROUP(
 		PS6_15_FN1, PS6_15_FN2,
 		PS6_14_FN1, PS6_14_FN2,
 		PS6_13_FN1, PS6_13_FN2,
@@ -2074,9 +2074,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PS6_3_FN1, PS6_3_FN2,
 		PS6_2_FN1, PS6_2_FN2,
 		PS6_1_FN1, PS6_1_FN2,
-		PS6_0_FN1, PS6_0_FN2, }
+		PS6_0_FN1, PS6_0_FN2, ))
 	},
-	{ PINMUX_CFG_REG("PSEL7", 0xffec0082, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL7", 0xffec0082, 16, 1, GROUP(
 		PS7_15_FN1, PS7_15_FN2,
 		PS7_14_FN1, PS7_14_FN2,
 		PS7_13_FN1, PS7_13_FN2,
@@ -2092,9 +2092,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PSEL8", 0xffec0084, 16, 1) {
+	{ PINMUX_CFG_REG("PSEL8", 0xffec0084, 16, 1, GROUP(
 		PS8_15_FN1, PS8_15_FN2,
 		PS8_14_FN1, PS8_14_FN2,
 		PS8_13_FN1, PS8_13_FN2,
@@ -2110,7 +2110,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0, }
+		0, 0, ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 1934cbe..73a30fd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -988,7 +988,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xffe70000, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xffe70000, 16, 2, GROUP(
 		PA7_FN, PA7_OUT, PA7_IN, 0,
 		PA6_FN, PA6_OUT, PA6_IN, 0,
 		PA5_FN, PA5_OUT, PA5_IN, 0,
@@ -996,9 +996,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PA3_FN, PA3_OUT, PA3_IN, 0,
 		PA2_FN, PA2_OUT, PA2_IN, 0,
 		PA1_FN, PA1_OUT, PA1_IN, 0,
-		PA0_FN, PA0_OUT, PA0_IN, 0 }
+		PA0_FN, PA0_OUT, PA0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xffe70002, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xffe70002, 16, 2, GROUP(
 		PB7_FN, PB7_OUT, PB7_IN, 0,
 		PB6_FN, PB6_OUT, PB6_IN, 0,
 		PB5_FN, PB5_OUT, PB5_IN, 0,
@@ -1006,9 +1006,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB3_FN, PB3_OUT, PB3_IN, 0,
 		PB2_FN, PB2_OUT, PB2_IN, 0,
 		PB1_FN, PB1_OUT, PB1_IN, 0,
-		PB0_FN, PB0_OUT, PB0_IN, 0 }
+		PB0_FN, PB0_OUT, PB0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xffe70004, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xffe70004, 16, 2, GROUP(
 		PC7_FN, PC7_OUT, PC7_IN, 0,
 		PC6_FN, PC6_OUT, PC6_IN, 0,
 		PC5_FN, PC5_OUT, PC5_IN, 0,
@@ -1016,9 +1016,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC3_FN, PC3_OUT, PC3_IN, 0,
 		PC2_FN, PC2_OUT, PC2_IN, 0,
 		PC1_FN, PC1_OUT, PC1_IN, 0,
-		PC0_FN, PC0_OUT, PC0_IN, 0 }
+		PC0_FN, PC0_OUT, PC0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xffe70006, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xffe70006, 16, 2, GROUP(
 		PD7_FN, PD7_OUT, PD7_IN, 0,
 		PD6_FN, PD6_OUT, PD6_IN, 0,
 		PD5_FN, PD5_OUT, PD5_IN, 0,
@@ -1026,9 +1026,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_FN, PD3_OUT, PD3_IN, 0,
 		PD2_FN, PD2_OUT, PD2_IN, 0,
 		PD1_FN, PD1_OUT, PD1_IN, 0,
-		PD0_FN, PD0_OUT, PD0_IN, 0 }
+		PD0_FN, PD0_OUT, PD0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xffe70008, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xffe70008, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PE5_FN, PE5_OUT, PE5_IN, 0,
@@ -1036,9 +1036,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PE3_FN, PE3_OUT, PE3_IN, 0,
 		PE2_FN, PE2_OUT, PE2_IN, 0,
 		PE1_FN, PE1_OUT, PE1_IN, 0,
-		PE0_FN, PE0_OUT, PE0_IN, 0 }
+		PE0_FN, PE0_OUT, PE0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xffe7000a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xffe7000a, 16, 2, GROUP(
 		PF7_FN, PF7_OUT, PF7_IN, 0,
 		PF6_FN, PF6_OUT, PF6_IN, 0,
 		PF5_FN, PF5_OUT, PF5_IN, 0,
@@ -1046,9 +1046,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_FN, PF3_OUT, PF3_IN, 0,
 		PF2_FN, PF2_OUT, PF2_IN, 0,
 		PF1_FN, PF1_OUT, PF1_IN, 0,
-		PF0_FN, PF0_OUT, PF0_IN, 0 }
+		PF0_FN, PF0_OUT, PF0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xffe7000c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xffe7000c, 16, 2, GROUP(
 		PG7_FN, PG7_OUT, PG7_IN, 0,
 		PG6_FN, PG6_OUT, PG6_IN, 0,
 		PG5_FN, PG5_OUT, PG5_IN, 0,
@@ -1056,9 +1056,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PG3_FN, PG3_OUT, PG3_IN, 0,
 		PG2_FN, PG2_OUT, PG2_IN, 0,
 		PG1_FN, PG1_OUT, PG1_IN, 0,
-		PG0_FN, PG0_OUT, PG0_IN, 0 }
+		PG0_FN, PG0_OUT, PG0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xffe7000e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xffe7000e, 16, 2, GROUP(
 		PH7_FN, PH7_OUT, PH7_IN, 0,
 		PH6_FN, PH6_OUT, PH6_IN, 0,
 		PH5_FN, PH5_OUT, PH5_IN, 0,
@@ -1066,9 +1066,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PH3_FN, PH3_OUT, PH3_IN, 0,
 		PH2_FN, PH2_OUT, PH2_IN, 0,
 		PH1_FN, PH1_OUT, PH1_IN, 0,
-		PH0_FN, PH0_OUT, PH0_IN, 0 }
+		PH0_FN, PH0_OUT, PH0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xffe70010, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xffe70010, 16, 2, GROUP(
 		PJ7_FN, PJ7_OUT, PJ7_IN, 0,
 		PJ6_FN, PJ6_OUT, PJ6_IN, 0,
 		PJ5_FN, PJ5_OUT, PJ5_IN, 0,
@@ -1076,9 +1076,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ3_FN, PJ3_OUT, PJ3_IN, 0,
 		PJ2_FN, PJ2_OUT, PJ2_IN, 0,
 		PJ1_FN, PJ1_OUT, PJ1_IN, 0,
-		PJ0_FN, PJ0_OUT, PJ0_IN, 0 }
+		PJ0_FN, PJ0_OUT, PJ0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PKCR", 0xffe70012, 16, 2) {
+	{ PINMUX_CFG_REG("PKCR", 0xffe70012, 16, 2, GROUP(
 		PK7_FN, PK7_OUT, PK7_IN, 0,
 		PK6_FN, PK6_OUT, PK6_IN, 0,
 		PK5_FN, PK5_OUT, PK5_IN, 0,
@@ -1086,9 +1086,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PK3_FN, PK3_OUT, PK3_IN, 0,
 		PK2_FN, PK2_OUT, PK2_IN, 0,
 		PK1_FN, PK1_OUT, PK1_IN, 0,
-		PK0_FN, PK0_OUT, PK0_IN, 0 }
+		PK0_FN, PK0_OUT, PK0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PLCR", 0xffe70014, 16, 2) {
+	{ PINMUX_CFG_REG("PLCR", 0xffe70014, 16, 2, GROUP(
 		PL7_FN, PL7_OUT, PL7_IN, 0,
 		PL6_FN, PL6_OUT, PL6_IN, 0,
 		PL5_FN, PL5_OUT, PL5_IN, 0,
@@ -1096,9 +1096,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PL3_FN, PL3_OUT, PL3_IN, 0,
 		PL2_FN, PL2_OUT, PL2_IN, 0,
 		PL1_FN, PL1_OUT, PL1_IN, 0,
-		PL0_FN, PL0_OUT, PL0_IN, 0 }
+		PL0_FN, PL0_OUT, PL0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PMCR", 0xffe70016, 16, 2) {
+	{ PINMUX_CFG_REG("PMCR", 0xffe70016, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1106,9 +1106,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PM1_FN, PM1_OUT, PM1_IN, 0,
-		PM0_FN, PM0_OUT, PM0_IN, 0 }
+		PM0_FN, PM0_OUT, PM0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PNCR", 0xffe70018, 16, 2) {
+	{ PINMUX_CFG_REG("PNCR", 0xffe70018, 16, 2, GROUP(
 		PN7_FN, PN7_OUT, PN7_IN, 0,
 		PN6_FN, PN6_OUT, PN6_IN, 0,
 		PN5_FN, PN5_OUT, PN5_IN, 0,
@@ -1116,9 +1116,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PN3_FN, PN3_OUT, PN3_IN, 0,
 		PN2_FN, PN2_OUT, PN2_IN, 0,
 		PN1_FN, PN1_OUT, PN1_IN, 0,
-		PN0_FN, PN0_OUT, PN0_IN, 0 }
+		PN0_FN, PN0_OUT, PN0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PPCR", 0xffe7001a, 16, 2) {
+	{ PINMUX_CFG_REG("PPCR", 0xffe7001a, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		PP5_FN, PP5_OUT, PP5_IN, 0,
@@ -1126,9 +1126,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PP3_FN, PP3_OUT, PP3_IN, 0,
 		PP2_FN, PP2_OUT, PP2_IN, 0,
 		PP1_FN, PP1_OUT, PP1_IN, 0,
-		PP0_FN, PP0_OUT, PP0_IN, 0 }
+		PP0_FN, PP0_OUT, PP0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PQCR", 0xffe7001c, 16, 2) {
+	{ PINMUX_CFG_REG("PQCR", 0xffe7001c, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1136,9 +1136,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PQ3_FN, PQ3_OUT, PQ3_IN, 0,
 		PQ2_FN, PQ2_OUT, PQ2_IN, 0,
 		PQ1_FN, PQ1_OUT, PQ1_IN, 0,
-		PQ0_FN, PQ0_OUT, PQ0_IN, 0 }
+		PQ0_FN, PQ0_OUT, PQ0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PRCR", 0xffe7001e, 16, 2) {
+	{ PINMUX_CFG_REG("PRCR", 0xffe7001e, 16, 2, GROUP(
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -1146,9 +1146,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PR3_FN, PR3_OUT, PR3_IN, 0,
 		PR2_FN, PR2_OUT, PR2_IN, 0,
 		PR1_FN, PR1_OUT, PR1_IN, 0,
-		PR0_FN, PR0_OUT, PR0_IN, 0 }
+		PR0_FN, PR0_OUT, PR0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("P1MSELR", 0xffe70080, 16, 1) {
+	{ PINMUX_CFG_REG("P1MSELR", 0xffe70080, 16, 1, GROUP(
 		P1MSEL15_0, P1MSEL15_1,
 		P1MSEL14_0, P1MSEL14_1,
 		P1MSEL13_0, P1MSEL13_1,
@@ -1164,9 +1164,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		P1MSEL3_0, P1MSEL3_1,
 		P1MSEL2_0, P1MSEL2_1,
 		P1MSEL1_0, P1MSEL1_1,
-		P1MSEL0_0, P1MSEL0_1 }
+		P1MSEL0_0, P1MSEL0_1 ))
 	},
-	{ PINMUX_CFG_REG("P2MSELR", 0xffe70082, 16, 1) {
+	{ PINMUX_CFG_REG("P2MSELR", 0xffe70082, 16, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -1182,7 +1182,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		P2MSEL2_0, P2MSEL2_1,
 		P2MSEL1_0, P2MSEL1_1,
-		P2MSEL0_0, P2MSEL0_1 }
+		P2MSEL0_0, P2MSEL0_1 ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index c98585d..c91d245 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -630,7 +630,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PACR", 0xffcc0000, 16, 2) {
+	{ PINMUX_CFG_REG("PACR", 0xffcc0000, 16, 2, GROUP(
 		PA7_FN, PA7_OUT, PA7_IN, 0,
 		PA6_FN, PA6_OUT, PA6_IN, 0,
 		PA5_FN, PA5_OUT, PA5_IN, 0,
@@ -638,9 +638,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PA3_FN, PA3_OUT, PA3_IN, 0,
 		PA2_FN, PA2_OUT, PA2_IN, 0,
 		PA1_FN, PA1_OUT, PA1_IN, 0,
-		PA0_FN, PA0_OUT, PA0_IN, 0 }
+		PA0_FN, PA0_OUT, PA0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PBCR", 0xffcc0002, 16, 2) {
+	{ PINMUX_CFG_REG("PBCR", 0xffcc0002, 16, 2, GROUP(
 		PB7_FN, PB7_OUT, PB7_IN, 0,
 		PB6_FN, PB6_OUT, PB6_IN, 0,
 		PB5_FN, PB5_OUT, PB5_IN, 0,
@@ -648,9 +648,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB3_FN, PB3_OUT, PB3_IN, 0,
 		PB2_FN, PB2_OUT, PB2_IN, 0,
 		PB1_FN, PB1_OUT, PB1_IN, 0,
-		PB0_FN, PB0_OUT, PB0_IN, 0 }
+		PB0_FN, PB0_OUT, PB0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PCCR", 0xffcc0004, 16, 2) {
+	{ PINMUX_CFG_REG("PCCR", 0xffcc0004, 16, 2, GROUP(
 		PC7_FN, PC7_OUT, PC7_IN, 0,
 		PC6_FN, PC6_OUT, PC6_IN, 0,
 		PC5_FN, PC5_OUT, PC5_IN, 0,
@@ -658,9 +658,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PC3_FN, PC3_OUT, PC3_IN, 0,
 		PC2_FN, PC2_OUT, PC2_IN, 0,
 		PC1_FN, PC1_OUT, PC1_IN, 0,
-		PC0_FN, PC0_OUT, PC0_IN, 0 }
+		PC0_FN, PC0_OUT, PC0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PDCR", 0xffcc0006, 16, 2) {
+	{ PINMUX_CFG_REG("PDCR", 0xffcc0006, 16, 2, GROUP(
 		PD7_FN, PD7_OUT, PD7_IN, 0,
 		PD6_FN, PD6_OUT, PD6_IN, 0,
 		PD5_FN, PD5_OUT, PD5_IN, 0,
@@ -668,9 +668,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_FN, PD3_OUT, PD3_IN, 0,
 		PD2_FN, PD2_OUT, PD2_IN, 0,
 		PD1_FN, PD1_OUT, PD1_IN, 0,
-		PD0_FN, PD0_OUT, PD0_IN, 0 }
+		PD0_FN, PD0_OUT, PD0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PECR", 0xffcc0008, 16, 2) {
+	{ PINMUX_CFG_REG("PECR", 0xffcc0008, 16, 2, GROUP(
 		PE7_FN, PE7_OUT, PE7_IN, 0,
 		PE6_FN, PE6_OUT, PE6_IN, 0,
 		0, 0, 0, 0,
@@ -678,9 +678,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PFCR", 0xffcc000a, 16, 2) {
+	{ PINMUX_CFG_REG("PFCR", 0xffcc000a, 16, 2, GROUP(
 		PF7_FN, PF7_OUT, PF7_IN, 0,
 		PF6_FN, PF6_OUT, PF6_IN, 0,
 		PF5_FN, PF5_OUT, PF5_IN, 0,
@@ -688,9 +688,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_FN, PF3_OUT, PF3_IN, 0,
 		PF2_FN, PF2_OUT, PF2_IN, 0,
 		PF1_FN, PF1_OUT, PF1_IN, 0,
-		PF0_FN, PF0_OUT, PF0_IN, 0 }
+		PF0_FN, PF0_OUT, PF0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PGCR", 0xffcc000c, 16, 2) {
+	{ PINMUX_CFG_REG("PGCR", 0xffcc000c, 16, 2, GROUP(
 		PG7_FN, PG7_OUT, PG7_IN, 0,
 		PG6_FN, PG6_OUT, PG6_IN, 0,
 		PG5_FN, PG5_OUT, PG5_IN, 0,
@@ -698,9 +698,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
 		0, 0, 0, 0,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
-	{ PINMUX_CFG_REG("PHCR", 0xffcc000e, 16, 2) {
+	{ PINMUX_CFG_REG("PHCR", 0xffcc000e, 16, 2, GROUP(
 		PH7_FN, PH7_OUT, PH7_IN, 0,
 		PH6_FN, PH6_OUT, PH6_IN, 0,
 		PH5_FN, PH5_OUT, PH5_IN, 0,
@@ -708,9 +708,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PH3_FN, PH3_OUT, PH3_IN, 0,
 		PH2_FN, PH2_OUT, PH2_IN, 0,
 		PH1_FN, PH1_OUT, PH1_IN, 0,
-		PH0_FN, PH0_OUT, PH0_IN, 0 }
+		PH0_FN, PH0_OUT, PH0_IN, 0 ))
 	},
-	{ PINMUX_CFG_REG("PJCR", 0xffcc0010, 16, 2) {
+	{ PINMUX_CFG_REG("PJCR", 0xffcc0010, 16, 2, GROUP(
 		PJ7_FN, PJ7_OUT, PJ7_IN, 0,
 		PJ6_FN, PJ6_OUT, PJ6_IN, 0,
 		PJ5_FN, PJ5_OUT, PJ5_IN, 0,
@@ -718,9 +718,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PJ3_FN, PJ3_OUT, PJ3_IN, 0,
 		PJ2_FN, PJ2_OUT, PJ2_IN, 0,
 		PJ1_FN, PJ1_OUT, PJ1_IN, 0,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
-	{ PINMUX_CFG_REG("P1MSELR", 0xffcc0080, 16, 1) {
+	{ PINMUX_CFG_REG("P1MSELR", 0xffcc0080, 16, 1, GROUP(
 		0, 0,
 		P1MSEL14_0, P1MSEL14_1,
 		P1MSEL13_0, P1MSEL13_1,
@@ -736,9 +736,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		P1MSEL3_0,  P1MSEL3_1,
 		P1MSEL2_0,  P1MSEL2_1,
 		P1MSEL1_0,  P1MSEL1_1,
-		P1MSEL0_0,  P1MSEL0_1 }
+		P1MSEL0_0,  P1MSEL0_1 ))
 	},
-	{ PINMUX_CFG_REG("P2MSELR", 0xffcc0082, 16, 1) {
+	{ PINMUX_CFG_REG("P2MSELR", 0xffcc0082, 16, 1, GROUP(
 		P2MSEL15_0, P2MSEL15_1,
 		P2MSEL14_0, P2MSEL14_1,
 		P2MSEL13_0, P2MSEL13_1,
@@ -754,7 +754,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		P2MSEL3_0,  P2MSEL3_1,
 		P2MSEL2_0,  P2MSEL2_1,
 		P2MSEL1_0,  P2MSEL1_1,
-		P2MSEL0_0,  P2MSEL0_1 }
+		P2MSEL0_0,  P2MSEL0_1 ))
 	},
 	{}
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index 3f60c90..7abe085 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -434,7 +434,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("PABCR", 0xffc70000, 32, 2) {
+	{ PINMUX_CFG_REG("PABCR", 0xffc70000, 32, 2, GROUP(
 		PA7_FN, PA7_OUT, PA7_IN, 0,
 		PA6_FN, PA6_OUT, PA6_IN, 0,
 		PA5_FN, PA5_OUT, PA5_IN, 0,
@@ -450,9 +450,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PB3_FN, PB3_OUT, PB3_IN, 0,
 		PB2_FN, PB2_OUT, PB2_IN, 0,
 		PB1_FN, PB1_OUT, PB1_IN, 0,
-		PB0_FN, PB0_OUT, PB0_IN, 0, },
+		PB0_FN, PB0_OUT, PB0_IN, 0, ))
 	},
-	{ PINMUX_CFG_REG("PCDCR", 0xffc70004, 32, 2) {
+	{ PINMUX_CFG_REG("PCDCR", 0xffc70004, 32, 2, GROUP(
 		PC7_FN, PC7_OUT, PC7_IN, 0,
 		PC6_FN, PC6_OUT, PC6_IN, 0,
 		PC5_FN, PC5_OUT, PC5_IN, 0,
@@ -468,9 +468,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PD3_FN, PD3_OUT, PD3_IN, 0,
 		PD2_FN, PD2_OUT, PD2_IN, 0,
 		PD1_FN, PD1_OUT, PD1_IN, 0,
-		PD0_FN, PD0_OUT, PD0_IN, 0, },
+		PD0_FN, PD0_OUT, PD0_IN, 0, ))
 	},
-	{ PINMUX_CFG_REG("PEFCR", 0xffc70008, 32, 2) {
+	{ PINMUX_CFG_REG("PEFCR", 0xffc70008, 32, 2, GROUP(
 		PE7_FN, PE7_OUT, PE7_IN, 0,
 		PE6_FN, PE6_OUT, PE6_IN, 0,
 		PE5_FN, PE5_OUT, PE5_IN, 0,
@@ -486,9 +486,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PF3_FN, PF3_OUT, PF3_IN, 0,
 		PF2_FN, PF2_OUT, PF2_IN, 0,
 		PF1_FN, PF1_OUT, PF1_IN, 0,
-		PF0_FN, PF0_OUT, PF0_IN, 0, },
+		PF0_FN, PF0_OUT, PF0_IN, 0, ))
 	},
-	{ PINMUX_CFG_REG("PGHCR", 0xffc7000c, 32, 2) {
+	{ PINMUX_CFG_REG("PGHCR", 0xffc7000c, 32, 2, GROUP(
 		PG7_FN, PG7_OUT, PG7_IN, 0,
 		PG6_FN, PG6_OUT, PG6_IN, 0,
 		PG5_FN, PG5_OUT, PG5_IN, 0,
@@ -504,7 +504,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		PH3_FN, PH3_OUT, PH3_IN, 0,
 		PH2_FN, PH2_OUT, PH2_IN, 0,
 		PH1_FN, PH1_OUT, PH1_IN, 0,
-		PH0_FN, PH0_OUT, PH0_IN, 0, },
+		PH0_FN, PH0_OUT, PH0_IN, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 298fd06..8ad5721 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -118,20 +118,24 @@ struct pinmux_cfg_reg {
 	const u8 *var_field_width;
 };
 
+#define GROUP(...)	__VA_ARGS__
+
 /*
  * Describe a config register consisting of several fields of the same width
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
  *   - f_width: Width of the fixed-width register fields (in bits)
- * This macro must be followed by initialization data: For each register field
- * (from left to right, i.e. MSB to LSB), 2^f_width enum IDs must be specified,
- * one for each possible combination of the register field bit values.
+ *   - ids: For each register field (from left to right, i.e. MSB to LSB),
+ *          2^f_width enum IDs must be specified, one for each possible
+ *          combination of the register field bit values, all wrapped using
+ *          the GROUP() macro.
  */
-#define PINMUX_CFG_REG(name, r, r_width, f_width) \
+#define PINMUX_CFG_REG(name, r, r_width, f_width, ids)			\
 	.reg = r, .reg_width = r_width,					\
 	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width),	\
-	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])
+	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])	\
+		{ ids }
 
 /*
  * Describe a config register consisting of several fields of different widths
-- 
2.7.4
