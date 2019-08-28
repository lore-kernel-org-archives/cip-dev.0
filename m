From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:32 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 05/41] pinctrl: sh-pfc: Make
	pinmux_cfg_reg.var_field_width[] variable-length
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f83f97684a737f66c9a10437544c92e3436ca4e0 upstream.

pinmux_cfg_reg.var_field_width[] is actually a variable-length array,
terminated by a zero, and counting at most r_width entries.
Usually the number of entries is much smaller than r_width, so the
ability to catch bugs at compile time through an "excess elements in
array initializer" warning is fairly limited.

Hence make the array variable-length, decreasing kernel size slightly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 6d3430c..0e39fad 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -145,8 +145,7 @@ struct pinmux_cfg_reg {
  */
 #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
 	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (const u8 [r_width]) \
-		{ var_fw0, var_fwn, 0 }, \
+	.var_field_width = (const u8 []) { var_fw0, var_fwn, 0 }, \
 	.enum_ids = (const u16 [])
 
 struct pinmux_drive_reg_field {
-- 
2.7.4
