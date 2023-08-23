Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CAAEE4993
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 08:42:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7145.1692780147652596419
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 01:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 758AC1C0015; Wed, 23 Aug 2023 10:42:24 +0200 (CEST)
Date: Wed, 23 Aug 2023 10:42:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Message-ID: <ZOXGb3YJEo3jCtQI@duo.ucw.cz>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZLkHg75tYMjt6rhq@duo.ucw.cz>
 <TYWPR01MB87755C152C51606BBB7FC52FC21EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <ZOSKNusPvGn/Huuz@duo.ucw.cz>
 <TYWPR01MB87751FAD44B308A8317216C9C21FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWUoyT02oosqEPQf"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB87751FAD44B308A8317216C9C21FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 08:42:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12834


--SWUoyT02oosqEPQf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Patch "arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC
> > support"
> > > is found in v6.4.
> >=20
> > Aha, let me investigate, it looks like I got confused between
> > different patch series.
> >=20
> > > Could you please apply them?
> >=20
> > They were already reviewed by Nobuhiro-san, let me take another look,
> > test them, and probably apply them with the other batch.
>=20
> Thanks.

Thank you. I added Nobuhiro-san's reviewed-by and pushed the patches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SWUoyT02oosqEPQf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOXGbwAKCRAw5/Bqldv6
8v5eAJ40FMNLuEweUX+9cc4+m4KxT6xinwCdGuVeqq406byLh7aYUdK7CUIRbU0=
=YsVR
-----END PGP SIGNATURE-----

--SWUoyT02oosqEPQf--

