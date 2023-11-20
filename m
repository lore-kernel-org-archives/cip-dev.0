Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2973C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 09:53:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.47025.1700474010000588064
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Nov 2023 01:53:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC8C41C006B; Mon, 20 Nov 2023 10:53:26 +0100 (CET)
Date: Mon, 20 Nov 2023 10:53:26 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: 5.10.200-cip40-rt17 (rt97) update -- not easy
Message-ID: <ZVsslmgICGwnNkdT@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ED99JxrwIMyy+3Tu"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 09:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13594


--ED99JxrwIMyy+3Tu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried to prepare 5.10.200-cip40-rt17 (rt97) update, but I don't know
how to verify it. Problem is that regular release and rt releases are
based on different -stable release, thus can't be compared easily.

I have 5.10.200-cip40 and v5.10.199-rt97. In -cip branch, I have to
combine them, and result will be 5.10.200-cip40 (rt97). But we have
-cip-rebase which is "on top" of rt. And rt is on 5.10.199, so I get
5.10.199-cip40 (rt97), which is obviously different trees.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ED99JxrwIMyy+3Tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVsslgAKCRAw5/Bqldv6
8p2XAJ0arSOZSNeyBrSYBYUA93TamFT82gCeJbc9iKZtKhflMbLYx8c5B6jNsfk=
=ywGe
-----END PGP SIGNATURE-----

--ED99JxrwIMyy+3Tu--

