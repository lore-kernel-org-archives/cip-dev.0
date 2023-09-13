Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D47CEDEC7E
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 15:51:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.284.1694620300425242931
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 08:51:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D97F81C001A; Wed, 13 Sep 2023 17:51:37 +0200 (CEST)
Date: Wed, 13 Sep 2023 17:51:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/15] Enable MTU3 PWM/Counter support on
 RZ/G2L SMARC
Message-ID: <ZQHaiXjuWW2aLHjL@duo.ucw.cz>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
 <ZQDXwFctYJWJKMHs@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bsea7eBdA5ZV8idx"
Content-Disposition: inline
In-Reply-To: <ZQDXwFctYJWJKMHs@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 15:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13103


--bsea7eBdA5ZV8idx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to enable MTU3 PWM/Counter support on RZ/G2L SMA=
RC EVK.
> >=20
> > The first 2 patches are dma fixes.
> > =20
> > All the patches are cherry-picked from the mainline.
>=20
> Thank you. It looks ok to me, and I can apply it if there are no other
> comments and if it tests ok.

It passed testing so I'm applying / pushing it.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bsea7eBdA5ZV8idx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQHaiQAKCRAw5/Bqldv6
8nuwAJ9o3uu0hr9eyc2qnqnhw4IdttdYPwCfU5jDpSD1JXeGkPlDj4JWdzbzloc=
=5NUj
-----END PGP SIGNATURE-----

--bsea7eBdA5ZV8idx--

