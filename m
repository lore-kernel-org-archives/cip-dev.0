Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1116BC44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:23:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3212.1784110992994482615
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:23:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XYjuaQL+;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30586119ADC;
	Wed, 15 Jul 2026 12:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784110990;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WzbY7T6yQ0BR+cyBKFnCFuTQ9tsJ3ydb3V/Kv7/iDQk=;
	b=XYjuaQL+kMJ2bq5kpE8g9RsICLLYl4aK4oFb3yWgUoLJ4wuaNnhipsGt8CF5c9IVSND8gN
	Y2MU7QQdrnXSXzYtJpAAiaLdTcERUkDPaTahmK4yB7WxPtaye1kXwYQxAFXQ3/S3dxXrJh
	SaKyO4KdMl62+5+Im5Yij044HTv6+guQHgGNSfWD5+x71dcYIGJbEtkXMy+34yBQJlHUfZ
	1CpAQ/IzpEPiiAOEYoXYdOc71lNlsKxR31UQrLCFcs6KZsHSGi2lp6p2QEltvPTej94Rbh
	3XWKo8qZMm3fhbdumOuViK5ZotYHQLr2UvD4MoBxRUhoOrcBNHAuFqkPywzIDA==
Date: Wed, 15 Jul 2026 12:23:06 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 15/23] pinctrl: renesas: rzg2l: Add support
 for clone channel control
Message-ID: <aldfilAzZmb1ww7K@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-16-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZKf+XAHtXT89nSAu"
Content-Disposition: inline
In-Reply-To: <20260703105923.251255-16-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:23:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23592


--ZKf+XAHtXT89nSAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> The RZ/G3L SoC has some IP such as I2C ch{2,3},SCIF ch{3,4,5},
> RSPI ch{1,2} and RSCI ch{1,2,3} need to control the clone channel for
> proper operation. As per the RZ/G3L hardware manual, the clone channel
> setting is to be done before the mux setting.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20260430093422.74812-8-biju.das.jz@bp.rene=
sas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

=2E..

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -352,6 +368,7 @@ struct rzg2l_pinctrl_pin_settings {
>   * @smt: SMT registers cache
>   * @sr: SR registers cache
>   * @nod: NOD registers cache
> + * @clone: Clone register cache
>   * @sd_ch: SD_CH registers cache

I notice clone is very different from the other fields (being value,
not pointer), yet is documented in exactly the same way as other
field. That should probably be improved.

>   * @eth_poc: ET_POC registers cache
>   * @other_poc: OTHER_POC register cache
> @@ -369,6 +386,7 @@ struct rzg2l_pinctrl_reg_cache {
>  	u32	*smt[2];
>  	u32	*sr[2];
>  	u32	*nod[2];
> +	u32	clone;
>  	u8	sd_ch[2];
>  	u8	eth_poc[2];
>  	u8	oen;
> @@ -387,6 +405,8 @@ struct rzg2l_pinctrl {
> =20
>  	struct clk			*clk;
> =20
> +	struct regmap			*syscon;
> +
>  	struct gpio_chip		gpio_chip;
>  	struct pinctrl_gpio_range	gpio_range;
>  	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);

Best regards,
								Pavel

--ZKf+XAHtXT89nSAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldfigAKCRAw5/Bqldv6
8l++AKCQeLCrxhdIAWrwzLP3OKyEs9kVzwCfV9e8tPNUr8y9T+Htj78wL71/iUg=
=vapI
-----END PGP SIGNATURE-----

--ZKf+XAHtXT89nSAu--

