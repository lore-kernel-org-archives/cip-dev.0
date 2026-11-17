Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15816.1794916021007089550
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15FE56344D;
	Tue, 17 Nov 2026 11:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B91F000C4;
	Tue, 17 Nov 2026 11:46:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 39/69] pinctrl: renesas: rzg2l: Unify power source handling
Date: Tue, 17 Nov 2026 13:45:23 +0200
Message-ID: <20261117114553.1484215-40-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24880
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5e1e9d0cd8f366cedac88b7463126da989704e35 upstream.

The previous code handled power sources using a mixture of power
source specific definitions and lookups in the available_ps[] array.
Unify the power source handling by introducing struct
rzg2l_pinctrl_ps_desc, whose purpose is to describe a power source
through its power source value, associated register value, associated
capabilities (e.g. Ethernet), and associated IOLH index.

Introduce two new functions, rzg2l_ps_to_desc() and
rzg2l_pwr_reg_val_to_desc(), using the
RZG2L_PINCTRL_PS_DESC_MEMBER_TO_DESC_FUNC() macro, as their
implementations are similar.

These functions retrieve a power source descriptor based on either a
power source value or a power source register value.  Other functions
that need to perform power source specific operations can call them to
retrieve the corresponding power source descriptor.

The register values for the soft power sources were kept to zero since
they are not used across the driver's code.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260904125425.412632-4-claudiu.beznea+ren=
esas@tuxon.dev
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
- dropped PIN_CFG_IO_VMC_SD2
- dropped AWO, ISO, WDTOVF voltage domains
- declare i outside of for loop to avoid errors like: 'for' loop initial
  declarations are only allowed in C99 or C11 mode"]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 148 +++++++++++++++---------
 1 file changed, 94 insertions(+), 54 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 74544067912e..ed2ecde9ec07 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -123,9 +123,6 @@
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define ETH_MODE		(0x3018)
=20
-#define PVDD_2500		2	/* I/O domain voltage 2.5V */
-#define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
-#define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
 #define PVDD_MASK		0x3
=20
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
@@ -190,12 +187,14 @@ struct rzg2l_register_offsets {
=20
 /**
  * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_NA: index N/A (to be used for error checking)
  * @RZG2L_IOLH_IDX_1V8: starting index for 1V8 power source
  * @RZG2L_IOLH_IDX_2V5: starting index for 2V5 power source
  * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
  * @RZG2L_IOLH_IDX_MAX: maximum index
  */
 enum rzg2l_iolh_index {
+	RZG2L_IOLH_IDX_NA =3D -1,
 	RZG2L_IOLH_IDX_1V8 =3D 0,
 	RZG2L_IOLH_IDX_2V5 =3D 4,
 	RZG2L_IOLH_IDX_3V3 =3D 8,
@@ -324,7 +323,71 @@ struct rzg2l_pinctrl {
 	atomic_t			wakeup_path;
 };
=20
-static const u16 available_ps[] =3D { 1800, 2500, 3300 };
+/**
+ * struct rzg2l_pinctrl_ps_desc - RZ/G2L power source descriptor
+ * @caps: Capabilities that applies to the power source
+ * @iolh_index: IOLH index
+ * @ps: Power source value
+ * @pwr_reg_val: Power source register value
+ */
+struct rzg2l_pinctrl_ps_desc {
+	u32 caps;
+	enum rzg2l_iolh_index iolh_index;
+	u16 ps;
+	u16 pwr_reg_val;
+};
+
+#define RZG2L_PINCTRL_PS_DESC(_ps, _pwr_reg_val, _caps, _iolh_index) \
+	{ \
+		.ps =3D _ps, \
+		.pwr_reg_val =3D _pwr_reg_val, \
+		.caps =3D _caps, \
+		.iolh_index =3D _iolh_index, \
+	}
+
+static const struct rzg2l_pinctrl_ps_desc available_ps[] =3D {
+	/* Ethernet I/O voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1800, 1, PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH=
1,
+			      RZG2L_IOLH_IDX_1V8),
+	RZG2L_PINCTRL_PS_DESC(2500, 2, PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH=
1,
+			      RZG2L_IOLH_IDX_2V5),
+	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH=
1,
+			      RZG2L_IOLH_IDX_3V3),
+
+	/* SD I/O voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1800, 1, PIN_CFG_IO_VMC_SD0 | PIN_CFG_IO_VMC_SD1,
+			      RZG2L_IOLH_IDX_1V8),
+	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_IO_VMC_SD0 | PIN_CFG_IO_VMC_SD1,
+			      RZG2L_IOLH_IDX_3V3),
+
+	/* QSPI I/O voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1800, 1, PIN_CFG_IO_VMC_QSPI, RZG2L_IOLH_IDX_1V8)=
,
+	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_IO_VMC_QSPI, RZG2L_IOLH_IDX_3V3)=
,
+
+	/* Software voltage domains */
+	RZG2L_PINCTRL_PS_DESC(1800, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_1V8),
+	RZG2L_PINCTRL_PS_DESC(2500, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_2V5),
+	RZG2L_PINCTRL_PS_DESC(3300, 0, PIN_CFG_SOFT_PS, RZG2L_IOLH_IDX_3V3),
+};
+
+#define RZG2L_PINCTRL_PS_DESC_MEMBER_TO_DESC_FUNC(_name, _desc_member, _=
caps)	\
+static const struct rzg2l_pinctrl_ps_desc *_name(u16 _desc_member, u32 _=
caps)	\
+{										\
+	unsigned int i;								\
+										\
+	for (i =3D 0; i < ARRAY_SIZE(available_ps); i++) {			\
+		if (available_ps[i]._desc_member !=3D _desc_member)		\
+			continue;						\
+										\
+		if (available_ps[i].caps & _caps)				\
+			return &available_ps[i];				\
+	}									\
+										\
+	return NULL;								\
+}
+
+RZG2L_PINCTRL_PS_DESC_MEMBER_TO_DESC_FUNC(rzg2l_ps_to_desc, ps, caps)
+RZG2L_PINCTRL_PS_DESC_MEMBER_TO_DESC_FUNC(rzg2l_pwr_reg_val_to_desc, pwr=
_reg_val, caps)
=20
 #ifdef CONFIG_RISCV
 static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctr=
l,
@@ -864,34 +927,26 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l=
_register_offsets *regs,
 	return -EINVAL;
 }
