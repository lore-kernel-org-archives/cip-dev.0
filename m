Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F7FD5329
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 09:58:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92280.1772186286016127322
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 01:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OStRSOim;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1E6A103DA1;
	Fri, 27 Feb 2026 10:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772186284;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6Gw83zqa7S4oGBa8iasdjlrsJIs4Ar3S1X2Q2Czh5KE=;
	b=OStRSOimpm7F1h9ZmIn9OGfCO694rWzsTI5ifuTiF2272+1RmhOGPw89QRhORcsOvETl5W
	lDUtDGX9+AB0FNqSptKh05JjH9bCTaAfY78T93l1qzZeor/iRcOgQZAo4oF0RRV4PdRHCO
	sfj75KeM/kSeHqCrYZ29f8FBTJPNPVA95Mq7iu913GFkrQ8Kfoy9aSXN6bBFvK8owL+h4q
	mgEif4LblEDW8NfLak/5z3Y/4D9v+phAWnF+bpFBinZD4GFfmx4ETIPANuq/W9hdGK6Myf
	LX+T4O3t2xN8LxR1lwGPULQlNH0BX//FSmnpkJnCFMQ5LGf3eOLHK05N11f+HA==
Date: Fri, 27 Feb 2026 10:57:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 18/25] drm: renesas: rz-du: mipi_dsi: Add
 function pointers for configuring VCLK and mode validation
Message-ID: <aaFqppNRl3CcWPTv@duo.ucw.cz>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
 <20260225121003.129467-19-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ayY+jKLXbhws/mc"
Content-Disposition: inline
In-Reply-To: <20260225121003.129467-19-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 09:58:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22025


--9ayY+jKLXbhws/mc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit e2944dc6587f39c3eefb15ee607e700314230a0b upstream.
>=20
> Introduce `dphy_conf_clks` and `dphy_mode_clk_check` callbacks in
> `rzg2l_mipi_dsi_hw_info` to configure the VCLK and validate
> supported display modes.
>=20
> On the RZ/V2H(P) SoC, the DSI PLL dividers need to be as accurate as
> possible. To ensure compatibility with both RZ/G2L and RZ/V2H(P) SoCs,
> function pointers are introduced.
>=20
> Modify `rzg2l_mipi_dsi_startup()` to use `dphy_conf_clks` for clock
> configuration and `rzg2l_mipi_dsi_bridge_mode_valid()` to invoke
> `dphy_mode_clk_check` for mode validation.
>=20
> This change ensures proper operation across different SoC variants
> by allowing fine-grained control over clock configuration and mode
> validation.

> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -276,12 +280,39 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_m=
ipi_dsi *dsi)
>  	reset_control_assert(dsi->rstc);
>  }
> =20
> +static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned lon=
g mode_freq,
> +				u64 *hsfreq_millihz)
> +{
> +	unsigned long vclk_rate;
> +	unsigned int bpp;
> +
> +	clk_set_rate(dsi->vclk, mode_freq * KILO);
> +	vclk_rate =3D clk_get_rate(dsi->vclk);
> +	if (vclk_rate !=3D mode_freq * KILO)
> +		dev_dbg(dsi->dev, "Requested vclk rate %lu, actual %lu mismatch\n",
> +			mode_freq * KILO, vclk_rate);

I believe what the message is trying to say is there's mismatch
between requested and actual rate.

In such case, "-- mismatch" would make it more clear.

Thanks,
								Pavel

--9ayY+jKLXbhws/mc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFqpgAKCRAw5/Bqldv6
8maLAJ4hoK7tJknaoJl9rUyx4YfhhYNMDwCgpERBfYG1/5x0KAAEQK8ZHqBa2Aw=
=cVSX
-----END PGP SIGNATURE-----

--9ayY+jKLXbhws/mc--

