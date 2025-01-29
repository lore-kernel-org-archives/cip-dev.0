Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F66C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 10:17:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9619.1738145824851617835
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 02:17:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=b7gX2nH5;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94E1410382D08;
	Wed, 29 Jan 2025 11:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738145823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MiW3BOM6OTbU/6c1GYuQr1Go+3vGnYcZK8xqHE+Kx48=;
	b=b7gX2nH5sUT6C/tR6XQGn0N5VgeiW4rk/lIqM/wB1S1u2w/LkzkLUKJZIaYq9ige/2JdVM
	cSwxulbYZgDjwpLZpJbaHLwotm82EC6NaNILae6RXfn8IE4ErUyeNKCjwxoDhkIK4zvWUC
	gRMAuALbppGSI8Ae3qfLqHXKgI0tbiNrtpu0WrF24vWmphkKDfES2papSPXMTwoGSX5RrE
	8OKdRDXbSi4dvQmFEmp6QmB4W2GthBvjpc6C30tm3CKx+DYo9tpe24quaNFjG6CgjsJCcg
	jWNnjugBB++Y19L9990ADt2koleTUBvcPHgJEK7I+Tvb9Ra72a+0gtpOgJrC5A==
Date: Wed, 29 Jan 2025 11:16:59 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.127-cip36-rt19 (rt48)
Message-ID: <Z5oAGySREnhysh0B@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R/NaZ7a6CJJbBFBm"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jan 2025 10:17:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17677


--R/NaZ7a6CJJbBFBm
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

--R/NaZ7a6CJJbBFBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5oAGwAKCRAw5/Bqldv6
8njyAJwO48/ux/NkbZDWvwC1Ij5pTiP+FgCfft5vQB7uBuVgeS/3C93bvmheYOw=
=wGY0
-----END PGP SIGNATURE-----

--R/NaZ7a6CJJbBFBm--

