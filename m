Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF84C433F5
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 22:56:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2506.1649282778825911361
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 15:06:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6A7AA1C0B87; Thu,  7 Apr 2022 00:06:13 +0200 (CEST)
Date: Thu, 7 Apr 2022 00:06:12 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: 5.10.110-rc2 mirroring/testing
Message-ID: <20220406220612.GB4213@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Apr 2022 22:56:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8015


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

5.10.110-rc2 is out, and it would be good to test it, but somehow we
are still at -rc1...?

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Does mirroring need to be kicked again?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYk4O1AAKCRAw5/Bqldv6
8nclAJ9Ob1z4nSTSDg6m4znOp6xwQGbYHACdHEDLB0NwpKXLd6E4R8c4Y/6jSgQ=
=rqdo
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

