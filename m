From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:37 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 27/39] pinctrl: sh-pfc: r8a77965:
	Replace DU_DOTCLKIN2 by DU_DOTCLKIN3
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-28-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 86c045c2e4201e94ef37458e5777fcb2dab33a11 upstream.

Unlike R-Car M3-W, R-Car M3-N does not have DU_DOTCLKIN2, but the
corresponding pin carries the DU_DOTCLKIN3 signal.  Correct all
references to DU_DOTCLKIN2 to fix this.

This change does not have any runtime effect, as it only changes an
internal enum name, and a comment.

Fixes: 490e687eb8b274b5 ("pinctrl: sh-pfc: Initial R-Car M3-N support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index ea3d026..61b33f7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -553,7 +553,7 @@ MOD_SEL0_4_3		MOD_SEL1_4 \
 	FM(AVB_RX_CTL) FM(AVB_RXC) FM(AVB_RD0) FM(AVB_RD1) FM(AVB_RD2) FM(AVB_RD3) \
 	FM(AVB_TXCREFCLK) FM(AVB_MDIO) \
 	FM(PRESETOUT) \
-	FM(DU_DOTCLKIN0) FM(DU_DOTCLKIN1) FM(DU_DOTCLKIN2) \
+	FM(DU_DOTCLKIN0) FM(DU_DOTCLKIN1) FM(DU_DOTCLKIN3) \
 	FM(TMS) FM(TDO) FM(ASEBRK) FM(MLB_REF) FM(TDI) FM(TCK) FM(TRST) FM(EXTALR)
 
 enum {
@@ -1563,7 +1563,7 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('E'),  5, QSPI1_MISO_IO1, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  7, DU_DOTCLKIN0, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('P'),  8, DU_DOTCLKIN1, CFG_FLAGS),
-	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN2, CFG_FLAGS),
+	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'),  8, DU_DOTCLKIN3, CFG_FLAGS),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 26, TRST#, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 29, TDI, SH_PFC_PIN_CFG_PULL_UP_DOWN),
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('R'), 30, TMS, CFG_FLAGS),
@@ -5740,7 +5740,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
-		[ 0] = PIN_A_NUMBER('R', 8),	/* DU_DOTCLKIN2 */
+		[ 0] = PIN_A_NUMBER('R', 8),	/* DU_DOTCLKIN3 */
 		[ 1] = SH_PFC_PIN_NONE,
 		[ 2] = PIN_A_NUMBER('D', 38),	/* FSCLKST */
 		[ 3] = PIN_A_NUMBER('D', 39),	/* EXTALR*/
-- 
2.7.4
