Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB33C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 09:23:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15715.1739870599076170614
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 01:23:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=b64x+9eV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFDAB10382C18;
	Tue, 18 Feb 2025 10:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739870596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ym/tMmVBhuVEFteptlsW+wrrvo2oDApP/+i7E5wztPI=;
	b=b64x+9eVPMtAGvPYkJ6WZC3fmxj/NACK0K5Wm+Ew2L6eMF3wBwimBYnIa7WfrfSbZd7us8
	vW1qbz+1qOiYZSYtmMeO3G7gbG7HjaNIS8DMo7q/AVZFpSeV9xqWDmfL+oXcjFqLcc9+qm
	CPFE94qMqRDZyh2xEboC/mdr1U3/F1vS+Bq1uvCa3kSOmGiEK3kuvx+2Pgm+Vp3RUcBPnj
	PP5D0VIzWdq8hiTQBEpF/Zzs0vNxQ7xIGX4Ij85cOmRTtevVXwS5CxxdaYuz0Y1+e4mPEY
	MpaCK/xlzKGC5VrFpQr1ap5YXTj91KCDp6AqZZzHk5j4JNGqj8r7S+Vtf7d0Nw==
Date: Tue, 18 Feb 2025 10:23:11 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip96-rt53
Message-ID: <Z7RRfyM2xvXrgmhj@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THWvM2E+3z7N/ezu"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 09:23:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17862


--THWvM2E+3z7N/ezu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--THWvM2E+3z7N/ezu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ7RRfwAKCRAw5/Bqldv6
8rdKAJ95b2JOSf08wcYejTHngiF7Zl8EFwCguWJTRW9MJF7r1lmMx5iyIk+7hXM=
=vyEh
-----END PGP SIGNATURE-----

--THWvM2E+3z7N/ezu--

