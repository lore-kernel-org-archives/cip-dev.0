Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A45C77B73
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 12:31:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10798.1685795494466047750
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Jun 2023 05:31:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A34F31C0E65; Sat,  3 Jun 2023 14:31:31 +0200 (CEST)
Date: Sat, 3 Jun 2023 14:31:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st41, 4.4-cip76
Message-ID: <ZHsyoeIMsGf0RtLS@duo.ucw.cz>
References: <1864470219.2230353.1685607500584@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0EdO/y+u6HBQPOv+"
Content-Disposition: inline
In-Reply-To: <1864470219.2230353.1685607500584@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 12:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11752


--0EdO/y+u6HBQPOv+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st41 and 4.4-cip76 rel=
eases that should be reviewed, and that can currently be found in https://g=
it.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.4=
=2Ey-st-rc
>

These look good to me:

> Trivial backports:
>=20
a | 998080b96 c77065 o+ | i2c: omap: Fix standard mode false ACK readings
a | 911c66cfc 8ee3b0 .+ | drm/rockchip: Drop unbalanced obj unref
a | 6378f4810 40882d o+ | NFSv4.1: Always send a RECLAIM_COMPLETE after est=
ablishing lease
a | bd89073fc 28a65b o  | nilfs2: do not write dirty data after degeneratin=
g to read-only
a | 5a229d21b 2220ea o  | ext4: add bounds checking in get_max_inline_xattr=
_value_size()
a | 021d30d05 04e827 o  | serial: 8250: Reinit port->pm on port specific dr=
iver unbind
a | 1afc51187 9be24f .  | mcb-pci: Reallocate memory region to avoid memory=
 overlapping
a | 1a0b65dad a398d5 o  | usb-storage: fix deadlock when a scsi command tim=
eouts more than once
a | 0c9f71a5b d2b005 o  | serial: Add support for Advantech PCI-1611U card
a | d5fb07429 9b5a04 o  | nilfs2: fix use-after-free bug of nilfs_root in n=
ilfs_evict_inode()
>=20
> Equally trivial backports, but with differences in context large enough t=
o warrant a second look:
>=20
a | serial: 8250: Add missing wakeup event reporting
a | 74400353b a8e478 o+ | drm/probe-helper: Cancel previous job before star=
ting new one

There is extra whitespace change here:

-- | 7dd95a282 4c0b48 o  | ext4: improve error recovery code paths in __ext=
4_remount()

This is just READ_ONCE annotation. Lets take it, but it does not
really fix anything, so I'd not too much effort there.

-- a | 8e7655da8 a939d1 o+ | netlink: annotate accesses to nlk->cb_running

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0EdO/y+u6HBQPOv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHsyoQAKCRAw5/Bqldv6
8kIdAJ4w+mC1+lRg+XiSPnenSOA9PPTyPACgkqgDXO+kiu34sWrCG8tYyGjPms0=
=loB0
-----END PGP SIGNATURE-----

--0EdO/y+u6HBQPOv+--

