Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8701C25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 11:02:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12742.1716462116636564977
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 04:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 42BC31C0081; Thu, 23 May 2024 13:01:54 +0200 (CEST)
Date: Thu, 23 May 2024 13:01:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Michael Adler <michael.adler@siemens.com>
Cc: cip-dev@lists.cip-project.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: Re: [cip-dev] gitlab testing stuck?
Message-ID: <Zk8iIfG70SxOC7gx@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <Zk8NZmeJPwIYiqqH@duo.ucw.cz>
 <17D2152C9599A0A5.4692@lists.cip-project.org>
 <c4topyfzwtzk4h7525yjhe56lgtrisjfqkbsvmboz3o24wgub7@ji4aqgxfow6b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+MbsS/2qrXUwKoZ"
Content-Disposition: inline
In-Reply-To: <c4topyfzwtzk4h7525yjhe56lgtrisjfqkbsvmboz3o24wgub7@ji4aqgxfow6b>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 11:02:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15933


--H+MbsS/2qrXUwKoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks to Chris for providing me the new tokens. I've registered the runn=
ers
> again and it seems to be working.

Thank you, testing seems to work now.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--H+MbsS/2qrXUwKoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZk8iIQAKCRAw5/Bqldv6
8loIAJ4hF///s+4ii9qRqc/5eP36okYGRACfQUdYBHlvq6Swtdgc/0PLBBcf0MY=
=o5Dh
-----END PGP SIGNATURE-----

--H+MbsS/2qrXUwKoZ--

