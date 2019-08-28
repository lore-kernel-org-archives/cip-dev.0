From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:33 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 06/41] pinctrl: sh-pfc: Validate
	fixed-size field widths at build time
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5e8588c86d71e78de9e97103324d9127063f18d0 upstream.

Add a build-time check, to ensure the register and field widths in
descriptors for config registers with fixed-width fields are sane.
This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 0e39fad..298fd06 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -129,7 +129,8 @@ struct pinmux_cfg_reg {
  * one for each possible combination of the register field bit values.
  */
 #define PINMUX_CFG_REG(name, r, r_width, f_width) \
-	.reg = r, .reg_width = r_width, .field_width = f_width,		\
+	.reg = r, .reg_width = r_width,					\
+	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width),	\
 	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])
 
 /*
-- 
2.7.4
