Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276EC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 20:49:03 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.99])
 by mx.groups.io with SMTP id smtpd.web09.12850.1665521341167895054
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 13:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WtycVKu2;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.99,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkyS0jnVGHNqQS1FE6wLY/Pvog+A95ir6wZ1sPEuwABryDmc6T/aio48skbPWrWTmJuP+1/dKlf5tzFhVPmNeSEm1HZn5Kj0NqIdkDq1a6C3sFBMkQcgZoFfOsxbqlzAlSPI8evYUHu+JD5j7ApFj63+JQKJWhyufZNu9hc8OA/wTJTvZztzsEYvt6IvqNc/V5KWDEUyXtmygA/YxivDTbVGc8ot+6ciHFvAra82vWZaN3n/4tqL4L4eURVXokZ6G8Bq0w1Sbc+Dh7m3zaPZUC4sPLHowPb4zgkDfNg698KASrYAl9nJnrYeYhrWdswntQsOegCGbSzKcGtT3MwgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pOa/mp3PYzFCmDpnfV7mQnt/1gFPaW6Oa1sAkhA2t4=;
 b=JDYqTk8AEhBTw7+cxbMLBPv5sjm92S8GR3QI8mrlk5Hzd5SRM93mnH9LBWA/Ir19D3Oegp1aaxNtDDrJBDlLSHRL17VK/8JpnSLZ+HlEP3wyAUxdlF6L+n1TyqyNLv58gBBm8Ob5/EWwxtFtevxDN7+chVGnctHT3+9oBfDX/iMILZnLAJE4V9F+yv7AWMEHDdUuMVIA7z+7IL/sHPiUcCGA/em4I8jFCqxsnnQloirLy6zomXp042OVbBfPr1ctRALFmZNImWFoXbmU8FiCDIsTDtl6kFAcZsvQEcZmP+ax+7rbC9huyn5TBYrKUhnFrq44zdvRhcphrcx0gt1UlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pOa/mp3PYzFCmDpnfV7mQnt/1gFPaW6Oa1sAkhA2t4=;
 b=WtycVKu2Hsy3R7Za+x3yYcl2wsjNoK87MbOdtED+CHaAMXAgFjW/OlvgBhwktyb3GGw4Mu/oiBdIU3C80LAIv8eVH/fvNriNNNfAZwprBrKiQ1DpOyr0hzP4XnXpMa/qVD+qf41LkUr25FGZMcsbPzH5jJaQ/P3YEP2YDozP59U=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB5583.jpnprd01.prod.outlook.com (2603:1096:400:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 20:48:57 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f%7]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:48:57 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Hung Tran <hung.tran.jy@renesas.com>
CC: Pavel Machek <pavel@denx.de>
Subject: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Topic: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Index: AQHY3aJ1UOfjjk+7D0K/pBqB70He+q4JoSEAgAAJDPA=
Date: Tue, 11 Oct 2022 20:48:57 +0000
Message-ID: 
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
 <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
 <20221007101932.GB25429@duo.ucw.cz>
 <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
