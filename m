Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C2EB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:13:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8742.1687432422638982033
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D71511C0AB3; Thu, 22 Jun 2023 13:13:38 +0200 (CEST)
Date: Thu, 22 Jun 2023 13:13:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Message-ID: <ZJQs4hqSSX2mU4ZF@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsRjF1EpOl46m8zn"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:13:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12117


--FsRjF1EpOl46m8zn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add MTU3 core/counter driver support for RZ/G2L=
 alike
> SoCs.
>=20
> All these patches are cherry-picked from the mainline.

I went through my comments again, and I guess they are better solved
in the mainline. There were no other comments, and patches pass the
testing, so I applied them.

Best regards, and sorry for the delay,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FsRjF1EpOl46m8zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZJQs4gAKCRAw5/Bqldv6
8mGWAJ9iNC83d85x3XS2rptRO4JJXk4xtgCeKnqzk205lSvB0b5y/okLfjcCx88=
=Yb2X
-----END PGP SIGNATURE-----

--FsRjF1EpOl46m8zn--

