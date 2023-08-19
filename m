Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C6EE4993
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 17:01:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13451.1692464482380626856
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Aug 2023 10:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 03A801C0004; Sat, 19 Aug 2023 19:01:19 +0200 (CEST)
Date: Sat, 19 Aug 2023 19:01:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/13] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Message-ID: <ZOD1XrEKl5itYppI@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vbpa0ZqJ73HdJpDA"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Aug 2023 17:01:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12791


--vbpa0ZqJ73HdJpDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add PMIC RAA215300 driver and builtin RTC suppo=
rt
> =20
> All the patches are cherry-picked from the mainline except the last
> 3 patches.
>=20
> The last 3 patches are from next and just added here for testing.

Thanks for the patches, I applied the first 10 to the 6.1-cip.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vbpa0ZqJ73HdJpDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOD1XgAKCRAw5/Bqldv6
8kvyAKC79sDb5HfubQzB0FV40qgkr/HLuQCgk0bPn7750Gq9fTwaEj1b97AgEnU=
=IRkL
-----END PGP SIGNATURE-----

--vbpa0ZqJ73HdJpDA--

