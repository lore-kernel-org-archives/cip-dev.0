From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:54 +0100
Subject: [cip-dev] [PATCH  01/11] pinctrl: sh-pfc: Add PINMUX_SINGLE()
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a macro to describe a pinmux configuration for a single-function
pin.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
(cherry picked from commit dcd803bebcfc0fae9c2d3d5063210e9225fe4b1b)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 7b373d43..fb2de52 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -199,6 +199,14 @@ struct sh_pfc_soc_info {
 	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
 
 /*
+ * Describe a pinmux configuration for a single-function pin with GPIO
+ * capability.
+ *   - fn: Function name
+ */
+#define PINMUX_SINGLE(fn)						\
+	PINMUX_DATA(fn##_MARK, FN_##fn)
+
+/*
  * GP port style (32 ports banks)
  */
 
-- 
1.9.1
