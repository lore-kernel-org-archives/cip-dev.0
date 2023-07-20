Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D9EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:08:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9466.1689847685397952481
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A81141C0A94; Thu, 20 Jul 2023 12:08:03 +0200 (CEST)
Date: Thu, 20 Jul 2023 12:08:03 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: fabrizio.castro.jz@renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Chris.Paterson2@renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Message-ID: <ZLkHg75tYMjt6rhq@duo.ucw.cz>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjtVT62BZevOCobd"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12461


--PjtVT62BZevOCobd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Phil Edworthy (1):
> >   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
>=20
> I reviewed this series, LGTM. I can apply if there are no comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review. I applied and pushed first 3 patches, I believe
last 3 need to be in mainline, first.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PjtVT62BZevOCobd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLkHgwAKCRAw5/Bqldv6
8pvcAJ9n/7WYGDZCEy5Qx4m2oFFtHQbwRgCfYcNfH6Xt5RgYl8PyLW5TK6dszqU=
=aa1P
-----END PGP SIGNATURE-----

--PjtVT62BZevOCobd--

