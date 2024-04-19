Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7BC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 19:44:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2928.1713555838074041772
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 12:43:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 91EEC1C0080; Fri, 19 Apr 2024 21:43:55 +0200 (CEST)
Date: Fri, 19 Apr 2024 21:43:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/36] Add IA55 interrupt controller support
Message-ID: <ZiLJe38ZgWbYC7P2@duo.ucw.cz>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
 <11c7f37d-d18d-4120-ad04-8efc3dec8305@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIuybT7vijzN4skR"
Content-Disposition: inline
In-Reply-To: <11c7f37d-d18d-4120-ad04-8efc3dec8305@kernel.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 19:44:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15708


--KIuybT7vijzN4skR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Series adds support for Renesas IA55 interrupt controller. The
> > controller is available on RZ/{G2L,GLC,V2L} SoCs.
> >=20
> > All patches are cherry-picked from mainline, except 10/36 "of: platform:
> > Skip populating IRQ to device resource table". Patch 10/36 has been
> > created as a result of discussion at [1].
> >=20
> > Thank you,
>=20
> Hey folks,
>=20
> Please use same tooling as stable is using, so you will produce
> "X-stable: review" header. Or any other header which will allow people
> to filter out huge CIP mailings when using lei/lore, just like we filter
> out the stable ones.

I'm confused, what should such header mean and what would you like to
filter?

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KIuybT7vijzN4skR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiLJewAKCRAw5/Bqldv6
8qjuAJ4yOWSWvpyeChKPGDfzfRrlDYaHOQCfe9bTfB0E/cRmJVkjjbx00YxUuZw=
=nILx
-----END PGP SIGNATURE-----

--KIuybT7vijzN4skR--

