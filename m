From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:50 +0100
Subject: [cip-dev] [PATCH 01/62] pinctrl: sh-pfc: r8a7791: Add can_clk
	function
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds can_clk function to r8a7743/r8a7791 which is cleaner,
and allows for independent configuration.
We keep the can_clk* pins definitions from within can0_groups and
can1_groups for uniformity and backwards compatibility.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 57eec02caee60332b8052615e7257f932ae07abc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 351842e..39fc9ad 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -4830,6 +4830,10 @@ static const char * const can0_groups[] = {
 	"can0_data_d",
 	"can0_data_e",
 	"can0_data_f",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -4841,6 +4845,21 @@ static const char * const can1_groups[] = {
 	"can1_data_b",
 	"can1_data_c",
 	"can1_data_d",
+	/*
+	 * Retained for backwards compatibility, use can_clk_groups in new
+	 * designs.
+	 */
+	"can_clk",
+	"can_clk_b",
+	"can_clk_c",
+	"can_clk_d",
+};
+
+/*
+ * can_clk_groups allows for independent configuration, use can_clk function
+ * in new designs.
+ */
+static const char * const can_clk_groups[] = {
 	"can_clk",
 	"can_clk_b",
 	"can_clk_c",
@@ -5312,7 +5331,7 @@ static const char * const vin2_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[56];
+	struct sh_pfc_function common[57];
 	struct sh_pfc_function r8a779x[2];
 } pinmux_functions = {
 	.common = {
@@ -5320,6 +5339,7 @@ static const struct {
 		SH_PFC_FUNCTION(avb),
 		SH_PFC_FUNCTION(can0),
 		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
 		SH_PFC_FUNCTION(du),
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
-- 
2.7.4
