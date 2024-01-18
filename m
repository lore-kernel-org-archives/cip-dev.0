Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AEC4707B
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 13:26:05 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web11.11284.1705584362654224484
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 05:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=n7y5P9Ci;
 spf=pass (domain: renesas.com, ip: 40.107.113.123, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYV23xRucDnByff5oXlE5SNu324zFA1vQJKebeTMduZqUjc2Kygh19liytA0UULjVMpexYiQblPH4jhq/CVY7WCdTABlTuuXpqAD+ZNTKb0+rAebwSvYaUkQa4gp/uNhbg3ecAvuh4fgavC2JVlriRtHEK18KBSPzv7D6p0fWio0h7DoZX4JdxMzp3NHlSNO9PKm+gT2BmnsiXWDTiqJ+mL38qSt9Dr3IwL3+im9Hej77UkeDpv/nojuklN2B3TW2oMqWBYqJdQXef1MeRn3h0RJPCgJ0XeaLtTsbJxOcbE8D9LWdfTqRMUIildgZEs201OZ0GbjBpN/dZEj3RGNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HtLqgnOJwhpnUIn2tPL5MPTDhfjpOfI6CJNu1ox60s=;
 b=mPaSRjROEZc7ZTtITRd0q4qjA4eCvjmcVCEkJnSd6PP2dIafkSIitz4/3qoLB1s/alWBbw4mgq9FslHHIcg/AmzMA8/eIoBzNC8ktbVBkB0kD1cbYk3LYBRqNZPAnYKegkDYrOZV07l4mGlNdlRcXP60GqTXzt6mb5/XOa2Bw0aAPNr263jl1W62mdKL90YPjdZeMnBazYR3MvN1C/OKU+xyWKdxX/nMq/QJO8nEf6ra8EZ2zfj+LQADRwVSPYU81gCDIcAInFoFN1q095pOHiKxTnzsW/80OPsFOrRD6mmiDiwvgo/mZhQFu3c8dtLaymHZyEEiNmCeldM8Og5yrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HtLqgnOJwhpnUIn2tPL5MPTDhfjpOfI6CJNu1ox60s=;
 b=n7y5P9CiNjypVCnq7azwFShkeYDwpAVHNxLustwkcaZMsAX+pmc299GYb8u3kYtzjIr9OvgMf9BQUXa7RUNFA004w7OIarnJjmwzpJ2AyYu9/rV/2g/6uu6WSckXXvxDSKElDga6WTnEH9ApuH+cYOiEZCtsgimJ6yD/adVTR8M=
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10)
 by TYWPR01MB9742.jpnprd01.prod.outlook.com (2603:1096:400:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 13:25:57 +0000
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899]) by OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899%2]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:25:57 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/30] Add support for Renesas
 RZ/Five RISC-V SoC
Thread-Index: AQHaQl7KzaCr6SZL006IrgPr6YzfgbDR5ZyAgAM4jfCACn+nkA==
Date: Thu, 18 Jan 2024 13:25:57 +0000
Message-ID: 
 <OSZPR01MB6816679E5D1F28D931D8C412B7712@OSZPR01MB6816.jpnprd01.prod.outlook.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZZ2jpzco/6c5h/UP@duo.ucw.cz> <17A967822D2F9532.647@lists.cip-project.org>
