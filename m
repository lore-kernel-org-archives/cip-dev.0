Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7936C678D5
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 21:23:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6543.1678224187652040242
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 13:23:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED8D71C0AC1; Tue,  7 Mar 2023 22:23:04 +0100 (CET)
Date: Tue, 7 Mar 2023 22:23:04 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Tests of 6.1-stable and others
Message-ID: <ZAerOFASj+Fgqe1o@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqvU7ZFUOnvsFyNG"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 21:23:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10950


--eqvU7ZFUOnvsFyNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.16-rc1 review was announced, and I guess this would be great time to
announce that we are now testing it.

I see tree at:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/ci/patersonc/=
linux-6.1.y

=2E..but that one is does not contain recent commits from 6.1.16-rc1.

I see it updates from linux-cip. I believe it should update from
stable@kernel.org.

Ideally, I'd like to see same setup we have at

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

=2E.. (And prefferably do it at the same address).

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eqvU7ZFUOnvsFyNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZAerOAAKCRAw5/Bqldv6
8oOyAJ9bScuWVp0DywKGiyDhFs96T104XQCfcsORoCJa8ZtewhdhXMOAkhw4SAw=
=3QQP
-----END PGP SIGNATURE-----

--eqvU7ZFUOnvsFyNG--

