Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE074CFB45A
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 19:55:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1332.1728330936610103934
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Oct 2024 12:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9867C1C0082; Mon,  7 Oct 2024 21:55:33 +0200 (CEST)
Date: Mon, 7 Oct 2024 21:55:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st57, 4.4-cip92
Message-ID: <ZwQ8tc+9S/gDDy5/@duo.ucw.cz>
References: <1841375864.2314304.1727945930345@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="le/IvcJczrKXbkwy"
Content-Disposition: inline
In-Reply-To: <1841375864.2314304.1727945930345@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Oct 2024 19:55:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17012


--le/IvcJczrKXbkwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

I see additional patch in the branch:

? fbcon: Prevent that screen size is smaller than font size

It seems ok. I have two comments below:

a just a robustness > cb18618cde9e0b rtmutex: Drop rt_mutex::wait_lock befo=
re scheduling
a > 2cf61544745a4a nilfs2: protect references to superblock parameters expo=
sed in sysfs
a just a preparation > 70b6df109f705e nilfs2: replace snprintf in show func=
tions with sysfs_emit
a > c238fad7c56339 of/irq: Prevent device address out-of-bounds read in int=
errupt map walk
! missing locks[level] =3D ? > f6a9c01857b6ce btrfs: clean up ourhandling o=
f refs =3D=3D 0 in snapshot delete

I'd expect path->locks[level] =3D 0;, but if it is a problem, then
problem exists in mainline too.

a > d8503ffe1bf81c cgroup: Protect css->cgroup write under css_set_lock
a > 2e25daf10039e9 udf: Avoid excessive partition lengths
a > 87dc99ef544f29 nilfs2: fix missing cleanup on rollforward recovery error
a > 28636a45c5431b mmc: dw_mmc: Fix IDMAC operation with pages bigger than =
4K
a > 2e18d3c2de0487 sch/netem: fix use after free in netem_dequeue
a > fac14924bceef0 block: initialize integrity buffer to zero before writin=
g it to media
a just an API tweak > 35c4dde44c6041 dm suspend: return -ERESTARTSYS instea=
d of -EINTR
a > c283ebf19e5280 drm/amdgpu: Using uninitialized value *size when calling=
 amdgpu_vce_cs_reloc
a > b915a8926cf4fb Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in=
 HCIUARTGETPROTO
a just a robustness > 9a02ec8b8d3f53 f2fs: fix to do sanity check in update=
_sit_entry
!! adds a WARN > be060e6fdb11b1 quota: Remove BUG_ON from dqget()

This converts BUG_ON to WARN.. which would be ok, but BUG was #ifdef
DEBUG, and WARN is not. I'd just drop this one. (Plus, I'm not sure
condition is correct one for 4.4 kernel, and it will not be easy to
check.)

> 1f43ccdf08b610 fuse: Initialize beyond-EOF page contents before setting u=
ptodate

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--le/IvcJczrKXbkwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwQ8tQAKCRAw5/Bqldv6
8lznAJ9KwuuVhR2BJsAXzgXD8KeacN38KQCgrG0E/KvK5U+Rb/ItURJ2N+pp20M=
=5vJo
-----END PGP SIGNATURE-----

--le/IvcJczrKXbkwy--

