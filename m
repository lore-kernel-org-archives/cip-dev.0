Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F5C10F05
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 18:03:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.91296.1701972190839999034
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 10:03:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 459261C0080; Thu,  7 Dec 2023 19:03:09 +0100 (CET)
Date: Thu, 7 Dec 2023 19:03:08 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/12]  Add display/dsi/gpt/poeg clk support
Message-ID: <ZXII3AdJ3b3JLKCF@duo.ucw.cz>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
 <TYVPR01MB11245FE499E04243865C3667E928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tdf7aSU6aw98Tz0L"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB11245FE499E04243865C3667E928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 18:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13901


--tdf7aSU6aw98Tz0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (12):
> >   clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
> >   clk: renesas: rzg2l: Add PLL5_4 clk mux support
> >   clk: renesas: rzg2l: Add DSI divider clk support
> >   clk: renesas: r9a07g044: Add M1 clock support
> >   clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
> >   clk: renesas: r9a07g044: Add M3 Clock support
> >   clk: renesas: r9a07g044: Add M4 Clock support
> >   clk: renesas: r9a07g044: Add LCDC clock and reset entries
> >   clk: renesas: r9a07g044: Add DSI clock and reset entries
> >   clk: renesas: r9a07g044: Add GPT clock and reset entry
> >   clk: renesas: r9a07g044: Add POEG clock and reset entries
> >   clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
> >=20
>=20
> I reviewed this series, LGTM.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you. Applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tdf7aSU6aw98Tz0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXII3AAKCRAw5/Bqldv6
8kn7AKDCQHnPDaIlNM30SeridWQFbjW2nACfTtFKPoCiuOzQZl6QDdLM0DI/Dbg=
=TKGE
-----END PGP SIGNATURE-----

--tdf7aSU6aw98Tz0L--

