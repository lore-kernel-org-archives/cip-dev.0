Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F9E7717F
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 09:26:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.76385.1733649947452412376
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 01:25:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C18191C00A0; Sun,  8 Dec 2024 10:25:44 +0100 (CET)
Date: Sun, 8 Dec 2024 10:25:44 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, chris.paterson2@renesas.com
Subject: Tests slow and failing?
Message-ID: <Z1VmGEH8ErHlIt7J@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OcPB0sw2ygaZ3+MH"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 09:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17373


--OcPB0sw2ygaZ3+MH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I can't get 6.6/6.12 tests to pass. Not only bbb is acting up, but
obsvx2 as well, and retries don't seem to fixing it. I tried to look
into the results, but I'm getting empty pages, so I suspect something
is wrong with the testing.

Empty page:

https://lava.ciplatform.org/scheduler/job/1228877

6.6 failing:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
577092627

6.12 failing:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
577095923

My various pipelines failing:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1578401988
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1578416624
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1578507755

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OcPB0sw2ygaZ3+MH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1VmGAAKCRAw5/Bqldv6
8kHgAJ9OyxPhybV0u4m3rbp1FaxOlX/fvQCcDsnKVJj3667aVz331CelqwjIw80=
=Kh6L
-----END PGP SIGNATURE-----

--OcPB0sw2ygaZ3+MH--

