Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B66C761A6
	for <webhook@archiver.kernel.org>; Thu, 30 Mar 2023 11:32:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.22500.1680175942437396104
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Mar 2023 04:32:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 09CE01C0DE7; Thu, 30 Mar 2023 13:32:19 +0200 (CEST)
Date: Thu, 30 Mar 2023 13:32:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st39, 4.4-cip74, 4.4-cip74-rt43
Message-ID: <ZCVzQnoWvB/hIGnU@duo.ucw.cz>
References: <1611211333.1066638.1680166351379@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhqClwi+ZNRvuv3E"
Content-Disposition: inline
In-Reply-To: <1611211333.1066638.1680166351379@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Mar 2023 11:32:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11135


--RhqClwi+ZNRvuv3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st39, 4.4-cip74 and 4.=
4-cip74-rt43 releases that should be reviewed, and that can currently be fo=
und in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/lo=
g/?h=3Dlinux-4.4.y-st-rc
>=20
> Trivial backports:

a | d2d3052d9 6f8ecb o+ | gpio: vf610: connect GPIO label to dev name
a | 09fa241bc 4971c2 o+ | ima: Align ima_file_mmap() parameters with mmap_f=
ile LSM hook
a | 38345d84e aa56b9 o  | dm flakey: fix logic when corrupting a bio
a | c214be981 709fca o  | Bluetooth: hci_sock: purge socket queues in
a | 85f922f42 c22c3b o+ | net: phy: smsc: bail out in

These look good.

 | c075aa346 5d5aa2 o  | ARM: dts: exynos: Use Exynos5420

This one is wrong. Old compatible is used in
drivers/phy/phy-exynos-mipi-video.c . Suggested new compatible is not
used anywhere, so this would break things.

 | 9acadaf26 a98fc2    | staging: rtl8192e: Remove function ..dm_check_ac_d=
c_power calling a script
 | 1c4293ded fe413a    | staging: rtl8192e: Remove call_usermodehelper star=
ting RadioPower.sh

I'd not bother with staging stuff. Plus, these are not really
bugfixes, they are really cleanups. I'd suggest we drop these.

> Not completely trivial backports, and/or stuff that touches important sub=
systems:
>=20
a | 4e3b4b170 9a5571 o+ | f2fs: fix information leak in f2fs_move_inline_di=
rents()
a | 5621f7a81 256fe4 o  | udf: Do not update file length for failed writes =
to inline files
I assume this is preparation for next patch? | 11790a4fa b06730 o+ | irqdom=
ain: Fix association race
a | 30b560087 3f883c o+ | irqdomain: Fix disassociation race
a | b40d2fbf4 4d57a7 o+ | ubi: ubi_wl_put_peb: Fix infinite loop when wear-=
leveling work failed
a | 3df6f492f db4df8 o  | tty: fix out-of-bounds access in tty_driver_looku=
p_tty()
a | 438d62a68 c4c81d o  | tty: serial: fsl_lpuart: disable the CTS when sen=
d break signal

> I would also like an opinion or two on the importance of this patch:
>=20
> ** i | d5cf15857 e88b2c o+ | bpf: Fix 32 bit src register truncation on d=
iv/mod
>=20
> I have chosen not to include it because it would require backporting quit=
e a bit of infrastructure. According to the bug report at https://bugzilla.=
redhat.com/show_bug.cgi?id=3D1981954, the issue is not exploitable for out-=
of-bounds accesses on 4.4.
>

I agree with not including this one. It backport would be tricky, and
testing it would be even trickier.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RhqClwi+ZNRvuv3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZCVzQgAKCRAw5/Bqldv6
8oI5AKC9zQzd9zMMLSOFeDNBLPUWF+IHiwCffNHlYJ7vw2Z/aacENWD4vvB3/lg=
=yQW7
-----END PGP SIGNATURE-----

--RhqClwi+ZNRvuv3E--

