Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19EF8D77B
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:51:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25877.1776372708551828698
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VGD75PI8;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38BF41136B2;
	Thu, 16 Apr 2026 22:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776372706;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eHsM05ssS6pHLWIJWnT8YEB1CjVE6qMZbiVCypIC8oE=;
	b=VGD75PI8ruHETLNah9QPLHGOqv9v2Kkwi7nyujxPNlKvPy942cBjHUSYXxSFiBYWOmyzEB
	hlw1a8BJHp8vhZAaYD5aCOpbM1e9RYHlkE72xAzwQ3X0juCsmW03W3moj8SZmiROsaUlPh
	RFaoMCxEMjOekvFFrnFSRnc4bMrhG5mXPZKGi55sz4SEKJTXfFfQrIOYqxjDqGmTPzY21U
	fDZp6nz/XS1srEExXFSddQY9b98EY0RtCOD67S0r2gRE4m79LUWhE2rTrezyapDk+5NTYg
	e7TAE5WgbgH1rOPBxrU1a9Y9iGZMC0ZJdRBEqaSpclWIYIT6G13QSzWZ1JwMqg==
Date: Thu, 16 Apr 2026 22:51:42 +0200
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 2/8] spi: Add driver for the
 RZ/V2H(P) RSPI IP
Message-ID: <aeFL3nqhdtOk6cQm@duo.ucw.cz>
References: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
 <20260415131919.95486-3-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTcXLkB9Hyoan7+7"
Content-Disposition: inline
In-Reply-To: <20260415131919.95486-3-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:51:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22750


--QTcXLkB9Hyoan7+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> new file mode 100644
> index 000000000000..cf4272f99378
> --- /dev/null
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> +
> +#define RZV2H_RSPI_TX(func, type)					\
> +static inline void rzv2h_rspi_tx_##type(struct rzv2h_rspi_priv *rspi,	\
> +					const void *txbuf,		\
> +					unsigned int index) {		\
> +	type buf = 0;							\
> +									\
> +	if (txbuf)							\
> +		buf = ((type *)txbuf)[index];				\
> +									\
> +	func(buf, rspi->base + RSPI_SPDR);				\
> +}
> +
> +#define RZV2H_RSPI_RX(func, type)					\
> +static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	\
> +					void *rxbuf,			\
> +					unsigned int index) {		\
> +	type buf = func(rspi->base + RSPI_SPDR);			\
> +									\
> +	if (rxbuf)							\
> +		((type *)rxbuf)[index] = buf;				\
> +}
> +
> +RZV2H_RSPI_TX(writel, u32)
> +RZV2H_RSPI_TX(writew, u16)
> +RZV2H_RSPI_TX(writeb, u8)
> +RZV2H_RSPI_RX(readl, u32)
> +RZV2H_RSPI_RX(readw, u16)
> +RZV2H_RSPI_RX(readl, u8)

This is quite ... complex system for generating functions that are
then only used once. I suspect that if you just inlined the functions
by hand, code would be easier to read, and not really longer.

Thanks and best regards,
								Pavel

> +static void rzv2h_rspi_send(struct rzv2h_rspi_priv *rspi, const void *txbuf,
> +			    unsigned int index)
> +{
> +	switch (rspi->bytes_per_word) {
> +	case 4:
> +		rzv2h_rspi_tx_u32(rspi, txbuf, index);
> +		break;
> +	case 2:
> +		rzv2h_rspi_tx_u16(rspi, txbuf, index);
> +		break;
> +	default:
> +		rzv2h_rspi_tx_u8(rspi, txbuf, index);
> +	}
> +}
> +
> +static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbuf,
> +			      unsigned int index)
> +{
> +	int ret;
> +
> +	ret = rzv2h_rspi_wait_for_interrupt(rspi, RSPI_SPSR_SPRF);
> +	if (ret)
> +		return ret;
> +
> +	switch (rspi->bytes_per_word) {
> +	case 4:
> +		rzv2h_rspi_rx_u32(rspi, rxbuf, index);
> +		break;
> +	case 2:
> +		rzv2h_rspi_rx_u16(rspi, rxbuf, index);
> +		break;
> +	default:
> +		rzv2h_rspi_rx_u8(rspi, rxbuf, index);
> +	}
> +
> +	return 0;
> +}

--QTcXLkB9Hyoan7+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFL3gAKCRAw5/Bqldv6
8iVDAKCqId9uGADCF9apKg7FkdL/uhQQtwCcCkrDMMoXFa/kF1HlvR+5DYQYAog=
=DV3V
-----END PGP SIGNATURE-----

--QTcXLkB9Hyoan7+7--

