Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E72C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 16 Nov 2023 09:28:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3405.1700126909802174383
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Nov 2023 01:28:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AEE511C006B; Thu, 16 Nov 2023 10:28:25 +0100 (CET)
Date: Thu, 16 Nov 2023 10:28:25 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [kernel-cve-report] New CVE entries this week
Message-ID: <ZVXgudbJrU/ZFPXD@duo.ucw.cz>
References: <CAODzB9r5dW9fwvNexYe_+VpycEXpfJS7gbH_49V3oRicz2Z=ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAGAKFPraQ6vsah8"
Content-Disposition: inline
In-Reply-To: <CAODzB9r5dW9fwvNexYe_+VpycEXpfJS7gbH_49V3oRicz2Z=ow@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Nov 2023 09:28:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13593


--yAGAKFPraQ6vsah8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's this week's CVE report.
>=20
> This week reported 4 new CVEs and 0 updated CVEs.

Thank you.

There's also a new one, CVE-2023-23583. It is a CPU bug on recent
Intel CPUs, but this time CPU is so confused that it performs random
instructions basically. Fun.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yAGAKFPraQ6vsah8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVXguQAKCRAw5/Bqldv6
8m5AAKDAN53aURZcqWnFAMpqPF/gs+vh0QCdE5rXVm67DnsS9lt9UG3O1gsGM/U=
=aNqq
-----END PGP SIGNATURE-----

--yAGAKFPraQ6vsah8--

