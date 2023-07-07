Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEEBEB64D9
	for <webhook@archiver.kernel.org>; Fri,  7 Jul 2023 15:49:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.157.1688744975649440219
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jul 2023 08:49:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DA21E1C0ABB; Fri,  7 Jul 2023 17:49:31 +0200 (CEST)
Date: Fri, 7 Jul 2023 17:49:31 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: fabrizio.castro.jz@renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Chris.Paterson2@renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Message-ID: <ZKg0CxYHByaAo3VG@duo.ucw.cz>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BxUvoCHA3oTkdddF"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jul 2023 15:49:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12276


--BxUvoCHA3oTkdddF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Fabrizio Castro (4):
> >   dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
> >   mmc: renesas_sdhi: Add RZ/V2M compatible string
> >   arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
> >   arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
> >=20
> > Phil Edworthy (1):
> >   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
> >=20
>=20
> I reviewed the patch and found no issues.
> I can apply, if there are no comments and issues.
>=20
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919=
945015
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

There's an extra empty line in 2/5, but that's too minor detail to be
worth fixing.

Reviewed-by: Pavel Machek <pavel@denx.de>

We'll need similar series for 6.1, AFAICT.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BxUvoCHA3oTkdddF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKg0CwAKCRAw5/Bqldv6
8gN6AKCCAmNml0W9yGqfuWhi1XAC3L6+ZACgn/c14cVoQ/lGEP8yCER86ReWQ5w=
=55xn
-----END PGP SIGNATURE-----

--BxUvoCHA3oTkdddF--

