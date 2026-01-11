Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55943D2502D
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 16:52:47 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13796.1768150362288479782
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Jan 2026 08:52:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Bbhpr9I/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D78810972A;
	Sun, 11 Jan 2026 17:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768150359; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=GDTTmPZuDCrWajHRRDmzW/zvOkQgW9JFgPKk+P/ppO0=;
	b=Bbhpr9I//0TALLHSc5FFwtTVKVuvZaWCOHGS7a9LgTZEK3axG6+ZM5kt2LEwBYJIN3kakc
	J33WvuAJKzxJFo8DPWH3Y4yyf51DjW9Ck/YZ5uxFYUXjrdm+mg0adk/caaBG5492Bl6WMq
	xdMYLfVqn48IDk6fqxmErkNoGc9MJrDN+rpooQ71o77+IDtxz3s5608r4db+806L8Z9Iq+
	uQkZY7wrcLCqfdDpENPwVpWH7WlUuDBx+E0wYGP1Apszpk2LBwwv8ymuLbiCAU2Aw8QGLR
	MJxvlrrmnnoGNZv1mTh/c8nMam+W3Dqi0gRams0MrKq07e3UKCRk1IjT6CJQkw==
Date: Sun, 11 Jan 2026 17:52:36 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip106-rt59
Message-ID: <aWPVVFx+ayHApV6o@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FOQpLBrLO2YVADe8"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Jan 2026 16:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21529


--FOQpLBrLO2YVADe8
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
In cooperation with Nabla.

--FOQpLBrLO2YVADe8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWPVVAAKCRAw5/Bqldv6
8l1MAJ4v/TUbslQPPtcDF/gYBG8SgoGhJACeJj4oLlpGRUcwp4rrKGwmA8xo1gM=
=jUZk
-----END PGP SIGNATURE-----

--FOQpLBrLO2YVADe8--

