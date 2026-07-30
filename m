Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99103C54FD2
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 10:18:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8349.1785406683446223191
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 03:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GF2zglZa;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4E4811B7C3;
	Thu, 30 Jul 2026 12:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785406677; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=sav7B3XNg9cIcdvC7y4KftdA4pnk+IgMmz+m0Rki6zo=;
	b=GF2zglZapgnlUqWrseyNyh4TMRIQRDXmyPQ28F6Bkqi5XslckFKYEl0AuWdNqHjJ2BLxJG
	Il0BNY85/8dUPCMpIDH3CvYVIrIWBi+4HvrYot7wnX52eSVycQ3kiwbeY9GcAtvJxd2Ds7
	0nQcc3MM8c3bEmC84O+FrFa3zjV7DUvMKzcoiAfPwglr1xDTJ0ESO39YMYLmlQATFqpskR
	SuOuIDnBedOoHFFCyHlzWCAi9FfFTiqg1wpi9slFJ4LBx2RyTftmcjBCEG1vOIIVmXkE4l
	d7fLsP+q68ZRv7c6A2tOCHEGvV6PYSXb2B+Vb1nU7rZRDkC4ljNXe7lpnSNmzw==
Date: Thu, 30 Jul 2026 12:17:55 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip113-rt62
Message-ID: <amsk065vLxtC90zN@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nE6d3RstvdaByg62"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 10:18:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23818


--nE6d3RstvdaByg62
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

--nE6d3RstvdaByg62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamsk0wAKCRAw5/Bqldv6
8u5qAJ497n0QAe+1IGJTlE1H4y01pfPmBQCdGzoKjJuZ8os5pLNxk2epH7PT6+0=
=7UQp
-----END PGP SIGNATURE-----

--nE6d3RstvdaByg62--

