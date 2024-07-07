Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D0EC30653
	for <webhook@archiver.kernel.org>; Sun,  7 Jul 2024 09:17:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.54850.1720343859961646942
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jul 2024 02:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E1FBD1C0099; Sun,  7 Jul 2024 11:17:36 +0200 (CEST)
Date: Sun, 7 Jul 2024 11:17:36 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
Message-ID: <ZopdMJQrneHka8lb@duo.ucw.cz>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JyKRFN1J2XtMk5f0"
Content-Disposition: inline
In-Reply-To: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 07 Jul 2024 09:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16422


--JyKRFN1J2XtMk5f0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add IRQC support to RZ/Five SoC. While at it
> fix build warning for RZ/G2L CPG driver and fix for ax45mp_cache driver.
>=20
> - patches 4/9 and 5/9 have been cherry picked from -next
> - rest of the patches have been cherry picked from v6.10-rc6

I went through the series and it looks okay to me. I can apply it if
it passes testing and if there are no other comments.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JyKRFN1J2XtMk5f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZopdMAAKCRAw5/Bqldv6
8hIiAKCqZPrWEH7yYtET4m3WwOUf9i2kgQCfYUnz2ExrBEgoQX0Fg2HOYOto5jA=
=2kpU
-----END PGP SIGNATURE-----

--JyKRFN1J2XtMk5f0--

