Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A24C43334
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 10:50:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4227.1657968606976035494
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 03:50:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CF4BD1C0001; Sat, 16 Jul 2022 12:50:03 +0200 (CEST)
Date: Sat, 16 Jul 2022 12:49:56 +0200
From: Pavel Machek <pavel@denx.de>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] cip/linux-4.4.y-cip build: 187 builds: 5 failed, 182
 passed, 6 errors, 200 warnings (v4.4.302-cip69-508-gd887d54a1be6) #kernelci
Message-ID: <20220716104956.GA18467@duo.ucw.cz>
References: <62d01299.1c69fb81.afe7f.1e60@mx.google.com>
 <3a28a0046f2dbc660d2771617e81c08b60236f2f.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <3a28a0046f2dbc660d2771617e81c08b60236f2f.camel@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 10:50:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8836


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > cip/linux-4.4.y-cip build: 187 builds: 5 failed, 182 passed, 6 errors, =
200 warnings (v4.4.302-cip69-508-gd887d54a1be6)
> >=20
> > Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-c=
ip/kernel/v4.4.302-cip69-508-gd887d54a1be6/
> >=20
> > Tree: cip
> > Branch: linux-4.4.y-cip
> > Git Describe: v4.4.302-cip69-508-gd887d54a1be6
> > Git Commit: d887d54a1be6de9a74cb732ba80ecaf1cedefb61
> > Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.=
git
> > Built: 6 unique architectures
> >=20
> > Build Failures Detected:
> >=20
> > arm:
> >     rpc_defconfig: (gcc-10) FAIL
>=20
> The log tells me:
>=20
> arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
> arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=E2=
=80=99
>=20
> AFAIK armv3 support has been removed from gcc 9, we're using gcc 10
> here. If we still care about such boards we would have to switch to a
> older compiler (for that config). Don't know yet if that is possible in
> kernelci configuration.

I'm not sure what machine "rpc" is. It is quite probable it does not
really need armv3 instruction set.
>=20
> > mips:
> >     fuloong2e_defconfig: (gcc-10) FAIL
> >     ip27_defconfig: (gcc-10) FAIL
> >     ip28_defconfig: (gcc-10) FAIL
> >     lemote2f_defconfig: (gcc-10) FAIL
>=20
> According to [1] CIP does not have a single mips reference board, so I
> assume we could simply skip mips completely, right?
>=20
> Should we disable mips unconditionally for all branches, or just for
> 4.4. because it makes problems here? I would vote for 4.4 disablement
> only, but no idea if we can configure that in kernelci configuration.
> Let's see...

We could. Even better would be running 4.4-stable with same configs,
and see if they fail, too. If -stable works and -cip fails, we might
want to look into that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtKX1AAKCRAw5/Bqldv6
8m/zAJwObg9c3ne9Cy3VEtC8TJksu08WZwCgjH2Zd7sLLyidGIQEsXrEW9mOZd4=
=H9f4
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

