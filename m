Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518D4C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 11:43:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4699.1665056610316062215
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 04:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 34B281C0017; Thu,  6 Oct 2022 13:43:27 +0200 (CEST)
Date: Thu, 6 Oct 2022 13:43:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: Preparing isar-cip-core for RZ/Five
Message-ID: <20221006114326.GA21855@duo.ucw.cz>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 11:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9661


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Can you check if ldconfig and gcc work for you? That were the
> > roadblocks I was hitting. If they do, I'll be interested in details of
> > your setup.
>=20
> Hmm, seems the issue persists:

:-(. Do you get gcc faulting, too?

> root@demo:~# ldconfig                                                    =
                                                                           =
                                                                           =
             =20
> Illegal instruction
>=20
> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x0000000000=
0380c8 in ldconfig[10000+83000]
=2E..
> (gdb) disassemble $pc,+0x10
> Dump of assembler code from 0x380c8 to 0x380d8:
> =3D> 0x00000000000380c8:  auipc   a2,0x66
>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>    0x00000000000380d0:  sd      a0,0(a2)

auipc is something rather simple. a2 =3D pc + 0x66 << something. Not
sure how it could fault. Plus we get "illegal instruction", suggesting
it is not some other fault.

Could some kind of self-modifying code be involved? I guess some kind
of debugging/watchpoint is not probable.

> Do we have any instruction set restrictions that prevents the usage of=20
> distros on this CPU? Under QEMU, we come along here as well and execute=
=20
> this without problems. Some infamous Intel CPU comes to my mind at this=
=20
> point - hope, history does not repeat here....

Which Intel CPU comes to mind? Pentium with its fdiv bug? I'd say
recent ones outdid it :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz6/XgAKCRAw5/Bqldv6
8kmyAKCTobpy6qEMxxLpxQLYth0iSGGQuACgrlOKiKl2/yB6QZ17aE/j2PdxTi8=
=XocN
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

