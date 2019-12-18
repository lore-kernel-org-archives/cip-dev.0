From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:22 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 12/39] soc: renesas: r8a77980-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ee038b88c60a32908fd83d420fce445bd0138f6d upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
V3H, to prevent conflicts between internal and external power requests.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-7-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a77980-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index 9265fb5..d67cc7d 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2018 Cogent Embedded, Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 
@@ -49,4 +50,6 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 const struct rcar_sysc_info r8a77980_sysc_info __initconst = {
 	.areas = r8a77980_areas,
 	.num_areas = ARRAY_SIZE(r8a77980_areas),
+	.extmask_offs = 0x138,
+	.extmask_val = BIT(0),
 };
-- 
2.7.4
