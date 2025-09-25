Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7526CAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 11:31:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.9363.1758799895799108490
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 04:31:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eOnWv1MG;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 215FD1038C110;
	Thu, 25 Sep 2025 13:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758799893; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NhRKwUPV4EzpDX60mLDdw4Wf4xY6Yh1OLW2qJ0pE3mo=;
	b=eOnWv1MGwoijEQkCBkBWwd/vyqqJVtowfl57N9sWuOJxdfepuPkLnurqHSF2H6/dcI/7+H
	XY9hMJh4KuuxKsCHSKkRUUzMJAcDfyhyigM7O3cAw/m6NMYI8ONqU2/ej0XU+Yji/C8rWk
	IvnIw9ZKy5Kr8VyEwOGZqIB6/V7wzzeFwPu0S2KfnjTukCS4QKnBBXPc9o98DeadC1RbMM
	Ufg1U4TafswHqPc+lsOMsAFRw6F0fJQaeUbjk7IrhZOk8W8OtxSQ8pREwCeGE0CJyRszSP
	a5MaDnlHPjNcHYFDzjaSVc1oBvsS0SZp7hA+trbL6nM8H3C2LuoHKPWyMcI9Fg==
Date: Thu, 25 Sep 2025 13:31:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st68, 4.4-cip103
Message-ID: <aNUoD/wl6NLMxyC7@duo.ucw.cz>
References: <886040472.424568.1758727128905@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ubt9yDi4vU1nl60l"
Content-Disposition: inline
In-Reply-To: <886040472.424568.1758727128905@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 11:31:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20134


--ubt9yDi4vU1nl60l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
> (Probably. I still get stuck in an endless Anubis loop...)
>

Thanks for patches, they look good to me.

I'm not sure about "rtc: ds1307: remove clear of oscillator stop flag
(OSF) in probe" -- that changes behaviour, seems to be support for new
hardware, and code changed significantly there.

Best regards,
								Pavel
							=09
a just a statistic fix > 159bdce6d6b70 net: dlink: fix multicast stats bein=
g counted incorrectly
a > 457628f8cb01d atm: atmtcp: Prevent arbitrary write in atmtcp_recv_contr=
ol().
a > 0fe446c3739a9 usb: musb: omap2430: fix device leak at unbind
a > 98463a4924f3f cdc-acm: fix race between initial clearing halt and open
a > 3d068492060e1 usb: hub: Don't try to recover devices lost during warm r=
eset.
a > 5f55f645b658f usb: hub: avoid warm port reset during USB3 disconnect
a > d96c623bf8136 net: usbnet: Avoid potential RCU stall on LINK_CHANGE eve=
nt
!a just an interface tweak, maybe not? > 42e0edaf813d5 rtc: ds1307: remove =
clear of oscillator stop flag (OSF) in probe
a > d4532e8667c07 pNFS: Fix uninited ptr deref in block/scsi layout
a > 2f838b922217b net: fec: allow disable coalescing
a > 237504b56084d securityfs: don't pin dentries twice, once is enough...
a > 0d7cd3075bfab netfilter: ctnetlink: fix refcount leak on table dump
a just a WARN fix for crazy requests > ab712c7a36c55 fs: Prevent file descr=
iptor table allocations exceeding INT_MAX
a > 6b5d680b684d2 usb: gadget : fix use-after-free in composite_dev_cleanup=
()
a > 84e1d7c1d29c3 net/packet: fix a race in packet_set_ring() and packet_no=
tifier()
a > 45aa0cdcd2901 netfilter: xt_nfacct: don't assume acct name is null-term=
inated
a > 9812a62c6fcbb iwlwifi: Add missing check for alloc_ordered_workqueue
a that code is quite "interesting" > efdf5a1cdd46d usb: hub: fix detection =
of high tier USB3 devices behind suspended hubs
a > 538d08a48cee4 net_sched: sch_sfq: move the limit validation
a just an _ONCE annotation > 9424395985175 net_sched: sch_sfq: annotate dat=
a-races around q->perturb_period
a > 8d28e6639a4c5 net_sched: sch_sfq: don't allow 1 packet limit

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ubt9yDi4vU1nl60l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaNUoDwAKCRAw5/Bqldv6
8t/gAKCXLE+BBPZWPaZh3CKvdQmxgTPZMwCbB3Nx7AhfJ34+rGQqK2iNAN37Gbo=
=C7kl
-----END PGP SIGNATURE-----

--ubt9yDi4vU1nl60l--

