Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6BEB8FA5
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 08:46:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4164.1693989963244658553
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 01:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C2A5A1C000B; Wed,  6 Sep 2023 10:46:01 +0200 (CEST)
Date: Wed, 6 Sep 2023 10:46:01 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 05/20] drm: rcar-du: rzg2l_mipi_dsi: Enhance
 device lanes check
Message-ID: <ZPg8SUiVWyqxw9O4@duo.ucw.cz>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D9/pArPtq62oglal"
Content-Disposition: inline
In-Reply-To: <20230905160737.167877-6-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 08:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12981


--D9/pArPtq62oglal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 418bb3a69e1355c8977c528f8f3896a0aaaecb80 upstream.
>=20
> Enhance device lanes check by reading TXSETR register at probe(),
> and enforced in rzg2l_mipi_dsi_host_attach().
>=20
> As per HW manual, we can read TXSETR register only after
> DPHY initialization.

So this is kind of strange:


> +++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
> @@ -220,12 +204,6 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_=
dsi *dsi,
>  			break;
>  	}
> =20
> -	ret =3D pm_runtime_resume_and_get(dsi->dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	clk_set_rate(dsi->vclk, mode->clock * 1000);
> -
>  	/* Initializing DPHY before accessing LINK */
>  	dphyctrl0 =3D DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN=
 |
>  		    DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR;
> @@ -259,10 +237,62 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi=
_dsi *dsi,
> =20
>  	ret =3D reset_control_deassert(dsi->rstc);
>  	if (ret < 0)
> -		goto err_pm_put;
> +		return ret;
> =20
>  	udelay(1);
> =20
> +	return 0;
> +}

If dsi_startup fails, it does not undo the hw register writes.

> +static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
> +{
> +	u32 dphyctrl0;
> +
> +	dphyctrl0 =3D rzg2l_mipi_dsi_phy_read(dsi, DSIDPHYCTRL0);
> +
> +	dphyctrl0 &=3D ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
> +	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
> +
> +	reset_control_assert(dsi->rstc);
> +}

If dsi_startup fails, this undoes the register writes, but
reset_control_assert is now redundant.

> +	ret =3D rzg2l_mipi_dsi_dphy_init(dsi, hsfreq);
> +	if (ret < 0)
> +		goto err_phy;
> +
>  	/* Enable Data lanes and Clock lanes */
>  	txsetr =3D TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) | TXSETR_CLE=
N;
>  	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr);
> @@ -301,7 +331,8 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_d=
si *dsi,
> =20
>  	return 0;
> =20
> -err_pm_put:
> +err_phy:
> +	rzg2l_mipi_dsi_dphy_exit(dsi);
>  	pm_runtime_put(dsi->dev);
>

So this looks strange.

My suggestion would be "rzg2l_mipi_dsi_dphy_init() cleans for itself
in case of errors" (as we usually do), so there's no need to do
rzg2l_mipi_dsi_dphy_exit() in casa of failure.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--D9/pArPtq62oglal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPg8SQAKCRAw5/Bqldv6
8iN+AKCx3HKGdh7iRcDI1VUdz2IrMJ9OOwCfVRXx4OlHgcozeWJs29pjsqWImdw=
=vqtD
-----END PGP SIGNATURE-----

--D9/pArPtq62oglal--

