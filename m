Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F93CD4851
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 08:46:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16900.1779180369227874704
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 May 2026 01:46:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Y3XqZNst;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F624115179;
	Tue, 19 May 2026 10:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779180367;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JYPumA04BwWkQtiBg05BNn3z2518WHKEA7JE3rkb8HI=;
	b=Y3XqZNstqys8xju6IQFxugxyYscL2WTD4c/A9Ad7ui65+E+9OuNtfwF7W1Yyj750ydsJU4
	MrhMPT5FMR+3SoqvyEVOoBvdJBtnEJadih3D/hb2sXM/haUOqOI09U2iO67XiuxtYlmXoQ
	+S2bAsOMmlXqPDdMYWtsMjdfau08Hot5scZWz2T7QWIbZcVmeLhJvUw+mP4+Sxq/ub9TJi
	FqZ/J0KuZk9+4sBoFzPiKQw7a7V5BtQv4uagiytVZ0QanBehypqS79vvQgLWCiFWdnYJXI
	Euez13/hDY2QDnyueiisl1slF4FTlOxApeDHLdk4ts4j8913NS1W1soWEnStsw==
Date: Tue, 19 May 2026 10:46:02 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st76, 4.4-cip111
Message-ID: <agwjSvMB5UW15Y0Q@duo.ucw.cz>
References: <596572994.133475.1779136794242@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1czRZf1SBc99P0V"
Content-Disposition: inline
In-Reply-To: <596572994.133475.1779136794242@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 May 2026 08:46:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22980


--k1czRZf1SBc99P0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Series looks good to me. I believe some of patches are same as the
mainline version? And may want to sign off the patches.

Thanks and best regards,
								Pavel

a just a hw bug workaround > 1369f9bda4b79 x86/CPU: Fix FPDSS on Zen1
a > 3f64e9548b885 virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE =
is cleared and napi_tx is false
a > 4a2616a1bc204 net: stmmac: fix integer underflow in chain mode
a > bcbb001290534 netfilter: nfnetlink_log: fix uninitialized padding leak =
in NFULA_PAYLOAD
a > 0e368cfcb8d95 PM: runtime: Fix a race condition related to device remov=
al
(I guess this one is unmodified from mainline?)

a > 596467b2c8a25 netfilter: ctnetlink: fix use-after-free in ctnetlink_dum=
p_exp_ct()

You may want to sign off this one.

a just a preparation > 5964034f67b50 netfilter: ctnetlink: remove refcounti=
ng in expectation dumpers

This one may be unmodified, too?

a just a timing fix > 20b9c909f5106 net/tcp-md5: Fix MAC comparison to be c=
onstant-time
a not a minimum fix > f8f81dfa5ec62 btrfs: abort transaction on failure to =
update root in the received subvol ioctl
a > f949f9c5b025a usb: class: cdc-wdm: fix reordering issue in read code pa=
th
a just an accounting fix > 031802bdc81c9 net: usb: lan78xx: fix silent drop=
 of packets with checksum errors
a > e2402f11daafc xen/acpi-processor: fix _CST detection using undersized e=
valuation buffer
a > d46bd876ce21f drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
a > 8a344e750e899 media: dvb-core: fix wrong reinitialization of ringbuffer=
 on reopen
a > 0ca67aeb9a9d5 wifi: libertas: fix use-after-free in lbs_free_adapter()
>=20

--k1czRZf1SBc99P0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagwjSgAKCRAw5/Bqldv6
8tzGAKCe0elz/H/+qTYLdLx3iul3BCGIFQCfb6wyvunxvLj2wn3m6/ecxQVfOF8=
=3lWV
-----END PGP SIGNATURE-----

--k1czRZf1SBc99P0V--

