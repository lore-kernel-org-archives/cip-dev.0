Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE599C7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 19:18:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3252.1686338283015501811
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jun 2023 12:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0BD431C0E70; Fri,  9 Jun 2023 21:17:59 +0200 (CEST)
Date: Fri, 9 Jun 2023 21:17:58 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 4.19.284-cip99-rt31 (rt125)
Message-ID: <ZIN65u61l1di6fnv@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/jAWNmgKSN07stQ"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 19:18:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11959


--s/jAWNmgKSN07stQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org. 4.19-rt tree we
were using was rather old, and we got a match in versions, so I did an
update early.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s/jAWNmgKSN07stQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIN65gAKCRAw5/Bqldv6
8qlHAKDEPNPLHnKB67riWrBCieshBCkbWwCfTtlbmGO5CyrE2TKGsyGTd1ZEikw=
=TjxW
-----END PGP SIGNATURE-----

--s/jAWNmgKSN07stQ--

