Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15792C46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 22:10:02 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.137])
 by mx.groups.io with SMTP id smtpd.web10.305.1704233397808591347
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 14:09:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=cUG5odVl;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.137, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XemTEqFgV8fvxjwrdKsiGIe/itjttUVL5VoF6VZBcCEe2vLAUX0knBWEmeuC0V9cGQ5DV9MPfHAyksb0GpBryVN7S0N4hvuTvKzqbrICWVowa15GTl7eCClLtp7kySRjVuzN3K6QmsUTZy5eqa3xftS6qXqUXOhch4r1CIMweit3nsseLaIxhjgbgt3/iQKtSKpksfWIKaL1zMCSzb096OQAv8V7tg5GPxS3eleZxQwnMnfQTTFi43NpXSpQ44N9RPsP3t5Heh4GEs6pcG4UIIhUqyHtI37FnR0PklPMqPiYFJaZHgOTozYLlnrM33+w6n6qBDupOavvDGKL+6pzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inh9lFuFgP/tNdMQuf09XzJZGaehCrhz7Cw6hYbIyUg=;
 b=oetKEiim3MaYL0XpQNkJt9DHaTlGNv1qKuUiTyHP5RbeZI31kN3MxWhuq8no8pRb4+nCVtlBw14+b4koQTw9rC0wstn4OqghgKh3MNSndzCkACdlCh0cqe0o6JBy6dQorLQyu9MHp3itkUriKri20eaja2d4oWxzo2a1CqirB1iLMF5E4286SMt463k/yRCjGR+NjoDMXNfslAsT7JAoyyJX2G3FIu3hra5UTKBtXAmSHPlAYeuwOGYGAUpbYAPcWTKAOl9GVot5KI70EW4qk1cbJ4K/xnnM5puh7eUWS8DdoDnKWTR0GEbWZaVv5IYcpfsRtGZaNb4v22TWvlsH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inh9lFuFgP/tNdMQuf09XzJZGaehCrhz7Cw6hYbIyUg=;
 b=cUG5odVlfR8dxwDlrAUCTnr3KO3C0o4/NOlqk5coLquIkTU91aMACe74Acw9OSMNHlgdc9X/z0kybB43qIkkcRhxEGysJX0McGLTUw0GlzUXDbuC9k1a1EzBk5B4rOxDzkkMvaNTxxllzdU1s9hr+Fa5Uw3GDDeDa1nFVIxOy04=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB8042.jpnprd01.prod.outlook.com (2603:1096:604:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 22:09:53 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7159.010; Tue, 2 Jan 2024
 22:09:52 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Pavel Machek <pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: 
 AQHaM5k3+GkHfSn/K02qVWBhyLszJbC77lCAgAFpypCACOacAIAAZhwAgAAoqgCAAFh3EA==
Date: Tue, 2 Jan 2024 22:09:52 +0000
Message-ID: 
 <OSZPR01MB70193C0057170A3D8E629A9FAA61A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
 <OSZPR01MB6816A87ADFCB148C8F45958FB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
 <6f1c5d79-a5a0-4bac-8df7-5c6d08f98644@siemens.com>
In-Reply-To: <6f1c5d79-a5a0-4bac-8df7-5c6d08f98644@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB8042:EE_
x-ms-office365-filtering-correlation-id: 5c37164e-2d2b-4e2f-8bb6-08dc0bdf8b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UxGB4Xzc+1duXguwy5lW3xEtfB04dg/f+8Q6YjI+QftmK3hRUmtyEp7REPucIRSZwbi+uXqNb0ZpU6v8Oh5DFUJ9f1DAwp7BfxQWi9pCtJtM2mexI5RIofOeBc/4vXOV/nzp8i3lAj4hW66zV4vuVdaN2xk3Pe8lhS3AxRM6tTcOxaXPuO7KyB5pVqSxb1027ukuPl6LOZPNbvAuQT4ddadHCjF3D0JFsPcNhNhFQkP9kIpfk1tGbcBqsqTYlkDz1v/Bs8HT5mvOdV4D3HUF8/glAgTHl12WXSyUeOFnLPuDaOoByJEcpiC+bhRmLRmKyYG5sCsDkksRpsniLW5pcZnc3v8lpsk5DvGZMb6ec5AIh7ucDJvRKWwiEX9pXZstY3NW3UTV21yxWg27XDVtpTbQgr+5AujsDBu2v64Rr0nC1vrqJtZSoVuCpLbTPABUZbBEWJDYeExJoKaQgwSDXGAITwHDoTgGcPNVZLOYGeTNFkrDYJKVTQ05ik9TQdKNTMBIrODXINF0PLC20+gG2WckMaf4mwmFPWrpu4ll1q/u15YWicR6/+qzDrC54D3yye85TlMWN7ndJgo75xBzrR358F5505jepFZ2TGcVQnM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(66446008)(76116006)(66556008)(316002)(8936002)(54906003)(8676002)(110136005)(52536014)(66946007)(64756008)(966005)(83380400001)(6506007)(53546011)(45080400002)(478600001)(71200400001)(7696005)(26005)(107886003)(9686003)(66476007)(5660300002)(41300700001)(2906002)(33656002)(38070700009)(122000001)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sgwoOhkCCvzwY8/edNPFRzgIKLtXv32fgzzzAh9DD+6gHDVAXnR+U1fJVQIa?=
 =?us-ascii?Q?txuKRpFGQNdvWH3NkxMkeVlEDWg1CN2PFzXtCMSLkCQxZCTZnzIjsGduyibV?=
 =?us-ascii?Q?tS6VNUDMOW/yfIc9yizKA4kSnOub26bkiL4cRyRUOX/KRYFBacCo9dkaepNN?=
 =?us-ascii?Q?ZjcN0gAg4RxkMwJHnqUmYDp16QXuWngC8oabWFIja6zE59Q1dmpXColYrSMl?=
 =?us-ascii?Q?4DHYHTiyxL2W17IexeXXKMAWAq8/RzaQKDXkLhvH84RmMONFlcTXOpdjOd1J?=
 =?us-ascii?Q?kzF2T8fQeL5QYoAbHECxGkaWa+OWeIcpfjhX8vU7DPWCJ+WFo08w74rYNL+r?=
 =?us-ascii?Q?erflqZAGuJ0S+QDXgtU0VsopKVXSBJbmlXr1awtC/TXALOWrTe6hYQMMLaRX?=
 =?us-ascii?Q?+j4AY9XCtO7cjr8YhSIh43ASn2yXg+ZvTPbRzT2mCdZdVhUx6iyVMPGDCJ9S?=
 =?us-ascii?Q?+s9PbAbqLRD3+maeUqaxqhXLPGHLQRmbgbbu9YNhX/nxB5WG0xBm2Cr7gbfN?=
 =?us-ascii?Q?eb85xPopUQYFJKzqIV+iR4mL/sLqoOGX4PHvLgjjEs95Lq4bTeElRCU7s4rA?=
 =?us-ascii?Q?nX7XNx1pSv43Bmq5xwM9RjQWZv4d8s6GEXUDF1rxvQmJ0r8y6W4ElkPGnYYP?=
 =?us-ascii?Q?MswgiVa0LC2KHlJc3kzJajKsOcy47oK2wisFThvcq4dr8xJJ93fVaqA8DTza?=
 =?us-ascii?Q?CwzQ+/JXC6mcvpdVsneMbulh6FMjNIgO4jFQ5MCVcE93rXDfO77iYWtR/HEP?=
 =?us-ascii?Q?lKtR4K4AJT56dI3MgWazEOiV9CJoBA4nDZT+OYB1H6aw2vibfiq5fQguy++L?=
 =?us-ascii?Q?ynDZ7BE8aFAkGtuCuWTSuH90H99idQtoFUipupIYXZLfkbxkJYmm7Ov1bnM9?=
 =?us-ascii?Q?3p/F4TXBPvKl3pKOoa4nPlo03OOgYC0CH9FNrizaFwP/tQ9KEKHim6qaQUhu?=
 =?us-ascii?Q?3pQIVpem2pOOwjgZRYFDS1MT2hKERheZWpM+O/oI89buBErUw+C+qdXqcEEv?=
 =?us-ascii?Q?3k3nnA6GDFHA/aHgxwjIG8B/sBQvY5gESwedhm393BPMU055EXVvkyotKGgl?=
 =?us-ascii?Q?CzZdeHycWwoTbTW8PUodiqDgx5TIL+yY3FAeisWBB6zrr/F5Z+dJvu/B8qkG?=
 =?us-ascii?Q?dAA7jayvVug2Ip3UynFeIVrPupZ+SYDXOysaoGeeC2WQJkbHTFivPA40S796?=
 =?us-ascii?Q?rVxMLxdVqVMG95Y23qGxerM6CnMP8M9PR1dN82Ky9GkTaScIYjp4W1BfZKL/?=
 =?us-ascii?Q?IoFuVwsDihdyrw4aW0AcatNQse8Aog91iLxmDrqvrT8k8qiRUaNtKW4iEvQ4?=
 =?us-ascii?Q?g1EBgeljOZqoS1aWAP/Y0wC7y0MpBoN+R6MU8EycXtSdN0WTqoqT5Hi6ms/y?=
 =?us-ascii?Q?70onXkO9WNHQnbQkOQxD2GlgRbdkVnSR5TEUPQRYoGnHm/6GU49UT3ZnFJW8?=
 =?us-ascii?Q?lN+QdXPrOhulpEi5ddJXXhvDwndos+u6IF4k+2qc34lYMFfi07ZZ0HTHMXtb?=
 =?us-ascii?Q?lf5VVf84hEAndwxQ98W71FUQV7Umga80YGCLiLOf7dJL7ZrdfcBrgVBNh7EF?=
 =?us-ascii?Q?EI2PZNbWb+8OvPs72iznZqEjdMHGg5ofk6oEYIaBjIM08kKWuYOSCwcd/eeF?=
 =?us-ascii?Q?B5ZFqvyZTjglqpUASbO9TFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c37164e-2d2b-4e2f-8bb6-08dc0bdf8b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 22:09:52.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSp7+5J3ga5NHUI4HVAisECRi6zFOgTl15yxNnXI6ah6q79rAXg+7mYwxwJD9iW7Nna7pzyK91/qJE8GuXjl3006UY11KgVFo+zI8TycPrDZsICGXZICJdr6shOc9w+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8042
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 22:10:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14234

Hi,

> On 02.01.24 15:14, Chris Paterson wrote:
> > Hello Jan,
> >
> >> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> >> On Behalf Of Jan Kiszka via lists.cip-project.org
> >> Sent: Tuesday, January 2, 2024 8:09 AM
> >>
> >> On 27.12.23 17:18, Prabhakar Mahadev Lad wrote:
> >>> Hi,
> >>>
> >>>> Hi!
> >>>>
> >>>>> Sending this series as an RFC mainly beacuse, as the kernel image
> >>>>> is not generic to all RISC-V platforms as the HW is noncoherent.
> >>>>
> >>>> Does the hardware also have the "low memory does not work in
> >> userspace" problem? How is that handled?
> >>>>
> >>> For the local memory issues (ILM/DLM (Instruction/Data local
> >>> memory)) we
> >> will need a similar patch [0] to cip-isar-core. Note the
> >> cip-isar-core image built with this change [0] can be used on other RI=
SC-V platforms.
> >>>
> >>>
> >> https://githu
> >> b.com%2Fprabhakarlad%2Fmeta-
> >> riscv%2Fcommit%2Fda749379155980d1f906d8632432f35a01a9c9a1&data=3D05
> >> %7C02%7Cchris.paterson2%40renesas.com%7Ca5d360a701164419501808dc0
> >> b6a1e2b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6383977975
> >> 99811411%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DdY
> >> DnQGyt5JgcvbN2tCqYh7Ba6Tt8vEKooUjU0qBJ2do%3D&reserved=3D0
> >>>
> >>
> >> Just to emphasize this (again):
> >>
> >> Debian is not Yocto, buildroot or Gentoo, and we are not done by
> >> patching and rebuilding the toolchain. Unless you can also provide a
> >> reasonably short list of packages that require rebuilding after that
> >> patch is applied to binutils, it will not be practically feasible to
> >> address this hardware design issue via something like isar-cip-core.
> >
> > Perhaps we can come up with a small list of packages, at least to get C=
IP core working.
> > If this is the case, would CIP want to compile these packages separatel=
y as part of isar-cip-core
> builds?
> > Or would we (Renesas) need to compile them separately and pull them in =
during a normal isar-cip-core
> build?
> >
>
> Depends on the length of the list and size (build-time) of the packages.
>
> > I seem to remember you saying that RISC-V cross-compilation for Debian =
is broken. Do you know if
> this is still the case?
>
> I worked around the issue for now, waiting for review:
> https://groups.google.com/g/isar-
> users%2Fc%2F0QBjhzcs3ac&data=3D05%7C02%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.com%7C5eea955a6b3e43edc6f108dc0bb17ec1%7C53d82571da19=
47e49cb4625a166a4a2a%7C0%7C0%
> 7C638398104168344805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D3BOCfdyyKWJJtw1KF21pMIaZpuEoZoOSEG4JXKd=
7oLc%3D&reserved=3D0
>
> Once isar accepted it, isar-cip-core will pick it up quickly.
>
> >
> > So perhaps some options for now, in order:
> > 1) Add support for RZ/Five to linux-cip and don't test at all
> > 2) Add support for RZ/Five to linux-cip and rely on Renesas' internal
> > CI to test (similar to other non-official CIP reference platforms from
> > Renesas)
> > 3) Add support for RZ/Five to linux-cip and run limited testing with
> > Renesas' Poky BSP
> > 4a) Add support for RZ/Five to linux-cip, Renesas compiles binutils
> > etc. specifically for RZ/Five, isar-cip-core pulls in the Renesas
> > packages specifically for RZ/Five, or
> > 4b) Add support for RZ/Five to linux-cip, patch isar-cip-core to
> > compile binutils etc. specifically for RZ/Five
> >
> > Options 1-3 would mean RZ/Five would _not_ become an official CIP refer=
ence platform.
> > Option 4 _may_ open up the possibility for RZ/Five to become an officia=
l reference platform.
> >
> > I'd at least like to get 1-2, perhaps 3 working in the short term based=
 on this RFC series, if there
> are no objections from the CIP maintainers.
> >
> >>
> >> It would be better - not only having Debian but also other distros in
> >> mind - to look for a kernel/firmware-based workaround, even if ugly
> >> and potentially slower.
> >
> > It probably would be better, however sadly we haven't been able to come=
 up with such a workaround.
>
> Is there information missing when an access to the invalid virtual addres=
s happens, or is the
> implementation of a complete instruction emulator not realistic?
>
The virtual address here is valid, its just that it doesn't go through the =
cache/MMU therefore the virtual address matches physical address. (This hap=
pens for region 0x30000 - 0x4ffff hence we shifted to the start address to =
0x50000 in binutils as pointed previously)

Can you please elaborate on "implementation of a complete instruction emula=
tor not realistic?"

Cheers,
Prabhakar

