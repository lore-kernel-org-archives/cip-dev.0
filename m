Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB25C4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 22:11:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11838.1701814262230217382
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Dec 2023 14:11:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E5D411C006F; Tue,  5 Dec 2023 23:10:58 +0100 (CET)
Date: Tue, 5 Dec 2023 23:10:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/5] Drop WDT2 support from RZ/G2L family
Message-ID: <ZW+f8m6g4AyT9Cp1@duo.ucw.cz>
References: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5NtS6+UA3P6TCtnj"
Content-Disposition: inline
In-Reply-To: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Dec 2023 22:11:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13792


--5NtS6+UA3P6TCtnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to drop WDT2 support from G2L family of SoCs and
> along with SPI1 pinmux movement.
>=20
> All the patches have been cherry-picked from upstream kernel.

The patches also seem to be in 6.1.x. Good.

They are really simple, and look good to me, so I can apply them if
they pass testing and if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5NtS6+UA3P6TCtnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZW+f8gAKCRAw5/Bqldv6
8o9IAKCLCHvJDnK5v0zCSg3MVbDspdGNEgCfd94o7AmcQMrbTApvBc//hpvkAS8=
=n2FB
-----END PGP SIGNATURE-----

--5NtS6+UA3P6TCtnj--

