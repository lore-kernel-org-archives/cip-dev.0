Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79907C433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 10:06:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.17487.1640167593015192662
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 02:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C1711C0B7C; Wed, 22 Dec 2021 11:06:29 +0100 (CET)
Date: Wed, 22 Dec 2021 11:06:28 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Message-ID: <20211222100628.GE15186@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 10:06:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7228


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L SoC.
>=20
> All the patches have been cherry picked from v5.16-rc5.
>=20
> I have created a MR [0] for cip-kernel-config (for testing purpose), which
> can later be merged once this patches have been merged.

And these are various minor nits I noticed while reviewing the code.

Best regards,
								Pavel

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index ef68dabcf4dc3..dacf43ed6d040 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Renesas RZ/G2L combined Pin and GPIO controller
+title: Renesas RZ/G2L combined pin and GPIO controller
=20
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
=20
 description:
-  The Renesas SoCs of the RZ/G2L series feature a combined Pin and GPIO
+  The Renesas SoCs of the RZ/G2L series feature a combined pin and GPIO
   controller.
   Pin multiplexing and GPIO configuration is performed on a per-pin basis.
   Each port features up to 8 pins, each of them configurable for GPIO func=
tion
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ee2872e7d64c6..6946dd0d0485d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -25,7 +25,7 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
=20
-enum  rz_dmac_prep_type {
+enum rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
 };
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 20b2af889ca96..08d0bf139ba3a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -328,7 +328,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *=
pctldev,
 		psel_val[i] =3D MUX_FUNC(value);
 	}
=20
-	/* Register a single pin group listing all the pins we read from DT */
+	/* Register a single pin group, listing all the pins we read from DT */
 	gsel =3D pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux, N=
ULL);
 	if (gsel < 0) {
 		ret =3D gsel;
@@ -612,7 +612,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinct=
rl_dev *pctldev,
 		if (ret)
 			return ret;
=20
-		/* Check config matching between to pin  */
+		/* Check config matching between the pins */
 		if (i && prev_config !=3D *config)
 			return -EOPNOTSUPP;
=20
@@ -886,7 +886,7 @@ static const u32 rzg2l_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
=20
-static  struct rzg2l_dedicated_configs rzg2l_dedicated_pins[] =3D {
+static struct rzg2l_dedicated_configs rzg2l_dedicated_pins[] =3D {
 	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
 	 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
@@ -1109,7 +1109,7 @@ static int rzg2l_pinctrl_probe(struct platform_device=
 *pdev)
 	pctrl->clk =3D devm_clk_get(pctrl->dev, NULL);
 	if (IS_ERR(pctrl->clk)) {
 		ret =3D PTR_ERR(pctrl->clk);
-		dev_err(pctrl->dev, "failed to get GPIO clk : %i\n", ret);
+		dev_err(pctrl->dev, "failed to get GPIO clk: %i\n", ret);
 		return ret;
 	}
=20
@@ -1127,7 +1127,7 @@ static int rzg2l_pinctrl_probe(struct platform_device=
 *pdev)
 				       pctrl->clk);
 	if (ret) {
 		dev_err(pctrl->dev,
-			"failed to register GPIO clk disable action, %i\n",
+			"failed to register GPIO clk disable action: %i\n",
 			ret);
 		return ret;
 	}
@@ -1171,5 +1171,5 @@ static int __init rzg2l_pinctrl_init(void)
 core_initcall(rzg2l_pinctrl_init);
=20
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
-MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/G2L family");
+MODULE_DESCRIPTION("Pin and GPIO controller driver for RZ/G2L family");
 MODULE_LICENSE("GPL v2");


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHC+KQACgkQMOfwapXb+vI0/wCglwWxo/zBEVInGhKy+yt7YEjS
8RwAn0iqkfm3EvL+vcvwABD/Comnig0k
=wm1V
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

