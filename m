Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE0C77B7C
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 18:55:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13319.1684695350238258074
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 May 2023 11:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8F27A1C0AAC; Sun, 21 May 2023 20:55:47 +0200 (CEST)
Date: Sun, 21 May 2023 20:55:47 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/23]  Add RZ/V2M I2C and WDT support
Message-ID: <ZGppM6tG20J40PDK@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKLzTFxzM9J49ECe"
Content-Disposition: inline
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 18:55:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11581


--LKLzTFxzM9J49ECe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add I2C and WDT support for RZ/V2M EVK platform
>=20
> Also backported Timer clock and reset entries, Added L2 Cache and System
> controller nodes.
>=20
> All these patches are cherry-picked from the mainline.

Thank you for the patches.

Let's start with first 11 -- WDC changes. They passed testing and I
can apply them if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LKLzTFxzM9J49ECe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGppMwAKCRAw5/Bqldv6
8iWBAKCPKpaVJ94Hh0fYJCXq+dcqceZSCgCgsBYVA1lutJjtPngFGJjFk+9RVd4=
=5mR8
-----END PGP SIGNATURE-----

--LKLzTFxzM9J49ECe--

