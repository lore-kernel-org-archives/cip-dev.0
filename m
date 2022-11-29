Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA5C4708C
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 18:57:09 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.139])
 by mx.groups.io with SMTP id smtpd.web10.159168.1669748226846776227
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Nov 2022 10:57:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=va7JVEwS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.139, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5J1YXxjZHBmfZl+tFOHdKwCoLPZhKQ9vwuo1iI1zfu2Gt+TRIyPqKCbvNWJvcJsq7X+vcjvXilvntCHAhyv7Gu89uTKrSH6/0MfLMafpwu5mQmHglkl0hZWQZM/AzlLutyzihim8Jemhgj6hNDgrEgvdPpmvqRCdr4BAE1ADeScHLOG/4Rv07SJ3k6NOVq2RQ6roIhDo3/cWiNEtbhpWkiAotDv0gQeExVTxtNKfuotWz2+8pofvQ+O0BTDFyzi1SjV2IgW7wFf6oS06D34xholA6jBzcajHu1y3aUUyJOrm4XluPBpoDseMSqympH42iBoQ+UzlqWW4MtvlNhsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjsb7GEo/3S8v3QSnjc0aQi6mEhbPiJMRUaUeLMKh50=;
 b=msGFLaCKxBgCe1w86905ebO6Hkln4jseyEgwE5f8tgCxfRHOfKt2suG3Em3lwtTZiIsFYDXX4ffEjySKiIGE+uCsZvJSmFOuxosqDmfK6d8sPPIU2TgOdQxW6tUSQ898LITZ3gqKXXEzgTCrQ7zHF9OGY9jh7P8PoPWaofFTmmQ9Sj/1EPTyF9x/+iEGjSSFZiw9k9kuSQ7LVhWNSPoI81z3Okl5FyFCpL/W9JrqmUjlOzQrbDzK6TBxNs4zRPHKpsMPWp6R6KxeuKD2fyAl8N+9bo3VkUrKYQAJVgjay6G1YzgQvn3fRoaTwiRqfWO65jhWIfTakVAJt2kx2SgfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjsb7GEo/3S8v3QSnjc0aQi6mEhbPiJMRUaUeLMKh50=;
 b=va7JVEwS4YPEI6vMOsm4CFK5f7oitqpmwiFCrdwxSykBMDtji0TmI9qEMyCVX1bxRQ5mkVS2KLa1EHQb7WoiJuEWGospP8ZETMGXNCPkl7oEV9usRLVPg8gpYkXxMNF/mfHIhb5/YPjN7kN991i8bub8iA155wnd05qpGatbcWM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB9430.jpnprd01.prod.outlook.com (2603:1096:604:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 18:57:03 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2b87:97f9:d59f:8839]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2b87:97f9:d59f:8839%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 18:57:03 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Jan
 Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>
Subject: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Topic: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Index: 
 AQHY3aJ1UOfjjk+7D0K/pBqB70He+q4JoSEAgAAJDPCAANotEIABfi2AgADdBYCASauWkA==
Date: Tue, 29 Nov 2022 18:57:02 +0000
Message-ID: 
 <OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129@OSZPR01MB7019.jpnprd01.prod.outlook.com>
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
 <20221013214737.GC14791@duo.ucw.cz>
