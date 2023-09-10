Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D9EC8748
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 08:29:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.32728.1694334552580292701
 for <cip-dev@lists.cip-project.org>;
 Sun, 10 Sep 2023 01:29:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3D2081C001B; Sun, 10 Sep 2023 10:29:09 +0200 (CEST)
Date: Sun, 10 Sep 2023 10:29:08 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 5.10.192-rt release
Message-ID: <ZP1+VDebO44vJ99b@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xqd09/mM6vjqr66S"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 10 Sep 2023 08:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13016


--xqd09/mM6vjqr66S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could I ask for v5.10.192-based -cip release? I believe that's best
way to get -cip-rt out.

v5.10.192-rt92 is two weeks old --=20

commit a7fe2ad8ced572fc9fe4fc75168b9857e2d7e1ae (tag: v5.10.192-rt92, rt/v5=
=2E10-rt)
Date:   Mon Aug 28 19:25:43 2023 -0300

-- so I'd expect next -rt at end of September. Waiting for it is
another option, but we'd be a bit late with the release.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xqd09/mM6vjqr66S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP1+VAAKCRAw5/Bqldv6
8okrAJ9lrh6Z/2TqPHgVJlp3MfZvmpfDmQCgkpPgHZbNp04Ova4SF+oLGbTutTo=
=sjhO
-----END PGP SIGNATURE-----

--xqd09/mM6vjqr66S--

