Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EAC48291
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 11:24:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.60847.1707132237650137210
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 03:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C33491C0050; Mon,  5 Feb 2024 12:23:54 +0100 (CET)
Date: Mon, 5 Feb 2024 12:23:54 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
Message-ID: <ZcDFShdKWIuLva4z@duo.ucw.cz>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB63885D88BCDFCDA0E70DE5EE92422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3X8bdCw/qs9PWUEU"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63885D88BCDFCDA0E70DE5EE92422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 11:24:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14667


--3X8bdCw/qs9PWUEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to improve versa3 clock driver.
> >=20
> > All the patches are cherry-picked from the mainline.
> >=20
> > Biju Das (6):
> >   arm64: defconfig: Enable Renesas VersaClock 3 clock generator config
> >   clk: versaclock3: Update vc3_get_div() to avoid divide by zero
> >   clk: versaclock3: Avoid unnecessary padding
> >   clk: versaclock3: Use u8 return type for get_parent() callback
> >   clk: versaclock3: Add missing space between ')' and '{'
> >   clk: versaclock3: Drop ret variable
> >=20
> >  arch/arm64/configs/defconfig  |  1 +
> >  drivers/clk/clk-versaclock3.c | 88
> > ++++++++++++++++-------------------
> >  2 files changed, 41 insertions(+), 48 deletions(-)
>=20
> I reviewed this series, so LGTM.
> I will apply this series, if we have no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, it tests okay, so I applied the series and pushed
it out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3X8bdCw/qs9PWUEU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcDFSgAKCRAw5/Bqldv6
8ubyAJ9YaknZY+kBt4bdWsYgRaJn0xhgaACguK1fw05goPZq+596o+j/4noHLVQ=
=dyvO
-----END PGP SIGNATURE-----

--3X8bdCw/qs9PWUEU--

