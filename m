Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1419.1794937920931103016
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 09:52:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DNCGwjKU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6352A10F7ED;
	Tue, 17 Nov 2026 18:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794937914;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EVVzpB57YGCuut2Dwkwi+WidNPP/8o9Rk1KythiAH5Y=;
	b=DNCGwjKUqhluHbaSbl8tD6sTTqr1v171Bfr7twYWIko/z6N14sAyyG4Wltvbc4sEUmmEjY
	nYwH/Ao2x33ZdjAVRKm+eXV+fUzg4PlNQspyl0ZpQDfCtR3VAp+m5rNUc5hQ+tzB31yMoa
	kCfTPJw8NzpPLc+QW2HWyBAJUaE41JGYVo4eQyNP6nrQNdzIM9cdaaJNa6XQ3Nu7PFiYJD
	TNVhh/NJ6PoYrBztpbK0GNVNszO9ef0k9JYtUAoQ78/sFLMdiklzMjc3JJp/5nSTF3kF+l
	DVXSN3vfVJ9aHqHiwKJTJnPWDE6KZXXYj01WZw3p8CniKbIpyV/73EPbfHq9aA==
Date: Tue, 17 Nov 2026 18:51:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: luca.weiss@fairphone.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert
 patches for OpenSSL 4 compatibility
Message-ID: <avyUNwowVKWAJDj9@duo.ucw.cz>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ItIZWmbUt9AVvw18"
Content-Disposition: inline
In-Reply-To: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 17:52:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24946


--ItIZWmbUt9AVvw18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Arch Linux the extract-cert tool from 4.19.y-cip doesn't compile
> anymore due to OpenSSL 4 upgrade which removed some APIs used in the
> host tools.
>=20
> Backport some patches, taken from linux-6.1.y to fix compilation.
>=20
> Note, this is the first time I'm sending patches to cip-dev, so I hope
> I'm not missing some contribution guidelines.

I believe these are not yet in 5.10, that would be first step.

This is not usual kind of bugfix, nor is it backport from a member
company. Still, I'd not be opposed in taking these, provided 5.10
version is taken first.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
							Pavel

--ItIZWmbUt9AVvw18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavyUNwAKCRAw5/Bqldv6
8gFzAJ9Tl2YA5qpDVGEAsN/ZzN3W7VR33ACgkVGvS3IqtfN8YQy7mYWNF9ho3AQ=
=0VjM
-----END PGP SIGNATURE-----

--ItIZWmbUt9AVvw18--
