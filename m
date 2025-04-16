Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7AC369BD
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 10:49:14 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.16029.1744800544479534562
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 03:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VXDhrNPD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A45271039EF29;
	Wed, 16 Apr 2025 12:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744800542; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FJoq+/oN9nTGrw17Yx85sAme6bnejP5ugUds0Suef64=;
	b=VXDhrNPD3RHle+Iq48W3W6F5FBUFYL+bfbY/3iUFGzjaR/6JUpJ0LqESEq1dwp7UNMvITC
	uEu9iq2ftpwbqQ32ulilaqw1j8D7hvODfqMtVWFlWd8uyFsalfqfGbyZ2KK9zFdsi60DlU
	s5wjGibVNfIw9YXPZLnPe0be4X/YgNDEVwIn3I4yHVb9Z4midU2QXz+cnLUu7EHQOnOl4R
	k87jAjWcwZq1rDzLmlz/Q+G9BTn+D6X6MzhbfciItb1t9yc1R9YpWIPxKZnnYfipBo19z6
	EL39lbhcbsKa8B29kV0h8OH09TXCGYu/TDYO9ql/F3JpjV2Pc2lgY5AUMJlJSQ==
Date: Wed, 16 Apr 2025 12:48:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st63, 4.4-cip98
Message-ID: <Z/+LGM2q1rBi3Sgb@duo.ucw.cz>
References: <1262728637.101069.1744794403686@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QI/b/5f6Zr44pezE"
Content-Disposition: inline
In-Reply-To: <1262728637.101069.1744794403686@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 10:49:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18506


--QI/b/5f6Zr44pezE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the upcoming 4.4 kernel release. As
  always they can be found in
  https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc

"acct:" patch makes me a bit nervous, but patches look to me.

>=20
a > 2a7220968ef9 nilfs2: handle errors that nilfs_prepare_chunk() may return
a just an interface tweak > a19568ab17e4 wifi: nl80211: reject cooked mode =
if it is set along with other flags
a > 8004e7ee132f acct: perform last write from workqueue
a > cb22ed056a63 pfifo_tail_enqueue: Drop new packet when sch->limit =3D=3D=
 0
a > 91ae321630a0 geneve: Fix use-after-free in geneve_find_dev().
a > 89f949a9d75c ipv4: use RCU protection in inet_select_addr()
a > 69c4abc86ee6 ptp: Ensure info->enable callback is always set
a just a hw bug workaround > c9bd974f385b tg3: Disable tg3 PCIe AER on syst=
em reboot
a > 08f7a045863a usb: xhci: Fix NULL pointer dereference on certain command=
 aborts
a > 76519d4fbe4b net: rose: lock the socket in rose_bind()
a doing GFP_ATOMIC allocation for size from user is ... not nice > 719d7bc8=
be0d rdma/cxgb4: Prevent potential integer overflow on 32bit
a > b3b9ee117046 team: prevent adding a device which is already a team devi=
ce lower
>=20

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QI/b/5f6Zr44pezE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ/+LGAAKCRAw5/Bqldv6
8sZZAKDD4bslEG4P2aj+C8ZQ1zTEvrA6VgCfT8H8P2D8R5dlpc+5ucCqAgLcBzY=
=ieK8
-----END PGP SIGNATURE-----

--QI/b/5f6Zr44pezE--

