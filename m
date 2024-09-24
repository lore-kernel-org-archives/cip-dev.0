Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A52CF9C74
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 10:09:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10283.1727172548157068799
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Sep 2024 03:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B60411C00BD; Tue, 24 Sep 2024 12:09:05 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:09:05 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v4.19.322-cip113
Message-ID: <ZvKPwRDlK/pW+elq@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p23Gt42i2q/E9WmX"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Sep 2024 10:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16913


--p23Gt42i2q/E9WmX
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

--p23Gt42i2q/E9WmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvKPwQAKCRAw5/Bqldv6
8l9EAKCPZMHRLQ8SaVzn39ixKOYcZ4QQvgCgh6TF8lTSj8sI9HvzSI73zY/UhRA=
=Opox
-----END PGP SIGNATURE-----

--p23Gt42i2q/E9WmX--

