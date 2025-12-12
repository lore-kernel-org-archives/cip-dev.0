Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE6D49223
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 12:56:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11937.1765544183093791408
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 04:56:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XTp9UB+6;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9CAC1004E47B;
	Fri, 12 Dec 2025 13:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765544180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a/C85LFaTnCuznZ6kOq0mtCvYAKtEmvkBU95uXsSgSE=;
	b=XTp9UB+69tl7G+znGCJqbAHPNJdj7NK2DFp7+hJ67EheSzQZ2Wx0HOhyEpoSTUrGghq8JN
	PZflMSpocE5TPUquhpaRpeBOXiTmeJ7rYGa0d8XFyqBBHGkUHdFJP8ygiABQTeGdA9D0CX
	iecRTSKsZFiVARzi6SGC+kXvbZp+EAOzs4RMstBPgKkcusCj0EKtcR8LTHP1erGepTto+x
	YcYaebC1RrEl5gHxZAR0ugjoolumqZcb+fWQP0Rcs01blf0lHKJPdFg0FtB77HxwVlc1Q3
	cppzZ9l3wKTi3AF7R0jJnIjcfGGdjo0WL4r8F/Bo+89qytgwtkQpanHKQZApww==
Date: Fri, 12 Dec 2025 13:56:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 23/38] clk: renesas: Add CPG/MSSR support to
 RZ/N2H SoC
Message-ID: <aTwQ8evxipbEV9gu@duo.ucw.cz>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGYVu794OZj7sEMA"
Content-Disposition: inline
In-Reply-To: <20251205143258.13748-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 12:56:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20985


--PGYVu794OZj7sEMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add clock driver support for the Renesas RZ/N2H (R9A09G087) SoC by reusing
> the existing RZ/T2H (R9A09G077) CPG/MSSR implementation, as both SoCs
> share the same clock and reset architecture.

> +++ b/drivers/clk/renesas/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_CLK_R9A09G047)		+=3D r9a09g047-cpg.o
>  obj-$(CONFIG_CLK_R9A09G056)		+=3D r9a09g056-cpg.o
>  obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
>  obj-$(CONFIG_CLK_R9A09G077)		+=3D r9a09g077-cpg.o
> +obj-$(CONFIG_CLK_R9A09G087)		+=3D r9a09g077-cpg.o
>  obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o

This is kind of strange -- two options selecting same file. I believe
it is correct based on code below.

Best regards,
								Pavel
							=09
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -948,6 +948,12 @@ static const struct of_device_id cpg_mssr_match[] =
=3D {
>  		.compatible =3D "renesas,r9a09g077-cpg-mssr",
>  		.data =3D &r9a09g077_cpg_mssr_info,
>  	},
> +#endif
> +#ifdef CONFIG_CLK_R9A09G087
> +	{
> +		.compatible =3D "renesas,r9a09g087-cpg-mssr",
> +		.data =3D &r9a09g077_cpg_mssr_info,
> +	},
>  #endif
>  	{ /* sentinel */ }
>  };

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PGYVu794OZj7sEMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwQ8QAKCRAw5/Bqldv6
8h1mAKCqzmwZdvhpJxTwhXPc4XQHQ7ygQQCfTAO5AoJn89nKJgjWYwp4gMWopJ4=
=YED7
-----END PGP SIGNATURE-----

--PGYVu794OZj7sEMA--

