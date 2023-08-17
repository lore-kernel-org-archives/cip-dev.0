Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E99C27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:06:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.184586.1692270412832201419
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 58C891C0004; Thu, 17 Aug 2023 13:06:51 +0200 (CEST)
Date: Thu, 17 Aug 2023 13:06:50 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 02/13] regulator: Add Renesas PMIC RAA215300
 driver
Message-ID: <ZN3/SjL50ls+3dnD@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pOOzjZBIj138wmwo"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-3-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12756


--pOOzjZBIj138wmwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/regulator/Kconfig
> @@ -1016,6 +1016,13 @@ config REGULATOR_QCOM_USB_VBUS
>  	  Say M here if you want to include support for enabling the VBUS output
>  	  as a module. The module will be named "qcom_usb_vbus_regulator".
> =20
> +config REGULATOR_RAA215300
> +	tristate "Renesas RAA215300 driver"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Support for the Renesas RAA215300 PMIC.
> +


"Say M here ... the module will be named..."?

> --- /dev/null
> +++ b/drivers/regulator/raa215300.c
> @@ -0,0 +1,190 @@

> +static void raa215300_rtc_unregister_device(void *data)
> +{
> +	i2c_unregister_device(data);
> +	if (!clk) {
> +		clk_unregister_fixed_rate(clk);
> +		clk =3D NULL;
> +	}
> +}

This one looks suspect. Should be (clk)?

> +static int raa215300_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	const char *clk_name =3D xin_name;
> +	unsigned int pmic_version, val;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &raa215300_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap i2c init failed\n");
> +
> +	ret =3D regmap_read(regmap, RAA215300_HW_REV, &pmic_version);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "HW rev read failed\n");
> +
> +	dev_dbg(dev, "RAA215300 PMIC version 0x%04x\n", pmic_version);
> +
> +	/* Clear all blocks except RTC, if enabled */
> +	regmap_read(regmap, RAA215300_REG_BLOCK_EN, &val);
> +	val &=3D RAA215300_REG_BLOCK_EN_RTC_EN;
> +	regmap_write(regmap, RAA215300_REG_BLOCK_EN, val);
> +
> +	/*Clear the latched registers */

"/* Clear". I would not mind checking errors from regmap here.

> +	ret =3D raa215300_clk_present(client, xin_name);
> +	if (ret < 0) {
> +		return ret;
> +	} else if (!ret) {
> +		ret =3D raa215300_clk_present(client, clkin_name);
> +		if (ret < 0)
> +			return ret;
> +

dev_err_probe would be consistent/useful for the other returns?

> +		clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, 32000);

Elsewhere, you use 32767 for a rate.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pOOzjZBIj138wmwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN3/SgAKCRAw5/Bqldv6
8qoUAKCa3Z5bObjO7Vz8VHGNnp6CSPOFJACfZhdhyZA3s+gPmpZIDe1JwRCVNKA=
=G9VB
-----END PGP SIGNATURE-----

--pOOzjZBIj138wmwo--

