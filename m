Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A9C3DA49
	for <webhook@archiver.kernel.org>; Fri, 26 Jul 2024 18:24:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1705.1722018277654396446
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jul 2024 11:24:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 74D841C009B; Fri, 26 Jul 2024 20:24:34 +0200 (CEST)
Date: Fri, 26 Jul 2024 20:24:34 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Adding tests for 6.10.x
Message-ID: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YqIX/pMvQKzTACKr"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jul 2024 18:24:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16629


--YqIX/pMvQKzTACKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could we start testing 6.10.x kernels? I guess 6.9.x configs could be
used as templates...

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YqIX/pMvQKzTACKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqPp4gAKCRAw5/Bqldv6
8jfSAKCM6gl7ao0OLF/xcpzW7cjVBTclNgCgr2K4aagiLYgqNPsFWwxgvtD7Yyg=
=ihnn
-----END PGP SIGNATURE-----

--YqIX/pMvQKzTACKr--

