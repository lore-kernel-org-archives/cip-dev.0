From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:45 +0100
Subject: [cip-dev] [PATCH 4.19y 08/10] pinctrl: sh-pfc: r8a77990: GP6_9 does
	not have pull-down capability
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f7d8b568e204d295bf0e780cea10cab1f84be31e upstream.

Hence remove the SH_PFC_PIN_CFG_PULL_DOWN flag from the GP6_9 GPIO
description.

Fixes: 83f6941a42a5e773 ("pinctrl: sh-pfc: r8a77990: Add bias pinconf support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index b1d96a46c..3ce1b24 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -30,7 +30,16 @@
 	PORT_GP_CFG_1(3, 15, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_11(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE), \
 	PORT_GP_CFG_20(5, fn, sfx, CFG_FLAGS), \
-	PORT_GP_CFG_18(6, fn, sfx, CFG_FLAGS)
+	PORT_GP_CFG_9(6, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 9, fn, sfx, SH_PFC_PIN_CFG_PULL_UP), \
+	PORT_GP_CFG_1(6, 10, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 11, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 12, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 13, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 14, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 15, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 16, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(6, 17, fn, sfx, CFG_FLAGS)
 /*
  * F_() : just information
  * FM() : macro for FN_xxx / xxx_MARK
-- 
2.7.4
