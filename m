Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9FCAC5AE
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 17:17:59 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.20048.1758734271206784891
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 10:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=J9DS2jN8;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A95191038C109;
	Wed, 24 Sep 2025 19:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758734268; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=DDlrdXy0uUrTqnG2g8c5yJvQu2c60ox9/gr3AMqZTJw=;
	b=J9DS2jN8LRUUmWOUOQKpI4kkfxnwViiul3SUWca6Du4gJs0knebA9MwxVvE7xO1zDNW5b4
	JYgS1ix0/+wE2Zf+D0qQFlUg1Mq7z94gcmsNLVvSO9OJNXpMMQy0BzsEyDa8BsSrZy0EXe
	i7Mt1E2IjcmVPGl0QeqDDLqotdvLc7Py5wqU9JqM2NMQH5newN3WyC9wMMkxinE6l4jajD
	2pBeNxK+VH4vFqo8/VaRU+XgVXMpm2KWEADsTstMKWBa2ItrsvkbJJhxhnOMUkgjtaB16/
	FzG73la7Z4P7+H8RVpYgLUovXjhXoxwJR+zAgrHwqwKgZp8icDomVDdcPN7Jug==
Date: Wed, 24 Sep 2025 19:17:43 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip124-rt44
Message-ID: <aNQntwX9XEJwfnxp@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1kFrW/UOHQAK/roQ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Sep 2025 17:17:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20119


--1kFrW/UOHQAK/roQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Release is few days early, but I don't expect new 4.19-cip release
before the deadline.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1kFrW/UOHQAK/roQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaNQntwAKCRAw5/Bqldv6
8rCaAKCOu58y+JVQfatq4mmGSkhsOoBPbQCdE42HEnG2VKyUvcq+dGxpuh6Wb9U=
=BbJz
-----END PGP SIGNATURE-----

--1kFrW/UOHQAK/roQ--