In-Reply-To: <17A967822D2F9532.647@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_|TYWPR01MB9742:EE_
x-ms-office365-filtering-correlation-id: efa007ce-e010-46d5-7959-08dc18290181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TY3FZUud3gEmYHKAFOmWfgt28NduJn9dfGhd/N966yIJCClqEiJc4m85K/JEXjA8rUhy7Wyaz1X3TtPKWS6xEs74MQXOMeqRu2OoEPEwkBOrNpD4i6V76OVmY1RVJLpZlfqdD860V8fFOODPyN6SzptEZlwVJA8rOZCGwi5YM5jpPSfiWKo2fCj1x62Zcq2hmWz9+cW4VAdQfi+fhSRQgRV0Io177kJzDPp9g60tYRC7NwYlQvKb+CtwK/QJSfeXJHa1daUrZnJxpLRSropFNiPGl2YwrwXHsWXr9roYaLgWVYOISVEOZOxNA41hJb40WRoQ3qkas3a5neaDOqF6xAfvCHgRtnz56B1Wpk7QtEDCC0tWhAY/SsdmfJ+guvBwd3QpBiTr8Wm1IbNvNBVvGpKOIUvSEB1mVH5uDkSdV4NHmA7D9UN2EGFqJEQIC/7uAUhBKmC2f+vNVYJC3L8LJteHu7kL6/fQvRNPIiHhxtiyhfeHfIpmoxjTR528yiigYqqDWUQEPdPDRB21xQfP2VJb02nP0v88+y2qQgmoQ7e5OQGQXpxh+MMEs7cId4ZxANaBcnVaANvFHr04J+k/nVyxSf67EPt0iP6dWJwiOqA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6816.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(76116006)(66899024)(38070700009)(107886003)(41300700001)(26005)(5660300002)(2906002)(110136005)(33656002)(8676002)(8936002)(4326008)(316002)(64756008)(52536014)(66556008)(66946007)(54906003)(66446008)(66476007)(86362001)(7696005)(6506007)(9686003)(478600001)(45080400002)(966005)(71200400001)(83380400001)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?5AzctLkfMZjynImavrXw4X94shv3PNFZgVPQSVLJiToZRukXGmp2xw0w?=
 =?Windows-1252?Q?o8yBmGRU2pW9hYXaVTKvh/Pbk+KCnAYr7SjuIOQzbEZ6EHdnlVP1X/e6?=
 =?Windows-1252?Q?t+w3Ms7rUTH6bgLRgmIQo7y7vXJWwZ0/Gfzx+n6vnna2SaNMqFXfuRzK?=
 =?Windows-1252?Q?U+5p5bMMjxnvg2f7q8TUo6pJNnxkAdHCb/XmOiqAjVvmG3NTpQbx0lhe?=
 =?Windows-1252?Q?s1gc7pMek1R6xIx1vOX0SHaFZO6QVGdR12HG7vwsdR4cAcA3Do3SkNo6?=
 =?Windows-1252?Q?HYmFW2Rh46zLiQVEUvmKrkkaSqzreZhzbjDQchzwiS9ymnEqLzcmgSja?=
 =?Windows-1252?Q?dEpdF0DlBfqFn3o6X35PYfi45hM9pzN8wd5dv06w4zw+7NQMCcH6gpW3?=
 =?Windows-1252?Q?9IXpE4tJOQpAy4x2g6aUKiWZULTy9t3g3gRAIdnENy2vkwF4Vx3x800I?=
 =?Windows-1252?Q?LJJc8N/qETPcsSeFvDxGRn507dKPd6nA2cixWU19IdzrfjUqkClIE+j6?=
 =?Windows-1252?Q?FiM9idKMUG3pKlWY5CF0iI5x/5Oab08M6ddMyw85NJZp6/xJ8IJv6Jge?=
 =?Windows-1252?Q?jH1qo61qrI3W7pX2TbOhumsEnW6/2bWeKjHU+/dLd1hYYcl+BQYmtx4N?=
 =?Windows-1252?Q?4+SV6T/nzs8rGASnst6SUKQCGYOItkNrIEHLUEu94I3a0drtigdmymZ0?=
 =?Windows-1252?Q?IUiOk8Ovm1Fb53s8Y/MDHpgIUH83pg5M7fBDdkI2vBAUZJodNnYi6ebT?=
 =?Windows-1252?Q?UWIYWL2JI3KymXzVQFyZgSTBajdv8Xvuz/sNRw4SWaCojpQS8STfxtKv?=
 =?Windows-1252?Q?SwoA7aKGOd1VdxbuNQoIb8a7IjjFDjFyYnv6UmsKOIJQepxHzbybO/Hu?=
 =?Windows-1252?Q?c9NRRsUSznCapb7PaqxQ/Jd10RJtVdwLzbvRXU88wuvaxx67LkURYVkV?=
 =?Windows-1252?Q?2cXXAnKZ5i7xhjY6Z0EPUFG7SEj2svIc4Y+dUgf/xi9yTTWtXeSlIEUW?=
 =?Windows-1252?Q?j2yHzsTmsMZwgEQYldk5Xpmc8ndMiGI4F1zHB3YMUufXoDIx9WME3fDY?=
 =?Windows-1252?Q?I8st4fuRKmpsujJo0tBrikdecfbXRBcwk5WGpqVmpm1EUtw82td7wbL/?=
 =?Windows-1252?Q?jS2O3hdmGV4ibIDizK+7I16iChV+rw6cCJNCATeJ9xvIr61j0fPHmweF?=
 =?Windows-1252?Q?CJhA9xWVJTJ8/SRhVa56IxUHeaenuH4pz6yeQhM9ho+TnxHi6HHVuehN?=
 =?Windows-1252?Q?p4M3PPwBg4q7hl6uhJAu+bDhKQ9jd++VWJYy0QTbnBRenOFunjcrZBDP?=
 =?Windows-1252?Q?r0ZiT0VRIXaPpLLzU9Dh8QfJvqTayHC6UcFNISYhvdYLofnvrSXKr/YE?=
 =?Windows-1252?Q?l39ndZVjywUZkF8ZSVPDwb+tln++O7NJMJ7DOP5SIdG86ASeMo6bjEUv?=
 =?Windows-1252?Q?t8pO6PZsd6ZGRsKx6wdodxjuIB7+8ZiWvSOdsloN27ETDAIvfFAgvpH6?=
 =?Windows-1252?Q?yA27jabJgr6FsQ/yy7vKWNHOApgXVpL0ia/gvuVbd3+3C38AQz6LoGBs?=
 =?Windows-1252?Q?1zviRulq2EigA2rtaS0LRInnOFIxPkQVslp0Nvg+otsLtfA71JD10oZM?=
 =?Windows-1252?Q?ESYnIFSXHw9FIHBF7uhze0gs8eC3srR2rcuuEXGSAnYj6hzWFW3haO5S?=
 =?Windows-1252?Q?ARG6OgxoVeN626YyCrfKnLOWzEHYOSqLvYZIrMARWH0Yntp1wv0ZEQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6816.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa007ce-e010-46d5-7959-08dc18290181
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 13:25:57.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cc6ldA/xEuJRLTzsQGiwH7OmmlXY+DzCqAwoNwEjeY46+LGZGAgum1nNC7sw6xrrxa1ZZ0FO4zzQLaOWMLxpDcpjb52bCzSvhMvwYrrCb78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9742
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 13:26:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14400

