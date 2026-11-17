Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15813.1794916019077254172
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8070063445;
	Tue, 17 Nov 2026 11:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1640C1F000C4;
	Tue, 17 Nov 2026 11:46:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 38/69] pinctrl: renesas: rzg2l: Generalize power source code
Date: Tue, 17 Nov 2026 13:45:22 +0200
Message-ID: <20261117114553.1484215-39-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24879
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
[claudiu.beznea:
- kept rzg2l_caps_to_pwr_reg() variant from the backported patch and
  dropped SD2, OTHER_POC specific code, along with masks argument (since
  this is not yet used in this patch)
- fixed conflict in rzg2l_get_power_source() by keeping the patch code
- fixed conflict in rzg2l_set_power_source() by keeping the patch code an=
d
  using raw_spin_{lock,unlock}_irq{save,restore}()
- dropped rzg3l code from conflict
- dropped struct rzg2l_register_masks since it is not yet used]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 130 +++++++++++++++---------
 1 file changed, 83 insertions(+), 47 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 559064dcc09b..74544067912e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -126,6 +126,7 @@
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
+#define PVDD_MASK		0x3
=20
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
@@ -834,37 +835,37 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinct=
rl *pctrl, u32 offset,
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
=20
-static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs, u32 caps)
+static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *re=
gs,
+				 u32 caps, u16 *offset, u8 *mask)
 {
-	if (caps & PIN_CFG_IO_VMC_SD0)
-		return SD_CH(regs->sd_ch, 0);
-	if (caps & PIN_CFG_IO_VMC_SD1)
-		return SD_CH(regs->sd_ch, 1);
-	if (caps & PIN_CFG_IO_VMC_ETH0)
-		return ETH_POC(regs->eth_poc, 0);
-	if (caps & PIN_CFG_IO_VMC_ETH1)
-		return ETH_POC(regs->eth_poc, 1);
-	if (caps & PIN_CFG_IO_VMC_QSPI)
-		return regs->qspi;
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
=20
 	return -EINVAL;
 }
=20
-static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, =
u32 caps)
+static int rzg2l_pwr_reg_val_to_ps(u8 val, u32 caps)
 {
-	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
-	int pwr_reg;
-	u8 val;
-
-	if (caps & PIN_CFG_SOFT_PS)
-		return pctrl->settings[pin].power_source;
-
-	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps);
-	if (pwr_reg < 0)
-		return pwr_reg;
-
-	val =3D readb(pctrl->base + pwr_reg);
 	switch (val) {
 	case PVDD_1800:
 		return 1800;
@@ -872,43 +873,78 @@ static int rzg2l_get_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 		return 2500;
 	case PVDD_3300:
 		return 3300;
-	default:
-		/* Should not happen. */
-		return -EINVAL;
 	}
+
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
+	}
+
+	return -EINVAL;
+}
+
+static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, =
u32 caps)
+{
+	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	u8 mask, val;
+	u16 offset;
+	int ret;
+
+	if (caps & PIN_CFG_SOFT_PS)
+		return pctrl->settings[pin].power_source;
+
+	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	if (ret)
+		return ret;
+
+	val =3D readb(pctrl->base + offset);
+
+	return rzg2l_pwr_reg_val_to_ps(field_get(mask, val), caps);
 }
=20
 static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, =
u32 caps, u32 ps)
 {
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
-	int pwr_reg;
-	u8 val;
+	unsigned long flags;
+	u8 mask, tmp;
+	u16 offset;
+	int ret;
=20
 	if (caps & PIN_CFG_SOFT_PS) {
 		pctrl->settings[pin].power_source =3D ps;
 		return 0;
 	}
=20
-	switch (ps) {
-	case 1800:
-		val =3D PVDD_1800;
-		break;
-	case 2500:
-		val =3D PVDD_2500;
-		break;
-	case 3300:
-		val =3D PVDD_3300;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret =3D rzg2l_caps_to_pwr_reg(regs, caps, &offset, &mask);
+	if (ret)
+		return ret;
+
+	ret =3D rzg2l_ps_to_pwr_reg_val(ps, caps);
+	if (ret < 0)
+		return ret;
=20
-	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps);
-	if (pwr_reg < 0)
-		return pwr_reg;
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	tmp =3D readb(pctrl->base + offset);
+	tmp &=3D ~mask;
+	tmp |=3D field_prep(mask, ret);
+	writeb(tmp, pctrl->base + offset);
+
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
=20
-	writeb(val, pctrl->base + pwr_reg);
 	pctrl->settings[pin].power_source =3D ps;
=20
 	return 0;
--=20
2.43.0

