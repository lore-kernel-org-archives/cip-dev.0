Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F5AC369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:16:24 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.36519.1745316979822635853
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 03:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Z7P2Gj3H;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5DC1102A8C9C;
	Tue, 22 Apr 2025 12:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745316978;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=Gum1czny1lqLcvUtQw8VObcrjRqZBtI1MCID+t3lm8Y=;
	b=Z7P2Gj3HckCFHW6ygnjrZrjr/gqr9XdOs72LQq/u4VClCJHTu4B9frI4sUroJgWzuC8o+u
	hAVAK6ndhdYiSRL46dI7v996+KZoH63rxxxnOIs7RfdCqv7GngGxYS1xEqEATVqWi40j5D
	Nj0BMlAyavjLRanMD4bSh7WXL0eSP/+q/zJMjM0t6GBz3dECQkbFeclX2AJSVElzOldz1p
	APjpXvvUnMj7Ui001DCM6vjzg50jQP1nejgx34bECmtvweSOmPGhfy+GmU45gHDpikTRq9
	t+xVOboXNd6KEFe2eXe9VvZwjfJH4HuvW9FD0jp6Y0pYRRV2ATSnhiWHboV9tw==
Date: Tue, 22 Apr 2025 12:16:14 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix
 clock source
Message-ID: <aAdsbh8ihhKaaMeg@duo.ucw.cz>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <18389BF521EE6C81.21966@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XEJxduhoH8yVH58u"
Content-Disposition: inline
In-Reply-To: <18389BF521EE6C81.21966@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 10:16:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18547


--XEJxduhoH8yVH58u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Claudiu Beznea (1):
> > >   clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable
> > >=20
> > > Lad Prabhakar (1):
> > >   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
> > >=20
> > > Paul Barker (1):
> > >   clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
> > >=20
> > >  drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
> > > drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
> > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > >=20
> > >=20
> > > base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc
> >=20
> > I reviewed this series and 5.10.y, looks good to me.
> > I can apply this, if there are no other comments.
> >=20
> > Test:
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/17788=
85218
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/17788=
85853
> >=20
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks ok to me, too.

> Reviewed-by: Pavel Machek <pavel@denx.de>

Patches are okay, but we should wait for 6.12 "clk: renesas:
r9a07g043: Fix HP clock source for RZ/Five" before applying this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XEJxduhoH8yVH58u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAdsbgAKCRAw5/Bqldv6
8hzNAJdm7+oRrcThzZ2+St0NVg5Jt2NsAKC0pwT4J4AaINdCKUXUwz9Gii2Ygw==
=7sm5
-----END PGP SIGNATURE-----

--XEJxduhoH8yVH58u--

