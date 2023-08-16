Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474C9C001DF
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 09:38:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.157268.1692178716708621325
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 02:38:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0B1071C0006; Wed, 16 Aug 2023 11:38:34 +0200 (CEST)
Date: Wed, 16 Aug 2023 11:38:33 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Message-ID: <ZNyZGQ+dLPmO3Utl@duo.ucw.cz>
References: <20230808092849.32139-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94205434034D19DD563A8A9B9212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B5+IIYYS1HpO2OC8"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94205434034D19DD563A8A9B9212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 09:38:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12663


--B5+IIYYS1HpO2OC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

Thank you for the patches, I applied them.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--B5+IIYYS1HpO2OC8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZNyZGQAKCRAw5/Bqldv6
8hJqAKCBI/UQ7R9A5xvY7RQ6kX5eBp9u0QCcDcg/MiuRe/m37oYTGpHlZ96XL/4=
=IU9V
-----END PGP SIGNATURE-----

--B5+IIYYS1HpO2OC8--

