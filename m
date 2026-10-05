Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEDBCA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 20:21:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29812.1791231715586462501
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Oct 2026 13:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PGtgQ4PI;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9477107E14;
	Mon, 05 Oct 2026 22:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1791231709; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=ACQZ5IKhe2vkEoYxbmuHG/1FOpSk/tQWB15MKyoAAjk=;
	b=PGtgQ4PID0XNA0yCVdeK0SmlwVNEbaQSPA7SIOzt0F4Rlq5u/nAY/sYHRNGYCyGYn+cQFb
	//DifUKVW1ZQivUDiHvBQhi+WlsAjimgI6C84bWo860r/El8UY1KUb+dzfQsDh/wdtSsbc
	J7fItNp/B3qqMkaOSPHTEw8ZQJ8CKZN7yNrPhZ6kpUHh7cND1JwjUXL0qIWEwATuanK8i1
	qcA+ZLQ1D9oJHZlffavMWwkMAhLjXFicUiih8ZtqCwvkb8ZdtVZWoVNqzFLTSnbl6mFibw
	WF2ABRbENYeiAeN7xjgU2v5nnDUJqMQVEYZi1vH5KaNPWN0Mmen4ID5isJZDdw==
Date: Mon, 5 Oct 2026 22:21:46 +0200
From: Pavel Machek <pavel@nabladev.com>
To: ".kiszka"@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip115-rt63
Message-ID: <asQG2kwxcJq0oZEt@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NNP/sYWRJ/iGxP07"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Oct 2026 20:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24430


--NNP/sYWRJ/iGxP07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--NNP/sYWRJ/iGxP07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCasQG2gAKCRAw5/Bqldv6
8qikAKCnwff9/ueKOJeXp4KzG6ZE575DEgCeLKwstrl41WWBeQQqvUT8A61r6lc=
=po4C
-----END PGP SIGNATURE-----

--NNP/sYWRJ/iGxP07--

