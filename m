Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEBC433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 23:13:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.26328.1640214834688884452
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 15:13:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8293B1C0B81; Thu, 23 Dec 2021 00:13:44 +0100 (CET)
Date: Thu, 23 Dec 2021 00:13:43 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support for RZ/G2L
 family
Message-ID: <20211222231343.GA25345@amd>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 23:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7258


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 76e9353a80e9e9ff65b362a6dd8545d84427ec30 upstream.
>=20
> CANFD block on RZ/G2L SoC is almost identical to one found on
> R-Car Gen3 SoC's. On RZ/G2L SoC interrupt sources for each channel
> are split into different sources and the IP doesn't divide (1/2)
> CANFD clock within the IP.
>=20
> This patch adds compatible string for RZ/G2L family and splits
> the irq handlers to accommodate both RZ/G2L and R-Car Gen3 SoC's.


> +++ b/drivers/net/can/rcar/rcar_canfd.c
> +
> +static irqreturn_t rcar_canfd_global_err_interrupt(int irq, void *dev_id)
> +{
> +	struct rcar_canfd_global *gpriv =3D dev_id;
> +	u32 ch;
> +
> +	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> +		rcar_canfd_handle_global_err(gpriv, ch);
> +
> +	return IRQ_HANDLED;
> +}
> +

You are returning IRQ_HANDLED even when you do no handling. That
probably will not do harm as long as interrupts are not shared. Is
that guaranteed to be true?

> @@ -1577,6 +1653,53 @@ static int rcar_canfd_channel_probe(struct rcar_ca=
nfd_global *gpriv, u32 ch,
>  	priv->can.clock.freq =3D fcan_freq;
>  	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
> =20
> +	if (gpriv->chip_id =3D=3D RENESAS_RZG2L) {
> +		char *irq_name;
> +		int err_irq;
> +		int tx_irq;
> +
> +		err_irq =3D platform_get_irq_byname(pdev, ch =3D=3D 0 ? "ch0_err" : "c=
h1_err");
> +		if (err_irq < 0) {
> +			err =3D err_irq;
> +			goto fail;
> +		}

This leaks ndev; it should free_candev(ndev); before returning, AFAICT.

> @@ -1670,6 +1811,19 @@ static int rcar_canfd_probe(struct platform_device=
 *pdev)
>  	gpriv->pdev =3D pdev;
>  	gpriv->channels_mask =3D channels_mask;
>  	gpriv->fdmode =3D fdmode;
> +	gpriv->chip_id =3D chip_id;
> +
> +	if (gpriv->chip_id =3D=3D RENESAS_RZG2L) {
> +		gpriv->rstc1 =3D devm_reset_control_get_exclusive(&pdev->dev, "rstp_n"=
);
> +		if (IS_ERR(gpriv->rstc1))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc1),
> +					     "failed to get rstp_n\n");
> +
> +		gpriv->rstc2 =3D devm_reset_control_get_exclusive(&pdev->dev, "rstc_n"=
);
> +		if (IS_ERR(gpriv->rstc2))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc2),
> +					     "failed to get rstc_n\n");
> +	}
> =20
>  	/* Peripheral clock */
>  	gpriv->clkp =3D devm_clk_get(&pdev->dev, "fck");

The code is correct but it mixes direct returns with "goto
fail_dev", which is just alias for return. I'd prefer just doing
returns directly, but it really should not mix direct returns with
goto return.

> -	err =3D devm_request_irq(&pdev->dev, g_irq,
> -			       rcar_canfd_global_interrupt, 0,
> -			       "canfd.gbl", gpriv);

Strange. New code variant no longer allocates canfd.gbl?

> +	err =3D reset_control_reset(gpriv->rstc1);
> +	if (err)
> +		goto fail_dev;
> +	err =3D reset_control_reset(gpriv->rstc2);
>  	if (err) {
> -		dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
> -			g_irq, err);
> +		reset_control_assert(gpriv->rstc1);
>  		goto fail_dev;
>  	}

I'd introduce new label here, so that you don't need to do
reset_control_assert(gpriv->rstc1); at two different places... like
below...

Best regards,

								Pavel

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_=
canfd.c
index 52629c6c19702..ce9b3a0032bf8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1908,10 +1908,8 @@ static int rcar_canfd_probe(struct platform_device *=
pdev)
 	if (err)
 		goto fail_dev;
 	err =3D reset_control_reset(gpriv->rstc2);
-	if (err) {
-		reset_control_assert(gpriv->rstc1);
-		goto fail_dev;
-	}
+	if (err)
+		goto fail_reset1;
=20
 	/* Enable peripheral clock for register access */
 	err =3D clk_prepare_enable(gpriv->clkp);
@@ -1976,8 +1974,9 @@ static int rcar_canfd_probe(struct platform_device *p=
dev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+fail_reset1:
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }




--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHDsScACgkQMOfwapXb+vLyCgCggfdvW5/FO3azOmupVBoVMP8Z
mnwAnReWmU4Rdm248fy0lZeaRy1HTcUZ
=jpHp
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

