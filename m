From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:13 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 08/51] pinctrl: sh-pfc: Absorb
	enum IDs in PINMUX_CFG_REG_VAR() macro
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 69f7be1c6314fb0b1d5e2b101726db0c90f1ee61 upstream.

Currently the PINMUX_CFG_REG_VAR() macro must be followed by
initialization data, specifying all enum IDs.  Hence the macro itself
does not know anything about the enum IDs, preventing the macro from
performing any validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence both the register field widths and the enum
IDs are wrapped using the GROUP() macro.

No functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  47 +++++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 111 +++++++++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     |  81 ++++++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     |  89 +++++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 107 ++++++++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 123 +++++++++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     |  86 +++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     |  98 ++++++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c |  20 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     |  21 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     |  21 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    |  21 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  14 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    |  13 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      |  83 ++++++++++++---------
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  25 ++++---
 18 files changed, 572 insertions(+), 402 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c b/drivers/pinctrl/sh-pfc/pfc-emev2.c
index 6151b44..bf5e202 100644
--- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
+++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
@@ -1592,8 +1592,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_LCD3", 0xe0140284, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			1, 1, 1, 1, 2, 2, 2, 2, 2, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2,
+				   2, 2),
+			     GROUP(
 		/* 31 - 12 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1607,11 +1609,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* 1 - 0 */
 		FN_SEL_LCD3_1_0_00, FN_SEL_LCD3_1_0_01, 0, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_UART", 0xe0140288, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 2),
+			     GROUP(
 		/* 31 - 2 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1619,11 +1623,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* 1 - 0 */
 		FN_SEL_UART_1_0_00, FN_SEL_UART_1_0_01, 0, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_IIC", 0xe014028c, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 2),
+			     GROUP(
 		/* 31 - 2 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1631,11 +1637,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* 1 - 0 */
 		FN_SEL_IIC_1_0_00, FN_SEL_IIC_1_0_01, 0, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_AB", 0xe0140294, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			2, 2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2),
+			     GROUP(
 		/* 31 - 14 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1656,11 +1663,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_AB_3_2_10, FN_SEL_AB_3_2_11,
 		/* 1 - 0 */
 		FN_SEL_AB_1_0_00, 0, FN_SEL_AB_1_0_10, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_USI", 0xe0140298, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
+				   2, 2, 2),
+			     GROUP(
 		/* 31 - 10 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1675,11 +1684,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_USI_3_2_00, FN_SEL_USI_3_2_01, 0, 0,
 		/* 1 - 0 */
 		FN_SEL_USI_1_0_00, FN_SEL_USI_1_0_01, 0, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("CHG_PINSEL_HSI", 0xe01402a8, 32,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 2),
+			     GROUP(
 		/* 31 - 2 */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1687,7 +1698,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* 1 - 0 */
 		FN_SEL_HSI_1_0_00, FN_SEL_HSI_1_0_01, 0, 0,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index bad95b0..aeada74 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1687,7 +1687,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_0_FN, FN_IP13_31_28, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060040, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP0_31_28 [4] */
 		FN_SD0_WP, FN_IRQ7, FN_CAN0_TX_A, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1711,10 +1712,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP0_3_0 [4] */
 		FN_SD0_CLK, 0, 0, FN_SSI_SCK1_C, FN_RX3_C, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060044, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP1_31_28 [4] */
 		FN_D5, FN_HRX2, FN_SCL1_B, FN_PWM2_C, FN_TCLK2_B, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1738,10 +1740,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP1_3_0 [4] */
 		FN_MMC0_D4, FN_SD1_CD, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060048, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP2_31_28 [4] */
 		FN_D13, FN_MSIOF2_SYNC_A, 0, FN_RX4_C, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0,
@@ -1765,10 +1768,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP2_3_0 [4] */
 		FN_D6, FN_HTX2, FN_SDA1_B, FN_PWM4_C, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606004C, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP3_31_28 [4] */
 		FN_QSPI0_SSL, FN_WE1_N, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0,
@@ -1793,10 +1797,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP3_3_0 [4] */
 		FN_D14, FN_MSIOF2_SS1, 0, FN_TX4_C, FN_CAN1_RX_B,
 		0, FN_AVB_AVTP_CAPTURE_A,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060050, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP4_31_28 [4] */
 		FN_DU0_DR6, 0, FN_RX2_C, 0, 0, 0, FN_A6, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -1820,10 +1825,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP4_3_0 [4] */
 		FN_EX_WAIT0, FN_CAN_CLK_B, FN_SCIF_CLK_A, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060054, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP5_31_28 [4] */
 		FN_DU0_DG6, 0, FN_HRX1_C, 0, 0, 0, FN_A14,  0, 0, 0,
 		0, 0, 0, 0, 0, 0,
@@ -1847,10 +1853,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP5_3_0 [4] */
 		FN_DU0_DR7, 0, FN_TX2_C, 0, FN_PWM2_B, 0, FN_A7, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060058, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP6_31_28 [4] */
 		FN_DU0_DB6, 0, 0, 0, 0, 0, FN_A22, 0, 0,
 		0, 0, 0, 0, 0, 0, 0,
@@ -1874,10 +1881,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP6_3_0 [4] */
 		FN_DU0_DG7, 0, FN_HTX1_C, 0,  FN_PWM6_B, 0, FN_A15,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606005C, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP7_31_28 [4] */
 		FN_DU0_DISP, 0, 0, 0, FN_CAN1_RX_C, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0,
@@ -1901,10 +1909,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0,
 		/* IP7_3_0 [4] */
 		FN_DU0_DB7, 0, 0, 0, 0, 0, FN_A23, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060060, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP8_31_28 [4] */
 		FN_VI1_DATA5, 0, 0, 0, FN_AVB_RXD4, FN_ETH_LINK, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0,
@@ -1928,10 +1937,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0,
 		/* IP8_3_0 [4] */
 		FN_DU0_CDE, 0, 0, 0, FN_CAN1_TX_C, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060064, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP9_31_28 [4] */
 		FN_VI1_DATA9, 0, 0, FN_SDA2_B, FN_AVB_TXD0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0,
@@ -1955,10 +1965,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0,
 		/* IP9_3_0 [4] */
 		FN_VI1_DATA6, 0, 0, 0, FN_AVB_RXD5, FN_ETH_TXD1, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060068, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP10_31_28 [4] */
 		FN_SCL1_A, FN_RX4_A, FN_PWM5_D, FN_DU1_DR0, 0, 0,
 		FN_SSI_SCK6_B, FN_VI0_G0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -1983,10 +1994,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0,
 		/* IP10_3_0 [4] */
 		FN_VI1_DATA10, 0, 0, FN_CAN0_RX_B, FN_AVB_TXD1, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606006C, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP11_31_28 [4] */
 		FN_HRX1_A, FN_SCL4_A, FN_PWM6_A, FN_DU1_DG0, FN_RX0_A, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2014,10 +2026,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP11_3_0 [4] */
 		FN_SDA1_A, FN_TX4_A, 0, FN_DU1_DR1, 0, 0, FN_SSI_WS6_B,
-		FN_VI0_G1, 0, 0, 0, 0, 0, 0, 0, 0, }
+		FN_VI0_G1, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060070, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP12_31_28 [4] */
 		FN_SD2_DAT2, FN_RX2_A, 0, FN_DU1_DB0, FN_SSI_SDATA2_B, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2041,10 +2054,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP12_3_0 [4] */
 		FN_HTX1_A, FN_SDA4_A, 0, FN_DU1_DG1, FN_TX0_A, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060074, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP13_31_28 [4] */
 		FN_SSI_SCK5_A, 0, 0, FN_DU1_DOTCLKOUT1, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0,
@@ -2069,10 +2083,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP13_3_0 [4] */
 		FN_SD2_DAT3, FN_TX2_A, 0, FN_DU1_DB1, FN_SSI_WS9_B, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR14", 0xE6060078, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP14_31_28 [4] */
 		FN_SSI_SDATA7_A, 0, 0, FN_IRQ8, FN_AUDIO_CLKA_D, FN_CAN_CLK_D,
 		FN_VI0_G5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2096,10 +2111,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP14_3_0 [4] */
 		FN_SSI_WS5_A, 0, FN_SCL3_C, FN_DU1_DOTCLKIN, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR15", 0xE606007C, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP15_31_28 [4] */
 		FN_SSI_WS4_A, 0, FN_AVB_PHY_INT, 0, 0, 0, FN_VI0_R5, 0, 0, 0,
 		0, 0, 0, 0, 0, 0,
@@ -2123,10 +2139,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_VI0_G7, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP15_3_0 [4] */
 		FN_SSI_SCK0129_A, FN_MSIOF1_RXD_A, FN_RX5_D, 0, 0, 0,
-		FN_VI0_G6, 0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		FN_VI0_G6, 0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR16", 0xE6060080, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP16_31_28 [4] */
 		FN_SSI_SDATA2_A, FN_HRTS1_N_B, 0, 0, 0, 0,
 		FN_VI0_DATA4_VI0_B4, 0, 0, 0, 0, 0, 0, 0, 0, 0,
@@ -2151,10 +2168,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_DACK2, FN_VI0_CLK, FN_AVB_COL, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP16_3_0 [4] */
 		FN_SSI_SDATA4_A, 0, FN_AVB_CRS, 0, 0, 0, FN_VI0_R6, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR17", 0xE6060084, 32,
-			     4, 4, 4, 4, 4, 4, 4, 4) {
+			     GROUP(4, 4, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		/* IP17_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP17_27_24 [4] */
@@ -2177,11 +2195,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_VI0_DATA6_VI0_B6, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP17_3_0 [4] */
 		FN_SSI_SCK9_A, FN_RX2_B, FN_SCL3_E, 0, 0, FN_EX_WAIT1,
-		FN_VI0_DATA5_VI0_B5, 0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		FN_VI0_DATA5_VI0_B5, 0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xE60600C0, 32,
-			     1, 1, 1, 1, 1, 2, 1, 1, 2, 2, 2, 1, 3, 3,
-				 1, 2, 3, 3, 1) {
+			     GROUP(1, 1, 1, 1, 1, 2, 1, 1, 2, 2, 2, 1,
+				   3, 3, 1, 2, 3, 3, 1),
+			     GROUP(
 		/* RESERVED [1] */
 		0, 0,
 		/* RESERVED [1] */
@@ -2224,11 +2243,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_I2C00_0, FN_SEL_I2C00_1, FN_SEL_I2C00_2, FN_SEL_I2C00_3,
 		FN_SEL_I2C00_4, 0, 0, 0,
 		/* SEL_AVB [1] */
-		FN_SEL_AVB_0, FN_SEL_AVB_1, }
+		FN_SEL_AVB_0, FN_SEL_AVB_1, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xE60600C4, 32,
-			     1, 3, 3, 2, 2, 1, 2, 2,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 2, 1) {
+			     GROUP(1, 3, 3, 2, 2, 1, 2, 2, 2, 1, 1, 1,
+				   1, 1, 2, 1, 1, 2, 2, 1),
+			     GROUP(
 		/* SEL_SCIFCLK [1] */
 		FN_SEL_SCIFCLK_0, FN_SEL_SCIFCLK_1,
 		/* SEL_SCIF5 [3] */
@@ -2270,11 +2290,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_HSCIF1 [2] */
 		FN_SEL_HSCIF1_0, FN_SEL_HSCIF1_1, FN_SEL_HSCIF1_2, 0,
 		/* SEL_HSCIF0 [1] */
-		FN_SEL_HSCIF0_0, FN_SEL_HSCIF0_1,}
+		FN_SEL_HSCIF0_0, FN_SEL_HSCIF0_1, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE60600C8, 32,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-				 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
+				   2, 2, 2, 2, 2, 2, 2, 2, 2),
+			     GROUP(
 		/* RESERVED [1] */
 		0, 0,
 		/* RESERVED [1] */
@@ -2316,7 +2337,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_SSI1 [2] */
 		FN_SEL_SSI1_0, FN_SEL_SSI1_1, FN_SEL_SSI1_2, FN_SEL_SSI1_3,
 		/* SEL_SSI0 [2] */
-		FN_SEL_SSI0_0, FN_SEL_SSI0_1, 0, 0, }
+		FN_SEL_SSI0_0, FN_SEL_SSI0_1, 0, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 5a1ab20..7f1c675 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2284,8 +2284,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xfffc0020, 32,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 3, 4, 3, 3, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 3, 4, 3, 3, 2),
+			     GROUP(
 		/* IP0_31 [1] */
 		0,	0,
 		/* IP0_30 [1] */
@@ -2336,10 +2337,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_TX2_E,	FN_SDA2_B,		0,		0,
 		/* IP0_1_0 [2] */
 		FN_PRESETOUT,	0,	FN_PWM1,	0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xfffc0024, 32,
-			     1, 1, 2, 3, 1, 3, 3, 1, 2, 4, 3, 3, 3, 1, 1) {
+			     GROUP(1, 1, 2, 3, 1, 3, 3, 1, 2, 4, 3, 3,
+				   3, 1, 1),
+			     GROUP(
 		/* IP1_31 [1] */
 		0,	0,
 		/* IP1_30 [1] */
@@ -2379,11 +2382,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A21,		FN_HSPI_CLK1_B,
 		/* IP1_0 [1] */
 		FN_A20,		FN_HSPI_CS1_B,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xfffc0028, 32,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 3, 2, 3, 3, 3, 3) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 3, 2, 3, 3, 3, 3),
+			     GROUP(
 		/* IP2_31 [1] */
 		FN_MLB_CLK,	FN_IRQ1_A,
 		/* IP2_30 [1] */
@@ -2431,11 +2435,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP2_2_0 [3] */
 		FN_SD1_CLK_A,	FN_MMC_CLK,	0,	FN_ATACS00,
 		FN_EX_CS2,	0,		0,	0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xfffc002c, 32,
-			     1, 1, 1, 1, 1, 3, 3, 2,
-			     3, 3, 3, 2, 3, 3, 2) {
+			     GROUP(1, 1, 1, 1, 1, 3, 3, 2, 3, 3, 3, 2,
+				   3, 3, 2),
+			     GROUP(
 		/* IP3_31 [1] */
 		FN_DU0_DR6,	FN_LCDOUT6,
 		/* IP3_30 [1] */
@@ -2473,10 +2478,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SDSELF_B,	0,		0,		0,
 		/* IP3_1_0 [2] */
 		FN_MLB_SIG,	FN_RX5_B,	FN_SDA3_A,	FN_IRQ2_A,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xfffc0030, 32,
-			     1, 2, 2, 2, 4, 4, 2, 2, 2, 2, 1, 1, 3, 3, 1) {
+			     GROUP(1, 2, 2, 2, 4, 4, 2, 2, 2, 2, 1, 1,
+				   3, 3, 1),
+			     GROUP(
 		/* IP4_31 [1] */
 		0,	0,
 		/* IP4_30_29 [2] */
@@ -2515,10 +2522,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_TX1_D,	FN_CAN0_TX_A,	FN_ADICHS0,	0,
 		/* IP4_0 [1] */
 		FN_DU0_DR7,	FN_LCDOUT7,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xfffc0034, 32,
-			     1, 2, 3, 3, 2, 3, 3, 2, 1, 2, 2, 1, 1, 2, 2, 2) {
+			     GROUP(1, 2, 3, 3, 2, 3, 3, 2, 1, 2, 2, 1,
+				   1, 2, 2, 2),
+			     GROUP(
 
 		/* IP5_31 [1] */
 		0, 0,
@@ -2559,11 +2568,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_VI1_DATA10_B,	FN_DU0_DB6,	FN_LCDOUT22,	0,
 		/* IP5_1_0 [2] */
 		FN_VI0_R5_B,		FN_DU0_DB5,	FN_LCDOUT21,	0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xfffc0038, 32,
-			     2, 2, 2, 2, 2, 1, 2, 2, 1, 2,
-			     1, 2, 1, 1, 1, 1, 2, 3, 2) {
+			     GROUP(2, 2, 2, 2, 2, 1, 2, 2, 1, 2, 1, 2,
+				   1, 1, 1, 1, 2, 3, 2),
+			     GROUP(
 		/* IP6_31_30 [2] */
 		FN_SD0_DAT2,	0,	FN_SUB_TDI,	0,
 		/* IP6_29_28 [2] */
@@ -2610,10 +2620,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP6_1_0 [2] */
 		FN_SSI_SCK6,		FN_HSPI_RX2_A,
 		FN_FMCLK_B,		FN_CAN1_TX_B,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xfffc003c, 32,
-			     3, 4, 3, 1, 3, 3, 3, 3, 3, 2, 2, 2) {
+			     GROUP(3, 4, 3, 1, 3, 3, 3, 3, 3, 2, 2, 2),
+			     GROUP(
 
 		/* IP7_31_29 [3] */
 		FN_VI0_HSYNC,	FN_SD2_CD_B,	FN_VI1_DATA2,	FN_DU1_DR2,
@@ -2649,10 +2660,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SD0_CD,	0,		FN_TX5_A,	0,
 		/* IP7_1_0 [2] */
 		FN_SD0_DAT3,	0,		FN_IRQ1_B,	0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xfffc0040, 32,
-			     1, 1, 3, 3, 2, 3, 3, 2, 3, 2, 3, 3, 3) {
+			     GROUP(1, 1, 3, 3, 2, 3, 3, 2, 3, 2, 3, 3, 3),
+			     GROUP(
 		/* IP8_31 [1] */
 		0, 0,
 		/* IP8_30 [1] */
@@ -2689,10 +2701,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP8_2_0 [3] */
 		FN_VI0_VSYNC,		FN_SD2_WP_B,	FN_VI1_DATA3,	FN_DU1_DR3,
 		0,			FN_HSPI_TX1_A,	FN_TX3_B,	0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xfffc0044, 32,
-			     1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP9_31 [1] */
 		0, 0,
 		/* IP9_30 [1] */
@@ -2731,10 +2744,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP9_2_0 [3] */
 		FN_VI0_G4,	FN_SD2_DAT0_B,	FN_VI1_DATA6,	FN_DU1_DR6,
 		0,		FN_HRTS1_B,	0,		0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xfffc0048, 32,
-			     1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 4, 3, 3, 3) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 4,
+				   3, 3, 3),
+			     GROUP(
 
 		/* IP10_31 [1] */
 		0, 0,
@@ -2780,11 +2795,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ATARD1,	FN_ETH_MDC,
 		FN_SDA1_B,	0,
 		0,		0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xfffc0050, 32,
-			     1, 1, 2, 2, 3, 2, 2, 1, 1, 1, 1, 2,
-			     1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(1, 1, 2, 2, 3, 2, 2, 1, 1, 1, 1, 2,
+				   1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 
 		/* SEL 31  [1] */
 		0, 0,
@@ -2843,11 +2859,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_WAIT2_A,		FN_SEL_WAIT2_B,
 		/* SEL_0 (WAIT1) [1] */
 		FN_SEL_WAIT1_A,		FN_SEL_WAIT1_B,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xfffc0054, 32,
-			     1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1) {
+			     GROUP(1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1),
+			     GROUP(
 
 		/* SEL_31 [1] */
 		0, 0,
@@ -2907,7 +2924,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_I2C2_C,		0,
 		/* SEL_0 (I2C1) [1] */
 		FN_SEL_I2C1_A,		FN_SEL_I2C1_B,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 249e758..70aa490 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -3271,7 +3271,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xfffc0020, 32,
-			     1, 3, 2, 1, 2, 4, 3, 2, 2, 2, 2, 2, 3, 3) {
+			     GROUP(1, 3, 2, 1, 2, 4, 3, 2, 2, 2, 2, 2, 3, 3),
+			     GROUP(
 		/* IP0_31 [1] */
 		0, 0,
 		/* IP0_30_28 [3] */
@@ -3306,10 +3307,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ATADIR0, FN_SDSELF, FN_HCTS1, FN_TX4_C,
 		/* IP0_2_0 [3] */
 		FN_USB_PENC2, FN_SCK0, FN_PWM1, FN_PWMFSW0,
-		FN_SCIF_CLK, FN_TCLK0_C, 0, 0 }
+		FN_SCIF_CLK, FN_TCLK0_C, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xfffc0024, 32,
-			     3, 4, 2, 2, 2, 4, 4, 4, 3, 2, 2) {
+			     GROUP(3, 4, 2, 2, 2, 4, 4, 4, 3, 2, 2),
+			     GROUP(
 		/* IP1_31_29 [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP1_28_25 [4] */
@@ -3344,10 +3346,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP1_3_2 [2] */
 		FN_EX_CS1, FN_MMC0_D7, FN_FD7, 0,
 		/* IP1_1_0 [2] */
-		FN_EX_CS0, FN_RX3_C_IRDA_RX_C, FN_MMC0_D6, FN_FD6 }
+		FN_EX_CS0, FN_RX3_C_IRDA_RX_C, FN_MMC0_D6, FN_FD6 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xfffc0028, 32,
-			     1, 3, 1, 1, 1, 1, 1, 1, 3, 3, 4, 4, 4, 4) {
+			     GROUP(1, 3, 1, 1, 1, 1, 1, 1, 3, 3, 4, 4, 4, 4),
+			     GROUP(
 		/* IP2_31 [1] */
 		0, 0,
 		/* IP2_30_28 [3] */
@@ -3390,11 +3393,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_HRX0, FN_RX1, FN_SCKZ, FN_RTS0_C_TANS_C,
 		FN_SUB_TDI, FN_CC5_STATE3, FN_CC5_STATE11, FN_CC5_STATE19,
 		FN_CC5_STATE27, FN_CC5_STATE35, 0, 0,
-		0, 0, 0, 0 }
+		0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xfffc002c, 32,
-			     3, 1, 1, 3, 1, 2, 1, 1, 1, 1, 1,
-			     1, 3, 3, 1, 1, 1, 1, 1, 1, 3) {
+			     GROUP(3, 1, 1, 3, 1, 2, 1, 1, 1, 1, 1, 1,
+				   3, 3, 1, 1, 1, 1, 1, 1, 3),
+			     GROUP(
 	    /* IP3_31_29 [3] */
 	    FN_DU0_EXODDF_DU0_ODDF_DISP_CDE, FN_QCPV_QDE, FN_CAN1_TX, FN_TX2_C,
 	    FN_SCL2_C, FN_REMOCON, 0, 0,
@@ -3441,11 +3445,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_DU0_DG2, FN_LCDOUT10,
 	    /* IP3_2_0 [3] */
 	    FN_DU0_DG1, FN_LCDOUT9, FN_DACK1, FN_SDA2,
-	    FN_AUDATA3, 0, 0, 0 }
+	    FN_AUDATA3, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xfffc0030, 32,
-			     3, 1, 1, 1, 1, 1, 1, 3, 3,
-			     1, 1, 1, 1, 1, 1, 3, 3, 3, 2) {
+			     GROUP(3, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1,
+				   1, 1, 1, 3, 3, 3, 2),
+			     GROUP(
 	    /* IP4_31_29 [3] */
 	    FN_DU1_DB0, FN_VI2_DATA4_VI2_B4, FN_SCL2_B, FN_SD3_DAT0,
 	    FN_TX5, FN_SCK0_D, 0, 0,
@@ -3489,11 +3494,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_DU0_CDE, FN_QPOLB, FN_CAN1_RX, FN_RX2_C,
 	    FN_DREQ0_B, FN_SSI_SCK78_B, FN_SCK0_B, 0,
 	    /* IP4_1_0 [2] */
-	    FN_DU0_DISP, FN_QPOLA, FN_CAN_CLK_C, FN_SCK2_C }
+	    FN_DU0_DISP, FN_QPOLA, FN_CAN_CLK_C, FN_SCK2_C ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xfffc0034, 32,
-			     1, 2, 1, 4, 3, 4, 2, 2,
-			     2, 2, 1, 1, 1, 1, 1, 1, 3) {
+			     GROUP(1, 2, 1, 4, 3, 4, 2, 2, 2, 2, 1, 1,
+				   1, 1, 1, 1, 3),
+			     GROUP(
 	    /* IP5_31 [1] */
 	    0, 0,
 	    /* IP5_30_29 [2] */
@@ -3535,10 +3541,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_DU1_DB2, FN_VI2_R4,
 	    /* IP5_2_0 [3] */
 	    FN_DU1_DB1, FN_VI2_DATA5_VI2_B5, FN_SDA2_B, FN_SD3_DAT1,
-	    FN_RX5, FN_RTS0_D_TANS_D, 0, 0 }
+	    FN_RX5, FN_RTS0_D_TANS_D, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xfffc0038, 32,
-			     1, 2, 2, 2, 2, 3, 2, 3, 3, 3, 1, 2, 2, 2, 2) {
+			     GROUP(1, 2, 2, 2, 2, 3, 2, 3, 3, 3, 1, 2,
+				   2, 2, 2),
+			     GROUP(
 	    /* IP6_31 [1] */
 	    0, 0,
 	    /* IP6_30_29 [2] */
@@ -3572,10 +3580,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP6_3_2 [2] */
 	    FN_SSI_WS0129, FN_CAN_DEBUGOUT2, FN_MOUT2, 0,
 	    /* IP6_1_0 [2] */
-	    FN_SSI_SCK0129, FN_CAN_DEBUGOUT1, FN_MOUT1, 0 }
+	    FN_SSI_SCK0129, FN_CAN_DEBUGOUT1, FN_MOUT1, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xfffc003c, 32,
-			     1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 2) {
+			     GROUP(1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3,
+				   3, 2, 2),
+			     GROUP(
 	    /* IP7_31 [1] */
 	    0, 0,
 	    /* IP7_30_29 [2] */
@@ -3608,10 +3618,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP7_3_2 [2] */
 	    FN_SSI_SDATA6, FN_ADICHS2, FN_CAN_CLK, FN_IECLK_B,
 	    /* IP7_1_0 [2] */
-	    FN_SSI_WS6, FN_ADICHS1, FN_CAN0_RX, FN_IETX_B }
+	    FN_SSI_WS6, FN_ADICHS1, FN_CAN0_RX, FN_IETX_B ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xfffc0040, 32,
-			     1, 3, 3, 2, 2, 1, 1, 1, 2, 4, 4, 4, 4) {
+			     GROUP(1, 3, 3, 2, 2, 1, 1, 1, 2, 4, 4, 4, 4),
+			     GROUP(
 	    /* IP8_31 [1] */
 	    0, 0,
 	    /* IP8_30_28 [3] */
@@ -3651,11 +3662,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_HSPI_CLK0, FN_CTS0, FN_USB_OVC0, FN_AD_CLK,
 	    FN_CC5_STATE4, FN_CC5_STATE12, FN_CC5_STATE20, FN_CC5_STATE28,
 	    FN_CC5_STATE36, 0, 0, 0,
-	    0, 0, 0, 0 }
+	    0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xfffc0044, 32,
-			     2, 2, 2, 2, 2, 3, 3, 2, 2,
-			     2, 2, 1, 1, 1, 1, 2, 2) {
+			     GROUP(2, 2, 2, 2, 2, 3, 3, 2, 2, 2, 2, 1,
+				   1, 1, 1, 2, 2),
+			     GROUP(
 	    /* IP9_31_30 [2] */
 	    0, 0, 0, 0,
 	    /* IP9_29_28 [2] */
@@ -3691,10 +3703,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP9_3_2 [2] */
 	    FN_VI0_DATA1_VI0_B1, FN_HCTS1_B, FN_MT1_PWM, 0,
 	    /* IP9_1_0 [2] */
-	    FN_VI0_DATA0_VI0_B0, FN_HRTS1_B, FN_MT1_VCXO, 0 }
+	    FN_VI0_DATA0_VI0_B0, FN_HRTS1_B, FN_MT1_VCXO, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xfffc0048, 32,
-			     3, 3, 2, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(3, 3, 2, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP10_31_29 [3] */
 	    FN_VI1_VSYNC, FN_AUDIO_CLKOUT_C, FN_SSI_WS4, FN_SIM_CLK,
 	    FN_GPS_MAG_C, FN_SPV_TRST, FN_SCL3, 0,
@@ -3726,10 +3739,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_DACK0_C, FN_DRACK0_C, 0, 0,
 	    /* IP10_2_0 [3] */
 	    FN_VI0_R0, FN_SSI_SDATA7_C, FN_SCK1_C, FN_DREQ1_B,
-	    FN_ARM_TRACEDATA_10, FN_DREQ0_C, 0, 0 }
+	    FN_ARM_TRACEDATA_10, FN_DREQ0_C, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xfffc004c, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP11_31_30 [2] */
 	    0, 0, 0, 0,
 	    /* IP11_29_27 [3] */
@@ -3761,10 +3775,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_ADICS_B_SAMP_B, 0, 0, 0,
 	    /* IP11_2_0 [3] */
 	    FN_VI1_DATA0_VI1_B0, FN_SD2_DAT0, FN_SIM_RST, FN_SPV_TCK,
-	    FN_ADICLK_B, 0, 0, 0 }
+	    FN_ADICLK_B, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xfffc0050, 32,
-			     4, 4, 4, 2, 3, 3, 3, 3, 3, 3) {
+			     GROUP(4, 4, 4, 2, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP12_31_28 [4] */
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    0, 0, 0, 0, 0, 0, 0, 0,
@@ -3793,11 +3808,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    FN_SCL1_C, FN_HTX0_B, 0, 0,
 	    /* IP12_2_0 [3] */
 	    FN_VI1_G2, FN_VI3_DATA2, FN_SSI_WS1, FN_TS_SPSYNC1,
-	    FN_SCK2, FN_HSCK0_B, 0, 0 }
+	    FN_SCK2, FN_HSCK0_B, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xfffc0090, 32,
-			     2, 2, 3, 3, 2, 2, 2, 2, 2,
-			     1, 1, 1, 1, 1, 1, 1, 2, 1, 2) {
+			     GROUP(2, 2, 3, 3, 2, 2, 2, 2, 2, 1, 1, 1,
+				   1, 1, 1, 1, 2, 1, 2),
+			     GROUP(
 	    /* SEL_SCIF5 [2] */
 	    FN_SEL_SCIF5_0, FN_SEL_SCIF5_1, FN_SEL_SCIF5_2, FN_SEL_SCIF5_3,
 	    /* SEL_SCIF4 [2] */
@@ -3837,11 +3853,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* SEL_EXBUS1 [1] */
 	    FN_SEL_EXBUS1_0, FN_SEL_EXBUS1_1,
 	    /* SEL_EXBUS0 [2] */
-	    FN_SEL_EXBUS0_0, FN_SEL_EXBUS0_1, FN_SEL_EXBUS0_2, 0 }
+	    FN_SEL_EXBUS0_0, FN_SEL_EXBUS0_1, FN_SEL_EXBUS0_2, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xfffc0094, 32,
-			     2, 2, 2, 2, 1, 1, 1, 3, 1,
-			     2, 2, 2, 2, 1, 1, 2, 1, 2, 2) {
+			     GROUP(2, 2, 2, 2, 1, 1, 1, 3, 1, 2, 2, 2,
+				   2, 1, 1, 2, 1, 2, 2),
+			     GROUP(
 	    /* SEL_TMU1 [2] */
 	    FN_SEL_TMU1_0, FN_SEL_TMU1_1, FN_SEL_TMU1_2, 0,
 	    /* SEL_TMU0 [2] */
@@ -3880,7 +3897,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* SEL_I2C2 [2] */
 	    FN_SEL_I2C2_0, FN_SEL_I2C2_1, FN_SEL_I2C2_2, FN_SEL_I2C2_3,
 	    /* SEL_I2C1 [2] */
-	    FN_SEL_I2C1_0, FN_SEL_I2C1_1, FN_SEL_I2C1_2, FN_SEL_I2C1_3 }
+	    FN_SEL_I2C1_0, FN_SEL_I2C1_1, FN_SEL_I2C1_2, FN_SEL_I2C1_3 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 4c20966..8046469 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -4960,7 +4960,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_0_FN, FN_IP14_21_19 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
-			     1, 4, 4, 3, 4, 4, 3, 3, 3, 3) {
+			     GROUP(1, 4, 4, 3, 4, 4, 3, 3, 3, 3),
+			     GROUP(
 		/* IP0_31 [1] */
 		0, 0,
 		/* IP0_30_27 [4] */
@@ -4993,10 +4994,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* IP0_2_0 [3] */
 		FN_D0, FN_MSIOF3_SCK_B, FN_VI3_DATA0, FN_VI0_G4, FN_VI0_G4_B,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060024, 32,
-			     2, 2, 2, 4, 4, 3, 3, 4, 4, 4) {
+			     GROUP(2, 2, 2, 4, 4, 3, 3, 4, 4, 4),
+			     GROUP(
 		/* IP1_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP1_29_28 [2] */
@@ -5030,10 +5032,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP1_3_0 [4] */
 		FN_D9, FN_SCIFA1_RXD_C, FN_AVB_TXD1, 0,
 		FN_VI0_G1, FN_VI0_G1_B, FN_VI2_DATA1_VI2_B1,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
-			     3, 3, 4, 4, 3, 3, 3, 3, 3, 3) {
+			     GROUP(3, 3, 4, 4, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP2_31_29 [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP2_28_26 [3] */
@@ -5059,10 +5062,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP2_5_3 [3] */
 		FN_A3, FN_PWM6, FN_MSIOF1_SS2_B, 0, 0, 0, 0, 0,
 		/* IP2_2_0 [3] */
-		FN_A2, FN_PWM5, FN_MSIOF1_SS1_B, 0, 0, 0, 0, 0,	}
+		FN_A2, FN_PWM5, FN_MSIOF1_SS1_B, 0, 0, 0, 0, 0,	))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606002C, 32,
-			     3, 3, 3, 3, 2, 3, 3, 4, 4, 4) {
+			     GROUP(3, 3, 3, 3, 2, 3, 3, 4, 4, 4),
+			     GROUP(
 		/* IP3_31_29 [3] */
 		FN_A20, FN_SPCLK, FN_VI1_R3, FN_VI1_R3_B, FN_VI2_G4,
 		0, 0, 0,
@@ -5092,10 +5096,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP3_3_0 [4] */
 		FN_A11, FN_SCIFB2_CTS_N_B, FN_MSIOF2_SCK, FN_VI1_R0,
 		FN_VI1_R0_B, FN_VI2_G0, FN_VI2_DATA3_VI2_B3_B, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, }
+		0, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060030, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP4_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP4_29_27 [3] */
@@ -5125,10 +5130,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A22, FN_MISO_IO1, FN_VI1_R5, FN_VI1_R5_B, FN_VI2_G6, 0, 0, 0,
 		/* IP4_2_0 [3] */
 		FN_A21, FN_MOSI_IO0, FN_VI1_R4, FN_VI1_R4_B, FN_VI2_G5, 0, 0, 0,
-		}
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060034, 32,
-			     2, 3, 3, 3, 3, 3, 2, 3, 4, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 3, 2, 3, 4, 3, 3),
+			     GROUP(
 		/* IP5_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP5_29_27 [3] */
@@ -5162,10 +5168,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_INTC_EN0_N, FN_I2C1_SCL,
 		/* IP5_2_0 [3] */
 		FN_EX_CS3_N, FN_GPS_MAG, FN_VI3_FIELD, FN_VI1_G1, FN_VI1_G1_B,
-		FN_VI2_R3, 0, 0, }
+		FN_VI2_R3, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060038, 32,
-			     3, 3, 3, 3, 3, 3, 3, 2, 3, 3, 3) {
+			     GROUP(3, 3, 3, 3, 3, 3, 3, 2, 3, 3, 3),
+			     GROUP(
 		/* IP6_31_29 [3] */
 		FN_ETH_REF_CLK, 0, FN_HCTS0_N_E,
 		FN_STP_IVCXO27_1_B, FN_HRX0_F, 0, 0, 0,
@@ -5198,10 +5205,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SSI_SDATA7_C, FN_SSI_SCK78_B, 0, 0, 0,
 		/* IP6_2_0 [3] */
 		FN_DACK0, FN_IRQ0, FN_INTC_IRQ0_N, FN_SSI_SCK6_B,
-		FN_VI1_VSYNC_N, FN_VI1_VSYNC_N_B, FN_SSI_WS78_C, 0, }
+		FN_VI1_VSYNC_N, FN_VI1_VSYNC_N_B, FN_SSI_WS78_C, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606003C, 32,
-			     1, 2, 2, 2, 3, 3, 3, 3, 3, 2, 2, 3, 3) {
+			     GROUP(1, 2, 2, 2, 3, 3, 3, 3, 3, 2, 2, 3, 3),
+			     GROUP(
 		/* IP7_31 [1] */
 		0, 0,
 		/* IP7_30_29 [2] */
@@ -5233,11 +5241,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ETH_TXD1, 0, FN_HTX0_F, FN_BPFCLK_G, 0, 0, 0, 0,
 		/* IP7_2_0 [3] */
 		FN_ETH_MDIO, 0, FN_HRTS0_N_E,
-		FN_SIM0_D_C, FN_HCTS0_N_F, 0, 0, 0, }
+		FN_SIM0_D_C, FN_HCTS0_N_F, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060040, 32,
-			     1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2,
-			     2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2,
+				   2, 2, 2, 2, 2, 2),
+			     GROUP(
 		/* IP8_31 [1] */
 		0, 0,
 		/* IP8_30_29 [2] */
@@ -5274,10 +5283,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP8_3_2 [2] */
 		FN_VI0_DATA2_VI0_B2, FN_ATAWR0_N, FN_AVB_RXD4, 0,
 		/* IP8_1_0 [2] */
-		FN_VI0_DATA1_VI0_B1, FN_ATARD0_N, FN_AVB_RXD3, 0, }
+		FN_VI0_DATA1_VI0_B1, FN_ATARD0_N, FN_AVB_RXD3, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
-			     4, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 2, 2) {
+			     GROUP(4, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 2, 2),
+			     GROUP(
 		/* IP9_31_28 [4] */
 		FN_SD1_CD, FN_MMC1_D6, FN_TS_SDEN1, FN_USB1_EXTP,
 		FN_GLO_SS, FN_VI0_CLK_B, FN_IIC2_SCL_D, FN_I2C2_SCL_D,
@@ -5309,10 +5319,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP9_3_2 [2] */
 		FN_SD0_DAT1, FN_SCIFB1_TXD_B, FN_VI1_DATA3_VI1_B3_B, 0,
 		/* IP9_1_0 [2] */
-		FN_SD0_DAT0, FN_SCIFB1_RXD_B, FN_VI1_DATA2_VI1_B2_B, 0, }
+		FN_SD0_DAT0, FN_SCIFB1_RXD_B, FN_VI1_DATA2_VI1_B2_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060048, 32,
-			     2, 4, 3, 4, 4, 4, 4, 3, 4) {
+			     GROUP(2, 4, 3, 4, 4, 4, 4, 3, 4),
+			     GROUP(
 		/* IP10_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP10_29_26 [4] */
@@ -5348,10 +5359,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP10_3_0 [4] */
 		FN_SD1_WP, FN_MMC1_D7, FN_TS_SPSYNC1, FN_USB1_IDIN,
 		FN_GLO_RFON, FN_VI1_CLK_B, FN_IIC2_SDA_D, FN_I2C2_SDA_D,
-		FN_SIM0_D_B, 0, 0, 0, 0, 0, 0, 0, }
+		FN_SIM0_D_B, 0, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
-			     2, 3, 3, 2, 4, 3, 2, 2, 2, 2, 2, 1, 4) {
+			     GROUP(2, 3, 3, 2, 4, 3, 2, 2, 2, 2, 2, 1, 4),
+			     GROUP(
 		/* IP11_31_30 [2] */
 		FN_SSI_SCK0129, FN_CAN_CLK_B, FN_MOUT0, 0,
 		/* IP11_29_27 [3] */
@@ -5383,10 +5395,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP11_3_0 [4] */
 		FN_SD2_WP, FN_MMC0_D5, FN_TS_SCK0_B, FN_USB2_IDIN,
 		FN_GLO_I1, FN_VI0_DATA7_VI0_B7_B, FN_HRTS0_N_D,
-		FN_TS_SCK1_B, FN_GLO_I1_B, FN_VI3_DATA7_B, 0, 0, 0, 0, 0, 0, }
+		FN_TS_SCK1_B, FN_GLO_I1_B, FN_VI3_DATA7_B, 0, 0, 0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060050, 32,
-			     1, 3, 3, 2, 3, 3, 3, 3, 3, 2, 2, 2, 2) {
+			     GROUP(1, 3, 3, 2, 3, 3, 3, 3, 3, 2, 2, 2, 2),
+			     GROUP(
 		/* IP12_31 [1] */
 		0, 0,
 		/* IP12_30_28 [3] */
@@ -5422,10 +5435,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP12_3_2 [2] */
 		FN_SSI_SDATA0, FN_CAN0_RX_B, FN_MOUT2, 0,
 		/* IP12_1_0 [2] */
-		FN_SSI_WS0129, FN_CAN0_TX_B, FN_MOUT1, 0, }
+		FN_SSI_WS0129, FN_CAN0_TX_B, FN_MOUT1, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060054, 32,
-			     1, 2, 3, 3, 4, 3, 3, 3, 3, 4, 3) {
+			     GROUP(1, 2, 3, 3, 4, 3, 3, 3, 3, 4, 3),
+			     GROUP(
 		/* IP13_31 [1] */
 		0, 0,
 		/* IP13_30_29 [2] */
@@ -5458,10 +5472,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_BPFCLK_F, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP13_2_0 [3] */
 		FN_SSI_SDATA5, FN_SCIFB1_TXD, FN_IETX_B, FN_DU2_DR2,
-		FN_LCDOUT2, FN_CAN_DEBUGOUT5, 0, 0, }
+		FN_LCDOUT2, FN_CAN_DEBUGOUT5, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR14", 0xE6060058, 32,
-			     1, 3, 3, 3, 3, 3, 4, 3, 3, 3, 3) {
+			     GROUP(1, 3, 3, 3, 3, 3, 4, 3, 3, 3, 3),
+			     GROUP(
 		/* IP14_30 [1] */
 		0, 0,
 		/* IP14_30_28 [3] */
@@ -5496,10 +5511,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP14_2_0 [3] */
 		FN_AUDIO_CLKB, FN_SCIF_CLK, FN_CAN0_RX_D,
 		FN_DVC_MUTE, FN_CAN0_RX_C, FN_CAN_DEBUGOUT15,
-		FN_REMOCON, 0, }
+		FN_REMOCON, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR15", 0xE606005C, 32,
-			     2, 2, 2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3) {
+			     GROUP(2, 2, 2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3),
+			     GROUP(
 		/* IP15_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP15_29_28 [2] */
@@ -5531,10 +5547,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_IIC2_SCL, FN_I2C2_SCL, 0,
 		/* IP15_2_0 [3] */
 		FN_SCIFA2_SCK, FN_FMCLK, FN_SCK2, FN_MSIOF3_SCK, FN_DU2_DG7,
-		FN_LCDOUT15, FN_SCIF_CLK_B, 0, }
+		FN_LCDOUT15, FN_SCIF_CLK_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR16", 0xE6060160, 32,
-			     4, 4, 4, 4, 4, 4, 1, 1, 3, 3) {
+			     GROUP(4, 4, 4, 4, 4, 4, 1, 1, 3, 3),
+			     GROUP(
 		/* IP16_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -5562,11 +5579,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ADICS_SAMP, FN_DU2_CDE, FN_QPOLB, FN_SCIFA2_RXD_B, 0,
 		/* IP16_2_0 [3] */
 		FN_MSIOF0_SS2, FN_AUDIO_CLKOUT, FN_ADICHS2,
-		FN_DU2_DISP, FN_QPOLA, FN_HTX0_C, FN_SCIFA2_TXD_B, 0, }
+		FN_DU2_DISP, FN_QPOLA, FN_HTX0_C, FN_SCIFA2_TXD_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
-			     3, 2, 2, 3, 2, 1, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1) {
+			     GROUP(3, 2, 2, 3, 2, 1, 1, 1, 2, 1, 2, 1,
+				   1, 1, 1, 2, 1, 1, 2, 1, 1),
+			     GROUP(
 		/* SEL_SCIF1 [3] */
 		FN_SEL_SCIF1_0, FN_SEL_SCIF1_1, FN_SEL_SCIF1_2, FN_SEL_SCIF1_3,
 		FN_SEL_SCIF1_4, 0, 0, 0,
@@ -5612,11 +5630,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_SOF3 [1] */
 		FN_SEL_SOF3_0, FN_SEL_SOF3_1,
 		/* SEL_SOF0 [1] */
-		FN_SEL_SOF0_0, FN_SEL_SOF0_1, }
+		FN_SEL_SOF0_0, FN_SEL_SOF0_1, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
-			     3, 1, 1, 1, 2, 1, 2, 1, 2,
-			     1, 1, 1, 3, 3, 2, 3, 2, 2) {
+			     GROUP(3, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1,
+				   3, 3, 2, 3, 2, 2),
+			     GROUP(
 		/* RESERVED [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* SEL_TMU1 [1] */
@@ -5654,11 +5673,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_SIM [2] */
 		FN_SEL_SIM_0, FN_SEL_SIM_1, FN_SEL_SIM_2, 0,
 		/* SEL_SSI8 [2] */
-		FN_SEL_SSI8_0, FN_SEL_SSI8_1, FN_SEL_SSI8_2, 0, }
+		FN_SEL_SSI8_0, FN_SEL_SSI8_1, FN_SEL_SSI8_2, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL3", 0xE6060098, 32,
-			     1, 1, 2, 4, 4, 2, 2,
-			     4, 2, 3, 2, 3, 2) {
+			     GROUP(1, 1, 2, 4, 4, 2, 2, 4, 2, 3, 2, 3, 2),
+			     GROUP(
 		/* SEL_IICDVFS [1] */
 		FN_SEL_IICDVFS_0, FN_SEL_IICDVFS_1,
 		/* SEL_IIC0 [1] */
@@ -5689,7 +5708,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SEL_I2C2_0, FN_SEL_I2C2_1, FN_SEL_I2C2_2, FN_SEL_I2C2_3,
 		FN_SEL_I2C2_4, 0, 0, 0,
 		/* SEL_I2C1 [2] */
-		FN_SEL_I2C1_0, FN_SEL_I2C1_1, FN_SEL_I2C1_2, 0, }
+		FN_SEL_I2C1_0, FN_SEL_I2C1_1, FN_SEL_I2C1_2, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index aab38d4..c771a5c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5707,8 +5707,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_0_FN, FN_IP15_17_15 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
-			     1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP0_31 [1] */
 		0, 0,
 		/* IP0_30_29 [2] */
@@ -5763,10 +5764,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_1 [1] */
 		FN_D1, 0,
 		/* IP0_0 [1] */
-		FN_D0, 0, }
+		FN_D0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060024, 32,
-			     3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2) {
+			     GROUP(3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2),
+			     GROUP(
 		/* IP1_31_29 [3] */
 		FN_A18, FN_DREQ1, FN_SCIFA1_RXD_C, 0, FN_SCIFB1_RXD_C,
 		0, 0, 0,
@@ -5799,10 +5801,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A8, FN_MSIOF1_SS1, FN_I2C0_SCL, 0,
 		/* IP1_1_0 [2] */
 		FN_A7, FN_MSIOF1_SYNC,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
-			     2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3) {
+			     GROUP(2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3),
+			     GROUP(
 		/* IP2_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP2_29_27 [3] */
@@ -5835,10 +5838,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_A20, FN_SPCLK, 0, 0,
 		/* IP2_2_0 [3] */
 		FN_A19, FN_DACK1, FN_SCIFA1_TXD_C, 0,
-		FN_SCIFB1_TXD_C, 0, FN_SCIFB1_SCK_B, 0, }
+		FN_SCIFB1_TXD_C, 0, FN_SCIFB1_SCK_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606002C, 32,
-			     1, 3, 3, 3, 2, 2, 2, 2, 2, 3, 3, 3, 3) {
+			     GROUP(1, 3, 3, 3, 2, 2, 2, 2, 2, 3, 3, 3, 3),
+			     GROUP(
 		/* IP3_31 [1] */
 		0, 0,
 		/* IP3_30_28 [3] */
@@ -5873,10 +5877,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_SCIFB1_RXD_B, FN_PWM1, FN_TPU_TO1, 0,
 		/* IP3_2_0 [3] */
 		FN_EX_CS4_N, FN_ATARD0_N, FN_MSIOF2_RXD, 0, FN_EX_WAIT2,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060030, 32,
-			     1, 3, 2, 2, 2, 1, 1, 1, 3, 3, 3, 2, 3, 3, 2) {
+			     GROUP(1, 3, 2, 2, 2, 1, 1, 1, 3, 3, 3, 2,
+				   3, 3, 2),
+			     GROUP(
 		/* IP4_31 [1] */
 		0, 0,
 		/* IP4_30_28 [3] */
@@ -5915,10 +5921,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_MSIOF2_SYNC_C, FN_GLO_I0_D,
 		0, 0, 0,
 		/* IP4_1_0 [2] */
-		FN_SSI_SDATA0, FN_I2C0_SCL_B, FN_IIC0_SCL_B, FN_MSIOF2_SCK_C, }
+		FN_SSI_SDATA0, FN_I2C0_SCL_B, FN_IIC0_SCL_B, FN_MSIOF2_SCK_C,
+		))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060034, 32,
-			     3, 3, 2, 2, 2, 3, 2, 3, 3, 3, 3, 3) {
+			     GROUP(3, 3, 2, 2, 2, 3, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP5_31_29 [3] */
 		FN_SSI_SDATA9, FN_RX3_D, FN_CAN0_RX_D,
 		0, 0, 0, 0, 0,
@@ -5953,10 +5961,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP5_2_0 [3] */
 		FN_SSI_WS5, FN_MSIOF1_SYNC_C, FN_TS_SCK0, FN_GLO_I1,
 		FN_MSIOF2_TXD_D, FN_VI1_R3_B,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060038, 32,
-			     2, 3, 3, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3) {
+			     GROUP(2, 3, 3, 3, 2, 3, 2, 2, 2, 2, 2, 3, 3),
+			     GROUP(
 		/* IP6_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP6_29_27 [3] */
@@ -5993,10 +6002,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP6_2_0 [3] */
 		FN_AUDIO_CLKB, FN_STP_OPWM_0_B, FN_MSIOF1_SCK_B,
 		FN_SCIF_CLK, FN_DVC_MUTE, FN_BPFCLK_E,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606003C, 32,
-			     2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3),
+			     GROUP(
 		/* IP7_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP7_29_27 [3] */
@@ -6034,10 +6044,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_2_0 [3] */
 		FN_IRQ9, FN_DU1_DOTCLKIN_B, FN_CAN_CLK_D, FN_GPS_MAG_C,
 		FN_SCIF_CLK_B, FN_GPS_MAG_D,
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060040, 32,
-			     1, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP8_31 [1] */
 		0, 0,
 		/* IP8_30_28 [3] */
@@ -6077,10 +6088,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		/* IP8_2_0 [3] */
 		FN_DU1_DG3, FN_LCDOUT11, FN_VI1_DATA5_B, 0, FN_SSI_WS78_B,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
-			     3, 2, 2, 2, 2, 2, 2, 1, 3, 1, 1, 3, 1, 1, 3, 3) {
+			     GROUP(3, 2, 2, 2, 2, 2, 2, 1, 3, 1, 1, 3,
+				   1, 1, 3, 3),
+			     GROUP(
 		/* IP9_31_29 [3] */
 		FN_VI0_G0, FN_IIC1_SCL, FN_STP_IVCXO27_0_C, FN_I2C4_SCL,
 		FN_HCTS2_N, FN_SCIFB2_CTS_N, FN_ATAWR1_N, 0,
@@ -6120,10 +6133,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* IP9_2_0 [3] */
 		FN_DU1_DB6, FN_LCDOUT22, FN_I2C3_SCL_C, FN_RX3, FN_SCIFA3_RXD,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060048, 32,
-			     3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3) {
+			     GROUP(3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP10_31_29 [3] */
 		FN_VI0_R4, FN_VI2_DATA5, FN_GLO_SCLK_B, FN_TX0_C, FN_I2C1_SCL_D,
 		0, 0, 0,
@@ -6157,11 +6171,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_HSCK2, FN_SCIFB2_SCK, FN_ATARD1_N, 0,
 		/* IP10_2_0 [3] */
 		FN_VI0_G1, FN_IIC1_SDA, FN_STP_ISCLK_0_C, FN_I2C4_SDA,
-		FN_HRTS2_N, FN_SCIFB2_RTS_N, FN_ATADIR1_N, 0, }
+		FN_HRTS2_N, FN_SCIFB2_RTS_N, FN_ATADIR1_N, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
-			     2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
-			     3, 3, 3, 3, 3) {
+			     GROUP(2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
+				   2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP11_31_30 [2] */
 		FN_ETH_CRS_DV, FN_AVB_LINK, FN_I2C2_SDA_C, 0,
 		/* IP11_29_28 [2] */
@@ -6204,10 +6219,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0,
 		/* IP11_2_0 [3] */
 		FN_VI0_R5, FN_VI2_DATA6, FN_GLO_SDATA_B, FN_RX0_C,
-		FN_I2C1_SDA_D, 0, 0, 0, }
+		FN_I2C1_SDA_D, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060050, 32,
-			     2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2) {
+			     GROUP(2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2),
+			     GROUP(
 		/* IP12_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP12_29_27 [3] */
@@ -6245,11 +6261,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP12_3_2 [2] */
 		FN_ETH_RXD0, FN_AVB_PHY_INT, FN_I2C3_SDA, FN_IIC0_SDA,
 		/* IP12_1_0 [2] */
-		FN_ETH_RX_ER, FN_AVB_CRS, FN_I2C3_SCL, FN_IIC0_SCL, }
+		FN_ETH_RX_ER, FN_AVB_CRS, FN_I2C3_SCL, FN_IIC0_SCL, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060054, 32,
-			     1, 3, 1, 1, 1, 2, 1, 3, 3, 1, 1, 1, 1, 1, 1,
-			     3, 2, 2, 3) {
+			     GROUP(1, 3, 1, 1, 1, 2, 1, 3, 3, 1, 1, 1,
+				   1, 1, 1, 3, 2, 2, 3),
+			     GROUP(
 		/* IP13_31 [1] */
 		0, 0,
 		/* IP13_30_28 [3] */
@@ -6296,10 +6313,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP13_2_0 [3] */
 		FN_STP_ISD_0, FN_AVB_TX_ER, FN_SCIFB2_SCK_C,
 		FN_ADICLK_B, FN_MSIOF0_SS1_C,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR14", 0xE6060058, 32,
-			     3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 2) {
+			     GROUP(3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1,
+				   1, 1, 2),
+			     GROUP(
 		/* IP14_31_29 [3] */
 		FN_MSIOF0_SS2, FN_MMC_D7, FN_ADICHS2, FN_RX0_E,
 		FN_VI1_VSYNC_N_C, FN_IIC0_SDA_C, FN_VI1_G5_B, 0,
@@ -6339,10 +6358,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP14_2 [1] */
 		FN_SD2_CLK, FN_MMC_CLK,
 		/* IP14_1_0 [2] */
-		FN_SD1_WP, FN_PWM1_B, FN_I2C1_SDA_C, 0, }
+		FN_SD1_WP, FN_PWM1_B, FN_I2C1_SDA_C, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR15", 0xE606005C, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2) {
+			     GROUP(2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2),
+			     GROUP(
 		/* IP15_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP15_29_27 [3] */
@@ -6380,10 +6400,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP15_3_2 [2] */
 		FN_SIM0_CLK, FN_IECLK, FN_CAN_CLK_C, 0,
 		/* IP15_1_0 [2] */
-		FN_SIM0_RST, FN_IETX, FN_CAN1_TX_D, 0, }
+		FN_SIM0_RST, FN_IETX, FN_CAN1_TX_D, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR16", 0xE6060160, 32,
-			     4, 4, 4, 4, 4, 2, 2, 2, 3, 3) {
+			     GROUP(4, 4, 4, 4, 4, 2, 2, 2, 3, 3),
+			     GROUP(
 		/* IP16_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -6412,11 +6433,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP16_2_0 [3] */
 		FN_HRX1, FN_SCIFB1_RXD, FN_VI1_R0_B,
 		FN_GLO_SDATA_C, FN_VI1_DATA6_C,
-		0, 0, 0, }
+		0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
-			     1, 2, 2, 2, 3, 2, 1, 1, 1, 1,
-			     3, 2, 2, 2, 1, 2, 2, 2) {
+			     GROUP(1, 2, 2, 2, 3, 2, 1, 1, 1, 1, 3, 2,
+				   2, 2, 1, 2, 2, 2),
+			     GROUP(
 		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SCIF1 [2] */
@@ -6457,11 +6479,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_TSIF0 [2] */
 		FN_SEL_TSIF0_0, FN_SEL_TSIF0_1, FN_SEL_TSIF0_2, FN_SEL_TSIF0_3,
 		/* SEL_SOF0 [2] */
-		FN_SEL_SOF0_0, FN_SEL_SOF0_1, FN_SEL_SOF0_2, 0, }
+		FN_SEL_SOF0_0, FN_SEL_SOF0_1, FN_SEL_SOF0_2, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
-			     3, 1, 1, 3, 2, 1, 1, 2, 2,
-			     1, 3, 2, 1, 2, 2, 2, 1, 1, 1) {
+			     GROUP(3, 1, 1, 3, 2, 1, 1, 2, 2, 1, 3, 2,
+				   1, 2, 2, 2, 1, 1, 1),
+			     GROUP(
 		/* SEL_SCIF0 [3] */
 		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2,
 		FN_SEL_SCIF0_3, FN_SEL_SCIF0_4,
@@ -6505,11 +6528,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [1] */
 		0, 0,
 		/* SEL_SSI8 [1] */
-		FN_SEL_SSI8_0, FN_SEL_SSI8_1, }
+		FN_SEL_SSI8_0, FN_SEL_SSI8_1, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL3", 0xE6060098, 32,
-			     2, 2, 2, 2, 2, 2, 2, 2,
-			     1, 1, 2, 2, 3, 2, 2, 2, 1) {
+			     GROUP(2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2,
+				   3, 2, 2, 2, 1),
+			     GROUP(
 		/* SEL_HSCIF2 [2] */
 		FN_SEL_HSCIF2_0, FN_SEL_HSCIF2_1,
 		FN_SEL_HSCIF2_2, FN_SEL_HSCIF2_3,
@@ -6547,11 +6571,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* RESERVED [1] */
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL4", 0xE606009C, 32,
-			     3, 2, 2, 1, 1, 1, 1, 3, 2,
-			     2, 3, 1, 1, 1, 2, 2, 2, 2) {
+			     GROUP(3, 2, 2, 1, 1, 1, 1, 3, 2, 2, 3, 1,
+				   1, 1, 2, 2, 2, 2),
+			     GROUP(
 		/* SEL_SOF1 [3] */
 		FN_SEL_SOF1_0, FN_SEL_SOF1_1, FN_SEL_SOF1_2, FN_SEL_SOF1_3,
 		FN_SEL_SOF1_4,
@@ -6593,7 +6618,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [2] */
 		0, 0, 0, 0,
 		/* RESERVED [2] */
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
index 300c76a..f49da5d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7792.c
@@ -2399,10 +2399,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_11_0_FN, FN_IP7_1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060040, 32,
-			     4, 4,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP0_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP0_27_24 [4] */
@@ -2454,13 +2455,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_1 [1] */
 		FN_DU0_DR1_DATA1, 0,
 		/* IP0_0 [1] */
-		FN_DU0_DR0_DATA0, 0 }
+		FN_DU0_DR0_DATA0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060044, 32,
-			     4, 4,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP1_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP1_27_24 [4] */
@@ -2512,13 +2514,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP1_1 [1] */
 		FN_DU0_EXVSYNC_DU0_VSYNC, 0,
 		/* IP1_0 [1] */
-		FN_DU0_EXHSYNC_DU0_HSYNC, 0 }
+		FN_DU0_EXHSYNC_DU0_HSYNC, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060048, 32,
-			     4, 4,
-			     4, 3, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   4, 3, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP2_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP2_27_24 [4] */
@@ -2560,13 +2563,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP2_1 [1] */
 		FN_VI2_CLKENB, FN_AVB_RX_DV,
 		/* IP2_0 [1] */
-		FN_VI2_CLK, FN_AVB_RX_CLK }
+		FN_VI2_CLK, FN_AVB_RX_CLK ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606004C, 32,
-			     4, 4,
-			     4, 4,
-			     1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   4, 4,
+				   1, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP3_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP3_27_24 [4] */
@@ -2606,12 +2610,13 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP3_1 [1] */
 		FN_VI3_CLKENB, FN_AVB_TXD4,
 		/* IP3_0 [1] */
-		FN_VI3_CLK, FN_AVB_TX_CLK }
+		FN_VI3_CLK, FN_AVB_TX_CLK ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060050, 32,
-			     4, 3, 1,
-			     1, 1, 1, 2, 2, 2,
-			     2, 2, 2, 2, 2, 1, 2, 1, 1) {
+			     GROUP(4, 3, 1,
+				   1, 1, 1, 2, 2, 2,
+				   2, 2, 2, 2, 2, 1, 2, 1, 1),
+			     GROUP(
 		/* IP4_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP4_27_25 [3] */
@@ -2647,13 +2652,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP4_1 [1] */
 		FN_VI4_HSYNC_N, FN_VI0_D13_G5_Y5,
 		/* IP4_0 [1] */
-		FN_VI4_CLKENB, FN_VI0_D12_G4_Y4 }
+		FN_VI4_CLKENB, FN_VI0_D12_G4_Y4 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060054, 32,
-			     4, 4,
-			     4, 4,
-			     4, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   4, 4,
+				   4, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP5_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP5_27_24 [4] */
@@ -2687,13 +2693,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP5_1 [1] */
 		FN_VI5_HSYNC_N, FN_VI1_D13_G5_Y5_B,
 		/* IP5_0 [1] */
-		FN_VI5_CLKENB, FN_VI1_D12_G4_Y4_B }
+		FN_VI5_CLKENB, FN_VI1_D12_G4_Y4_B ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060058, 32,
-			     4, 4,
-			     4, 1, 2, 1,
-			     2, 2, 2, 2,
-			     1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4,
+				   4, 1, 2, 1,
+				   2, 2, 2, 2,
+				   1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP6_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP6_27_24 [4] */
@@ -2729,13 +2736,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP6_1 [1] */
 		FN_MSIOF0_SYNC, FN_HCTS0_N,
 		/* IP6_0 [1] */
-		FN_MSIOF0_SCK, FN_HSCK0 }
+		FN_MSIOF0_SCK, FN_HSCK0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606005C, 32,
-			     4, 4,
-			     3, 1, 1, 1, 1, 1,
-			     2, 2, 2, 2,
-			     1, 1, 2, 2, 2) {
+			     GROUP(4, 4,
+				   3, 1, 1, 1, 1, 1,
+				   2, 2, 2, 2,
+				   1, 1, 2, 2, 2),
+			     GROUP(
 		/* IP7_31_28 [4] */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP7_27_24 [4] */
@@ -2769,7 +2777,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_3_2 [2] */
 		FN_PWM1, FN_TCLK2, FN_FSO_CFE_1, 0,
 		/* IP7_1_0 [2] */
-		FN_PWM0, FN_TCLK1, FN_FSO_CFE_0, 0 }
+		FN_PWM0, FN_TCLK1, FN_FSO_CFE_0, 0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 923b7b2..47a4772 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4858,8 +4858,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_0_FN, FN_SD0_CLK ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
-			     2, 2, 2, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
-			     2, 1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 2, 2, 1, 1, 2, 2, 2, 1, 1, 1, 1,
+				   1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* IP0_31_30 [2] */
 		FN_D5, FN_SCIF4_RXD_B, FN_I2C0_SCL_D, 0,
 		/* IP0_29_28 [2] */
@@ -4909,11 +4910,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_1 [1] */
 		0, 0,
 		/* IP0_0 [1] */
-		FN_SD1_CD, FN_CAN0_RX, }
+		FN_SD1_CD, FN_CAN0_RX, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xE6060024, 32,
-			     2, 2, 1, 1, 1, 1, 2, 2, 2, 3, 2, 2, 3, 2, 2,
-			     2, 2) {
+			     GROUP(2, 2, 1, 1, 1, 1, 2, 2, 2, 3, 2, 2,
+				   3, 2, 2, 2, 2),
+			     GROUP(
 		/* IP1_31_30 [2] */
 		FN_A6, FN_SCIFB0_CTS_N, FN_SCIFA4_RXD_B, FN_TPUTO2_C,
 		/* IP1_29_28 [2] */
@@ -4949,10 +4951,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP1_3_2 [2] */
 		FN_D7, FN_IRQ3, FN_TCLK1, FN_PWM6_B,
 		/* IP1_1_0 [2] */
-		FN_D6, FN_SCIF4_TXD_B, FN_I2C0_SDA_D, 0, }
+		FN_D6, FN_SCIF4_TXD_B, FN_I2C0_SDA_D, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
-			     2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2),
+			     GROUP(
 		/* IP2_31_30 [2] */
 		FN_A20, FN_SPCLK, 0, 0,
 		/* IP2_29_27 [3] */
@@ -4984,10 +4987,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP2_3_2 [2] */
 		FN_A8, FN_MSIOF1_RXD, FN_SCIFA0_RXD_B, 0,
 		/* IP2_1_0 [2] */
-		FN_A7, FN_SCIFB0_RTS_N, FN_SCIFA4_TXD_B, 0, }
+		FN_A7, FN_SCIFB0_RTS_N, FN_SCIFA4_TXD_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xE606002C, 32,
-			     1, 1, 3, 3, 3, 3, 3, 2, 1, 1, 1, 2, 2, 2, 2, 2) {
+			     GROUP(1, 1, 3, 3, 3, 3, 3, 2, 1, 1, 1, 2,
+				   2, 2, 2, 2),
+			     GROUP(
 		/* IP3_31 [1] */
 		FN_RD_WR_N, FN_ATAG1_N,
 		/* IP3_30 [1] */
@@ -5024,10 +5029,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP3_3_2 [2] */
 		FN_A22, FN_MISO_IO1, 0, FN_ATADIR1_N,
 		/* IP3_1_0 [2] */
-		FN_A21, FN_MOSI_IO0, 0, 0, }
+		FN_A21, FN_MOSI_IO0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xE6060030, 32,
-			     2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 2) {
+			     GROUP(2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 2),
+			     GROUP(
 		/* IP4_31_30 [2] */
 		FN_DU0_DG4, FN_LCDOUT12, 0, 0,
 		/* IP4_29_28 [2] */
@@ -5059,10 +5065,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_DU0_DR0, FN_LCDOUT16, FN_SCIF5_RXD_C, FN_I2C2_SCL_D,
 		0, 0, 0, 0,
 		/* IP4_1_0 [2] */
-		FN_EX_WAIT0, FN_CAN_CLK_B, FN_SCIF_CLK, 0, }
+		FN_EX_WAIT0, FN_CAN_CLK_B, FN_SCIF_CLK, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xE6060034, 32,
-			     2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 2, 2) {
+			     GROUP(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3,
+				   2, 2, 2),
+			     GROUP(
 		/* IP5_31_30 [2] */
 		FN_DU0_EXHSYNC_DU0_HSYNC, FN_QSTH_QHS, 0, 0,
 		/* IP5_29_28 [2] */
@@ -5094,11 +5102,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP5_3_2 [2] */
 		FN_DU0_DG6, FN_LCDOUT14, 0, 0,
 		/* IP5_1_0 [2] */
-		FN_DU0_DG5, FN_LCDOUT13, 0, 0, }
+		FN_DU0_DG5, FN_LCDOUT13, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xE6060038, 32,
-			     3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,
-			     2, 2) {
+			     GROUP(3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 2, 2, 2, 2),
+			     GROUP(
 		/* IP6_31_29 [3] */
 		FN_ETH_MDIO, FN_VI0_G0, FN_MSIOF2_RXD_B, FN_I2C5_SCL_D,
 		FN_AVB_TX_CLK, FN_ADIDATA, 0, 0,
@@ -5140,10 +5149,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_DU0_EXODDF_DU0_ODDF_DISP_CDE, FN_QCPV_QDE, 0,
 		0,
 		/* IP6_1_0 [2] */
-		FN_DU0_EXVSYNC_DU0_VSYNC, FN_QSTB_QHE, 0, 0, }
+		FN_DU0_EXVSYNC_DU0_VSYNC, FN_QSTB_QHE, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xE606003C, 32,
-			     1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP7_31 [1] */
 		FN_DREQ0_N, FN_SCIFB1_RXD,
 		/* IP7_30 [1] */
@@ -5177,10 +5187,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_AVB_TXD1, FN_ADICLK, 0, 0,
 		/* IP7_2_0 [3] */
 		FN_ETH_CRS_DV, FN_VI0_G1, FN_MSIOF2_TXD_B, FN_I2C5_SDA_D,
-		FN_AVB_TXD0, FN_ADICS_SAMP, 0, 0, }
+		FN_AVB_TXD0, FN_ADICS_SAMP, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xE6060040, 32,
-			     3, 3, 3, 3, 3, 2, 3, 3, 3, 3, 3) {
+			     GROUP(3, 3, 3, 3, 3, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP8_31_29 [3] */
 		FN_MSIOF0_RXD, FN_SCIF5_RXD, FN_I2C2_SCL_C, FN_DU1_DR2,
 		0, FN_TS_SDEN_D, FN_FMCLK_C, 0,
@@ -5212,10 +5223,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_AVB_MDIO, FN_SSI_SCK78_B, 0, 0,
 		/* IP8_2_0 [3] */
 		FN_ETH_MDC, FN_VI0_R3, FN_SCIF3_TXD_B, FN_I2C4_SDA_E,
-		FN_AVB_MDC, FN_SSI_SDATA6_B, 0, 0, }
+		FN_AVB_MDC, FN_SSI_SDATA6_B, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xE6060044, 32,
-			     1, 3, 3, 3, 3, 2, 2, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 3, 3, 3, 3, 2, 2, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP9_31 [1] */
 		0, 0,
 		/* IP9_30_28 [3] */
@@ -5248,10 +5260,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, FN_TPUTO1_C, 0, 0,
 		/* IP9_2_0 [3] */
 		FN_MSIOF0_TXD, FN_SCIF5_TXD, FN_I2C2_SDA_C, FN_DU1_DR3,
-		0, FN_TS_SPSYNC_D, FN_FMIN_C, 0, }
+		0, FN_TS_SPSYNC_D, FN_FMIN_C, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xE6060048, 32,
-			     2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP10_31_30 [2] */
 		FN_SSI_SCK5, FN_SCIFA3_SCK, FN_DU1_DOTCLKIN, 0,
 		/* IP10_29_27 [3] */
@@ -5283,10 +5296,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		/* IP10_2_0 [3] */
 		FN_SCIF1_RXD, FN_I2C5_SCL, FN_DU1_DG6, FN_SSI_SCK2_B,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
-			     2, 3, 3, 3, 3, 2, 2, 3, 3, 2, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 2, 2, 3, 3, 2, 3, 3),
+			     GROUP(
 		/* IP11_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP11_29_27 [3] */
@@ -5318,10 +5332,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		/* IP11_2_0 [3] */
 		FN_SSI_WS5, FN_SCIFA3_RXD, FN_I2C3_SCL_C, FN_DU1_DOTCLKOUT0,
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR12", 0xE6060050, 32,
-			     2, 3, 3, 3, 3, 3, 2, 2, 2, 3, 3, 3) {
+			     GROUP(2, 3, 3, 3, 3, 3, 2, 2, 2, 3, 3, 3),
+			     GROUP(
 		/* IP12_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP12_29_27 [3] */
@@ -5353,10 +5368,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_CAN1_RX_C, FN_DACK1_B, 0, 0,
 		/* IP12_2_0 [3] */
 		FN_SSI_SCK34, FN_MSIOF1_SYNC_B, FN_SCIFA1_SCK_C, FN_ADICHS0_B,
-		0, FN_DREQ1_N_B, 0, 0, }
+		0, FN_DREQ1_N_B, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR13", 0xE6060054, 32,
-			     1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 		/* IP13_31 [1] */
 		0, 0,
 		/* IP13_30 [1] */
@@ -5393,11 +5409,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_VI1_DATA4, 0, FN_ATACS10_N, FN_ETH_REFCLK_B, 0,
 		/* IP13_2_0 [3] */
 		FN_SSI_WS2, FN_HSCIF1_HCTS_N_B, FN_SCIFA0_RXD_D, FN_VI1_DATA3,
-		0, FN_ATACS00_N, FN_ETH_LINK_B, 0, }
+		0, FN_ATACS00_N, FN_ETH_LINK_B, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL", 0xE6060090, 32,
-			     2, 1, 2, 3, 4, 1, 1, 3, 3, 3, 3, 3,
-			     2, 1) {
+			     GROUP(2, 1, 2, 3, 4, 1, 1, 3, 3, 3, 3, 3, 2, 1),
+			     GROUP(
 		/* SEL_ADG [2] */
 		FN_SEL_ADG_0, FN_SEL_ADG_1, FN_SEL_ADG_2, FN_SEL_ADG_3,
 		/* RESERVED [1] */
@@ -5431,11 +5447,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_I2C05 [2] */
 		FN_SEL_I2C05_0, FN_SEL_I2C05_1, FN_SEL_I2C05_2, FN_SEL_I2C05_3,
 		/* RESERVED [1] */
-		0, 0, }
+		0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
-			     2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1,
-			     2, 2, 2, 1, 1, 2) {
+			     GROUP(2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1,
+				   2, 2, 1, 1, 2, 2, 2, 1, 1, 2),
+			     GROUP(
 		/* SEL_IEB [2] */
 		FN_SEL_IEB_0, FN_SEL_IEB_1, FN_SEL_IEB_2, 0,
 		/* SEL_IIC0 [2] */
@@ -5482,11 +5499,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_HSCIF1 [1] */
 		FN_SEL_HSCIF1_0, FN_SEL_HSCIF1_1,
 		/* RESERVED [2] */
-		0, 0, 0, 0, }
+		0, 0, 0, 0, ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL3", 0xE6060098, 32,
-			     2, 2, 2, 1, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 2, 2, 1, 3, 2, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* SEL_SCIF0 [2] */
 		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2, FN_SEL_SCIF0_3,
 		/* SEL_SCIF1 [2] */
@@ -5539,7 +5557,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED [1] */
 		0, 0,
 		/* RESERVED [1] */
-		0, 0, }
+		0, 0, ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 2085f2b..63e406d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -5158,8 +5158,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     1, 2, 2, 3, 1, 1, 2, 1, 1, 1,
-			     2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 2, 1) {
+			     GROUP(1, 2, 2, 3, 1, 1, 2, 1, 1, 1, 2, 1,
+				   1, 1, 1, 1, 1, 1, 2, 2, 1, 2, 1),
+			     GROUP(
 		0, 0, /* RESERVED 31 */
 		MOD_SEL0_30_29
 		MOD_SEL0_28_27
@@ -5182,11 +5183,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_5_4
 		MOD_SEL0_3
 		MOD_SEL0_2_1
-		0, 0, /* RESERVED 0 */ }
+		0, 0, /* RESERVED 0 */ ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     2, 3, 1, 2, 3, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 3, 1, 2, 3, 1, 1, 2, 1, 2, 1, 1,
+				   1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		MOD_SEL1_31_30
 		MOD_SEL1_29_28_27
 		MOD_SEL1_26
@@ -5209,11 +5211,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3
 		MOD_SEL1_2
 		MOD_SEL1_1
-		MOD_SEL1_0 }
+		MOD_SEL1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xe6060508, 32,
-			     1, 1, 1, 1, 4, 4, 4,
-			     4, 4, 4, 1, 2, 1) {
+			     GROUP(1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 1, 2, 1),
+			     GROUP(
 		MOD_SEL2_31
 		MOD_SEL2_30
 		MOD_SEL2_29
@@ -5241,7 +5243,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		/* RESERVED 2, 1 */
 		0, 0, 0, 0,
-		MOD_SEL2_0 }
+		MOD_SEL2_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 03b0a16..00081c3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5549,8 +5549,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     3, 2, 3, 1, 1, 1, 1, 1, 2, 1,
-			     1, 2, 1, 1, 1, 2, 2, 1, 2, 3) {
+			     GROUP(3, 2, 3, 1, 1, 1, 1, 1, 2, 1, 1, 2,
+				   1, 1, 1, 2, 2, 1, 2, 3),
+			     GROUP(
 		MOD_SEL0_31_30_29
 		MOD_SEL0_28_27
 		MOD_SEL0_26_25_24
@@ -5571,11 +5572,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_5
 		MOD_SEL0_4_3
 		/* RESERVED 2, 1, 0 */
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     2, 3, 1, 2, 3, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 3, 1, 2, 3, 1, 1, 2, 1, 2, 1, 1,
+				   1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		MOD_SEL1_31_30
 		MOD_SEL1_29_28_27
 		MOD_SEL1_26
@@ -5598,11 +5600,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3
 		MOD_SEL1_2
 		MOD_SEL1_1
-		MOD_SEL1_0 }
+		MOD_SEL1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xe6060508, 32,
-			     1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1, 1,
-			     4, 4, 4, 3, 1) {
+			     GROUP(1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1,
+				   1, 4, 4, 4, 3, 1),
+			     GROUP(
 		MOD_SEL2_31
 		MOD_SEL2_30
 		MOD_SEL2_29
@@ -5629,7 +5632,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3, 2, 1 */
 		0, 0, 0, 0, 0, 0, 0, 0,
-		MOD_SEL2_0 }
+		MOD_SEL2_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index f4e2dc2..fcde6ce 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -5506,8 +5506,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     3, 2, 3, 1, 1, 1, 1, 1, 2, 1,
-			     1, 2, 1, 1, 1, 2, 2, 1, 2, 3) {
+			     GROUP(3, 2, 3, 1, 1, 1, 1, 1, 2, 1, 1, 2,
+				   1, 1, 1, 2, 2, 1, 2, 3),
+			     GROUP(
 		MOD_SEL0_31_30_29
 		MOD_SEL0_28_27
 		MOD_SEL0_26_25_24
@@ -5528,11 +5529,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_5
 		MOD_SEL0_4_3
 		/* RESERVED 2, 1, 0 */
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     2, 3, 1, 2, 3, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 3, 1, 2, 3, 1, 1, 2, 1, 2, 1, 1,
+				   1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		MOD_SEL1_31_30
 		MOD_SEL1_29_28_27
 		MOD_SEL1_26
@@ -5555,11 +5557,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3
 		MOD_SEL1_2
 		MOD_SEL1_1
-		MOD_SEL1_0 }
+		MOD_SEL1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xe6060508, 32,
-			     1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1, 1,
-			     4, 4, 4, 3, 1) {
+			     GROUP(1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1,
+				   1, 4, 4, 4, 3, 1),
+			     GROUP(
 		MOD_SEL2_31
 		MOD_SEL2_30
 		MOD_SEL2_29
@@ -5585,7 +5588,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3, 2, 1 */
 		0, 0, 0, 0, 0, 0, 0, 0,
-		MOD_SEL2_0 }
+		MOD_SEL2_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index e07f2a5..08c6635 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -4491,8 +4491,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     3, 2, 3, 1, 1, 1, 1, 1, 2, 1,
-			     1, 2, 1, 1, 1, 2, 2, 1, 2, 3) {
+			     GROUP(3, 2, 3, 1, 1, 1, 1, 1, 2, 1, 1, 2,
+				   1, 1, 1, 2, 2, 1, 2, 3),
+			     GROUP(
 		MOD_SEL0_31_30_29
 		MOD_SEL0_28_27
 		MOD_SEL0_26_25_24
@@ -4513,11 +4514,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_5
 		MOD_SEL0_4_3
 		/* RESERVED 2, 1, 0 */
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     2, 3, 1, 2, 3, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 3, 1, 2, 3, 1, 1, 2, 1, 2, 1, 1,
+				   1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		MOD_SEL1_31_30
 		MOD_SEL1_29_28_27
 		MOD_SEL1_26
@@ -4540,11 +4542,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3
 		MOD_SEL1_2
 		MOD_SEL1_1
-		MOD_SEL1_0 }
+		MOD_SEL1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xe6060508, 32,
-			     1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1, 1,
-			     4, 4, 4, 3, 1) {
+			     GROUP(1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1,
+				   1, 4, 4, 4, 3, 1),
+			     GROUP(
 		MOD_SEL2_31
 		MOD_SEL2_30
 		MOD_SEL2_29
@@ -4570,7 +4573,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3, 2, 1 */
 		0, 0, 0, 0, 0, 0, 0, 0,
-		MOD_SEL2_0 }
+		MOD_SEL2_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index f5265e0..42538ab 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -2354,8 +2354,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     4, 4, 4, 4,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1),
+			     GROUP(
 		/* RESERVED 31, 30, 29, 28 */
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 27, 26, 25, 24 */
@@ -2377,7 +2378,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_3
 		MOD_SEL0_2
 		MOD_SEL0_1
-		MOD_SEL0_0 }
+		MOD_SEL0_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 904c506..629fa0c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -2751,8 +2751,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     4, 4, 4, 4,
-			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1,
+				   1, 1, 1, 1, 1),
+			     GROUP(
 		/* RESERVED 31, 30, 29, 28 */
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 27, 26, 25, 24 */
@@ -2774,7 +2775,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		MOD_SEL0_2
 		MOD_SEL0_1
-		MOD_SEL0_0 }
+		MOD_SEL0_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index f72d97b..7b64da2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -4937,8 +4937,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     1, 2, 1, 2, 1, 1, 1, 1, 2, 3, 1,
-			     1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2) {
+			     GROUP(1, 2, 1, 2, 1, 1, 1, 1, 2, 3, 1, 1,
+				   1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2),
+			     GROUP(
 		/* RESERVED 31 */
 		0, 0,
 		MOD_SEL0_30_29
@@ -4962,11 +4963,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_4
 		MOD_SEL0_3
 		MOD_SEL0_2
-		MOD_SEL0_1_0 }
+		MOD_SEL0_1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1,
-			     1, 2, 2, 2, 1, 1, 2, 1, 4) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1,
+				   1, 2, 2, 2, 1, 1, 2, 1, 4),
+			     GROUP(
 		MOD_SEL1_31
 		MOD_SEL1_30
 		MOD_SEL1_29
@@ -4989,7 +4991,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_6_5
 		MOD_SEL1_4
 		/* RESERVED 3, 2, 1, 0  */
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 5baa948..06babec 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -2404,8 +2404,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1,
-			     1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1,
+				   1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* RESERVED 31 */
 		0, 0,
 		MOD_SEL0_30
@@ -2433,11 +2434,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_3
 		MOD_SEL0_2
 		MOD_SEL0_1
-		MOD_SEL0_0 }
+		MOD_SEL0_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     1, 1, 1, 1, 1, 1, 2, 4, 4,
-			     4, 4, 4, 4) {
+			     GROUP(1, 1, 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4),
+			     GROUP(
 		MOD_SEL1_31
 		MOD_SEL1_30
 		MOD_SEL1_29
@@ -2457,7 +2458,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED 7, 6, 5, 4  */
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3, 2, 1, 0  */
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 3174ffb..42c2234a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -1826,8 +1826,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xFFFC001C, 32,
-			2, 2, 2, 2, 2, 2, 2, 2,
-			2, 2, 2, 2, 2, 2, 2, 2) {
+			GROUP(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
+			GROUP(
 		/* IP0_31_30 [2] */
 		FN_A15, FN_ST0_VCO_CLKIN, FN_LCD_DATA15_A,
 			FN_TIOC3D_C,
@@ -1860,10 +1860,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_3_2 [2] */
 		FN_A1, FN_ST0_REQ, FN_LCD_DATA1_A, FN_TCLKB_C,
 		/* IP0_1_0 [2] */
-		FN_A0, FN_ST0_CLKIN, FN_LCD_DATA0_A, FN_TCLKA_C }
+		FN_A0, FN_ST0_CLKIN, FN_LCD_DATA0_A, FN_TCLKA_C ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR1", 0xFFFC0020, 32,
-			3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2) {
+			GROUP(3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
+			GROUP(
 		/* IP1_31_29 [3] */
 		FN_D3, FN_SD0_DAT3_A, FN_MMC_D3_A, FN_ST1_D6,
 			FN_FD3_A, 0, 0, 0,
@@ -1895,10 +1896,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP1_3_2 [2] */
 		FN_A17, FN_ST1_VCO_CLKIN, FN_LCD_CL1_A,	FN_TIOC4B_C,
 		/* IP1_1_0 [2] */
-		FN_A16, FN_ST0_PWM, FN_LCD_DON_A, FN_TIOC4A_C }
+		FN_A16, FN_ST0_PWM, FN_LCD_DON_A, FN_TIOC4A_C ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xFFFC0024, 32,
-			     1, 3, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3) {
+			     GROUP(1, 3, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3),
+			     GROUP(
 		/* IP2_31 [1] */
 		0, 0,
 		/* IP2_30_28 [3] */
@@ -1931,10 +1933,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_D5, FN_SD0_WP_A, FN_MMC_D5_A, FN_FD5_A,
 		/* IP2_2_0 [3] */
 		FN_D4, FN_SD0_CD_A, FN_MMC_D4_A, FN_ST1_D7,
-			FN_FD4_A, 0, 0, 0 }
+			FN_FD4_A, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR3", 0xFFFC0028, 32,
-				2, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 1, 2) {
+			     GROUP(2, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 1, 2),
+			     GROUP(
 	    /* IP3_31_30 [2] */
 		0, 0, 0, 0,
 	    /* IP3_29_27 [3] */
@@ -1968,10 +1971,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP3_2 [1] */
 		FN_CS1_A26, FN_QIO3_B,
 	    /* IP3_1_0 [2] */
-		FN_D15, FN_SCK2_B, 0, 0 }
+		FN_D15, FN_SCK2_B, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xFFFC002C, 32,
-				2, 2, 2, 2, 2, 2 , 2, 3, 3, 3, 3, 3, 3) {
+			     GROUP(2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP4_31_30 [2] */
 		0, FN_SCK2_A, FN_VI0_G3, 0,
 	    /* IP4_29_28 [2] */
@@ -2003,10 +2007,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			FN_ET0_RX_DV, 0, 0, 0,
 	    /* IP4_2_0 [3] */
 		FN_HCTS0_A, FN_CTS1_A, FN_VI0_FIELD, FN_RMII0_RXD1_A,
-			FN_ET0_ERXD7, 0, 0, 0 }
+			FN_ET0_ERXD7, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR5", 0xFFFC0030, 32,
-				1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3,
+				   3, 3, 3),
+			     GROUP(
 	    /* IP5_31 [1] */
 	    0, 0,
 	    /* IP5_30 [1] */
@@ -2043,11 +2049,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, FN_ET0_ERXD2_B,
 	    /* IP5_2_0 [3] */
 		FN_SD2_CLK_A, FN_RX2_A, FN_VI0_G4, 0,
-		FN_ET0_RX_CLK_B, 0, 0, 0 }
+		FN_ET0_RX_CLK_B, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR6", 0xFFFC0034, 32,
-				1, 1, 1, 1, 1, 1, 1, 1,
-				3, 3, 2, 2, 2, 2, 2, 2, 3, 3) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 2, 2,
+				   2, 2, 2, 2, 3, 3),
+			     GROUP(
 	    /* IP5_31 [1] */
 	    0, 0,
 	    /* IP6_30 [1] */
@@ -2087,10 +2094,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_TCLKB_A, FN_HIFD01, 0, 0,
 	    /* IP6_2_0 [3] */
 		FN_DU0_DR0, FN_SCIF_CLK_B, FN_HRX0_D, FN_IETX_A,
-		FN_TCLKA_A, FN_HIFD00, 0, 0 }
+		FN_TCLKA_A, FN_HIFD00, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR7", 0xFFFC0038, 32,
-			     1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
+			     GROUP(1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP7_31 [1] */
 	    0, 0,
 	    /* IP7_30_29 [2] */
@@ -2123,10 +2131,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_HIFD11, 0, 0, 0,
 	    /* IP7_2_0 [3] */
 		FN_DU0_DG2, FN_RTS1_C, FN_RMII0_MDC_B, FN_TIOC2A_A,
-		FN_HIFD10, 0, 0, 0 }
+		FN_HIFD10, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR8", 0xFFFC003C, 32,
-			     2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(2, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2,
+				   2, 2, 2),
+			     GROUP(
 	    /* IP9_31_30 [2] */
 	    0, 0, 0, 0,
 	    /* IP8_29_28 [2] */
@@ -2159,11 +2169,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP8_3_2 [2] */
 		FN_DU0_DB6, 0, FN_HIFRDY, 0,
 	    /* IP8_1_0 [2] */
-		FN_DU0_DB5, 0, FN_HIFDREQ, 0 }
+		FN_DU0_DB5, 0, FN_HIFDREQ, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR9", 0xFFFC0040, 32,
-			     2, 2, 2, 2, 2, 2, 2, 2,
-			     2, 2, 2, 2, 2, 2, 2, 2) {
+			     GROUP(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
+				   2, 2, 2, 2),
+			     GROUP(
 	    /* IP9_31_30 [2] */
 	    0, 0, 0, 0,
 	    /* IP9_29_28 [2] */
@@ -2195,11 +2206,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP9_3_2 [2] */
 		FN_VI1_0_A, 0, FN_FD1_B, FN_LCD_DATA1_B,
 	    /* IP9_1_0 [2] */
-		FN_VI1_CLK_A, 0, FN_FD0_B, FN_LCD_DATA0_B }
+		FN_VI1_CLK_A, 0, FN_FD0_B, FN_LCD_DATA0_B ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR10", 0xFFFC0044, 32,
-					2, 2, 2, 1, 2, 1, 3,
-					3, 1, 3, 3, 3, 3, 3) {
+			     GROUP(2, 2, 2, 1, 2, 1, 3, 3, 1, 3, 3, 3, 3, 3),
+			     GROUP(
 	    /* IP9_31_30 [2] */
 	    0, 0, 0, 0,
 	    /* IP10_29_28 [2] */
@@ -2234,10 +2245,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD_DON_B, 0, 0, 0,
 	    /* IP10_2_0 [3] */
 		FN_SSI_SCK23, FN_VI1_4_B, FN_RX1_D, FN_FCLE_B,
-		FN_LCD_DATA15_B, 0, 0, 0 }
+		FN_LCD_DATA15_B, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xFFFC0048, 32,
-			3, 1, 2, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
+			     GROUP(3, 1, 2, 3, 2, 2, 3, 3, 1, 2, 3, 3,
+				   1, 1, 1, 1),
+			     GROUP(
 	    /* IP11_31_29 [3] */
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    /* IP11_28 [1] */
@@ -2274,11 +2287,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* IP11_1 [1] */
 		FN_SDA1, FN_RX1_E,
 	    /* IP11_0 [1] */
-		FN_SCL1, FN_SCIF_CLK_C }
+		FN_SCL1, FN_SCIF_CLK_C ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xFFFC004C, 32,
-				3, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 2,
-				1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(3, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2,
+				   2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		/* SEL1_31_29 [3] */
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* SEL1_28 [1] */
@@ -2330,11 +2344,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL1_1 [1] */
 		FN_SEL_MMC_0, FN_SEL_MMC_1,
 		/* SEL1_0 [1] */
-		FN_SEL_INTC_0, FN_SEL_INTC_1 }
+		FN_SEL_INTC_0, FN_SEL_INTC_1 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xFFFC0050, 32,
-				1, 1, 1, 1, 1, 1, 1, 1,
-				1, 1, 1, 2, 2, 1, 2, 2, 3, 2, 3, 2, 2) {
+			     GROUP(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
+				   2, 1, 2, 2, 3, 2, 3, 2, 2),
+			     GROUP(
 		/* SEL2_31 [1] */
 		0, 0,
 		/* SEL2_30 [1] */
@@ -2378,7 +2393,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL2_3_2 [2] */
 		FN_SEL_SCIF0_0, FN_SEL_SCIF0_1, FN_SEL_SCIF0_2, 0,
 		/* SEL2_1_0 [2] */
-		FN_SEL_SCIF_CLK_0, FN_SEL_SCIF_CLK_1, FN_SEL_SCIF_CLK_2, 0  }
+		FN_SEL_SCIF_CLK_0, FN_SEL_SCIF_CLK_1, FN_SEL_SCIF_CLK_2, 0  ))
 	},
 	/* GPIO 0 - 5*/
 	{ PINMUX_CFG_REG("INOUTSEL0", 0xFFC40004, 32, 1, GROUP(GP_INOUTSEL(0)))
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 8ad5721..d775e1e 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -142,16 +142,17 @@ struct pinmux_cfg_reg {
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
- *   - var_fw0, var_fwn...: List of widths of the register fields (in bits),
- *                          From left to right (i.e. MSB to LSB)
- * This macro must be followed by initialization data: For each register field
- * (from left to right, i.e. MSB to LSB), 2^var_fwi enum IDs must be specified,
- * one for each possible combination of the register field bit values.
+ *   - f_widths: List of widths of the register fields (in bits), from left
+ *               to right (i.e. MSB to LSB), wrapped using the GROUP() macro.
+ *   - ids: For each register field (from left to right, i.e. MSB to LSB),
+ *          2^f_widths[i] enum IDs must be specified, one for each possible
+ *          combination of the register field bit values, all wrapped using
+ *          the GROUP() macro.
  */
-#define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
-	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (const u8 []) { var_fw0, var_fwn, 0 }, \
-	.enum_ids = (const u16 [])
+#define PINMUX_CFG_REG_VAR(name, r, r_width, f_widths, ids)		\
+	.reg = r, .reg_width = r_width,					\
+	.var_field_width = (const u8 []) { f_widths, 0 },		\
+	.enum_ids = (const u16 []) { ids }
 
 struct pinmux_drive_reg_field {
 	u16 pin;
@@ -669,7 +670,9 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
  */
 #define PORTCR(nr, reg)							\
 	{								\
-		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8, 2, 2, 1, 3) {\
+		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8,		\
+				   GROUP(2, 2, 1, 3),			\
+				   GROUP(				\
 			/* PULMD[1:0], handled by .set_bias() */	\
 			0, 0, 0, 0,					\
 			/* IE and OE */					\
@@ -681,7 +684,7 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 			PORT##nr##_FN2, PORT##nr##_FN3,			\
 			PORT##nr##_FN4, PORT##nr##_FN5,			\
 			PORT##nr##_FN6, PORT##nr##_FN7			\
-		}							\
+		))							\
 	}
 
 /*
-- 
2.7.4
