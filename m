Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3067CA0EFC
	for <webhook@archiver.kernel.org>; Sun, 24 Aug 2025 18:46:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.22650.1756061183756229818
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Aug 2025 11:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Nae48Og3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F092103A0BC0;
	Sun, 24 Aug 2025 20:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1756061181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fA3gRLSgBPC9eW0tOVdy6tPHjINMULgcDMcde0uBQEI=;
	b=Nae48Og3VW5wkd5rYnGLxPaknc0Vq+ckBTMty35osyBbmKdVsMmJg4v95H7fvlhNOvPt9L
	xW+Xc1G2SaXrVa80+Dkfag+Ru7zqKV3fMfs7N+SeHm7RbYEqzAcrJPZ57qPV6fejw9vbfy
	1Zz45kL+NHf8lJxw0ZrykFDhx1+LrcZ1OzD0ZEaRvbq3PCxUzgPfU8LU2j7b//MFqKkwhs
	/qx5zUv0mxr0fXKvYgcog16IWDdY631wTQnfJFSiaWXfhtM1oBbuK7iJZmghg47sn19h19
	imHfad7/G0LBNl2r5u6v8WJ7ssW1mEVGMQnGfFFg5nCMu8jx7Tanmd4K/6BT3Q==
Date: Sun, 24 Aug 2025 20:44:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Ulrich Hecht <uli@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
 register access
Message-ID: <aKtdfcOn0vpmMYZf@duo.ucw.cz>
References: <20250820141305.4841-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aKb38+2Q49y8kzBl@duo.ucw.cz>
 <OSZPR01MB70191CC24A9467931A33E42CAA32A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <2044519855.2076.1755954318987@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1M2U1i2emrjt4uhZ"
Content-Disposition: inline
In-Reply-To: <2044519855.2076.1755954318987@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Aug 2025 18:46:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19959


--1M2U1i2emrjt4uhZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Agreed, I've a now submitted this patch to stable [0].
> >=20
> > > Then we'll backport it to 4.19 and 4.4, provided it applies there, bu=
t I
> > > assume it does? (If not, you should re-send those versions after 5.10-
> > > stable accepts the patch).
> > >=20
> > For 4.4 and 4.19 the patch doesn't apply cleanly. I will resend the 4.4=
 and 4.19
> > Versions once the patch [0] hits stable.
>=20
> Since landing the patch in 5.10 is not a guarantee that it will show up i=
n 5.4 (which is the upstream for 4.4 and 4.19 ATM), I'm inclined to pick th=
ese up as posted for 4.4 and 4.19, unless there is a compelling reason not =
to.
>

I believe we should not take patches to 4.19-cip unless they are in
5.10-cip. Greg just took the patch to 5.10, so that really should not
be problem, but I'd be inclined to wait until it hits 5.10-cip.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1M2U1i2emrjt4uhZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKtdfQAKCRAw5/Bqldv6
8iU6AJ9lYy1oCBZ55xPf9HCF9WDhPGNEzQCgkupxAFGkUrW20EgPTdRLtKyOwws=
=7MVH
-----END PGP SIGNATURE-----

--1M2U1i2emrjt4uhZ--

