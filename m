From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:45 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 18/41] pinctrl: sh-pfc: Add check
	for empty pinmux groups/functions
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3dd5fd79f07103f7cda30567f8bf85a854796dd6 upstream.

The pinmux groups and functions arrays may contain two parts, to ease
supporting SoCs that expose pin subsets of other related SoCs.  Both
parts need to be declared with explicit sizes, which thus need to be
updated when adding support for more groups and functions.

If a size is too small, the compiler will detect this at build time
("excess elements in array initializer").
If a size is too large, this may go undetected (for pin groups), lead to
pin controller registration failures (for pin functions: "pinmux ops has
no name for functionN"), or crash the optional run-time debug code (for
pin groups).

Extend the run-time debug code with checks to detect this, to help
catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 5c4f441..2a66de2 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -777,9 +777,15 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 
 	for (i = 0; i < info->nr_functions; i++) {
 		func = &info->functions[i];
+		if (!func->name) {
+			pr_err("%s: empty function %u\n", drvname, i);
+			sh_pfc_errors++;
+			continue;
+		}
 		for (j = 0; j < func->nr_groups; j++) {
 			for (k = 0; k < info->nr_groups; k++) {
-				if (!strcmp(func->groups[j],
+				if (info->groups[k].name &&
+				    !strcmp(func->groups[j],
 					    info->groups[k].name)) {
 					refcnts[k]++;
 					break;
@@ -795,6 +801,11 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	}
 
 	for (i = 0; i < info->nr_groups; i++) {
+		if (!info->groups[i].name) {
+			pr_err("%s: empty group %u\n", drvname, i);
+			sh_pfc_errors++;
+			continue;
+		}
 		if (!refcnts[i]) {
 			pr_err("%s: orphan group %s\n", drvname,
 			       info->groups[i].name);
-- 
2.7.4
