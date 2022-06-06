Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914BCCA473
	for <webhook@archiver.kernel.org>; Mon,  6 Jun 2022 17:57:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.1617.1654538231817306574
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jun 2022 10:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84C381C0B8A; Mon,  6 Jun 2022 19:57:06 +0200 (CEST)
Date: Mon, 6 Jun 2022 19:57:06 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: pkexec vs kernel -- root to anyone who asks nicely
Message-ID: <20220606175706.GA19989@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jun 2022 17:57:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8497


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's a security problem in pkexec vs. kernel interaction. Impact is
local root. If you want to get root on someone else's system, it
should be easy right now. It is fixed in 5.18, 5.10.120, and latest
4.9 and 4.19 kernels.

Do you have untrusted users on your system and you need pkexec?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYp4/8gAKCRAw5/Bqldv6
8gWdAJ9jJB+bA4GSgHC84O0+f6wMu0US3QCeJUfIXT06F3ySYT3hbBPF2TNWl/U=
=h6ZC
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

