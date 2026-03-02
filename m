Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A4E9B352
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 10:02:44 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.157320.1772445759318459755
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 02:02:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RucB/cid;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CF4D101629;
	Mon,  2 Mar 2026 11:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772445756; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=6U2dmRq2AAMkkEae7IiqpSBRwO2PCuMw5YZYuL6irUw=;
	b=RucB/cid8NSi9B1j75zuczyeflDDMFEhP/Wof1B/tLw5BvRfLoGMDEy37onRXiStgB7zt/
	Sf1qUzgu7efjmmVm/Fmn6EfpUfJfYZdfWzRFaTIxUg0P7IrB9rEvsgbA8w4L9CMeTaYixB
	LMhXqHRZTWjqDq4WFIJWeg2siiUkLEzQchNeJRjss5FMMQM0pSxLr+tLR4AWXH5IwCU618
	yzzpivEKoAqE0gdi7k2Gs1+ODAZHE2TTYSRxqBXmqiqfb56eTdnbSXht9qjiXSvOyWWnUm
	bLO8KH9kAy5gz4Zx4o69bJaGaSXvUW6y0LqSfHrDpRosd91RgGWE/4m0E6KXbQ==
Date: Mon, 2 Mar 2026 11:02:33 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: No boards available for testing -- everything failing on gitlab
Message-ID: <aaVgOTtbrrgEHL2A@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wCX0XvVFeetAhGCF"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 10:02:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22034


--wCX0XvVFeetAhGCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I see all the runtime tests failing on gitlab (compilations work ok)
-- 0 boards available.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2357934585


57
09:56:19
There are currently 0 "r9a07g043f01-smarc-rzfive" devices online.
58
09:56:19
Refusing to submit test job as there are no suitable devices
available.
...

(And similar for other boards).

Can someone take a look?

Thanks,
								Pavel
--wCX0XvVFeetAhGCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaVgOQAKCRAw5/Bqldv6
8jlVAJ4uOw3u6InB37n7S7AaVmQRKrByZwCgtWNPNJVrpkEMHK/cLvSS83qgY6k=
=UQHQ
-----END PGP SIGNATURE-----

--wCX0XvVFeetAhGCF--

