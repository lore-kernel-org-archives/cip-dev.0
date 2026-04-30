Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF66CD13D2
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 22:32:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2577.1777588340957291608
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 15:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EUBR0Iar;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C11C1130AC;
	Fri,  1 May 2026 00:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777588338; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=LwF1VXYk9rLJozsnFeb24pDNyLvnVU9o+GeYDpL8rvg=;
	b=EUBR0IarNhZ2lz4dcDjNxIIQIFbfUNGKhvJ6R4tdZ0WNJOa0YThjLQhg2QuGpHTgfBPint
	GFzR878IAsrprI3qeD1oaUxuU2cXo04SX9/pxmBCTM21IbzaQB2OVm1Y0Y7GF5+/Pap2oF
	IE4De8QHr/AI2uKej26RtwLl/LrktzYP8+B22Z2BXwwIBueFIRJrCp2s9LYNhSNgci5vcb
	HQPSAjf4snQXYabx/HgISATDZFpXYw1oS2wcEL3PcRaJAwDzCGS1Scto/k81Y6SquzSFAH
	nHJFW2SyA0Th3FScQeEiWOg9q0VJvweVuC1Dfsts8/Ai9doQgJbKlcVMHeDBQg==
Date: Fri, 1 May 2026 00:32:14 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] v6.12.85-cip22
Message-ID: <afPYbpiCZUBFDZxz@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBFmmHxZecvM9Edg"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 22:32:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22832


--zBFmmHxZecvM9Edg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -cip release should be available at kernel.org. It is early due to
CVE-2026-31431.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.12.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.12.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--zBFmmHxZecvM9Edg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafPYbgAKCRAw5/Bqldv6
8umHAKCQwJ62YGkDuZ0R0gC4STOPr0CCtgCfbA6GWyk42dfP+dFterwJNdBpmCQ=
=Kwck
-----END PGP SIGNATURE-----

--zBFmmHxZecvM9Edg--

