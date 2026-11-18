Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.933.1795020146788659491
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9667745ADA;
	Wed, 18 Nov 2026 16:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9982F1F000C4;
	Wed, 18 Nov 2026 16:42:25 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 27/35] pinctrl: renesas: rzg2l: Generalize power source code
Date: Wed, 18 Nov 2026 18:41:38 +0200
Message-ID: <20261118164146.3040784-28-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24990
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 342a7ce6d2f7b13037f0f993ca760779c53834d9 upstream.

The current functions used to get/set the pin power source check the
OTHER_POC register, which is specific to the RZ/G3L SoC only.  To allow
the code to be extended for other power source functionalities (e.g. I3C
on RZ/G3S), generalize the functions used to get/set the pin power
source.

For this, introduce the struct rzg2l_register_masks data structure whose
purpose is to store SoC specific register bit masks.  The members of
this structure are then used in rzg2l_caps_to_pwr_reg() to retrieve the
bitmask corresponding to a SoC specific power source capability.

The conversion between HW specific power source values and SW specific
power source values is now handled through rzg2l_pwr_reg_val_to_ps() and
rzg2l_ps_to_pwr_reg_val().

Finally, to keep the code generic, the register update in
rzg2l_set_power_source() was changed to a read-modify-write approach to
cover all cases.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260904125425.412632-2-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: add simple definition for field_prep()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 183 +++++++++++++++---------
 1 file changed, 115 insertions(+), 68 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 80cb55d84932..3f1ab64097ef 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -187,6 +187,7 @@
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
+#define PVDD_MASK		0x3
=20
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
@@ -215,6 +216,7 @@
 #define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
=20
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
=20
 static const struct pinconf_generic_params renesas_rzv2h_custom_bindings=
[] =3D {
 	{ "renesas,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE=
, 1 },
@@ -273,6 +275,23 @@ struct rzg2l_register_offsets {
 	u16 other_poc;
 };
=20
+/**
+ * struct rzg2l_register_masks - Masks for different RZ/G2L pinctrl func=
tionalities
+ * @other_poc_pvdd1833_oth_awo_poc: PVDD1833_OTH_AWO_POC mask
+ * @other_poc_pvdd1833_oth_iso_poc: PVDD1833_OTH_ISO_POC mask
+ * @other_poc_wdtovf_n_poc: WDTOVF_N_POC mask
+ */
+struct rzg2l_register_masks {
+	union {
+		/* RZ/G3L masks */
+		struct {
+			u8 other_poc_pvdd1833_oth_awo_poc;
+			u8 other_poc_pvdd1833_oth_iso_poc;
+			u8 other_poc_wdtovf_n_poc;
+		};
+	};
+};
+
 /**
  * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
  * @RZG2L_IOLH_IDX_1V8: starting index for 1V8 power source
@@ -293,6 +312,8 @@ enum rzg2l_iolh_index {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @masks: hardware specific masks for various functionalities available=
 in
+ * the registers described by regs
  * @iolh_groupa_ua: IOLH group A uA specific values
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
@@ -306,6 +327,7 @@ enum rzg2l_iolh_index {
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	const struct rzg2l_register_masks masks;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
@@ -1066,29 +1088,74 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pin=
ctrl *pctrl, u32 offset,
 }
=20
 static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs,
-				 u32 caps, u8 *mask)
-{
-	if (caps & PIN_CFG_IO_VMC_SD0)
-		return SD_CH(regs->sd_ch, 0);
-	if (caps & PIN_CFG_IO_VMC_SD1)
-		return SD_CH(regs->sd_ch, 1);
-	if (caps & PIN_CFG_IO_VMC_SD2)
-		return regs->sd_ch2;
-	if (caps & PIN_CFG_IO_VMC_ETH0)
-		return ETH_POC(regs->eth_poc, 0);
-	if (caps & PIN_CFG_IO_VMC_ETH1)
-		return ETH_POC(regs->eth_poc, 1);
-	if (caps & PIN_CFG_IO_VMC_QSPI)
-		return QSPI;
+				 const struct rzg2l_register_masks *masks,
+				 u32 caps, u16 *offset, u8 *mask)
+{
+	*mask =3D PVDD_MASK;
+
+	if (caps & PIN_CFG_IO_VMC_SD0) {
+		*offset =3D SD_CH(regs->sd_ch, 0);
+		return 0;
+	}
+	if (caps & PIN_CFG_IO_VMC_SD1) {
+		*offset =3D SD_CH(regs->sd_ch, 1);
+		return 0;
+	}
+	if (caps & PIN_CFG_IO_VMC_SD2) {
+		*offset =3D regs->sd_ch2;
+		return 0;
+	}
+	if (caps & PIN_CFG_IO_VMC_ETH0) {
+		*offset =3D ETH_POC(regs->eth_poc, 0);
+		return 0;
+	}
+	if (caps & PIN_CFG_IO_VMC_ETH1) {
+		*offset =3D ETH_POC(regs->eth_poc, 1);
+		return 0;
+	}
+	if (caps & PIN_CFG_IO_VMC_QSPI) {
+		*offset =3D regs->qspi;
+		return 0;
+	}
 	if (caps & PIN_CFG_OTHER_POC_MASK) {
+		*offset =3D regs->other_poc;
 		if (caps & PIN_CFG_PVDD1833_OTH_AWO_POC)
-			*mask =3D BIT(0);
+			*mask =3D masks->other_poc_pvdd1833_oth_awo_poc;
 		else if (caps & PIN_CFG_PVDD1833_OTH_ISO_POC)
-			*mask =3D BIT(1);
+			*mask =3D masks->other_poc_pvdd1833_oth_iso_poc;
 		else
-			*mask =3D BIT(2);
+			*mask =3D masks->other_poc_wdtovf_n_poc;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int rzg2l_pwr_reg_val_to_ps(u8 val, u32 caps)
+{
+	switch (val) {
+	case PVDD_1800:
+		return 1800;
+	case PVDD_2500:
+		return 2500;
+	case PVDD_3300:
+		return 3300;
+	}
=20
-		return OTHER_POC;
+	return -EINVAL;
+}
+
+static int rzg2l_ps_to_pwr_reg_val(u32 ps, u32 caps)
+{
+	switch (ps) {
+	case 1800:
+		return PVDD_1800;
+	case 2500:
+		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
+			return -EINVAL;
+		return PVDD_2500;
+	case 3300:
+		return PVDD_3300;
 	}
=20
 	return -EINVAL;
@@ -1098,76 +1165,51 @@ static int rzg2l_get_power_source(struct rzg2l_pi=
nctrl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
-	u8 val, mask;
-	int pwr_reg;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
+	u8 mask, val;
+	u16 offset;
+	int ret;
=20
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
=20
-	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps, &mask);
-	if (pwr_reg < 0)
-		return pwr_reg;
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
+	if (ret)
+		return ret;
=20
-	val =3D readb(pctrl->base + pwr_reg);
-	if (pwr_reg =3D=3D OTHER_POC)
-		val =3D field_get(mask, val);
+	val =3D readb(pctrl->base + offset);
=20
-	switch (val) {
-	case PVDD_1800:
-		return 1800;
-	case PVDD_2500:
-		return 2500;
-	case PVDD_3300:
-		return 3300;
-	default:
-		/* Should not happen. */
-		return -EINVAL;
-	}
+	return rzg2l_pwr_reg_val_to_ps(field_get(mask, val), caps);
 }
