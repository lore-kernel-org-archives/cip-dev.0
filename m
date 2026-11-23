Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4702.1795468630179077880
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 13:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=A+LwUgUJ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 892AE10D6F3;
	Mon, 23 Nov 2026 22:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795468623;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M5tcfGt07CnO4+JBp4igebCrncYh6io1rSr6w7p/kLg=;
	b=A+LwUgUJLN2o1/lcqh1SVF9X7NRfXuRF7vEhBToAJwIeT/Rcg5JCvL59yO8IFQ4kISoAns
	D4Skh0f0icApmh2PYiNIQD2tn7vWQPtvOvEVEutftdBVTNMD4Jbw9cSNp52N2QCVbUnDuf
	NB7IOcmlMO6ugYCt8/0roVwK1uXxtYDmUK3bsxHKQGQBHv2iLnJiOBrB79BN2Tx8RK/Fgh
	rFovPs56CVR/1h604Wv+r1om9wbe+ipmzmmiiQIZYcA+5qj/lFE1sHY1mmtcg+a3WK5W0q
	22/fSZhXtdJMOCwqsCNy1PpQcbCg18lOEit4DPiWd3cFCJYmNlA5gqnPNHmfIg==
Date: Mon, 23 Nov 2026 22:16:59 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas
 RZ/G3S
Message-ID: <awStSzX0cNPoVR5E@duo.ucw.cz>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDBSoyO37d6yKN6e"
Content-Disposition: inline
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 21:17:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25050


--dDBSoyO37d6yKN6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the I3C support for the Renesas RZ/G3S.
>=20
> Please provide your feedback.

I'd be happier if series were closer to 20 patches than 35 or
70... but I got through this, and besides few poorly formatted
comments, it looks okay to me.

I can apply this if it passes testing and if there are no other
comments.

Best regards,
							Pavel

--dDBSoyO37d6yKN6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawStSwAKCRAw5/Bqldv6
8pjNAJ41ccBc+Ms9IJiq1ZcG63EfWAn8LgCeJUS6OEyiek7fxRKQi6j5KatYLQk=
=9uZ9
-----END PGP SIGNATURE-----

--dDBSoyO37d6yKN6e--
