Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683BC54E49
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 12:05:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18617.1708949104941830440
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Feb 2024 04:05:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 898B11C006B; Mon, 26 Feb 2024 13:05:02 +0100 (CET)
Date: Mon, 26 Feb 2024 13:05:02 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"pavel@denx.de" <pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: Re: [ANNOUNCE] Release and and v6.1.78-cip15
Message-ID: <Zdx+bq+O5nbxh/0J@duo.ucw.cz>
References: <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862EE8B1050FA1EC2B312B4B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4UbIwb8gUiwHqWh"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB11862EE8B1050FA1EC2B312B4B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 12:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15097


--F4UbIwb8gUiwHqWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Test results:=20
> - Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build=
/6.1.78-cip15_8e0cf035f/
> - Results comparison with previous release: https://squad.ciplatform.org/=
_/comparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&baseline=3D6.1.75-cip1=
4_f555c0a7f&target=3D6.1.78-cip15_8e0cf035f&comparison_type=3Dtest
> - Summary: No new regressions

Ok, so I'm looking at squad to see if it is feasible to decode the
results.

I assume testing starts automatically at the push?

I see "Test jobs progress 31 / 31 (100%)", but the bar above it is
partly red. What does the red part mean?

It lists incomplete test jobs at
https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6.1.78-cip15_8=
e0cf035f/testjobs/
=2E Is that expected? How should we deal with those?

Could we add big, green "This is okay to release" text somewhere, that
tells me that everything is okay without going through all the
details?

Thansk and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F4UbIwb8gUiwHqWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdx+bgAKCRAw5/Bqldv6
8toZAKCL7IR/R2wO69JM8izFa7Qeio8e5ACeOVf2k+OL/wBqDJD8UHHBmG0vXB8=
=SWn2
-----END PGP SIGNATURE-----

--F4UbIwb8gUiwHqWh--

