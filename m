Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C09EC0218F
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 11:59:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.17139.1738324780151715968
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jan 2025 03:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bXjj5LwF;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29F5710382D0E;
	Fri, 31 Jan 2025 12:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738324778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYy8ozIrrVO3m4iiYhK+li7JwCOyEM4rrgWpOM+lyRI=;
	b=bXjj5LwFVGXTIkCFChMX0NQ7EBMyfjHvUcT2+2MkVllln/PPT8pobeDFQpc0+KGLqkTl/D
	4AQCHYowpRc4IOc4W4SHORLyyzALvPaOOXqBlR0OXPwnEOX2dX5n0vlaNegsNIWR4amADl
	rXYTEO9JVT+/9BJwlV5MKqw6j1rHQHo3aR9eXctle+QVDQFZw9vkD+AywplTPCCJOG5MeB
	qIkHi6cZJw9M+hq/aCWs61VDnLuoAEvqQgkhjyAZyFQyRn6NKwwg27tbn3wPlYW/CCQVP0
	I57R7ixi2GZc5H01APSs/OZG1Ruqr80XhfGQNcT6P703Oe2wEAvPgDAYsnkrAw==
Date: Fri, 31 Jan 2025 12:59:33 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: karsten@fairphone.com
Subject: Re: [cip-dev] Questions about SLTS v4.19
Message-ID: <Z5y7JWvoj8ornlnH@duo.ucw.cz>
References: <D78HLVUGEZ2B.19ENWIOOSFW5A@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mk7oknvPSJHLQ6/"
Content-Disposition: inline
In-Reply-To: <D78HLVUGEZ2B.19ENWIOOSFW5A@fairphone.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jan 2025 11:59:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17718


--+mk7oknvPSJHLQ6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> I've got some questions regarding the SLTS v4.19 tree which I couldn't
> find an answer to on the website.
>=20
> As Fairphone, one of our Android devices, Fairphone 4 is running on a
> 4.19 kernel fork which was provided by Qualcomm. Unfortunately
> linux-stable support has run out and while we're looking into upgrading
> the kernel to a newer version, for now we're stuck with 4.19.
>=20
> Since CIP will continue maintaining the 4.19 kernel for the foreseeable
> future, we were thinking about starting to merge the v4.19 CIP releases
> into our tree, and continuing to do that for the foreseable future.

That sounds like a reasonable plan. Similar to 4.4-st, 4.19-st branch
should be best option for that (to be published soon).

> But it's not clear to me what is actually in scope for the 4.19 branch.
> At
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmai=
ntenance
> I see the text "For the 4.4 branch, the architectures we've committed to
> so far are arm (32-bit) and x86_64." but no info about 4.19, whether
> arm64 will be included, which is what our device is running on.

Arm64 should be in scope.

> And also while we're not a CIP member we'd like to know whether we can
> consider the CIP branches to be reasonably equivalent to the
> linux-stable branches, for example where we can assume that all known
> (security) issues will be getting the fixes backported, or how else it
> might differ from regular LTS.

Well, you can't rely on regular LTS to assume all issues are fixed,
and you should not rely on that with 4.19-st, either... but it should
be good base. We -cip/-st trees don't get as much testing as stable
trees do, so if you could set up testing on your hardware, that would
be good.

Of course, you are welcome to join CIP project, then you'll get chance
to improve project direction, will be able to put hw in the test labs,
etc ;-).

Now, not speaking for CIP or Denx... Well supported phone would be fun
to play with, but I'm not sure if hardware is easy to get in czech
republic, or if it is easy to get support for anything but Android...?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+mk7oknvPSJHLQ6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5y7JQAKCRAw5/Bqldv6
8vOaAJ0ZfrMUVFXbXUREgj0w9lwgjVXo5gCdED0KgPFiHhFXSSIq6XOi0f5ThOo=
=+zGZ
-----END PGP SIGNATURE-----

--+mk7oknvPSJHLQ6/--

