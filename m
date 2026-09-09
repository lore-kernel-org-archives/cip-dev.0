Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197CC79FB7
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 19:23:19 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20798.1788981794910233970
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 12:23:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=K0MdNeHK;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B938102AC5;
	Wed, 09 Sep 2026 21:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788981788;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=09EGPnUUp+DU3RYDYp8F+rwmLyMPvPORaedHJ9a4NR8=;
	b=K0MdNeHKJembR4fSwTlAnr7IoClLhPje2ATeTfCOXcB5b5DojSwu/NPVSsvUpC5/BudPvQ
	7OlfzrYKmxdvx7n3zgLv73q+xi+pNilHRBfXBS0ET9KGGz99eCgsot+4xC8INS3jEm9aVe
	J2gA5+UkvPScJCbqTfBzGHla3bIu1AGQYw4Eb3P5bVqD/Kp7kAzqnD53BvtpUC7ocMQFeC
	fkpYUCRqVt3z/Jw6pgUJuZrWScDB0ZCl+sD+xSOswdYQdGjzczm+lYTbf+HAa0NJt7vAVI
	aD3NR9Qhb5Kon+x+G92wPNrc8zUhnQUxspmS4VStY2UYC51qW6d9dZH1UNePQQ==
Date: Wed, 9 Sep 2026 21:23:04 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
Message-ID: <aqGyGN25fPID67KZ@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8W2uu0fXmP7c60FC"
Content-Disposition: inline
In-Reply-To: <588742173.259606.1788373971804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 19:23:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24111


--8W2uu0fXmP7c60FC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the "manual" backports for the upcoming 4.19 kernel release. The=
re's a total of 68; 40 by me, and 28 by LLM. (The latter are labeled with "=
Assisted-by: SLTR:qwen-3.8".)
>=20
> As always they can be found in https://git.kernel.org/pub/scm/linux/kerne=
l/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

The openvswitch patch is not easy to review, rest looks okay.

Thanks and best regards,
								Pavel

a > e370b6e8d1a59 vhost: reset the vring metadata cache on vring reconfigur=
ation
a this makes me a bit nervous > 7d8fc6d0208be futex: Prevent robust futex e=
xit race some more
a > 3d3bcb5dd85d1 Input: evdev - fix information leak in evdev_pass_values()
a > a3e7176697ddd mm/huge_memory: unlock i_mmap_rwsem before releasing afte=
r-split folios
a > 96c6f93b3ff66 sctp: prevent peer transport count overflow
a > 39cf294824a31 net: bridge: stop fast-leave after deleting a port group
a > f0b272d10c9df mm/percpu-km: fix bitmap overflow and accounting in pcpu_=
create_chunk()
a > caba2e7b56939 ipv6: fib6: fix NULL deref in fib6_walk_continue() on mul=
ti-batch dump
! changing meaning of variable while keeping name is pretty anti-social > 5=
298659ef682c openvswitch: fix GSO userspace truncation underflow
a just a API fix > 031a2f99d475b vxlan: require CAP_NET_ADMIN in the device=
 netns for changelink
a > e7383f6dbb6b9 can: bcm: defer rx_op deallocation to workqueue to fix th=
rtimer UAF
a quite different from upstream fix > bd5b04d67545f tipc: fix u16 MTU trunc=
ation in media and bearer MTU validation
a > fd119cc5d1ce0 net/sched: act_tunnel_key: Defer dst_release to RCU callb=
ack


--8W2uu0fXmP7c60FC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqGyGAAKCRAw5/Bqldv6
8jxKAJ4jeII8DAOCHijHVbjeHn2VgBJP4QCfaazgJtKszAnaHuo83M1/COCrYHA=
=3B9g
-----END PGP SIGNATURE-----

--8W2uu0fXmP7c60FC--

