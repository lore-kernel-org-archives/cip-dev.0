From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:03 +0000
Subject: [cip-dev] [PATCH 04/11] pinctrl: sh-pfc: r8a77990: Add voltage
	switch operations for SDHI
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch supports the {get,set}_io_voltage operations of SDHI.

This operates the IOCTRL30 register on the R8A77990 SoC and makes
1.8V/3.3V signal voltage switch possible.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 33847a71373cd6aeb185be4806ba8a760de0f4cc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 903460a..e6a0418 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -23,8 +23,12 @@
 	PORT_GP_CFG_18(0, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_23(1, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_26(2, fn, sfx, CFG_FLAGS), \
-	PORT_GP_CFG_16(3, fn, sfx, CFG_FLAGS), \
-	PORT_GP_CFG_11(4, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE), \
+	PORT_GP_CFG_1(3, 12, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(3, 13, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(3, 14, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_1(3, 15, fn, sfx, CFG_FLAGS), \
+	PORT_GP_CFG_11(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE), \
 	PORT_GP_CFG_20(5, fn, sfx, CFG_FLAGS), \
 	PORT_GP_CFG_18(6, fn, sfx, CFG_FLAGS)
 /*
@@ -3933,6 +3937,31 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+enum ioctrl_regs {
+	IOCTRL30,
+};
+
+static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
+	[IOCTRL30] = { 0xe6060380, },
+	{ /* sentinel */ },
+};
+
+static int r8a77990_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin,
+				   u32 *pocctrl)
+{
+	int bit = -EINVAL;
+
+	*pocctrl = pinmux_ioctrl_regs[IOCTRL30].reg;
+
+	if (pin >= RCAR_GP_PIN(3, 0) && pin <= RCAR_GP_PIN(3, 11))
+		bit = pin & 0x1f;
+
+	if (pin >= RCAR_GP_PIN(4, 0) && pin <= RCAR_GP_PIN(4, 10))
+		bit = (pin & 0x1f) + 19;
+
+	return bit;
+}
+
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 	{ PINMUX_BIAS_REG("PUEN0", 0xe6060400, "PUD0", 0xe6060440) {
 		 [0] = RCAR_GP_PIN(2, 23),	/* RD# */
@@ -4183,6 +4212,7 @@ static void r8a77990_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 }
 
 static const struct sh_pfc_soc_operations r8a77990_pinmux_ops = {
+	.pin_to_pocctrl = r8a77990_pin_to_pocctrl,
 	.get_bias = r8a77990_pinmux_get_bias,
 	.set_bias = r8a77990_pinmux_set_bias,
 };
@@ -4204,6 +4234,7 @@ const struct sh_pfc_soc_info r8a774c0_pinmux_info = {
 
 	.cfg_regs = pinmux_config_regs,
 	.bias_regs = pinmux_bias_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.7.4
