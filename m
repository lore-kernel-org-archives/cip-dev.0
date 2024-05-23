Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB6C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 09:33:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12764.1716456809508162915
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 02:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DC5D91C0081; Thu, 23 May 2024 11:33:26 +0200 (CEST)
Date: Thu, 23 May 2024 11:33:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: gitlab testing stuck?
Message-ID: <Zk8NZmeJPwIYiqqH@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wADqQf/qQsKQ2lLf"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 09:33:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15928


--wADqQf/qQsKQ2lLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There seems to be something wrong with gitlab testing at the moment:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1302074556

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/6920224416

gitlab says:

This job is stuck because of one of the following problems. There are no ac=
tive runners online, no runners for the protected branch, or no runners tha=
t match all of the job's tags: small

Go to project CI settings

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wADqQf/qQsKQ2lLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZk8NZgAKCRAw5/Bqldv6
8hJ7AKCF8mu7FpmwbL96X1/4Wx7TDDPpcwCff4gmmEZiHQvlwLMN6wkwM6Ng0Z4=
=DQK+
-----END PGP SIGNATURE-----

--wADqQf/qQsKQ2lLf--

