Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC8C98320
	for <webhook@archiver.kernel.org>; Sat, 17 Jan 2026 10:00:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5870.1768644020209671708
 for <cip-dev@lists.cip-project.org>;
 Sat, 17 Jan 2026 02:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XvXPtNQi;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7CF310DB22;
	Sat, 17 Jan 2026 11:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768644017;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DYM+LpU3OVHed2IxXDuwS14RtBZVsiOm/NyeIZN0PZ8=;
	b=XvXPtNQiXzQvM6vsBg14wC08drZ3GE0U30j/ZIqYXN1IdsJ63RDG/ZlKquXawmwbus91Lp
	RtZ2fPpLEUCqjSEpu4Bw5bpl8U4qNWJiRsopxgnhXTHEOJ4riPYmpVk5QvglcYq55YCRnc
	DQ/QlYj9NIvohJEFKQMemTa/RNlo/PqRVvt99LG8E7653mG8TaTzaoB0d3HUku28EYdeyF
	81BHMCfnm7OW+Y9icnmbIvrdcFVZuxamxg92s7q+OS+dwn9j8gp8d8XpU/d9gfxQUY/uoq
	RFP094UvAERlVuAYB/ugroPoOuy19ytHgxUctg9rPTD67wBvM1cu9kGhRsRBoQ==
Date: Sat, 17 Jan 2026 11:00:12 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Fix ISEL
 restore on resume
Message-ID: <aWtdrHpVgkmnlSa8@duo.ucw.cz>
References: <20260115103710.133165-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB1481852ED078D02DFA970560FCD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9gRF427GfI++mZvp"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481852ED078D02DFA970560FCD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Jan 2026 10:00:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21642


--9gRF427GfI++mZvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/dri
> > vers/pinctrl/renesas/pinctrl-rzg2l.c?h=3Dlinux-6.1.y-cip&id=3D9c6a8dccc=
2af82f7
> > 4d6401d5c13f4039bbad02eb
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3D
> > linux-6.12.y&id=3Df8bb150f228f4c1500632a81e91e6ad99df5c90c
> >=20
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 63
> > ++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 23 deletions(-)
> >=20
>=20
> Ah, I was just working to backport this patch. Thanks!
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Looks good to me, and it passed testing, so I'm applying/pushing it.

								Pavel
--=20
In cooperation with Nabla.

--9gRF427GfI++mZvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWtdrAAKCRAw5/Bqldv6
8r8sAKCfRxDIRKMpKir7/FMIOFECbTmQOQCfYTXL2N9/kpPBTDGRCdmTnWQNPc8=
=v64l
-----END PGP SIGNATURE-----

--9gRF427GfI++mZvp--