In-Reply-To: <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB5583:EE_
x-ms-office365-filtering-correlation-id: 8f4106c3-7119-47b6-1ebc-08daabca0456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oG8JS4poUJwl+UfB9OYKASozxI0CDthi9rbwc+jnkASnDA7a3ucUx5IzyDE3w0v0SN7wuQFfGgrOJP4yjLQ+Xrh5qwd+zBExqfZw1RSGC883KPRCRRRWd6JhnBcHYlRK7dM5+7vaCvDIHqay7Adp2CIz/Pc4XT8KytXLm/C3i6MZDzsNg4LSiHdegUaDrHRswYsH53NSPnbNX2CzE3etSVpY5hfWDkirJlej7OWEs6Cyi9rHQCCpDolNJqf/f5q2yuu7LrkBX7I19c8cRiuK6meWQP+FfXBL82CY8VY3bmnZuTLLbAZICYmyn5cL0S6eV0AyHI8jNUZc4dr2yRTYTsuk3VyKBhYMPfil+PHOThpDX4lF+xb68EhnswITHPTZZ81GZdsFJgExUhgP7tcOhcKFD5q+nGusDmoRN4YO2r8pei8jwaDaX7L9gY8v3YWaXmWmTJ/33X0C3WEtSCgoLTTl7fIS9hgzu/VmL4wafgHP0joBifYgSoanOiASTBczy3PfczlWSGFGIhVC7zm57AmI5YDnrT0BPhv+4O3VEBRX7lkv3B6bK25/hbiQZgbwvS4agphyUyi1gwozVE6XXPVeBzvW8jfXaiFvI4X+9G4EpYDnu87/O28rL1INvYhmnhzhFuhA093uL1IanvAI5TFAssdeUvANPHryrFDZOVP0m4cgIAGinSxxLY7Ey+Q+gxUziAwm0cWQkdfIPUh5JYy5P82Erfyr+reKzEO+Ljb9b0O3KOOZlptpuI77wcH3PDu3wCHVIDXbcx5d+Q1lsD5BVjDFf69CWYdrjKJHxIA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(83380400001)(33656002)(86362001)(110136005)(9686003)(38070700005)(38100700002)(64756008)(66946007)(66556008)(66476007)(66446008)(41300700001)(2906002)(122000001)(52536014)(8936002)(4326008)(8676002)(5660300002)(55016003)(76116006)(316002)(71200400001)(186003)(26005)(53546011)(7696005)(6506007)(478600001)(966005)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lBsf/cO+msYBsuunUUPOmObTpS7zYQ9a1tbiKiMRojjnvcw1LsiCRj8AgtxT?=
 =?us-ascii?Q?QNrG/FdSHYSsZIHhLBICDTfZRiObISRQgpbe+HXDS+5nKVCnEFj7UuNK6yR/?=
 =?us-ascii?Q?Xgry7yu5KF04D4cuVhF17KxxitUTv/rpIOJtM382BBFYXNx3CgM11Izw7J8i?=
 =?us-ascii?Q?YrGy6tYL3YE8vlnwJZX33ngkE3l3afOHQXFVSbZclWohkFWfLwNJ+nJivq9J?=
 =?us-ascii?Q?JdFN+U7Q4H1qEm29HiVCeIcbyQLA1WABabMiGv39hiIhqozoOkW4R4oy4omk?=
 =?us-ascii?Q?caQmtfzXB9SjDK8+Xpjqg12ko2KfKaX7UaWkb98xdpCp+0dIXCB0ICt1Zeiw?=
 =?us-ascii?Q?7l0AVckTM7MlU+T49RoGHV9hrF+0x80LHkB+9+KG6ZRcBjod8S/ebCKdkooW?=
 =?us-ascii?Q?2TLq4VJv9DMrnQFBDB3W2oQ+HQK1cnv5l+Z2thCDxK7MknMpjm3+WdS1K3VF?=
 =?us-ascii?Q?ZhfrJUnPLJSmHmWfL7c4AqTnVC9cF7iVnOqKzR5wA02B3Ys65XaupFABQvRl?=
 =?us-ascii?Q?KG8ocqd9wctfyfrF5RLEcacRj793rttjQ3rcie+AmqXOwzybFa/tAzHjSeMK?=
 =?us-ascii?Q?JKWo7nKn3R2GOZdflFAIxm6x5964zxbvEJT7hs6f/Rq+S8fPWRBaJr5lhJrn?=
 =?us-ascii?Q?95v7NYVrULclwkn2ujZ+3xQrE82CwSvVyJHhycVNTe+U49MHbU+Rq1/fJuJA?=
 =?us-ascii?Q?hydq9yoUca3F+NSBSiZkoSyBb9GmXoITK7+JU+3mdUjRTaGMCQzKeqToWyuD?=
 =?us-ascii?Q?Rqedy553y9PwQFHR0w1vIJzoa3V67+l+PbQ0YP2MiH6Vxgzr2lRdiruw6XOO?=
 =?us-ascii?Q?+KIrFqOsezXtl5UQCiUQ0cpvSzK9pOkeRGKVe1dokmnRXLpsnC4O0HOZh1CF?=
 =?us-ascii?Q?3b3GNMapV627vb0/K3P+QszJdHDmvky3GtJPmTfYb7untASM8ITo5UKTaVH+?=
 =?us-ascii?Q?twKbpqIjMA9JQtF8IPd3thd3ULkeJA6RgOoNDG8g4HJtbn0rSkDSfLCjFD62?=
 =?us-ascii?Q?7CBJ1AHZQPBH6a7q60QtBIgQtVLh41L34Ytpw/1Bd7kN1DejF9ZN9rpmVbpj?=
 =?us-ascii?Q?szvk6zdaTLtqQ90lXoDSL2j43qI1sOLFSOw2hH6asjxCrbjZHad9Q6Gfhl8l?=
 =?us-ascii?Q?ccb+gGmBhORgltuYsb/CLf3x5GT5Fn1CNDlR8CthuZkOfg83hSlm6RXY/PFQ?=
 =?us-ascii?Q?9hMkWQLF5dFIqs3/JOgL9ERewdJFRFXVGFteTcSXP/TKUdpSpor2A+OhK3uV?=
 =?us-ascii?Q?AfaN3nF7YmLy82pADGOAKz4lhMb0FKmMdza6FYkcT2NGJ6lLQWU9ZjGo6wZ1?=
 =?us-ascii?Q?kGzTmt8qSV5Rc/Uu25E64L4w2SYhXb6DSlLeXAilMoAJx2rK/rEuMyOUFjm0?=
 =?us-ascii?Q?XYxUzIoj/9maQJNWh6UMxHjTlJOgpYvvb2d1xFEuyEEZowJV9N4eIfmtZ1h3?=
 =?us-ascii?Q?x0zN1RNLd8HxZbnkr9yu/bsaWUb+B5yfodaZkEx0bSZJQ4sxygHDXFmthezV?=
 =?us-ascii?Q?P4m/EjXJ+EDdccPB3Tcn9cpCjdC40Yh8CvzCKbPVfLO3cdwABZFZWcVC1olH?=
 =?us-ascii?Q?WzkCpeOaWu8p11iEHDPoAUopQ00CYYbLzfbd3X7TMAMl7bz/fhgBj7UnHkWR?=
 =?us-ascii?Q?PxKc+QW+KucqKwMCVpAfe8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8f4106c3-7119-47b6-1ebc-08daabca0456
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:48:57.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 49Ps3cu8Qxj6HktfWDGO2++glLljZBDjt9qOpSIE8MtFtCj752VHamZqms8v+p6IPnFx6OVLF2JObspQIRboJs4m/2gpKlvumWJTcDctuwUUnV5oxFCPuDKQ48EsJNua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5583
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 20:49:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9732

