Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17987EB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 17:53:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3913.1689875603644929928
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 10:53:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1E0B01C0CAF; Thu, 20 Jul 2023 19:53:20 +0200 (CEST)
Date: Thu, 20 Jul 2023 19:53:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Message-ID: <ZLl0jyHulqBdQ99x@duo.ucw.cz>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XXsqwYU8/OaAWBLI"
Content-Disposition: inline
In-Reply-To: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 17:53:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12484


--XXsqwYU8/OaAWBLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> MTU3 core and PWM driver.
>=20
> All the patches are cherry-picked from the mainline
> except patch#11-patch#13. The trivial patches#11-#13 are
> cherry-picked from next.
>=20
> v1->v2:
>  * Add WARN_ON for rz_mtu3_pwm_get_state() in patch#8 as suggested by pav=
el.

Thank you for the update. It passed testing, so I applied mainline
parts of the series to 5.10. I added Iwamatsu-san's reviewed-by tag
=66rom the previous iteration.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XXsqwYU8/OaAWBLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLl0jwAKCRAw5/Bqldv6
8pccAKCHTi13F4qmmuJgc1qFPNiS0YJfLwCZAYFjzXg5GcTuuQq5UqRosfdVPjc=
=81NE
-----END PGP SIGNATURE-----

--XXsqwYU8/OaAWBLI--

