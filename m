Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6104.1793911892847115163
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 12:51:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EaR2fnOd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78B1110D07B;
	Thu, 05 Nov 2026 21:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793911886;
	h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=vmWLBAhFp9mtPuFMeOdDOBok9N2ghnKYJwROFj6Y0Z8=;
	b=EaR2fnOduhf4XeMeGukpUIA/kb6PffdeG8MRuYx/aWqKfmLUEqReiHHFt6IaNl9ZTYFDlO
	Ehyn+GnwY76PSZ8IbxoEvd+v+bYt1U56YT2fa5YK8J7s5YKa1u1oOowRBGBrWNMngcf7p1
	er471qSwZJiWQWZGN8ydjhjX1o2l19qpdZaL6Zwh1Xgx7vetKa6sTHwNDHg9VunJvsUVb5
	GIZi5nS1QRr+Y2TsTFF5Bp9j0yoLFxxGR+MpshKPfus1FZjQ864/S/d5SQjdmqJunj+ZLj
	Tp3lRYfMeJ6gg1sB7C9BYLVX5kid/Yvee2aJNGi39hzyWdV2FFOi7ionIm5y7Q==
Date: Thu, 5 Nov 2026 21:51:23 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Cc: claudiu.beznea.uj@bp.renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] Release v5.10.272-cip79-rt35
Message-ID: <auzsS37v3220jhcZ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="owom5blhUTpBlq7o"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 20:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24652


--owom5blhUTpBlq7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org. We are a bit
early due to "fun" CVEs.

I had to solve rejects between patches
2c3e0afdf6b850fb9c7109c73414db4a4d79c80d "driver core: platform: use bus_type functions",
5ba59245f2f8686887f754130716a1b86fc37894 and
c72281969950c6c86bdd55e5f8248effb1fa9868 "driver core: platform: Drop
dev_pm_domain_detach() call", related to RZ/G3S. Rebase got it right without my
interaction, and tests are passing, so I believe I got it right, but
second set of eyes would be welcome.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--owom5blhUTpBlq7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauzsSwAKCRAw5/Bqldv6
8jHzAJ9sKiJHcu93UcwY+UxchEoEY9DqLwCgugeqqSOri3XapxZ3kncZgCwritY=
=K741
-----END PGP SIGNATURE-----

--owom5blhUTpBlq7o--
