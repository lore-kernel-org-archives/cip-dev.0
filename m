Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5450.1795031753013834136
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 11:55:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=f+1skpTV;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD485109BFE;
	Wed, 18 Nov 2026 20:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795031746; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=edHGN56kwfT3XVXkqjGgjoaL7lftZaoTqyiznDoqIoE=;
	b=f+1skpTV+8A3+rNkXMB/J88zEz2mfcpy5d5U3vAYxNrd+RiY2TZNcCjEbSgz8B1LqOFAr1
	tGNS6cmmjxkp6kM46+DT1IX734S+PBRHf9+ZzxX7UuHEOag2EOUWhlhU5uaMlncTOj1o3C
	Me56mQ0hZtufxv5uWc4wgUndI7eTSuhmDqckS1rvfiaaNcBy6F9tPrXSYY7Em2y2Ypmk09
	uEQtA2tfSXvrbm+Ke7bhHGa42v5aMYZQsiEIxGUybaoVlXy03MaiD8mh+rDL/KS+7vnMiK
	GUArxxidTywXXBKHlbLgssR33LoFxOg4U340bCgHlO37UDa5b4/PgcoBxtyNqw==
Date: Wed, 18 Nov 2026 20:55:43 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] Release v6.12.118-cip36
Message-ID: <av4Cv7rk86FmRQ0J@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pa0WW1sOj30fqUQb"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 19:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25002


--Pa0WW1sOj30fqUQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.12.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.12.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--Pa0WW1sOj30fqUQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav4CvwAKCRAw5/Bqldv6
8lq4AJ9Z8TrvSJ5KO3hBbi8BFHQPSwFgoQCgppJjw+DgL7UiNGoes+TtrDqhl6U=
=VVYM
-----END PGP SIGNATURE-----

--Pa0WW1sOj30fqUQb--
