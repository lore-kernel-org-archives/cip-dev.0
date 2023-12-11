Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7CC4332F
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 20:27:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1925.1702326468738332269
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 12:27:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 49F1C1C0050; Mon, 11 Dec 2023 21:27:46 +0100 (CET)
Date: Mon, 11 Dec 2023 21:27:45 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: WIFI in 6.1.X was Re: Potential ext4 corruption in 6.1.64-cip10
Message-ID: <ZXdwwdiA6lh3VcYR@duo.ucw.cz>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
 <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
 <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
 <ZXbb/i1HuG0yPHXi@duo.ucw.cz>
 <df30a458-00c9-4b64-8963-27c556603981@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/iLUZf528bXnB5q"
Content-Disposition: inline
In-Reply-To: <df30a458-00c9-4b64-8963-27c556603981@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 20:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14038


--p/iLUZf528bXnB5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Ah, that missing dependency of the patch - subtle as it was written.
>=20
> > I'll just do 6.1.66 based -cip and -cip-rt releases, unless someone
> > stops me.

Ok, this is not good week for 6.1.X.

https://www.phoronix.com/news/Linux-6.6.6-Released

There's wifi regression in 6.1.66. I guess that's better than ext4
regression, and 6.1.67 is not nice round number, so I guess we do not
need to do anything just now... but if someone is affected by the
problem let me know.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--p/iLUZf528bXnB5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXdwwQAKCRAw5/Bqldv6
8iKuAKCj6QLDsC9UIUEnMRzD6FsttAxuyACgiBNjwm+vjjC4V7olGf8Y39iksls=
=jsyf
-----END PGP SIGNATURE-----

--p/iLUZf528bXnB5q--

