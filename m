From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:20 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 10/39] soc: renesas: r8a77965-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fd733519436fb56fc89265f42276bfac04a14cfc upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
M3-N, to prevent conflicts between internal and external power requests.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-5-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a77965-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/r8a77965-sysc.c b/drivers/soc/renesas/r8a77965-sysc.c
index d7f7928..60f0896 100644
--- a/drivers/soc/renesas/r8a77965-sysc.c
+++ b/drivers/soc/renesas/r8a77965-sysc.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2016 Glider bvba
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 
@@ -34,4 +35,6 @@ static const struct rcar_sysc_area r8a77965_areas[] __initconst = {
 const struct rcar_sysc_info r8a77965_sysc_info __initconst = {
 	.areas = r8a77965_areas,
 	.num_areas = ARRAY_SIZE(r8a77965_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
 };
-- 
2.7.4
