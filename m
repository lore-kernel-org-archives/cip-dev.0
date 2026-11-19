Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4527.1795120778553666101
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 12:39:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BpL2NHLU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18BF510EAA4;
	Thu, 19 Nov 2026 21:39:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795120772;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cMVMC4wPIMh7KkFdCKHpd4xB4qKWv8ipzjsz5wHxq/c=;
	b=BpL2NHLUB8IF7CNKZsWbFVq64EI12dN4/ldkoAOL19oCktH5gUx1sGrjjWiXHIGbcnIi++
	6DsR8ZkaZ4JhUKWi4WyTBCBw6h4+G+7fXZGvrl5zZ4uzne/RRlJByisuQeAtk2iwjQ0fZw
	WCZE1CrhdAAEUqMRM+9cO86woM2SIpSeTRblTLoNgMpdEkwAo1lO/7D7tqazBbF/Ha08e+
	+YvBEmAmftly0j8vAEjFm6urQHkjjiUvXAgj9TUvdGGw3aKNmEipms1RmP1rKhxGTRDUJl
	t6X9QRqY8qpXGcRSRscgHzVSAoOTtWJ1PlBrhBoCQTltZMKtWnwRfHptc7vnYw==
Date: Thu, 19 Nov 2026 21:39:28 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, uli@fpond.eu
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 4.19.y-cip 0/8] mmc: renesas_sdhi: fix eMMC test hang on
 RZ/G2N
Message-ID: <av9egKPuh4-B37O7@duo.ucw.cz>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u34TzD/+Xl4f0EXY"
Content-Disposition: inline
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 20:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25025


--u34TzD/+Xl4f0EXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On the HopeRun HiHope RZ/G2N board, running mmc_test on the eMMC hangs the
> board on 4.19-cip until the watchdog resets it.
>=20
> This series backports the upstream manual correction series from
> v5.7 (patches 4-8) to fix this. Patches 1-3 are support commits, so
> that the series applies cleanly.
>=20
> All patches were cherry-picked from mainline and apply cleanly.

So it looks like 4/ and 8/ from the series are just a cleanups, and
not really neccessarry to fix the bug?

Anyway, series looks ok to me,

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I guess Ulrich will take the series. I've cc-ed him.

Best regards,
								Pavel

--u34TzD/+Xl4f0EXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav9egAAKCRAw5/Bqldv6
8jLPAJ9v75qUBQZBdqyxJBzSLp2SWnuAogCguGXjLqsZDD0i4PRmrsGbZJmuuQw=
=hH+g
-----END PGP SIGNATURE-----

--u34TzD/+Xl4f0EXY--
