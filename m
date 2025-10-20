Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C2CCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 08:15:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.13036.1760948136271245017
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Oct 2025 01:15:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Rz+ZFrSw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 957051038C11C;
	Mon, 20 Oct 2025 10:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760948134; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=kUc9zaHt8MHrfO/5EW8HjEXD5+0e1bgiEVD9zlD80UY=;
	b=Rz+ZFrSwdbDiNGCuDRzINb8wXUGiMrpit9BSmKM8WtIWAr8qZ48hQEiWlxerSV4PXnD0Jx
	WrA0zuXCKqzQQOb22zt///P6ry0r1MNAKkn5E33VA3AdBtttX/ravrGgZbbq/tJCVzjaI5
	xdSz9esf++ofwi9TwEp2uKQSREozAhXacObYwwuGcEXIJZrU5oqoh/CDrq+Ygyabuzq3Rm
	6cTpyUmhXEpmqDWw1RNF7YEZJ5EkYU4tfrH7H32fqBwQEHg2c1n8Xiu9RF1vl6LIcFLQ01
	LrjvgmVei89z3pbAYWgb1BABN/LwD1tRbC9Whj5P0NxUvS58ipkM490fXxtYuA==
Date: Mon, 20 Oct 2025 10:15:29 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.155-cip47-rt25
Message-ID: <aPXvod6tgxfsFIJI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S31ao/Jra7hvuzc8"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Oct 2025 08:15:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20198


--S31ao/Jra7hvuzc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--S31ao/Jra7hvuzc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPXvoQAKCRAw5/Bqldv6
8hvXAKCmC1w19o0Y0F9Lwksqgbxng17MtQCgteL8OKjCsRK5XzTaCawkATGw0/k=
=ljZn
-----END PGP SIGNATURE-----

--S31ao/Jra7hvuzc8--

