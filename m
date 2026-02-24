Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99868E9B251
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 11:35:49 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18426.1771932943029503610
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 03:35:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=B8t9qkj3;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B947F110965;
	Tue, 24 Feb 2026 12:35:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771932940; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=VTDg36z8lleFInekzzQ8uC0SFCfMcTAtMJDQ4Zo2JUM=;
	b=B8t9qkj3PVKrO/vJ3bIqaQp1w/QJ05VK/O5sYXDfOLA5MoJgS7k2ix9/mrBhs4oW2tevYH
	UynVrgS6Y6q6Ub6d/T0CjqEZs8k2o92GBtQVWTKHUBIk1mvtwiXNml5YipviMil6Hoskep
	2VwKp4QSzARnWpvin2dfpTlWRfY/sH/RKBy+OsMchyMah5G13uBonW6QDVVgRV+bNCfzRH
	D3OCiByETqWfZAA4lQG0wkq2TCMLaou/8xn+KI2pqFM6JiXdLXbj7dWT9nGwL1a1+N3/MS
	l44DyQkttBt+n8A6cUkoI51tfN/GfGvLhLx9pofcoftnzta4Wh5syUsKJyTI0g==
Date: Tue, 24 Feb 2026 12:35:36 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] v6.1.164-cip52
Message-ID: <aZ2NCAjQ84hN4saH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6fjIMVklY9uygB2d"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 11:35:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21921


--6fjIMVklY9uygB2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org. This is a
preparation for -cip-rt release.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--6fjIMVklY9uygB2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZ2NCAAKCRAw5/Bqldv6
8ieoAJ4xLrdgISZR+nXCyZfNjX8FEmwl0wCfcia24DShPXmEeAoks5Jo8tY5+j0=
=ecSX
-----END PGP SIGNATURE-----

--6fjIMVklY9uygB2d--

