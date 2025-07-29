Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A4C83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 07:35:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.1932.1753774520176677414
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Jul 2025 00:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TDEOa5Ow;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC1B91038C126;
	Tue, 29 Jul 2025 09:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753774518; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=iKTUEFbACujY8fWw4tNADLB4Ihid/6jRI6tDnZVURnM=;
	b=TDEOa5Ow95EXCIf7NwE/fVyN+Ld1ij2+7OBmTqJ4UaGs8kmc4oFdy8AY89FpCcQ3Fk7ZHE
	7V7MjCmFyUu0fK0RF7KRFZgUBx2VI7xzx5Xx5lOPSNh5uxuPKNvfRoWM9N+7grTNWlWDuN
	DZHlJJWXl0HRKp2rHnoeZ9E1+qY7/9v45sHFt2DfNNdLCdE/h4dlYwfbXd7UX5fk0CxRII
	OJr1XZx9stnAeGP2J9UtPDAQ74j6Q0vQoEAq86aDna7Wtqkj3M62GyeyUTqGY0PpnJg6tD
	RFrDkslq/DEsfINXVUH0OQcCY5cidXXDDiQnEsnTMDhA23izjdZr+IP+J6SgSA==
Date: Tue, 29 Jul 2025 09:35:12 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip122-rt43
Message-ID: <aIh5sO3ItXxcgiTN@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XrCRklJQkOATU4y3"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Jul 2025 07:35:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19612


--XrCRklJQkOATU4y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

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

--XrCRklJQkOATU4y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIh5sAAKCRAw5/Bqldv6
8kieAJ9f5uvrL1sf1fXju3FXPGaGBUk/DwCggUeiSu/SIyqFlegZ8ZPXFPa9lzE=
=HtD2
-----END PGP SIGNATURE-----

--XrCRklJQkOATU4y3--

