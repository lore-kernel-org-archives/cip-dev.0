From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:41 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 36/51] pinctrl: sh-pfc: Add
	PORT_GP_27 helper macro
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-37-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fbc5108d93fff92e76c41a59fe07062be84dc720 upstream.

This follows the style of the existing PORT_GP_X macros, and will be
used by a follow-up patch for the r8a7778 SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 3c4b2ac..0b33108 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -546,9 +546,13 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 	PORT_GP_CFG_1(bank, 25, fn, sfx, cfg)
 #define PORT_GP_26(bank, fn, sfx)	PORT_GP_CFG_26(bank, fn, sfx, 0)
 
-#define PORT_GP_CFG_28(bank, fn, sfx, cfg)				\
+#define PORT_GP_CFG_27(bank, fn, sfx, cfg)				\
 	PORT_GP_CFG_26(bank, fn, sfx, cfg),				\
-	PORT_GP_CFG_1(bank, 26, fn, sfx, cfg),				\
+	PORT_GP_CFG_1(bank, 26, fn, sfx, cfg)
+#define PORT_GP_27(bank, fn, sfx)	PORT_GP_CFG_27(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_28(bank, fn, sfx, cfg)				\
+	PORT_GP_CFG_27(bank, fn, sfx, cfg),				\
 	PORT_GP_CFG_1(bank, 27, fn, sfx, cfg)
 #define PORT_GP_28(bank, fn, sfx)	PORT_GP_CFG_28(bank, fn, sfx, 0)
 
-- 
2.7.4
