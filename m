From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:37 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 32/51] pinctrl: sh-pfc:
	r8a77990: Fix MOD_SEL1 bit31 when using SIM0_D
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-33-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit e167d723e1a472d252e5c4baf823b77ce5543b05 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
Aug 24, 2018, there is no need to configure MOD_SEL1 bit31 when the
SIM0_D_{A,B} pin function is selected.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Remove now unused definitions, mark MOD_SEL1 bit31 reserved]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index fba0c22..8a95cb5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -429,7 +429,6 @@ FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM
 #define MOD_SEL0_1_0	   REV4(FM(SEL_SPEED_PULSE_IF_0),	FM(SEL_SPEED_PULSE_IF_1),	FM(SEL_SPEED_PULSE_IF_2),	F_(0, 0))
 
 /* MOD_SEL1 */			/* 0 */				/* 1 */				/* 2 */				/* 3 */			/* 4 */			/* 5 */		/* 6 */		/* 7 */
-#define MOD_SEL1_31		FM(SEL_SIMCARD_0)		FM(SEL_SIMCARD_1)
 #define MOD_SEL1_30		FM(SEL_SSI2_0)			FM(SEL_SSI2_1)
 #define MOD_SEL1_29		FM(SEL_TIMER_TMU_0)		FM(SEL_TIMER_TMU_1)
 #define MOD_SEL1_28		FM(SEL_USB_20_CH0_0)		FM(SEL_USB_20_CH0_1)
@@ -451,7 +450,6 @@ FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM
 
 #define PINMUX_MOD_SELS	\
 \
-			MOD_SEL1_31 \
 MOD_SEL0_30_29		MOD_SEL1_30 \
 			MOD_SEL1_29 \
 MOD_SEL0_28		MOD_SEL1_28 \
@@ -1180,7 +1178,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP13_19_16,		RIF0_D1_A,	SEL_DRIF0_0),
 	PINMUX_IPSR_MSEL(IP13_19_16,		SDA1_B,		SEL_I2C1_1),
 	PINMUX_IPSR_MSEL(IP13_19_16,		TCLK2_B,	SEL_TIMER_TMU_1),
-	PINMUX_IPSR_MSEL(IP13_19_16,		SIM0_D_A,	SEL_SIMCARD_0),
+	PINMUX_IPSR_GPSR(IP13_19_16,		SIM0_D_A),
 
 	PINMUX_IPSR_GPSR(IP13_23_20,		MLB_DAT),
 	PINMUX_IPSR_MSEL(IP13_23_20,		TX0_B,		SEL_SCIF0_1),
@@ -1248,7 +1246,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP15_15_12,		TPU0TO2),
 	PINMUX_IPSR_MSEL(IP15_15_12,		SDA1_D,		SEL_I2C1_3),
 	PINMUX_IPSR_MSEL(IP15_15_12,		FSO_CFE_1_N_B,	SEL_FSO_1),
-	PINMUX_IPSR_MSEL(IP15_15_12,		SIM0_D_B,	SEL_SIMCARD_1),
+	PINMUX_IPSR_GPSR(IP15_15_12,		SIM0_D_B),
 
 	PINMUX_IPSR_GPSR(IP15_19_16,		SSI_SDATA6),
 	PINMUX_IPSR_MSEL(IP15_19_16,		HRTS2_N_A,	SEL_HSCIF2_0),
@@ -4969,7 +4967,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 			     GROUP(1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1,
 				   1, 2, 2, 2, 1, 1, 2, 1, 4),
 			     GROUP(
-		MOD_SEL1_31
+		/* RESERVED 31 */
+		0, 0,
 		MOD_SEL1_30
 		MOD_SEL1_29
 		MOD_SEL1_28
-- 
2.7.4
