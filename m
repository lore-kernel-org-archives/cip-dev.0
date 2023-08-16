Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B13C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 08:56:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.156834.1692176195549409118
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 01:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B433C1C0006; Wed, 16 Aug 2023 10:56:32 +0200 (CEST)
Date: Wed, 16 Aug 2023 10:56:32 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Message-ID: <ZNyPQG/o1FrzledS@duo.ucw.cz>
References: <20230808095825.136589-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942094BDC5C8FBA0EC632B299212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+zfFvq2bYmBW/nFi"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942094BDC5C8FBA0EC632B299212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 08:56:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12662


--+zfFvq2bYmBW/nFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Replace the below overflow/underflow interrupt names:
> >  - tgiv0->tciv0
> >  - tgiv1->tciv1
> >  - tgiu1->tciu1
> >  - tgiv2->tciv2
> >  - tgiu2->tciu2
> >  - tgiv3->tciv3
> >  - tgiv4->tciv4
> >  - tgiv6->tciv6
> >  - tgiv7->tciv7
> >  - tgiv8->tciv8
> >  - tgiu8->tciu8
> >=20
> > Fixes: 26336d66d021 ("arm64: dts: renesas: r9a07g044: Add MTU3a node")
> > Fixes: dd123dd01def ("arm64: dts: renesas: r9a07g054: Add MTU3a node")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link:
> > https://lore.kernel.org/r/20230724091927.123847-5-biju.das.jz@bp.renesa=
s.c
> > om
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 16 ++++++++--------
> > arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 16 ++++++++--------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> LGTM. I will apply if there are no comments.

Looks good to me, too, and it passes testing, so I applied it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+zfFvq2bYmBW/nFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZNyPQAAKCRAw5/Bqldv6
8ppkAKCvMBLa7mFRY9T3j5UNbAjtvt7u+QCfUbABvyWzuWknLKjmLv5FSRWH7tY=
=3lFg
-----END PGP SIGNATURE-----

--+zfFvq2bYmBW/nFi--

