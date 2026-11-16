Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1033.1794854367064516353
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2026 10:39:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Pd1WiDH5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DCC510F26E;
	Mon, 16 Nov 2026 19:39:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794854360; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=+orMUcaKk9M2V+AhNsHLf1LWzLzbrIEPBnZi65T0gjw=;
	b=Pd1WiDH5v6iA05tfnZNaa7c5/Fq21XNhW0I0bhRfWjp+zcFe9YWmjIEoT2X3poZxer33cc
	R11hF2TfDUjKxXtRLUIz+FL9pQ070Xx09/wnbwWg5RK31GlQRVqfOyru7TDCi9++8OJR+t
	X4N+8gDeRq0Otl8VNzc0YmYOze1uIzw3DFm8IDQv8y2EkQTRmQQ1NldaW8IHmrMEiBwS9L
	DWiBfJ5sWmyZnr7mjo5AVYWAMpQd3IbIWk8Fag3L4fg8MlgwJApfDcY9RM7TS4urCdkO7m
	/tb20SahXYKzLWEtxq7nxepvsud9lBtM8oVjMKlyqcdK6Z+lbfrb017+2cIyog==
Date: Mon, 16 Nov 2026 19:39:17 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] Release v4.19.325-cip137-rt51
Message-ID: <avtN1ajkh2y0iYhF@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vAfZrNws/D1QveE0"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 16 Nov 2026 18:39:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24808


--vAfZrNws/D1QveE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--vAfZrNws/D1QveE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavtN1QAKCRAw5/Bqldv6
8tfDAJ9JPsW+aOKuvzDknUHEbIDGlr3jWACfe1o8YuxtE70pf2WbTNhaFUT65dQ=
=fm94
-----END PGP SIGNATURE-----

--vAfZrNws/D1QveE0--
