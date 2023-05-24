Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A533CC7EE23
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 07:43:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3572.1684914229917429535
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 00:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 37CB01C0DFE; Wed, 24 May 2023 09:43:47 +0200 (CEST)
Date: Wed, 24 May 2023 09:43:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 14/23] PM: core: Add new *_PM_OPS macros,
 deprecate old ones
Message-ID: <ZG3AMpZFzOjtWzVT@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-15-biju.das.jz@bp.renesas.com>
 <ZGf0bB94Ugj2sQ36@duo.ucw.cz>
 <OS0PR01MB592279CFAE4F7FC03C7414E1867D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGy9adIV+qjSXZBg@duo.ucw.cz>
 <OS0PR01MB5922E0B4751229CF74A545E886409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2HNEjbSp5XkGmzc"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922E0B4751229CF74A545E886409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 07:43:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11626


--f2HNEjbSp5XkGmzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I believe it would be less intrusive to make i2c driver work w/o core
> > changes.
>=20
> What is your suggestion for adding RZ/V2M driver support 5.10.y-cip?
>=20
> Modify the original mainline driver by using the available PM macros in 5=
=2E10.y-cip ?

This is the preferred option.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--f2HNEjbSp5XkGmzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZG3AMgAKCRAw5/Bqldv6
8nQ9AJwM82D9kJOqh2jPzvLuLsltXiq7RQCgpdRUBeEWbkXz+aKwohMV7gZ9yJo=
=zvCP
-----END PGP SIGNATURE-----

--f2HNEjbSp5XkGmzc--

