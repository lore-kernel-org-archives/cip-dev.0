Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4FE77179
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 20:18:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.46770.1733516289600414665
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 12:18:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3BAE71C00A0; Fri,  6 Dec 2024 21:18:06 +0100 (CET)
Date: Fri, 6 Dec 2024 21:18:05 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Message-ID: <Z1Nb/R3VOXJlMVj1@duo.ucw.cz>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zJA7zjC7MAzsjloS"
Content-Disposition: inline
In-Reply-To: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 20:18:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17369


--zJA7zjC7MAzsjloS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable
> it on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
> platforms.
>=20
> All the patches have been cherry picked from upstream kernel apart from
> patch 1/8.

Series looks ok to me. I can apply it, if it passes testing and there
are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zJA7zjC7MAzsjloS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1Nb/QAKCRAw5/Bqldv6
8hFqAKCpJku+osgGpGLLArgnkv59LN4cawCeNyl/LN6G9IQf4PTBVaUhzV3joNQ=
=kuGx
-----END PGP SIGNATURE-----

--zJA7zjC7MAzsjloS--

