From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:28 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 01/41] pinctrl: sh-pfc: Print
	actual field width for variable-width fields
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ce16e8dd0db2701265e6dfdb4fbed632b6ff61c2 upstream.

The debug code in sh_pfc_write_config_reg() prints the width of the
field being modified.

However, registers with a variable-width field layout are identified by
pinmux_cfg_reg.field_width being zero, hence zeroes are printed instead
of the actual field widths.

Fix this by printing the Hamming weight of the field mask instead, which
is correct for both fixed-width and variable-width fields.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 4f835b6..310b0dd 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -224,7 +224,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 
 	dev_dbg(pfc->dev, "write_reg addr = %x, value = 0x%x, field = %u, "
 		"r_width = %u, f_width = %u\n",
-		crp->reg, value, field, crp->reg_width, crp->field_width);
+		crp->reg, value, field, crp->reg_width, hweight32(mask));
 
 	mask = ~(mask << pos);
 	value = value << pos;
-- 
2.7.4
