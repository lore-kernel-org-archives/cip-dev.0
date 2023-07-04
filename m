Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982AEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 20:09:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2708.1688501362277108292
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 13:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C1FF1C0DE7; Tue,  4 Jul 2023 22:09:20 +0200 (CEST)
Date: Tue, 4 Jul 2023 22:09:20 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Message-ID: <ZKR8cHWQHc6QPv6k@duo.ucw.cz>
References: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94201C9E1FC1A2DF030AA86D922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q1+PlDO/OFszjp4W"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94201C9E1FC1A2DF030AA86D922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 20:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12219


--q1+PlDO/OFszjp4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series aims to improve RZ/V2M I2C driver, based on the feedb=
ack
> > from Pavel.
> >=20
> > All these patches are cherry-picked from the mainline.
> >=20
> > Biju Das (3):
> >   i2c: rzv2m: Drop extra space
> >   i2c: rzv2m: Replace lowercase macros with static inline functions
> >   i2c: rzv2m: Disable the operation of unit in case of error
> >=20
>=20
> I reviewed this series. Looks fine to me.
> I can apply, if there are no comments and issues.
>=20
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919=
964303
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me.

Reviewed-by: Pavel Machek <pavel@denx.de>

It also looks identical (or very very similar) to 5.10 series. In such
case, I believe you can just do [PATCH 5.10, 6.1] and we'll apply it
to both branches. (It will likely be a bit easier for us, too).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--q1+PlDO/OFszjp4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKR8cAAKCRAw5/Bqldv6
8tW+AJ0SmDPqZa0PtwqtnJdFNBtPvE2C2wCff6tJkyWgp6FhZn2y0ieYD61IiXk=
=/i+T
-----END PGP SIGNATURE-----

--q1+PlDO/OFszjp4W--

