From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:50 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 23/41] pinctrl: sh-pfc: r8a7796:
	Move CANFD pin groups and functions
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit dcd24e098d8df8b4f85686c6be7673d4506c1888 upstream.

CANFD is found also on the R8A774A1, therefore move CANFD pin
groups and functions to "common".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index c734443..3a178d89 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -4125,8 +4125,8 @@ static const unsigned int vin5_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[310];
-	struct sh_pfc_pin_group automotive[33];
+	struct sh_pfc_pin_group common[313];
+	struct sh_pfc_pin_group automotive[30];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
@@ -4161,6 +4161,9 @@ static const struct {
 		SH_PFC_PIN_GROUP(can0_data_b),
 		SH_PFC_PIN_GROUP(can1_data),
 		SH_PFC_PIN_GROUP(can_clk),
+		SH_PFC_PIN_GROUP(canfd0_data_a),
+		SH_PFC_PIN_GROUP(canfd0_data_b),
+		SH_PFC_PIN_GROUP(canfd1_data),
 		SH_PFC_PIN_GROUP(du_rgb666),
 		SH_PFC_PIN_GROUP(du_rgb888),
 		SH_PFC_PIN_GROUP(du_clk_out_0),
@@ -4441,9 +4444,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clk),
 	},
 	.automotive = {
-		SH_PFC_PIN_GROUP(canfd0_data_a),
-		SH_PFC_PIN_GROUP(canfd0_data_b),
-		SH_PFC_PIN_GROUP(canfd1_data),
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
 		SH_PFC_PIN_GROUP(drif0_data1_a),
@@ -4983,8 +4983,8 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[48];
-	struct sh_pfc_function automotive[6];
+	struct sh_pfc_function common[50];
+	struct sh_pfc_function automotive[4];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -4992,6 +4992,8 @@ static const struct {
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
 		SH_PFC_FUNCTION(can_clk),
+		SH_PFC_FUNCTION(canfd0),
+		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(hdmi0),
 		SH_PFC_FUNCTION(hscif0),
@@ -5037,8 +5039,6 @@ static const struct {
 		SH_PFC_FUNCTION(vin5),
 	},
 	.automotive = {
-		SH_PFC_FUNCTION(canfd0),
-		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(drif0),
 		SH_PFC_FUNCTION(drif1),
 		SH_PFC_FUNCTION(drif2),
-- 
2.7.4
