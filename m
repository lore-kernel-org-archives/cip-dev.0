Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED1C433F5
	for <webhook@archiver.kernel.org>; Mon, 30 May 2022 12:36:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.36213.1653914181615335386
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 May 2022 05:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F18191C0B82; Mon, 30 May 2022 14:36:16 +0200 (CEST)
Date: Mon, 30 May 2022 14:36:16 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 4.19.245-cip74-rt25 (-rt109)
Message-ID: <20220530123616.GA11202@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 May 2022 12:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8461


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpS6QAAKCRAw5/Bqldv6
8rYkAJMGufnoCu9hTMISXjyi7RC4v0ZXAKCwCD1P+hAwWd/IFpXLYAahmig6Iw==
=m09p
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