In-Reply-To: <20221013214737.GC14791@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB9430:EE_
x-ms-office365-filtering-correlation-id: 3b77ab64-789b-45e7-8053-08dad23b80a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zR8MXGGtnkzFJwdwz+qH7/bRj8/AmtJA/8u4m0Kmc9pwq1Hf7QGJ6A2CRjz/wVAPKBu2NBHup/9/FCTea8MHHvHqgUMMv/bZ49eNt2y/wHKLksm29XPouQd/0kkQbbIMhtQ9woY9zzJG0Sa1XhXBwG1ngjMqWAQ1CDhfRHNSfOb+HRhFEGN1xc092vB9epQcsKrrURpRcpjT1gzRyrBZqAtQwVUMhDsZH5Od0PwGU/SJj0Zwz7ANqCYonZA8Vl9BU31J3p5rZyD1QDUv8xPLmG3lutYujVuSG7TyoDi9bB0AtdpbpmP7tZwvdVvRp8/xgiSDXW1QQDCH2M8nt2vDOKnId565RdR1sSRGslTM3ZMGrTHBUo87X4gEQD5Srw+23amYkfYzTfMLemFdop64zTOxQ4oIJEnWocXDbzVyibwAXPbXuiTNuZrvVS2v+D4+qp8vLvQRQWuRLMkuCF97uAeOqex7bA0DfRMyNGscQOPLsDRAWt3X+JvQRN2nwE8lETebAY7So/+ZRt9mF73WkiC9p3i0N5jlVylH8rAhizsqR/0Sg0nnMfmtLpu83JurVNWJQZPwwAX89CqglFyCWRTqAdY+wAdEz/ift1eg6YIhqsPQOCL3HRcjNWJffS6KW/NmdD5vI72GMYGfu56xHbrvkDflqMrT216lQ398EMTKwGszRK5UV/K1td6zxPQBKQeW+tzy8JrFlkKwUM2qVA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(38070700005)(5660300002)(122000001)(99936003)(107886003)(71200400001)(110136005)(38100700002)(54906003)(76116006)(9686003)(26005)(316002)(33656002)(55016003)(186003)(8936002)(6506007)(52536014)(7696005)(66946007)(4326008)(86362001)(8676002)(66446008)(64756008)(41300700001)(66556008)(66476007)(478600001)(2906002)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?usdAU5Ah/A6yGvfD9YBBslcQ4R5p0VU/ufihZNSINdMZwqH230x05O0KdvAk?=
 =?us-ascii?Q?hmvwlXk7DU9amI5VSA0/ky+1eXDTNXIRmG2+iPkqNBku28kOK1m5oyfXPQds?=
 =?us-ascii?Q?XAnzr5k186Vn+M26YvM6zsbaeZv/eyD/AtkZZHrAP73ZnoinyjifTnIud4q2?=
 =?us-ascii?Q?luhJQTtVsIY1bapqPINgFXyG4MLaPSNIE3GDy5F02nDaPtXoTzfg0DQyZ4kf?=
 =?us-ascii?Q?xIzn8hZcNNAYQJ3MMb1zN0UjWpS0uy8uqEQddJR0rZkd+pmBueaqz86hvAGG?=
 =?us-ascii?Q?cbE9+gyk5wt537yinX/KmssS7/oGIhGqSZmzp05r5DjRe2E3nLdmWrEZRoe9?=
 =?us-ascii?Q?QY52VbMrkRPO/biZHoxZ3zkPmPpR2yiFJQX1+z8NUFETk4iP2cVFgLmWg04g?=
 =?us-ascii?Q?2aRqbkJY3i4C6KS7JoBGJNV/Axhh8YDW//9gaWkCCIdlqGQ5ylTCVCPcImhc?=
 =?us-ascii?Q?BX12eXNKymdUf7Vga+bhQIBx18wp6LVgublc9FTCT59NSjdk1yHRo3pi7+Qf?=
 =?us-ascii?Q?+55ep0ZYJtq7pLZJT370sRKtho9dgnUxS5SMjBJqF3Sget771wdWqzGveKYE?=
 =?us-ascii?Q?drBImQ/UXx89bC6592DACwIoLA1HnC3w96Z8ROxH9MdzVT4t5L678UXoBdFo?=
 =?us-ascii?Q?xxJ9mbCjwTpeCIfb7Bpl1LMhcdmZNVl4WfenFyU04LwtMCEMqOP4qnVVN1Ot?=
 =?us-ascii?Q?uDifNJmCVS2qPaFSdbI9KY5ARCqblQod3mciYy8jny5HHo26P6hhBykMNugg?=
 =?us-ascii?Q?7vkHh4xVIi9yXgRZdKwbt0fZYjeagOAIK8Xabo0bre5OJrRqz2bOVOhvppSP?=
 =?us-ascii?Q?gmGuM4ydb7Coxrjs+X1iGdTX9QY4+3f8PRXr/ylP66NtYGSaxT+amcmgIjT3?=
 =?us-ascii?Q?RwrBhOXrWGdVAdTj70Np5NwWYkFgpiefFtTGxeTHHhlquapqi0fQC2OsT3jW?=
 =?us-ascii?Q?Ri6B0O7vKVqsKvF/XwwDKD2HSQDzT4PPQq+YhGU2mgjGSedb3I3Toh+udd53?=
 =?us-ascii?Q?Mi3kfqvCT3rkaSS5vF0zOQDAyl7gGyc+Msnw3HI7rprmZpAuzWolM6oDRzkR?=
 =?us-ascii?Q?o2CYxFSP8WBOm0ZWriLCvjXnnoj90NGMwKbZlcaY3+oHWno/YIwP3e8iae/B?=
 =?us-ascii?Q?MKklLQKKmYmkJg/kpzLtuQHoXD7bd+A2GJBjFIus9j3FV5aJMddHT3VGlBDc?=
 =?us-ascii?Q?0+MtH42lNTEZBGtZdokk9+WFsxZVavZ7TpBU413khY5j/MaOqkkTace7QMHA?=
 =?us-ascii?Q?19cVdy6HGep5heoVgbqBvkULrIrc+Hx5WYnCTWC5qRb0YsBfKpk5koOMStdx?=
 =?us-ascii?Q?9VvA97AEFAQrumbpTed6wIjXhFxhCzvbBb/fgEBmDZAOUS1Fi6BVUz93ugbR?=
 =?us-ascii?Q?mq3OZ/z99p7E3dj6uNLiro+oY/n+I29j1vWcAW+vknRoZFKZ/k3W5pMDGRh7?=
 =?us-ascii?Q?QYcBon8j/Xa948hKQZ1peG0KOJ0qbiCvLo6Gt8nDqzZ6WIlNaIn+T87jrXq4?=
 =?us-ascii?Q?p0x3t2O22/LY7ui34Te4PBeSTc+oVfEBzfEZv/+EFNuvsnXjURoBArPLbnUT?=
 =?us-ascii?Q?QjicMrmcMrnMQX8TgWZHBck72TMtrV8Ouzls2No9kp3bXHSgxhNbZvZyg3eb?=
 =?us-ascii?Q?PY+AqiLjz+feTy7CeV1/u94=3D?=
