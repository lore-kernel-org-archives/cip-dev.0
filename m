Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF8C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 20:11:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.82433.1680552660116106161
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 13:11:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3CF4B1C0DFD; Mon,  3 Apr 2023 22:10:57 +0200 (CEST)
Date: Mon, 3 Apr 2023 22:10:56 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 4.4.302-cip74-rt43
Message-ID: <ZCsy0AW4lwFMpeOt@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HLk62ch71Opf3xVh"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 20:11:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11160


--HLk62ch71Opf3xVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

They should be up-to date with v4.4-st39 and thus 4.14.311. I'll still
need to catch up with latest updates from the -rt branch.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HLk62ch71Opf3xVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZCsy0AAKCRAw5/Bqldv6
8lmuAKDBDT45j5YEqiqaZ9V0L7u/rz6+GACePZCoK5CN86G2BcN0WJXNtvt7718=
=52+t
-----END PGP SIGNATURE-----

--HLk62ch71Opf3xVh--

