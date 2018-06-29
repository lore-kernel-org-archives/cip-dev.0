From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:30 +0100
Subject: [cip-dev] [PATCH 29/86] pinctrl: sh-pfc: r8a7794: Add DU pin groups
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-30-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

r8a7794 PFC DU support from the R-Car Gen2 v1.9.4 BSP

[Magnus: added the description, added missing dot clock output signals,
separated CDE and DISP signals, broke out the ODDF signal from the sync
group.]

[Sergei: resolved rejects, folded in Magnus' patches, killed empty lines,
reordered pin/mux arrays and pin groups, fixed up some comments to the pin
arrays, removed the "du" function splitting its groups between the "du0"
and "du1" functions.]

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 56ed4bb984acbba9cfe080e45ac4b50ca63dd188)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 217 +++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 4524fb8..a47843e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -1701,6 +1701,179 @@ static const unsigned int avb_avtp_match_b_pins[] = {
 static const unsigned int avb_avtp_match_b_mux[] = {
 	AVB_AVTP_MATCH_B_MARK,
 };
+/* - DU --------------------------------------------------------------------- */
+static const unsigned int du0_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+};
+static const unsigned int du0_rgb666_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK,
+};
+static const unsigned int du0_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(2, 7),  RCAR_GP_PIN(2, 6),  RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 4),  RCAR_GP_PIN(2, 3),  RCAR_GP_PIN(2, 2),
+	RCAR_GP_PIN(2, 1),  RCAR_GP_PIN(2, 0),
+	RCAR_GP_PIN(2, 15), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+	RCAR_GP_PIN(2, 12), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 10),
+	RCAR_GP_PIN(2, 9),  RCAR_GP_PIN(2, 8),
+	RCAR_GP_PIN(2, 23), RCAR_GP_PIN(2, 22), RCAR_GP_PIN(2, 21),
+	RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 19), RCAR_GP_PIN(2, 18),
+	RCAR_GP_PIN(2, 17), RCAR_GP_PIN(2, 16),
+};
+static const unsigned int du0_rgb888_mux[] = {
+	DU0_DR7_MARK, DU0_DR6_MARK, DU0_DR5_MARK, DU0_DR4_MARK,
+	DU0_DR3_MARK, DU0_DR2_MARK, DU0_DR1_MARK, DU0_DR0_MARK,
+	DU0_DG7_MARK, DU0_DG6_MARK, DU0_DG5_MARK, DU0_DG4_MARK,
+	DU0_DG3_MARK, DU0_DG2_MARK, DU0_DG1_MARK, DU0_DG0_MARK,
+	DU0_DB7_MARK, DU0_DB6_MARK, DU0_DB5_MARK, DU0_DB4_MARK,
+	DU0_DB3_MARK, DU0_DB2_MARK, DU0_DB1_MARK, DU0_DB0_MARK,
+};
+static const unsigned int du0_clk0_out_pins[] = {
+	/* DOTCLKOUT0 */
+	RCAR_GP_PIN(2, 25),
+};
+static const unsigned int du0_clk0_out_mux[] = {
+	DU0_DOTCLKOUT0_MARK
+};
+static const unsigned int du0_clk1_out_pins[] = {
+	/* DOTCLKOUT1 */
+	RCAR_GP_PIN(2, 26),
+};
+static const unsigned int du0_clk1_out_mux[] = {
+	DU0_DOTCLKOUT1_MARK
+};
+static const unsigned int du0_clk_in_pins[] = {
+	/* CLKIN */
+	RCAR_GP_PIN(2, 24),
+};
+static const unsigned int du0_clk_in_mux[] = {
+	DU0_DOTCLKIN_MARK
+};
+static const unsigned int du0_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(2, 28), RCAR_GP_PIN(2, 27),
+};
+static const unsigned int du0_sync_mux[] = {
+	DU0_EXVSYNC_DU0_VSYNC_MARK, DU0_EXHSYNC_DU0_HSYNC_MARK
+};
+static const unsigned int du0_oddf_pins[] = {
+	/* EXODDF/ODDF/DISP/CDE */
+	RCAR_GP_PIN(2, 29),
+};
+static const unsigned int du0_oddf_mux[] = {
+	DU0_EXODDF_DU0_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du0_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(2, 31),
+};
+static const unsigned int du0_cde_mux[] = {
+	DU0_CDE_MARK,
+};
+static const unsigned int du0_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(2, 30),
+};
+static const unsigned int du0_disp_mux[] = {
+	DU0_DISP_MARK
+};
+static const unsigned int du1_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(4, 7),  RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 4),  RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+	RCAR_GP_PIN(4, 12), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 18),
+};
+static const unsigned int du1_rgb666_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK,
+};
+static const unsigned int du1_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(4, 7),  RCAR_GP_PIN(4, 6),  RCAR_GP_PIN(4, 5),
+	RCAR_GP_PIN(4, 4),  RCAR_GP_PIN(4, 3),  RCAR_GP_PIN(4, 2),
+	RCAR_GP_PIN(4, 1),  RCAR_GP_PIN(4, 0),
+	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 13),
+	RCAR_GP_PIN(4, 12), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 10),
+	RCAR_GP_PIN(4, 9),  RCAR_GP_PIN(4, 8),
+	RCAR_GP_PIN(4, 23), RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 21),
+	RCAR_GP_PIN(4, 20), RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 18),
+	RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 16),
+};
+static const unsigned int du1_rgb888_mux[] = {
+	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
+	DU1_DR3_MARK, DU1_DR2_MARK, DU1_DR1_MARK, DU1_DR0_MARK,
+	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
+	DU1_DG3_MARK, DU1_DG2_MARK, DU1_DG1_MARK, DU1_DG0_MARK,
+	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
+	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
+};
+static const unsigned int du1_clk0_out_pins[] = {
+	/* DOTCLKOUT0 */
+	RCAR_GP_PIN(4, 25),
+};
+static const unsigned int du1_clk0_out_mux[] = {
+	DU1_DOTCLKOUT0_MARK
+};
+static const unsigned int du1_clk1_out_pins[] = {
+	/* DOTCLKOUT1 */
+	RCAR_GP_PIN(4, 26),
+};
+static const unsigned int du1_clk1_out_mux[] = {
+	DU1_DOTCLKOUT1_MARK
+};
+static const unsigned int du1_clk_in_pins[] = {
+	/* DOTCLKIN */
+	RCAR_GP_PIN(4, 24),
+};
+static const unsigned int du1_clk_in_mux[] = {
+	DU1_DOTCLKIN_MARK
+};
+static const unsigned int du1_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(4, 28), RCAR_GP_PIN(4, 27),
+};
+static const unsigned int du1_sync_mux[] = {
+	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
+};
+static const unsigned int du1_oddf_pins[] = {
+	/* EXODDF/ODDF/DISP/CDE */
+	RCAR_GP_PIN(4, 29),
+};
+static const unsigned int du1_oddf_mux[] = {
+	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
+};
+static const unsigned int du1_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(4, 31),
+};
+static const unsigned int du1_cde_mux[] = {
+	DU1_CDE_MARK
+};
+static const unsigned int du1_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(4, 30),
+};
+static const unsigned int du1_disp_mux[] = {
+	DU1_DISP_MARK
+};
 /* - ETH -------------------------------------------------------------------- */
 static const unsigned int eth_link_pins[] = {
 	/* LINK */
@@ -3383,6 +3556,24 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_avtp_match),
 	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
 	SH_PFC_PIN_GROUP(avb_avtp_match_b),
