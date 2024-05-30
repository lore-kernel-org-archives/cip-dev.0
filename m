Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CAAC25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 11:12:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5667.1717067569582832649
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 04:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 510291C0080; Thu, 30 May 2024 13:12:46 +0200 (CEST)
Date: Thu, 30 May 2024 13:12:45 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, jan.kiszka@siemens.com
Subject: Siemens targets timing out?
Message-ID: <ZlhfLfL7fmsHShTx@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG/IzdgK+D9VXGSZ"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 May 2024 11:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16072


--HG/IzdgK+D9VXGSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to test Renesas Ethernet changes, but Siemens targets cause
timeouts. Can anyone take a look?

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1310801626

Thanks,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HG/IzdgK+D9VXGSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZlhfLQAKCRAw5/Bqldv6
8hbeAJ49jixwO8rBZ/2eChDh8WwUfcQDDACfRxWlcko2XmoMHNmwiXsaPJifkVM=
=kZqK
-----END PGP SIGNATURE-----

--HG/IzdgK+D9VXGSZ--

