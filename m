From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:55 +0100
Subject: [cip-dev] [PATCH 02/11] pinctrl: sh-pfc: r8a7791: Use
	PINMUX_SINGLE() instead of raw PINMUX_DATA()
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
(cherry picked from commit bc3341ddaea26756c76965a7e0e95c6a8e01c857)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 87a4f44..ebadd28 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -787,23 +787,23 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(EX_CS0_N_MARK, FN_EX_CS0_N),
-	PINMUX_DATA(RD_N_MARK, FN_RD_N),
-	PINMUX_DATA(AUDIO_CLKA_MARK, FN_AUDIO_CLKA),
-	PINMUX_DATA(VI0_CLK_MARK, FN_VI0_CLK),
-	PINMUX_DATA(VI0_DATA0_VI0_B0_MARK, FN_VI0_DATA0_VI0_B0),
-	PINMUX_DATA(VI0_DATA1_VI0_B1_MARK, FN_VI0_DATA1_VI0_B1),
-	PINMUX_DATA(VI0_DATA2_VI0_B2_MARK, FN_VI0_DATA2_VI0_B2),
-	PINMUX_DATA(VI0_DATA4_VI0_B4_MARK, FN_VI0_DATA4_VI0_B4),
-	PINMUX_DATA(VI0_DATA5_VI0_B5_MARK, FN_VI0_DATA5_VI0_B5),
-	PINMUX_DATA(VI0_DATA6_VI0_B6_MARK, FN_VI0_DATA6_VI0_B6),
-	PINMUX_DATA(VI0_DATA7_VI0_B7_MARK, FN_VI0_DATA7_VI0_B7),
-	PINMUX_DATA(USB0_PWEN_MARK, FN_USB0_PWEN),
-	PINMUX_DATA(USB0_OVC_MARK, FN_USB0_OVC),
-	PINMUX_DATA(USB1_PWEN_MARK, FN_USB1_PWEN),
-	PINMUX_DATA(USB1_OVC_MARK, FN_USB1_OVC),
-	PINMUX_DATA(DU0_DOTCLKIN_MARK, FN_DU0_DOTCLKIN),
-	PINMUX_DATA(SD1_CLK_MARK, FN_SD1_CLK),
+	PINMUX_SINGLE(EX_CS0_N),
+	PINMUX_SINGLE(RD_N),
+	PINMUX_SINGLE(AUDIO_CLKA),
+	PINMUX_SINGLE(VI0_CLK),
+	PINMUX_SINGLE(VI0_DATA0_VI0_B0),
+	PINMUX_SINGLE(VI0_DATA1_VI0_B1),
+	PINMUX_SINGLE(VI0_DATA2_VI0_B2),
+	PINMUX_SINGLE(VI0_DATA4_VI0_B4),
+	PINMUX_SINGLE(VI0_DATA5_VI0_B5),
+	PINMUX_SINGLE(VI0_DATA6_VI0_B6),
+	PINMUX_SINGLE(VI0_DATA7_VI0_B7),
+	PINMUX_SINGLE(USB0_PWEN),
+	PINMUX_SINGLE(USB0_OVC),
+	PINMUX_SINGLE(USB1_PWEN),
+	PINMUX_SINGLE(USB1_OVC),
+	PINMUX_SINGLE(DU0_DOTCLKIN),
+	PINMUX_SINGLE(SD1_CLK),
 
 	/* IPSR0 */
 	PINMUX_IPSR_DATA(IP0_0, D0),
-- 
1.9.1
