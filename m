Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39262.1793180959796223693
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 02:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OjYCGLUd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFC80108965;
	Wed, 28 Oct 2026 10:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793180953;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yf0lhPUKQRBTuuBR1NrW1nrREbV/pLYzV363IZYpUB8=;
	b=OjYCGLUd91HYUBVAKDI6DsbqTj5+O1qxt755evT2vOc3ffhEtle4FaI7Fsqv+LpznjpvJ8
	nXYTjKN1CFowWS+1OBDe5e1gBbis1e3C5XhbLRcS7jSNmzDPOnnW/epeAjewSfkIxJfsP/
	nBrdbrYhdLbPdrsMj5lQdM2TrY1ufiuOBFN76n0LIMy4LEjArn6sXwg9+9hT7cnhGb2Raf
	JkIRaR+34dAYna24Yobak4TPcbIyOKVwWnXACKU3m/c90MaWjV9SiGhdydtWey5u+OMAQD
	KSVpnQItTTnrfzp+zzO5/pCTGF5FUFHCErJXiUq/ymSUbrQdzCQtLYPJvaJ81w==
Date: Wed, 28 Oct 2026 10:49:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <auHFFfOyzM0zZGwl@duo.ucw.cz>
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MbzVIYXAIxdlg/Ae"
Content-Disposition: inline
In-Reply-To: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 09:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24556


--MbzVIYXAIxdlg/Ae
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Claudiu Beznea (1):
>   iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
>=20
> Felix Gu (1):
>   i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()

Thank you, applied. Thanks for Claudiu for review.

Best regards,
								Pavel

--MbzVIYXAIxdlg/Ae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauHFFQAKCRAw5/Bqldv6
8pQVAJ9Qe30aqZTO3QsMwX+KRKrEjwofZACgrVimodcsRiGUQur+aWsvcICtHyQ=
=6mlA
-----END PGP SIGNATURE-----

--MbzVIYXAIxdlg/Ae--
