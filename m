Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B884C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 21:00:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1325.1658782834487599591
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 14:00:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE0BE1C0009; Mon, 25 Jul 2022 23:00:31 +0200 (CEST)
Date: Mon, 25 Jul 2022 23:00:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 16/24] ASoC: sh: rz-ssi: Release the DMA
 channels in rz_ssi_probe() error path
Message-ID: <20220725210031.GB2302@duo.ucw.cz>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-17-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20220715072244.2298757-17-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 21:00:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8905


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit 767e6f26204d3f5406630e86b720d01818b8616d upstream.
>=20
> DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
> never released in the error path apart from one place. This patch fixes
> this issue by calling rz_ssi_release_dma_channels() in the error
> path.

I believe this is correct, but...
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -976,14 +976,18 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
> -	if (ssi->irq_int < 0)
> +	if (ssi->irq_int < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return ssi->irq_int;
> +	}

> +	if (ret < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "irq request error (int_req)\n");
> +	}

>  	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -	if (IS_ERR(ssi->rstc))
> +	if (IS_ERR(ssi->rstc)) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return PTR_ERR(ssi->rstc);
> +	}

I believe we have enough cases to use "goto cleanup" style to reduce
code duplication.

>  	if (ret < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		pm_runtime_disable(ssi->dev);
>  		reset_control_assert(ssi->rstc);
>  		return dev_err_probe(ssi->dev, ret,
> "pm_runtime_resume_and_get failed\n");

Plus, we usually do cleanup in reverse order of init.

Best regards,
                                                        Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt8EbwAKCRAw5/Bqldv6
8ojRAJ0XM7p3UkKp/yj+VAvlVQonQSaDfQCghqOvhAuS1bMEopR3gS5pALxq3qM=
=+72p
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

