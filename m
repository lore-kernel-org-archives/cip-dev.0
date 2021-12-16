Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB3C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 08:49:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.7857.1639644564974158537
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 00:49:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5869F1C0B9C; Thu, 16 Dec 2021 09:49:20 +0100 (CET)
Date: Thu, 16 Dec 2021 09:49:16 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211216084916.GA5178@amd>
References: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 08:49:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7117


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-3864: descendant's dumpable setting with certain SUID binaries
>=20
> CVSS v3 score is not provided
>=20
> This bug is able to write coredump file anyware. However, abusing this
> bug, such as arbitrary code execution is required some program. The
> PoC(https://www.openwall.com/lists/oss-security/2021/10/20/2).
> There is two mitigation techniques are suggested. So, users follow
> these mitigation technique is recommended.
>=20
> Fixed status
>=20
> Not fixed yet.

This one is actually quite interesting.

Untrusted users should not normally have shell access on embedded
systems, but it highlights topic of coredumps. Default config of
coredumping is unsuitable for many embedded systems; coredumps should
be probably disabled.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG6/YwACgkQMOfwapXb+vKoewCfZNICp3RbqEs7+pXB5L82ORqQ
7QUAnitGOK9vRnaTZ5SYHs1oHLzxlzZk
=yPcw
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

