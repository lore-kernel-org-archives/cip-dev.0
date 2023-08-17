Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B9C2FC14
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 13:23:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.187388.1692278624152520072
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 06:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7BD3B1C0004; Thu, 17 Aug 2023 15:23:41 +0200 (CEST)
Date: Thu, 17 Aug 2023 15:23:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 07/13] rtc: isl1208: Make similar I2C and
 DT-based matching table
Message-ID: <ZN4fXPCSaD2MXiNL@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-8-biju.das.jz@bp.renesas.com>
 <ZN4AcXTOMBfKBtt3@duo.ucw.cz>
 <OS0PR01MB5922D24949EE819918555CA9861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qQpXGOZfyl2WdxJ5"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D24949EE819918555CA9861AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 13:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12765


--qQpXGOZfyl2WdxJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +++ b/drivers/rtc/rtc-isl1208.c
> > > @@ -90,10 +90,10 @@ static const struct isl1208_config {  };
> > >
> > >  static const struct i2c_device_id isl1208_id[] =3D {
> > > -	{ "isl1208", TYPE_ISL1208 },
> > > -	{ "isl1209", TYPE_ISL1209 },
> > > -	{ "isl1218", TYPE_ISL1218 },
> > > -	{ "isl1219", TYPE_ISL1219 },
> > > +	{ "isl1208", .driver_data =3D
> > (kernel_ulong_t)&isl1208_configs[TYPE_ISL1208] },
> > > +	{ "isl1209", .driver_data =3D
> > (kernel_ulong_t)&isl1208_configs[TYPE_ISL1209] },
> > > +	{ "isl1218", .driver_data =3D
> > (kernel_ulong_t)&isl1208_configs[TYPE_ISL1218] },
> > > +	{ "isl1219", .driver_data =3D
> > > +(kernel_ulong_t)&isl1208_configs[TYPE_ISL1219] },
> >=20
> > I'd expect to see "(unsigned long)" here.
>=20
> Because driver_data is kernel_ulong_t. See below
>=20
> struct i2c_device_id {
> 	char name[I2C_NAME_SIZE];
> 	kernel_ulong_t driver_data;	/* Data private to the driver */
> };

Aha, ok, that's quite unusual. Sorry for the noise.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qQpXGOZfyl2WdxJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN4fXAAKCRAw5/Bqldv6
8hFtAJ4yZDX39uqvgx7N4p5JF0HB633gPQCeMyL95sEZIyvLnL5fBYVK2o0J17Q=
=/fJu
-----END PGP SIGNATURE-----

--qQpXGOZfyl2WdxJ5--

