Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58465C54EBD
	for <webhook@archiver.kernel.org>; Mon,  9 Jan 2023 15:53:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.75890.1673279609090562122
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Jan 2023 07:53:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0A10C1C09F6; Mon,  9 Jan 2023 16:53:26 +0100 (CET)
Date: Mon, 9 Jan 2023 16:53:25 +0100
From: Pavel Machek <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: 4.4 steps towards release
Message-ID: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nLRwIC5m2dUxTYTi"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Jan 2023 15:53:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10331


--nLRwIC5m2dUxTYTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

For 4.4 -st release, I'd suggest these steps:

- sign off the patches
- push that to linux-4.4.y-st-rc @ kernel.org
- update v4.4.org

For patches that were applied automatically, I don't think we need to
additional review. For the others, I guess you should send list to
cip-dev, and someone will take a look.

For updating 4.4-cip tree, just checkout linux-4.4.y-cip and merge
-st. Iwamatsu is doing 4.4-cip releases, so I was just asking him to
do them, he handles 4.4-cip-rebase.

Best regards,
     								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nLRwIC5m2dUxTYTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7w4dQAKCRAw5/Bqldv6
8lTbAJ9Q8RS6foa5scnUWQ7AGzNIy/kqOQCdENYyFEIwfeZs6DFdUZT5IzfgBgI=
=iKDe
-----END PGP SIGNATURE-----

--nLRwIC5m2dUxTYTi--

