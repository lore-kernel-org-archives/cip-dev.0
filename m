Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02268C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:05:35 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.36362.1745316332332545440
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 03:05:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QUMQD06L;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF0AA102A8C97;
	Tue, 22 Apr 2025 12:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745316330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=npFfVT3gFEfkiEygJdy1CfCfB7r0OPhRtV9i5M6fDWM=;
	b=QUMQD06LAWeL9J/iZngbTukK8lQtldsjyBtXrCGe8gGEWpx1L5hqFJIAKEBQi/h/7ey5s8
	tUcqaYwaipWzXPxmzsmAz0oHNRUPtKsBBlZ6VpL3/9HcNlwgijxTfY6jyYFWQ+a2mLNJP/
	CATzWv88hcHUjk9a8cN+Xn+H+BZQTf5eYd/mIJwXE3iP0FLh4oOrXG9aYk8Kxgs8o9Ot9k
	RPak1Kr1tdi+gTiKabhJcXfHfRBwlyJbuoplOvT2/sVRMwtPxVlax4j42Q5pe/6jt6N3T0
	gFDNaZlg+vX1g5ND8Wxb7KYd9WiLteRyWaL484/zSlrX8s7zZiTENwBDxWW7rQ==
Date: Tue, 22 Apr 2025 12:05:26 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Message-ID: <aAdp5jO3LmPfci7Z@duo.ucw.cz>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUJTCVN8xA10Z3AM"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 10:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18545


--UUJTCVN8xA10Z3AM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > Claudiu Beznea (1):
> >   clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable
> >=20
> > Lad Prabhakar (1):
> >   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
> >=20
> > Paul Barker (1):
> >   clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
> >=20
> >  drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
> > drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >=20
> >=20
> > base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc
>=20
> I reviewed this series and 5.10.y, looks good to me.
> I can apply this, if there are no other comments.
>=20
> Test:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1778885=
218
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1778885=
853
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks ok to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UUJTCVN8xA10Z3AM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAdp5gAKCRAw5/Bqldv6
8mruAJ4/Y1HFghCpOS2+2R04SLZlGSUWQQCeITOc7OPTJZUk5xXp4iZKAf9zRkE=
=FJTg
-----END PGP SIGNATURE-----

--UUJTCVN8xA10Z3AM--