=20
 static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, =
u32 caps, u32 ps)
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
-	u8 poc_val, val, mask;
-	int pwr_reg;
+	const struct rzg2l_register_masks *masks =3D &hwcfg->masks;
+	u16 offset;
+	u8 mask;
+	int ret;
=20
 	if (caps & PIN_CFG_SOFT_PS) {
 		pctrl->settings[pin].power_source =3D ps;
 		return 0;
 	}
=20
-	switch (ps) {
-	case 1800:
-		poc_val =3D PVDD_1800;
-		break;
-	case 2500:
-		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
-			return -EINVAL;
-		poc_val =3D PVDD_2500;
-		break;
-	case 3300:
-		poc_val =3D PVDD_3300;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret =3D rzg2l_caps_to_pwr_reg(regs, masks, caps, &offset, &mask);
+	if (ret)
+		return ret;
+
+	ret =3D rzg2l_ps_to_pwr_reg_val(ps, caps);
+	if (ret < 0)
+		return ret;
=20
-	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps, &mask);
-	if (pwr_reg < 0)
-		return pwr_reg;
+	scoped_guard(raw_spinlock_irqsave, &pctrl->lock) {
+		u8 tmp =3D readb(pctrl->base + offset);
=20
-	if (pwr_reg =3D=3D OTHER_POC) {
-		scoped_guard(raw_spinlock_irqsave, &pctrl->lock) {
-			val =3D readb(pctrl->base + pwr_reg);
-			if (poc_val)
-				val |=3D mask;
-			else
-				val &=3D ~mask;
-			writeb(val, pctrl->base + pwr_reg);
-		}
-	} else {
-		writeb(poc_val, pctrl->base + pwr_reg);
+		tmp &=3D ~mask;
+		tmp |=3D field_prep(mask, ret);
+		writeb(tmp, pctrl->base + offset);
 	}
=20
 	pctrl->settings[pin].power_source =3D ps;
@@ -3832,6 +3874,11 @@ static const struct rzg2l_hwcfg rzg3l_hwcfg =3D {
 		.oen =3D 0x3018,
 		.other_poc =3D OTHER_POC,
 	},
+	.masks =3D {
+		.other_poc_pvdd1833_oth_awo_poc =3D BIT(0),
+		.other_poc_pvdd1833_oth_iso_poc =3D BIT(1),
+		.other_poc_wdtovf_n_poc =3D BIT(2),
+	},
 	.iolh_groupa_ua =3D {
 		/* 1v8 power source */
 		[RZG2L_IOLH_IDX_1V8] =3D 2200, 4400, 9000, 10000,
--=20
2.43.0

