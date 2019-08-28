From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:51 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 24/41] pinctrl: sh-pfc: r8a77990:
	Rename IOCTRLx registers
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-25-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3df892fdbfe6919270a65a25c7982e2701c44f2b upstream.

The R-Car Gen3 HardWare Manual Errata for Rev. 1.00 (Jul 2, 2018)
renamed the various miscellaneous I/O control registers (IOCTRLx) on
R-Car E3, to reflect better their actual purposes, and matching other
SoCs.

Update the code to match this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index b654e06..b8c49f0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -4996,11 +4996,11 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 };
 
 enum ioctrl_regs {
-	IOCTRL30,
+	POCCTRL0,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
-	[IOCTRL30] = { 0xe6060380, },
+	[POCCTRL0] = { 0xe6060380, },
 	{ /* sentinel */ },
 };
 
@@ -5009,7 +5009,7 @@ static int r8a77990_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin,
 {
 	int bit = -EINVAL;
 
-	*pocctrl = pinmux_ioctrl_regs[IOCTRL30].reg;
+	*pocctrl = pinmux_ioctrl_regs[POCCTRL0].reg;
 
 	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 11))
 		bit = pin & 0x1f;
-- 
2.7.4
