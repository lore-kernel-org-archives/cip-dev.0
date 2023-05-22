Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821DC7EE29
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 20:12:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2265.1684786362994017537
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 13:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D03471C0E50; Mon, 22 May 2023 22:12:39 +0200 (CEST)
Date: Mon, 22 May 2023 22:12:39 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/23] Add RZ/V2M I2C and WDT support
Message-ID: <ZGvMt+KPgXzr16ng@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <17613D7F1DB6F5FD.16124@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g9s7GS6S3dLc761"
Content-Disposition: inline
In-Reply-To: <17613D7F1DB6F5FD.16124@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 May 2023 20:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11586


--+g9s7GS6S3dLc761
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add I2C and WDT support for RZ/V2M EVK platfo=
rm
> >=20
> > Also backported Timer clock and reset entries, Added L2 Cache and System
> > controller nodes.
> >=20
> > All these patches are cherry-picked from the mainline.
>=20
> Thank you for the patches.
>=20
> Let's start with first 11 -- WDC changes. They passed testing and I
> can apply them if there are no other comments.

Now applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+g9s7GS6S3dLc761
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGvMtwAKCRAw5/Bqldv6
8qwYAJ95FY7YLIW1fGAe36zkHh18Cv6XCACdHqHfWgjFmRYKwEW2g6o+uZV3734=
=Ce5H
-----END PGP SIGNATURE-----

--+g9s7GS6S3dLc761--

