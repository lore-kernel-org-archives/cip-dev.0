Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60655C43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 11:11:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53298.1782558699768933331
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 04:11:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MJ/9ajl1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EA80118270;
	Sat, 27 Jun 2026 13:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782558697;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hRELZ3iH5/RGScBmeutKYdgCZqa1lepY3f79wbOfh5A=;
	b=MJ/9ajl10zera5jZuZJlut3op5n+8vQBdi286+xYj76Oz9VReGgOQCZmKHsp9gxjd6M5CU
	FH4dsoGwqC/OSmHM3P0xCpQEntoF/msqX0dirYxrGMMnXTbcVIx4L4mF+fJNukHNRwhVTz
	hnshrbHQ7TWG0+QGp+UUrx4Sa0PZzFD8C4KHMoiajwmldXSu9wag+DKA8QybeAuXxALMtl
	E2FQEJMDybv3EqoSbgF6pWS//cYgKufW5OeY4N4IgFKx6P8zsbgok73rJCm3+fF539bHa4
	JAOW+TPc/jBK1GkNvz1k3TESq+RZw1a9GYonvLlnTqjMigFT/XUoYSh2wYb12Q==
Date: Sat, 27 Jun 2026 13:11:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 17/32] spi: rzv2h-rspi: add support
 for RZ/T2H and RZ/N2H
Message-ID: <aj-v5pqrtAsWVkmP@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <20260617083003.1071543-18-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iaXPNBt1lqNcfqkN"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-18-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 11:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23290


--iaXPNBt1lqNcfqkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> Compared to the previously supported RZ/V2H, the Renesas RZ/T2H
> (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a smaller FIFO, no resets,
> and only two clocks: PCLKSPIn and PCLK. PCLKSPIn, being the clock from
> which the SPI transfer clock is generated, is the equivalent of the TCLK
> clock from RZ/V2H. They also support generating the SPI transfer clock
> from PCLK.
>=20
> PCLKSPIn supports multiple dividers, generating multiple possible
> frequencies from its parent. To handle this, do the following changes.
>=20
> Use the minimum frequency of SPI clock to calculate the SPI controller's
> min_speed_hz, and the maximum frequency to calculate max_speed_hz.
>=20
> Add a new function, rzv2h_rspi_find_rate_variable(), which is used for
> the .find_tclk_rate() callback, and which supports handling clocks with
> a variable rate, with the following overall logic.
>=20
> Iterate through all possible BRDV values.
>=20
> For each BRDV, calculate two different SPRs, one for the clock's minimum
> frequency, and one for the maxmimum, and iterate through each SPR
> between them.
>=20
> If the minimum SPR is higher than the upper SPR limit, the minimum rate
> is too high to achieve the requested SPI frequency, skip to the next
> BRDV.
>=20
> For each SPR, calculate a rate and let the clock framework round it to
> the closest supported rate of the clock.
>=20
> The rate and SPR that generate a transfer frequency closest to the
> requested SPI transfer frequency will be picked.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Link: https://patch.msgid.link/20251119161434.595677-12-cosmin-gabriel.ta=
nislav.xa@renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/spi/spi-rzv2h-rspi.c | 108 +++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>=20
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
> index 3c1cb76bc7b4..2f4feaedaf97 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -258,6 +258,105 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned =
long tclk_rate, u8 spr,
>  	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
>  }
> =20
> +static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
> +					  u8 spr_min, u8 spr_max,
> +					  struct rzv2h_rspi_best_clock *best)
> +{
> +	long clk_rate, clk_min_rate, clk_max_rate;
> +	int min_rate_spr, max_rate_spr;
> +	unsigned long error;
> +	u32 actual_hz;
> +	u8 brdv;
> +	int spr;
> +
> +	/*
> +	 * On T2H / N2H, the source for the SPI clock is PCLKSPIn, which is a
> +	 * 1/32, 1/30, 1/25 or 1/24 divider of PLL4, which is 2400MHz,
> +	 * resulting in either 75MHz, 80MHz, 96MHz or 100MHz.
> +	 */
> +	clk_min_rate =3D clk_round_rate(clk, 0);
> +	if (clk_min_rate < 0)
> +		return;

These are clearly failures, yet we are returning void. That is not
usual coding style.

Best regards,
								Pavel

--iaXPNBt1lqNcfqkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj+v5gAKCRAw5/Bqldv6
8n3VAKCafJYczXJbq7CS/mNnR1EKzmDHtACeIvzIIFi7aWCS8Ogbdd6OHhRGILg=
=ZayC
-----END PGP SIGNATURE-----

--iaXPNBt1lqNcfqkN--

