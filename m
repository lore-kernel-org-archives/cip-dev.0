Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A102C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 17:59:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.91196.1701971965061695492
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 09:59:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 911D81C0080; Thu,  7 Dec 2023 18:59:23 +0100 (CET)
Date: Thu, 7 Dec 2023 18:59:23 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <ZXIH+1Uons/2PtB0@duo.ucw.cz>
References: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
 <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <ZXGm8hlfZRmosI1O@duo.ucw.cz>
 <TYVPR01MB11245642F579F30840E67FD7C928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pg4yaNcs6ipFIlFF"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB11245642F579F30840E67FD7C928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 17:59:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13900


--pg4yaNcs6ipFIlFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > linux-4.19.y-cip: interval 30 day
> > >   latest version release date: Mon 06 Nov 2023 04:21:02 AM UTC
> > >   limit date: Wed 06 Dec 2023 04:21:02 AM UTC
> > >   Status: late
> >=20
> > I can do the 4.19-cip release if that would help...
>=20
> Thank you.
> I plan to do this this weekend. But it would be very helpful if you would.
> Please go ahead.

I went ahead. Sorry for confusion, I only checked the emails after IRC
meeting.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pg4yaNcs6ipFIlFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXIH+wAKCRAw5/Bqldv6
8iF7AJ9NqlPJeAYDyQPoIB0OBDbx9tAD8wCePqUPkhz3xv68YivisI6g1Xgq3iw=
=k8s8
-----END PGP SIGNATURE-----

--pg4yaNcs6ipFIlFF--