Hello Pavel, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: Thursday, January 11, 2024 9:16 PM
>=20
> Hello Pavel,
>=20
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: Tuesday, January 9, 2024 7:51 PM
> >
> > Hi!
> > >
> > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> > Single)
> > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces
> > such
> > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications suc=
h as
> > > entry-class social infrastructure gateway control and industrial gate=
way
> > > control.
> >
> > I don't dare to apply it without testing. So... can we get qemu-riscv
> > and this board tested for 6.1 (and probably 6.8)?
>=20
> Currently we're building using CIP's risc-v qemu config.
> We'll get test support sorted soon once we have a suitable rootfs.
>=20
> I've done the initial work to build for RZ/Five, see pipeline [0], job [1=
].
> This is using a Renesas specific defconfig [2] that I've created a MR [3]=
 for.
>=20
> [0]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fpipelines%2F1135494600&data=3D05%7C02%7Cchris.paterson2%40ren
> esas.com%7C02bb7316971e4deb9f8f08dc12ea7a30%7C53d82571da1947
> e49cb4625a166a4a2a%7C0%7C0%7C638406045475126479%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DJ%2B4VRFeq8aHpn
> Vk%2FEjuoxohV3i0iCJfM3g%2FeAfBAyb0%3D&reserved=3D0
> [1]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fjobs%2F5914246689&data=3D05%7C02%7Cchris.paterson2%40renesas
> .com%7C02bb7316971e4deb9f8f08dc12ea7a30%7C53d82571da1947e49c
> b4625a166a4a2a%7C0%7C0%7C638406045475282677%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D054E9QFWV2Pumxcnma
> wxs1yC9vIAsy4qPnhOVRlQtMY%3D&reserved=3D0
> [2]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.com%2Fpatersonc%2Fcip-kernel-config%2F-
> %2Fblob%2Fpatersonc%2Fadd-rzfive-config%2F6.1.y-
> cip%2Friscv%2Frenesas_rzfive_defconfig&data=3D05%7C02%7Cchris.paters
> on2%40renesas.com%7C02bb7316971e4deb9f8f08dc12ea7a30%7C53d82
> 571da1947e49cb4625a166a4a2a%7C0%7C0%7C638406045475282677%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D9zClQ4l
> VfTydYp5b%2BPzYz7bRIil1F56k89R1oig2UUY%3D&reserved=3D0
> [3]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.com%2Fcip-project%2Fcip-kernel%2Fcip-kernel-config%2F-
> %2Fmerge_requests%2F87&data=3D05%7C02%7Cchris.paterson2%40renes
> as.com%7C02bb7316971e4deb9f8f08dc12ea7a30%7C53d82571da1947e4
> 9cb4625a166a4a2a%7C0%7C0%7C638406045475282677%7CUnknown%
> 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dba0YxWoRnm%2BkEa
> aLbBivPaou8gJkK1k8gEzz0uiDydU%3D&reserved=3D0
>=20
> I've also done the preparation for boot testing RZ/Five, however before w=
e
> can use it I need to put an RZ/Five board
> into the CIP LAVA infrastructure. I've got a board on order for this, so
> hopefully we can get this sorted next week.
> I'll keep you updated.

I've now added an RZ/Five platform to lab-cip-renesas so we can test.
Tested with a simple boot test based on CIP 6.1 + this patch series:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1142975670

Please let me know if there is anything else you need.

I'll integrate test support into our "official" pipeline once the kernel co=
nfig MR is merged.
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1142975670

Kind regards, Chris


