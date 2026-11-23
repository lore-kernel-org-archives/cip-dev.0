Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50888.1795428041046688750
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 02:00:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fId4KsMz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F073D10E954;
	Mon, 23 Nov 2026 11:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795428034;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9iDBxUXPxLWcWTkKKZ5nQjSZN0tq4Ck0pg7TkHb4FTM=;
	b=fId4KsMzSSp1qM2TT7hG6S7FwjgUpWgp5ylBjVGWcYhGze9txczNyhwoDlQjoRANIGvkvA
	xNATPnhbm5uJ3mAsyxgmGab+EFcpM3Hg0zq/d6qwLLOR0hxtlmWAX5sUkMoTLW0IMFmHJ6
	gnl+mKyDL9GHEyt8seOgE6lLnBwcXszqvqi25A0fw87IDFPGpWZPQh1TnUJpc6bcVbpNck
	BdbKF79OhwButPYQnyGPV2rMCg0GEY48IC6w/9NZ5oHK8TwH4lI1LhZab6AwMx/J3Qe7Ru
	/YUtsyba7V5mMsCfvtZ5hhEzTKyfUjl5xhN4Z957wDrKsvMRPHWqca4jjhCirQ==
Date: Mon, 23 Nov 2026 11:00:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Ulrich Hecht <uli@fpond.eu>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Dinesh Kumar <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [6.12.y-cip][PATCH v4] Add SECURITY.md for the CIP kernel
Message-ID: <awQOtprGQ-KYCNsc@duo.ucw.cz>
References: <fd7c1d48-bb3a-448f-abc3-108b5c573783@siemens.com>
 <avyUodZ4_b0QpWyI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vHIWl77lIx14vPj"
Content-Disposition: inline
In-Reply-To: <avyUodZ4_b0QpWyI@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 10:00:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25046


--0vHIWl77lIx14vPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This describes at which time which areas of the CIP kernel are handled
> > by the CIP security team and how to report vulnerabilities to it. It
> > furthermore states that this project falls under the LF stewardship
> > framework.
> >=20
> > As the original kernel documentation already contains a reporting guide,
> > leave a note there which one applies to CIP kernels.
> >=20
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply this if there are no other comments.

Thank you, applied.

I can apply this to 6.1 and 5.10, unless there are other comments.

Best regards,
								Pavel

--0vHIWl77lIx14vPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawQOtgAKCRAw5/Bqldv6
8hioAJ9M0n2fVbbiMaegH8tm77oSmyl1uQCXTeCnn8j2pLhanptM3MOsTYSrSQ==
=WgZD
-----END PGP SIGNATURE-----

--0vHIWl77lIx14vPj--
