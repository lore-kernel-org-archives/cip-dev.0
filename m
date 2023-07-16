Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2B6EB64DA
	for <webhook@archiver.kernel.org>; Sun, 16 Jul 2023 09:40:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13709.1689500408830481061
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 Jul 2023 02:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6844E1C0D21; Sun, 16 Jul 2023 11:40:05 +0200 (CEST)
Date: Sun, 16 Jul 2023 11:40:04 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Releasing 6.1-cip-rt?
Message-ID: <ZLO69J9ZmUBl3+cy@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wYOKJ5Mq4eQaPb0R"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 16 Jul 2023 09:40:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12361


--wYOKJ5Mq4eQaPb0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I prepared simple merge of 6.1.38-cip1 with 6.1.38-rtrt12, and seems
to pass basic testing.

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

If there are reasons not to release this, or extra steps that should
be taken here, let me know.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wYOKJ5Mq4eQaPb0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLO69AAKCRAw5/Bqldv6
8llIAJoClpARpaQk45ACC6/PloUAtnAE0QCdE79jDqnNCJwN5YDP+riJ5GhZi8s=
=9Te+
-----END PGP SIGNATURE-----

--wYOKJ5Mq4eQaPb0R--

