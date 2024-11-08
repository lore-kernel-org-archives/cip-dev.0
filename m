Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A25D6407A
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 19:13:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1275.1731093197307858225
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 11:13:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DD9161C00A0; Fri,  8 Nov 2024 20:13:13 +0100 (CET)
Date: Fri, 8 Nov 2024 20:13:13 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Message-ID: <Zy5iyaoHh69t9sNW@duo.ucw.cz>
References: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB638880836390C77391267A04925D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1dNoKUV1CvXZuHSt"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638880836390C77391267A04925D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 19:13:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17235


--1dNoKUV1CvXZuHSt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to add (and enable) CRU, CSI support on the Rene=
sas
> > RZ/{G2LC, G2UL} SoCs.
> >=20
> > All the patches have been cherry-picked from upstream.
> >=20
> > v1->v2
> > - Fixed build on RISC-V by moving the enabling of CRU and CSI from
> >   rzg2ul-smarc.dtsi to r9a07g043u11-smarc.dts.
>=20
> I've confirmed that the build issue is fixed. Thanks for your work!
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1533048163

Thank you. I added your reviewed-by from v1, and since it looks ok to
me, too, I applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1dNoKUV1CvXZuHSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZy5iyQAKCRAw5/Bqldv6
8u+PAKC5y96go+T9HPFExQOCXenZKytfQQCgnJgxKrDGgQPJJk0sIhfdQANE87U=
=fgVl
-----END PGP SIGNATURE-----

--1dNoKUV1CvXZuHSt--

