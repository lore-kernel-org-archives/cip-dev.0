Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA58C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 22:07:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.484.1665094064823640513
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 15:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 890591C0026; Fri,  7 Oct 2022 00:07:40 +0200 (CEST)
Date: Fri, 7 Oct 2022 00:07:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: ldconfig segfault on RZ/Five was Re: Preparing isar-cip-core for
 RZ/Five
Message-ID: <20221006220740.GA7670@duo.ucw.cz>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 22:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9664


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Hmm, seems the issue persists:
> >=20
> > :-(. Do you get gcc faulting, too?
>=20
> I tried, but installation fails - illegal instruction.

Yeah, ldconfig is needed for installation. But I get a segfaulting gcc
binary.

> >> root@demo:~# ldconfig                                                 =
                      =20
> >>
> >> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x0000000=
0000380c8 in ldconfig[10000+83000]
> > ...
> >> (gdb) disassemble $pc,+0x10
> >> Dump of assembler code from 0x380c8 to 0x380d8:
> >> =3D> 0x00000000000380c8:  auipc   a2,0x66
> >>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
> >>    0x00000000000380d0:  sd      a0,0(a2)
> >=20
> > auipc is something rather simple. a2 =3D pc + 0x66 << something. Not
> > sure how it could fault. Plus we get "illegal instruction", suggesting
> > it is not some other fault.
> >=20
> > Could some kind of self-modifying code be involved? I guess some kind
> > of debugging/watchpoint is not probable.
>=20
> No idea - but why should ldconfig be self-modifying?

No idea.

But I do have slightly different results then you (I think; I'm far
=66rom risc-v expert). I did a breakpoint:

Breakpoint 1, 0x00000000000385d4 in ?? ()
(gdb)

Dump of assembler code from 0x385d4 to 0x385f4:
=3D> 0x00000000000385d4:  lb      zero,81(t1)
   0x00000000000385d8:  andi    a1,a1,25
   0x00000000000385da:  sd      zero,24(sp)
   0x00000000000385dc:  sd      zero,32(sp)

If I do the stepi, it will give the illegal instruction, because,
well, we are in the middle of the auipc instruction:

(gdb) disassemble $pc-0x10,+0x20
Dump of assembler code from 0x385c4 to 0x385e4:
   0x00000000000385c4:  .4byte  0x4881f753
   0x00000000000385c8:  li      a6,0
   0x00000000000385ca:  li      a5,0
   0x00000000000385cc:  addi    a3,a1,920
   0x00000000000385d0:  mv      a2,s8
   0x00000000000385d2:  auipc   a0,0x3f
   0x00000000000385d6:  addi    a0,a0,-1890 # 0x76e70
   0x00000000000385da:  sd      zero,24(sp)
   0x00000000000385dc:  sd      zero,32(sp)
   0x00000000000385de:  sb      t3,20(sp)
   0x00000000000385e2:  sd      s7,40(sp)
End of assembler dump.
(gdb)

Weird. But it explains sigill when executing auipc does not result in
segfault...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz9RrAAKCRAw5/Bqldv6
8ra7AJ9k+FhqY/LSa2+6bnKhRpyjarvXgACgpGcuYRjjmea9aWK3Pf5bf2aqNFI=
=6Qvi
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

