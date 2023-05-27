Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F2C77B73
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 07:39:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6622.1685173166573424359
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 00:39:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C6D501C0AAC; Sat, 27 May 2023 09:39:23 +0200 (CEST)
Date: Sat, 27 May 2023 09:39:23 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Message-ID: <ZHGzq91g7AC8PP/b@duo.ucw.cz>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420A2C36904A2A95575D48892479@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JTBaWvoBfP2T/VQa"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420A2C36904A2A95575D48892479@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 07:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11659


--JTBaWvoBfP2T/VQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > All these patches are cherry-picked from the mainline.
> >=20
> > v1->v2:
> >  * Dropped patch#2 and patch#3 and replaced
> >    SYSTEM_SLEEP_PM_OPS->SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> >    and pm_sleep_ptr->DEV_PM_OPS.
> >=20
> > Chris Paterson (1):
> >   dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
> >=20
> > Fabrizio Castro (2):
> >   dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
> >   arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
> >=20
> > Geert Uytterhoeven (1):
> >   arm64: defconfig: Enable additional support for Renesas platforms
> >=20
> > Ioana Ciornei (1):
> >   driver core: add a helper to setup both the of_node and fwnode of a
> >     device
> >=20
> > Phil Edworthy (5):
> >   clk: renesas: r9a09g011: Add IIC clock and reset entries
> >   dt-bindings: i2c: Document RZ/V2M I2C controller
> >   i2c: Add Renesas RZ/V2M controller
> >   arm64: dts: renesas: r9a09g011: Add i2c nodes
> >   arm64: dts: renesas: rzv2m evk: Enable i2c

> I reviewed this series, LGTM.
> I can apply, if we do not get any issue.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/090289427e=
8b2be9dac126c4d1b760b100f2c6b8
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

They look good to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JTBaWvoBfP2T/VQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHGzqwAKCRAw5/Bqldv6
8g3XAKCtBSMML1UrpyzDQnm04E3/79l7oQCdHE91FZAZah22mMeKH5cyrkam6gc=
=TZeN
-----END PGP SIGNATURE-----

--JTBaWvoBfP2T/VQa--

