Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859ABFF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 20:00:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23814.1777924798903416568
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 12:59:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=aystbjAt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B982F113FE6;
	Mon,  4 May 2026 21:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777924796; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=eT73xStAKTxMFmhs1I6uObnlBI8mk4c+eXYVw0b0ddA=;
	b=aystbjAtR4KeUYHNF43UVRghcACC16bW0XtTtGLMbsUtHb8zGNtLFlmkYy1w8iJ2fyQvBL
	aFctQO+tE2++iP9Hb1xuMcnZ0pk3p+0oR+rn274fIsx7tYP5Uet6C20/FG/W9gjial4Eun
	GSe8WRv8QpBHnlJKk4crc6UuPIv9JL7VhJmNqZojnl3emmc8YEmz8wiXA1A8EfWr475rEh
	Rn9TSdH50z/f4rD0o7V4g8UufUxxK4YN1bvcPhSS55DgU+OoCfqA1d4+hrR6i8DKcDM7IX
	T7N3+xDmJoKFc2TneJpuIOkxg5wvoQ3q9yO3mhGIptn02q8aD0kVUG6qOwy9+w==
Date: Mon, 4 May 2026 21:59:53 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.254-cip72-rt32
Message-ID: <afj6uUrML8OhfyQC@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L7vhtbFUPv6nE9Ay"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 20:00:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22865


--L7vhtbFUPv6nE9Ay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org. These are
"special" -- were done quickly in response to CVE-2026-31431. Suitable
stable-rt kernel was not available, so this is based
v5.10.254-rt150-rc1. Additionally, this inherits problems on Renesas
boards from v5.10.254-cip72, see that announcement and "phy: renesas:
rcar-gen3-usb2: Fix the use of msleep..." discussion for details.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--L7vhtbFUPv6nE9Ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafj6uQAKCRAw5/Bqldv6
8jJQAKCB+48Q6vwyircw7HlwinCLNTyUJgCgtZwzqzB+UKtWEqVkg68b1SxkWvA=
=2xML
-----END PGP SIGNATURE-----

--L7vhtbFUPv6nE9Ay--

