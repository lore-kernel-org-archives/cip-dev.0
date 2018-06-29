From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:33 +0100
Subject: [cip-dev] [PATCH 32/86] pinctrl: sh-pfc: r8a7794: Remove AVB_AVTP_*
	groups
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-33-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The ATA_AVTP_* signals are documented as reserved in the recent R-Car E2
user's manual (the only remaining mention is in the table 5.2 and I believe
it's a simple overlook).  Remove the AVB_AVTP_* pinmux groups -- we will
remove the signals themselves in the next patch, along with the other now
reserved bits...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit d24709f5d69a0a5e5caae16f53db84bf5211d75e)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 77f4908..f0c0db8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1677,30 +1677,6 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
 	AVB_COL_MARK,
 };
-static const unsigned int avb_avtp_capture_pins[] = {
-	RCAR_GP_PIN(5, 11),
-};
-static const unsigned int avb_avtp_capture_mux[] = {
-	AVB_AVTP_CAPTURE_MARK,
-};
-static const unsigned int avb_avtp_match_pins[] = {
-	RCAR_GP_PIN(5, 12),
-};
-static const unsigned int avb_avtp_match_mux[] = {
-	AVB_AVTP_MATCH_MARK,
-};
-static const unsigned int avb_avtp_capture_b_pins[] = {
-	RCAR_GP_PIN(1, 1),
-};
-static const unsigned int avb_avtp_capture_b_mux[] = {
-	AVB_AVTP_CAPTURE_B_MARK,
-};
-static const unsigned int avb_avtp_match_b_pins[] = {
-	RCAR_GP_PIN(1, 2),
-};
-static const unsigned int avb_avtp_match_b_mux[] = {
-	AVB_AVTP_MATCH_B_MARK,
-};
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du0_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3552,10 +3528,6 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_mdio),
 	SH_PFC_PIN_GROUP(avb_mii),
 	SH_PFC_PIN_GROUP(avb_gmii),
-	SH_PFC_PIN_GROUP(avb_avtp_capture),
-	SH_PFC_PIN_GROUP(avb_avtp_match),
-	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
-	SH_PFC_PIN_GROUP(avb_avtp_match_b),
 	SH_PFC_PIN_GROUP(du0_rgb666),
 	SH_PFC_PIN_GROUP(du0_rgb888),
 	SH_PFC_PIN_GROUP(du0_clk0_out),
@@ -3826,10 +3798,6 @@ static const char * const avb_groups[] = {
 	"avb_mdio",
 	"avb_mii",
 	"avb_gmii",
-	"avb_avtp_capture",
-	"avb_avtp_match",
-	"avb_avtp_capture_b",
-	"avb_avtp_match_b",
 };
 
 static const char * const du0_groups[] = {
-- 
2.7.4
