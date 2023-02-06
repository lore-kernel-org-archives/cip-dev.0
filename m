Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB64C05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 20:35:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.65460.1675715755271974293
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 12:35:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 96D6B1C0ABB; Mon,  6 Feb 2023 21:35:51 +0100 (CET)
Date: Mon, 6 Feb 2023 21:35:51 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 4.4.302-cip72-rt42
Message-ID: <Y+FkpxAoRxZib3+Y@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NepzT4iv6em1EjQR"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 20:35:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10610


--NepzT4iv6em1EjQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NepzT4iv6em1EjQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+FkpwAKCRAw5/Bqldv6
8vf2AKCXU35bkwXBmPjZ3WtLIzeuIaPgNgCgmoPSn15y6Zr0dD8hk1vHEY903OU=
=S/8I
-----END PGP SIGNATURE-----

--NepzT4iv6em1EjQR--

