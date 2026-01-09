Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDE0D16802
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:32:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7487.1767954771548140359
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:32:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dvwWK21F;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDAB310D517;
	Fri,  9 Jan 2026 11:32:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767954769;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g4z+e8Ru8YfQBHABQHow/H4fXL9mxzezK1czV+f3iXA=;
	b=dvwWK21Fl7EzQScM8gtcStp2B0atwF1gaaHiazAUmVssOK6POzyz+WWCT5ej207KX++w6l
	L7SyhtwrwpIBamQth0acJFI7HkOzK5gA1zcpf8zq7U+a+FB8AGmwSRyx1KIqUoO3dZVlOc
	0w2JxX9bdzdF0a7N/I7/UdaK1zmRu/bXtcRIS6LfZLgpVpF9WpEjtU8ndPYeY83N7zgLC8
	Alg4icItQH7rb5O5xYcnPtV0RJYFdpwusjdpH56+f1HEndPB5SN4r8H7MyK7bq4JnmtZTh
	rj7KJRISjx3K6kpRw9j8ruNieO4LTnpfKrUtFBxtDBSfk+yJMrIJVQkgNngPBA==
Date: Fri, 9 Jan 2026 11:32:44 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 20/22] hwmon: (tmp108) Add support
 for I3C device
Message-ID: <aWDZTMbsXtg2Ht08@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-21-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="caHwO7QWd3bQpa3v"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-21-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:32:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21499


--caHwO7QWd3bQpa3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Frank Li <Frank.Li@nxp.com>
>=20
> commit c40655e3310649866c4ebf7a10f0d53802ebdfa9 upstream.
>=20
> Add support for I3C device in the tmp108 driver to handle the P3T1085
> sensor. Register the I3C device driver to enable I3C functionality for the
> sensor.
>=20
=2E..

> +++ b/drivers/hwmon/Kconfig
> @@ -2061,6 +2061,7 @@ config SENSORS_TMP108
>  	tristate "Texas Instruments TMP108"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select REGMAP_I3C if I3C
>  	help
>  	  If you say yes here you get support for Texas Instruments TMP108
>  	  sensor chips and NXP P3T1085.

Ok, so config says "enable this for P3T1085 support", and we allow
user to enable this without I3C.

> +++ b/drivers/hwmon/tmp108.c
> @@ -440,7 +441,39 @@ static struct i2c_driver tmp108_driver =3D {

> +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev =3D i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +
> +#ifdef CONFIG_REGMAP_I3C
> +	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> +#else
> +	regmap =3D ERR_PTR(-ENODEV);
> +#endif
> +
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +

And then we fail the probe with "Failed to register i3c regmap"
message. That looks quite confusing to me.

Best regards,
								Pavel

--=20
In cooperation with Nabla.

--caHwO7QWd3bQpa3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDZTAAKCRAw5/Bqldv6
8vNPAKCLDvmwF3gohi99kG06kFeduWm+vACghLHuJZcA2JrZ3KIg6PiMjJsbeeM=
=6uOO
-----END PGP SIGNATURE-----

--caHwO7QWd3bQpa3v--

