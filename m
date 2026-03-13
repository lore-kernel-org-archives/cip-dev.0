Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1919105F792
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 10:25:21 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12720.1773397519619990152
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 03:25:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DPqgbUda;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAC6310C17C;
	Fri, 13 Mar 2026 11:25:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773397517;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lGmxyLO2+iSB16Hx966jkBa3SO2UuLYuQFeu2ksRj5g=;
	b=DPqgbUdaeeg8y+J8ks0bnDNj02cQKnkfYq+X/D1qM7g9Dx64xqWtNhTWuct+JXEeYJgCB1
	2FLGmb6lsiHY/mnu9k+9EfVemuhhcu0SN1FC/Mhpb+JtSxHxfOfCjm4p3s/sg7htfGiygo
	xaRVxx5lU9sCh6dEXegGkBhSuP4RquM3notv6pY70KegZFuHS5G/6m1rGsOmuh0lbBHiQK
	NlmD9p2F/DqunjiLhdv73yzQLKSH6FraEnZ/2cmlKKjXO06isiYa3WjxZN+hpkFRiWRX6+
	WQOBYFWbuYS+tGPdNyjLO8KbPToYG/SKj4rnC+K2ZumpHU3dnnrPTyMeh+/XtA==
Date: Fri, 13 Mar 2026 11:25:15 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip v3 10/17] spi: rzv2h-rspi: make transfer clock
 rate finding chip-specific
Message-ID: <abPmC/HquWcaDtom@duo.ucw.cz>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260309150619.761962-11-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1snPMP1y7f/IMd40"
Content-Disposition: inline
In-Reply-To: <20260309150619.761962-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 10:25:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22370


--1snPMP1y7f/IMd40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

> @@ -255,21 +270,49 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi=
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
> =20
>  clock_found:
> -	rspi->spr =3D spr;
> -	rspi->brdv =3D brdv;
> +	actual_hz =3D rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
> +	error =3D abs((long)hz - (long)actual_hz);
> =20
> -	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
> +	if (error >=3D best->error)
> +		return;
> +
> +	*best =3D (struct rzv2h_rspi_best_clock) {
> +		.clk =3D clk,
> +		.clk_rate =3D clk_rate,
> +		.error =3D error,
> +		.actual_hz =3D actual_hz,
> +		.brdv =3D brdv,
> +		.spr =3D spr,
> +	};
> +}

This is really quite strange code... looks like Rust more than C.

Filling clk, error, actual_hz, .... into temporary variable and then
just assiging it may be better.

Best regards,
								Pavel

--1snPMP1y7f/IMd40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabPmCwAKCRAw5/Bqldv6
8qIeAJ9LahHYTrr4XRpwV7xEw/dVkzAzBACgjKAKljhszAOdsTENP7c8tx4GDR0=
=eNjm
-----END PGP SIGNATURE-----

--1snPMP1y7f/IMd40--

