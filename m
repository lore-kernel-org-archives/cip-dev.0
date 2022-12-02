Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CDC4167B
	for <webhook@archiver.kernel.org>; Fri,  2 Dec 2022 10:33:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.71957.1669977191115686760
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Dec 2022 02:33:12 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 307A81C09FE; Fri,  2 Dec 2022 11:33:08 +0100 (CET)
Date: Fri, 2 Dec 2022 11:33:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: pavel@denx.de, cip-dev@lists.cip-project.org, uli@fpond.eu,
	Peter Foley <pefoley2@pefoley.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND][PATCH for 4.4.y] extcon: adc-jack: Fix incompatible
 pointer type warning
Message-ID: <Y4nUYx9A0A1Mi4A8@duo.ucw.cz>
References: <20221201001903.1695510-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27CFhY/mZC6g8u1I"
Content-Disposition: inline
In-Reply-To: <20221201001903.1695510-1-nobuhiro1.iwamatsu@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Dec 2022 10:33:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10160


--27CFhY/mZC6g8u1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Peter Foley <pefoley2@pefoley.com>
>=20
> commit 8a522bf2d4f788306443d36b26b54f0aedcdfdbe upstream.
>=20
> This patch fixes the incompatible warning of extcon-adc-jack.c driver
> when calling devm_extcon_dev_allocate().
>=20
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> [cw00.choi: Modify the patch title and descritpion]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied to 4.4-cip.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--27CFhY/mZC6g8u1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4nUYwAKCRAw5/Bqldv6
8gOVAJ44ZCBESG/YTb4Br5wvqleMBJfj1ACgoNBaMphOfDGGWZYbttHJbmiQ/hc=
=tIkE
-----END PGP SIGNATURE-----

--27CFhY/mZC6g8u1I--

