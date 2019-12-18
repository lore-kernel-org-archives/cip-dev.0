From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:19 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 09/39] soc: renesas: r8a7796-sysc: Fix
	power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5a6cf826b37c5cd31304ba42117f632ee1f0552f upstream.

Describe the location and contents of the SYSCEXTMASK register on R-Car
M3-W, to prevent conflicts between internal and external power requests.

This register does not exist on R-Car M3-W ES1.x.

Based on a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-4-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/r8a7796-sysc.c | 22 +++++++++++++++++++++-
 drivers/soc/renesas/rcar-sysc.h    |  2 +-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/soc/renesas/r8a7796-sysc.c
index f700c84..5f03cc9 100644
--- a/drivers/soc/renesas/r8a7796-sysc.c
+++ b/drivers/soc/renesas/r8a7796-sysc.c
@@ -8,8 +8,10 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/sys_soc.h>
 
 #include <dt-bindings/power/r8a7796-sysc.h>
 
@@ -42,7 +44,25 @@ static const struct rcar_sysc_area r8a7796_areas[] __initconst = {
 	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON },
 };
 
-const struct rcar_sysc_info r8a7796_sysc_info __initconst = {
+
+/* Fixups for R-Car M3-W ES1.x revision */
+static const struct soc_device_attribute r8a7796es1[] __initconst = {
+	{ .soc_id = "r8a7796", .revision = "ES1.*" },
+	{ /* sentinel */ }
+};
+
+static int __init r8a7796_sysc_init(void)
+{
+	if (soc_device_match(r8a7796es1))
+		r8a7796_sysc_info.extmask_val = 0;
+
+	return 0;
+}
+
+struct rcar_sysc_info r8a7796_sysc_info __initdata = {
+	.init = r8a7796_sysc_init,
 	.areas = r8a7796_areas,
 	.num_areas = ARRAY_SIZE(r8a7796_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
 };
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 733b8ec..d36cd76 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -63,7 +63,7 @@ extern const struct rcar_sysc_info r8a7791_sysc_info;
 extern const struct rcar_sysc_info r8a7792_sysc_info;
 extern const struct rcar_sysc_info r8a7794_sysc_info;
 extern struct rcar_sysc_info r8a7795_sysc_info;
-extern const struct rcar_sysc_info r8a7796_sysc_info;
+extern struct rcar_sysc_info r8a7796_sysc_info;
 extern const struct rcar_sysc_info r8a77965_sysc_info;
 extern const struct rcar_sysc_info r8a77970_sysc_info;
 extern const struct rcar_sysc_info r8a77980_sysc_info;
-- 
2.7.4
