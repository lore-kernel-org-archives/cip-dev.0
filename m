Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB4DC54E67
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 12:03:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.35743.1711540979099708806
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 05:02:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 929A11C007E; Wed, 27 Mar 2024 13:02:57 +0100 (CET)
Date: Wed, 27 Mar 2024 13:02:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/36] Add IA55 interrupt controller support
Message-ID: <ZgQK8Jypy91yS6as@duo.ucw.cz>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OEGrYlUS5SF56cj+"
Content-Disposition: inline
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 12:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15469


--OEGrYlUS5SF56cj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series adds support for Renesas IA55 interrupt controller. The
> controller is available on RZ/{G2L,GLC,V2L} SoCs.
>=20
> All patches are cherry-picked from mainline, except 10/36 "of: platform:
> Skip populating IRQ to device resource table". Patch 10/36 has been
> created as a result of discussion at [1].

I'll have some minor comments for the patch 11/ (but that can be fixed
post-merge). Yes, 10/ is quite "interesting" but I believe it is
better than alternatives.

I can take the patch if there are no other comments and if it passes
testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OEGrYlUS5SF56cj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgQK8AAKCRAw5/Bqldv6
8lhdAJ9xHNBKv6cadTGlGwJsgvfp6RiCIACbB1sWL41xaYE6o45v4e+xqgnamog=
=qgoT
-----END PGP SIGNATURE-----

--OEGrYlUS5SF56cj+--

