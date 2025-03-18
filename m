Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC2C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 08:33:53 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6831.1742286823498573123
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 01:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Y4zLAK34;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AD5C101F7A35;
	Tue, 18 Mar 2025 09:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742286821; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=FB1gcy56IjR0coBOytlk4vxi9rHHDIVg4lkV6OxZqUU=;
	b=Y4zLAK34Pe0hoEqY44p2JikOrNZxzMyVMRk2GGEtxGoVPNv/39h3U9AQqDOUQ32ha5cf0J
	048HFKmyjgdh6wZ4hoLE+JGVY/S3CwgmcgUges5VIGNaIb1cS9B8bRlGAOMYrVcIks2LLM
	mZYkdJ4HbUKityZtc9HWU+qnp3pMogh2d/fNjOgz0/HIowM3DeCqOLlDSAMUrH6zi7RhVd
	owALM8ngemjB5PjURX+FfdQ4CaO1gy51MeAoqPCIX6RgjF2ujfeJe6WU356q/ue7Su+wYT
	dBYKD/mvpNZ4PEX3VTHQTvt/3DGwiBfAuhfm/LIEDhL4m4axLj5dkq045kfjkw==
Date: Tue, 18 Mar 2025 09:33:37 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: v5.10.234-cip57-rt25 (rt127)
Message-ID: <Z9kv4aijWXNBDCrj@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hpl+61h7sAo9PZ27"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 08:33:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18237


--hpl+61h7sAo9PZ27
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

--hpl+61h7sAo9PZ27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9kv4QAKCRAw5/Bqldv6
8kuNAJ9PRhQtOoBcZnkkO+ACWqhgGtEmgACcDeJu7/7x/eiT3u5oCVzowLTt6SM=
=MT/D
-----END PGP SIGNATURE-----

--hpl+61h7sAo9PZ27--

