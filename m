From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:43 +0100
Subject: [cip-dev] [PATCH 4.19y 06/10] pinctrl: sh-pfc: r8a77990: Fix
	MOD_SEL0 bit2 when using RX2, TX2 and SCK2
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 7219a4b645208734d45b1d30a4c35b6f09a0e9e6 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
Aug 24, 2018, the MOD_SEL0 bit2 is set when RX2_{A,B}, TX2_{A,B} and
SCK2_A pin functions are selected.

Fixes: 6d4036a1e3b3ac0f ("pinctrl: sh-pfc: Initial R8A77990 PFC support")
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 1bc9b71..2492479 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1099,7 +1099,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP12_3_0,		SSI_WS9_B,	SEL_SSI9_1),
 	PINMUX_IPSR_GPSR(IP12_3_0,		AUDIO_CLKOUT3_B),
 
-	PINMUX_IPSR_GPSR(IP12_7_4,		SCK2_A),
+	PINMUX_IPSR_MSEL(IP12_7_4,		SCK2_A,		SEL_SCIF2_0),
 	PINMUX_IPSR_MSEL(IP12_7_4,		HSCK0_A,	SEL_HSCIF0_0),
 	PINMUX_IPSR_MSEL(IP12_7_4,		AUDIO_CLKB_A,	SEL_ADGB_0),
 	PINMUX_IPSR_GPSR(IP12_7_4,		CTS1_N),
@@ -1107,14 +1107,14 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP12_7_4,		REMOCON_A,	SEL_REMOCON_0),
 	PINMUX_IPSR_MSEL(IP12_7_4,		SCIF_CLK_B,	SEL_SCIF_1),
 
-	PINMUX_IPSR_GPSR(IP12_11_8,		TX2_A),
+	PINMUX_IPSR_MSEL(IP12_11_8,		TX2_A,		SEL_SCIF2_0),
 	PINMUX_IPSR_MSEL(IP12_11_8,		HRX0_A,		SEL_HSCIF0_0),
 	PINMUX_IPSR_GPSR(IP12_11_8,		AUDIO_CLKOUT2_A),
 	PINMUX_IPSR_MSEL(IP12_11_8,		SCL1_A,		SEL_I2C1_0),
 	PINMUX_IPSR_MSEL(IP12_11_8,		FSO_CFE_0_N_A,	SEL_FSO_0),
 	PINMUX_IPSR_GPSR(IP12_11_8,		TS_SDEN1),
 
-	PINMUX_IPSR_GPSR(IP12_15_12,		RX2_A),
+	PINMUX_IPSR_MSEL(IP12_15_12,		RX2_A,		SEL_SCIF2_0),
 	PINMUX_IPSR_GPSR(IP12_15_12,		HTX0_A),
 	PINMUX_IPSR_GPSR(IP12_15_12,		AUDIO_CLKOUT3_A),
 	PINMUX_IPSR_MSEL(IP12_15_12,		SDA1_A,		SEL_I2C1_0),
@@ -1126,11 +1126,11 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP12_23_20,		MSIOF0_RXD),
 	PINMUX_IPSR_GPSR(IP12_23_20,		SSI_WS78),
-	PINMUX_IPSR_GPSR(IP12_23_20,		TX2_B),
+	PINMUX_IPSR_MSEL(IP12_23_20,		TX2_B,		SEL_SCIF2_1),
 
 	PINMUX_IPSR_GPSR(IP12_27_24,		MSIOF0_TXD),
 	PINMUX_IPSR_GPSR(IP12_27_24,		SSI_SDATA7),
-	PINMUX_IPSR_GPSR(IP12_27_24,		RX2_B),
+	PINMUX_IPSR_MSEL(IP12_27_24,		RX2_B,		SEL_SCIF2_1),
 
 	PINMUX_IPSR_GPSR(IP12_31_28,		MSIOF0_SYNC),
 	PINMUX_IPSR_GPSR(IP12_31_28,		AUDIO_CLKOUT_B),
-- 
2.7.4
