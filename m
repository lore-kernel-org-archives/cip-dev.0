Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBCEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 11:34:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.10669.1689852837024563871
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 04:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 41B4C1C0A94; Thu, 20 Jul 2023 13:33:52 +0200 (CEST)
Date: Thu, 20 Jul 2023 13:33:51 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Message-ID: <ZLkbnxzQEXD6mt7q@duo.ucw.cz>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942068546B387A153DB9EDE0923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="upgbmjtR/4OYyWv+"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB942068546B387A153DB9EDE0923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 11:34:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12464


--upgbmjtR/4OYyWv+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Lad Prabhakar (1):
> >   arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
> >=20
>=20
> I reviewed this series, LGTM. I can apply if there are no comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I applied patches that are mainline and pushed
results out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--upgbmjtR/4OYyWv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLkbnwAKCRAw5/Bqldv6
8hG/AJ4jOVHsXVOscCIVfGREW3/3Ei4dlQCgh1vfutOrcUSzmrak4p9V+76I7UM=
=9sdL
-----END PGP SIGNATURE-----

--upgbmjtR/4OYyWv+--

