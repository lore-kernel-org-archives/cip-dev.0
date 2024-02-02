Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B469C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:45:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.20824.1706874345680691844
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:45:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B0451C0075; Fri,  2 Feb 2024 12:45:42 +0100 (CET)
Date: Fri, 2 Feb 2024 12:45:41 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
Message-ID: <ZbzV5bNL9qwCmQca@duo.ucw.cz>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C2i4a4t5k7XxR+nZ"
Content-Disposition: inline
In-Reply-To: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14622


--C2i4a4t5k7XxR+nZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to improve versa3 clock driver.
>=20
> All the patches are cherry-picked from the mainline.

Series looks okay to me, I can apply it if there are no other comments
and if it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C2i4a4t5k7XxR+nZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbzV5QAKCRAw5/Bqldv6
8jOmAKCp3LDrN5gFYujdf3gkKvZLLR2QBQCeI5+xUpueED7xVyPR6fqBN31+ugk=
=HDV+
-----END PGP SIGNATURE-----

--C2i4a4t5k7XxR+nZ--

