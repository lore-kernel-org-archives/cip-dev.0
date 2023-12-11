Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6603C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 13:30:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8193.1702301448140450028
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 05:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E7C5D1C0050; Mon, 11 Dec 2023 14:30:44 +0100 (CET)
Date: Mon, 11 Dec 2023 14:30:44 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] 6.1.66-cip11
Message-ID: <ZXcPBNau3KXVGYj1@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hinkDr4/PEVy/ILf"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 13:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14022


--hinkDr4/PEVy/ILf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org. We seen cool
number combination, so we could not resist urge to release early. :-).

Ok, no -- so there was regression in 6.1.64 affecting ext4 in
combination with O_SYNC and O_DIRECT. That sounded a bit scary, so we
are doing release soon. 6.1.66 should be fixing that.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hinkDr4/PEVy/ILf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXcPBAAKCRAw5/Bqldv6
8kQQAJ98XpCrzro3tCOm94Y3IoxAD8ElfQCfexOdtdTtv71N2OXtsxEkHZ1H5XU=
=aTLz
-----END PGP SIGNATURE-----

--hinkDr4/PEVy/ILf--

