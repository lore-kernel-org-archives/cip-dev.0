Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85159C47DDF
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 09:51:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10615.1706694689837648207
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 01:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AB3051C0079; Wed, 31 Jan 2024 10:51:26 +0100 (CET)
Date: Wed, 31 Jan 2024 10:51:26 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Message-ID: <ZboYHqLJhaD3JnOA@duo.ucw.cz>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zbi9j7QrnxocN+af@duo.ucw.cz>
 <TY2PR01MB3209DAF580A7B848FF2D9F7CB77D2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0KdSf9n7VGWUPs+"
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3209DAF580A7B848FF2D9F7CB77D2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 09:51:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14552


--Z0KdSf9n7VGWUPs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It seems to be testing problem, but it would be nice to get the
> > testing fixed.
>=20
> The job that failed was an arm64 defconfig boot test on hihope-rzg2m, due=
 to missing files in AWS S3.
> It turns out that this was because the actual build failed, but GitLab CI=
 didn't realise.
> I've found the issue and fixed it.

Thank you, -stable-rc testing seems to be fixed now.

Could you take a look at Iwamatsu-san's tests of this series?

# I can apply this series, If we have no other opinion.
# Test:
# https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1157000194

That may be similar problem, but I don't see where the compile fails.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z0KdSf9n7VGWUPs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZboYHgAKCRAw5/Bqldv6
8jVYAJ9Xd0pumYQuTboRY9ZDcic4dFEgTQCfa5HyrRBTJzUw4mqLQuy38vAuKh4=
=+3kl
-----END PGP SIGNATURE-----

--Z0KdSf9n7VGWUPs+--

