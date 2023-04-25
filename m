Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBDC77B71
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 12:48:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.77956.1682426892980016328
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 05:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CFC371C0ABB; Tue, 25 Apr 2023 14:48:09 +0200 (CEST)
Date: Tue, 25 Apr 2023 14:48:09 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: Steps towards 6.1-cip branch
Message-ID: <ZEfMCeBR3jIlEU/8@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OkgJP2fdTSJcmkE8"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 12:48:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11347


--OkgJP2fdTSJcmkE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As discussed on the IRC meeting, we should be preparing 6.1-cip
branch.

AFAICT we do have some 6.1.y configs, but we lack 6.1.y-rt
configs. Members should likely comment if all the configurations we
have are relevant for 6.1 (and should continue to be supported), and
if we need some new configurations for 6.1.

Then we should start 6.1-cip branch. I propose we start it from 6.1.26
when that one is released.

=46rom that point on, we should start reviewing 6.1 patches, and start
requiring patches for older kernels to be submitted for 6.1, too.

We'll need adjustments to the testing, and to the review scripts. I'd
postpone starting of 6.1-cip-rt branch for now, lets get 6.1-cip
going, first.

Comments welcome.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OkgJP2fdTSJcmkE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEfMCQAKCRAw5/Bqldv6
8h+EAJwLZMqHxmrlQRh6TLbg2hSoJ/uBQwCglP5k6PZicL18Z29K8BCdE/cZeMU=
=yXK9
-----END PGP SIGNATURE-----

--OkgJP2fdTSJcmkE8--

