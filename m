Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A2C5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 22:04:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.36587.1709330643994040512
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Mar 2024 14:04:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 839B81C006B; Fri,  1 Mar 2024 23:04:00 +0100 (CET)
Date: Fri, 1 Mar 2024 23:04:00 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] 4.19.306-cip107-rt35 (rt132)
Message-ID: <ZeJQ0GdSPt8azMsM@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PXs8KATKLitxS7uB"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 22:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15148


--PXs8KATKLitxS7uB
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

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PXs8KATKLitxS7uB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeJQ0AAKCRAw5/Bqldv6
8jdZAJ4y13eZ4/2UTuiN8unvNlhaXEZ7dQCdHnisCWXKYRRMmlBUAMt850NTdAM=
=w5EL
-----END PGP SIGNATURE-----

--PXs8KATKLitxS7uB--

