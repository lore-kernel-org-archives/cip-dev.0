Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D769C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 11:54:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12349.1717674878491601105
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 04:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 195901C0082; Thu,  6 Jun 2024 13:54:36 +0200 (CEST)
Date: Thu, 6 Jun 2024 13:54:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudius Heine <ch@denx.de>
Cc: Pavel Machek <pavel@denx.de>,
	Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: Siemens targets timing out?
Message-ID: <ZmGjewtL4yj1FDuy@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
 <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de>
 <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
 <4c30427d-d63d-42e4-a603-966c09aa9079@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gz39zda73sZ2Pitj"
Content-Disposition: inline
In-Reply-To: <4c30427d-d63d-42e4-a603-966c09aa9079@denx.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 11:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16127


--Gz39zda73sZ2Pitj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I will probably try to patch the `docker-compose` calls to `docker
> > > compose`.
> > Thank you. Can you ping me when I should re-try the tests?
>=20
> The lab-cip-denx is online now, and hopefully stays that for a while.

Thank you, it seems to work ok now.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Gz39zda73sZ2Pitj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmGjewAKCRAw5/Bqldv6
8s0LAKC9H5G3KOurEizr6X0FrhuZA/TKeACeIBIxv9aIOgZoh7hKfQGoRINZ3Ow=
=TWw1
-----END PGP SIGNATURE-----

--Gz39zda73sZ2Pitj--

