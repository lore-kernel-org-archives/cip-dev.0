Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A1DC43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 11:10:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53278.1782558600618738730
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 04:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CcBLLmw1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBD4D10A41E;
	Sat, 27 Jun 2026 13:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782558597;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SIJiK/vAkSHjJfraHp8hzfCXkQxpOCwjUBkbSq44Dcs=;
	b=CcBLLmw1hoW8f4efVICLCw3nFcaaNHPIjKRgQN87mPdeQf3W+mMBtWkZ/z4OtSxBL9CRfh
	Qahp+9XG960r9O26cklw4+nxkz+kXjQZHY2/hcG7if0AXBjc4QUn77Mbz5u9JRS3KjI2Gy
	1ebGpqxWhTYa92oHM9FLbC8N2Q2VLTWuhS5Vq9GejP3L10b6yqlhYHMXme0ZQZtjZVhIp4
	4sZknC3HykqVP27AfDgeo9UQkDz3R4wE/6otAhiTO0ks90zz0BxfVSpOcMa9jgo0WQjTH/
	AGeIyTIykJ/6T/wRrRdGRsnSDjwsQTUMSFOfocrrjAa+JMDX/Z9GYLoxCdnfIA==
Date: Sat, 27 Jun 2026 13:09:51 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 13/32] spi: rzv2h-rspi: make transfer clock
 rate finding chip-specific
Message-ID: <aj-vf04J2K6N9-sL@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <20260617083003.1071543-14-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yc0amK7dpfYpir9S"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-14-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 11:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23289


--Yc0amK7dpfYpir9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> commit 77d931584dd38916b66c65320c80a65cbef4b122 upstream.
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
> complicated clocking setup for the SPI transfer clock than RZ/V2H, as
> the clock from which it is generated supports multiple dividers.
>=20
> To prepare for adding support for these SoCs, split out the logic for
> finding the SPR and BRDV for a fixed clock into
> rzv2h_rspi_find_rate_fixed(), and add and use a .find_tclk_rate()
> callback into the chip-specific structure.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Link: https://patch.msgid.link/20251119161434.595677-7-cosmin-gabriel.tan=
islav.xa@renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/spi/spi-rzv2h-rspi.c | 62 ++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
> index f22f418325d8..fc0957d2bb2a 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -237,9 +248,13 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned l=
ong tclk_rate, u8 spr,
>  	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
>  }
> =20
> -static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
> +static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
> +				       u8 spr_min, u8 spr_max,
> +				       struct rzv2h_rspi_best_clock *best)
>  {
> -	unsigned long tclk_rate;
> +	unsigned long clk_rate;
> +	unsigned long error;
> +	u32 actual_hz;
>  	int spr;
>  	u8 brdv;
> =20
> @@ -252,21 +267,49 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi=
_priv *rspi, u32 hz)
>  	 * * n =3D SPR - is RSPI_SPBR.SPR (from 0 to 255)
>  	 * * N =3D BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
>  	 */
> -	tclk_rate =3D clk_get_rate(rspi->tclk);
> +	clk_rate =3D clk_get_rate(clk);
>  	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv+=
+) {
> -		spr =3D DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
> +		spr =3D DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
>  		spr--;
> -		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
> +		if (spr >=3D spr_min && spr <=3D spr_max)
>  			goto clock_found;
>  	}
> =20
> -	return 0;
> +	return;
>

So this is basically error return, yet we are returning void. Not nice.

> +static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
> +{
> +	struct rzv2h_rspi_best_clock best_clock =3D {
> +		.error =3D ULONG_MAX,
> +	};
> +
> +	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
> +				   RSPI_SPBR_SPR_MAX, &best_clock);
> +
> +	if (!best_clock.clk_rate)
> +		return -EINVAL;

-errno in function returning u32. I see this is fixed in subsequent patches.

Best regards,
									Pavel

--Yc0amK7dpfYpir9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj+vfwAKCRAw5/Bqldv6
8tUSAJ9vJgobqpEoWym+24Zh/ziKoGXIWQCfY+q+0FkIOBqQ6TyO8z/NhvQaTm8=
=MGLX
-----END PGP SIGNATURE-----

--Yc0amK7dpfYpir9S--

