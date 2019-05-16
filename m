From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:23 +0100
Subject: [cip-dev] [PATCH v2 11/52] pinctrl: sh-pfc: r8a77470: Add USB pin
	groups
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 8faa0754ec246bb40034c6d8afca72afef54bd10 upstream.

Add USB[01] pin groups and functions to the R8A77470 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1->v2:
* No change
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index a103740..283217f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1681,6 +1681,24 @@ static const unsigned int sdhi2_wp_pins[] = {
 static const unsigned int sdhi2_wp_mux[] = {
 	SD2_WP_MARK,
 };
+/* - USB0 ------------------------------------------------------------------- */
+static const unsigned int usb0_pins[] = {
+	RCAR_GP_PIN(0, 0), /* PWEN */
+	RCAR_GP_PIN(0, 1), /* OVC */
+};
+static const unsigned int usb0_mux[] = {
+	USB0_PWEN_MARK,
+	USB0_OVC_MARK,
+};
+/* - USB1 ------------------------------------------------------------------- */
+static const unsigned int usb1_pins[] = {
+	RCAR_GP_PIN(0, 2), /* PWEN */
+	RCAR_GP_PIN(0, 3), /* OVC */
+};
+static const unsigned int usb1_mux[] = {
+	USB1_PWEN_MARK,
+	USB1_OVC_MARK,
+};
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_col),
@@ -1755,6 +1773,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(sdhi2_ctrl),
 	SH_PFC_PIN_GROUP(sdhi2_cd),
 	SH_PFC_PIN_GROUP(sdhi2_wp),
+	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb1),
 };
 
 static const char * const avb_groups[] = {
@@ -1868,6 +1888,14 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_wp",
 };
 
+static const char * const usb0_groups[] = {
+	"usb0",
+};
+
+static const char * const usb1_groups[] = {
+	"usb1",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(du0),
@@ -1882,6 +1910,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif5),
 	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(sdhi2),
+	SH_PFC_FUNCTION(usb0),
+	SH_PFC_FUNCTION(usb1),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.7.4
