From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:29 +0100
Subject: [cip-dev] [PATCH 28/86] pinctrl: sh-pfc: r8a7794: Fix GP2[29] muxing
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-29-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

GP2[29] muxing is controlled by 2-bit IP6[3:2] field, yet only 3 values
are listed instead of 4...

[Sergei: fixed up the formatting, renamed, added the changelog.]

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit abf05e1900a355e5d5bf2ec35ede6261affb6328)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index abcf735..4524fb8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -4549,6 +4549,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_DU0_DISP, FN_QPOLA, FN_CC50_STATE30, 0,
 		/* IP6_3_2 [2] */
 		FN_DU0_EXODDF_DU0_ODDF_DISP_CDE, FN_QCPV_QDE, FN_CC50_STATE29,
+		0,
 		/* IP6_1_0 [2] */
 		FN_DU0_EXVSYNC_DU0_VSYNC, FN_QSTB_QHE, FN_CC50_STATE28, 0, }
 	},
-- 
2.7.4
