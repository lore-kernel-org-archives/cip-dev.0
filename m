Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B9BC54E65
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 10:07:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7682.1747822069748767644
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 May 2025 03:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DTM1IJnO;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 472711039728C;
	Wed, 21 May 2025 12:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747822067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IUrjeYDG/T5wRY7oYcfWGbVqUJXtvIgBU215Y2OwNZ4=;
	b=DTM1IJnOxiFM+gnVPEE4sZxyhVB1mb0Qm1CFovIOX0pyBZpP2EWlg5WGy7xulJft6fmfNR
	SE74oEIJ9Qqy5HreS5UG0nqsz8fAD+0hp0/As0qMTCLiG9dCKxG7pWqFvmxiVIK7a617Qx
	zeLlDoqEfELsen3h5mD7/l37mJRZzUDVa+Ek+cB1mg+SLA1qqKb5CVLPfYENcRo5o7jZQo
	PI5yJN9jOFZ6DFrb4+0jMjtev+tvKtMkzQbOvt3c1l1kyS6yXAyDolPHTolB3jHxFKJ9X4
	oJYiyl6UQgDPUbzStBaFBWmJuUMastzZvlgUOp4CFmE/BqB63k2Ewrz30bmPWw==
Date: Wed, 21 May 2025 12:07:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: -stable-rc kernels are not being tested?
Message-ID: <aC2l71hF4Kr9KcD1@duo.ucw.cz>
References: <aC112tFkcRZb6YAG@duo.ucw.cz>
 <OS3PR01MB58962F9214ED7C7DB899B5C9B79EA@OS3PR01MB5896.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wCZr3YTXZttzEtDk"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB58962F9214ED7C7DB899B5C9B79EA@OS3PR01MB5896.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 10:07:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18934


--wCZr3YTXZttzEtDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 6.1.140-rc1 should be out for more than 8 hours now, but I don't see
> > it on our gitlab mirrors, so I can't get test results.
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /tree/linux-6.1.y
> >=20
> > I tried clicking around to find anything obviously broken, but I found
> > nothing.
>=20
> Thank you for reporting this.
> Looks like we had an expired access token.
> All fixed and working again now.
>=20
> Lots of new pipelines running (including 6.1.140-rc1) so there may be a b=
it of a delay:
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
?page=3D1&scope=3Dall&source=3Dpush

Thanks for quick fix.

I'm still getting "runner system failures" such as:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/101003=
67933

I retried bunch of them to get results.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wCZr3YTXZttzEtDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaC2l7wAKCRAw5/Bqldv6
8hNBAJ9WbqW0pbYV4TtkeDPkT527CS/O1QCdGFUDWD/euEbqirA1j4XFHZ/7E0k=
=ixsD
-----END PGP SIGNATURE-----

--wCZr3YTXZttzEtDk--