+	SH_PFC_PIN_GROUP(du0_rgb666),
+	SH_PFC_PIN_GROUP(du0_rgb888),
+	SH_PFC_PIN_GROUP(du0_clk0_out),
+	SH_PFC_PIN_GROUP(du0_clk1_out),
+	SH_PFC_PIN_GROUP(du0_clk_in),
+	SH_PFC_PIN_GROUP(du0_sync),
+	SH_PFC_PIN_GROUP(du0_oddf),
+	SH_PFC_PIN_GROUP(du0_cde),
+	SH_PFC_PIN_GROUP(du0_disp),
+	SH_PFC_PIN_GROUP(du1_rgb666),
+	SH_PFC_PIN_GROUP(du1_rgb888),
+	SH_PFC_PIN_GROUP(du1_clk0_out),
+	SH_PFC_PIN_GROUP(du1_clk1_out),
+	SH_PFC_PIN_GROUP(du1_clk_in),
+	SH_PFC_PIN_GROUP(du1_sync),
+	SH_PFC_PIN_GROUP(du1_oddf),
+	SH_PFC_PIN_GROUP(du1_cde),
+	SH_PFC_PIN_GROUP(du1_disp),
 	SH_PFC_PIN_GROUP(eth_link),
 	SH_PFC_PIN_GROUP(eth_magic),
 	SH_PFC_PIN_GROUP(eth_mdio),
@@ -3641,6 +3832,30 @@ static const char * const avb_groups[] = {
 	"avb_avtp_match_b",
 };
 
+static const char * const du0_groups[] = {
+	"du0_rgb666",
+	"du0_rgb888",
+	"du0_clk0_out",
+	"du0_clk1_out",
+	"du0_clk_in",
+	"du0_sync",
+	"du0_oddf",
+	"du0_cde",
+	"du0_disp",
+};
+
+static const char * const du1_groups[] = {
+	"du1_rgb666",
+	"du1_rgb888",
+	"du1_clk0_out",
+	"du1_clk1_out",
+	"du1_clk_in",
+	"du1_sync",
+	"du1_oddf",
+	"du1_cde",
+	"du1_disp",
+};
+
 static const char * const eth_groups[] = {
 	"eth_link",
 	"eth_magic",
@@ -3988,6 +4203,8 @@ static const char * const vin1_groups[] = {
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
+	SH_PFC_FUNCTION(du0),
+	SH_PFC_FUNCTION(du1),
 	SH_PFC_FUNCTION(eth),
 	SH_PFC_FUNCTION(hscif0),
 	SH_PFC_FUNCTION(hscif1),
-- 
2.7.4
