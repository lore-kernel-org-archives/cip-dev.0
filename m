Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A4FEE3F35
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 21:24:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2351.1694553870476124444
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 14:24:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B6D201C001B; Tue, 12 Sep 2023 23:24:27 +0200 (CEST)
Date: Tue, 12 Sep 2023 23:24:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/12] Enable MTU3 PWM support on RZ/G2L SMARC
Message-ID: <ZQDXCw6L9KH5OrE+@duo.ucw.cz>
References: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0FwnKkt9Lqgl6vyD"
Content-Disposition: inline
In-Reply-To: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 21:24:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13092


--0FwnKkt9Lqgl6vyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to enable MTU3 PWM support on RZ/G2L SMARC EVK.
> =20
> All the patches are cherry-picked from the mainline.

Series looks okay to me, I can apply it if there are no other comments
and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0FwnKkt9Lqgl6vyD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQDXCwAKCRAw5/Bqldv6
8rbiAJ437MkQENBNNg8lNduinnt3hjA7RgCfd/78mTUbhd8EPRUKiodQUYUI+dc=
=ADU1
-----END PGP SIGNATURE-----

--0FwnKkt9Lqgl6vyD--

