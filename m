Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5547C43217
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 08:58:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.38241.1669885123642255239
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Dec 2022 00:58:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D63911C09FC; Thu,  1 Dec 2022 09:58:39 +0100 (CET)
Date: Thu, 1 Dec 2022 09:58:39 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
Message-ID: <Y4hsv1cMA1ZvoY67@duo.ucw.cz>
References: <Y4fSIdKnyVeYN1+D@duo.ucw.cz>
 <TYWPR01MB94201038D0EAE900A607518B92149@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvvD9zFDGAM9dqY6"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94201038D0EAE900A607518B92149@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 08:58:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10149


--RvvD9zFDGAM9dqY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for release work!
>=20
> BTW, rt_x86_siemens_i386-rt.config is the build error.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3405080634#L=
4519
> I'm posting a patch to cip-dev that fixes this. Please check that.
>    [RESEND][PATCH for 4.4.y] extcon: adc-jack: Fix incompatible pointer t=
ype warning

Yes, will take a look, thanks for noticing.

I tried to run tests before release, and they succeeded
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/709907648
:

1) Any idea why my testing differs / how I can properly run the tests
for the -rt branch?

2) Should we have config similar to rt_x86_siemens_i386-rt.config for
4.4-cip, too? The -rt bits will not apply, but we should be able to
test the rest.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RvvD9zFDGAM9dqY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4hsvwAKCRAw5/Bqldv6
8k1wAKCjBTeRbWQefU21opoj+pnnhpm20wCgwsrg7Fyj1EhwbFuN9u2WWjwUpqM=
=L6oD
-----END PGP SIGNATURE-----

--RvvD9zFDGAM9dqY6--

