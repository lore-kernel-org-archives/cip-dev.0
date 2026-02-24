Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC910E9B25F
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 12:33:39 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19217.1771936415596231512
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 04:33:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=aNkfMol3;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BC861109E6;
	Tue, 24 Feb 2026 13:33:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771936413; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=Q4yg8pAZ+vh1XtPmSQtRV6iXuD+3q37Gz02pRYCVT38=;
	b=aNkfMol34ltJhrATlRk0vsPuJ19B2EBZb1VcARCFieBKIOypFvjdrD56j7QiahFW6nCXv4
	RYxaoeY2m0YkmfwLzQrC5gNWm5URtIMfKFZQNGpBvQSotJeliMsnh5B6FFYufIlDYuDxHa
	Iht9UaqG8j9hup3GTSN4hgJ15+82dRTyz48duQ4LmR0p1EYbNM8+l1JL0YGjvwtG2qjZhs
	FKImVBVJa0CeCU4wX66e/ImaL6RipEpqsMfFLm4kEkba+58Lt6zxOos/tlUDMepIEX49nC
	2UK33/Fg939J87ORG0qsU/7HBs0C2CeNSpK2asg3D9b178SPDvAyDiyFQJgjqw==
Date: Tue, 24 Feb 2026 13:33:30 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.164-cip52-rt28
Message-ID: <aZ2amuglgRKjQsTX@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2pi2xKl3hx8+OSxh"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 12:33:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21922


--2pi2xKl3hx8+OSxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--2pi2xKl3hx8+OSxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZ2amgAKCRAw5/Bqldv6
8hs0AKCyR25xRE5UGeLG3VRU9Q4u3Pn7RACghOABnMi3T7SPvcOMGwIcemE/nVg=
=eT+h
-----END PGP SIGNATURE-----

--2pi2xKl3hx8+OSxh--

