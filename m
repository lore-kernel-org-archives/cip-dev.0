From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 10:28:46 +0000
Subject: [cip-dev] [PATCH 2/4] pinctrl: sh-pfc: Add optional arg to
	VIN_DATA_PIN_GROUP
In-Reply-To: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
References: <1553250528-42395-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553250528-42395-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

VIN data groups may appear on different sets of pins, usually named
"vinX_data_[a|b]". The existing VIN_DATA_PIN_GROUP() does not support
appending the '_a' or '_b' suffix, leading to the definition of group
names not consistent with the ones defined using the SH_PFC_PIN_GROUP()
macro.

Fix this by making the VIN_DATA_PIN_GROUP macro a variadic one,
which accepts an optional 'version' argument.

Fixes: 423caa52534f ("pinctrl: sh-pfc: r8a779[01]: Move 'union vin_data' to shared header file")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit e889b2981511b625d0dbe28add0546175046d107)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 2a62fc7..7f31300 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -58,14 +58,15 @@ struct sh_pfc_pin_group {
 /*
  * Using union vin_data{,12,16} saves memory occupied by the VIN data pins.
  * VIN_DATA_PIN_GROUP() is a macro used to describe the VIN pin groups
- * in this case.
+ * in this case. It accepts an optional 'version' argument used when the
+ * same group can appear on a different set of pins.
  */
-#define VIN_DATA_PIN_GROUP(n, s)				\
-	{							\
-		.name = #n#s,					\
-		.pins = n##_pins.data##s,			\
-		.mux = n##_mux.data##s,				\
-		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
+#define VIN_DATA_PIN_GROUP(n, s, ...)					\
+	{								\
+		.name = #n#s#__VA_ARGS__,				\
+		.pins = n##__VA_ARGS__##_pins.data##s,			\
+		.mux = n##__VA_ARGS__##_mux.data##s,			\
+		.nr_pins = ARRAY_SIZE(n##__VA_ARGS__##_pins.data##s),	\
 	}
 
 union vin_data12 {
-- 
2.7.4
