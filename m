Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CDC433EF
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 09:27:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.9938.1638955646009550709
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 01:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D5FAF1C0B77; Wed,  8 Dec 2021 10:27:22 +0100 (CET)
Date: Wed, 8 Dec 2021 10:27:21 +0100
From: Pavel Machek <pavel@denx.de>
To: dinesh.kumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: Realtime branch on 5.10 -- 5.10.83-cip1-rt0
Message-ID: <20211208092721.GA20833@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Dec 2021 09:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7072


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

-cip-rt branch is available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt

and it passes basic testing we do on gitlab.

More testing would be welcome, but I believe we are ready to release
this as 5.10.83-cip1-rt1.

Unless there are objections, I'll proceed to create -rebase branch and
announce this in usual way.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGwenkACgkQMOfwapXb+vLEvACfZmKaAAlHEX7Lqo/IL/VEUC02
w+YAoI1j+j7N/p0HFKRMOA9dMi3RHwus
=pxep
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

