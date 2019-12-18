From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:24 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 14/39] soc: renesas: r8a774c0-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8c32c5ff873580a5bff1b743ac5e080b36fbd784 upstream.

Describe the location and contents of the SYSCEXTMASK register on
RZ/G2E, to prevent conflicts between internal and external power
requests.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190920143523.23125-1-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a774c0-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/r8a774c0-sysc.c b/drivers/soc/renesas/r8a774c0-sysc.c
index 11050e1..40d1558 100644
--- a/drivers/soc/renesas/r8a774c0-sysc.c
+++ b/drivers/soc/renesas/r8a774c0-sysc.c
@@ -6,6 +6,7 @@
  * Based on Renesas R-Car E3 System Controller
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/sys_soc.h>
@@ -50,4 +51,6 @@ const struct rcar_sysc_info r8a774c0_sysc_info __initconst = {
 	.init = r8a774c0_sysc_init,
 	.areas = r8a774c0_areas,
 	.num_areas = ARRAY_SIZE(r8a774c0_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
 };
-- 
2.7.4
