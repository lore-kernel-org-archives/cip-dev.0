From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:15:02 +0100
Subject: [cip-dev] [PATCH 09/11] pinctrl: sh-pfc: r8a7791: Fix IPSR comment
	typos
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The IPSR field names in the comments have been fat-fingered in a couple
places --  fix those silly typos...

Fixes: 508845196238 ("pinctrl: sh-pfc: r8a7791 PFC support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 0cbdc11482d72ad164e33ef7cc57b01e8b61e40d)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 8232305..69a8541 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5715,7 +5715,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR2", 0xE6060028, 32,
 			     2, 3, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 3) {
-		/* IP2_31_20 [2] */
+		/* IP2_31_30 [2] */
 		0, 0, 0, 0,
 		/* IP2_29_27 [3] */
 		FN_EX_CS3_N, FN_ATADIR0_N, FN_MSIOF2_TXD,
@@ -5735,7 +5735,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP2_15_13 [3] */
 		FN_A24, FN_DREQ2, FN_IO3, FN_TX1, FN_SCIFA1_TXD,
 		0, 0, 0,
-		/* IP2_12_0 [3] */
+		/* IP2_12_10 [3] */
 		FN_A23, FN_IO2, FN_BPFCLK_B, FN_RX0, FN_SCIFA0_RXD,
 		0, 0, 0,
 		/* IP2_9_7 [3] */
@@ -6046,7 +6046,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP10_24_22 [3] */
 		FN_VI0_R1, FN_VI2_DATA2, FN_GLO_I1_B, FN_TS_SCK0_C, FN_ATAG1_N,
 		0, 0, 0,
-		/* IP10_21_29 [3] */
+		/* IP10_21_19 [3] */
 		FN_VI0_R0, FN_VI2_DATA1, FN_GLO_I0_B,
 		FN_TS_SDATA0_C, FN_ATACS11_N,
 		0, 0, 0,
-- 
1.9.1
