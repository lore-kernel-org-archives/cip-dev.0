Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769FEB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 14:01:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.324.1689084085042416763
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 07:01:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 769ED1C0E53; Tue, 11 Jul 2023 16:01:22 +0200 (CEST)
Date: Tue, 11 Jul 2023 16:01:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Message-ID: <ZK1gseNTIrqEeyyS@duo.ucw.cz>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB87756342112FB5A35D4D93C6C231A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xxKHb2cUcQi7Id7o"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB87756342112FB5A35D4D93C6C231A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 14:01:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12306


--xxKHb2cUcQi7Id7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I reviewed the patch and found no issues.
> > I can apply, if there are no comments and issues.
>=20
> I think this series is safe to apply, as no issues have been highlighted
> from the reviews.

Thank you, applied.

I'm not aware of any other patches in the pipeline; if there's
anything I am missing, let me know.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xxKHb2cUcQi7Id7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZK1gsQAKCRAw5/Bqldv6
8mkkAKC4RqhXagKlo7y+GZ6VFytmTthPvgCgjeQxoDEVpLu08ImvpSDp/sjUMIo=
=7nxr
-----END PGP SIGNATURE-----

--xxKHb2cUcQi7Id7o--

