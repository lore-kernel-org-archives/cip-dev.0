Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED07C25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 17:25:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1049.1715793939879826184
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 10:25:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED43B1C008B; Wed, 15 May 2024 19:25:36 +0200 (CEST)
Date: Wed, 15 May 2024 19:25:36 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org,
	"pavel@duo:/data/l/k$chris.paterson2"@renesas.com
Subject: gitlab -stable-rc: mirroring not working?
Message-ID: <ZkTwEKwobEIumswy@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2o0WUfbKslgT/N1"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 17:25:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15898


--s2o0WUfbKslgT/N1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'd like to test 6.1.91-rc2 and friends, but gitlab still have -rc1:
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Can someone take a look what is wrong?

Plus, it would be cool to start testing 6.9-stable branch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s2o0WUfbKslgT/N1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkTwEAAKCRAw5/Bqldv6
8turAKC1kVk2hSLFU9mYzFjVkQfYZ6ZIiQCePBr7xdzWvQhCVhd2AsF3e8dIyj0=
=OzcJ
-----END PGP SIGNATURE-----

--s2o0WUfbKslgT/N1--

