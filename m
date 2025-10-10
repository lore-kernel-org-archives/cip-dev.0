Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628DFCCA476
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 06:38:14 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2939.1760078292287807168
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Oct 2025 23:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LWqg1VgG;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF7CE101DB814;
	Fri, 10 Oct 2025 08:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760078290; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LSevH77OZaC0X7cgrx0WYEJIUi5m7r2UoVrkJsbaekE=;
	b=LWqg1VgGJfk/XstJqwWTWFs8u2gga6J3NC5LEqIGPHpAjZDkSqPSRZ6Pizq3Xdv9PKIYa8
	RsTeO27Yd6ncKYaa8484PuHloTNKG/GKOrlaSeQeM5R02Qa8J2SrpI5ttfgEqiL2BFJwJ4
	ksLId+z0rEGfa2j/suP5C520GJRe9JJfwFW+6kZ0/h5bLE//6HxtbFFvksrBL8W3vTZnCD
	JU25VUu2LXiwP9Zt48lIo92vUsa2YstmmX8R5kb+3CC3fAk0UO2BplR67JNWMpncHdy1Dz
	uyUKeXSNQNOfhuLsfpVh5JPxJULzQ2v0frCgqsjSm0TkACvxCITTF+y3rFzC0Q==
Date: Fri, 10 Oct 2025 08:38:06 +0200
From: Pavel Machek <pavel@denx.de>
To: lnasby@intwineconnect.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] v4.19.325-cip124 pipeline failure
Message-ID: <aOipzhKLNItjJODU@duo.ucw.cz>
References: <CAJ6VbXKtYC2r6+obQvCza9jtWTCsfRbzNGWFa6_MwZALR9qvJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PC2Iit8QoFQ0yQ+O"
Content-Disposition: inline
In-Reply-To: <CAJ6VbXKtYC2r6+obQvCza9jtWTCsfRbzNGWFa6_MwZALR9qvJg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Oct 2025 06:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20167


--PC2Iit8QoFQ0yQ+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> I noticed that the pipeline for v4.19.325-cip124 fails most of its tests.
> Should these be re-run, or should we assume this kernel is untested
> currently? Just curious as to if these kernel versions are safe to
> incorporate in another project, or if we should wait til these tests pass,
> or use another version that passes its gitlab pipeline.

Okay, so I assume that would be

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/linux-4.19.y-cip=
?ref_type=3Dheads

I hit retry on those tests, and I expect these are test issues, not a
real code issues, so that version should be safe to use.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PC2Iit8QoFQ0yQ+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaOipzgAKCRAw5/Bqldv6
8gEqAJ41Kpc4ghBYjJmthPKXZH967dUBNgCgpttIKXoJiREXbg8pJXi1XSDnFFQ=
=kpXd
-----END PGP SIGNATURE-----

--PC2Iit8QoFQ0yQ+O--

