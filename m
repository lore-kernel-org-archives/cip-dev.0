Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57B4C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 12:02:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6961.1677067352098752330
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 04:02:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 214951C0AAC; Wed, 22 Feb 2023 13:02:29 +0100 (CET)
Date: Wed, 22 Feb 2023 13:02:28 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Message-ID: <Y/YEVIJ3F5ci70Ak@duo.ucw.cz>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942011DEBBC3C691EA12CEB092A59@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G7hH0b+3ucABrhRX"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942011DEBBC3C691EA12CEB092A59@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 12:02:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10781


--G7hH0b+3ucABrhRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to fix reset issue with watchdog driver and remo=
ve
> > unnecessary check from pinctrl driver for RZ/G2L alike SoCs.
> >=20
> > Biju Das (1):
> >   pinctrl: renesas: rzg2l: remove unnecessary check from
> >     rzg2l_dt_node_to_map()
> >=20
> > Lad Prabhakar (1):
> >   watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
> >=20
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c |  3 +--
> >  drivers/watchdog/rzg2l_wdt.c            | 10 ++++------
> >  2 files changed, 5 insertions(+), 8 deletions(-)
> >=20
> I reviewed this series, LGTM.
> If no opinion, I will apply this series.

Go ahead, it looks good to me and it passed basic testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G7hH0b+3ucABrhRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/YEVAAKCRAw5/Bqldv6
8hygAJ4iAzGsVyw9EDSossLV8uGhF0TEUgCgg7BCHgcMtfpq8s0Mpqxsq1rOJME=
=uTPa
-----END PGP SIGNATURE-----

--G7hH0b+3ucABrhRX--

