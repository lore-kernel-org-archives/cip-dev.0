Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB6C4332F
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 10:35:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5917.1665657306130437110
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 03:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 110361C0025; Thu, 13 Oct 2022 12:35:03 +0200 (CEST)
Date: Thu, 13 Oct 2022 12:35:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Message-ID: <20221013103502.GA17710@duo.ucw.cz>
References: <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <1263180941.78238.1665650193479@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1263180941.78238.1665650193479@webmail.strato.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 10:35:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9751


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(Can I get you to wrap emails at ~72 columns or so?)

> > I did a quick test with the patches pointed by Florian but unfortunatel=
y ldconfig still fails.
>=20
> I did some experiments on RZ/Five with this issue, and I'm almost positiv=
e that there is something wrong (or doesn't work as documented) with the ic=
ache handling on this SoC.

>  1. The issue only affects non-PIE executables (there are very few
> of those, basically just ldconfig, gcc, cpp and gcov* on the Debian
> system), and it occurs very early during the execution of the
> program. According to the datasheet, the cache on the ax45mp-1c core
> is virtually indexed, so it is unlikely that a PIE executable will
> ever hit anything in the cache when newly loaded, but it is much
> more likely with non-PIE executables.

Ah, I was wondering what does gcc and ldconfig have in common...

> 2. Setting a breakpoint before the illegal/segfaulting instruction
>doesn't work, and what is executed is clearly not what we're seeing
>through the dcache (the offending instructions are neither illegal,
>nor are they able to cause segfaults), so instruction fetches must
>see something different.

In my testing, I was able to stepi from the start, and then I was able
to put breakpoint at preceding instruction (which was a jump). It
looked like we jumped into the middle of instruction, which would
explain the fault.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY0fp1gAKCRAw5/Bqldv6
8vpJAJ9AgsA7NaLP/ZHZaxf6QpIYllt47wCguCqG7c7EuddaadIXNwv7JLaZ1w8=
=6QDl
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

