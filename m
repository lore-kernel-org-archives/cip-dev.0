Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC09C5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 11:41:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.20577.1709293283134485264
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Mar 2024 03:41:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 897E91C006B; Fri,  1 Mar 2024 12:41:20 +0100 (CET)
Date: Fri, 1 Mar 2024 12:41:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"van Buuren Sietze (XC-CT/EMT2)" <Sietze.vanBuuren@de.bosch.com>
Subject: squad was Re: [ANNOUNCE] Release and and v6.1.78-cip15
Message-ID: <ZeG+4IMAEEcc0lPy@duo.ucw.cz>
References: <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862EE8B1050FA1EC2B312B4B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <Zdx+bq+O5nbxh/0J@duo.ucw.cz>
 <TYWPR01MB11862BFA542FA685652E73FA8B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3RNiUdsdV09C0LFB"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB11862BFA542FA685652E73FA8B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 11:41:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15114


--3RNiUdsdV09C0LFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > . Is that expected? How should we deal with those?
>=20
>=20
>=20
> If the "incomplete" LAVA job has a green ticket next to it (as in this ca=
se), the job has already been resubmitted and successfully run again.
>=20
> If there is a red cross, a LAVA job failed to complete and hasn't been re=
submitted yet.
>=20
> SQUAD admins (me & Sietze) can resubmit these LAVA jobs directly from SQU=
AD, then SQUAD automatically keeps track of it all.
>

Still looking at Squad. I submitted test merge to LAVA, and it is now
being tested at

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

=2E Where can I find it in SQUAD?

And while browsing around, I stepped on this:

https://squad.ciplatform.org/linux-cip/

There is still lot of skips and fails there. The 5.10 ones are from 9
hours ago. What is going on there?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3RNiUdsdV09C0LFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeG+4AAKCRAw5/Bqldv6
8sJJAKCj8eMO+pbWEVSYpqmoye2KsL/rrgCdHsR4yYw9ELxkmolR2+PdzAjYPK4=
=xokB
-----END PGP SIGNATURE-----

--3RNiUdsdV09C0LFB--

