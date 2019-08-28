From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:47 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 20/41] pinctrl: sh-pfc: r8a7796:
	Fix VIN versioned groups
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit 10e78f03da181b24f33a8a77047fb6798126fb46 upstream.

Versioned VIN groups can appear on different sets of pins. Using the
VIN_DATA_PIN_GROUP macro now supports proper naming of said groups
through an optional 'version' argument.

Use the 'version' argument for said macro to fix naming of versioned
groups for the R-Car M3-W R8A7796 SoC.

Fixes: a5c2949ff7bd ("pinctrl: sh-pfc: r8a7796: Deduplicate VIN4 pin definitions")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 70b05f2..1577620 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -4410,20 +4410,20 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb1),
 		SH_PFC_PIN_GROUP(usb30),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 8),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 10),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 12),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 16),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _a),
 		SH_PFC_PIN_GROUP(vin4_data18_a),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 20),
-		VIN_DATA_PIN_GROUP(vin4_data_a, 24),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 8),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 10),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 12),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 16),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _b),
 		SH_PFC_PIN_GROUP(vin4_data18_b),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 20),
-		VIN_DATA_PIN_GROUP(vin4_data_b, 24),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _b),
 		SH_PFC_PIN_GROUP(vin4_sync),
 		SH_PFC_PIN_GROUP(vin4_field),
 		SH_PFC_PIN_GROUP(vin4_clkenb),
-- 
2.7.4
