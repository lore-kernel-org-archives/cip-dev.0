Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E4CC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 08:02:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.131425.1700812926847806882
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 00:02:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 261DB1C0072; Fri, 24 Nov 2023 09:02:03 +0100 (CET)
Date: Fri, 24 Nov 2023 09:02:02 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/3] Document MTU3 IP on RZ/{G2UL,Five} SoCs
Message-ID: <ZWBYeowe/acslk+j@duo.ucw.cz>
References: <20231122165106.235838-1-biju.das.jz@bp.renesas.com>
 <TYVPR01MB11245431B2A5A261AC451179292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X5O/lB4bV7d1obfl"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB11245431B2A5A261AC451179292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 08:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13712


--X5O/lB4bV7d1obfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Biju Das (3):
> >   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
> >     names
> >   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
> >   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
> >=20
> >  .../bindings/timer/renesas,rz-mtu3.yaml       | 67
> > ++++++++++---------
> >  1 file changed, 34 insertions(+), 33 deletions(-)
>=20
> I reviewed this series, LGTM. I can apply this series.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for the review, I applied the series and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--X5O/lB4bV7d1obfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWBYegAKCRAw5/Bqldv6
8qfVAJ0cn/glyzpqKb9Ta5L3Fshc/hUH1gCePAoegr2SVPX3l6p2cG7PHkoxuV4=
=4s6D
-----END PGP SIGNATURE-----

--X5O/lB4bV7d1obfl--

