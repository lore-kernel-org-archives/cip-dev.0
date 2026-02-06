Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13841EE2091
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 10:59:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8563.1770375551504829974
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Feb 2026 02:59:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=j/I8TTC6;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEF9D10F04D;
	Fri,  6 Feb 2026 11:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770375549; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=GRNE4C0heTRIzK5AFRofgzJQzUm5/P/WY3HQTiplmZA=;
	b=j/I8TTC6VBlA7j4Biw/XdPv7vjdWchTWXAqW0ADN732ufleXZx8PyWxHFCrYO4nV5CvB3n
	o/JnwzJYUbb2bey19Hb3Cu1yhcbMikoFwEkfu7ClwgRBgaeZ+tbNfWLBXnX4X5s0FkcTWD
	lxPryHc83vCLLkGxxJWOyXq5uNm4BO7j69U8nQ0ywFaK4gTpuKYaMSFt6dpdZS0oRwyJoF
	Dpf/EzN0ownNsOwT063RAFw4B/vrsVnTsA/HzwblmaxN7B5wjJ13U5pY+WV5/BcZUTxgLr
	1Te8eOlielXg/dx2hCpQrZ6rRS2cHU4G6ZiigV63LbbeFjBXl98NOku+lAed4w==
Date: Fri, 6 Feb 2026 11:59:05 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.159-cip50-rt27
Message-ID: <aYXJeQBQzXVAL0fS@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3avF63Ak/FumxfTQ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Feb 2026 10:59:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21846


--3avF63Ak/FumxfTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

There was no suitable stable-rt release, so I merged v6.1.158-rt58 onto
v6.1.159 (result is 36dd8d4e485e397e08ab8378f88b0eadb7dcd1bb) and used
that as a base of -cip-rt tree.

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
In cooperation with Nabla.

--3avF63Ak/FumxfTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYXJeQAKCRAw5/Bqldv6
8hWOAJ4z8GPO4S8+ULusRrjm3UUPUn5OQQCbB74lvSWYMc4rmlKJVZGwty5z+dA=
=Apis
-----END PGP SIGNATURE-----

--3avF63Ak/FumxfTQ--

