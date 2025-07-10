Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA59C83F17
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 20:36:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.5077.1752179802531125347
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jul 2025 13:36:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DU36/uxc;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 867A910380104;
	Thu, 10 Jul 2025 22:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752179800; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=E4qufP//qT19KHdR4ZgD1oxrh0TmhR27J3qXtagqrD4=;
	b=DU36/uxcB4MWHwP0TIte06XfuIQ0vpOTAl4TzdCiXjmQeFTJoLOI/rKu3OWC3y4tMAO3/j
	KCG3bj6MX/9/bth3Q/68Vko6AbM+7J2/DXEXiofVefy5aZsARd26SWSTZwHntVXGFK5YgY
	Ia2owMRek6ag1cwvIJZ588wkSHpuIDeQRPuznqatD1mFXdHgf92l/K8m78SgPSuVlRJCa1
	DBovJtCNFjOWBagQCZQWpIbJ8IF7fq3cMzbUzUYndQ+YyMLQ77cjdDfPEL3hSfnAxV5tVH
	UIMccLguXC51Bc6v6yLQuKQebXgf4vd8rsJZ3NKa70uSKtU5WyDeSrYsbsXWvg==
Date: Thu, 10 Jul 2025 22:36:35 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.141-cip43-rt23 (rt52)
Message-ID: <aHAkU7O5osXfjAEp@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bOql1+WUT0AYz23B"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Jul 2025 20:36:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19392


--bOql1+WUT0AYz23B
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
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bOql1+WUT0AYz23B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHAkUwAKCRAw5/Bqldv6
8sTxAKCjLHbyMTa65kA61JnZYNDBNa11pQCfXt8uif5JdVm9TCJ3V6qRnDsWJTs=
=J94Z
-----END PGP SIGNATURE-----

--bOql1+WUT0AYz23B--

