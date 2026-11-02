Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1615.1793646239203488142
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 11:03:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=T0RWuDzT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFFA510B1F1;
	Mon, 02 Nov 2026 20:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793646232;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vMmOeJEKOrkII3e/Jpd/fnjxo/VnnFRsr/i9IaHydZQ=;
	b=T0RWuDzT87Ranf+Z2les9PBB+SQZ5R3eFofHBqo103wN+pGsItHHtfOLJ5RrJhw8CWJuoF
	vyKfO368NDj30RDk4PROHna+d4d3ky2G8Yotmzyr+ppQgV2RkSNAQZWA+bV7Zt9q42X/Od
	sucjOnDHZFSyrNqT5eBHGFzvs6AzSjdFHsu/NZIVf2v5lS6dtgALnMt8NGqjXFA2AJp5+v
	WxkbihMDfcu5vJKa92A+pcfgCMKwsCBy+ev300aOYIkqGQ01YKwlT2XZPGkplZoWt/0Ls7
	PRvTOkIx3+5ROPhgeKlzWCHi0K1+DoCy73H9Yd8kQQGNOI06LC1F8GkTIg6blw==
Date: Mon, 2 Nov 2026 20:03:50 +0100
From: Pavel Machek <pavel@nabladev.com>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CVE-2026-99999, CVE-2026-98432: status in cip branches
Message-ID: <aujeljxPFkX9LoWE@duo.ucw.cz>
References: <auhtu6LQDZuPFP_N@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U8aQVryskrKzMBbU"
Content-Disposition: inline
In-Reply-To: <auhtu6LQDZuPFP_N@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 19:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24618


--U8aQVryskrKzMBbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2026-98432 is fixed by e3f33b0a1d89d738e2b913dab519226eaf76e15b
> "ipv4: free inet_opt and ireq_opt after an RCU grace period"
>=20
> Exploit for CVE-2026-99999 is stopped by
> 6785011f8b16abf40b1e9d8b2e332232b3e68822 "ipv4: validate
> checksum_start before completing checksum"
>=20
> 6.12-cip: we have v6.12.114-cip34 with both patches.
>=20
> 6.1-cip: last commit is Oct 26, last release is Oct 14,
> v6.1.189-cip61. Does not have e3f3 or 6785. 6.1.190 has e3f3 and 6785.
>=20
> 5.10-cip: last commit os Oct 26, last release is Oct 15,
> v5.10.271-cip78. Does not have e3f3 or 6785. 5.10.272 has e3f3 and
> 6785.
>=20
> I guess we could do early releases of -cip at this point. I don't
> think embedded users should be affected by either of them (one is KVM,
> one is MPTCP, basically), but both are getting some publicity and we
> were already thinking about early releases when CVE-2026-99999
> appeared.

If noone has other comments, I'll likely do 6.1-cip and 5.10-cip
releases later this week.

Best regards,
								Pavel

--U8aQVryskrKzMBbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaujelgAKCRAw5/Bqldv6
8uSEAJ4tZkt+FuqIYx6P9oXaQ7FM3mbYgwCcCSg38lT2T2tQpgKMbVi6IunPDxQ=
=F4xA
-----END PGP SIGNATURE-----

--U8aQVryskrKzMBbU--
