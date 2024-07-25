Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A540C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 08:10:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31503.1721895013280134132
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 01:10:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EF51D1C0082; Thu, 25 Jul 2024 10:10:10 +0200 (CEST)
Date: Thu, 25 Jul 2024 10:10:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 1/1] Revert "arm64: dts: renesas: rzg2l: Add
 missing cache-level properties"
Message-ID: <ZqIIYuOTQQi6YlVA@duo.ucw.cz>
References: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
 <20240724091240.67115-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bVl+FJZc5xZhzvh0"
Content-Disposition: inline
In-Reply-To: <20240724091240.67115-2-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 08:10:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16620


--bVl+FJZc5xZhzvh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This reverts commit f703a1ddec6a36b67e895921951666e0ffe58c54.
>=20
> It is triggering a warning on linux-6.1.y-cip:
> "cacheinfo: Unable to detect cache hierarchy for CPU 0"
>=20
> Backporting the generic patches may not suitable for
> linux-6.1.y-cip.

Sorry I missed it before. Can I add your signed-off-by: here?

(Not sure it is strictly required for reverts, but...)

Best regards,
							Pavel


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bVl+FJZc5xZhzvh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqIIYgAKCRAw5/Bqldv6
8nqcAJ41h97TAAUiCTm94F0mUdi32ZiXGACggQktXB39/lCIARTl8E7DgKZJZnw=
=QUKq
-----END PGP SIGNATURE-----

--bVl+FJZc5xZhzvh0--

