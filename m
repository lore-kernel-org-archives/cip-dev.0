Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1514C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:14:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.34841.1702041271609959448
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5958B1C0080; Fri,  8 Dec 2023 14:14:28 +0100 (CET)
Date: Fri, 8 Dec 2023 14:14:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/18] Add VSPD/FCPVD support
Message-ID: <ZXMWs911OohVcD3o@duo.ucw.cz>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oo1u6GzTc0aRICyw"
Content-Disposition: inline
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:14:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13942


--Oo1u6GzTc0aRICyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add VSPD/FCPVD support on
> RZ/{G2L,G2LC,V2L} SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline.
>=20
> The first patch is to supress build warning with
> i2c_get_match_data().

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Oo1u6GzTc0aRICyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXMWswAKCRAw5/Bqldv6
8ojEAKC/BGqqn/rAE5Y4eShU1kCMTd3mbACeJgC94b9ex2qB6WwGHo5DjFlbG94=
=bsru
-----END PGP SIGNATURE-----

--Oo1u6GzTc0aRICyw--

