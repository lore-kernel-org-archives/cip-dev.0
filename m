Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C2EC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 11:42:55 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.139])
 by mx.groups.io with SMTP id smtpd.web10.19542.1707219772253415298
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 03:42:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=l5z9VpaS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.139, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt0CeSdqMWnIO8ENOBrHYqcQErZFBrkcFdOzKnYqZENJ8Dzin5g/phs2O6oVqDGzz/9jOOcBSKaBiBsoFgkR2kXveKnnvfoctAtGv34C8T/0ivsuOldGxBNmdUeX4qLrAt/GU+PvejfUH7sDmf+bD6QSLtNgndhAFG/2MzNDDkGFoXH0zbg+JK+5F5RfT1u4KIHGhlPGUBxJzhWcs07XmZdPcGez5nRdgWzyEnXQy1mc+J+fTkgBbeEIqgbAZ9CSHFVjLfLe7x4zoB6UryrHGsWhILbJH6pEH0eWnStHVWktdQZ5aViuoA9TGtoB1MlVOUfrp5yLFkCzJvRTvSYEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe6UclQezmszxULcfJ3eC8ObDdCPZdDT7Jztmmg8qFE=;
 b=W2qtmaU3hB1AxTWGN7TLDGQgTe2ywGIUhLYRITbOJg/9imp6IyDKUiQjRwZJ7WM8b/YJJyxHW6qyvL/mSNzhA4OeOlvVKhsV8h8ABLawEeDr7pRY3rVOaed6V61SPGjyTs1YaM9An2b0juTA2yzPQqdWXD8mzJH8KLdDDZiXr6X7sN5QQ37DBiOLsdU9JsW4sSGGb+HsS/i5dcIaNoaGFix5w/gXbIpquxgiKcqryBB5mx1+2lbvIgVAp7U8cWL5nsuam/P1k0VOER32eQGlXtHFY55RfVcI/taPgDtxgS2taaDGQNzBMkm89e7XDIGrVuNRyCTAt0iN3DDZ647Yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe6UclQezmszxULcfJ3eC8ObDdCPZdDT7Jztmmg8qFE=;
 b=l5z9VpaSrJUBYEoUNKDnaZC6l+UGE5ZTMHbFmNJu3yR++NxZdnU5QHPMppWLPqTVYNk3SYnUy6pM2srCq3Q63wA8mtgCjPeXD5vFQGukvlTHe5uz45ndvUmZXE4P67Gi5Lbx8BhiVjPzpw8Cob9KOr7mrXCYaL3k/G37GBoAOtM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9671.jpnprd01.prod.outlook.com (2603:1096:400:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:42:47 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 11:42:47 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Topic: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify
 dma_init_coherent_memory
Thread-Index: AQHaWDDAtSOiX4zTq0m8Hpx7oVOkBbD9CV+AgAAJuWCAAAaggIAAGNTQ
Date: Tue, 6 Feb 2024 11:42:47 +0000
Message-ID: 
 <OSZPR01MB701995B79117844DFD0AE588AA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB638894EFF5D8E2BA83D45B0992462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019F985CDD1F11C0671EEBBAA462@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <ZcIGJ+Rd3xJAgTLZ@duo.ucw.cz>
In-Reply-To: <ZcIGJ+Rd3xJAgTLZ@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9671:EE_
x-ms-office365-filtering-correlation-id: a2007706-1194-4d36-ea5b-08dc2708bda3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7DfnnmUZgACsFDQzPRt7jGcFBHYds4sJXZyHWffVbmxRCXtgYwbs1MJTtUpJYpk8zpsJHYyVK5BgugZCwlZjBHMM0CsaapKrwgPC6UNFOdmtm106ObQ+hxUXbfbtdedOfd3Rx0SG0NNXIpGu9q9dal6YclaMLjv6Jw2tsu7BhGzuhHrcg/+Ez/drDAqFMht41t28uVt67MspBi1gn/4sLMxM5UvaGztLDKgMaPjpR+7b7jL+jwfC/T1O79J5vPNli52BilBA0dA93q92bbc6njlfOF9H0sWessSTWIHQX77+mPQqnUKHr0C3IAgFKspO7gGFlP03O3PL1QK/JyvRguWBLxzRCPh/DAJs+RU28xcmvHanAv8s0diVz35rSFUnD/PuVFxDDQdkvRZBsz9at9VGTJwHa4cuntseg3c6jKFkMUsOFs+Ly5dJvKOgtdOtaUss9hZ3DNA25WFosWYKWqBlvMrfazk0A7JKuMApIytDi1USYdlJ4h6ZdNR/XJlOcZ/DCMUhU+4vRKB5OxRReDHfUpmxPr7NqNLokSShMZPrEAKX/eiSjDyjsw8/U1Qx4f3BiNZyeZ/Nwt9SFqWcRnvdyjuApcbzrOS6MW+1b3RjN4vwp80hjiqdASExPT69
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(122000001)(38070700009)(76116006)(6916009)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(107886003)(6506007)(4326008)(8936002)(8676002)(52536014)(71200400001)(83380400001)(53546011)(33656002)(9686003)(86362001)(7696005)(478600001)(5660300002)(2906002)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/7xT/AdimdaMv/ZJMZQnaDz5GA3lAdmu3CIzxNQ4RgDoTo3LZrFg2UQtpwjC?=
 =?us-ascii?Q?HyUFuSgGOhXBSs/3VnzMsnzVENmDdYbcq9sJhX9TV8em6TwCajOjErUFKMXv?=
 =?us-ascii?Q?3VsL+ZEdo0LDdYEU4frT7XrNn/iG8fowb4PwLYuU4/Q0Puj9/i3NVfOKmTp6?=
 =?us-ascii?Q?bkTGFj4STIuQXrYskMkUr+QJ6cdbt3UCc1gJrN/GtR1LGRJRc+hhrr8V9DF3?=
 =?us-ascii?Q?QREZ1WoiOXkEoj7u9UYJMQe+N/Qwg4kVLc1Z1jMRKBaPaFHOvl5GqbyN/0+D?=
 =?us-ascii?Q?iamlo3dTxxb/nRPUOs4Go+fcL9z/WN3AfVPHseAeqthDgyPt4zaKJn+HKDRF?=
 =?us-ascii?Q?tE2Pxvz8b5mepVs6P1KlRC09TIOaxHwAkyBvCykwDX9sROUfwM8WN4SBkrMc?=
 =?us-ascii?Q?O/ikDmN7BrpZSn0I+p/t0QKS8flvvUqy57mFfmPUE5qW2vnhOADp4k1b389T?=
 =?us-ascii?Q?Gu3roGlDXR2sAFYfa32BDYmJP/6L/Yu9PgJ/a4/PNuD9FgrQX6k1s7H7L3wz?=
 =?us-ascii?Q?DiEhyD69/gLdqLzEQNF0Xl88qjz1KZaudyuUUWDrU8FDA+bTjMu4KXIRx1Z0?=
 =?us-ascii?Q?MJE/YhaiP14NxyfPenpBC47T2cPTi2FS/98W6MmQ32o5YMuX4+7EmZcMJK0+?=
 =?us-ascii?Q?AeT0vDzk7r+5KT5dl5OUktmxVGkrBBHYOYY3bywjXLYHq/MCwQD/7a1gkwSt?=
 =?us-ascii?Q?UEeYXS5IuOsPQKsoeEaFshaNwu43uGW/Wx9X4ywkhYoIGmn8sf75bkHrRJpe?=
 =?us-ascii?Q?nt0gn2YGbw1NZANX3pKjLuvkQ1Y7itDVZoSO8dcsR2UZFIt9W2dSYYNTe6Ys?=
 =?us-ascii?Q?x9Abk5lTNU9RPLuKLj0gdp6jsixOOLFNV8jSwnkzWFdWs7iM070XHIqagzgm?=
 =?us-ascii?Q?THVkbD3MaDjTrI3V1/9dJ+Vf1SRdWdq3uhh+WXIQO3HQCmwaXHelbGJVB+3C?=
 =?us-ascii?Q?OH9LEKKH4eknH3K0X7lRctwHPVa90/oubQgiL4M7vHfJsl79F+lQCgI1qrLp?=
 =?us-ascii?Q?3Yweh6rwBfIQv5LetCbLyPlg3sSu0RDGRtxqalyS9YbClPaTZnLaVmpBZ1ed?=
 =?us-ascii?Q?6/DKCFcwAhuyMqmae6rDkSrcjbEQn+WlQbrQ4j8Z2x7/Uc5TRGUSbk1jqhmV?=
 =?us-ascii?Q?vKS8w0q7HcSfaITVBbnjXucMPyvFoQhBDBk5tk+sh5VxAWF4vgYfpzEeOZxt?=
 =?us-ascii?Q?TiSJaMFltETB/MDPgbRxnQ49d27h4usMQ9BWRlQK8fVimqKq8u1ichR1Ov83?=
 =?us-ascii?Q?Xc7Ctec+t+0MnH7MbQCYQV8Ij9nC6op3BVzt76O5/WEuwSF5JyblZU7YBGlD?=
 =?us-ascii?Q?h+4aqlxeVktL/nT27jrWvxzVlYE0e+9yCM9nsq2AgM/pFqOmv1sEIhbMohfK?=
 =?us-ascii?Q?pHVZrnDdwSl6W0Z/iVEXpX17YnN4Zb1/qUrkCxuzpyHTsn/gk6crf1Ku8ABB?=
 =?us-ascii?Q?WvJsqOfInrtn7UYv7G6E6Ijm+8wH+5lhWUdjgoy53pI4g7A8AXaTLko5fa68?=
 =?us-ascii?Q?ZlJF3GfdE5BIB/snnuynGuEuKWaaTvmuCBNuPKRStuNOHFdoz6kFXtJUY4ol?=
 =?us-ascii?Q?5U7roy6/DXx6KMn1Kfapljy7wVK5Rg8cka9AnjjEFu7OroCxTDdm0WJNNOYD?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2007706-1194-4d36-ea5b-08dc2708bda3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 11:42:47.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxj0YjutFS9Fm+zdSLapcbm9GTX72JmR2+JDlIuHAU+3z9qz+5v+fD7btmqyiiyWI/CSOtHvqom7pnHP2RDt0tL166jehZUV/7VnpLsAmIUPbsozCWq1o39lARJcMMSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 11:42:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14783

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, February 6, 2024 10:13 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: nobuhiro1.iwamatsu@toshiba.co.jp; cip-dev@lists.cip-project.org; pave=
l@denx.de; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify dma_init_cohe=
rent_memory
>=20
> Hi!
>=20
> > > I can not apply this patch cip/Linux-5.10.y-cip.
> > > Could you check this ?
> > >
> > > $ git am -s patch.series
> > > Applying: arm64: dts: renesas: rzg2ul-smarc: Move selecting
> > > PMOD_SCI0_EN to board DTS
> > > Applying: arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into
> > > board DTS
> > > Applying: arm64: dts: renesas: r9a07g043: Introduce
> > > SOC_PERIPHERAL_IRQ() macro to specify interrupt property
> > > Applying: arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI
> > > channels
> > > Applying: arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC
> > > specific parts
> > > Applying: cacheinfo: clear cache_leaves(cpu) in
> > > free_cache_attributes()
> > > Applying: riscv: Kconfig: Enable cpufreq kconfig menu
> > > Applying: dma-direct: add support for dma_coherent_default_memory
> > > Applying: dma-mapping: allow using the global coherent pool for !ARM
> > > Applying: dma-mapping: simplify dma_init_coherent_memory
> > > error: patch failed: kernel/dma/coherent.c:37
> > > error: kernel/dma/coherent.c: patch does not apply Patch failed at
> > > 0010 dma-mapping: simplify dma_init_coherent_memory
> > > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patc=
h
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort=
".
> > >
> > My patch series was based on v5.10.208-cip43, I'll rebase and send the =
v2 soon after testing.
>=20
> That's a bad coincidence. Hopefully we won't have too many conflicts in t=
hat code in future, as it
> looks a bit tricky.
>=20
Agreed. Ive rebased the patches and kicked off the tests all seems to be OK=
. Ill send a v2.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

