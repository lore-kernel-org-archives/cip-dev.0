Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D62C43334
	for <webhook@archiver.kernel.org>; Tue, 12 Jul 2022 09:35:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7019.1657618555795686842
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Jul 2022 02:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A97601C0001; Tue, 12 Jul 2022 11:35:52 +0200 (CEST)
Date: Tue, 12 Jul 2022 11:35:52 +0200
From: Pavel Machek <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: linux-4.4.y-st-rc moving forward
Message-ID: <20220712093552.GA23165@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Jul 2022 09:35:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8749


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've moved linux-4.4.y-st-rc forwards. Could I get some reviews
(Uli?). Especially look at last two patches would be useful, as those
were manually ported.

What will we do with the random changes?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYs1AeAAKCRAw5/Bqldv6
8jA2AJ9zIWyEm40doC/PUONiGRafUpXLRACgnyK5/IRwZEaCJCRBdU5iJVNtfxU=
=fsmg
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

