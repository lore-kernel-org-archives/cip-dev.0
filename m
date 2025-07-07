Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04EC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 10:04:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.56350.1751882655766593269
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 03:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dRgkU6fj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A652310380104;
	Mon,  7 Jul 2025 12:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751882654; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=LRbujraN/GNYWFirgkeiL9gG5Nv9BdK6tKgVueoZ1i4=;
	b=dRgkU6fjDNTBqbpGC67zTj8QX9ST2o12NnXvfMup58eIalWsUZPefpQKGFASXan9V28/cT
	UmKsCrFIKlf7OKjFVO5COeMWBvws000l+9yjDdY7oq51rv8e4ux2+jDUiGqGfh2bo5XHcr
	uojHZcmwSxqzE3rH/odPX6w7VYCb2nnnopFrIYPzC2GZ8iyozijWM5jbYkfADwQYCI1sHQ
	rl3lAmybRpnJjas0M4KXMV8Y8M45/RgWg0a9fAOBWhQIc4Vg9UpllS938TE2Cmo0ueO7n8
	2q51cMCLTVWZNMTgxOxaPZEfqyRDTwxIL67BjmOdNDSqd/LibD9GODhe+CM/pw==
Date: Mon, 7 Jul 2025 12:04:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Testing -- plathome_obsvx2 has problems?
Message-ID: <aGubmZMZYf7Ww9EP@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8up+4ckAcPOeV0Kr"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 10:04:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19383


--8up+4ckAcPOeV0Kr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting a lot of failures in -stable-rc testing... it looks like
plathome_obsvx2 is always failing. One example is here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
904974561

Newer pipelines just show it as "running".

Is it okay to just ignore that config for now?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8up+4ckAcPOeV0Kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGubmQAKCRAw5/Bqldv6
8qsXAJwIqRhN83VIR/6Y9TSQIzauLQw7EQCfQU91WJPIe/tSfY89KExWjQNMGoI=
=qRAb
-----END PGP SIGNATURE-----

--8up+4ckAcPOeV0Kr--

