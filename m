Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A76BC47DA9
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 19:24:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5518.1706642680747647056
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 11:24:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2363F1C0071; Tue, 30 Jan 2024 20:24:38 +0100 (CET)
Date: Tue, 30 Jan 2024 20:24:37 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: 6.1.75-cip-rt
Message-ID: <ZblM9Z3ZMNnyBOqa@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j2wFFhCJDzGR9JiY"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 19:24:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14511


--j2wFFhCJDzGR9JiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.75-rt is out, could I ask for 6.1.75-cip?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--j2wFFhCJDzGR9JiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZblM9QAKCRAw5/Bqldv6
8r8XAKC4p37vo0w36MpKpzGx1p52K1KkfgCdGfWLfSYrCaqqRdtA2wim7XZW2YY=
=q5Ra
-----END PGP SIGNATURE-----

--j2wFFhCJDzGR9JiY--

