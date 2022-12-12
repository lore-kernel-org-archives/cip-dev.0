Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E1C00145
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 13:52:10 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.110])
 by mx.groups.io with SMTP id smtpd.web10.43357.1670853123279832597
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Dec 2022 05:52:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=hCVohLH1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.110, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDCBrw8pcuYMu/4Jz8HDbphXaibMtGG5ldrccy1TwFbCfgqAMT4Pqgw1IInQk45uW0LRVNKSVIVEPfz4Yc2P8Up1XQt4HGZ4L8mmGEr0lBtnHUjh7RyaElvPl+WJlyIgIl2fNvRlii1LWpfBSFQOJc1/6ZzflFw7ptoNA3WCPsmNv7CgMusdshLZgPaKjY9aImZaX+JzvHxf2Bj+ekI68qGAiv3XuqVfnHtb0tEEBMFGF6uVGiBOkhlZhlc+vqBeu5Oag5ECF6s/c/j9pw2aSb00ihM4Fns3J8LkY6S5NPaemSHwHDe+W5xjrOPUxSYsQ+j0KfIyuxOby7fUa8/DGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+qvW4sSVwiR3TDZIs5TiFrvU+nPc41kOJS4QGeaosE=;
 b=Nz2S34QV9KRjbG3+8oDB8lfzw2Q6ai4yOy0VexvRAX6V4c0Tv0zc4B5CTK6F5WANl1UuYoeeuCD1kINBLOdcrg555Dfqwfr8OaCnPsDTgcMCDtPai6AZlKjQiVp1UxxoLY1oOTYAtXmgOGlrYt3jW0N+dMyyFT1XWGDuK8XRYuxHTM/kepVJc54SpF5XAH6BzQcLCB8JXmAH8DTVB7exepfit96yvVirKuaBJRxEnAy7VhvABQb0UPQZBRY1fErMR3UL/L6JmYgKjzql4UeAtUh8VbY/x948qYKIQolnKrUGUSurqring7l3Vm6SY1QRFpP6hls0WpBRWKep7G1XUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+qvW4sSVwiR3TDZIs5TiFrvU+nPc41kOJS4QGeaosE=;
 b=hCVohLH1hKMa5lmNJWxhuChdhrkmawY87ijkRJ3dnIplXK1f/PmG+3c28vM7ZMciIOu3qe+wLOk4tAGfJT5apqDIHCC73cWdA9OpuLKZcVezPsLVa3OVSTYG9cbJtIkmIRXiGDgAG+Hrv900cNeGJ54VxaMKMwvW4A4n/GQwLcM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB9786.jpnprd01.prod.outlook.com (2603:1096:604:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:51:59 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:51:59 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
CC: Ulrich Hecht <uli@fpond.eu>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>
Subject: RE: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Topic: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Index: 
 AQHY3aJ1UOfjjk+7D0K/pBqB70He+q4JoSEAgAAJDPCAANotEIABfi2AgADdBYCASauWkIAQii6AgADaogCAAq7xAA==
Date: Mon, 12 Dec 2022 13:51:59 +0000
Message-ID: 
 <OSZPR01MB7019503AC89CC83ABECF3295AAE29@OSZPR01MB7019.jpnprd01.prod.outlook.com>
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
 <Y5TrVMvSR9ytEp4I@duo.ucw.cz>
In-Reply-To: <Y5TrVMvSR9ytEp4I@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB9786:EE_
x-ms-office365-filtering-correlation-id: 87c2ef24-6bc5-40f9-1dbb-08dadc480a31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pAxQziTZxT94vFsqc8XXg0aUahmXt8DedgkNs1gI1wrHLefpPQcorAEDr+JSjulVBd/5gMZc9wHS3tuXpexufd6W0ni6Tjv+PA16l/QzlafdrzfllF8guNDlmcrpHIEWdX76+05ZFLphQLaIgAuBgf+jrOB2FThiH9sO+V1s5ik3+F47NlO+G2w7omJYsi8DwkuPGqr+1yhdvG93KSUZHX7BMDfPaLL58YIpNNBLkmUGg+XC/7fNJl8EaP4R9zuLUp+p86zWLqCM45ip9mYGPcqgO07uiIErk0JtAO5QSeO9GiKeKDWjw1qRHXVRYnEi7CEH+L5uDYZzH3GahAPkvjIvzKsgAKvrYbvtSvY6IKmCp+xK4EAOC6SyMCQ39H0vafoNx5Xgn2onZ5nfr4pmXnSQwIIyhbv3D7oRl71zA8BzbzuAC4GoZfexGSo3xclAPDGPifKQQBzSDnL4oknaw2Y/esCMZS6xfMgreofP+aTVD6BEX2jImS4xd9ZtpU5kzqyDc59p62zSFCbTgcmAyX54VWYQbRXt+EZaDQ5VvGzy/+ByjHPTpSitzz9oBSNOhuXhS8BpWajKhJC+oVEP1ThhDbNob+KWNbPxs9sRVSNMaueSbFeSlSzYke9vYbLWQnbuZoUqxfwHau0IWWq7GNL/Sp/MNWdDyLwe/2U4u9yj82icjSK3YvoPKJWrjso8WPgyVx3akb2d9/sDwUcJjQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(66946007)(66556008)(66446008)(8676002)(76116006)(64756008)(66476007)(71200400001)(52536014)(4326008)(5660300002)(8936002)(478600001)(41300700001)(6506007)(53546011)(107886003)(186003)(7696005)(26005)(9686003)(86362001)(54906003)(110136005)(33656002)(83380400001)(316002)(38100700002)(38070700005)(122000001)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fbWIKTS/kBS1CvbLNscrV8ZYvt+H7XRBKOWmW8QIQ+JTtgeGBeAhf50GIJdV?=
 =?us-ascii?Q?zet62kEykIE9Lmec/71K1R+JjjtalwxJDGta4lqhPB1/Ecg0X0uVHFqAE2Kj?=
 =?us-ascii?Q?eF8zWw4jg/XRHBq6D1KsrqQ8siLSGmjjI03W4zX36VNVdGSRlzNjtddlsLU8?=
 =?us-ascii?Q?phI7RrtSh2DCvXe34rM7Bm0iGARvrPG3v91E9OsBdQgOu8v5x/gBCoTI0Tm1?=
 =?us-ascii?Q?b7U5GFKaE8c54E5anFAoJ3/TZgBfbwzvoKGlhTlPRdUvEyT/Nt/V3j0KztFX?=
 =?us-ascii?Q?QU0RFbI37tEsAvuNST/E7muKPOsyvNV8q+SlwJDU0j2wJ2lzTMTzcgCF4gq7?=
 =?us-ascii?Q?Pw+twwgL/If6zN0Dj40s9XwPlAcvzgQ2N8dUvjG42NSmcO/CKcZp4wRR7Lyz?=
 =?us-ascii?Q?58sSE+ns/pD2X+tByOYN0Nk489dQOdBywbBW9dTmAR9sS6SpacQcR0sWX84I?=
 =?us-ascii?Q?lhXKEvXYzAffpgo0jJqS5Hgq6t+/RCt4X0leYnaFDW/oOvpcdAFHGJQGxlUe?=
 =?us-ascii?Q?30w8lKobqudEwG7wb9ql1YnifauRRFrQP8RZCEsZHEv5xayQ6u6VzDr0ehhU?=
 =?us-ascii?Q?g2DrPb5dFZ8/zLHvcvKoWRYfJ2DetWREfariiMiVhui174f3IN1Cw5aSGEkL?=
 =?us-ascii?Q?kopqXpNRWuXTTA4B4cGWEVI/rmP+o6339k82OVy47YsB5IpPUCgq64M2zlvJ?=
 =?us-ascii?Q?Ki2EbXPpx8bZKSP7aXKzaFpnUIdDA6eoE7bZyFLXGhM+tmj/vgRfqiIZX/zp?=
 =?us-ascii?Q?0WEmVZ4Y+BwIJsF8373W9/xBV2xZGGsSNiN7YVrW8Y+ULSNChq2kkBK86Cuk?=
 =?us-ascii?Q?rvGYxBEKqdwD49QTAiwaOSXqLD/dqdt3TE59klPGCnvzf7mn/o0A5RMiDoej?=
 =?us-ascii?Q?FqYyprXPjZ5PMhC3ebQk3qwWhKXG8wYfYDwXRmAfwWsoGzQdg8NB7R0gTtXc?=
 =?us-ascii?Q?bbRNtYC8BIfNfKgAMHga3eUg/EAv4hucNSvgaH7z3HWeE5JRUZpxtSEnPSWa?=
 =?us-ascii?Q?1bv/oC5Z5dbQQNql82cBDqWX/whRIJ5u4rwbXs7LzGLlgZnOh8/rWTUoibOZ?=
 =?us-ascii?Q?RmO099XWYWF0/uVS7C2IpGllDXzvVSgoXxDr8ekiEAur+bciPOkW9jiNPte3?=
 =?us-ascii?Q?q1mw+L5AmjwtlfdSVxhMcYp2jW70eGv0XsG/9ENCxrpc6xIGJFzBbVYE8GPM?=
 =?us-ascii?Q?aDNbPcmBQfIdP5EFPQclKT3XeQK0kFvULpwPD9oZe/CFNT/JlHIPUtyG50JA?=
 =?us-ascii?Q?BF7YEmYZg6+iow5x50mg8q4tjy6BJLXGEqOtFDhmqZKzKEDMgG9Nv2tPNkDI?=
 =?us-ascii?Q?AWd97LmHQTTj1W/TDun4zPOBWkBknYRFdaRXMB/F2/AesbwGwVgQw0ahCeMd?=
 =?us-ascii?Q?9ATyvLe46xjW3JkSTCmlBVj7Y2pTzZz7REOi4a2ZTVMdjWlaKeZtxNFd2QeF?=
 =?us-ascii?Q?yojuV438klXtg0A1aCWUOvQjd/O5blTEIGOqIGP4FQ3vS2YBip81mV5DnISh?=
 =?us-ascii?Q?sfUkDr0rpuIQ1/ca+27+1DOgUh6or7k5gW0oc1SoZYR6yTC63Rr6c1H16aIP?=
 =?us-ascii?Q?/woFdlcB9PnnmE7yAm2kCSzR5msVYufabkmP9QVs6LHVD+J6+IRPr8W1yWHU?=
 =?us-ascii?Q?X6qBzNufacBSwTuOuRKxPNQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c2ef24-6bc5-40f9-1dbb-08dadc480a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:51:59.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RE7ZrDN41+t3TgiPXlx7WYKCLlrOPGIH2anQOBlGFfBBdG0pP34LjMHPK9ETW2fucWbyMHbyhnJVltIFZVb2oF9aCPWnItHHf5guCj0Mpr5DnXqZp4Y0JK6HSbc8csFU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Dec 2022 13:52:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10210

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 10 December 2022 20:26
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Pave=
l Machek <pavel@denx.de>;
> Ulrich Hecht <uli@fpond.eu>; cip-dev@lists.cip-project.org; Florian Bezde=
ka
> <florian.bezdeka@siemens.com>; Chris Paterson <Chris.Paterson2@renesas.co=
m>; Hung Tran
> <hung.tran.jy@renesas.com>
> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing=
 isar-cip-core for RZ/Five
>=20
> Hi!
>=20
> > >> This is very good observation. Thanks!
> > >>
> > >> And indeed it looks like _any_ non-PIE executable fails. See:
> > >>
> > >
> > > Just a brief about the issue and solution:
> > >
> > > TEXT_START_ADDR is the start of text segment of an application. This =
is being set to 0x10000 for
> RISCV platforms.
> > >
> > > So when an application is compiled with the static flag the load
> > > would start from 0x10000 - xyz (depending on size of the
> > > application)
> > >
> > > Entry point 0x101c0
> > > There are 5 program headers, starting at offset 64Program Headers:
> > >   Type           Offset             VirtAddr           PhysAddr
> > >                  FileSiz            MemSiz              Flags  Align
> > >   LOAD           0x0000000000000000 0x0000000000010000 0x000000000001=
0000
> > >                  0x0000000000059b48 0x0000000000059b48  R E    0x1000
> > >   LOAD           0x0000000000059b60 0x000000000006ab60 0x000000000006=
ab60
> > >                  0x0000000000001f68 0x0000000000003528  RW     0x1000
> > > So for the above application which is compiled statically we can see =
the entry point is 0x101c0
> and load 0x0000000000010000.
> > >
> > > Andes cores have local memories ILM and DLM that are mapped in the
> > >>region H'0_0003_0000 - H'0_0004_FFFF on the RZ/Five SoC. When the
> > >>virtual address falls in this range the MMU doesnt trigger a page
> > >>fault and assume the virtual address as physical address and hence
> > >>the application fails to run (panics somewhere).
>=20
> ...
>=20
> > Good that the issue is understood and likely solved now. Make sure to
> > upstream this as quickly as possible. It targets a fundamental tool
> > and requires recompilation of many components. And Debian will freeze
> > the toolchain in early January - although:
> >
> > "It is unlikely that the release arch of bookworm will include riscv64.=
"
> > [1] :(
>=20
> I'm pretty sure this is not complete fix. Yes, we should change the toolc=
hain, but the problem is
> really in the hardware: you can't just take part of _virtual_ address spa=
ce and reserve it. Not if you
> want to claim board is riscv64 compatible. Someone else (manual mmap, som=
e kind of JIT, some kind of
> emulator) might want normal RAM there.
>=20
> I believe this is quite important and should be solved in hardware (at le=
ast in next generation).
>=20
Agreed.

> Can ILM/DLM be disabled?
>=20
Unfortunately ILM/DLM  cannot be disabled in the current version of HW.

> If we can not fix it at hardware level, we'll really need to prevent atte=
mpts to map anything at that
> virtual memory range. Clear -EPERM from mmap is better than strange behav=
iour at runtime, and it is
> must-have from security perspective.
>=20
Yes we need to come up with a solution for stopping users from mapping with=
ing this virtual memory ranges.

Cheers,
Prabhakar

