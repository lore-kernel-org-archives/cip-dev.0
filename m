Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55441CD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42526.1781174594368454962
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8EE760216;
	Thu, 11 Jun 2026 10:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6501A1F00893;
	Thu, 11 Jun 2026 10:43:12 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/26] pinctrl: renesas: rzg2l: Add support for pull-up/down
Date: Thu, 11 Jun 2026 13:42:43 +0300
Message-ID: <20260611104307.2532466-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23064

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 19d4bce9ce876ad0ee4240ebd849b730b3dc3763 upstream.

Add support to configure bias-disable, bias-pull-up, and bias-pull-down
properties of the pin.

Two new function pointers, hw_to_bias_param() and bias_param_to_hw(),
are introduced in the struct rzg2l_pinctrl_data to configure bias
settings, as the values in the PUPD register differ when compared to the
RZ/G2L family and the RZ/V2H(P) SoC.

Value | RZ/G2L        | RZ/V2H
---------------------------------
00b:  | Bias Disabled | Pull up/down disabled
01b:  | Pull-up       | Pull up/down disabled
10b:  | Pull-down     | Pull-down
11b:  | Prohibited    | Pull-up

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-12-prabhakar.mahade=
v-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping slew rate code and
 initialization of pwpr_pfc_lock_unlock, pmc_writeb, oen_read, oen_write
 in driver specific data]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index bcdbf1362fa3..16e32a090131 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -117,6 +117,7 @@
 #define PIN(off)		(0x0800 + (off))
 #define IOLH(off)		(0x1000 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
+#define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
@@ -134,6 +135,7 @@
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
+#define PUPD_MASK		0x03
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -252,6 +254,8 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
 	unsigned int n_variable_pin_cfg;
+	int (*hw_to_bias_param)(unsigned int val);
+	int (*bias_param_to_hw)(enum pin_config_param param);
 };
=20
 /**
@@ -1068,6 +1072,38 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *p=
ctrl, u32 caps, u32 offset, u8
 	return 0;
 }
=20
+static int rzg2l_hw_to_bias_param(unsigned int bias)
+{
+	switch (bias) {
+	case 0:
+		return PIN_CONFIG_BIAS_DISABLE;
+	case 1:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	case 2:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rzg2l_bias_param_to_hw(enum pin_config_param param)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return 0;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return 1;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return 2;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -1118,6 +1154,23 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctr=
l_dev *pctldev,
 		arg =3D ret;
 		break;
=20
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (!(cfg & PIN_CFG_PUPD))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, PUPD(off), bit, PUPD_MASK);
+		ret =3D pctrl->data->hw_to_bias_param(arg);
+		if (ret < 0)
+			return ret;
+
+		if (ret !=3D param)
+			return -EINVAL;
+		/* for PIN_CONFIG_BIAS_PULL_UP/DOWN when enabled we just return 1 */
+		arg =3D 1;
+		break;
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
=20
@@ -1223,6 +1276,19 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctr=
l_dev *pctldev,
 			settings.power_source =3D pinconf_to_config_argument(_configs[i]);
 			break;
=20
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (!(cfg & PIN_CFG_PUPD))
+				return -EINVAL;
+
+			ret =3D pctrl->data->bias_param_to_hw(param);
+			if (ret < 0)
+				return ret;
+
+			rzg2l_rmw_pin_config(pctrl, PUPD(off), bit, PUPD_MASK, ret);
+			break;
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg =3D pinconf_to_config_argument(_configs[i]);
=20
@@ -2705,6 +2771,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D=
 {
 	.variable_pin_cfg =3D r9a07g043f_variable_pin_cfg,
 	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
 #endif
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g044_data =3D {
@@ -2716,6 +2784,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D=
 {
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 	.hwcfg =3D &rzg2l_hwcfg,
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static struct rzg2l_pinctrl_data r9a08g045_data =3D {
@@ -2726,6 +2796,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D=
 {
 	.n_port_pins =3D ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PO=
RT,
 	.n_dedicated_pins =3D ARRAY_SIZE(rzg3s_dedicated_pins),
 	.hwcfg =3D &rzg3s_hwcfg,
+	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
--=20
2.43.0


