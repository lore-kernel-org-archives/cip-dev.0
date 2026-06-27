Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C63C43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 11:27:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53507.1782559666427271848
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 04:27:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=SUVGKOvm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D94AA116468;
	Sat, 27 Jun 2026 13:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782559664;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MVz8jxazEdR8g5uWLX6CYHW4goYtIOKvPYtnR/F5tyE=;
	b=SUVGKOvmxscBEDQ6t0e5fwZMRidpuUa5I33zOwYkpwxN+yJXYy3kwBSLaza5Jj1J5O3Bwj
	nTlAPw1Wpa7VgKUg4nkX32ZUcFLew/yxPYg8TEj6GTA08lVtyR+VF5dUaZdpcbSIEHQIYN
	S3aT7sGbNVv3lyxS6wN97ExilatF+gmCbMWD9Dor7SlBXfWetwRjWWQPJixBpou5Kr1iiA
	D2tWY8B+tcfvCXlcZ1oabtfqQCfJouO6p/iFIM24aT79PFtmQH3CHwYYJG3RGaPz8AMEjd
	nzRNcfAxFqNDp6ZxuTpamir8lotz9QLJNHE7p/KFQ/q3mexWFhHJKlKzajTDEQ==
Date: Sat, 27 Jun 2026 13:27:41 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 20/32] spi: rzv2h-rspi: use device-managed APIs
Message-ID: <aj-zrcibpelHmedH@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <20260617083003.1071543-21-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zyCZ8/5oCg7ddIfv"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-21-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 11:27:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23292


--zyCZ8/5oCg7ddIfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> commit b73ac782828f27c2217a17bd26aa8710769f032d upstream.
>=20
> Non-device-managed APIs were initially used here to avoid the buggy
> interaction between PM domains and device-managed actions.
>=20
> Commit f99508074e78 ("PM: domains: Detach on device_unbind_cleanup()")
> fixed the interaction between PM domains and device-managed actions.
>=20
> Simplify the code by using device-managed actions to unregister the SPI
> controller and to assert and release the resets.

> +++ b/drivers/spi/spi-rzv2h-rspi.c

>  static int rzv2h_rspi_probe(struct platform_device *pdev)
>  {
>  	struct spi_controller *controller;
>  	struct device *dev =3D &pdev->dev;
>  	struct rzv2h_rspi_priv *rspi;
> +	struct reset_control *reset;
>  	struct clk_bulk_data *clks;
>  	int irq_rx, ret, i;
>  	long tclk_rate;
=2E..
>  	irq_rx =3D platform_get_irq_byname(pdev, "rx");
>  	if (irq_rx < 0)
>  		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
> =20
> -	ret =3D reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to deassert resets\n");
> -
>  	init_waitqueue_head(&rspi->wait);
> =20
>  	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
>  			       dev_name(dev), rspi);
>  	if (ret) {
>  		dev_err(dev, "cannot request `rx` IRQ\n");
> -		goto quit_resets;
> +		return ret;
>  	}

I guess that for consistency, and to avoid spamming log in case of
PROBE_DEFER, this should be "return dev_err_probe()".

> @@ -622,31 +638,13 @@ static int rzv2h_rspi_probe(struct platform_device =
*pdev)
> =20
>  	device_set_node(&controller->dev, dev_fwnode(dev));
> =20
> -	ret =3D spi_register_controller(controller);
> -	if (ret) {
> +	ret =3D devm_spi_register_controller(dev, controller);
> +	if (ret)
>  		dev_err(dev, "register controller failed\n");
> -		goto quit_resets;
> -	}

Probably same here.

Thanks and best regards,
								Pavel

--zyCZ8/5oCg7ddIfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj+zrQAKCRAw5/Bqldv6
8mM+AJ9nYo14Ug3PIa0np/BpJFEjnvy0GACeNWIvqkhXAS0dx4DJ6Hgt0wjtyos=
=1beT
-----END PGP SIGNATURE-----

--zyCZ8/5oCg7ddIfv--

