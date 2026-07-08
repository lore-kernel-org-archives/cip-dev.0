Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E654C43602
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3718.1783498326838495191
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 377926001A;
	Wed,  8 Jul 2026 08:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C081F000E9;
	Wed,  8 Jul 2026 08:12:04 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 03/22] reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
Date: Wed,  8 Jul 2026 11:11:40 +0300
Message-ID: <20260708081159.3882514-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23509

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 78f2d64e484753bfede6a0e9eab0ef35830c34fb upstream.

On the Renesas RZ/G3S SoC, the USB PHY block has an input signal called
PWRRDY. This signal is managed by the system controller and must be
de-asserted after powering on the area where USB PHY resides and asserted
before powering it off.

On power-on/resume the USB PWRRDY signal need to be de-asserted before
enabling clock and switching the module to normal state (through MSTOP
support). The power-on/resume configuration sequence must be:

1/ PWRRDY=3D0
2/ CLK_ON=3D1
3/ MSTOP=3D0

On power-off/suspend the configuration sequence should be:

1/ MSTOP=3D1
2/ CLK_ON=3D0
3/ PWRRDY=3D1

The CLK_ON and MSTOP functionalities are controlled by clock drivers.
The suspend/resume support will be handled by different patches.

After long discussions with the internal HW team, it has been confirmed
that the HW connection b/w USB PHY block, the USB channels, the system
controller, clock, MSTOP, PWRRDY signal is as follows:

                               =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
                               =E2=94=82                              =E2=
=94=82=E2=97=84=E2=94=80=E2=94=80 CPG_CLKON_USB.CLK0_ON
                               =E2=94=82     USB CH0                  =E2=
=94=82
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90   =E2=94=82=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=
 =E2=94=82=E2=97=84=E2=94=80=E2=94=80 CPG_CLKON_USB.CLK2_ON
=E2=94=82                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =E2=94=82=E2=94=82host contr=
oller registers  =E2=94=82 =E2=94=82
=E2=94=82                 =E2=94=82        =E2=94=82   =E2=94=82=E2=94=82=
function controller registers=E2=94=82
=E2=94=82                 =E2=94=82 PHY0   =E2=94=82=E2=97=84=E2=94=80=E2=
=94=80=E2=94=A4=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82
=E2=94=82     USB PHY     =E2=94=82        =E2=94=82   =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
=E2=94=82                 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98                =E2=94=82
=E2=94=82                          =E2=94=82    CPG_BUS_PERI_COM_MSTOP.MS=
TOP{6, 5}_ON
=E2=94=82=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
=E2=94=82=E2=94=82USHPHY control=E2=94=82 =E2=94=82        =E2=94=82
=E2=94=82=E2=94=82  registers   =E2=94=82 =E2=94=82 PHY1   =E2=94=82   =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=82        =E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=A4     US=
B CH1                  =E2=94=82
=E2=94=82                 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=82=E2=94=8C=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90 =E2=94=82=E2=97=84=E2=94=80=E2=94=80 CPG_CLKON_USB.CLK1_O=
N
=E2=94=94=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98   =E2=94=82=E2=94=82 host controller register=
s =E2=94=82 =E2=94=82
  =E2=94=82       =E2=94=82         =E2=94=82          =E2=94=82=E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98 =E2=94=82
  =E2=94=82       =E2=94=82         =E2=94=82          =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
  =E2=94=82       =E2=94=82         =E2=94=82                       =E2=94=
=82
  =E2=94=82       =E2=94=82         =E2=94=82           CPG_BUS_PERI_COM_=
MSTOP.MSTOP7_ON
  =E2=94=82PWRRDY =E2=94=82         =E2=94=82
  =E2=94=82       =E2=94=82   CPG_CLK_ON_USB.CLK3_ON
  =E2=94=82       =E2=94=82
  =E2=94=82  CPG_BUS_PERI_COM_MSTOP.MSTOP4_ON
  =E2=94=82
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82SYSC=E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

where:
- CPG_CLKON_USB.CLK.CLKX_ON is the register bit controlling the clock X
  of different USB blocks, X in {0, 1, 2, 3}
- CPG_BUS_PERI_COM_MSTOP.MSTOPX_ON is the register bit controlling the
  MSTOP of different USB blocks, X in {4, 5, 6, 7}
