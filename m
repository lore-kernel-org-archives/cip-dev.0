From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:21 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 11/39] soc: renesas: r8a77970-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit a228560c52e89aa5e31c5b8a636bf9ab681bda84 upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
V3M, to prevent conflicts between internal and external power requests.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-6-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a77970-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index caf894f..da4f549 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 
@@ -36,4 +37,6 @@ static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
 const struct rcar_sysc_info r8a77970_sysc_info __initconst = {
 	.areas = r8a77970_areas,
 	.num_areas = ARRAY_SIZE(r8a77970_areas),
+	.extmask_offs = 0x1b0,
+	.extmask_val = BIT(0),
 };
-- 
2.7.4
