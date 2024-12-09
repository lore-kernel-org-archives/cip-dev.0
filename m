Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B85E7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 11:23:01 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.98913.1733743379136778459
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Dec 2024 03:22:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 180AF1C00A0; Mon,  9 Dec 2024 12:22:56 +0100 (CET)
Date: Mon, 9 Dec 2024 12:22:55 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v4.19.324-cip115
Message-ID: <Z1bTD13v0KKOYB1Z@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EHdH9FqH78SymLuy"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 11:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17383


--EHdH9FqH78SymLuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EHdH9FqH78SymLuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1bTDwAKCRAw5/Bqldv6
8ronAKCa0TGYPi5OAU9FXkRJOG9E0OPFRACglcW2OGfB04T5aAB22pQTdmVhWmU=
=YY00
-----END PGP SIGNATURE-----

--EHdH9FqH78SymLuy--

