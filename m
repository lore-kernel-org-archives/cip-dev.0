Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15936.1794916204073756815
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:50:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB27C40312;
	Tue, 17 Nov 2026 11:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B911F000C5;
	Tue, 17 Nov 2026 11:50:02 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 28/34] pinctrl: renesas: rzg2l: Add RZ/G3S support for selecting I3C power source
Date: Tue, 17 Nov 2026 13:49:14 +0200
Message-ID: <20261117114921.1485204-29-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:50:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24939
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
   use bit 19 instead of 23
 - fixed conflict in rzg2l_register_offsets by keeping only the i3c_set
   member
 - dropped RZ/G3L code from rzg2l_register_masks and get rid of anonimous
   union
 - fixed conflict in available_ps[] by keeping the I3C voltage domain
 - in rzg2l_caps_to_pwr_reg(), rzg2l_pinctrl_suspend_noirq(),
   rzg2l_pinctrl_resume_noirq() fixed conflict by keeping the I3C code on=
ly
 - introduced masks member to struct rzg2l_hwcfg as initially presented i=
n
   commit 342a7ce6d2f7 ("pinctrl: renesas: rzg2l: Generalize power source
   code") since this is its first user in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 42 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index faccc764e09c..fa4d70d043d8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -62,6 +62,7 @@
 #define PIN_CFG_SMT			BIT(16)	/* Schmitt-trigger input control */
 #define PIN_CFG_ELC			BIT(17)
 #define PIN_CFG_IOLH_RZV2H		BIT(18)
+#define PIN_CFG_IO_VMC_I3C		BIT(19)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
@@ -217,6 +218,7 @@ static const struct pin_config_item renesas_rzv2h_con=
f_items[] =3D {
  * @eth_poc: ETH_POC register offset
  * @oen: OEN register offset
  * @qspi: QSPI register offset
+ * @i3c_set: I3C_SET register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
@@ -224,6 +226,15 @@ struct rzg2l_register_offsets {
 	u16 eth_poc;
 	u16 oen;
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
@@ -248,6 +259,8 @@ enum rzg2l_iolh_index {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @masks: hardware specific masks for various functionalities available=
 in
+ * the registers described by regs
  * @iolh_groupa_ua: IOLH group A uA specific values
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
@@ -261,6 +274,7 @@ enum rzg2l_iolh_index {
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	const struct rzg2l_register_masks masks;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
@@ -326,6 +340,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
  * @qspi: QSPI registers cache
+ * @i3c_set: I3C_SET register cache
  */
 struct rzg2l_pinctrl_reg_cache {
 	u8	*p;
@@ -340,6 +355,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u8	eth_poc[2];
 	u8	oen;
 	u8	qspi;
+	u8	i3c_set;
 };
=20
 struct rzg2l_pinctrl {
@@ -409,6 +425,10 @@ static const struct rzg2l_pinctrl_ps_desc available_=
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
@@ -960,6 +980,7 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl=
 *pctrl, u32 offset,
 }
=20
 static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs,
+				 const struct rzg2l_register_masks *masks,
 				 u32 caps, u16 *offset, u8 *mask)
 {
 	*mask =3D PVDD_MASK;
@@ -984,6 +1005,11 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l=
_register_offsets *regs,
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
@@ -1014,6 +1040,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
 	u8 mask, val;
 	u16 offset;
 	int ret;
@@ -1021,7 +1048,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
=20
-	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
 	if (ret)
 		return ret;
=20
@@ -1034,6 +1061,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
 	u16 offset;
 	u8 mask;
 	int ret;
@@ -1043,7 +1071,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 		return 0;
 	}
=20
-	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
 	if (ret)
 		return ret;
=20
@@ -2288,6 +2316,8 @@ static const struct rzg2l_dedicated_configs rzg3s_d=
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
@@ -3277,6 +3307,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct devic=
e *dev)
 	if (regs->qspi)
 		cache->qspi =3D readb(pctrl->base + regs->qspi);
 	cache->oen =3D readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
+	if (regs->i3c_set)
+		cache->i3c_set =3D readb(pctrl->base + regs->i3c_set);
=20
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
@@ -3303,6 +3335,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device=
 *dev)
=20
 	if (regs->qspi)
 		writeb(cache->qspi, pctrl->base + regs->qspi);
+	if (regs->i3c_set)
+		writeb(cache->i3c_set, pctrl->base + regs->i3c_set);
=20
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
@@ -3376,8 +3410,12 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
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

