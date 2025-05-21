Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A54C2D0CD
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 06:42:44 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.4950.1747809762057247014
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 23:42:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BMRAoqH5;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3C9F1039728C;
	Wed, 21 May 2025 08:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747809759; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=tG/39BDojKVcUa3kRemjid4spxM+ImRXzv7ITQqMlXo=;
	b=BMRAoqH5ssiho3rwp7QdQO3rCQRQNtk3vOtyT+k6X/kTAnUjBMB2CcURJxbwFZRImvaobM
	KKo04xz/yWZhmt+w4v0o1G3nVFY09ol53TR2v/68QgCC5vz49RZRdiXAWeVt2zbQrakz9J
	tsoGfSLQJhleK/kkhvYp6GPYsYC2cAymd0TOWwy/8jkH4PjqKGgnPOSGM1bbBYvvhtmm9n
	Uv2LEViPjKNQRpgRbPaOJ75rLWX7KYmLH1yxZ28xRp61VRLnZoFX/+4lI0q+T/yVgQvoo6
	P9lgGfITqLmnlr8kGiH8X8P2HjAY+ifn7nCMuGA5HPKAuzczndrAVqQh7Za5xg==
Date: Wed, 21 May 2025 08:42:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: -stable-rc kernels are not being tested?
Message-ID: <aC112tFkcRZb6YAG@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tJ8v9hRg46T7qUYv"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 06:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18932


--tJ8v9hRg46T7qUYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.140-rc1 should be out for more than 8 hours now, but I don't see
it on our gitlab mirrors, so I can't get test results.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

I tried clicking around to find anything obviously broken, but I found
nothing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tJ8v9hRg46T7qUYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaC112gAKCRAw5/Bqldv6
8oDZAJ9eL+Yi1InWKUsDFn1QPU/qJJjbNgCeLF5RPf+FEZol7Ru9LEuuITbkUEk=
=xAvX
-----END PGP SIGNATURE-----

--tJ8v9hRg46T7qUYv--

