From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:27 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 22/51] pinctrl: sh-pfc: r8a7796:
	Deduplicate VIN5 pin definitions
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 08b7e2112a9b19ccc583617cd81714d0e98b7e79 upstream.

Use union vin_data16 and VIN_DATA_PIN_GROUP() to reduce redundancies in
pin definitions for the VIN5 channel.

This reduces kernel size by 240 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 90 +++++++++++-------------------------
 1 file changed, 26 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 5ab1b60..c734443 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -4071,67 +4071,29 @@ static const unsigned int vin4_clk_mux[] = {
 };
 
 /* - VIN5 ------------------------------------------------------------------- */
-static const unsigned int vin5_data8_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-};
-static const unsigned int vin5_data8_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-};
-static const unsigned int vin5_data10_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-};
-static const unsigned int vin5_data10_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-};
-static const unsigned int vin5_data12_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
-};
-static const unsigned int vin5_data12_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-	VI5_DATA10_MARK, VI5_DATA11_MARK,
-};
-static const unsigned int vin5_data16_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
-	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
-	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+static const union vin_data16 vin5_data_pins = {
+	.data16 = {
+		RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+		RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+		RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
+		RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+		RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	},
 };
-static const unsigned int vin5_data16_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-	VI5_DATA10_MARK, VI5_DATA11_MARK,
-	VI5_DATA12_MARK, VI5_DATA13_MARK,
-	VI5_DATA14_MARK, VI5_DATA15_MARK,
+static const union vin_data16 vin5_data_mux = {
+	.data16 = {
+		VI5_DATA0_MARK, VI5_DATA1_MARK,
+		VI5_DATA2_MARK, VI5_DATA3_MARK,
+		VI5_DATA4_MARK, VI5_DATA5_MARK,
+		VI5_DATA6_MARK, VI5_DATA7_MARK,
+		VI5_DATA8_MARK,  VI5_DATA9_MARK,
+		VI5_DATA10_MARK, VI5_DATA11_MARK,
+		VI5_DATA12_MARK, VI5_DATA13_MARK,
+		VI5_DATA14_MARK, VI5_DATA15_MARK,
+	},
 };
 static const unsigned int vin5_sync_pins[] = {
 	/* HSYNC#, VSYNC# */
@@ -4469,10 +4431,10 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin4_field),
 		SH_PFC_PIN_GROUP(vin4_clkenb),
 		SH_PFC_PIN_GROUP(vin4_clk),
-		SH_PFC_PIN_GROUP(vin5_data8),
-		SH_PFC_PIN_GROUP(vin5_data10),
-		SH_PFC_PIN_GROUP(vin5_data12),
-		SH_PFC_PIN_GROUP(vin5_data16),
+		VIN_DATA_PIN_GROUP(vin5_data, 8),
+		VIN_DATA_PIN_GROUP(vin5_data, 10),
+		VIN_DATA_PIN_GROUP(vin5_data, 12),
+		VIN_DATA_PIN_GROUP(vin5_data, 16),
 		SH_PFC_PIN_GROUP(vin5_sync),
 		SH_PFC_PIN_GROUP(vin5_field),
 		SH_PFC_PIN_GROUP(vin5_clkenb),
-- 
2.7.4
