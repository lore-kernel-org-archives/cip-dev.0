Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F01EC4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 20:26:08 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2660.1670703961033860398
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Dec 2022 12:26:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 16B971C09F6; Sat, 10 Dec 2022 21:25:57 +0100 (CET)
Date: Sat, 10 Dec 2022 21:25:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>
Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Message-ID: <Y5TrVMvSR9ytEp4I@duo.ucw.cz>
References: <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <1263180941.78238.1665650193479@webmail.strato.com>
 <20221013214737.GC14791@duo.ucw.cz>
 <OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <b38ebaa1-bb3f-f2d8-b200-0cdd18cf07cd@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bnNrxG1JWIhipg84"
Content-Disposition: inline
In-Reply-To: <b38ebaa1-bb3f-f2d8-b200-0cdd18cf07cd@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 20:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10195


--bnNrxG1JWIhipg84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This is very good observation. Thanks!
> >>
> >> And indeed it looks like _any_ non-PIE executable fails. See:
> >>
> >=20
> > Just a brief about the issue and solution:
> >=20
> > TEXT_START_ADDR is the start of text segment of an application. This is=
 being set to 0x10000 for RISCV platforms.
> >=20
> > So when an application is compiled with the static flag the load would =
start from 0x10000 - xyz (depending on size of the application)
> >=20
> > Entry point 0x101c0
> > There are 5 program headers, starting at offset 64Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   LOAD           0x0000000000000000 0x0000000000010000 0x00000000000100=
00
> >                  0x0000000000059b48 0x0000000000059b48  R E    0x1000
> >   LOAD           0x0000000000059b60 0x000000000006ab60 0x000000000006ab=
60
> >                  0x0000000000001f68 0x0000000000003528  RW     0x1000
> > So for the above application which is compiled statically we can see th=
e entry point is 0x101c0 and load 0x0000000000010000.
> >=20
> > Andes cores have local memories ILM and DLM that are mapped in the
> >>region H'0_0003_0000 - H'0_0004_FFFF on the RZ/Five SoC. When the
> >>virtual address falls in this range the MMU doesnt trigger a page
> >>fault and assume the virtual address as physical address and hence
> >>the application fails to run (panics somewhere).

=2E..

> Good that the issue is understood and likely solved now. Make sure to
> upstream this as quickly as possible. It targets a fundamental tool and
> requires recompilation of many components. And Debian will freeze the
> toolchain in early January - although:
>=20
> "It is unlikely that the release arch of bookworm will include riscv64."
> [1] :(

I'm pretty sure this is not complete fix. Yes, we should change the
toolchain, but the problem is really in the hardware: you can't just
take part of _virtual_ address space and reserve it. Not if you want
to claim board is riscv64 compatible. Someone else (manual mmap, some
kind of JIT, some kind of emulator) might want normal RAM there.

I believe this is quite important and should be solved in hardware (at
least in next generation).

Can ILM/DLM be disabled?

If we can not fix it at hardware level, we'll really need to prevent
attempts to map anything at that virtual memory range. Clear -EPERM
=66rom mmap is better than strange behaviour at runtime, and it is
must-have from security perspective.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bnNrxG1JWIhipg84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5TrVAAKCRAw5/Bqldv6
8gJJAJ9x5Q2jMUjxdI/7fuuZueTJ76kRCQCfYod7EK5FdnmNL9i1EzyiXB9pFS0=
=zGS5
-----END PGP SIGNATURE-----

--bnNrxG1JWIhipg84--

