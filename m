Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F4EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 18:27:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.824.1689877668049388052
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 11:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5A3651C0A94; Thu, 20 Jul 2023 20:27:44 +0200 (CEST)
Date: Thu, 20 Jul 2023 20:27:43 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: fabrizio.castro.jz@renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip] pinctrl: renesas: rzv2m: Handle non-unique
 subnode names
Message-ID: <ZLl8nwg80gnuO4RW@duo.ucw.cz>
References: <20230718161639.431910-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94209BD1F4EB07C57774E533923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3Dvjqr5bllB64mF"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94209BD1F4EB07C57774E533923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 18:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12485


--j3Dvjqr5bllB64mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >=20
> > Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio
> > controller driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Link:
> > https://lore.kernel.org/r/607bd6ab4905b0b1b119a06ef953fa1184505777.1688
> > 396717.git.geert+renesas@glider.be
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> Looks good to me. I can apply if there are no comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, it looks okay to me, too, and passed testing, so I applied
it with your Reviewed-by: tag.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--j3Dvjqr5bllB64mF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLl8nwAKCRAw5/Bqldv6
8r3gAJwJSxGx5vHfTpwLQdse8ch4KbmTGwCgjU8ZB96rcSk5Gl29H7FbTvPJMoE=
=ZB2R
-----END PGP SIGNATURE-----

--j3Dvjqr5bllB64mF--

