Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDDC433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 08:35:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.27894.1647851725141361750
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 01:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 88A8C1C0B77; Mon, 21 Mar 2022 09:35:20 +0100 (CET)
Date: Mon, 21 Mar 2022 09:35:19 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Doing 4.4-cip release
Message-ID: <20220321083518.GA18233@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 08:35:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7786


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

linux-4.4.y-cip tree should be up-to-date with changes from 4.9.305
and older.

I believe it may be good time to do 4.4.x release; last release
of 4.4.y-cip was at Feb 14, and 4.9.306 contains speculation fixes
that are rather intrusive... so it may be good time to test that we
did a good job on the easy changes.

We do not have 4.9-rt release to work with, so doing 4.4-rt is not
easy at the moment, and it may be good to do non-rt release, first,
anyway.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmI4OMYACgkQMOfwapXb+vI8XQCgprIQM0uRUAV4UtRkI5ye9xxg
+QwAn1iugSGF80b713vxucqU9l7pwFve
=9Qut
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

