Return-Path: <SRS0=Hh2j=E5=lists.cip-project.org=bounce+64572+5831+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30BC2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:52:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5B20717
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OzKCJnbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5831+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id O44rYY4521723xjDp5Y4lWwj; Mon, 23 Nov 2020 11:52:32 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.40852.1606161151583193523
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:52:31 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4014C1C0BA9; Mon, 23 Nov 2020 20:52:29 +0100 (CET)
Date: Mon, 23 Nov 2020 20:52:28 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 7/7] spi: add Renesas RPC-IF driver
Message-ID: <20201123195228.GE5619@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123120354.26413-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VJsrhKFrGVH37LXATC9hRj8Ox4520388AA=
Content-Type: multipart/mixed; boundary="1NoQEleJ9efAioqYa7kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606161152;
 bh=UDSqPjyS6kKLv+jB8l3U9MxgMZ/ckhTSHRXqQIU+R4w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OzKCJnbE3HQAU0mpxfAirh7dNoPeugW574h+4Un042MYcszv3D9AtIAn+sPxidq+Wr1
 XbQTzXetDoBq8q4CVg70WP9IZQMFHym6CyBfN+4+g+rNozFthKgspS/ftbw0Z6N0FyYzt
 BLHrkkFVk4BkQF9tca2mRZ2D7w6ilnxEzd0=

--1NoQEleJ9efAioqYa7kv
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit eb8d6d464a27850498dced21a8450e85d4a02009 upstream.
>=20
> Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
> using the "back end" APIs in the main driver to talk to the real hardware.
> We only implement the 'spi-mem' interface -- there's no need to implement
> the usual SPI driver methods...
>=20
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Link: https://lore.kernel.org/r/1ece0e6c-71af-f0f1-709e-571f4b0b4853@coge=
ntembedded.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/spi/Kconfig      |   6 ++
>  drivers/spi/Makefile     |   1 +
>  drivers/spi/spi-rpc-if.c | 216 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 drivers/spi/spi-rpc-if.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 0a7fd56c1ed9..461315967f96 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -514,6 +514,12 @@ config SPI_RB4XX
>  	help
>  	  SPI controller driver for the Mikrotik RB4xx series boards.
> =20
> +config SPI_RPCIF
> +	tristate "Renesas RPC-IF SPI driver"
> +	depends on RENESAS_RPCIF
> +	help
> +	  SPI driver for Renesas R-Car Gen3 RPC-IF.

Few lines here explaining the acronyms etc. would be nice.

> +	error =3D spi_register_controller(ctlr);
> +	if (error) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto err_put_ctlr;
> +	}
> +	return 0;
> +
> +err_put_ctlr:
> +	rpcif_disable_rpm(rpc);
> +	spi_controller_put(ctlr);
> +
> +	return error;
> +}

With just one user of the error exit, I'd avoid the goto.

> +#ifdef CONFIG_PM_SLEEP
> +static int rpcif_spi_suspend(struct device *dev)
> +{
> +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> +
> +	return spi_controller_suspend(ctlr);
> +}
> +
> +static int rpcif_spi_resume(struct device *dev)
> +{
> +	struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> +
> +	return spi_controller_resume(ctlr);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_=
resume);
> +#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif
> +
> +static struct platform_driver rpcif_spi_driver =3D {
> +	.probe	=3D rpcif_spi_probe,
> +	.remove	=3D rpcif_spi_remove,
> +	.driver =3D {
> +		.name	=3D "rpc-if-spi",
> +		.pm	=3D DEV_PM_OPS,
> +	},
> +};

Can you just add "__maybe_unused" annotation and avoid the ifdefs,
like atmel-quadspi.c does?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+8EvwACgkQMOfwapXb+vI/xgCgt7K7QkdVBYLOqepa99GqxNH5
FO0AnRP38YJTouNq5QrmCHZxEDSDGBfW
=LtPN
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--1NoQEleJ9efAioqYa7kv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5831): https://lists.cip-project.org/g/cip-dev/message=
/5831
Mute This Topic: https://lists.cip-project.org/mt/78451549/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1NoQEleJ9efAioqYa7kv--
