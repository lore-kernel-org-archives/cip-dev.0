Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596EC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 09:18:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.206416.1724059104407621674
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 02:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 842D71C00A9; Mon, 19 Aug 2024 11:18:21 +0200 (CEST)
Date: Mon, 19 Aug 2024 11:18:21 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc3 review (fwd)
Message-ID: <ZsMN3VCrMLTBfdkj@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3gpaHIicigZCYco"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 09:18:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16793


--t3gpaHIicigZCYco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Help needed. If possible, please reply to the original email on the
stable mailing list, so that upstream is in the loop.

Best regards,
								Pavel

----- Forwarded message from Pavel Machek <pavel@denx.de> -----

Date: Mon, 19 Aug 2024 11:16:19 +0200
=46rom: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris.Paterson2@renesa=
s.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kern=
el.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.n=
et,
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pave=
l@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.c=
om,
	broonie@kernel.org
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc3 review

Hi!

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This one fails our testing.

https://lava.ciplatform.org/scheduler/job/1181715

[    0.493440] ThumbEE CPU extension supported.
[    0.493646] Registering SWP/SWPB emulation handler
[    0.515073] clk: Disabling unused clocks
login-action timed out after 119 seconds
end: 2.2.1 login-action (duration 00:01:59) [common]

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/761048=
4202

Failure does not go away with retries.

Now... I believe I seen similar failures before, but those did go away
with retries. I guess I'll need help of our Q/A team here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany



----- End forwarded message -----

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t3gpaHIicigZCYco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZsMN3QAKCRAw5/Bqldv6
8k07AJ4+rDVnJGFtUUUoJRUazELr64x+JwCgl3RrZ+eqBetEW90uk01IBdot85o=
=1kUG
-----END PGP SIGNATURE-----

--t3gpaHIicigZCYco--

