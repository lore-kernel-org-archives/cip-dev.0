Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD61C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:11:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.32701.1713708690715595655
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CEE1F1C0080; Sun, 21 Apr 2024 16:11:26 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:11:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavel Machek <pavel@denx.de>, Claudiu <claudiu.beznea@tuxon.dev>,
	nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/36] Add IA55 interrupt controller support
Message-ID: <ZiUejtwUYcdfRVoj@duo.ucw.cz>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
 <11c7f37d-d18d-4120-ad04-8efc3dec8305@kernel.org>
 <ZiLJe38ZgWbYC7P2@duo.ucw.cz>
 <ad85fa92-5b70-4b47-83c0-a2d307538934@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YxnhaOZHVEwaLYV0"
Content-Disposition: inline
In-Reply-To: <ad85fa92-5b70-4b47-83c0-a2d307538934@kernel.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15710


--YxnhaOZHVEwaLYV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Please use same tooling as stable is using, so you will produce
> >> "X-stable: review" header. Or any other header which will allow people
> >> to filter out huge CIP mailings when using lei/lore, just like we filt=
er
> >> out the stable ones.
> >=20
> > I'm confused, what should such header mean and what would you like to
> > filter?
>=20
> Meaning would be the same as in stable process. Why CIP is doing this
> differently?
>=20
> What we all are filtering? Emails from stable and CIP. It's way too
> much. Many of us have several filters on lei for specific paths in
> kernel, because lei successfully allows to replace the MAINTAINER entry.
> stable and CIP postings are picked up by such filters, because they
> touch the same paths. And it's not  just one email, it's entire thread,
> like 200 patches from stable. CIP is somehow smaller but still.
> Therefore the filter has AND NOT for mentioned header - I can nicely
> remove all stable postings which I am not interested at all.

Why not simply ignore everything on cip-dev? We have rule that
everything applied to -cip has to be upstream first.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YxnhaOZHVEwaLYV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUejgAKCRAw5/Bqldv6
8lyHAJ9v9VJ/GLkRfHg81pdTfreVbjzA0QCgn/lcq4pQqBE8XoP+4rpX5PIldlA=
=0quq
-----END PGP SIGNATURE-----

--YxnhaOZHVEwaLYV0--

