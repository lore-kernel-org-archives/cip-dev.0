Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF510C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:36:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4729.1702287379125969032
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:36:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E83321C0050; Mon, 11 Dec 2023 10:36:15 +0100 (CET)
Date: Mon, 11 Dec 2023 10:36:15 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: Re: Potential ext4 corruption in 6.1.64-cip10
Message-ID: <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pm8jOxpAl+d4xdHC"
Content-Disposition: inline
In-Reply-To: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14000


--Pm8jOxpAl+d4xdHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> seems also our 6.1 CIP kernel is affected by [1]. Please do not use in
> production if you have an ext4 filesystem!

This seems to affect O_SYNC / O_DIRECT users, so I'm not sure how
common problem that is.

6.1.66 is out, and there's matching 6.1.66-rt. I can release one or
both, but I don't see any confirmation that it is fixed in .66 or how.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Pm8jOxpAl+d4xdHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXbYDwAKCRAw5/Bqldv6
8qwIAJ918DxmeYaII3ICtpW74JRXwAyW6ACePe/LTbHa8p41EArLOJb9qvdTyBc=
=s9qx
-----END PGP SIGNATURE-----

--Pm8jOxpAl+d4xdHC--

