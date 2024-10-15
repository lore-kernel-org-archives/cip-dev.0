Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C830DCFC279
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 08:55:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8755.1728982552819025896
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 01:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E46831C0086; Tue, 15 Oct 2024 10:55:49 +0200 (CEST)
Date: Tue, 15 Oct 2024 10:55:49 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] lab-cip-renesas offline
Message-ID: <Zw4uFWi6kWekKeCd@duo.ucw.cz>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQ5c1XoPTDq8wN82"
Content-Disposition: inline
In-Reply-To: <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 08:55:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17038


--hQ5c1XoPTDq8wN82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > lab-cip-renesas is currently offline (since last night) due to some pow=
er
> > issues.
> > Hopefully it'll be back online later today or tomorrow.
>=20
> All back online now :)

I still see failures like this:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/808606=
7433

Other branches show test:arm_multi_v7_defconfig_de0nanosoc failures,
too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hQ5c1XoPTDq8wN82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZw4uFQAKCRAw5/Bqldv6
8nCwAJ0UyNOSBgWxyrj/2zUPjpxVQEMVhACfT9rSDF7T+vYHz5BmblYer3842cE=
=O1a1
-----END PGP SIGNATURE-----

--hQ5c1XoPTDq8wN82--

