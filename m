Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B3CC3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 16:09:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14795.1721837336022939703
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 09:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 868DF1C0082; Wed, 24 Jul 2024 18:08:53 +0200 (CEST)
Date: Wed, 24 Jul 2024 18:08:53 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/1] Revert "Add missing cache-level
 properties"
Message-ID: <ZqEnFWeyatlT4ZfX@duo.ucw.cz>
References: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jeAIykrUGe0jAbP"
Content-Disposition: inline
In-Reply-To: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 16:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16613


--8jeAIykrUGe0jAbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The patch series revert the commit f703a1ddec6a ("arm64: dts: renesas:
> rzg2l: Add missing cache-level properties") as it is triggering a warning
> on linux-6.1.y-cip "cacheinfo: Unable to detect cache hierarchy for CPU 0"
>=20
> The the proper fix needs backporting generic/architecture-specific changes
> to support the "cache-level" in device tree.
>=20
> Mainline patch[1]-[5] fixes the warning message, but there is drop in
> ethernet rx performance on RZ/G2L SoCs and also triggers another warning
> message "Early cacheinfo failed, ret =3D -2" on RZ/G2{H,M,N,E} family
>=20
> patch [6]->[9] fixes the above  warning message. Still we left out with
> ethernet rx performance on RZ/G2L SoCs, which needs backporting further
> patches.
> Since [1]->[9] impacts all architectures, it is better not to backport
> these patches on linux-6.1.y-cip.

Ok, this looks like reasonable solution. I can apply it if it passes
testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8jeAIykrUGe0jAbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqEnFQAKCRAw5/Bqldv6
8pXeAJ0RNfhlyoYk+NjvxwpjXOqMQzYmTgCgtsVp9jEG1zBKqI6Rc9YhTFr8T38=
=IE7+
-----END PGP SIGNATURE-----

--8jeAIykrUGe0jAbP--

