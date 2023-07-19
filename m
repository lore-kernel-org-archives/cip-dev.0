Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE94EB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 10:30:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.10710.1689762621478934611
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 03:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A95A51C0A97; Wed, 19 Jul 2023 12:30:18 +0200 (CEST)
Date: Wed, 19 Jul 2023 12:30:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/4] Add PWC support
Message-ID: <ZLe7On5AqlSg0nuM@duo.ucw.cz>
References: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LF6btyFyu7YCqxT"
Content-Disposition: inline
In-Reply-To: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12418


--5LF6btyFyu7YCqxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> this series add PWC support to 6.1.y-cip.
> All the patches are cherry-picked from mainline.

Thanks for the series. It looks okay to me. I can apply it if there
are no other comments and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5LF6btyFyu7YCqxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLe7OgAKCRAw5/Bqldv6
8t55AJ0esuC7Pgpx2/O3J4sd4E1eKXO62QCfZlu659iu6UIIsev0YGC7yksLoVs=
=TGMq
-----END PGP SIGNATURE-----

--5LF6btyFyu7YCqxT--

