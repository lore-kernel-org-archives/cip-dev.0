Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB2EB64DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 12:29:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6902.1689596946167627627
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 05:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 264821C0A96; Mon, 17 Jul 2023 14:29:02 +0200 (CEST)
Date: Mon, 17 Jul 2023 14:29:01 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 6.1.38-cip1-rt1
Message-ID: <ZLU0DeXaEFjbM9LH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+yLsCDMWJ0AEdb+n"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 12:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12371


--+yLsCDMWJ0AEdb+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First 6.1-rt should be available at kernel.org. Test and enjoy!

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+yLsCDMWJ0AEdb+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLU0DQAKCRAw5/Bqldv6
8scbAJ4quqIU8oUBG0EFemCPHwaqSoVAvQCffaQphdOdoLDjv4Jp/8uGqA/lj34=
=mon6
-----END PGP SIGNATURE-----

--+yLsCDMWJ0AEdb+n--

