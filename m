Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2404C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 16:14:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.16696.1747325689471531959
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 09:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eaDQfxq+;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 394821039728C;
	Thu, 15 May 2025 18:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747325687; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=1XscWDXimCZ1+pLFhVXDuJdLXDUWfpktd3UypYQsAbE=;
	b=eaDQfxq+FohHWNLYMUP7yYNgd1h8yt7NfvVAQWxE0Zlo6nkSWd099jetM4N5XwVZCxIkow
	JM9vIzCeJPYfdk6lJ/mjfgdRBg2mQCp1FES5kX4dDcg46PnkgHPEcfoKh0tkMECa/iwtB/
	dBCStf+YhMYP8j6s6/NzNIQ6kLqKzURAJG6KgphJiMKDCBkrMA+7/HvDaGes27zUhTtFT+
	qNk5nnyNKc1pb5S8/jj+efQyPXv7cLE5MAX2DN8D/D6Uis7oKS99sJ+pFacigdOVA2KYdz
	a9KMGoSq7v0UzJu1mWxXRLhBIx8ZmXj9Pol+zkmT1qvQtgqWKFtMzwbkg59Vcg==
Date: Thu, 15 May 2025 18:14:41 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.237-cip60-rt26 (rt131)
Message-ID: <aCYS8ZNpHwmulW82@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xMaDyhBEelZruiAU"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 16:14:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18916


--xMaDyhBEelZruiAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xMaDyhBEelZruiAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCYS8QAKCRAw5/Bqldv6
8uxOAKCVm9QiV9cogYJ0x/yaKYDNk4Ls2QCgp7ztZ1amxxbPM7XusWwOT5A/a6M=
=fkUt
-----END PGP SIGNATURE-----

--xMaDyhBEelZruiAU--

