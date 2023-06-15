Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B3EB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 08:27:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13330.1686817660349703256
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 01:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D3D5D1C0E65; Thu, 15 Jun 2023 10:27:38 +0200 (CEST)
Date: Thu, 15 Jun 2023 10:27:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset for
 UART_FCR
Message-ID: <ZIrLeqKXeOmi9R62@duo.ucw.cz>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <20230613132339.150671-6-biju.das.jz@bp.renesas.com>
 <ZImTIqG11bqfsvCp@duo.ucw.cz>
 <OS0PR01MB59225C000B638ED14D74E10F865AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WaIJJsIbs55sqmif"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225C000B638ED14D74E10F865AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 08:27:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12042


--WaIJJsIbs55sqmif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset =
for
> > UART_FCR
> >=20
> > Hi!
> >=20
> > > commit 59d6558fb5fd750777edfde028ea1f9e7eed8a46 upstream.
> > >
> > > UART_FCR shares the same offset with UART_IIR. We cannot use UART_FCR
> > > in serial8250_em_serial_in() as it overlaps with UART_IIR.
> >=20
> > I don't follow the argument. AFAICT you could simply define UART_FCR to
> > UART_IIR, same readl() is used to read both.
>=20
> See https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ser=
ial_reg.h#L53
>=20
> UART_FCR=3D2 and UART_IIR=3D2
>=20
> On reality from IP point, it is @0xC and @0x08.

Aha, thanks for explanation. So on some hardware IIR and FCR share the
same register, but not on yours?

It would be better if serial core provided different defines for the
two registers, as current situation is quite confusing.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WaIJJsIbs55sqmif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIrLegAKCRAw5/Bqldv6
8twQAJ9VjsSskMahD+Dq0oD/0Cc44gQ7DgCghZSsNQfOZbs2ew6KWWyCG/e1cvA=
=Xnw5
-----END PGP SIGNATURE-----

--WaIJJsIbs55sqmif--

