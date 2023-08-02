Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C9C001DE
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 08:57:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9926.1690966621602659213
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 01:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 046C61C0A93; Wed,  2 Aug 2023 10:56:59 +0200 (CEST)
Date: Wed, 2 Aug 2023 10:56:58 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: stable-rc-ci tests failing
Message-ID: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0GbvCZm0qwiBAHoL"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 08:57:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12532


--0GbvCZm0qwiBAHoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There seems to be something wrong with testing at the moment:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
52990993

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0GbvCZm0qwiBAHoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMoaWgAKCRAw5/Bqldv6
8o5fAJ0ezbJF+rU1ZzwhNy3PJ9CvHcsauACeObl8zL1kI9t+eCVAPAD3hTP9YI8=
=RyrI
-----END PGP SIGNATURE-----

--0GbvCZm0qwiBAHoL--

