From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:56 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 29/41] pinctrl: sh-pfc: rcar-gen3:
	Remove CC5_OSCOUT pin
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-30-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 662dc924a05e9dffd62f602c7111d6b7ada8fa88 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
Jun 4, 2018, the CC5_OSCOUT pin is removed.  Update the pin control
drivers to reflect this.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Update R-Car V3M, V3H]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 3 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 3 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 3 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 3 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    | 3 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    | 3 +--
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 157a8e9..c77db750 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -341,7 +341,7 @@
 #define IP15_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0, 0)	FM(TCLK2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP15_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP15_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP16_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	FM(CC5_OSCOUT)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP16_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0, 0)		F_(0, 0)	FM(TCLK1_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_11_8	FM(USB0_PWEN)		F_(0, 0)	F_(0, 0)		FM(SIM0_RST_C)			F_(0, 0)	FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_15_12	FM(USB0_OVC)		F_(0, 0)	F_(0, 0)		FM(SIM0_D_C)			F_(0, 0)	FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0, 0)	FM(RIF3_SYNC_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -1353,7 +1353,6 @@ static const u16 pinmux_data[] = {
 
 	/* IPSR16 */
 	PINMUX_IPSR_MSEL(IP16_3_0,	AUDIO_CLKA_A,		SEL_ADG_0),
