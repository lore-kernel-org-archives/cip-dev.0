Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2880DFD5332
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 10:05:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.92304.1772186716262550111
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 02:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=T0X2V6Zx;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50BE710F866;
	Fri, 27 Feb 2026 11:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772186714;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=b46cchJgApacvLHaBdiHgUvgCmK1uYHVbJIDanYas04=;
	b=T0X2V6Zx6fLsfMiu+YZnuffd2svbrLTu+YAUPDzjd+t314EdU/oWyibcxzaCg7MV56utG7
	fRicO3tzo59eNH956yC3fpNo1Xq4DjN/LwPiEsTk2ydtOPU/hRtyG6e6PYRREu8GPJUstb
	rRgpmw1jzpxXTxYMTurr4An5yAIZuQM1rzDY/aoVeHGbWv1JCUeI11jWEUf5b7HJ2KOWrR
	JU7XbFu338ZtXkx6gWXui/9kUvILnieuVq215BfdyGdFPFX4Ybksnxllm7gzizOVIWdb4e
	CSLg439WUMMItlsjUF+kImOTxVOL/vZSKbpMERZym4iDdpLdOFw6Otivl9kSKw==
Date: Fri, 27 Feb 2026 11:05:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 20/25] drm: renesas: rz-du: mipi_dsi: Add
 support for RZ/V2H(P) SoC
Message-ID: <aaFsVjmlSMUJlAkN@duo.ucw.cz>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
 <20260225121003.129467-21-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fafm/MHFRHrztgvF"
Content-Disposition: inline
In-Reply-To: <20260225121003.129467-21-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 10:05:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22026


--fafm/MHFRHrztgvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add MIPI DSI support for the Renesas RZ/V2H(P) SoC. Compared to the
> RZ/G2L family, the RZ/V2H(P) requires dedicated D-PHY PLL programming,
> different clock configuration, and additional timing parameter handling.
> The driver introduces lookup tables and helpers for D-PHY timings
> (TCLK*, THS*, TLPX, and ULPS exit) as specified in the RZ/V2H(P) hardware
> manual. ULPS exit timing depends on the LPCLK rate and is now handled
> explicitly.
>=20
> The implementation also adds support for 16 bpp RGB format, updates the
> clock setup path to use the RZ/V2H PLL divider limits, and provides new
> .dphy_init, .dphy_conf_clks, and .dphy_startup_late_init callbacks to
> match the RZ/V2H sequence.
>=20
> With these changes, the RZ/V2H(P) can operate the MIPI DSI interface in
> compliance with its hardware specification while retaining support for
> existing RZ/G2L platforms.

> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c


> +static const u8 thsexitctl[] =3D {
> +	15, 23, 31, 39, 47, 55, 63, 71, 79, 87,
> +	95, 103, 111, 119, 127, 135, 143, 150,
> +};

Some _'s in the control names would make these more clear. I believe
it is ths_exit_ctl, but... there are more confusing ways to parse this.

> +/**
> + * rzv2h_dphy_find_timings_val - Find timing parameter value from lookup=
 tables
> + * @freq: Input frequency in Hz
> + * @index: Index to select timing parameter table (see enum rzv2h_dsi_ti=
ming_idx)
> + *
> + * Selects the timing table for the requested parameter, finds the
> + * frequency range entry and returns the register value to program:
> + *
> + *   register_value =3D timings->base_value + table_index
> + *
> + * Note: frequency table entries are stored as small integers (units of =
10):

This should probably say "units of of 10MHz", if I'm reading that correctly.

> +
> +static const u8 rzv2h_cpg_div_table[] =3D {
> +	2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32,
> +};

Ok, so this is table of even numbers. Other tables seem to have kind
of regular, too. Documenting how the tables were created would not be
bad.

Thanks and best regards,
								Pavel

--fafm/MHFRHrztgvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFsVgAKCRAw5/Bqldv6
8m18AJ0d3PSdVLmNaoxGBzMjQ/Sp93fsiwCeI0vikz0/nmUV3njdyLq9BuoCir0=
=aNFN
-----END PGP SIGNATURE-----

--fafm/MHFRHrztgvF--

