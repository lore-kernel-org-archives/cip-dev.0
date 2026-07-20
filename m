Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EBC44529
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 20:15:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6763.1784578500989119456
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 13:15:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OLOpdsf2;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E44D11A91F;
	Mon, 20 Jul 2026 22:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784578499;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5+aVCMrS3WSZwVoz+ZmsJni0iYgD7/ph0WSkVyZ+43E=;
	b=OLOpdsf26+8095zwYvNqdoXTyKT2yRjcAG7G8ssrkjqryFX6uFSXvL+7CYG6EjOAsu+qVv
	7DJMm7X8ONI7G03YACG/OD5FOib4CPN/y1eosfh890mPIDJN8onqLpuGiH7a/Zfl0kxqJe
	LX4LYTRxEBWxdcgJEZbvn/RXTooIOEV1Z1nSn+u5aPoJ07euAt0ERcE7vNTC74dA0xBitu
	TXFDP4Px/KsudkinX/Cg8xuNNnOcBYxZlyuf/C34sIAMnG5CXXQFUVaFi3sQ6LYHhstRsL
	yCTo25/BvtaU6khBKcvubVNHaKd2zIAepB5GT83p+PPEMq8twGN65hzqAe/CaQ==
Date: Mon, 20 Jul 2026 22:14:57 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 14/23] hwmon: (lm75) Fix tmp112 default config
Message-ID: <al6BwdhAv7oaLPTh@duo.ucw.cz>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
 <20260717131241.2233788-15-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SZFG0YcF7XyJxnHM"
Content-Disposition: inline
In-Reply-To: <20260717131241.2233788-15-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 20:15:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23687


--SZFG0YcF7XyJxnHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Abdel Alkuor <alkuor@gmail.com>
>=20
> commit 8249a0e25dd2972e919a2552425bf4faa2581d24 upstream.
>=20
> Set tmp112 conversion rate to 8 HZ and 12-bit mode.
>=20
> Fixes: 35cd18048542 ("hwmon: (lm75) Aproximate sample times to data-sheet=
 values")
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> Link: https://lore.kernel.org/r/20240106030254.384963-1-alkuor@gmail.com
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/hwmon/lm75.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index f6e16dfa11c5..5eba180b66a0 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -270,8 +270,9 @@ static const struct lm75_params device_params[] =3D {
>  		.resolutions =3D (u8 []) {9, 10, 11, 12 },
>  	},
>  	[tmp112] =3D {
> -		.set_mask =3D 3 << 5,	/* 8 samples / second */
> -		.clr_mask =3D 1 << 7,	/* no one-shot mode*/
> +		.config_reg_16bits =3D true,
> +		.set_mask =3D 0x60C0,	/* 12-bit mode, 8 samples / second */
> +		.clr_mask =3D 1 << 15,	/* no one-shot mode*/

I would not mind space before "*/". But not your code and not your
patch...

Best regards,
								Pavel

--SZFG0YcF7XyJxnHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCal6BwQAKCRAw5/Bqldv6
8lu+AJ94uKOYtv1K90ETGFOkUJB2teA8BwCfT3oejY6XDBw9GFi3MyYPNIjHXOw=
=yIkS
-----END PGP SIGNATURE-----

--SZFG0YcF7XyJxnHM--

