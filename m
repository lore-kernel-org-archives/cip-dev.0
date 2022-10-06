Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28478C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 22:33:01 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.699.1665095575408124938
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 15:32:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D1E381C002C; Fri,  7 Oct 2022 00:32:51 +0200 (CEST)
Date: Fri, 7 Oct 2022 00:32:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: ldconfig segfault on RZ/Five was Re: Preparing isar-cip-core for
 RZ/Five
Message-ID: <20221006223251.GB7670@duo.ucw.cz>
References: 
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20221006220740.GA7670@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 22:33:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9665


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I tried, but installation fails - illegal instruction.
>=20
> Yeah, ldconfig is needed for installation. But I get a segfaulting gcc
> binary.

It crashes rather soon after startup, so I was able to trace complete
path.

> But I do have slightly different results then you (I think; I'm far
> from risc-v expert). I did a breakpoint:
>=20
> Breakpoint 1, 0x00000000000385d4 in ?? ()

I believe it should not end at 0x00000000000385d4 at all. The
0x000000000001537e jal instruction should end up calling 0x3806a
AFAICT, but it calls 0x385d4 instead. It happens during
single-stepping, so it should not be anything subtle.

(gdb) disassemble $pc,+0x20
Dump of assembler code from 0x1537c to 0x1539c:
=3D> 0x000000000001537c:  mv      a0,a4
   0x000000000001537e:  jal     ra,0x3806a
   0x0000000000015382:  auipc   a5,0x8a
   0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
   0x000000000001538a:  ld      a4,0(a5)
   0x000000000001538c:  beqz    a4,0x153f0
   0x000000000001538e:  jal     ra,0x38abe
   0x0000000000015392:  ld      a0,0(s6)
   0x0000000000015396:  auipc   s7,0x85
   0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
End of assembler dump.
(gdb)
(gdb) stepi
0x000000000001537e in ?? ()
(gdb)

Program received signal SIGILL, Illegal instruction.
0x00000000000385d4 in ?? ()
(gdb)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz9XkwAKCRAw5/Bqldv6
8jWpAKCgLXeQyFHdEdLtDvuqAjRteXSG8QCgq02xkRrmXHGJTFJ8kwaTGb+xa8k=
=jDNb
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

