From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:19:23 +0000
Subject: [cip-dev] [PATCH 2/9] pinctrl: sh-pfc: rcar: Rename automotive-only
	arrays to automotive
In-Reply-To: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
References: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553246370-60751-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Renesas RZ/G SoCs are pin compatible with R-Car SoCs, but lack several
automotive-specific peripherals.

Currently pin groups and functions for automotive-specific peripherals
are grouped in arrays named after the automative SoC part numbers.
Rename them to "automotive" for clarity and consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a97f340c0a071bcb32ff68f3d19cf56a76887288)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c  | 16 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c  | 12 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c |  8 ++++----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 5811784..c5144de 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4458,7 +4458,7 @@ static const unsigned int vin2_clk_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[346];
-	struct sh_pfc_pin_group r8a779x[9];
+	struct sh_pfc_pin_group automotive[9];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a),
@@ -4808,7 +4808,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin2_clkenb),
 		SH_PFC_PIN_GROUP(vin2_clk),
 	},
-	.r8a779x = {
+	.automotive = {
 		SH_PFC_PIN_GROUP(adi_common),
 		SH_PFC_PIN_GROUP(adi_chsel0),
 		SH_PFC_PIN_GROUP(adi_chsel1),
@@ -5365,7 +5365,7 @@ static const char * const vin2_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[58];
-	struct sh_pfc_function r8a779x[2];
+	struct sh_pfc_function automotive[2];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -5427,7 +5427,7 @@ static const struct {
 		SH_PFC_FUNCTION(vin1),
 		SH_PFC_FUNCTION(vin2),
 	},
-	.r8a779x = {
+	.automotive = {
 		SH_PFC_FUNCTION(adi),
 		SH_PFC_FUNCTION(mlb),
 	}
@@ -6646,10 +6646,10 @@ const struct sh_pfc_soc_info r8a7791_pinmux_info = {
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
 	.groups = pinmux_groups.common,
 	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
-		     ARRAY_SIZE(pinmux_groups.r8a779x),
+		     ARRAY_SIZE(pinmux_groups.automotive),
 	.functions = pinmux_functions.common,
 	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
-			ARRAY_SIZE(pinmux_functions.r8a779x),
+			ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 
@@ -6670,10 +6670,10 @@ const struct sh_pfc_soc_info r8a7793_pinmux_info = {
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
 	.groups = pinmux_groups.common,
 	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
-		     ARRAY_SIZE(pinmux_groups.r8a779x),
+		     ARRAY_SIZE(pinmux_groups.automotive),
 	.functions = pinmux_functions.common,
 	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
-			ARRAY_SIZE(pinmux_functions.r8a779x),
+			ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 067a79e..aa378e4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -4128,7 +4128,7 @@ static const unsigned int vin5_clk_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[307];
-	struct sh_pfc_pin_group r8a779x[33];
+	struct sh_pfc_pin_group automotive[33];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
@@ -4439,7 +4439,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
 	},
-	.r8a779x = {
+	.automotive = {
 		SH_PFC_PIN_GROUP(canfd0_data_a),
 		SH_PFC_PIN_GROUP(canfd0_data_b),
 		SH_PFC_PIN_GROUP(canfd1_data),
@@ -4971,7 +4971,7 @@ static const char * const vin5_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[45];
-	struct sh_pfc_function r8a779x[6];
+	struct sh_pfc_function automotive[6];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -5020,7 +5020,7 @@ static const struct {
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
 	},
-	.r8a779x = {
+	.automotive = {
 		SH_PFC_FUNCTION(canfd0),
 		SH_PFC_FUNCTION(canfd1),
 		SH_PFC_FUNCTION(drif0),
@@ -6188,10 +6188,10 @@ const struct sh_pfc_soc_info r8a7796_pinmux_info = {
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
 	.groups = pinmux_groups.common,
 	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
-		ARRAY_SIZE(pinmux_groups.r8a779x),
+		ARRAY_SIZE(pinmux_groups.automotive),
 	.functions = pinmux_functions.common,
 	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
-		ARRAY_SIZE(pinmux_functions.r8a779x),
+		ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 	.drive_regs = pinmux_drive_regs,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 76ac77a..663b8ce 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2391,7 +2391,7 @@ static const unsigned int usb30_id_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[117];
-	struct sh_pfc_pin_group r8a77990[0];
+	struct sh_pfc_pin_group automotive[0];
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(avb_link),
@@ -2717,7 +2717,7 @@ static const char * const usb30_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[28];
-	struct sh_pfc_function r8a77990[0];
+	struct sh_pfc_function automotive[0];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(avb),
@@ -3509,10 +3509,10 @@ const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
 	.groups = pinmux_groups.common,
 	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
-		ARRAY_SIZE(pinmux_groups.r8a77990),
+		ARRAY_SIZE(pinmux_groups.automotive),
 	.functions = pinmux_functions.common,
 	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
-		ARRAY_SIZE(pinmux_functions.r8a77990),
+		ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 	.bias_regs = pinmux_bias_regs,
-- 
2.7.4