Hi Jan,

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 11 October 2022 21:15
> To: Florian Bezdeka <florian.bezdeka@siemens.com>; cip-dev@lists.cip-proj=
ect.org; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-l=
ad.rj@bp.renesas.com>; Hung
> Tran <hung.tran.jy@renesas.com>
> Cc: Pavel Machek <pavel@denx.de>
> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing isa=
r-cip-core for RZ/Five
>=20
> On 11.10.22 20:51, Florian Bezdeka wrote:
> > On 11.10.22 12:34, Biju Das via lists.cip-project.org wrote:
> >>> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re:
> >>> Preparing isar-cip-core for RZ/Five
> >>>
> >>> On 09.10.22 10:42, Biju Das wrote:
> >>>>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re:
> >>> Preparing
> >>>>> isar-cip-core for RZ/Five
> >>>>>
> >>>>> On 08.10.22 10:27, Jan Kiszka wrote:
> >>>>>> On 07.10.22 12:19, Pavel Machek wrote:
> >>>>>>> Hi!
> >>>>>>>
> >>>>>>>>>>> I tried, but installation fails - illegal instruction.
> >>>>>>>>>>
> >>>>>>>>>> Yeah, ldconfig is needed for installation. But I get a
> >>>>> segfaulting
> >>>>>>>>>> gcc binary.
> >>>>>>>>>
> >>>>>>>>> It crashes rather soon after startup, so I was able to trace
> >>>>>>>>> complete path.
> >>>>>>>>>
> >>>>>>>>>> But I do have slightly different results then you (I think;
> >>> I'm
> >>>>>>>>>> far from risc-v expert). I did a breakpoint:
> >>>>>>>>>>
> >>>>>>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
> >>>>>>>>>
> >>>>>>>>> I believe it should not end at 0x00000000000385d4 at all. The
> >>>>>>>>> 0x000000000001537e jal instruction should end up calling
> >>> 0x3806a
> >>>>>>>>> AFAICT, but it calls 0x385d4 instead. It happens during
> >>>>>>>>> single-stepping, so it should not be anything subtle.
> >>>>>>>>>
> >>>>>>>>> (gdb) disassemble $pc,+0x20
> >>>>>>>>> Dump of assembler code from 0x1537c to 0x1539c:
> >>>>>>>>> =3D> 0x000000000001537c:  mv      a0,a4
> >>>>>>>>>    0x000000000001537e:  jal     ra,0x3806a
> >>>>>>>>>    0x0000000000015382:  auipc   a5,0x8a
> >>>>>>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
> >>>>>>>>>    0x000000000001538a:  ld      a4,0(a5)
> >>>>>>>>>    0x000000000001538c:  beqz    a4,0x153f0
> >>>>>>>>>    0x000000000001538e:  jal     ra,0x38abe
> >>>>>>>>>    0x0000000000015392:  ld      a0,0(s6)
> >>>>>>>>>    0x0000000000015396:  auipc   s7,0x85
> >>>>>>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
> >>>>>>>>> End of assembler dump.
> >>>>>>>>> (gdb)
> >>>>>>>>> (gdb) stepi
> >>>>>>>>> 0x000000000001537e in ?? ()
> >>>>>>>>> (gdb)
> >>>>>>>>>
> >>>>>>>>> Program received signal SIGILL, Illegal instruction.
> >>>>>>>>> 0x00000000000385d4 in ?? ()
> >>>>>>>>> (gdb)
> >>>>>>>>
> >>>>>>>> Did you try to compare the call trace to QEMU, where we divert?
> >>>>>>>
> >>>>>>> Yes, that's possible way forward, but it will require some
> >>>>>>> considerable setup on my side.
> >>>>>>>
> >>>>>>> If you have QEMU ready... objdump tells you ldconfig's
> >>> entrypoint,
> >>>>>>> from that point you can just stepi. In less than 200 steps, you
> >>>>>>> should have sigill... and complete steps that lead to it.
> >>>>>>>
> >>>>>>
> >>>>>> I've updated sid-ports (dropped the snapshot pinning), and now
> >>>>>> I'm getting a page fault on the instruction before the one that
> >>>>>> was causing SIGILL before:
> >
> > In case the requested page is a page with PROT_WRITE only (no
> > PROT_READ) it might be related to
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-riscv%2F20220915193702.2201018-1-abrestic%40rivosi
> > nc.com%2F&amp;data=3D05%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.co=
m
> > %7C4efefe2d9ed148944efd08daabc55ab5%7C53d82571da1947e49cb4625a166a4a2a
> > %7C0%7C0%7C638011161361337108%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp
> > ;sdata=3DmsPQCy0siXTQOmhj7gAtCK1zSQChGNg%2B2KcmAhQvH4k%3D&amp;reserved=
=3D0
> >
> > AFAIR all stable branches have that problem currently.
> >
>=20
> Nice idea. I quickly hacked that on top of the rzfive kernel, but it didn=
't change the picture,
> unfortunately.
>=20
Thanks for the quick test.

> That said, being able to test linus/master would be very valuable here.
>=20
I will test this on top of v6.0 and update the results.

Cheers,
Prabhakar

