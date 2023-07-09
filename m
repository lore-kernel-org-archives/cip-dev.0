Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F59EEB64DC
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 19:50:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.24662.1688932238260238185
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Jul 2023 12:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 97D051C0DFE; Sun,  9 Jul 2023 21:50:34 +0200 (CEST)
Date: Sun, 9 Jul 2023 21:50:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st42, 4.4-cip77
Message-ID: <ZKsPiq6+/Zx1CLHr@duo.ucw.cz>
References: <721088923.1980911.1688547506942@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUoJxwal0mZ0G6vS"
Content-Disposition: inline
In-Reply-To: <721088923.1980911.1688547506942@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 19:50:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12285


--VUoJxwal0mZ0G6vS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st42 and 4.4-cip77 rel=
eases that should be reviewed, and that can currently be found in https://g=
it.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.4=
=2Ey-st-rc
>=20
> trivial backports:
>=20

a| 61256d2d6 None o+ | netfilter: nft_dynset: do not reject set updates wit=
h NFT_SET_EVAL

Usual marking is "Commit xxx upstream.", this one has [ xxx ].

a | 42ca9589c 138906 o  | USB: core: Add routines for endpoint checks in ol=
d drivers
a | 72197f21d b8c75e o  | media: dvb-core: Fix kernel WARNING for blocking =
operation in wait_event*()
a | 66e262ad9 280a8a o  | media: dvb-core: Fix use-after-free due to race c=
ondition at dvb_ca_en50221
a | 22fb46cc1 2474e0 o+ | tty: serial: fsl_lpuart: use UARTCTRL_TXINV to se=
nd break instead of UARTCTRL_SBK
a | 1a5353475 fb686c o  | btrfs: check return value of btrfs_commit_transac=
tion in relocation
a | ff0e8ed8d 85f02d o  | btrfs: unset reloc control if transaction commit =
fails in prepare_to_relocate()
a | 1ba0925b4 b6ebaa o  | xen/blkfront: Only check REQ_FUA for writes
a | 2b88ccb93 50d927 o  | ocfs2: fix use-after-free when unmounting read-on=
ly filesystem
a | 6f40a2503 7651e2  + | IB/isert: Fix possible list corruption in CMA han=
dler
a | 5304616a6 48bfd0 .  | drm/exynos: fix race condition UAF in exynos_g2d_=
exec_ioctl

> slightly more interesting backports with non-trivial differences in conte=
xt:

a | 4e0dbab57 None o+ | netfilter: nf_tables: do not allow SET_ID to refer =
to another table

Again, usual marking is "Commit xxx upstream.", this one has [ xxx
]. And.. no this is not trivial backport.

a | 6119cae79 5c34c0 F+ | power: supply: bq27xxx: Fix bq27xxx_battery_updat=
e() race condition
a | 3bd7816c9 efb6b5 o+ | usb: gadget: f_fs: Add unbind event before functi=
onfs_unbind
a | 4bb5329c7 1e5c64 o+ | rfs: annotate lockless accesses to sk->sk_rxhash
a | b221b7189 409e87 o  | ceph: fix use-after-free bug for inodes when flus=
hing capsnaps

So... all seems to be good.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VUoJxwal0mZ0G6vS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZKsPigAKCRAw5/Bqldv6
8mDEAKCbzL9f3eD6VJwZ8Pphy3zeZGQmTQCeJcZo8yakT+UjxJa3Ltl4UIHEFtY=
=3zxz
-----END PGP SIGNATURE-----

--VUoJxwal0mZ0G6vS--

