From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:31 +0100
Subject: [cip-dev] [PATCH 30/86] pinctrl: sh-pfc: r8a7794: Swap ATA signals
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-31-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

All R8A7794 manuals I have here (0.50 and 1.10) agree that the PFC driver
has ATAG0# and ATAWR0# signals in IPSR12 swapped -- fix this.

Fixes: 43c4436e2f18 ("pinctrl: sh-pfc: add R8A7794 PFC support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 5f4c8cafe1148f8a91287072815df8f0b66f0e5c)
(replaced PINMUX_IPSR_GPSR with PINMUX_IPSR_DATA)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index a47843e..21d8b02 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -298,8 +298,8 @@ enum {
 	FN_AVB_AVTP_CAPTURE, FN_ETH_CRS_DV_B, FN_SSI_WS1, FN_SCIF1_TXD_B,
 	FN_IIC1_SDA_C, FN_VI1_DATA0, FN_CAN0_TX_D, FN_AVB_AVTP_MATCH,
 	FN_ETH_RX_ER_B, FN_SSI_SDATA1, FN_HSCIF1_HRX_B, FN_SDATA, FN_VI1_DATA1,
-	FN_ATAG0_N, FN_ETH_RXD0_B, FN_SSI_SCK2, FN_HSCIF1_HTX_B, FN_VI1_DATA2,
-	FN_MDATA, FN_ATAWR0_N, FN_ETH_RXD1_B,
+	FN_ATAWR0_N, FN_ETH_RXD0_B, FN_SSI_SCK2, FN_HSCIF1_HTX_B, FN_VI1_DATA2,
+	FN_MDATA, FN_ATAG0_N, FN_ETH_RXD1_B,
 
 	/* IPSR13 */
 	FN_SSI_WS2, FN_HSCIF1_HCTS_N_B, FN_SCIFA0_RXD_D, FN_VI1_DATA3, FN_SCKZ,
@@ -592,8 +592,8 @@ enum {
 	ETH_CRS_DV_B_MARK, SSI_WS1_MARK, SCIF1_TXD_B_MARK, IIC1_SDA_C_MARK,
 	VI1_DATA0_MARK, CAN0_TX_D_MARK, AVB_AVTP_MATCH_MARK, ETH_RX_ER_B_MARK,
 	SSI_SDATA1_MARK, HSCIF1_HRX_B_MARK, VI1_DATA1_MARK, SDATA_MARK,
-	ATAG0_N_MARK, ETH_RXD0_B_MARK, SSI_SCK2_MARK, HSCIF1_HTX_B_MARK,
-	VI1_DATA2_MARK, MDATA_MARK, ATAWR0_N_MARK, ETH_RXD1_B_MARK,
+	ATAWR0_N_MARK, ETH_RXD0_B_MARK, SSI_SCK2_MARK, HSCIF1_HTX_B_MARK,
+	VI1_DATA2_MARK, MDATA_MARK, ATAG0_N_MARK, ETH_RXD1_B_MARK,
 
 	/* IPSR13 */
 	SSI_WS2_MARK, HSCIF1_HCTS_N_B_MARK, SCIFA0_RXD_D_MARK, VI1_DATA3_MARK,
@@ -1430,13 +1430,13 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP12_26_24, HSCIF1_HRX_B, SEL_HSCIF1_1),
 	PINMUX_IPSR_DATA(IP12_26_24, VI1_DATA1),
 	PINMUX_IPSR_MSEL(IP12_26_24, SDATA, SEL_FSN_0),
-	PINMUX_IPSR_DATA(IP12_26_24, ATAG0_N),
+	PINMUX_IPSR_DATA(IP12_26_24, ATAWR0_N),
 	PINMUX_IPSR_MSEL(IP12_26_24, ETH_RXD0_B, SEL_ETH_1),
 	PINMUX_IPSR_MSEL(IP12_29_27, SSI_SCK2, SEL_SSI2_0),
 	PINMUX_IPSR_MSEL(IP12_29_27, HSCIF1_HTX_B, SEL_HSCIF1_1),
 	PINMUX_IPSR_DATA(IP12_29_27, VI1_DATA2),
 	PINMUX_IPSR_MSEL(IP12_29_27, MDATA, SEL_FSN_0),
-	PINMUX_IPSR_DATA(IP12_29_27, ATAWR0_N),
+	PINMUX_IPSR_DATA(IP12_29_27, ATAG0_N),
 	PINMUX_IPSR_MSEL(IP12_29_27, ETH_RXD1_B, SEL_ETH_1),
 
 	/* IPSR13 */
@@ -4955,10 +4955,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0,
 		/* IP12_29_27 [3] */
 		FN_SSI_SCK2, FN_HSCIF1_HTX_B, FN_VI1_DATA2, FN_MDATA,
-		FN_ATAWR0_N, FN_ETH_RXD1_B, 0, 0,
+		FN_ATAG0_N, FN_ETH_RXD1_B, 0, 0,
 		/* IP12_26_24 [3] */
 		FN_SSI_SDATA1, FN_HSCIF1_HRX_B, FN_VI1_DATA1, FN_SDATA,
-		FN_ATAG0_N, FN_ETH_RXD0_B, 0, 0,
+		FN_ATAWR0_N, FN_ETH_RXD0_B, 0, 0,
 		/* IP12_23_21 [3] */
 		FN_SSI_WS1, FN_SCIF1_TXD_B, FN_IIC1_SDA_C, FN_VI1_DATA0,
 		FN_CAN0_TX_D, FN_AVB_AVTP_MATCH, FN_ETH_RX_ER_B, 0,
-- 
2.7.4
