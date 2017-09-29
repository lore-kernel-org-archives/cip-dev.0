From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:12 +0100
Subject: [cip-dev] [PATCH 10/15] pinctrl: sh-pfc: r8a7791: Add missing
	mmc_data8_b pin group
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-11-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Pins D6 and D7 of the MMC interface can be muxed to two different sets
of pins, but currently only one set is supported.
Add a pin group for the alternative set to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Tested-by: Chris Paterson <chris.paterson2@renesas.com>
(cherry picked from commit 2bf147a836918b14aae7aba2e598fa18a73e4f19)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 33d1357..351842e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2593,6 +2593,17 @@ static const unsigned int mmc_data8_mux[] = {
 	MMC_D0_MARK, MMC_D1_MARK, MMC_D2_MARK, MMC_D3_MARK,
 	MMC_D4_MARK, MMC_D5_MARK, MMC_D6_MARK, MMC_D7_MARK,
 };
+static const unsigned int mmc_data8_b_pins[] = {
+	/* D[0:7] */
+	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 19),
+	RCAR_GP_PIN(6, 20), RCAR_GP_PIN(6, 21),
+	RCAR_GP_PIN(6, 22), RCAR_GP_PIN(6, 23),
+	RCAR_GP_PIN(6, 6), RCAR_GP_PIN(6, 7),
+};
+static const unsigned int mmc_data8_b_mux[] = {
+	MMC_D0_MARK, MMC_D1_MARK, MMC_D2_MARK, MMC_D3_MARK,
+	MMC_D4_MARK, MMC_D5_MARK, MMC_D6_B_MARK, MMC_D7_B_MARK,
+};
 static const unsigned int mmc_ctrl_pins[] = {
 	/* CLK, CMD */
 	RCAR_GP_PIN(6, 16), RCAR_GP_PIN(6, 17),
@@ -4424,7 +4435,7 @@ static const unsigned int vin2_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[341];
+	struct sh_pfc_pin_group common[342];
 	struct sh_pfc_pin_group r8a779x[9];
 } pinmux_groups = {
 	.common = {
@@ -4527,6 +4538,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(mmc_data1),
 		SH_PFC_PIN_GROUP(mmc_data4),
 		SH_PFC_PIN_GROUP(mmc_data8),
+		SH_PFC_PIN_GROUP(mmc_data8_b),
 		SH_PFC_PIN_GROUP(mmc_ctrl),
 		SH_PFC_PIN_GROUP(msiof0_clk),
 		SH_PFC_PIN_GROUP(msiof0_sync),
@@ -4959,6 +4971,7 @@ static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
 	"mmc_data8",
+	"mmc_data8_b",
 	"mmc_ctrl",
 };
 
-- 
1.9.1