=20
-static int rzg2l_pwr_reg_val_to_ps(u8 val, u32 caps)
+static int rzg2l_pwr_reg_val_to_ps(u16 pwr_reg_val, u32 caps)
 {
-	switch (val) {
-	case PVDD_1800:
-		return 1800;
-	case PVDD_2500:
-		return 2500;
-	case PVDD_3300:
-		return 3300;
-	}
+	const struct rzg2l_pinctrl_ps_desc *desc;
=20
-	return -EINVAL;
+	desc =3D rzg2l_pwr_reg_val_to_desc(pwr_reg_val, caps);
+	if (!desc)
+		return -EINVAL;
+
+	return desc->ps;
 }
=20
-static int rzg2l_ps_to_pwr_reg_val(u32 ps, u32 caps)
+static int rzg2l_ps_to_pwr_reg_val(u16 ps, u32 caps)
 {
-	switch (ps) {
-	case 1800:
-		return PVDD_1800;
-	case 2500:
-		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
-			return -EINVAL;
-		return PVDD_2500;
-	case 3300:
-		return PVDD_3300;
-	}
+	const struct rzg2l_pinctrl_ps_desc *desc;
=20
-	return -EINVAL;
+	desc =3D rzg2l_ps_to_desc(ps, caps);
+	if (!desc)
+		return -EINVAL;
+
+	return desc->pwr_reg_val;
 }
=20
 static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, =
u32 caps)
@@ -950,32 +1005,11 @@ static int rzg2l_set_power_source(struct rzg2l_pin=
ctrl *pctrl, u32 pin, u32 caps
 	return 0;
 }
=20
-static bool rzg2l_ps_is_supported(u16 ps)
-{
-	unsigned int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(available_ps); i++) {
-		if (available_ps[i] =3D=3D ps)
-			return true;
-	}
-
-	return false;
-}
-
-static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps)
+static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps, u32 caps)
 {
-	unsigned int i;
+	const struct rzg2l_pinctrl_ps_desc *desc =3D rzg2l_ps_to_desc(ps, caps)=
;
=20
-	for (i =3D 0; i < ARRAY_SIZE(available_ps); i++) {
-		if (available_ps[i] =3D=3D ps)
-			break;
-	}
-
-	/*
-	 * We multiply with RZG2L_IOLH_MAX_DS_ENTRIES as we have
-	 * RZG2L_IOLH_MAX_DS_ENTRIES DS values per power source
-	 */
-	return i * RZG2L_IOLH_MAX_DS_ENTRIES;
+	return desc ? desc->iolh_index : RZG2L_IOLH_IDX_NA;
 }
=20
 static u16 rzg2l_iolh_val_to_ua(const struct rzg2l_hwcfg *hwcfg, u32 cap=
s, u8 val)
@@ -1236,7 +1270,11 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctr=
l_dev *pctldev,
 		ret =3D rzg2l_get_power_source(pctrl, _pin, cfg);
 		if (ret < 0)
 			return ret;
-		iolh_idx =3D rzg2l_ps_to_iolh_idx(ret);
+
+		iolh_idx =3D rzg2l_ps_to_iolh_idx(ret, cfg);
+		if (iolh_idx =3D=3D RZG2L_IOLH_IDX_NA)
+			return -EINVAL;
+
 		val =3D rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
 		arg =3D rzg2l_iolh_val_to_ua(hwcfg, cfg, iolh_idx + val);
 		break;
@@ -1376,8 +1414,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
=20
 	/* Apply power source. */
 	if (settings.power_source !=3D pctrl->settings[_pin].power_source) {
-		ret =3D rzg2l_ps_is_supported(settings.power_source);
-		if (!ret)
+		if (!rzg2l_ps_to_desc(settings.power_source, cfg))
 			return -EINVAL;
=20
 		/* Apply power source. */
@@ -1391,7 +1428,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctr=
l_dev *pctldev,
 		enum rzg2l_iolh_index iolh_idx;
 		int val;
=20
-		iolh_idx =3D rzg2l_ps_to_iolh_idx(settings.power_source);
+		iolh_idx =3D rzg2l_ps_to_iolh_idx(settings.power_source, cfg);
+		if (iolh_idx =3D=3D RZG2L_IOLH_IDX_NA)
+			return -EINVAL;
+
 		ret =3D rzg2l_ds_is_supported(pctrl, cfg, iolh_idx,
 					    settings.drive_strength_ua);
 		if (!ret)
--=20
2.43.0

