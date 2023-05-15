Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C0C77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 20:34:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1615.1684182840930654203
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 13:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 723861C0E4B; Mon, 15 May 2023 22:33:59 +0200 (CEST)
Date: Mon, 15 May 2023 22:33:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 2/4] dmaengine: sh: rz-dmac: Add reset support
Message-ID: <ZGKXNyv5QJgs2q8Y@duo.ucw.cz>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
 <20230515085352.25794-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vRfHoS7hONp1dZv8"
Content-Disposition: inline
In-Reply-To: <20230515085352.25794-3-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 20:34:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11459


--vRfHoS7hONp1dZv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add reset support for DMAC module found on RZ/G2L alike SoCs.
>=20
> For booting the board, reset release of the DMAC module is required
> otherwise we don't get GIC interrupts. Currently the reset release
> was done by the bootloader now move this to the driver instead.

> @@ -896,6 +903,10 @@ static int rz_dmac_probe(struct platform_device *pde=
v)
>  		goto err_pm_disable;
>  	}
> =20
> +	ret =3D reset_control_deassert(dmac->rstc);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
>  	for (i =3D 0; i < dmac->n_channels; i++) {
>  		ret =3D rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
>  		if (ret < 0)
> @@ -940,6 +951,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> +	reset_control_assert(dmac->rstc);
>  	channel_num =3D i ? i - 1 : 0;
>  	for (i =3D 0; i < channel_num; i++) {
>  		struct rz_dmac_chan *channel =3D &dmac->channels[i];

I'd put it reset_control_assert() after the for () loop freeing the
channels, to be symetrical with the init order.

> @@ -972,6 +985,7 @@ static int rz_dmac_remove(struct platform_device *pde=
v)
>  	}
>  	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&dmac->engine);
> +	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>

AFAICT

dma_async_device_unregister(&dmac->engine);
of_dma_controller_free(pdev->dev.of_node);

would better match the init code, too.

(This does not need fixing for -cip merge).

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vRfHoS7hONp1dZv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGKXNwAKCRAw5/Bqldv6
8sRPAJ0WQFi6FK/3TLzqG6bCvgMreO6S5gCfd60xhB2w1zfZoamk0oy1kO6sZRk=
=l8Wn
-----END PGP SIGNATURE-----

--vRfHoS7hONp1dZv8--

