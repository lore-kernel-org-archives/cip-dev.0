Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8031F364A7
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 17:14:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.137977.1775754848326227387
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2026 10:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cnSfujt7;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9CDE113741;
	Thu,  9 Apr 2026 19:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775754845; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=JTnS0z2vB7eoxi272XNBDBnfvSG6I99A4an4rO4kU+4=;
	b=cnSfujt7Fs1aLeuL1zRiy6T2PAI5OKJ0m99HpABLWuyfXVEtGKP+hTCaMW3CLyhUTxn+CO
	quoXv+bMxppunWwghGaHFh59otjqyk+5Ln5xGQjnr0EY+kmY2L+vtuRrZa7fx6+hUwIxfz
	64oLyXMj6nxbcRexJI/KmJc0W9Xp1nDXmJg8i/5cvfgbr5Tw6v+lmTBgu8xV26oyIAM0Mp
	Ge9uUcyZvxEbN/SejfH/srF8zMHFYcHFNS3JKiINSx5gCUIqOfsGEJXxveVrEcpmF0p8YZ
	QB9+aty11aC+IcLLJxUgLYS8sHhtsOdnU7D8x5k4zhdM52DbHi6ixcf2dpnw1g==
Date: Thu, 9 Apr 2026 19:14:03 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip130-rt47
Message-ID: <adfeW2JAobr9pOXj@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jBdbwlpxj6VmftQc"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2026 17:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22660


--jBdbwlpxj6VmftQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--jBdbwlpxj6VmftQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadfeWwAKCRAw5/Bqldv6
8v/WAJ4pohP+6xKfr8j0amsFqEphe4gHLgCbBxOmgjDAq6AoDmL5ZKjTr/xtSEs=
=pbOK
-----END PGP SIGNATURE-----

--jBdbwlpxj6VmftQc--

