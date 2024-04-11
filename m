Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC6CD128A
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 12:07:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16172.1712837268030568799
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 05:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6B1521C0083; Thu, 11 Apr 2024 14:07:45 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:07:44 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: stable-rc tests failing in squad
Message-ID: <ZhfSkDGKBRR+p/Bs@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t1U/xnRZOYDb7CRH"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 12:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15543


--t1U/xnRZOYDb7CRH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, I had to retry a lot of builds in gitlab, in 6.1.84 and 6.1.85
testing. I'd not mind someone investigating what went wrong them.

Second, squad still reports broken tests in 6.8.6-rc1 (and
others). Can someone investigate?

https://squad.ciplatform.org/linux-stable-rc/linux-6.8.y/

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t1U/xnRZOYDb7CRH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhfSkAAKCRAw5/Bqldv6
8lb3AJ9MoZDzTFMZfymhitdaAu5pOAfxTwCgmd7ahxvqfKFLpZV2U7RJbTty3Uk=
=kSHu
-----END PGP SIGNATURE-----

--t1U/xnRZOYDb7CRH--

