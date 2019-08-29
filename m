From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:21 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 16/51] pinctrl: sh-pfc: Correct
	printk level of group reference warning
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5f304f8c87c71572da4ee514eb2ec50f8f4d2e26 upstream.

Improve wording while at it.

Fixes: 6161b39a14380815 ("pinctrl: sh-pfc: Validate pinmux tables at runtime when debugging")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 3ffd945..09b58eb 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -800,8 +800,8 @@ static void sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 			       info->groups[i].name);
 			sh_pfc_errors++;
 		} else if (refcnts[i] > 1) {
-			pr_err("%s: group %s referred by %u functions\n",
-			       drvname, info->groups[i].name, refcnts[i]);
+			pr_warn("%s: group %s referenced by %u functions\n",
+				drvname, info->groups[i].name, refcnts[i]);
 			sh_pfc_warnings++;
 		}
 	}
-- 
2.7.4
