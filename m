Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC9C43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 21:09:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6275.1783976945507636044
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 14:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JAPIVu5t;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 363591199CF;
	Mon, 13 Jul 2026 23:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783976942;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a0DAqtF80h7x/jKxHt5LT2bFOYNA0tRHr0b5nOw/FFY=;
	b=JAPIVu5twQHINTPL0+/beYfUTPgM/gfHNPOU1XRojp8rSERAiFCzHxNix3/k/LJ7BwblD+
	/DKGytcwDiaefM5a12AeSH3WJlQ0k15Zx+V9TRfdo/gPnAb7Pd1NnZg9nnMGvx2cK5slv9
	vMJcNtFeBGqBrF2UBO5LQG8Wf1V1DMsUTKtUjVkcogz0dldESblXkAWJfOuiqVNJ4X4qvX
	RsodZYE/InPFxSQODrprxCYdmMqA2KbdyaCPQtCx80SJkNt5kAyqsathC65NEumuuXDaZt
	C8a67YtpnDsiv9aBpH52nEqxqWpfZepKrAUzB0MMchk9rt3YDlIKxMVtQZpyFw==
Date: Mon, 13 Jul 2026 23:08:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: whyshall.dev@gmail.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Urgent: Regarding Fixing of Security Vulnerabilities
Message-ID: <alVT63ojQwHf4n7f@duo.ucw.cz>
References: <CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com>
 <Groupsio.1.CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUM76v5ZOxmSN6EN"
Content-Disposition: inline
In-Reply-To: <Groupsio.1.CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 21:09:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23567


--SUM76v5ZOxmSN6EN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We are planning to migrate our product to the Linux Kernel 4.19.y
>CIP release to benefit from its long-term maintenance and security
>updates.

Would you mind introducing yourself, your company, and your product?

Normally, we would recommend 6.12 kernel branch if you are doing the
migration, anyway.

> We have a few questions regarding security vulnerability tracking for the=
 CIP kernel:
>=20
> * Is there any tool, dashboard, or documentation available to determine:
>=20
> * The Kernel CVEs applicable to a specific 4.19.y CIP release.
> * Which CVEs have already been fixed till the given CIP release.
> * Which CVEs are still outstanding.

Take a look at
git@gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git .

> * If there are unfixed vulnerabilities that are considered critical
> for our product, what is the recommended approach to address them?

Approach is similar / same to what -stable kernels use.

Best regards,
								Pavel

--SUM76v5ZOxmSN6EN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalVT6wAKCRAw5/Bqldv6
8jrgAJ9juOsW90bgLRzn6hshExh3fHEafwCcCofzizbXvPATvpoA+DkFukb4RII=
=1stG
-----END PGP SIGNATURE-----

--SUM76v5ZOxmSN6EN--

