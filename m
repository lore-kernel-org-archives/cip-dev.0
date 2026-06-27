Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7228EC43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 11:20:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53634.1782559248828630913
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 04:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PNcIv7Sy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5932118201;
	Sat, 27 Jun 2026 13:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782559245;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/i0SKQzM2AtePxeFWOjLM8sBTVfzQW0NhQzXUbtR6ZU=;
	b=PNcIv7SyqmCG1WkbNPRSi3h5INSypkZsa+b8c/de/K7imekrmB1FfKzICtNF4jmdH+90/s
	+WQVnHzYEDSFV8gcoxxfF+SPSzLUci1j2whNYk1BbA/IeXSAd5mt5dzS4A8AZasD/bsjDs
	T6/6ce5Duo2v71tvxC2JfVROtCE64OdktQqEUHR5iVl7KJo6m0jD2lPKG0bE7C37ZA3tPa
	SEDREFgQ1QdjiYS14r2UMDPLvAaTmbqueiKjgNh+Em356xreti1LxMT8QwS32wud0QYJPp
	AGFsWW2MnQ5gPoMxfuni3CGfcozfLTVusB75Ui/riPprb4n37QhfIDeKh45ubw==
Date: Sat, 27 Jun 2026 13:20:41 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 26/32] spi: rzv2h-rspi: add support for DMA mode
Message-ID: <aj-yCQC-C6yS4qes@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <20260617083003.1071543-27-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FBBWovreKrbjmmEI"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-27-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 11:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23291


--FBBWovreKrbjmmEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> commit fa08b566860bca8ebf9300090b85174c34de7ca5 upstream.
>=20
> The DMA controller can be used to transfer data to and from the SPI
> controller without involving the CPU for each word of a SPI transfer.
>=20
> Add support for DMA mode.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Link: https://patch.msgid.link/20251201134229.600817-12-cosmin-gabriel.ta=
nislav.xa@renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> [tm: Use dev_warn() equivalent of dev_warn_probe()]
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  drivers/spi/spi-rzv2h-rspi.c | 171 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 170 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
> index 3191eaddc9d5..623e7683dcf3 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> +static int rzv2h_rspi_transfer_dma(struct rzv2h_rspi_priv *rspi,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *transfer,
> +				   unsigned int words_to_transfer)
> +{
> +	struct dma_async_tx_descriptor *tx_desc =3D NULL, *rx_desc =3D NULL;
> +	enum dma_slave_buswidth width;
> +	dma_cookie_t cookie;
> +	int ret;
=2E..
> +	cookie =3D dmaengine_submit(rx_desc);
> +	if (dma_submit_error(cookie))
> +		return cookie;
> +
> +	cookie =3D dmaengine_submit(tx_desc);
> +	if (dma_submit_error(cookie)) {
> +		dmaengine_terminate_sync(rspi->controller->dma_rx);
> +		return cookie;
> +	}

I'd do "ret =3D dma_submit_error()"... return ret; in both cases
here. Just silently casting dma_cookie_t to int like this is
apparently not how the API was designed.

Thanks and best regards,
								Pavel

--FBBWovreKrbjmmEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj+yCQAKCRAw5/Bqldv6
8jEpAJ9l8EAUMQltieUhwgGQdcKQuYbjMQCfcZmH/XAXyVSlsgtHlfnhe5F/TQs=
=zUWN
-----END PGP SIGNATURE-----

--FBBWovreKrbjmmEI--

