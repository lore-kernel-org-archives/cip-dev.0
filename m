Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB3EF99363
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 10:00:23 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16016.1776938420507319683
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 03:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EqgXa1GQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A2F1129E0;
	Thu, 23 Apr 2026 12:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776938418;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ku0/euqfVLrplqERzyjLnmFDYOVocPMlBw4px2e3XBM=;
	b=EqgXa1GQsAKpzqW3rlI4OMtmKdOTja1oG+p5yBg9JJb/1t2PJM8s4JJEOyddOS1MF7LimQ
	CIBYwi5gGUbT5p/uBaYPJqq38EkAr1tn4KWWtDdsEZKvSALyHnFCv7UuB9w+8+lK+F5jz1
	oIybMz5Pjia6CJDgbCNqyn74ftf0MIr5hTEDcZAZTlvH2xS7dufvjG9vJAcEt4vbEMrsqq
	IPasIRZFP4RCHylDYc9xXbAxqaJrqZ/yr/qD7oieKsIOcw6hkErK5DZMz2ijBc3f+weOcV
	jEtTxkohGi2tMUggpQv3L6qhoC8ovjsGuZdXZcYGkFEDomYVBojBK5y2zoYDsA==
Date: Thu, 23 Apr 2026 12:00:14 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st75, 4.4-cip110
Message-ID: <aentrtAsop2UI7t1@duo.ucw.cz>
References: <310741778.1030622.1776850439887@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AUM8br8pbtow/UgW"
Content-Disposition: inline
In-Reply-To: <310741778.1030622.1776850439887@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Apr 2026 10:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22792


--AUM8br8pbtow/UgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Patches look okay to me, thank you!

Best regards,
									Pavel


a just a robustness against malicious hw > 7c091280e3bb2 net: usb: pegasus:=
 enable basic endpoint checking
a > e2727eb73284b ceph: supply snapshot context in ceph_zero_partial_object=
()
a just an API fix> 2574b34a8eb2d xen-netback: reject zero-queue configurati=
on from guest
a quite complex/e > 14894a8decc71 net: atm: fix crash due to unvalidated vc=
c pointer in sigd_send()
a > de412dd7471d2 PCI/portdrv: Fix potential resource leak
a just a tracing fix > 1837000f16f5e hrtimer: Fix trace oddity
a > 5525cf4093568 md/raid10: fix any_working flag handling in raid10_sync_r=
equest
a just a robustness against malicious hw > 554c2968593e9 net: usb: catc: en=
able basic endpoint checking
>=20
> Thanks for having a look!

--AUM8br8pbtow/UgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaentrgAKCRAw5/Bqldv6
8p22AKCtmMVOfZfFvQiQjLGLePZk4YTnNgCfTkSIdMHC0PV+7OqA0X1ZNVtUKs4=
=TTGu
-----END PGP SIGNATURE-----

--AUM8br8pbtow/UgW--

