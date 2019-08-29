From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:38 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 33/51] pinctrl: sh-pfc:
	r8a77990: Fix MOD_SEL1 bit30 when using SSI_SCK2 and SSI_WS2
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-34-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit e87882eb9be10b2b9e28156922c2a47d877f5db4 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of Aug
24, 2018, there is no need to configure MOD_SEL1 bit30 when the
SSI_SCK2_{A,B} or SSI_WS2_{A,B} pin functions are selected.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Remove now unused definitions, mark MOD_SEL1 bit30 reserved]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 8a95cb5..4557070 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -429,7 +429,6 @@ FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM
 #define MOD_SEL0_1_0	   REV4(FM(SEL_SPEED_PULSE_IF_0),	FM(SEL_SPEED_PULSE_IF_1),	FM(SEL_SPEED_PULSE_IF_2),	F_(0, 0))
 
 /* MOD_SEL1 */			/* 0 */				/* 1 */				/* 2 */				/* 3 */			/* 4 */			/* 5 */		/* 6 */		/* 7 */
-#define MOD_SEL1_30		FM(SEL_SSI2_0)			FM(SEL_SSI2_1)
 #define MOD_SEL1_29		FM(SEL_TIMER_TMU_0)		FM(SEL_TIMER_TMU_1)
 #define MOD_SEL1_28		FM(SEL_USB_20_CH0_0)		FM(SEL_USB_20_CH0_1)
 #define MOD_SEL1_26		FM(SEL_DRIF2_0)			FM(SEL_DRIF2_1)
@@ -450,7 +449,7 @@ FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM
 
 #define PINMUX_MOD_SELS	\
 \
-MOD_SEL0_30_29		MOD_SEL1_30 \
+MOD_SEL0_30_29 \
 			MOD_SEL1_29 \
 MOD_SEL0_28		MOD_SEL1_28 \
 MOD_SEL0_27_26 \
@@ -1040,7 +1039,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP10_27_24,		RIF0_CLK_B,	SEL_DRIF0_1),
 	PINMUX_IPSR_MSEL(IP10_27_24,		SCL2_B,		SEL_I2C2_1),
 	PINMUX_IPSR_MSEL(IP10_27_24,		TCLK1_A,	SEL_TIMER_TMU_0),
-	PINMUX_IPSR_MSEL(IP10_27_24,		SSI_SCK2_B,	SEL_SSI2_1),
+	PINMUX_IPSR_GPSR(IP10_27_24,		SSI_SCK2_B),
 	PINMUX_IPSR_GPSR(IP10_27_24,		TS_SCK0),
 
 	PINMUX_IPSR_GPSR(IP10_31_28,		SD0_WP),
@@ -1049,7 +1048,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP10_31_28,		RIF0_D0_B,	SEL_DRIF0_1),
 	PINMUX_IPSR_MSEL(IP10_31_28,		SDA2_B,		SEL_I2C2_1),
 	PINMUX_IPSR_MSEL(IP10_31_28,		TCLK2_A,	SEL_TIMER_TMU_0),
-	PINMUX_IPSR_MSEL(IP10_31_28,		SSI_WS2_B,	SEL_SSI2_1),
+	PINMUX_IPSR_GPSR(IP10_31_28,		SSI_WS2_B),
 	PINMUX_IPSR_GPSR(IP10_31_28,		TS_SDAT0),
 
 	/* IPSR11 */
@@ -1067,13 +1066,13 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_MSEL(IP11_11_8,		RX0_A,		SEL_SCIF0_0),
 	PINMUX_IPSR_MSEL(IP11_11_8,		HRX1_A,		SEL_HSCIF1_0),
-	PINMUX_IPSR_MSEL(IP11_11_8,		SSI_SCK2_A,	SEL_SSI2_0),
+	PINMUX_IPSR_GPSR(IP11_11_8,		SSI_SCK2_A),
 	PINMUX_IPSR_GPSR(IP11_11_8,		RIF1_SYNC),
 	PINMUX_IPSR_GPSR(IP11_11_8,		TS_SCK1),
 
 	PINMUX_IPSR_MSEL(IP11_15_12,		TX0_A,		SEL_SCIF0_0),
 	PINMUX_IPSR_GPSR(IP11_15_12,		HTX1_A),
-	PINMUX_IPSR_MSEL(IP11_15_12,		SSI_WS2_A,	SEL_SSI2_0),
+	PINMUX_IPSR_GPSR(IP11_15_12,		SSI_WS2_A),
 	PINMUX_IPSR_GPSR(IP11_15_12,		RIF1_D0),
 	PINMUX_IPSR_GPSR(IP11_15_12,		TS_SDAT1),
 
@@ -4964,12 +4963,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     GROUP(1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1,
-				   1, 2, 2, 2, 1, 1, 2, 1, 4),
+			     GROUP(2, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1,
+				   2, 2, 2, 1, 1, 2, 1, 4),
 			     GROUP(
-		/* RESERVED 31 */
-		0, 0,
-		MOD_SEL1_30
+		/* RESERVED 31, 30 */
+		0, 0, 0, 0,
 		MOD_SEL1_29
 		MOD_SEL1_28
 		/* RESERVED 27 */
-- 
2.7.4
