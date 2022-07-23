Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C9C433EF
	for <webhook@archiver.kernel.org>; Sat, 23 Jul 2022 21:05:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10646.1658610299943565721
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Jul 2022 14:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC7AC1C0001; Sat, 23 Jul 2022 23:04:56 +0200 (CEST)
Date: Sat, 23 Jul 2022 23:04:56 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
	alice.ferrazzi@miraclelinux.com
Subject: Failures in 5.10, 4.4 testing
Message-ID: <20220723210456.GA7918@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Jul 2022 21:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8893


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I see a lot of failures this week. 5.10.133-rc1:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/5=
95045922

4.4:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/595036439
(renesas failure is expected).

Is bbb expected to work in 4.4? What is going on with 5.10 testing?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtxieAAKCRAw5/Bqldv6
8srpAJ9ogWQf51Dan26MJ8CEI2KtjO5FGACfVkBL4RA2PeDPFMURp2xT7wEZQnA=
=7JGC
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