-	PINMUX_IPSR_GPSR(IP16_3_0,	CC5_OSCOUT),
 
 	PINMUX_IPSR_MSEL(IP16_7_4,	AUDIO_CLKB_B,		SEL_ADG_1),
 	PINMUX_IPSR_MSEL(IP16_7_4,	SCIF_CLK_A,		SEL_SCIF1_0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 5e6df51..527ace0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -352,7 +352,7 @@
 #define IP16_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0, 0)	FM(TCLK2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5_A)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	FM(CC5_OSCOUT)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0, 0)		F_(0, 0)	FM(TCLK1_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_11_8	FM(USB0_PWEN)		F_(0, 0)	F_(0, 0)		FM(SIM0_RST_C)			F_(0, 0)	FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HSCK2_C) F_(0, 0) F_(0, 0)
 #define IP17_15_12	FM(USB0_OVC)		F_(0, 0)	F_(0, 0)		FM(SIM0_D_C)			F_(0, 0)	FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0, 0)	FM(RIF3_SYNC_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HRX2_C) F_(0, 0) F_(0, 0)
@@ -1404,7 +1404,6 @@ static const u16 pinmux_data[] = {
 
 	/* IPSR17 */
 	PINMUX_IPSR_MSEL(IP17_3_0,	AUDIO_CLKA_A,		SEL_ADG_A_0),
-	PINMUX_IPSR_GPSR(IP17_3_0,	CC5_OSCOUT),
 
 	PINMUX_IPSR_MSEL(IP17_7_4,	AUDIO_CLKB_B,		SEL_ADG_B_1),
 	PINMUX_IPSR_MSEL(IP17_7_4,	SCIF_CLK_A,		SEL_SCIF_0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index e3da9ba..ba52b5b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -357,7 +357,7 @@
 #define IP16_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0, 0)	FM(TCLK2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5_A)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	FM(CC5_OSCOUT)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0, 0)		F_(0, 0)	FM(TCLK1_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_11_8	FM(USB0_PWEN)		F_(0, 0)	F_(0, 0)		FM(SIM0_RST_C)			F_(0, 0)	FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HSCK2_C) F_(0, 0) F_(0, 0)
 #define IP17_15_12	FM(USB0_OVC)		F_(0, 0)	F_(0, 0)		FM(SIM0_D_C)			F_(0, 0)	FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0, 0)	FM(RIF3_SYNC_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HRX2_C) F_(0, 0) F_(0, 0)
@@ -1415,7 +1415,6 @@ static const u16 pinmux_data[] = {
 
 	/* IPSR17 */
 	PINMUX_IPSR_MSEL(IP17_3_0,	AUDIO_CLKA_A,		SEL_ADG_A_0),
-	PINMUX_IPSR_GPSR(IP17_3_0,	CC5_OSCOUT),
 
 	PINMUX_IPSR_MSEL(IP17_7_4,	AUDIO_CLKB_B,		SEL_ADG_B_1),
 	PINMUX_IPSR_MSEL(IP17_7_4,	SCIF_CLK_A,		SEL_SCIF_0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 6f800de..97361c3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -355,7 +355,7 @@
 #define IP16_23_20	FM(SSI_SDATA7)		FM(HCTS2_N_B)	FM(MSIOF1_RXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SDEN1_A)	FM(STP_ISEN_1_A)	FM(RIF1_D0_A)	FM(RIF3_D0_A)		F_(0, 0)	FM(TCLK2_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_27_24	FM(SSI_SDATA8)		FM(HRTS2_N_B)	FM(MSIOF1_TXD_C)	F_(0, 0)			F_(0, 0)	FM(TS_SPSYNC1_A)FM(STP_ISSYNC_1_A)	FM(RIF1_D1_A)	FM(RIF3_D1_A)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP16_31_28	FM(SSI_SDATA9_A)	FM(HSCK2_B)	FM(MSIOF1_SS1_C)	FM(HSCK1_A)			FM(SSI_WS1_B)	FM(SCK1)	FM(STP_IVCXO27_1_A)	FM(SCK5_A)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	FM(CC5_OSCOUT)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP17_3_0	FM(AUDIO_CLKA_A)	F_(0, 0)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_7_4	FM(AUDIO_CLKB_B)	FM(SCIF_CLK_A)	F_(0, 0)		F_(0, 0)			F_(0, 0)	F_(0, 0)	FM(STP_IVCXO27_1_D)	FM(REMOCON_A)	F_(0, 0)		F_(0, 0)	FM(TCLK1_A)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP17_11_8	FM(USB0_PWEN)		F_(0, 0)	F_(0, 0)		FM(SIM0_RST_C)			F_(0, 0)	FM(TS_SCK1_D)	FM(STP_ISCLK_1_D)	FM(BPFCLK_B)	FM(RIF3_CLK_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HSCK2_C) F_(0, 0) F_(0, 0)
 #define IP17_15_12	FM(USB0_OVC)		F_(0, 0)	F_(0, 0)		FM(SIM0_D_C)			F_(0, 0)	FM(TS_SDAT1_D)	FM(STP_ISD_1_D)		F_(0, 0)	FM(RIF3_SYNC_B)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) FM(HRX2_C) F_(0, 0) F_(0, 0)
@@ -1407,7 +1407,6 @@ static const u16 pinmux_data[] = {
 
 	/* IPSR17 */
 	PINMUX_IPSR_MSEL(IP17_3_0,	AUDIO_CLKA_A,		SEL_ADG_A_0),
-	PINMUX_IPSR_GPSR(IP17_3_0,	CC5_OSCOUT),
 
 	PINMUX_IPSR_MSEL(IP17_7_4,	AUDIO_CLKB_B,		SEL_ADG_B_1),
 	PINMUX_IPSR_MSEL(IP17_7_4,	SCIF_CLK_A,		SEL_SCIF_0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index 5582f41..5785928 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -175,7 +175,7 @@
 #define IP2_15_12	FM(DU_EXHSYNC_DU_HSYNC)		FM(HRX0)		F_(0, 0)	FM(A19)		FM(IRQ3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_19_16	FM(DU_EXVSYNC_DU_VSYNC)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_23_20	FM(DU_EXODDF_DU_ODDF_DISP_CDE)	FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2_27_24	FM(IRQ0)			FM(CC5_OSCOUT)		F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2_27_24	FM(IRQ0)			F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_31_28	FM(VI0_CLK)			FM(MSIOF2_SCK)		FM(SCK3)	F_(0, 0)	FM(HSCK3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_3_0		FM(VI0_CLKENB)			FM(MSIOF2_RXD)		FM(RX3)		FM(RD_WR_N)	FM(HCTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_7_4		FM(VI0_HSYNC_N)			FM(MSIOF2_TXD)		FM(TX3)		F_(0, 0)	FM(HRTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -474,7 +474,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2_23_20,	MSIOF3_SYNC),
 
 	PINMUX_IPSR_GPSR(IP2_27_24,	IRQ0),
-	PINMUX_IPSR_GPSR(IP2_27_24,	CC5_OSCOUT),
 
 	PINMUX_IPSR_GPSR(IP2_31_28,	VI0_CLK),
 	PINMUX_IPSR_GPSR(IP2_31_28,	MSIOF2_SCK),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 04d51b1..27c4392 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -205,7 +205,7 @@
 #define IP2_15_12	FM(DU_EXHSYNC_DU_HSYNC)		FM(MSIOF3_SS2)		FM(GETHER_PHY_INT_B)	FM(A19)		FM(FXR_TXENA_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_19_16	FM(DU_EXVSYNC_DU_VSYNC)		FM(MSIOF3_SCK)		F_(0, 0)		F_(0, 0)	FM(FXR_TXENB_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_23_20	FM(DU_EXODDF_DU_ODDF_DISP_CDE)	FM(MSIOF3_SYNC)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2_27_24	FM(IRQ0)			FM(CC5_OSCOUT)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2_27_24	FM(IRQ0)			F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2_31_28	FM(VI0_CLK)			FM(MSIOF2_SCK)		FM(SCK3)		F_(0, 0)	FM(HSCK3)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_3_0		FM(VI0_CLKENB)			FM(MSIOF2_RXD)		FM(RX3)			FM(RD_WR_N)	FM(HCTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3_7_4		FM(VI0_HSYNC_N)			FM(MSIOF2_TXD)		FM(TX3)			F_(0, 0)	FM(HRTS3_N)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -555,7 +555,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2_23_20,	MSIOF3_SYNC),
 
 	PINMUX_IPSR_GPSR(IP2_27_24,	IRQ0),
-	PINMUX_IPSR_GPSR(IP2_27_24,	CC5_OSCOUT),
 
 	PINMUX_IPSR_GPSR(IP2_31_28,	VI0_CLK),
 	PINMUX_IPSR_GPSR(IP2_31_28,	MSIOF2_SCK),
-- 
2.7.4
