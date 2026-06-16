Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F6CD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 20:36:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.538.1781642172593362798
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 13:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CLx3rrmd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4D0D11362F;
	Tue, 16 Jun 2026 22:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781642170; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=csnirTbU2lyiPwi4wtSOujJd8QHF70lzEfJz5hi6ww4=;
	b=CLx3rrmdNGKaeRvmDkKMvm3NSxkNohFQkVObUTiI015+iSvZHGM1MTcdbeTfwNXxmoQQDT
	OtBD3k5O3G8fKwrnC4/rYvb+7/E6yQ1Lif6BiaXsF4RlzevDB7AvMDT5bYk5doIjD9Q8kj
	SrO+Zip77Vj+bquhC8q3J2na85uCOTUAhFquBWXd4N4tXcKfmq83OlOKucv7tpX1Fiurz/
	jfuuVvSFNLWMj6S1CMsgjKoZNpsq8y47f9lERP/Bm4wPf4GHQDYqTgmOCrSEPJ6BaZB2bo
	shJtt/Doq9QRG2fJmG/A0yByrx26mkbgD9VcJPMpFJNwAKoHVihzcA/F7wvrhQ==
Date: Tue, 16 Jun 2026 22:36:07 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.175-cip57-rt30
Message-ID: <ajGzt6msWzy02GSX@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qX7wT+rj6+T0ZhED"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 20:36:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23156


--qX7wT+rj6+T0ZhED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--qX7wT+rj6+T0ZhED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajGztwAKCRAw5/Bqldv6
8qECAJ9NccwwfgBjSM3c4PY1BvjBs8GmiQCeOTM9In08uE/MNyLkKi03V/6DuX0=
=t1g3
-----END PGP SIGNATURE-----

--qX7wT+rj6+T0ZhED--

