Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C7FEB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 08:41:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.13450.1686818512329972680
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 01:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 89F251C0E65; Thu, 15 Jun 2023 10:41:49 +0200 (CEST)
Date: Thu, 15 Jun 2023 10:41:49 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <ZIrOzbbFV1zmYs61@duo.ucw.cz>
References: <CAODzB9oUr_wN0h73C4aAQg6qk+awCv6QpxD11bME1K4GPJFsmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dP428xltKTavic/v"
Content-Disposition: inline
In-Reply-To: <CAODzB9oUr_wN0h73C4aAQg6qk+awCv6QpxD11bME1K4GPJFsmg@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 08:41:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12044


--dP428xltKTavic/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This week reported 4 new CVEs and 7 updated CVEs.
>=20
> * New CVEs
>=20
> CVE-2023-3141: memstick: r592: Fix UAF bug in r592_remove due to race con=
dition
>=20
> CVSS v3 score is 5.9 MEDIUM.
>=20
> The client side in OpenSSH 5.7 through 8.4 has an Observable
> Discrepancy leading to an information leak in the algorithm
> negotiation. This allows man-in-the-middle attackers to target initial
> connection attempts (where no host key for the server has been cached
> by the client).

Description seems wrong here. Here's better one:

https://nvd.nist.gov/vuln/detail/CVE-2023-3141

A use-after-free flaw was found in r592_remove in
drivers/memstick/host/r592.c in media access in the Linux Kernel. This
flaw allows a local attacker to crash the system at device disconnect,
possibly leading to a kernel information leak.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dP428xltKTavic/v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIrOzQAKCRAw5/Bqldv6
8iIRAJ96BZZvPOYr5AAfmMIBqmTZDbNLNQCfUEFKmC0dsjZK7tP8bhpnApS5An4=
=r2ha
-----END PGP SIGNATURE-----

--dP428xltKTavic/v--

