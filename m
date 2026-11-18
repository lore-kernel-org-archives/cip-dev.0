Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.979.1795020150963401094
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1B6045ABB;
	Wed, 18 Nov 2026 16:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144E1F000C8;
	Wed, 18 Nov 2026 16:42:29 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 30/35] pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power source
Date: Wed, 18 Nov 2026 18:41:41 +0200
Message-ID: <20261118164146.3040784-31-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24993
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ec5202ccfa24791acf64146d5bac6b63ce234f95 upstream.

The Renesas RZ/G3S I3C pins can be powered at either 1.8V or 1.2V.  The
pin controller provides a register to select between these two options.
Update the Renesas RZ/G2L pin controller driver to allow selecting the
I3C power source on RZ/G3S SoC.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260904125425.412632-6-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index b44b03dbda59..771837f7eb03 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -70,6 +70,7 @@
 #define PIN_CFG_PVDD1833_OTH_ISO_POC	BIT(20) /* known on RZ/G3L only */
 #define PIN_CFG_WDTOVF_N_POC		BIT(21) /* known on RZ/G3L only */
 #define PIN_CFG_IO_VMC_SD2		BIT(22) /* known on RZ/G3L only */
+#define PIN_CFG_IO_VMC_I3C		BIT(23)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
@@ -259,6 +260,7 @@ static const struct pin_config_item renesas_rzv2h_con=
f_items[] =3D {
  * @oen: OEN register offset
  * @qspi: QSPI register offset
  * @other_poc: OTHER_POC register offset
+ * @i3c_set: I3C_SET register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
@@ -268,6 +270,7 @@ struct rzg2l_register_offsets {
 	u16 oen;
 	u16 qspi;
 	u16 other_poc;
+	u16 i3c_set;
 };
=20
 /**
@@ -275,6 +278,7 @@ struct rzg2l_register_offsets {
  * @other_poc_pvdd1833_oth_awo_poc: PVDD1833_OTH_AWO_POC mask
  * @other_poc_pvdd1833_oth_iso_poc: PVDD1833_OTH_ISO_POC mask
  * @other_poc_wdtovf_n_poc: WDTOVF_N_POC mask
+ * @i3c_set_poc: I3C_SET_POC mask
  */
 struct rzg2l_register_masks {
 	union {
@@ -284,6 +288,11 @@ struct rzg2l_register_masks {
 			u8 other_poc_pvdd1833_oth_iso_poc;
 			u8 other_poc_wdtovf_n_poc;
 		};
+
+		/* RZ/G3S masks */
+		struct {
+			u8 i3c_set_poc;
+		};
 	};
 };
=20
@@ -397,6 +406,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @oen: Output Enable register cache
  * @other_poc: OTHER_POC register cache
  * @qspi: QSPI registers cache
+ * @i3c_set: I3C_SET register cache
  */
 struct rzg2l_pinctrl_reg_cache {
 	u8	*p;
@@ -416,6 +426,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u8	oen;
 	u8	other_poc;
 	u8	qspi;
+	u8	i3c_set;
 };
=20
 struct rzg2l_pinctrl {
@@ -504,6 +515,10 @@ static const struct rzg2l_pinctrl_ps_desc available_=
ps[] =3D {
 	RZG2L_PINCTRL_PS_DESC(1800, 1, PIN_CFG_WDTOVF_N_POC, RZG2L_IOLH_IDX_1V8=
),
 	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_WDTOVF_N_POC, RZG2L_IOLH_IDX_3V3=
),
=20
+	/* I3C I/O voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1200, 1, PIN_CFG_IO_VMC_I3C, RZG2L_IOLH_IDX_NA),
+	RZG2L_PINCTRL_PS_DESC(1800, 0, PIN_CFG_IO_VMC_I3C, RZG2L_IOLH_IDX_NA),
+
 	/* Software voltage domains */
 	RZG2L_PINCTRL_PS_DESC(1800, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_1V8),
 	RZG2L_PINCTRL_PS_DESC(2500, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_2V5),
@@ -1202,6 +1217,11 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2=
l_register_offsets *regs,
 			*mask =3D masks->other_poc_wdtovf_n_poc;
 		return 0;
 	}
+	if (caps & PIN_CFG_IO_VMC_I3C) {
+		*offset =3D regs->i3c_set;
+		*mask =3D masks->i3c_set_poc;
+		return 0;
+	}
=20
 	return -EINVAL;
 }
@@ -2572,6 +2592,8 @@ static const struct rzg2l_dedicated_configs rzg3s_d=
edicated_pins[] =3D {
 	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x2, 0, PIN_CFG_IEN) },
 	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x2, 1, PIN_CFG_IEN) },
 	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN=
_CFG_SOFT_PS) },
+	{ "I3C_SDA", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IEN | PIN_CFG_IO_VM=
C_I3C)) },
+	{ "I3C_SCL", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IEN | PIN_CFG_IO_VM=
C_I3C)) },
 	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_I=
O_VMC_SD0)) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_I=
EN |
 						     PIN_CFG_IO_VMC_SD0)) },
@@ -3804,6 +3826,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct devic=
e *dev)
 	cache->oen =3D readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
 	if (regs->other_poc)
 		cache->other_poc =3D readb(pctrl->base + regs->other_poc);
+	if (regs->i3c_set)
+		cache->i3c_set =3D readb(pctrl->base + regs->i3c_set);
=20
 	if (pctrl->syscon) {
 		int ret;
@@ -3846,6 +3870,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device=
 *dev)
 		writeb(cache->qspi, pctrl->base + regs->qspi);
 	if (regs->other_poc)
 		writeb(cache->other_poc, pctrl->base + regs->other_poc);
+	if (regs->i3c_set)
+		writeb(cache->i3c_set, pctrl->base + regs->i3c_set);
=20
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
@@ -3962,8 +3988,12 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 		.pwpr =3D 0x3000,
 		.sd_ch =3D 0x3004,
 		.eth_poc =3D 0x3010,
+		.i3c_set =3D 0x301c,
 		.oen =3D 0x3018,
 	},
+	.masks =3D {
+		.i3c_set_poc =3D BIT(2),
+	},
 	.iolh_groupa_ua =3D {
 		/* 1v8 power source */
 		[RZG2L_IOLH_IDX_1V8] =3D 2200, 4400, 9000, 10000,
--=20
2.43.0

