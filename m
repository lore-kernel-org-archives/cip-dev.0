Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA25C433F5
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 08:41:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.73803.1638261710161656972
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 00:41:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D86CB1C0B76; Tue, 30 Nov 2021 09:41:39 +0100 (CET)
Date: Tue, 30 Nov 2021 09:41:37 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, bot@kernelci.org,
	Chris.Paterson2@renesas.com, alice.ferrazzi@miraclelinux.com
Subject: Re: [cip-dev] cip/linux-4.19.y-cip baseline: 121 runs, 1 regressions
 (v4.19.217-cip62) #kernelci
Message-ID: <20211130084137.GB2355@amd>
References: <61a58f0e.1c69fb81.ac5ac.8c21@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <61a58f0e.1c69fb81.ac5ac.8c21@mx.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 08:41:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7027


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> platform | arch | lab           | compiler | defconfig           | regres=
sions
> ---------+------+---------------+----------+---------------------+-------=
-----
> panda    | arm  | lab-collabora | gcc-10   | omap2plus_defconfig | 1     =
    =20
>=20
>   Details:     https://kernelci.org/test/plan/id/61a587a0ab3b0079bd18f6d7
>=20
>   Results:     5 PASS, 1 FAIL, 0 SKIP
>   Full config: omap2plus_defconfig
>   Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 2=
0210110)
>   Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.2=
17-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.txt
>   HTML log:
> https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217-cip62/arm/om=
ap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html

So this has enough information to tell me that we have a kernel
problem there, good:

02:08:17.792502  <6>[   18.847320] omap-mailbox 4a0f4000.mailbox: omap
mailbox rev 0x400
02:08:17.800596  <0>[   18.857543] BUG: spinlock bad magic on CPU#0,
udevd/110
02:08:17.808843  <6>[   18.857788] emif 4c000000.emif: emif_probe:
device configured with addr =3D (ptrval) and IRQ26
02:08:17.818753  <0>[   18.863311]  lock: emif_lock+0x0/0xffffecfc
[emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
02:08:17.825277  <4>[   18.877502] CPU: 0 PID: 110 Comm: udevd Not
tainted 4.19.217-cip62 #1
02:08:17.831655  <4>[   18.888275] Hardware name: Generic OMAP4
(Flattened Device Tree)
02:08:17.839660  <4>[   18.894195] [<c01123bc>] (unwind_backtrace)
=66rom [<c010cc28>] (show_stack+0x10/0x14)
02:08:17.847570  <4>[   18.900482] [<c010cc28>] (show_stack) from
[<c0949dd4>] (dump_stack+0xe0/0x114)
02:08:17.855211  <4>[   18.905761] [<c0949dd4>] (dump_stack) from
[<c01a9168>] (do_raw_spin_lock+0xbc/0x124)

Unfortunately, not enough information to debug the problem, I'm
afraid. Questions to start debugging this would be:

a) is the problem deterministic?

b) is the problem present in v4.19.217 ?

c) what were the last -stable and -cip kernels that worked?

d) what device/module is causing the BUG?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGl48EACgkQMOfwapXb+vIT5QCffMmMsRrshBKTBi6mAV/d5ftk
27YAn0QWaPlydCixfQd+5XojT8JfBn6t
=FqNi
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--

