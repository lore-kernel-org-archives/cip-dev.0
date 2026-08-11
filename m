Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1DC5CFCF
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 11:12:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51820.1786446724946416694
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 04:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Pqm5il+T;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D852211BB7A;
	Tue, 11 Aug 2026 13:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786446722; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=kOSc0JeKveCGCeD6G8snVh/lU8Kb3ZhNXrHS7Z2l14M=;
	b=Pqm5il+TSgDVc1n4sdXM+/je9nmxqRTc4U9q42twEsAaWalrH9S0bp/gAuf5qO0cbt6+Eu
	JdXBPcZm+IT5Ip1aNmj7QA6F8U6EhXQEyxDr0cu41pUXqfI0vTUOedFvwlUS3ELMkCvOVS
	UOxPhKLOjWC81K3qjuAkj6VPLs8QJwQ5+VtyR82LRX+szoQzBeTbDMqQBfrW291gMxE6T3
	hoqLAUFo+YiYvBuahiCDk9jSuo3yzxmV3BK/kIYZQ1cBaUSQ3IImufNspNGyc/ouk/Zck8
	APgzE169vvE6EhuMj1CfhPImAxm2Fj07nx7Nmkb7zym3KpzJ4Fs8WeiBQm4oNQ==
Date: Tue, 11 Aug 2026 13:11:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org, rnkenchor@linuxfoundation.org
Subject: CIP TSC meeting today?
Message-ID: <ansDfyfjUgGYHWMG@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4tdXcBEucG4+hc5"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 11:12:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23896


--k4tdXcBEucG4+hc5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have just got email from Regina "Regina Nke Reminder: CIP TSC
Meeting =E2=80=93 Tuesday, August 11, 2026 at 1:00 PM" . But my notes say no
TSC meeting today... So which is it?

Best regards,
								Pavel



--k4tdXcBEucG4+hc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCansDfwAKCRAw5/Bqldv6
8mDSAKC3r2iolyD1K7QcIXFbJSEHnlPSsgCgnz3Aro8WbI7Jwlq13O4OzYl5Jl8=
=6H0i
-----END PGP SIGNATURE-----

--k4tdXcBEucG4+hc5--

