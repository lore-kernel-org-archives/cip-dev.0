From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:40 +0100
Subject: [cip-dev] [PATCH 4.4.y 15/52] pinctrl: sh-pfc: r8a77470: Add QSPI1
	pin groups
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit f743f017b739e27601fec7d3eab29840c5e95b37 upstream.

Add QSPI1 pin groups and function to the RZ/G1C (a.k.a. R8A77470)
pinctrl driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index f23042e..395d1fd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -1629,6 +1629,29 @@ static const unsigned int qspi0_data4_mux[] = {
 	QSPI0_MOSI_QSPI0_IO0_MARK, QSPI0_MISO_QSPI0_IO1_MARK,
 	QSPI0_IO2_MARK, QSPI0_IO3_MARK,
 };
+static const unsigned int qspi1_ctrl_pins[] = {
+	/* SPCLK, SSL */
+	RCAR_GP_PIN(4, 6), RCAR_GP_PIN(4, 9),
+};
+static const unsigned int qspi1_ctrl_mux[] = {
+	QSPI1_SPCLK_MARK, QSPI1_SSL_MARK,
+};
+static const unsigned int qspi1_data2_pins[] = {
+	/* MOSI_IO0, MISO_IO1 */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5),
+};
+static const unsigned int qspi1_data2_mux[] = {
+	QSPI1_MOSI_QSPI1_IO0_MARK, QSPI1_MISO_QSPI1_IO1_MARK,
+};
+static const unsigned int qspi1_data4_pins[] = {
+	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
+	RCAR_GP_PIN(4, 4), RCAR_GP_PIN(4, 5), RCAR_GP_PIN(4, 7),
+	RCAR_GP_PIN(4, 8),
+};
+static const unsigned int qspi1_data4_mux[] = {
+	QSPI1_MOSI_QSPI1_IO0_MARK, QSPI1_MISO_QSPI1_IO1_MARK,
+	QSPI1_IO2_MARK, QSPI1_IO3_MARK,
+};
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_a_pins[] = {
 	/* RX, TX */
@@ -2126,6 +2149,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	SH_PFC_PIN_GROUP(qspi0_data2),
 	SH_PFC_PIN_GROUP(qspi0_data4),
+	SH_PFC_PIN_GROUP(qspi1_ctrl),
+	SH_PFC_PIN_GROUP(qspi1_data2),
+	SH_PFC_PIN_GROUP(qspi1_data4),
 	SH_PFC_PIN_GROUP(scif0_data_a),
 	SH_PFC_PIN_GROUP(scif0_data_b),
 	SH_PFC_PIN_GROUP(scif0_data_c),
@@ -2278,6 +2304,12 @@ static const char * const qspi0_groups[] = {
 	"qspi0_data4",
 };
 
+static const char * const qspi1_groups[] = {
+	"qspi1_ctrl",
+	"qspi1_data2",
+	"qspi1_data4",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data_a",
 	"scif0_data_b",
@@ -2383,6 +2415,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c4),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(qspi0),
+	SH_PFC_FUNCTION(qspi1),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.7.4
