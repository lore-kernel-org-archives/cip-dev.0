Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C9C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 13:24:50 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.95])
 by mx.groups.io with SMTP id smtpd.web11.42873.1670851480686892729
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Dec 2022 05:24:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=G01vKtrJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.95, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLOxC1ZN3lKzV8zEUYlg4Zd7uA4M+ihOttCTs+Pjbcmqc+kDYHlEAajMLNUyt2P99d+lteu/4sy4YbOIXwHeTCfy2iGT0jW1CHowfN9Dbkf5wrYO01uTnCUAFFnK0q+yyClXoP8+LM+NY2XNNFs1bem6AledT7NDl7luaCI1+VTD/fYFUcGq+Omteqto620M5HwuwrBsv+wWHiDhhhXTHb0dathFbFPwSpz56hjk6xEbwDivA/XhRJZJsrut9BoajWyadLJFoRx5KfcOF+hok0VP92qR9+GwtvBsyTvRPgcJ4Wufk9XBf8iyWbgTRcETGIdEPyH6dtwxTrHR0WsiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qah1impL60KIgmXnRRQh4JR0RMbGmTIjIgzlisxH56k=;
 b=b+9nKRcFJMEUwN7wBhM/qjHxDb+FPYWWnOw+gFkfX7cYnUeZE1QywZsn6qBraJL47f+xpFG6eA9fF33dz/cQdP6Kli9/1ewMrRtqjD9U9XsQq7kwB3EFxDxXqSPUOy2eH7Ao50Jabg98lXGlUST9iM0zem8/d1FkeOK3s/X4mcgstMAkzpquvD5DCipk1U2SCAaJxH/QJX3R92ck46J2Eco1EM0kIpDYp7wnMQpmHDj4CwhO4FKiAi8Jm6tkq6vZxSoW1RfC7qR0+Dxir2mfnUAAYxKtBvfWnofinmWm7GMeQYI2TyhpNWSIt+grBTwP8ko36IdTnrPjXQ3OHNLJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qah1impL60KIgmXnRRQh4JR0RMbGmTIjIgzlisxH56k=;
 b=G01vKtrJ0ZnhYtSSbPqnh2YRviBWcKzQ94F+WnAxmTsbEkdCuS5FIXLU2wmo59DpaHGhK2auIW+oYIr3Vvzp3B/Qn0u43PFoLN/RdPkl3zQiXdzbOgFjX/kW+cz6rZuIqqyCwGSGEsC0B8bVTl2eEo+xqP3+gmt/Y85h/36hbt4=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB5991.jpnprd01.prod.outlook.com (2603:1096:604:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:24:36 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f472:84ae:c3ff:90e6%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:24:36 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>, Ulrich
 Hecht <uli@fpond.eu>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Hung Tran <hung.tran.jy@renesas.com>
Subject: RE: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Topic: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Thread-Index: 
 AQHY3aJ1UOfjjk+7D0K/pBqB70He+q4JoSEAgAAJDPCAANotEIABfi2AgADdBYCASauWkIAQii6AgAOI6MA=
Date: Mon, 12 Dec 2022 13:24:36 +0000
Message-ID: 
 <OSZPR01MB7019A34D84839E6AD2AD2906AAE29@OSZPR01MB7019.jpnprd01.prod.outlook.com>
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
 <OSZPR01MB70191A1A9FD7FAE4EF4F8FF0AA129@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <b38ebaa1-bb3f-f2d8-b200-0cdd18cf07cd@siemens.com>
In-Reply-To: <b38ebaa1-bb3f-f2d8-b200-0cdd18cf07cd@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB5991:EE_
x-ms-office365-filtering-correlation-id: 1011f3c8-14a5-4c38-8fab-08dadc443742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g3t+GptfSCOCXdCjeCFI+eUylGNRxXsHj+pVey0i0WE9BtLo/inJCZBgWillUeWLnbJ+p65ie/s+gmKqMjStrlXz6mhshrY0cx0GmDt1y/FbFeGkSNkPfwPcerDTfyFnCeTChxVjHVpf9oC4Pz3oao8/tKJ8yXVbFecxwM2yHqCgGk1u9eQkI+uNPIBwg0YQ/vwYKHZlN/0Zkj7xVlJqpqdtHsfuT7uks+2X3Rk7hjWHaRfpb5KZD0xEJQ6ucX2allYdjpqjqSIEaTmlXv4EMgokKmNE7MzGVKhNkmFn5DpJzHLt+CsYvpqeDateve68otG4s7/WYE21oRbhDVc4kRa+QhjiqxobRJmc9LA5FED8XhrZatssOu78UnKcOxGjYWApihyLkJYJLNTCFXag8TN0jpjXVDS+3slQintg1ZcKJq+RyVbJvK3nvbOqucEvJ4JFJukpir5+AdaYdQI3x5i/cMkCG2OG042N4xzOmkTYiLj3c+0pYlhml6kBwnZo//MUKNT6r5qlMtzV7pdItQpDDFABcItUrWULCrxc6pHjWx9aaNs2M2ab5nhYMwwv+LNP7VoENp5HJdK1nLm65+t+zOG4IJul17twzW7U7WDdnIYPEE+bzampnpsxhxgZjg3eQRnd6xlRHQ78GguA2xpeUFv/TzRAFncwyrwJWLyf0IGL5M61roCtBKrA5gC2uw+GghMBk5vXRWWJIvZxP2z/UmmC0fukB1NNwdMOK60=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(186003)(52536014)(2906002)(110136005)(54906003)(83380400001)(86362001)(33656002)(66946007)(66556008)(66476007)(66446008)(8936002)(5660300002)(76116006)(64756008)(4326008)(316002)(38070700005)(8676002)(55016003)(122000001)(26005)(71200400001)(107886003)(9686003)(38100700002)(45080400002)(41300700001)(966005)(6506007)(53546011)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aU/FNgbpq7zPoiYYPLfmGgLQFZnQbfsYp/5/24UKO4wk+E23k17A9BVjqHMZ?=
 =?us-ascii?Q?3LfBPGO6gbM04wqTbaFThW3U3ySYreDRY5tamAOBq1vtmkscAsWwxfPaOA47?=
 =?us-ascii?Q?4d/qoR6qt6QrCmva9fGQEJSIbAYOBlyw++bRizkiTqDtTCZwSvUHyTakf9fM?=
 =?us-ascii?Q?OkxnszafPfp2MvKWQFV6K1JpHrv1OWSOkoavR0V0xWD3ja2CS6pXi39qD5IQ?=
 =?us-ascii?Q?9XdNKAc4Zkl9/OhYc8KENZqqSQg4UUsRY9FpPeH3ZITNzZcHw/gOosc3y2uc?=
 =?us-ascii?Q?4HRcsW4MfTvasETpH0cjoSoTDQM5DMZ0M6WoQDriZhYiQYssKeMe0EGbORH8?=
 =?us-ascii?Q?f1iyUhZr/r3nv5ZZulvrCB42U9Zd7nS7csrwJnj3CkZoFIMdd5FuQ+bXUgzW?=
 =?us-ascii?Q?6qIw6kwM5ZguCto5vEB2Btv8YHwp5Ewf/z3BeiUGzbrzsGfCwDS08kkryLho?=
 =?us-ascii?Q?m5Iw5k/B/FFWSndhWEsZoLBSr1ulKTwLxCcuxgwxsEJ68CoezLkwO+e6WBz8?=
 =?us-ascii?Q?kIm+cNpCkox8H4+B+iuqJa2FzY/JCqBRuYM+PkPF+9WpQd66hvBNrfyA0DVr?=
 =?us-ascii?Q?QsHLtKSRaJZTaGgQ47z6MYuEoSnh725htGsfEfCyd5R2pY01OZ5SNjD6goVJ?=
 =?us-ascii?Q?dMpeRSUSM2hTEMDRzGJevibV0f19eeSkRPOu/uguZCCKodLFQfWXhd9xCuFW?=
 =?us-ascii?Q?YS4Zh9yHTsZo4gQh643yphKZcyLlM1XVUq6JICERv89sGX+eytsNlRUCn5LE?=
 =?us-ascii?Q?iDxEBHje1n9LIrYCU3pXTNRy5i9SzO1GK/LVNj8uFsTWdQRCkkrtiFFW3W5L?=
 =?us-ascii?Q?od8q6b2x+ZjikWGo9CzWURfvbSZVZD44ZJ87cH2TUWdWjQ++MxFq+iLnqmGw?=
 =?us-ascii?Q?NARZmq6CqZBwmDXQv7jCwMJAYQnyopOMbS5Oe0pA/M4FIpqEAle355TLxV8b?=
 =?us-ascii?Q?x+ni717GICgPT61c7ZbWKilyipAh3wwWL3tFsqz6psLtIQnU5h+d/3CqoApE?=
 =?us-ascii?Q?gGSE40Pjjyk+4o8QNy82+oOk+Kfjz/zBvGXbDbaCubxscmjWfRFS9eWBAojO?=
 =?us-ascii?Q?M//lbgmEGGm8+2p/8PvAiEnLhoxyLaORVF208846bdZMdHg7TbFjhDKJvaOy?=
 =?us-ascii?Q?jKZ0lWDZu9aVtkoqZBjqndbARvE7j8/efRe8gOQTgY8NuOh2VOowtww47U0y?=
 =?us-ascii?Q?uTB+8bZS5t+EcJhGkKWePhMezl0TtrOhsn4H7wd/lRgvvhEOkIdeK36VRPdV?=
 =?us-ascii?Q?VCDV9qcOJtp63HHbBIjnXBlW/5qBUczQZCgOchtgRSm5eMfMDobU7lT/SmVf?=
 =?us-ascii?Q?OhdGUcoq4hWQxLoIuK3Rbnj1HrWUXXyJQ8HXjAAwPt3r/vVfZfi0BiCi4GZD?=
 =?us-ascii?Q?iUlt3UOsjuwx6VmGBU31hcqwPP00j5MiCjrawU5dVzzi+vj2/FWKg9DBDdRs?=
 =?us-ascii?Q?H3jteWFNBJFt77FOVDcUsh+dxxPo1gW0Ep9kGA5Bab/fSDr1gIf5Bkr4YCQw?=
 =?us-ascii?Q?1PSd5Dxl/Y5Eym+jEJVgRSEC9H+DkdzTktpwD9AvhHZ/uoDZzq8kjyugmVJ/?=
 =?us-ascii?Q?eh+fsA6Iz9vB4S9AgA00uJvRDJY3by64aTPi+yluH4kMMfqo0ITHmbld/GjD?=
 =?us-ascii?Q?WjMCR/HPpJDtKD+aNfx/FhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1011f3c8-14a5-4c38-8fab-08dadc443742
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:24:36.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCs8hQLu0XwdreXnUOBNt67t6FOHA6imP6Fb+83yii0DaE6jt7FWpzsoIHF20R/x2Iov7ofy+h16BguCc9RBt4kPYU5Jx7d0LxYFgO+vEUpbtVrBpC9lwjPi63BHj98X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Dec 2022 13:24:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10209

Hi Jan,

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 10 December 2022 07:23
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Pave=
l Machek <pavel@denx.de>;
> Ulrich Hecht <uli@fpond.eu>
> Cc: cip-dev@lists.cip-project.org; Florian Bezdeka <florian.bezdeka@sieme=
ns.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Hung Tran <hung.tran.jy@renesas.com>
> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing=
 isar-cip-core for RZ/Five
>=20
> On 29.11.22 19:57, Prabhakar Mahadev Lad wrote:
> > Hi All,
> >
> >> -----Original Message-----
> >> From: Pavel Machek <pavel@denx.de>
> >> Sent: 13 October 2022 22:48
> >> To: Ulrich Hecht <uli@fpond.eu>
> >> Cc: cip-dev@lists.cip-project.org; Prabhakar Mahadev Lad
> >> <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> >> Jan Kiszka <jan.kiszka@siemens.com>; Florian Bezdeka
> >> <florian.bezdeka@siemens.com>; Chris Paterson
> >> <Chris.Paterson2@renesas.com>; Hung Tran <hung.tran.jy@renesas.com>;
> >> Pavel Machek <pavel@denx.de>
> >> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
> >> isar-cip-core for RZ/Five
> >>
> >> Hi!
> >>
> >>>> On 10/12/2022 11:50 AM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@=
bp.renesas.com> wrote:
> >>>> I did a quick test with the patches pointed by Florian but unfortuna=
tely ldconfig still fails.
> >>>
> >>> I did some experiments on RZ/Five with this issue, and I'm almost
> >>> positive that there is something
> >> wrong (or doesn't work as documented) with the icache handling on this=
 SoC.
> >>>
> >>> 1. The issue only affects non-PIE executables (there are very few of
> >>> those, basically just ldconfig,
> >> gcc, cpp and gcov* on the Debian system), and it occurs very early
> >> during the execution of the program. According to the datasheet, the
> >> cache on the ax45mp-1c core is virtually indexed, so it is unlikely
> >> that a PIE executable will ever hit anything in the cache when newly l=
oaded, but it is much more
> likely with non-PIE executables.
> >>>
> >>
> >> This is very good observation. Thanks!
> >>
> >> And indeed it looks like _any_ non-PIE executable fails. See:
> >>
> >
> > Just a brief about the issue and solution:
> >
> > TEXT_START_ADDR is the start of text segment of an application. This is=
 being set to 0x10000 for
> RISCV platforms.
> >
> > So when an application is compiled with the static flag the load would
> > start from 0x10000 - xyz (depending on size of the application)
> >
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
e entry point is 0x101c0 and
> load 0x0000000000010000.
> >
> > Andes cores have local memories ILM and DLM that are mapped in the regi=
on H'0_0003_0000 -
> H'0_0004_FFFF on the RZ/Five SoC. When the virtual address falls in this =
range the MMU doesnt trigger
> a page fault and assume the virtual address as physical address and hence=
 the application fails to run
> (panics somewhere).
> >
> > So to avoid this issue we set the TEXT_START_ADDR to 0x50000 so that vi=
rtual address of any
> statically compiled application doesnt fall in the range of H'0_0003_0000=
 - H'0_0004_FFFF.
> >
> > Elf file type is EXEC (Executable file) Entry point 0x504e4 There are
> > 5 program headers, starting at offset 64
> >
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   LOAD           0x0000000000000000 0x0000000000050000 0x00000000000500=
00
> >                  0x0000000000057dc8 0x0000000000057dc8  R E    0x1000
> >   LOAD           0x00000000000585b8 0x00000000000a95b8 0x00000000000a95=
b8
> >                  0x0000000000004ee0 0x00000000000064b0  RW     0x1000
> >   NOTE           0x0000000000000158 0x0000000000050158 0x00000000000501=
58
> >                  0x0000000000000044 0x0000000000000044  R      0x4
> >
> > So now with the fix for statically compiled application we can see its =
offsetted and entry point is
> 0x504e4 and load is at 0x0000000000050000. So with this we are for sure t=
he MMU will always trigger a
> page fault.
> >
> > I have attached a patch for binutils to the email. We plan to upstream =
this patch to binutils soon.
> >
>=20
> Good that the issue is understood and likely solved now. Make sure to ups=
tream this as quickly as
> possible. It targets a fundamental tool and requires recompilation of man=
y components. And Debian will
> freeze the toolchain in early January - although:
>=20
Yes the plan is to get the TEXT_START_ADDR change asap.

Cheers,
Prabhakar

> "It is unlikely that the release arch of bookworm will include riscv64."
> [1] :(
>=20
> Jan
>=20
> [1] https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.debian.org%2Fdebian-
> riscv%2F2022%2F12%2Fmsg00009.html&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7Ce594a8c6f8e140ff526508dada7f723b%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638062538154354137%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DTJZULCOPJrvGQIPC4VQ0q1A%2BRk7kBpdvC=
34IY87JJM4%3D&amp;reserved=3D0
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


