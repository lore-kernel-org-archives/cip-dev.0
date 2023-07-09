Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0974AEB64DC
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 11:19:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15271.1688901570985716115
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Jul 2023 04:19:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 384B91C0AB3; Sun,  9 Jul 2023 13:19:27 +0200 (CEST)
Date: Sun, 9 Jul 2023 13:19:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Message-ID: <ZKqXvkVO1zhYNIjH@duo.ucw.cz>
References: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tSMSU/+ciuxm+0Lg"
Content-Disposition: inline
In-Reply-To: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 11:19:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12277


--tSMSU/+ciuxm+0Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.
>=20
> Currently {modprobe, bind} after {rmmod, unbind} results in probe failure.
>=20
> genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004 (=
85070400.usb3drd)
> renesas_usb3: probe of 85070000.usb3peri failed with error -16
>=20
> The reason is, it is trying to register an interrupt handler for the same
> IRQ twice. The devm_request_irq() was called with the parent device.
> So the interrupt handler won't be unregistered when the usb3-peri device
> is unbound.
>=20
> Fix this issue by replacing "parent dev"->"dev" as the irq resource
> is managed by this driver.

Thank you, applied.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tSMSU/+ciuxm+0Lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKqXvgAKCRAw5/Bqldv6
8ny3AJ9SxTUUg7ee8uWclQz3h/2DY4viXwCfap27LKWjxiFFQKfdfr66okYl83g=
=68Aw
-----END PGP SIGNATURE-----

--tSMSU/+ciuxm+0Lg--

