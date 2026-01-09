Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5CD167FE
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:26:47 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7345.1767954397357047750
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:26:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WP/7gfbX;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 655AF10D3F2;
	Fri,  9 Jan 2026 11:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767954395;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oPNgnsoCvn5swVg6P3unS4sLNgr61SBQKN/qkCrZDYE=;
	b=WP/7gfbXBJZzB4tD3EMcIxkupH0AyPQVEf5jt7VL9jXGXmf7e0lzw3hBdIWtXpeZxh/2KG
	27JB/VZRpCvTfsLKpW41K8KiJgQhkB+YFczvuqThJEtIE4aN6H3cEHo9rbCDqJVGYynoaa
	afWdpQam7o0qyQvRYbFKnblWM0ORc+C1Vs0MNU88CM77Or4rGAbDskOirhG1EGnpiodAnq
	h46iMMkwR/h/Sn2QMTm+9h/p2VeB2vLKiF1f7ijh8xEUzUFYOHDDBjtfU+vE/fP7z3Nz8g
	KpoXxTNHtII/eygYbdeLrcaFd+QST2zbjJb7w+IA2QYLDBNH8HZf2KGkH8SWKg==
Date: Fri, 9 Jan 2026 11:26:32 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 11/22] i3c: master: Add inline
 i3c_readl_fifo() and i3c_writel_fifo()
Message-ID: <aWDX2GnS1p7FS1NZ@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-12-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="13ycqkBGZfche7nU"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-12-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:26:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21495


--13ycqkBGZfche7nU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jorge Marques <jorge.marques@analog.com>
>=20
> commit 733b439375b494e8a6950ab47d18a4b615b73cb3 upstream.
>=20
> The I3C abstraction expects u8 buffers, but some controllers operate with
> a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
> reading or writing outside the buffer bounds, use 32-bit accesses where
> possible and apply memcpy for any remaining bytes

> +++ b/drivers/i3c/internals.h
> @@ -24,4 +24,41 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev=
);
>  int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
>  			       const struct i3c_ibi_setup *req);
>  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> +
> +/**
> + * i3c_writel_fifo - Write data buffer to 32bit FIFO
> + * @addr: FIFO Address to write to
> + * @buf: Pointer to the data bytes to write
> + * @nbytes: Number of bytes to write
> + */
> +static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
> +				   int nbytes)
> +{
> +	writesl(addr, buf, nbytes / 4);
> +	if (nbytes & 3) {
> +		u32 tmp =3D 0;
> +
> +		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> +		writel(tmp, addr);
> +	}
> +}

That's quite an interesting code. Will it work correctly on both endianness?

> +/**
> + * i3c_readl_fifo - Read data buffer from 32bit FIFO
> + * @addr: FIFO Address to read from
> + * @buf: Pointer to the buffer to store read bytes
> + * @nbytes: Number of bytes to read
> + */
> +static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
> +				  int nbytes)
> +{
> +	readsl(addr, buf, nbytes / 4);
> +	if (nbytes & 3) {
> +		u32 tmp;
> +
> +		tmp =3D readl(addr);
> +		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> +	}
> +}

Same question here.

Best regards,
									Pavel

--=20
In cooperation with Nabla.

--13ycqkBGZfche7nU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDX2AAKCRAw5/Bqldv6
8sBYAJ9Iqw2ANRj2bnyM/4/oYmTm2IfeHgCcCZvQVMCqQsVLclVpcrUo+WFxvzI=
=k6pa
-----END PGP SIGNATURE-----

--13ycqkBGZfche7nU--

