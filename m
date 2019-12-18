From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:23 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 13/39] soc: renesas: r8a77990-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit b34095cbc2bb102c9f138afd8c99a8a205b0e142 upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
E3, to prevent conflicts between internal and external power requests.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-8-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a77990-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/r8a77990-sysc.c b/drivers/soc/renesas/r8a77990-sysc.c
index 15579eb..3b6f576 100644
--- a/drivers/soc/renesas/r8a77990-sysc.c
+++ b/drivers/soc/renesas/r8a77990-sysc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/sys_soc.h>
@@ -65,4 +66,6 @@ const struct rcar_sysc_info r8a77990_sysc_info __initconst = {
 	.init = r8a77990_sysc_init,
 	.areas = r8a77990_areas,
 	.num_areas = ARRAY_SIZE(r8a77990_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
 };
-- 
2.7.4