Content-Type: multipart/mixed;
	boundary="_002_OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129OSZPR01MB7019jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b77ab64-789b-45e7-8053-08dad23b80a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 18:57:02.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKGQUus/I/P08mPc8GdVimBVSwJP3bm/xICI1QYd0IYleTb5kkgQlLlS8ROeNIB5u6uGWNJRUtw0Ace0+60l+2XVND5YjD2sjiDSr8XufCumbVyEzt8L2MlcuiIT4NML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9430
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 18:57:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10141

--_002_OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129OSZPR01MB7019jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 13 October 2022 22:48
> To: Ulrich Hecht <uli@fpond.eu>
> Cc: cip-dev@lists.cip-project.org; Prabhakar Mahadev Lad <prabhakar.mahad=
ev-lad.rj@bp.renesas.com>;
> Jan Kiszka <jan.kiszka@siemens.com>; Florian Bezdeka <florian.bezdeka@sie=
mens.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Hung Tran <hung.tran.jy@renesas.com>; Pave=
l Machek <pavel@denx.de>
> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing isa=
r-cip-core for RZ/Five
>=20
> Hi!
>=20
> > > On 10/12/2022 11:50 AM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@b=
p.renesas.com> wrote:
> > > I did a quick test with the patches pointed by Florian but unfortunat=
ely ldconfig still fails.
> >
> > I did some experiments on RZ/Five with this issue, and I'm almost posit=
ive that there is something
> wrong (or doesn't work as documented) with the icache handling on this So=
C.
> >
> > 1. The issue only affects non-PIE executables (there are very few of th=
ose, basically just ldconfig,
> gcc, cpp and gcov* on the Debian system), and it occurs very early during=
 the execution of the
> program. According to the datasheet, the cache on the ax45mp-1c core is v=
irtually indexed, so it is
> unlikely that a PIE executable will ever hit anything in the cache when n=
ewly loaded, but it is much
> more likely with non-PIE executables.
> >
>=20
> This is very good observation. Thanks!
>=20
> And indeed it looks like _any_ non-PIE executable fails. See:
>=20

Just a brief about the issue and solution:

TEXT_START_ADDR is the start of text segment of an application. This is bei=
ng set to 0x10000 for RISCV platforms.

So when an application is compiled with the static flag the load would star=
t from 0x10000 - xyz (depending on size of the application)

Entry point 0x101c0
There are 5 program headers, starting at offset 64Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000010000 0x0000000000010000
                 0x0000000000059b48 0x0000000000059b48  R E    0x1000
  LOAD           0x0000000000059b60 0x000000000006ab60 0x000000000006ab60
                 0x0000000000001f68 0x0000000000003528  RW     0x1000
So for the above application which is compiled statically we can see the en=
try point is 0x101c0 and load 0x0000000000010000.

Andes cores have local memories ILM and DLM that are mapped in the region H=
'0_0003_0000 - H'0_0004_FFFF on the RZ/Five SoC. When the virtual address f=
alls in this range the MMU doesnt trigger a page fault and assume the virtu=
al address as physical address and hence the application fails to run (pani=
cs somewhere).

So to avoid this issue we set the TEXT_START_ADDR to 0x50000 so that virtua=
l address of any statically compiled application doesnt fall in the range o=
f H'0_0003_0000 - H'0_0004_FFFF.

Elf file type is EXEC (Executable file)
Entry point 0x504e4
There are 5 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000050000 0x0000000000050000
                 0x0000000000057dc8 0x0000000000057dc8  R E    0x1000
  LOAD           0x00000000000585b8 0x00000000000a95b8 0x00000000000a95b8
                 0x0000000000004ee0 0x00000000000064b0  RW     0x1000
  NOTE           0x0000000000000158 0x0000000000050158 0x0000000000050158
                 0x0000000000000044 0x0000000000000044  R      0x4

So now with the fix for statically compiled application we can see its offs=
etted and entry point is 0x504e4 and load is at 0x0000000000050000. So with=
 this we are for sure the MMU will always trigger a page fault.

I have attached a patch for binutils to the email. We plan to upstream this=
 patch to binutils soon.=20

Cheers,
Prabhakar

--_002_OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129OSZPR01MB7019jpnp_
Content-Type: application/octet-stream;
	name="0001-ld-emulparams-elf32lriscv-defs.sh-Adjust-TEXT_START_.patch"
Content-Description: 
 0001-ld-emulparams-elf32lriscv-defs.sh-Adjust-TEXT_START_.patch
Content-Disposition: attachment;
	filename="0001-ld-emulparams-elf32lriscv-defs.sh-Adjust-TEXT_START_.patch";
	size=1307; creation-date="Tue, 29 Nov 2022 18:51:58 GMT";
	modification-date="Tue, 29 Nov 2022 18:57:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MWI5ZDcyN2Q2OTY3MDFiYzBmYTA5YTY2YTkxZmJmZTNhNjM5ZTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+CkRhdGU6IFR1ZSwgMjkgTm92IDIwMjIgMTE6MTQ6MDggKzAwMDAK
U3ViamVjdDogW1BBVENIXSBsZDogZW11bHBhcmFtczogZWxmMzJscmlzY3YtZGVmcy5zaDogQWRq
dXN0IFRFWFRfU1RBUlRfQUREUgogZm9yIFJaL0ZpdmUKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rp
bmc6IDhiaXQKCldpdGggYXBwbGljYXRpb25zIGNvbXBpbGVkIHdpdGggYSBzdGF0aWMgZmxhZyB0
aGUgdmlydHVhbCBhZGRyZXNzIGZvciB0aGUKYXBwbGljYXRpb25zIG1heSBmYWxsIHdpdGhpbiBI
4oCZMF8wMDAzXzAwMDAgLSBI4oCZMF8wMDA0X0ZGRkYgd2hlcmUgdGhlIElMTQphbmQgRExNIGJs
b2NrcyBvZiB0aGUgQVg0NU1QIGV4aXN0LgoKVGhlIE1NVSB3b24ndCB0cmlnZ2VyIHBhZ2UgZmF1
bHRzIHdoZW4gdGhlIHZpcnR1YWwgYWRkcmVzcyBmYWxscyBpbiB0aGUKcmFuZ2Ugb2YgQVg0NU1Q
IGxvY2FsIG1lbW9yeS4gU28gdG8gbWFrZSBzdXJlIHN0YXRpY2FsbHkgY29tcGlsZWQKYXBwbGlj
YXRpb25zIHJ1biBzdWNjZXNzZnVsbHksIGFkanVzdCB0aGUgVEVYVF9TVEFSVF9BRERSIHRvIDB4
NTAwMDAuCgpTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20+Ci0tLQogbGQvZW11bHBhcmFtcy9lbGYzMmxyaXNjdi1kZWZz
LnNoIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbGQvZW11bHBhcmFtcy9lbGYzMmxyaXNjdi1kZWZzLnNoIGIvbGQvZW11
bHBhcmFtcy9lbGYzMmxyaXNjdi1kZWZzLnNoCmluZGV4IDkxMDE1ZDQ0Li5iYmEzNGMxNyAxMDA2
NDQKLS0tIGEvbGQvZW11bHBhcmFtcy9lbGYzMmxyaXNjdi1kZWZzLnNoCisrKyBiL2xkL2VtdWxw
YXJhbXMvZWxmMzJscmlzY3YtZGVmcy5zaApAQCAtMjYsNyArMjYsNyBAQCBjYXNlICIkdGFyZ2V0
IiBpbgogICAgIDs7CiBlc2FjCiAKLVRFWFRfU1RBUlRfQUREUj0weDEwMDAwCitURVhUX1NUQVJU
X0FERFI9MHg1MDAwMAogTUFYUEFHRVNJWkU9IkNPTlNUQU5UIChNQVhQQUdFU0laRSkiCiBDT01N
T05QQUdFU0laRT0iQ09OU1RBTlQgKENPTU1PTlBBR0VTSVpFKSIKIAotLSAKMi4yNS4xCgo=

--_002_OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129OSZPR01MB7019jpnp_--

