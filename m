Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15817.1794916021629003921
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DF3D415CD;
	Tue, 17 Nov 2026 11:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412AB1F000C4;
	Tue, 17 Nov 2026 11:47:00 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 40/69] pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power source
Date: Tue, 17 Nov 2026 13:45:24 +0200
Message-ID: <20261117114553.1484215-41-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24881
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
[claudiu.beznea:
- fixed conflict in the defines code and adjusted PIN_CFG_IO_VMC_I3C to
  use bit 18 instead of 23
- fixed conflict in rzg2l_register_offsets by keeping only the i3c_set
  member
- dropped RZ/G3L code from rzg2l_register_masks and get rid of anonimous
  union
- fixed conflict in available_ps[] by keeping the I3C voltage domain
- in rzg2l_caps_to_pwr_reg(), rzg2l_pinctrl_suspend_noirq(),
  rzg2l_pinctrl_resume_noirq() fixed conflict by keeping the I3C code onl=
y
- introduced masks member to struct rzg2l_hwcfg as initially presented in
  commit 342a7ce6d2f7 ("pinctrl: renesas: rzg2l: Generalize power source
  code") since this is its first user in v5.10 CIP
- fixed conflict in rzg3s_hwcfg by keeping i3c_set]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 42 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index ed2ecde9ec07..f16d43c96e05 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -55,6 +55,7 @@
 #define PIN_CFG_OEN			BIT(15)
 #define PIN_CFG_VARIABLE		BIT(16)
 #define PIN_CFG_NOGPIO_INT		BIT(17)
+#define PIN_CFG_IO_VMC_I3C		BIT(18)
=20
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -177,12 +178,22 @@
  * @sd_ch: SD_CH register offset
  * @eth_poc: ETH_POC register offset
  * @qspi: QSPI register offset
+ * @i3c_set: I3C_SET register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
 	u16 eth_poc;
 	u16 qspi;
+	u16 i3c_set;
+};
+
+/**
+ * struct rzg2l_register_masks - Masks for different RZ/G2L pinctrl func=
tionalities
+ * @i3c_set_poc: I3C_SET_POC mask
+ */
+struct rzg2l_register_masks {
+	u8 i3c_set_poc;
 };
=20
 /**
@@ -207,6 +218,8 @@ enum rzg2l_iolh_index {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @masks: hardware specific masks for various functionalities available=
 in
+ * the registers described by regs
  * @iolh_groupa_ua: IOLH group A uA specific values
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
@@ -218,6 +231,7 @@ enum rzg2l_iolh_index {
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	const struct rzg2l_register_masks masks;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
@@ -282,6 +296,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @eth_poc: ET_POC registers cache
  * @eth_mode: ETH_MODE register cache
  * @qspi: QSPI registers cache
+ * @i3c_set: I3C_SET register cache
  */
 struct rzg2l_pinctrl_reg_cache {
 	u8	*p;
@@ -295,6 +310,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u8	eth_poc[2];
 	u8	eth_mode;
 	u8	qspi;
+	u8	i3c_set;
 };
=20
 struct rzg2l_pinctrl {
@@ -364,6 +380,10 @@ static const struct rzg2l_pinctrl_ps_desc available_=
ps[] =3D {
 	RZG2L_PINCTRL_PS_DESC(1800, 1, PIN_CFG_IO_VMC_QSPI, RZG2L_IOLH_IDX_1V8)=
,
 	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_IO_VMC_QSPI, RZG2L_IOLH_IDX_3V3)=
,
=20
+	/* I3C I/O voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1200, 1, PIN_CFG_IO_VMC_I3C, RZG2L_IOLH_IDX_NA),
+	RZG2L_PINCTRL_PS_DESC(1800, 0, PIN_CFG_IO_VMC_I3C, RZG2L_IOLH_IDX_NA),
+
 	/* Software voltage domains */
 	RZG2L_PINCTRL_PS_DESC(1800, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_1V8),
 	RZG2L_PINCTRL_PS_DESC(2500, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_2V5),
@@ -899,6 +919,7 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl=
 *pctrl, u32 offset,
 }
=20
 static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs,
+				 const struct rzg2l_register_masks *masks,
 				 u32 caps, u16 *offset, u8 *mask)
 {
 	*mask =3D PVDD_MASK;
@@ -923,6 +944,11 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l_=
register_offsets *regs,
 		*offset =3D regs->qspi;
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
@@ -953,6 +979,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinctr=
l *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
 	u8 mask, val;
 	u16 offset;
 	int ret;
@@ -960,7 +987,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinctr=
l *pctrl, u32 pin, u32 caps
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
=20
-	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
 	if (ret)
 		return ret;
=20
@@ -973,6 +1000,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinct=
rl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
 	unsigned long flags;
 	u8 mask, tmp;
 	u16 offset;
@@ -983,7 +1011,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinct=
rl *pctrl, u32 pin, u32 caps
 		return 0;
 	}
=20
-	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
 	if (ret)
 		return ret;
=20
@@ -1952,6 +1980,8 @@ static const struct rzg2l_dedicated_configs rzg3s_d=
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
@@ -2772,6 +2802,8 @@ static int __maybe_unused rzg2l_pinctrl_suspend_noi=
rq(struct device *dev)
 	if (regs->qspi)
 		cache->qspi =3D readb(pctrl->base + regs->qspi);
 	cache->eth_mode =3D readb(pctrl->base + ETH_MODE);
+	if (regs->i3c_set)
+		cache->i3c_set =3D readb(pctrl->base + regs->i3c_set);
=20
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
@@ -2803,6 +2835,8 @@ static int __maybe_unused rzg2l_pinctrl_resume_noir=
q(struct device *dev)
 		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
 		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
+	if (regs->i3c_set)
+		writeb(cache->i3c_set, pctrl->base + regs->i3c_set);
=20
 	rzg2l_pinctrl_pm_setup_pfc(pctrl);
 	rzg2l_pinctrl_pm_setup_regs(pctrl, false);
@@ -2831,6 +2865,10 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 		.pwpr =3D 0x3000,
 		.sd_ch =3D 0x3004,
 		.eth_poc =3D 0x3010,
+		.i3c_set =3D 0x301c,
+	},
+	.masks =3D {
+		.i3c_set_poc =3D BIT(2),
 	},
 	.iolh_groupa_ua =3D {
 		/* 1v8 power source */
--=20
2.43.0

