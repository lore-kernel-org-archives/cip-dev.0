Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5BFC3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 09:02:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.46219.1746435762159333181
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 May 2025 02:02:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HSdjEtv8;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31B9610382D36;
	Mon,  5 May 2025 11:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746435760; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ga8aIN37WOGgalLK+lPlDgmmyVpu34XEaV8W3y25iq4=;
	b=HSdjEtv8l+qc5kxMitatgCHmEWUc4FhlWn6zUAyMDDHKt4oV4fANeL4faVKvMj8rrFITYx
	UsK9NjVX1kQXWjD997zY9beddm/nVot7asZGU4WRp2CQjzuQZxEZFntVvPqsRVsG/H5Qbk
	vEr2b5oR31H4hnGJ9b2x54BuSA8gWpYl2BlsCJkFSg4NzRuLD1fqn9S+egsxg0QFYTtLUC
	5yXRJrcoe/2lzjZYUB9sshXRU1ba++GC022J4Dl5vkGMXZrcNsGzSpMFfzULjMzkJztyFn
	14NC4ufXl7Hnpr7S8bIBUIsHymYIy6y+/3h6dwfZK1CU737Zb00aejge/e8Gyw==
Date: Mon, 5 May 2025 11:02:34 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.134-cip41-rt22 (rt51)
Message-ID: <aBh+qjlbIPY+xeLo@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5IL7W0S/DRTuc4MB"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 May 2025 09:02:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18760


--5IL7W0S/DRTuc4MB
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
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5IL7W0S/DRTuc4MB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBh+qgAKCRAw5/Bqldv6
8vw8AJ9hWeKuBZMQ640E510TEJv6cl/YQQCeJku3VEuKcWQ4h+riF129WsbDZkI=
=qOMg
-----END PGP SIGNATURE-----

--5IL7W0S/DRTuc4MB--

