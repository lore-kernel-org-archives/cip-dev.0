Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91958C433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 09:41:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8564.1654767704178792331
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jun 2022 02:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E0A811C0BC5; Thu,  9 Jun 2022 11:41:39 +0200 (CEST)
Date: Thu, 9 Jun 2022 11:41:39 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20220609094139.GA21103@duo.ucw.cz>
References: 
 <CAODzB9proCGmsbhFuuOhx=pgwqsGsXEjz2Smd+S97_gFL-A5Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9proCGmsbhFuuOhx=pgwqsGsXEjz2Smd+S97_gFL-A5Dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jun 2022 09:41:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8521


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's this week's CVE report.
>=20
> This week reported 12 new CVEs and 5 updated CVEs.

Thanks for CVEs. I think there's another one we need to track --
CVE-2021-4034 -- kernel vs pkexec API confusion leads to easy local
root. I created an initial yml and pushed it to the repository.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYqHAUwAKCRAw5/Bqldv6
8pdfAJ9S8FVvdnUpTMLBcW9hj1wWuS4oigCgigP3n9jXz5kzw0opT27GBzErCcY=
=vm/s
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

