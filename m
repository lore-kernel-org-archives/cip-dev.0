Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA1C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 08:52:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4123.1686041531015901409
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 01:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1833E1C0CAF; Tue,  6 Jun 2023 10:52:08 +0200 (CEST)
Date: Tue, 6 Jun 2023 10:52:07 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
Message-ID: <ZH7zt/NrohkDl6Y2@duo.ucw.cz>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942086A48D86FFF4117256C79252A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="961AL6M1UYOThJRt"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942086A48D86FFF4117256C79252A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 08:52:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11851


--961AL6M1UYOThJRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (7):
> >   tty: serial: sh-sci: Fix TE setting on SCI IP
> >   tty: serial: sh-sci: Add support for tx end interrupt handling
> >   tty: serial: sh-sci: Fix end of transmission on SCI
> >   tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based
> >     on DMA direction
> >   tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
> >   tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
> >   arm64: dts: renesas: rzg2ul-smarc: Enable SCI0
> >=20
> >  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  26 ++++
> >  drivers/tty/serial/sh-sci.c                   | 111
> > ++++++++++++++----
> >  drivers/tty/serial/sh-sci.h                   |   3 +
> >  3 files changed, 117 insertions(+), 23 deletions(-)
> >=20
>=20
> I reviewed this series, there were no issues.
> I can apply, if there are no other comments and issues.
>=20
> Reviewed-by Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I tested the series, added you reviewed-by tag
(with added :) and pushed the changes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--961AL6M1UYOThJRt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH7ztwAKCRAw5/Bqldv6
8imyAJ4q6ZkLcy15pR42hOi8Ni6fa8FGKQCfUFhl1RAhY7kL//BPrZHPHpqZ5rc=
=64eB
-----END PGP SIGNATURE-----

--961AL6M1UYOThJRt--

