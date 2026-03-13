Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE441105F791
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 10:18:01 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12683.1773397075312942064
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 03:17:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QMM5KUul;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C45310BF1B;
	Fri, 13 Mar 2026 11:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773397073;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LVM2VuBv2W/IatBE6vi8ylcYOqj32Qbq48bkynx1qt0=;
	b=QMM5KUult8ap0EgXdWA91qvHju2LTlbpRbOPcn5I0a5MQgCr975i1x0aGgypUGRf6n/EM0
	NeFrcs9sPcTuR7SEPv656CTRlN3w9/Ts0UsqllgMpsCTLNbs3HoeF+yT0Dh1qwFc7UnGP6
	KREc2N3wr10aDiFH8AfPDvtAJqTc9K/HmC3TPr9gtkfkhlZGgCqo3z+h81F4d20Np6K950
	nwvN9ELL3qWkbKmQmFSUgH7zM3+N+Jdn/6ZwnCULHLtubvYp7f7MChWptOsw2nx7X+EZsM
	6a8DOiX9lEPjmX5v63MpiITsyhU/c3GC0yQ0Xhf5NR5Bfd0jFiurGjJauQA/TQ==
Date: Fri, 13 Mar 2026 11:17:48 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cosmin-gabriel.tanislav.xa@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 02/17] spi: Add driver for the
 RZ/V2H(P) RSPI IP
Message-ID: <abPkTIDQRgV0lxPA@duo.ucw.cz>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260309150619.761962-3-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3HzEFunvpSabJWDc"
Content-Disposition: inline
In-Reply-To: <20260309150619.761962-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 10:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22369


--3HzEFunvpSabJWDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> commit 8b61c8919dff080d83415523cd68f2fef03ccfc7 upstream.
>=20
> The Renesas RZ/V2H(P) RSPI IP supports 4-wire and 3-wire
> serial communications in both host role and target role.
> It can use a DMA, but the I/O can also be driven by the
> processor.

Normally we format this to 70 columns or so.

> @@ -885,6 +885,14 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
> =20
> +config SPI_RZV2H_RSPI
> +	tristate "Renesas RZ/V2H RSPI controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  RSPI driver for the Renesas RZ/V2H Serial Peripheral Interface (RSPI).
> +	  RSPI supports both SPI host and SPI target roles. This option only
> +	  enables the SPI host role.

"Module will be called xyz" is normally in the help text.

> +static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
> +{
> +	unsigned long tclk_rate;
> +	int spr;
> +	u8 brdv;
=2E..
> +	tclk_rate =3D clk_get_rate(rspi->tclk);
> +	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv+=
+) {
> +		spr =3D DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
> +		spr--;
> +		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
> +			goto clock_found;
> +	}
> +
> +	return 0;
> +
> +clock_found:
> +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
> +	writeb(spr, rspi->base + RSPI_SPBR);
> +
> +	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
> +}

I believe code would be better without the goto here.

Best regards,
								Pavel

--3HzEFunvpSabJWDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabPkTAAKCRAw5/Bqldv6
8r7CAJ4oUKhlgz3ARPHOulBVov0ZqW1xKgCgsGdPMMWSSZUZK0NJyps4TkqLX8w=
=gIqI
-----END PGP SIGNATURE-----

--3HzEFunvpSabJWDc--

