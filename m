Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99714C4167B
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 16:06:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77459.1670947571221524238
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 08:06:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA8B71C09F4; Tue, 13 Dec 2022 17:06:07 +0100 (CET)
Date: Tue, 13 Dec 2022 17:06:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Message-ID: <Y5ii74pEmCLaW0P+@duo.ucw.cz>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Vndp+SULL5dYvTA"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 16:06:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10219


--0Vndp+SULL5dYvTA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Anyway, I will post this patch to CIP ML today.

The code was moved around with

commit 59a641368b460e4d1e8dc58a922915591303bd54
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Wed Dec 22 13:49:45 2021 +0000

    can: rcar_canfd: Add support for RZ/G2L family
   =20
    commit 76e9353a80e9e9ff65b362a6dd8545d84427ec30 upstream.

Sometimes later, I see your commit:

commit 702de2c21eed04c67cefaaedc248ef16e5f6b293
Author: Biju Das <biju.das.jz@bp.renesas.com>
Date:   Tue Oct 25 16:56:55 2022 +0100

    can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on g=
lobal
 FIFO receive

=2E..and yes, it looks like we may want that one.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0Vndp+SULL5dYvTA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5ii7wAKCRAw5/Bqldv6
8pq3AJ4hbS/Mz4TblGk3Uqvp+iSXEP0tHQCgobQLn7DfBj28liB+2BAPZ9rCIMY=
=Salr
-----END PGP SIGNATURE-----

--0Vndp+SULL5dYvTA--

