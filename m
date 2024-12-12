Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA64E7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 11:14:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.17637.1734002089459753078
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 03:14:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Y+7crgBj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D98410408FB9;
	Thu, 12 Dec 2024 12:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734002087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=UBqPcIHAHaLHNayKYRtNfTfNN7fu0nHKjuCwVulu49w=;
	b=Y+7crgBjtc735VCh0Ctl1oCnZvqd+lV5VayOa5G6bBEEltOSutqDoX5Q7KxL/p9Kfcjtt4
	PBOmTxQd2UBVTIeQQXVsc28LTwYPRw/Cxo8W8cSbyhyE+I85ARzYCD3WRkpyKdiACcBUD6
	3CFPOgsZazStdFAOhE0kyczPrxoSkSucX7rR6iDoNiJyEnz8Xnv9VKDIajQv9JGrtOYCwN
	+2vuk48CLhEo/SGYRDUPZxK3zKfPquZPA7oYxw+IKgTHHI2FLnWXMxdqLNxXDvw/FhP50F
	UhIPfjtczG/qakKpDBv03WQQpi2k7QFVBYRPZFMd1mpenEflGbogmR/hvjglPw==
Date: Thu, 12 Dec 2024 12:14:43 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.119-cip33-rt18 (rt45)
Message-ID: <Z1rFoyUCGdkcslAP@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HaUwYMhodOS6GLcF"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 11:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17413


--HaUwYMhodOS6GLcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HaUwYMhodOS6GLcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1rFowAKCRAw5/Bqldv6
8uo1AKCThxsZg7yNE81joezunQwphIMpUgCgoRp4EXx+BLq6I8+mCyUGnj5NRzQ=
=KK3m
-----END PGP SIGNATURE-----

--HaUwYMhodOS6GLcF--

