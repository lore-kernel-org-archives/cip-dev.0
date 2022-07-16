Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD1C433EF
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 10:54:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4254.1657968853088441384
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 03:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9121E1C0001; Sat, 16 Jul 2022 12:54:11 +0200 (CEST)
Date: Sat, 16 Jul 2022 12:53:51 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Message-ID: <20220716105351.GB18467@duo.ucw.cz>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 10:54:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8837


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 673c68bd48390dad01f7d17670de3e33b60860ac upstream.
>=20
> The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures the
> temperature inside the LSI.
>=20
> The thermal sensor in this unit measures temperatures in the range from
> =E2=88=9240 degree Celsius to 125 degree Celsius with an accuracy of =C2=
=B13=C2=B0C. The
> TSU repeats measurement at 20 microseconds intervals and automatically
> updates the results of measurement.
>=20
> The TSU has no interrupts as well as no external pins.
>=20
> This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.

> +#define TSU_SS_CONV_RUNNING	BIT(0)
> +
> +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> +#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
> +#define TS_CODE_CAP_TIMES	8	/* Capture  times */

Two spaces, plus "capture times" does not really explain much.

> +static int rzg2l_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct rzg2l_thermal_priv *priv =3D devdata;
> +	u32 result =3D 0, dsensor, ts_code_ave;
> +	int val, i;
> +
> +	for (i =3D 0; i < TS_CODE_CAP_TIMES ; i++) {
> +		/* TSU repeats measurement at 20 microseconds intervals and
> +		 * automatically updates the results of

According to CodingStyle, /* should be on separate line.

> +	dev_dbg(dev, "TSU probed with %s caliberation values",
> +		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");

Typo, should be "calibration" I guess.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtKYvwAKCRAw5/Bqldv6
8qoLAJ0TYgkKljBm58F/8/lyZIv2kAglzwCgg6DA1ZjZAdSqoutNeO20vTvhLnA=
=flFF
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

