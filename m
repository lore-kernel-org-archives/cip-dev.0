Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F19C54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 12:01:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.41652.1710763254364352997
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 05:00:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0A7DC1C007E; Mon, 18 Mar 2024 13:00:52 +0100 (CET)
Date: Mon, 18 Mar 2024 13:00:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: Backporting Renesas IA55 IRQC driver
Message-ID: <Zfgs83wPf6Wp4UcK@duo.ucw.cz>
References: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0X2zmF9dK+hiQEwa"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 12:01:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15352


--0X2zmF9dK+hiQEwa
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

Ok.

> Now we want to backport the IA55 driver to v5.10.209-cip44 (in the first =
instance).
>=20
> At the moment we have 2 working approaches:
> 1/ backport all the work that Prabhakar did (I counted ~80 commits)

No.

> 2/ change the mainline IA55 driver to not use the interrupts bindings
>    to describe the interrupts (see [4] for the mainline approach)
>    but another DT property (we have a working version that uses
>    interrupt-map and interrupt-map-mask) and adapt the
>    rzg2l_irqc_parse_interrupts() to do the proper mapping

We'd rather not.

So... you are converting 80 drivers to newer/better/cleaner API, but
surely there's a way not to do the cleanup and only convert "your"
drivers affected by this?

It may mean passing flag down the callchain saying "hey, I'm new
user", but I believe this should be explored before going with 1/ or
2/.

Please avoid these:

> Legal Disclaimer: This e-mail communication (and any attachment/s) is con=
fidential and contains proprietary information, some or all of which may be=
 legally privileged. It is intended solely for the use of the individual or=
 entity to which it is addressed. Access to this email by anyone else is un=
authorized. If you are not the intended recipient, any disclosure, copying,=
 distribution or any action taken or omitted to be taken in reliance on it,=
 is prohibited and may be unlawful.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0X2zmF9dK+hiQEwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfgs8wAKCRAw5/Bqldv6
8mrYAKCFSJV8HK09sAeyWyPZIJCsOZUXiACgnHFvjjQ1HENAt0vzK5uei4l107c=
=/9YQ
-----END PGP SIGNATURE-----

--0X2zmF9dK+hiQEwa--

