Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70083F459F8
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 16:38:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.160770.1775839082917392484
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 09:38:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=B+xvryPM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D05E4113682;
	Fri, 10 Apr 2026 18:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775839079;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/IiXCtdZWv7r8Evl+/kYkxgWwTyRWUVcV5FZW/J004s=;
	b=B+xvryPM/GltV4pylO0ZcAgG4ewGYSgo5YoG1nKlJ5AWbNTZvI5coxzcP1AhCMOXxUccIx
	O8A1MKrePHSFI508teKbOKyWVFUU7HNbLuwo9VDqdDzRYlOiePC3SJxGrwTmwZ5OFd6xDM
	gt+MTJUddIY6v2EJ703AUZPoY4EF+61NOR+7JyHn0jfIpBfASvFFAlutDyiYAbHaVQetbG
	hbise0AozpX+uFHWISbSpkWXxNqz5kkBSCOextlpWhaPHZlKrqltUXYsGCLBKcYIPL8T4Y
	CFGakQgwKdpk11OcYP9zYlb5jBYunr3JuUv2hQY3grevRO7+CDy87t9XwJGQ+g==
Date: Fri, 10 Apr 2026 18:37:55 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st15, 4.19-cip131
Message-ID: <adknY4VCZ6n0VZCJ@duo.ucw.cz>
References: <1933779544.248038.1775719721901@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="02LRl0mmzU1dxLUb"
Content-Disposition: inline
In-Reply-To: <1933779544.248038.1775719721901@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 16:38:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22662


--02LRl0mmzU1dxLUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
a > 630e7903d2418 nfsd: fix return error code for nfsd_map_name_to_[ug]id
a just a robustness against bad hw > 96e0a5c848e8c net: usb: pegasus: enabl=
e basic endpoint checking
a > 963b4ef89d7d6 Bluetooth: L2CAP: Fix not checking l2cap_chan security le=
vel
a just a preparation, may break compatibility > a973f99e737ba Bluetooth: En=
force key size of 16 bytes on FIPS level
a > bcdd464658030 xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
a just an API fix > 8906907dd0fae netfilter: nf_conntrack: Add allow_clash =
to generic protocol handler
a > 13c736b3eb26c ext4: don't cache extent during splitting extent
a > cb6f09dc9ae18 apparmor: fix rlimit for posix cpu timers
>=20

Patches look good to me, thank you!

Best regards,
								Pavel


--02LRl0mmzU1dxLUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadknYwAKCRAw5/Bqldv6
8pDkAKCMZ6NYoLYzoaaIgjJpvs8LPusXjwCgwnhrJmrJqHTtdduCZLVizJMMRG8=
=TfQH
-----END PGP SIGNATURE-----

--02LRl0mmzU1dxLUb--

