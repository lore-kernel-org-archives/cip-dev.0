Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79007C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 09:12:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14243.1706605971253828876
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 01:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8F3771C006B; Tue, 30 Jan 2024 10:12:47 +0100 (CET)
Date: Tue, 30 Jan 2024 10:12:47 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp, chris.paterson2@renesas.com
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Message-ID: <Zbi9j7QrnxocN+af@duo.ucw.cz>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AnsL7r65YJya+Gd4"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 09:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14489


--AnsL7r65YJya+Gd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series. LGTM.
> I can apply this series, If we have no other opinion.

Patches look okay to me.

Reviewed-by: Pavel Machek <pavel@ucw.cz>

> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/115=
7000194

But the tests are failing, as is 6.1.76-rc1 test @
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y
=2E

It seems to be testing problem, but it would be nice to get the
testing fixed.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AnsL7r65YJya+Gd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbi9jwAKCRAw5/Bqldv6
8qabAKC5B0N1KD9ssb/7vmZ5JJHH6D2ImQCgi+dMM0pIxuLIGI1uUKsDC01/oyA=
=sSeO
-----END PGP SIGNATURE-----

--AnsL7r65YJya+Gd4--

