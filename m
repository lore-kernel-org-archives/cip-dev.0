Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF696C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:49:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10158.1784198972747024156
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:49:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DWjfkx9d;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79D44119BC9;
	Thu, 16 Jul 2026 12:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784198970;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/stwyDZ1BqcQ2XezYZnLbNwsr4aGMsspvDoNKth4UvU=;
	b=DWjfkx9dpvMD+9gtLTNqSPIytrLI1Vep/z1iH81cMfGkwVBfKzCE56h6zvXdl2UhD+YYa+
	bJhH9ALj91lx9q+zGbSW5I2E9i9Rxfa7EOXjozfTEQcmWY//krHSetA8JH6kssz1BizTxt
	Ks+2zkVK6b12uMpel1QlJ1kshqyPqFW7aUHE8Y4K7LPgidEuQICuf2ZFIUkbjhfonnSGi9
	zAy86Xzte/c9xYQEoty7uwwiOluDTXVpH069XDDsJ7TWY2nphzvkTncmwDnhecnibaYz/5
	akiOna0G2AYNvHKK2DHiQwFv6UtL//I/yz+MhNwViBRIogHhgoWxvJT94j7PLA==
Date: Thu, 16 Jul 2026 12:49:28 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Add
 suspend/resume support
Message-ID: <ali3OLuCzcYfZswf@duo.ucw.cz>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5DjKuOwpv6tbQyp0"
Content-Disposition: inline
In-Reply-To: <20260706182328.5237-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:49:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23617


--5DjKuOwpv6tbQyp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>

> On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
> callbacks to control spi/spix2 clocks.

=2E..
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -1024,19 +1026,15 @@ static int rpcif_probe(struct platform_device *pd=
ev)
>  	 * flash write failure. So, enable these clocks during probe() and
>  	 * disable it in remove().
>  	 */
> -	if (rpc->info->type =3D=3D XSPI_RZ_G3E) {
> -		struct clk *spi_clk;
> -
> -		spi_clk =3D devm_clk_get_enabled(dev, "spix2");
> -		if (IS_ERR(spi_clk))
> -			return dev_err_probe(dev, PTR_ERR(spi_clk),
> -					     "cannot get enabled spix2 clk\n");
> -
> -		spi_clk =3D devm_clk_get_enabled(dev, "spi");
> -		if (IS_ERR(spi_clk))
> -			return dev_err_probe(dev, PTR_ERR(spi_clk),
> -					     "cannot get enabled spi clk\n");
> -	}
> +	rpc->spix2_clk =3D devm_clk_get_optional_enabled(dev, "spix2");
> +	if (IS_ERR(rpc->spix2_clk))
> +		return dev_err_probe(dev, PTR_ERR(rpc->spix2_clk),
> +				     "cannot get enabled spix2 clk\n");
> +
> +	rpc->spi_clk =3D devm_clk_get_optional_enabled(dev, "spi");
> +	if (IS_ERR(rpc->spi_clk))
> +		return dev_err_probe(dev, PTR_ERR(rpc->spi_clk),
> +				     "cannot get enabled spi clk\n");
> =20
>  	vdev =3D platform_device_alloc(name, PLATFORM_DEVID_AUTO);
>  	if (!vdev)

This change is not exmplained in the changelog, and it does not look
related to suspend. I guess it is too late to do anything with it now.

Best regards,
								Pavel

--5DjKuOwpv6tbQyp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali3OAAKCRAw5/Bqldv6
8iHZAJ9wwMJHxTQEAv/WBbhH9qiWrBk+4wCgoZ6Th84xJfwvK386fWvgVOOKOpw=
=uVMP
-----END PGP SIGNATURE-----

--5DjKuOwpv6tbQyp0--

