Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59511C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 11:00:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.63082.1640862040792124992
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 03:00:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5D10C1C0B77; Thu, 30 Dec 2021 12:00:36 +0100 (CET)
Date: Thu, 30 Dec 2021 12:00:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 10/31] iio: adc: Add driver for Renesas RZ/G2L
 A/D converter
Message-ID: <20211230110035.GB9799@amd>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211229101530.22783-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20211229101530.22783-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 11:00:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7312


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit d484c21bacfa8bd2fa9fc26393ec59108f508c4c upstream.
>=20
> Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> trigger mode.
>=20
> A/D Converter block is a successive approximation analog-to-digital
> converter with a 12-bit accuracy and supports a maximum of 8 input
> channels.
>=20
> new file mode 100644
> index 000000000000..919108d798ba
> --- /dev/null
> +++ b/drivers/iio/adc/rzg2l_adc.c
=2E..
> +
> +#define RZG2L_ADSMP_DEFUALT_SAMPLING	0x578
> +

This should be "DEFAULT".

> +	do {
> +		usleep_range(100, 200);
> +		reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(0));
> +		timeout--;
> +		if (!timeout) {
> +			pr_err("%s stopping ADC timed out\n", __func__);
> +			break;
> +		}
> +	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
> +}

I'd write this as (reg & (RZG2L_ADM0_ADBSY | RZG2L_ADM0_ADCE)). Note
that we wait, then check for timeout without using the register
values. Which is strange and basically makes timeout one tick
lower. (But probably does not matter much).

> +static void rzg2l_set_trigger(struct rzg2l_adc *adc)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Setup ADM1 for SW trigger
> +	 * EGA[13:12] - Set 00 to indicate hardware trigger is invalid
> +	 * BS[4] - Enable 1-buffer mode
> +	 * MS[1] - Enable Select mode
> +	 * TRG[0] - Enable software trigger mode
> +	 */
> +	reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(1));
> +	reg &=3D ~RZG2L_ADM1_EGA_MASK;
> +	reg &=3D ~RZG2L_ADM1_BS;
> +	reg &=3D ~RZG2L_ADM1_TRG;

reg &=3D ~(RZG2L_ADM1_EGA_MASK | RZG2L_ADM1_BS | ...) would be usual way
to write this. You can use it in more than one place in the file.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHNkVMACgkQMOfwapXb+vKzhwCgko1nZDBcChv3PC+uTm7Ur9Ri
f5kAnRPkLkRrphZuDUlfoYBsd5eDLYJg
=VXnP
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

