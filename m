Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4964.1794513798076491884
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 12:03:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XGxx4odN;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0C4610CE6A;
	Thu, 12 Nov 2026 21:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794513792;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bJpyucP6qRcEKSioceLGEEf/lKFxhmhf2L6NJ5Dpbrw=;
	b=XGxx4odNjUJ3NccLnnE5DFZZCdDVgze1OWQ4QiYSvkROk+OiZWjN2qiOWmWZxvqEYs0W8p
	D586pmoSojtfpiS40WrDJVYV9rYnW3nk+5kfc4f6Tgpdi8gVtlkRgsz/yuF5DI83wazTYF
	ziQXhUTHoRm516eydgGzr4faoMuhEF/C2o3m/YHRcmbqyj2gE0NhzWtj2OnMBd4YjN72RK
	zNDebKyDWPFHQOagNVGPULF+H1bFfcmH+ZflIHvPeIZWERJJZRjrmPZeUBHe+sX+HwtXKs
	fDy03cCEUyJVGujdps8Z4Pi1cBJ3zS0F/wK7Q2qUWN7bvr7MdNh9EMMl1GTkiw==
Date: Thu, 12 Nov 2026 21:03:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 12/24] clk: renesas: cpg-mssr: Implement
 dedicated MSTP delay logic for RZ/T2H LCDC and RTC
Message-ID: <avYbfjIQTzMiNqmi@duo.ucw.cz>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iPmtp24WA/JTYsLr"
Content-Disposition: inline
In-Reply-To: <20261109121451.6042-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 20:03:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24793


--iPmtp24WA/JTYsLr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 0a6643b1a5ee72f76ed0c606c1b34c7cf632cbfb upstream.
>=20
> Introduce a dedicated clock delay mechanism, cpg_rzt2h_mstp_delay(), to
> satisfy the module-stop (MSTP) state release requirements specified in
> the RZ/T2H hardware manual.
>=20
> Per the hardware manual, while a standard 10 us delay (satisfying 7 dummy
> reads) is sufficient for most IP blocks, the LCDC requires 100 dummy reads
> (142 us) and the RTC requires 300 dummy reads (428 us) to stabilize after
> being released from a module-stop state.

That's 0.4 msec. That's way too long for udelay(). It may cause
unacceptable latencies depending on config and usage.

Best regards,
								Pavel

> index 1b505de9dcd31..e4287599006d6 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -253,6 +253,22 @@ static void cpg_rzt2h_mstp_write(struct cpg_mssr_pri=
v *priv, u16 offset, u32 val
>  	writel(value, base + RZT2H_MSTPCR_OFFSET(offset));
>  }
> =20
> +static void cpg_rzt2h_mstp_delay(u32 idx, bool bit_valid)
> +{
> +	unsigned int mask =3D bit_valid ? GENMASK(31, 0) : GENMASK(31, 5);
> +
> +	if (idx =3D=3D (MOD_CLK_PACK(1204) & mask)) {
> +		/* LCDC needs 100 dummy reads, or 142us */
> +		udelay(142);
> +	} else if (idx =3D=3D (MOD_CLK_PACK(605) & mask)) {
> +		/* RTC needs 300 dummy reads, or 428us */
> +		udelay(428);
> +	} else {
> +		/* default 7 dummy reads, or 10us */
> +		udelay(10);
> +	}
> +}
> +

--iPmtp24WA/JTYsLr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavYbfgAKCRAw5/Bqldv6
8u6iAJ4tGhzvA24l+62OniuU5UaFfumBBACgsGrDSnRmVVDvkobE1XLzD7HPayk=
=775O
-----END PGP SIGNATURE-----

--iPmtp24WA/JTYsLr--
