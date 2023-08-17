Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71968C41513
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 13:27:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.187243.1692278837478702310
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 06:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A72D01C0004; Thu, 17 Aug 2023 15:27:15 +0200 (CEST)
Date: Thu, 17 Aug 2023 15:27:14 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Message-ID: <ZN4gMm5Nmng8SDrN@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
 <ZN4BgzG2xmzOzdFZ@duo.ucw.cz>
 <OS0PR01MB59228E95C12FD0624CB955C5861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SSBTwxHwPqcvx8Z"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59228E95C12FD0624CB955C5861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 13:27:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12766


--7SSBTwxHwPqcvx8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > If using an external crystal, the XTOSCB bit needs to be set at 0 to
> > > enable the crystal oscillator.
> >=20
> > > +++ b/drivers/rtc/rtc-isl1208.c
> > > @@ -6,6 +6,7 @@
> > > @@ -175,6 +176,20 @@ isl1208_i2c_validate_client(struct i2c_client
> > *client)
> > >  	return 0;
> > >  }
> > >
> > > +static int isl1208_set_xtoscb(struct i2c_client *client, int sr, int
> > > +xtosb_val) {
> > > +	/* Do nothing if bit is already set to desired value */
> > > +	if ((sr & ISL1208_REG_SR_XTOSCB) =3D=3D xtosb_val)
> > > +		return 0;
> >=20
> > XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1, te=
st
> > will never succeed. I don't think that's intended.
>=20
> As mentioned in the comment, check is to avoid unnecessary
> writing to I2C register if it is same value.
>=20
> 0 & 1 =3D=3D 0 -->skip
> 0 & 1 =3D=3D 1 -->write
> 1 & 1 =3D=3D 0 --> write
> 1 & 1 =3D=3D 1 -->skip
>=20
> Is it expected result right?

As far as I can see, you'll get

#define ISL1208_REG_SR_XTOSCB  (1<<6)

xtosb_val =3D 1;

  64 & 64 =3D=3D 1
  64 =3D=3D 1
  false --> write

when you should be skipping.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7SSBTwxHwPqcvx8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN4gMgAKCRAw5/Bqldv6
8umGAJ9pb/aTHD0v9h84B0UeWADUFgLaDwCghunhtwxvj8k4OHkj9iGepoJeNWg=
=NMYI
-----END PGP SIGNATURE-----

--7SSBTwxHwPqcvx8Z--

