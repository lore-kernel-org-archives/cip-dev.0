Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B3EE49AE
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 08:43:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7159.1692780206606693119
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 01:43:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A48991C0019; Wed, 23 Aug 2023 10:43:24 +0200 (CEST)
Date: Wed, 23 Aug 2023 10:43:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/15] RZ/G2{L,UL} Improvements
Message-ID: <ZOXGrM4HW1PL3na+@duo.ucw.cz>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
 <ZOR1XcetJSzqlGzK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2BBu4h4kkGUPHps+"
Content-Disposition: inline
In-Reply-To: <ZOR1XcetJSzqlGzK@duo.ucw.cz>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 08:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12835


--2BBu4h4kkGUPHps+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series add improvements to RZ/G2{L,UL} SMARC EVKs.
> > All the patches are cherry-picked from mainline.
>=20
> Thanks for patches. They look ok to me, and I can apply them provided
> they pass testing and there are no other comments.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2BBu4h4kkGUPHps+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOXGrAAKCRAw5/Bqldv6
8iajAKCbOuF60EF2ggXsjOb1uZjTcw5HSgCgkKgRzLswayEq8TYazlLxaWaSVyg=
=aRhx
-----END PGP SIGNATURE-----

--2BBu4h4kkGUPHps+--

