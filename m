Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE0FFF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 09:58:01 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16500.1777543073812438530
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 02:57:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=csI6SZov;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 846BF113CBF;
	Thu, 30 Apr 2026 11:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777543071;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BLrL99e0KdP0EhmDW2Q2G7e6X6osw7lJDIMIYQA7dRI=;
	b=csI6SZove3zr+2PKXH8+jiC7tV/Z1a2iBrPQ5ZttmMhZvCYFeuecRPN4veR3YfASlPSTo6
	W2T1ywg5ksHSC2lSlNlfJIhj3rIA+DWbwZMBvNYrewIj3wy1x9lv4pAAYIaXpZT+CMWm1t
	Rw3nnNRe+JiYCURYpblboT0R1paYkVF/H0pxmfkoCApTiZMX/QoyA2WihoJRbql/x6r7fQ
	jdzBvLp0XT0mqHP4nGlILPHFmSDGTWXwiAAzena/bOkNyYInknafbTCt+TwMwoJdHl2y7s
	f8BTXbpvrW+C+N+p4bp8eO4PImme1X1aPUDkRXxUSZbpQSXO8eAK1U5XgYQZkw==
Date: Thu, 30 Apr 2026 11:57:49 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: masami.ichikawa@miraclelinux.com,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: "Copy fail" -- Fun CVE -- CVE-2026-31431, likely should do
 out-of-schedule releases
Message-ID: <afMnnRcuwvQyaW-8@duo.ucw.cz>
References: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
 <18AB121F2F67B74D.2435051@lists.cip-project.org>
 <afMOaPbHBf806Ypb@duo.ucw.cz>
 <afMYZJ4CQynbitnJ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b9QW9Z01JxdcNl3x"
Content-Disposition: inline
In-Reply-To: <afMYZJ4CQynbitnJ@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 09:58:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22830


--b9QW9Z01JxdcNl3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

>=20
> > > Apparently there's new CVE with a name, and when a CVE has a name,
> > > that's not good news.
> > >=20
> > > https://nvd.nist.gov/vuln/detail/CVE-2026-31431
> > > https://xint.io/blog/copy-fail-linux-distributions
> >=20
> > I assume it is real.
> >=20
> > 72548b093ee3 -- place where this was introduced
> >=20
> > a664bf3d603d -- is the fix
> >=20
> > This is another remainder that running untrusted code on your machine
> > is a bad idea.
>=20
> # 6.12-cip:
>=20
> I don't see fixes in the stable tree or queues.
>=20
> Cherry picking f2804d0eee8ddd57aa79d0b82872b74c21e1b69b allows me to
> pick a664bf3d603d, and looks like good hotfix for the bug. I'll push
> it for testing.
>=20
> Testing as 51d7d95a40bce11143de82150c2ff9372e3c34c4 .

Nope. At least these would need to be backported, and they cause more
rejects. This is more effort then I assumed.

131bdceca1f0 ("crypto: scatterwalk - Add memcpy_sglist").

commit 4dffc9bbffb9ccfcda730d899c97c553599e7ca8
Author: Eric Biggers <ebiggers@kernel.org>
Date:   Sat Nov 15 15:08:16 2025 -0800

    crypto: scatterwalk - Fix memcpy_sglist() to always succeed

Best regards,
								Pavel

--b9QW9Z01JxdcNl3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafMnnQAKCRAw5/Bqldv6
8tdJAKCaEs1MkT79R0TtwXK3eGF2ZKjacACePPQ+yq/a6/6oZ8QswOU9N0IiZmY=
=fJID
-----END PGP SIGNATURE-----

--b9QW9Z01JxdcNl3x--

