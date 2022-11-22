Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B67EC433FE
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 10:08:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.15108.1669111718537642634
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Nov 2022 02:08:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 580371C09F6; Tue, 22 Nov 2022 11:08:36 +0100 (CET)
Date: Tue, 22 Nov 2022 11:08:35 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: 4.4-cip release
Message-ID: <Y3yfo3FDgy84vZRp@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bEWOmFejW2G/qliY"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 10:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10067


--bEWOmFejW2G/qliY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have merged 4.4-st trees to 4.4-cip, so there should be good time to
do 4.4-cip release. (Tests are still running, but there's good chance
they'll be ready when you'll read this).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bEWOmFejW2G/qliY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3yfowAKCRAw5/Bqldv6
8hUaAKCV92OrA+/bgaGfiOFKiHNANFqIGACfTdPAoqM6+Lg6m4V5YxpSodSaFuw=
=HUGO
-----END PGP SIGNATURE-----

--bEWOmFejW2G/qliY--

