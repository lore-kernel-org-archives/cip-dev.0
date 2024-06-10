Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CCC27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 21:26:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31888.1718054787618409884
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jun 2024 14:26:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F381B1C0099; Mon, 10 Jun 2024 23:26:25 +0200 (CEST)
Date: Mon, 10 Jun 2024 23:26:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/19] Add suspend to RAM support for pin and
 IA55 IRQ controllers
Message-ID: <ZmdvgdE0A0f/go/b@duo.ucw.cz>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PaDyEBzLHnjhLO+H"
Content-Disposition: inline
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jun 2024 21:26:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16185


--PaDyEBzLHnjhLO+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series adds suspend to RAM support for PIN and IA55 IRQ controller.
> Support is needed for RZ/G3S SoC.
>=20
> Along with it pin controller and IA55 interrupt controller drivers
> were updated with enhancements.
>=20
> Series is split as follows:
> - patch 01:      add clock and reset support for IA55 IRQ controller on
>                  RZ/G3S
> - patches 02-08: update the pin controller driver with fixes for spurious
>                  interrupts when pin controller interrupt lines are routed
>                  to IA55 IRQ controller
> - patch 09:      add suspend to RAM support for pinctrl driver
> - patch 10:      add suspend to RAM support for IA55 IRQ controler
> - patches 11-14: documentation patches
> - patches 15-19: update the device tree with IA55, gpio keys, PSCI
>                  support

Thanks for the series. It looks pretty similar to 6.1 version.

I noticed "pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and
IRQ_DOMAIN_HIERARCHY" is missing from this version, should we have it,
too?

I can apply it if it passes testing and if there are no other
comments.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PaDyEBzLHnjhLO+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmdvgQAKCRAw5/Bqldv6
8mvsAJ916m8t6wvjBVHvWJtzqde8jqpGzgCgsdk2qcDk+Fag2M9tFlMJhnsBRvs=
=SnvM
-----END PGP SIGNATURE-----

--PaDyEBzLHnjhLO+H--

