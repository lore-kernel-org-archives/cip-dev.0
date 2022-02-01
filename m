Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F81C433EF
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:20:52 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.46915.1643714450970233623
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:20:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9BA621C0B81; Tue,  1 Feb 2022 12:20:47 +0100 (CET)
Date: Tue, 1 Feb 2022 12:20:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 16/27] memory: renesas-rpc-if: Add support for
 RZ/G2L
Message-ID: <20220201112046.GE30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7555


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> commit b04cc0d912eb80d3c438b11d96ca847c3e77e8ab upstream.
>=20
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
>=20
> This patch adds a new compatible string for the RZ/G2L family so
> that the timing values on RZ/G2L can be adjusted.


> index 367b0d72bf62..40bca89268c3 100644
> --- a/drivers/mtd/hyperbus/rpc-if.c
> +++ b/drivers/mtd/hyperbus/rpc-if.c
> @@ -132,7 +132,9 @@ static int rpcif_hb_probe(struct platform_device *pde=
v)
> =20
>  	rpcif_enable_rpm(&hyperbus->rpc);
> =20
> -	rpcif_hw_init(&hyperbus->rpc, true);
> +	error =3D rpcif_hw_init(&hyperbus->rpc, true);
> +	if (error)
> +		return error;
> =20
>  	hyperbus->hbdev.map.size =3D hyperbus->rpc.size;
>  	hyperbus->hbdev.map.virt =3D hyperbus->rpc.dirmap;

This needs to rpcif_disable_rpm() before returning, AFAICT.

> +++ b/drivers/spi/spi-rpc-if.c
> @@ -156,7 +156,9 @@ static int rpcif_spi_probe(struct platform_device *pd=
ev)
>  	ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
>  	ctlr->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
> =20
> -	rpcif_hw_init(rpc, false);
> +	error =3D rpcif_hw_init(rpc, false);
> +	if (error)
> +		return error;
> =20
>  	error =3D spi_register_controller(ctlr);
>  	if (error) {

Same here.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmH5F44ACgkQMOfwapXb+vKLcACfVncVmoys4nw5iRvcHmoex8+0
ng4AmgJSvCU6Z3XMLONE2QESduVRlItq
=IKYA
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--

