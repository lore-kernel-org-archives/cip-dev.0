Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A98CC4332F
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 21:47:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.415.1665697662076943096
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 14:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7419D1C0025; Thu, 13 Oct 2022 23:47:38 +0200 (CEST)
Date: Thu, 13 Oct 2022 23:47:37 +0200
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
Message-ID: <20221013214737.GC14791@duo.ucw.cz>
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
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <1263180941.78238.1665650193479@webmail.strato.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 21:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9759


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 10/12/2022 11:50 AM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com> wrote:
> > I did a quick test with the patches pointed by Florian but unfortunatel=
y ldconfig still fails.
>=20
> I did some experiments on RZ/Five with this issue, and I'm almost positiv=
e that there is something wrong (or doesn't work as documented) with the ic=
ache handling on this SoC.
>=20
> 1. The issue only affects non-PIE executables (there are very few of thos=
e, basically just ldconfig, gcc, cpp and gcov* on the Debian system), and i=
t occurs very early during the execution of the program. According to the d=
atasheet, the cache on the ax45mp-1c core is virtually indexed, so it is un=
likely that a PIE executable will ever hit anything in the cache when newly=
 loaded, but it is much more likely with non-PIE executables.
>

This is very good observation. Thanks!

And indeed it looks like _any_ non-PIE executable fails. See:

root@smarc-rzfive:/my# cat mytest.c=20
#include <stdio.h>

void main(void) { printf("ahoj svete\n"); }=20
root@smarc-rzfive:/my# clang mytest.c -fno-pie -static
mytest.c:3:1: warning: return type of 'main' is not 'int' [-Wmain-return-ty=
pe]
void main(void) { printf("ahoj svete\n"); }=20
^
mytest.c:3:1: note: change return type to 'int'
void main(void) { printf("ahoj svete\n"); }=20
^~~~
int
1 warning generated.
root@smarc-rzfive:/my# ./a.out=20
[  279.010424] a.out[214]: unhandled signal 11 code 0x1 at 0xffffff8c38bd15=
24


(-O3 -g might be useful to add to clang command line).

Then you can

b _dl_discover_osversion
run

(gdb) disassemble /r
Dump of assembler code for function _dl_discover_osversion:
   0x000000000002538a <+0>:     41 71   addi    sp,sp,-496
   0x000000000002538c <+2>:     a8 00   addi    a0,sp,72
   0x000000000002538e <+4>:     86 f7   sd      ra,488(sp)
   0x0000000000025390 <+6>:     a2 f3   sd      s0,480(sp)
   0x0000000000025392 <+8>:     a6 ef   sd      s1,472(sp)
   0x0000000000025394 <+10>:    ca eb   sd      s2,464(sp)
=3D> 0x0000000000025396 <+12>:    ef 60 a1 5c     jal     ra,0x3b960 <uname>
   0x000000000002539a <+16>:    93 05 a1 0c     addi    a1,sp,202
   0x000000000002539e <+20>:    49 e5   bnez    a0,0x25428 <_dl_discover_os=
version+158>
   0x00000000000253a0 <+22>:    81 48   li      a7,0
   0x00000000000253a2 <+24>:    01 45   li      a0,0
   0x00000000000253a4 <+26>:    25 48   li      a6,9
   0x00000000000253a6 <+28>:    13 03 e0 02     li      t1,46

It clearly tries to call uname, which.. it should, according to the
source code. But somehow it ends up in completely different function:

(gdb) stepi

Program received signal SIGILL, Illegal instruction.
0x000000000003b2fe in wcsrtombs ()

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY0iHeQAKCRAw5/Bqldv6
8kXmAJ0ce1L+sjgLvmImAjgB1GOIDe02QQCgqpdKBYIiWYrvTM2jEv4S7LuXDFg=
=zMKc
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

