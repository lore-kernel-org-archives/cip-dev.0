Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB2EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:06:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9431.1689847582082057551
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:06:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3BDA41C0A94; Thu, 20 Jul 2023 12:06:18 +0200 (CEST)
Date: Thu, 20 Jul 2023 12:06:17 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: fabrizio.castro.jz@renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Chris.Paterson2@renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/4] Add PWC support
Message-ID: <ZLkHGdCcnSUwcGgB@duo.ucw.cz>
References: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94202AFAD6CE40BB9C74EF96923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0B1IJOygpGqLUB3c"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94202AFAD6CE40BB9C74EF96923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:06:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12460


--0B1IJOygpGqLUB3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Fabrizio Castro (4):
> >   dt-bindings: soc: renesas: Add RZ/V2M PWC
> >   soc: renesas: Add PWC support for RZ/V2M
> >   arm64: dts: renesas: r9a09g011: Add PWC support
> >   arm64: dts: renesas: v2mevk2: Add PWC support
> >=20
>=20
> I reviewed this series, LGTM. I can apply if there are no comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

I had patches ready in my tree, so I applied and pushed them.

Thanks!
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0B1IJOygpGqLUB3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLkHGQAKCRAw5/Bqldv6
8mWkAKCXiK7+vAbaUv6E8FM3JWf26gHifwCgmhxpWIhXXxx6TLyABv28DQhiSXM=
=pI2p
-----END PGP SIGNATURE-----

--0B1IJOygpGqLUB3c--

