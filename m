Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14666.1795780547488522541
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2026 03:55:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Az0ZJpO4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9200510AAB2;
	Fri, 27 Nov 2026 12:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795780541; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=NVQIT6ZuoPamJ4ild4NN+EfxGOXmEigOTGIEA+N2gdw=;
	b=Az0ZJpO40VlJezHfmlB1MJpGeuGXLtTF/ep/tb0QXPtP81NQa2CNQz2SdufcwR5eUUdRni
	2C934WPo4lRx0jEfOMBO0D/SIi6+NaRDDWJvLwQs6ps8UdwQHNpD8MnLFiGHxSPjX6sdtA
	AabbPZCfIwvoobx8rSDn1DKF7AZ33j42qwLHaP0aNlkjiLLz4kAviTCzjb1yAJGkb27i+q
	S6HwKT+/TmFc74oJ65kJRLrDMSetJNrXxIjLFaG9HArqGcWlwLdgMQgaRDeAq1b1ljLUII
	uatUgz0LPtMy9Sos5BjBmZEZtKqSOL6aQhtkCxVJ9QZQQjAtabf6MvykrXUEBQ==
Date: Fri, 27 Nov 2026 12:55:37 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] Release v5.10.275-cip80
Message-ID: <awlvuXzQAWNBVxfO@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CAJR4eGlZaxrQF+b"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 11:55:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25228


--CAJR4eGlZaxrQF+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--CAJR4eGlZaxrQF+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawlvuQAKCRAw5/Bqldv6
8vIGAKCCtDn+GXwO2Meb14urULv4lGsNdACeIUHd7gi3wXRStlm+Pbv+DgnHIyk=
=211+
-----END PGP SIGNATURE-----

--CAJR4eGlZaxrQF+b--
