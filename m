Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E6C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 10:16:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.79895.1717409783023251905
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 03:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 188471C0098; Mon,  3 Jun 2024 12:16:19 +0200 (CEST)
Date: Mon, 3 Jun 2024 12:16:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudius Heine <ch@denx.de>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>,
	cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Re: Siemens targets timing out?
Message-ID: <Zl2X8iYxb0r/2rTk@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
 <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
 <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbqm8IqdV21qwFps"
Content-Disposition: inline
In-Reply-To: <7dd2c3fc-7c37-4b1a-a996-3f600278cee5@denx.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 10:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16095


--Zbqm8IqdV21qwFps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > https://lava.ciplatform.org/scheduler/worker/lab-cip-denx
>=20
> I had the bright idea to restart the server and update it beforehand last
> week, I now had to fix the boot issues, but it seems like
> docker-compose/docker now complains:
>=20
> ```
> docker-compose client version 1.22 is too old. Minimum supported API vers=
ion
> is 1.24, please upgrade your client to a newer version
> ```
>=20
> It seems now that there is `docker-compose-plugin` package from the docker
> repos, which does not supply a `docker-compose` binary to the PATH. Inste=
ad
> now it is used via `docker compose`...
>=20
> So either patching all `docker-compose` calls to `docker compose`, adding
> `/usr/libexec/docker/cli-plugins/` to the search path, or creating a syml=
ink
> for it.
>=20
> I will probably try to patch the `docker-compose` calls to `docker
> compose`.

Thank you. Can you ping me when I should re-try the tests?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Zbqm8IqdV21qwFps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZl2X8gAKCRAw5/Bqldv6
8iqdAJsHYhEvKYHE20QlfAinLRnbBJDeFgCcC0btbKIpWLlQf5GTiZ9hngnTwYs=
=9LFa
-----END PGP SIGNATURE-----

--Zbqm8IqdV21qwFps--

