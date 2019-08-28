From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:46 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 19/41] pinctrl: sh-pfc: Validate
	pin tables at runtime
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 542ffc9e026a3f736eeaa041823d406510f40a12 upstream.

Extend the run-time debug code with checks to ensure there are no
conflicting pin names, numbers, or enumeration values.

This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 2a66de2..c3d2313 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -770,6 +770,35 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 
 	pr_info("Checking %s\n", drvname);
 
+	/* Check pins */
+	for (i = 0; i < info->nr_pins; i++) {
+		for (j = 0; j < i; j++) {
+			if (!strcmp(info->pins[i].name, info->pins[j].name)) {
+				pr_err("%s: pin %s/%s: name conflict\n",
+				       drvname, info->pins[i].name,
+				       info->pins[j].name);
+				sh_pfc_errors++;
+			}
+
+			if (info->pins[i].pin != (u16)-1 &&
+			    info->pins[i].pin == info->pins[j].pin) {
+				pr_err("%s: pin %s/%s: pin %u conflict\n",
+				       drvname, info->pins[i].name,
+				       info->pins[j].name, info->pins[i].pin);
+				sh_pfc_errors++;
+			}
+
+			if (info->pins[i].enum_id &&
+			    info->pins[i].enum_id == info->pins[j].enum_id) {
+				pr_err("%s: pin %s/%s: enum_id %u conflict\n",
+				       drvname, info->pins[i].name,
+				       info->pins[j].name,
+				       info->pins[i].enum_id);
+				sh_pfc_errors++;
+			}
+		}
+	}
+
 	/* Check groups and functions */
 	refcnts = kcalloc(info->nr_groups, sizeof(*refcnts), GFP_KERNEL);
 	if (!refcnts)
-- 
2.7.4
