Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC38C54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:12:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.42224.1710763950321595747
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:12:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F00221C007D; Mon, 18 Mar 2024 13:12:27 +0100 (CET)
Date: Mon, 18 Mar 2024 13:12:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: Backporting Renesas IA55 IRQC driver
Message-ID: <Zfgvq46kKNklD/tK@duo.ucw.cz>
References: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kgcNtvqN9e4J6Csk"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:12:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15353


--kgcNtvqN9e4J6Csk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm trying to backport the IA55 IRQC driver [1] to v5.10.209-cip44.
>=20
> The controller is connected to GIC and pin controller as follows:
>=20
>                                           =E2=94=8C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                                           =E2=94=82          =E2=94=82 SP=
IX     =E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=9C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=82   =
       =E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=82   =
       =E2=94=82          =E2=94=82
>                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90IRQ0-7        =E2=94=82  IA55    =E2=94=
=82          =E2=94=82  GIC     =E2=94=82
>      Pin0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=
=82
>                   =E2=94=82        =E2=94=82              =E2=94=82      =
    =E2=94=82 PPIY     =E2=94=82          =E2=94=82
>      ...          =E2=94=82  GPIO  =E2=94=82              =E2=94=82      =
    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82          =E2=94=82
>                   =E2=94=82        =E2=94=82GPIOINT0-127  =E2=94=82      =
    =E2=94=82          =E2=94=82          =E2=94=82
>      PinN =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=
=82
>                   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98              =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>=20
> While working on mainline driver, my colleague, Prabhakar, found that the=
re
> are issues with this kind of hierarchy due to
> platform_get_resource(pdev, IORESOURCE_IRQ, ...) which relies on static
> allocation of IRQ resources in DT core code causing issues
> when using hierarchical interrupt domains with "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>=20
> As a result he run a cleanup campaign in mainline kernel and changed
> drivers from using platform_get_resource(pdev, IORESOURCE_IRQ, ...)
> to platform_get_irq(pdev, ...) (see list here [2]) and at the submitting =
[3].
>=20
> Now we want to backport the IA55 driver to v5.10.209-cip44 (in the first =
instance).
>=20
> At the moment we have 2 working approaches:
> 1/ backport all the work that Prabhakar did (I counted ~80 commits)
> 2/ change the mainline IA55 driver to not use the interrupts bindings
>    to describe the interrupts (see [4] for the mainline approach)
>    but another DT property (we have a working version that uses
>    interrupt-map and interrupt-map-mask) and adapt the
>    rzg2l_irqc_parse_interrupts() to do the proper mapping

So I'm suggesting 3/:

Replace a1a2b7125e1079cfcc13a116aa3af3df2f9e002b with something like

and then arrange new_style_board to be set on machines you converted
but nowhere else. Best would be passing that information down the
callchain somehow, but you use have global variable or even config
option...

Best regards,
								Pavel

+++ b/drivers/of/platform.c
@@ -114,35 +114,31 @@ struct platform_device *of_device_alloc(struct device=
_node *np,
 				  struct device *parent)
 {
 	struct platform_device *dev;
	int rc, i, num_reg =3D 0, num_irq;
 	struct resource *res, temp_res;
=20
 	dev =3D platform_device_alloc("", PLATFORM_DEVID_NONE);
 	if (!dev)
 		return NULL;
=20
	/* count the io and irq resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) =3D=3D 0)
 		num_reg++;
	num_irq =3D of_irq_count(np);
	if (new_style_board)
	   num_irq =3D 0;
=20
 	/* Populate the resource table */
	if (num_irq || num_reg) {
		res =3D kcalloc(num_irq + num_reg, sizeof(*res), GFP_KERNEL);
 		if (!res) {
 			platform_device_put(dev);
 			return NULL;
 		}
=20
		dev->num_resources =3D num_reg + num_irq;
 		dev->resource =3D res;
 		for (i =3D 0; i < num_reg; i++, res++) {
 			rc =3D of_address_to_resource(np, i, res);
 			WARN_ON(rc);
 		}
+		if (num_irq)	=09
		    if (of_irq_to_resource_table(np, res, num_irq) !=3D num_irq)
			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
				 np);
 	}
=20
 	dev->dev.of_node =3D of_node_get(np);

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kgcNtvqN9e4J6Csk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfgvqwAKCRAw5/Bqldv6
8p85AJ9XxkogpdB7U6C9qWCwPNbDucqV4gCeOEbIFlIOAjUc4mbugUS2BJf1PII=
=L13U
-----END PGP SIGNATURE-----

--kgcNtvqN9e4J6Csk--

