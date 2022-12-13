Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A48AC4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 15:52:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.77037.1670946719710102193
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 07:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 76A431C09F4; Tue, 13 Dec 2022 16:51:56 +0100 (CET)
Date: Tue, 13 Dec 2022 16:51:55 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Message-ID: <Y5ifmxuSAOkRGLv3@duo.ucw.cz>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TLvbElhq1z558Rdv"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10218


--TLvbElhq1z558Rdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Anyway, I will post this patch to CIP ML today.

Let me investigate. We _do_ have that patch in 5.10.y-cip and that
patch does not "simply apply".

commit eb69c07eca22ffd8621d9de9378e4b3ce7965190

    can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on g=
lobal FIFO receive


Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TLvbElhq1z558Rdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5ifmwAKCRAw5/Bqldv6
8hRnAJ4kbHcPbvNv3gtZg5fJWvUOzCjVtQCfQ+s4q0vma1Ds4wd1MPIqqlpKc2Q=
=joAR
-----END PGP SIGNATURE-----

--TLvbElhq1z558Rdv--

