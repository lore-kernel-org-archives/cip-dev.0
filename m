From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:18 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 08/39] soc: renesas: r8a7795-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0e0c4db2fa0982af0956c0eed0a94e0b412ef2f4 upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
H3, to prevent conflicts between internal and external power requests.

This register does not exist on R-Car H3 ES1.x and ES2.x.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-3-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a7795-sysc.c | 32 +++++++++++++++++++++++++++-----
 drivers/soc/renesas/rcar-sysc.h    |  2 +-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/soc/renesas/r8a7795-sysc.c
index 7412666..37b05e5 100644
--- a/drivers/soc/renesas/r8a7795-sysc.c
+++ b/drivers/soc/renesas/r8a7795-sysc.c
@@ -8,6 +8,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/sys_soc.h>
@@ -54,25 +55,46 @@ static struct rcar_sysc_area r8a7795_areas[] __initdata = {
 
 
 	/*
-	 * Fixups for R-Car H3 revisions after ES1.x
+	 * Fixups for R-Car H3 revisions
 	 */
 
-static const struct soc_device_attribute r8a7795es1[] __initconst = {
-	{ .soc_id = "r8a7795", .revision = "ES1.*" },
+#define HAS_A2VC0	BIT(0)		/* Power domain A2VC0 is present */
+#define NO_EXTMASK	BIT(1)		/* Missing SYSCEXTMASK register */
+
+static const struct soc_device_attribute r8a7795_quirks_match[] __initconst = {
+	{
+		.soc_id = "r8a7795", .revision = "ES1.*",
+		.data = (void *)(HAS_A2VC0 | NO_EXTMASK),
+	}, {
+		.soc_id = "r8a7795", .revision = "ES2.*",
+		.data = (void *)(NO_EXTMASK),
+	},
 	{ /* sentinel */ }
 };
 
 static int __init r8a7795_sysc_init(void)
 {
-	if (!soc_device_match(r8a7795es1))
+	const struct soc_device_attribute *attr;
+	u32 quirks = 0;
+
+	attr = soc_device_match(r8a7795_quirks_match);
+	if (attr)
+		quirks = (uintptr_t)attr->data;
+
+	if (!(quirks & HAS_A2VC0))
 		rcar_sysc_nullify(r8a7795_areas, ARRAY_SIZE(r8a7795_areas),
 				  R8A7795_PD_A2VC0);
 
+	if (quirks & NO_EXTMASK)
+		r8a7795_sysc_info.extmask_val = 0;
+
 	return 0;
 }
 
-const struct rcar_sysc_info r8a7795_sysc_info __initconst = {
+struct rcar_sysc_info r8a7795_sysc_info __initdata = {
 	.init = r8a7795_sysc_init,
 	.areas = r8a7795_areas,
 	.num_areas = ARRAY_SIZE(r8a7795_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
 };
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 9b2a869..733b8ec 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -62,7 +62,7 @@ extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
 extern const struct rcar_sysc_info r8a7792_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
-extern const struct rcar_sysc_info r8a7795_sysc_info;
+extern struct rcar_sysc_info r8a7795_sysc_info;
 extern const struct rcar_sysc_info r8a7796_sysc_info;
 extern const struct rcar_sysc_info r8a77965_sysc_info;
 extern const struct rcar_sysc_info r8a77970_sysc_info;
-- 
2.7.4
