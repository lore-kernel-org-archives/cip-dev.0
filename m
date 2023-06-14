Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF73EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 10:15:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7978.1686737701379882950
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 03:15:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 029191C0D23; Wed, 14 Jun 2023 12:14:59 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:14:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset for
 UART_FCR
Message-ID: <ZImTIqG11bqfsvCp@duo.ucw.cz>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <20230613132339.150671-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0Ik9b1XJUxtXOrV"
Content-Disposition: inline
In-Reply-To: <20230613132339.150671-6-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 10:15:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12005


--B0Ik9b1XJUxtXOrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 59d6558fb5fd750777edfde028ea1f9e7eed8a46 upstream.
>=20
> UART_FCR shares the same offset with UART_IIR. We cannot use UART_FCR
> in serial8250_em_serial_in() as it overlaps with UART_IIR.

I don't follow the argument. AFAICT you could simply define UART_FCR
to UART_IIR, same readl() is used to read both.

Yes, you'd have to add an comment to explain that this is the same
register...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--B0Ik9b1XJUxtXOrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZImTIgAKCRAw5/Bqldv6
8peMAKClMUsgfjDrDJvpJOyEj4jssGY8QQCfabCtnRoSHbH6cpyXikEY72rgWC0=
=nco/
-----END PGP SIGNATURE-----

--B0Ik9b1XJUxtXOrV--