- USB PHY is the USB PHY block exposing 2 ports, port0 and port1, used
  by the USB CH0, USB CH1
- SYSC is the system controller block controlling the PWRRDY signal
- USB CHx are individual USB block with host and function capabilities
  (USB CH0 have both host and function capabilities, USB CH1 has only
  host capabilities)

The USBPHY control registers are controlled though the
reset-rzg2l-usbphy-ctrl driver. The USB PHY ports are controlled by
phy_rcar_gen3_usb2 (drivers/phy/renesas/phy-rcar-gen3-usb2.c file). The
USB PHY ports request resets from the reset-rzg2l-usbphy-ctrl driver.

The connection b/w the system controller and the USB PHY CTRL driver is
implemented through the renesas,sysc-pwrrdy device tree property
proposed in this patch. This property specifies the register offset and t=
he
bitmask required to control the PWRRDY signal.

Since the USB PHY CTRL driver needs to be probed before any other
USB-specific driver on RZ/G3S, control of PWRRDY is passed exclusively
to it. This guarantees the correct configuration sequence between clocks,
MSTOP bits, and the PWRRDY bit on probe/resume and remove/suspend. At the
same time, changes are kept minimal by avoiding modifications to the USB
PHY driver to also handle the PWRRDY itself.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/reset/Kconfig                   |  1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 56 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index e7ff064709cb..a4884e16df0b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -191,6 +191,7 @@ config RESET_RASPBERRYPI
 config RESET_RZG2L_USBPHY_CTRL
 	tristate "Renesas RZ/G2L USBPHY control driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select MFD_SYSCON
 	help
 	  Support for USBPHY Control found on RZ/G2L family. It mainly
 	  controls reset and power down of the USB/PHY.
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 255c894a4782..aac947dc467b 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -13,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
=20
 #define RESET			0x000
 #define VBENCTL			0x03c
@@ -91,6 +92,8 @@ static int rzg2l_usbphy_ctrl_status(struct reset_contro=
ller_dev *rcdev,
 	return !!(readl(priv->base + RESET) & port_mask);
 }
=20
+#define RZG2L_USBPHY_CTRL_PWRRDY	1
+
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] =3D {
 	{ .compatible =3D "renesas,rzg2l-usbphy-ctrl" },
 	{ /* Sentinel */ }
@@ -110,6 +113,55 @@ static const struct regmap_config rzg2l_usb_regconf =
=3D {
 	.max_register =3D 1,
 };
=20
+static void rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap_field *pwrrdy,
+					 bool power_on)
+{
+	u32 val =3D power_on ? 0 : 1;
+
+	/* The initialization path guarantees that the mask is 1 bit long. */
+	regmap_field_update_bits(pwrrdy, 1, val);
+}
+
+static void rzg2l_usbphy_ctrl_pwrrdy_off(void *data)
+{
+	rzg2l_usbphy_ctrl_set_pwrrdy(data, false);
+}
+
+static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
+{
+	struct regmap_field *pwrrdy;
+	struct reg_field field;
+	struct regmap *regmap;
+	const int *data;
+	u32 args[2];
+
+	data =3D device_get_match_data(dev);
+	if ((uintptr_t)data !=3D RZG2L_USBPHY_CTRL_PWRRDY)
+		return 0;
+
+	regmap =3D syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "renesas,sysc-pwrrdy",
+						      ARRAY_SIZE(args), args);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Don't allow more than one bit in mask. */
+	if (hweight32(args[1]) !=3D 1)
+		return -EINVAL;
+
+	field.reg =3D args[0];
+	field.lsb =3D __ffs(args[1]);
+	field.msb =3D __fls(args[1]);
+
+	pwrrdy =3D devm_regmap_field_alloc(dev, regmap, field);
+	if (!pwrrdy)
+		return -ENOMEM;
+
+	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
+
+	return devm_add_action_or_reset(dev, rzg2l_usbphy_ctrl_pwrrdy_off, pwrr=
dy);
+}
+
 static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -132,6 +184,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_d=
evice *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
=20
+	error =3D rzg2l_usbphy_ctrl_pwrrdy_init(dev);
+	if (error)
+		return error;
+
 	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
--=20
2.43.0


