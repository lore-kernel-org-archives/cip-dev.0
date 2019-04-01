From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:40 +0100
Subject: [cip-dev] [PATCH 4.19y 03/10] pinctrl: sh-pfc: r8a77990: Fix IOCTRL
	reg state after s2ram on R-Car E3
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 117774fbe6beae3fd4f1fed5b7f596acdd90a2ed upstream.

Due to an interaction with commit 9f2b76a2db3c4387 ("pinctrl: sh-pfc:
r8a77990: Add R8A774C0 PFC support"), the state of the I/O Control
Registers is saved/restored during s2ram on RZ/G2E, but not on R-Car E3.
Hence on R-Car E3, SDHI voltage state is lost after system resume.

Fix this by registering the I/O Control Registers on R-Car E3, too.

Fixes: 33847a71373cd6ae ("pinctrl: sh-pfc: r8a77990: Add voltage switch operations for SDHI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 8c06d72..9ebc7bc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -5004,6 +5004,7 @@ const struct sh_pfc_soc_info r8a77990_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 	.bias_regs = pinmux_bias_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.7.4
