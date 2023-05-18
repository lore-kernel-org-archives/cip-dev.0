Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A9AC77B7A
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 21:34:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4853.1684445634778609986
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 May 2023 14:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 55BF21C0E4D; Thu, 18 May 2023 23:33:51 +0200 (CEST)
Date: Thu, 18 May 2023 23:33:50 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Message-ID: <ZGaZvnCWMW+cOXl1@duo.ucw.cz>
References: <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zVuVuw9EFbtTrnnB"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 21:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11524


--zVuVuw9EFbtTrnnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hi All,
> >=20
> > RZ/G2L MTU3a counter driver support is added to 6.4 mainline kernel [1].
> >=20
> > Counter framework restructure happened from 5.15 along with that all
> > vendor specific driver code is also updated[2] and [3]
> >=20
> > Other than that lot of sysfs entries added after 5.10 see [4]
> >=20
> > Q1) Do you have any suggestion how to support counter driver in 5.10.y-
> > cip?

Fun... Let me take a look. It would have been good to bring it up on
the IRC meeting, but I forgot.

> MTU3a Counter driver based on IIO framework is available in BSP[1].
>=20
> Is it acceptable to add MTU3a Counter driver support using IIO framework =
for=20
> 5.10.y cip kernel?

So AFAICT there are three possibilities:

1) Say we can't / don't want to merge the counter driver to 5.10-cip
as it is too intrusive. Would it be enough for you/your users to have
in 6.1-cip?

2) Update counter subsystem in 5.10-cip with patches from 5.15, then
merge the driver from 6.4.

3) Merge iio driver from rz-5.10-cip22 as is.

Are there other people using counter subsystem in 5.10-cip? If so, 2)
may interfere with their usage. 3) is a bit sad, as it presents
non-mainline interface to userland, and the userland code will need to
be updated. Plus 3) also violates our rules, as it is not mainline
backport.

Best regards,
								Pavel

> [1] https://github.com/renesas-rz/rz_linux-cip/blob/rz-5.10-cip22/drivers=
/clocksource/renesas-mtu3.c

> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> > t/?h=3Dv6.4-rc2&id=3D0be8907359df4c62319f5cb2c6981ff0d9ebf35a
> >=20
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> > t/drivers/counter?h=3Dv6.4-rc2&id=3Daaec1a0f76ec25f46bbb17b81487c4b0e1c=
318c5
> >=20
> > [3]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi
> > t/drivers/counter?h=3Dv6.4-rc2&id=3Db6c50affda5957a3629b149a91c7f6688ff=
ce7f7
> >=20
> > [4]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/D
> > ocumentation/ABI/testing/sysfs-bus-counter?h=3Dv6.4-rc2

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zVuVuw9EFbtTrnnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZGaZvgAKCRAw5/Bqldv6
8uFzAKCayyJeMeaFFYrbgFvQHCDydWDjxgCglusbzKWS4PsQtZQPiPRm8eZlPHA=
=A5sb
-----END PGP SIGNATURE-----

--zVuVuw9EFbtTrnnB--

