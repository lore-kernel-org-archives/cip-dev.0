Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FDC77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 18:02:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.27308.1683136946692515047
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 May 2023 11:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BAFE71C0CAF; Wed,  3 May 2023 20:02:23 +0200 (CEST)
Date: Wed, 3 May 2023 20:02:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: 4.4 localversion-st
Message-ID: <ZFKhr0PY1FXqYgGu@duo.ucw.cz>
References: <2bf16d2e-7c8d-467f-2f72-3e0925536dbb@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7TcBbJ0HlHlY6Z+5"
Content-Disposition: inline
In-Reply-To: <2bf16d2e-7c8d-467f-2f72-3e0925536dbb@web.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 18:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11408


--7TcBbJ0HlHlY6Z+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I just noticed in some error message that our 4.4 kernels are reporting
> themselves as "4.4.302-cip74-st39", and that extra -st39 is coming from
> localversion-st. Is that intentional or an accidental effect of merging
> the -st tree into the cip branch?

That's an accident. Intention was to delete localversion-st when
merging it to -cip.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7TcBbJ0HlHlY6Z+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFKhrwAKCRAw5/Bqldv6
8i7TAJwIkLVQ4t/OpRt1gQ4pnuiI9RS8ywCdH8ZcDYSnE+C6XROfqGVkA+/8PrA=
=L0BL
-----END PGP SIGNATURE-----

--7TcBbJ0HlHlY6Z+5--

