Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EFC7114C
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18909.1650529987599435089
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 01:33:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C9A781C0B87; Thu, 21 Apr 2022 10:33:04 +0200 (CEST)
Date: Thu, 21 Apr 2022 10:33:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/24] ASoC: sh: rz-ssi: Add SSI DMAC support
Message-ID: <20220421083303.GB3269@amd>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20220420213424.27837-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8155


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -775,8 +949,18 @@ static int rz_ssi_probe(struct platform_device *pdev)
> =20
>  	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk=
_2;
> =20
> -	ssi->playback.transfer =3D rz_ssi_pio_send;
> -	ssi->capture.transfer =3D rz_ssi_pio_recv;
> +	/* Detect DMA support */
> +	ret =3D rz_ssi_dma_request(ssi, &pdev->dev);
> +	if (ret < 0) {
> +		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
> +		ssi->playback.transfer =3D rz_ssi_pio_send;
> +		ssi->capture.transfer =3D rz_ssi_pio_recv;
> +	} else {
> +		dev_info(&pdev->dev, "DMA enabled");
> +		ssi->playback.transfer =3D rz_ssi_dma_transfer;
> +		ssi->capture.transfer =3D rz_ssi_dma_transfer;
> +	}
> +
>  	ssi->playback.priv =3D ssi;
>  	ssi->capture.priv =3D ssi;
> =20

AFAICT rz_ssi_dma_request() allocates resources and
rz_ssi_release_dma_channels() is needed to free them if we fail.

But in most failure paths below, that's not done, with one exception:

> @@ -829,6 +1017,8 @@ static int rz_ssi_probe(struct platform_device *pdev)
>  					      rz_ssi_soc_dai,
>  					      ARRAY_SIZE(rz_ssi_soc_dai));
>  	if (ret < 0) {
> +		rz_ssi_release_dma_channels(ssi);
> +
>  		pm_runtime_put(ssi->dev);
>  		pm_runtime_disable(ssi->dev);
>  		reset_control_assert(ssi->rstc);

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJhFr8ACgkQMOfwapXb+vJB9wCdHUBfd3VuSSfisu7KjuaYVSCJ
IRMAnij8MHbL++/QiWFfWhVxpMUawesE
=zUAv
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

