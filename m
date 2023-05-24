Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BFDC77B7A
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 07:51:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3542.1684914661629081319
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 00:51:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1EB6D1C0DFE; Wed, 24 May 2023 09:51:00 +0200 (CEST)
Date: Wed, 24 May 2023 09:50:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 19/23] i2c: Add Renesas RZ/V2M controller
Message-ID: <ZG3B469M6oPKqDIB@duo.ucw.cz>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
 <20230519082058.109760-20-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/wU6kcRXRX17UdAA"
Content-Disposition: inline
In-Reply-To: <20230519082058.109760-20-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 07:51:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11628


--/wU6kcRXRX17UdAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Minor details I noticed during review (they should not prevent merge):

> commit e0ca796a151bd4de76efd71aade2b4805a95c93d upstream.
>=20
> Yet another i2c controller from Renesas that is found on the RZ/V2M
> (r9a09g011) SoC. It can support only 100kHz and 400KHz operation.

KHz should be kHz.

> +++ b/drivers/i2c/busses/Kconfig
> @@ -961,6 +961,16 @@ config HAVE_S3C2410_I2C
>  	  include I2C support for any machine, kindly select this in the
>  	  respective Kconfig file.
> =20
> +config I2C_RZV2M
> +	tristate "Renesas RZ/V2M adapter"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Renesas RZ/V2M  I2C interface.

Double space ("  ").

> +#define bit_setl(addr, val)		writel(readl(addr) | (val), (addr))
> +#define bit_clrl(addr, val)		writel(readl(addr) & ~(val), (addr))

Normally we'd put macro names in all uppercase.

> +static int rzv2m_i2c_probe(struct platform_device *pdev)
> +{
=2E..
> +	pm_runtime_get_sync(dev);
> +	rzv2m_i2c_init(priv);
> +	pm_runtime_put(dev);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret =3D i2c_add_numbered_adapter(adap);
> +	if (ret < 0)
> +		pm_runtime_disable(dev);

Is it possible that bit_clrl(priv->base + IICB0CTL0, IICB0IICE); is
missing before pm_runtime_disable?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/wU6kcRXRX17UdAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZG3B4wAKCRAw5/Bqldv6
8r54AJsERWwrirxAkKoQ5KAAh/jBLLpcZgCgmLlW2RNR7DbuAqVc1Q+bSY8weeA=
=ehY6
-----END PGP SIGNATURE-----

--/wU6kcRXRX17UdAA--

