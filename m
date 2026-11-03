Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1557.1793731418380924609
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 10:43:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Xgz+8IOg;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3989710C74B;
	Tue, 03 Nov 2026 19:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793731412; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=FMHJV6U/LgX4K7Z+pbocNVvOTISX9wH9NZLHS2rsPno=;
	b=Xgz+8IOgApE3CyzgIYU6q9CUkPBaRP9CE2COxrWdi00fh3u6EOXUEh8mDwBiFg8gJprf/9
	AvDDvT33op168Qnv9jrEFSZN+pnprgZhD0xTHRgX7qcImRkza1C8sA/7l8dMK+cQjrEMG/
	St1W43mYUg6WXaHktTqYyrk95rzsM6Io+PQFtqSNThnrZmeVVQAfqp15kfiqNmDnmW6fLC
	3rD9DYI1kTijmIyGsiFDxUwK/vl9PaR5VXxdY1dy7WVokzdcMHaEse7LoozdNQITRjbduF
	wyDkgwGPvU/Mt+0gEQnkqeSFLxB68F0ZERMo843/+RuJU3an6w3TDGt4X6fcig==
Date: Tue, 3 Nov 2026 19:43:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] v5.10.272-cip79
Message-ID: <auorTz_TmlMMH0CJ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n3zeWeBMUSwvb/XJ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 18:43:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24633


--n3zeWeBMUSwvb/XJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -cip release should be available at kernel.org. It is early due to
recent CVEs.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--n3zeWeBMUSwvb/XJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauorTwAKCRAw5/Bqldv6
8gneAJ9x1aGlXWetMUj9+chOVexP7LfQDACfRfArh7Vc5GTaYlJ4faoOJqIYXso=
=Z3UG
-----END PGP SIGNATURE-----

--n3zeWeBMUSwvb/XJ--
