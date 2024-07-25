Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB9EC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 08:34:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31748.1721896491057048920
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 01:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 90BB91C0082; Thu, 25 Jul 2024 10:34:49 +0200 (CEST)
Date: Thu, 25 Jul 2024 10:34:49 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: paul.barker.ct@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/11] Backport ravb driver improvements
Message-ID: <ZqIOKULhLpz4rZNm@duo.ucw.cz>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
 <OS0PR01MB6388F643074689B3B7F3D1DF92AB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="67fiPpoGLJA0ZGAT"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388F643074689B3B7F3D1DF92AB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 08:34:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16623


--67fiPpoGLJA0ZGAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  drivers/net/ethernet/renesas/ravb.h      |  20 +-
> >  drivers/net/ethernet/renesas/ravb_main.c | 290
> > +++++++++--------------
> >  2 files changed, 119 insertions(+), 191 deletions(-)
>=20
> I reviewed this series, there are no problems.
> I can apply this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I applied it with your Reviewed-by: tag added.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--67fiPpoGLJA0ZGAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqIOKQAKCRAw5/Bqldv6
8qpeAJ91YfGonu+Hka8JqWQuahrfuexilACeOD5M1up60YXyXIPdbHWqY7/z5FM=
=3j/e
-----END PGP SIGNATURE-----

--67fiPpoGLJA0ZGAT--

