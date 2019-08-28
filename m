From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:52 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 25/41] pinctrl: sh-pfc: r8a77990:
	Move CANFD pin groups and functions
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-26-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 2cee6cb290ab30f2f3a69866d24ca6cb64b1d7e8 upstream.

CANFD is found also on the R8A774C0, therefore move CANFD pin
groups and functions to "common".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index b8c49f0..9ade895 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -3765,8 +3765,8 @@ static const unsigned int vin5_clk_b_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[245];
-	struct sh_pfc_pin_group automotive[23];
+	struct sh_pfc_pin_group common[247];
+	struct sh_pfc_pin_group automotive[21];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a),
@@ -3797,6 +3797,8 @@ static const struct {
 		SH_PFC_PIN_GROUP(can0_data),
 		SH_PFC_PIN_GROUP(can1_data),
 		SH_PFC_PIN_GROUP(can_clk),
+		SH_PFC_PIN_GROUP(canfd0_data),
+		SH_PFC_PIN_GROUP(canfd1_data),
 		SH_PFC_PIN_GROUP(du_rgb666),
 		SH_PFC_PIN_GROUP(du_rgb888),
 		SH_PFC_PIN_GROUP(du_clk_in_0),
@@ -4016,8 +4018,6 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clk_b),
 	},
 	.automotive = {
-		SH_PFC_PIN_GROUP(canfd0_data),
-		SH_PFC_PIN_GROUP(canfd1_data),
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
 		SH_PFC_PIN_GROUP(drif0_data1_a),
@@ -4464,8 +4464,8 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[45];
-	struct sh_pfc_function automotive[6];
+	struct sh_pfc_function common[47];
+	struct sh_pfc_function automotive[4];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -4473,6 +4473,8 @@ static const struct {
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
 		SH_PFC_FUNCTION(can_clk),
+		SH_PFC_FUNCTION(canfd0),
+		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(hscif0),
 		SH_PFC_FUNCTION(hscif1),
@@ -4515,8 +4517,6 @@ static const struct {
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
