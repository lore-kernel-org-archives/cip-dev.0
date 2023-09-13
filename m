Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C65EDEC5E
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:29:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13547.1694615358807935342
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 07:29:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 21F941C001C; Wed, 13 Sep 2023 16:29:16 +0200 (CEST)
Date: Wed, 13 Sep 2023 16:29:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/12] Enable MTU3 PWM support on RZ/G2L SMARC
Message-ID: <ZQHHOylTSWCK2NGZ@duo.ucw.cz>
References: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3O3aObHRaYtxgrY"
Content-Disposition: inline
In-Reply-To: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 14:29:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13100


--R3O3aObHRaYtxgrY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to enable MTU3 PWM support on RZ/G2L SMARC EVK.
> =20
> All the patches are cherry-picked from the mainline.
>=20
> This patch series depend upon [1]
> [1] https://lore.kernel.org/cip-dev/20230911144702.948246-1-biju.das.jz@b=
p.renesas.com/T/#t

Thank you, this passed the testing so I'm pushing this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--R3O3aObHRaYtxgrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQHHOwAKCRAw5/Bqldv6
8rv6AKCo5l0Kr+EqYtGe/ejU/dkBLcMbEACdGvZiclwlkS5U3wTtAPgran4zCNA=
=4gL2
-----END PGP SIGNATURE-----

--R3O3aObHRaYtxgrY--

