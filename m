Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C61AC369D3
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 12:11:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.11])
 by mx.groups.io with SMTP id smtpd.web11.38201.1745323861033037213
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 05:11:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LXtGsHP8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.11, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJtyCHU9GCLydK4U1KZb5pT59HgX9Trvq+U8sNEb92CSUiy7gO3HkrkD4Zdd6iD9lUriiQRuT6Pw7/n83T2C5KLXHO99YFpv15g+97lgfPPZgY4O8bEjiYGLx6Al1nWFu5r5f0UITf7UUnFuID14MpSCmJ2powe5zd9h8OGuc01WZOcPnxlgwGid9xdiZ5c+SkEK+ZflFc4xY+BqHohjiRM5EZcUpjFyvuFU++xQGYDOLYxVhdK+6RzRlbJUd26Fymj3WS/WGFbbsIvFnmUZvaH/82rtHPhLiiqyQbGQ+Wcn754yUFoVLhSqIk6dFeAhE3WqF0zd/pCS7wfV0cywnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4dQWBJX0VSSEXRG3hXEpT2AD25mH7+FqWnjhlEQkdE=;
 b=ly8jXU3h5mdl0evdRCS04xJ7NLR/CvZVQ9cFJeycckZKT8qTSAelYw1PcXIHkphoZY/8/jc4ywDyW6aPihv2HMtDquTs+Khy+C7dNjbLnE+CH6htGVMP+PQAOAOanOZ6tWG0apnUpb9mUDLIY9nvm8zKsFBgLCG0z/6yXCrhFYb+d9OsN+ePJ5+Frn2eamm1hL2zjARoRAQBOzvRIikueun+ObiXRhiReWSGSKxdCdkszGVWDRngfDsjwN95UEg3RBrUW6SySZEpGcraV0YMI0VrQ7GQm2p3RgVIQa2ppE9qQIALx3QOO2ubku1osb6aCQDbtsb5WhBWoxMXwMzRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4dQWBJX0VSSEXRG3hXEpT2AD25mH7+FqWnjhlEQkdE=;
 b=LXtGsHP8leJPB5RzArDhgF3Ry/V+U72pi7nmU3/SCxWWm6sLmGmURlgU1IjWThv+zlGopcy+uJKaGl56Q9ocGYA6EYhWi9Ooh8kxE0m+HHqQTbEF4JojZmtwQnGRbhXEvHzJX/BhDmiEQRofo1Fpu+w+oYz1MF7vzUVA/scPFXI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS7PR01MB11569.jpnprd01.prod.outlook.com (2603:1096:604:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 12:10:52 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8655.027; Tue, 22 Apr 2025
 12:10:50 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix
 clock source
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix
 clock source
Thread-Index: AQHbsut7sTKLCk/5rUKvAwbNCsAwHrOu59EAgACRjL+AAB9qsA==
Date: Tue, 22 Apr 2025 12:10:50 +0000
Message-ID: 
 <OSZPR01MB701900318B258B4975085F1CAABB2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <18389BF521EE6C81.21966@lists.cip-project.org> <aAdsbh8ihhKaaMeg@duo.ucw.cz>
In-Reply-To: <aAdsbh8ihhKaaMeg@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS7PR01MB11569:EE_
x-ms-office365-filtering-correlation-id: eb22c682-e95b-4543-275c-08dd8196b91d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wa5R6eYub4xeBQQjyjMF6pxlcjsfnDXCYB1V8y4UTXxr+ozhIAs/HDfv9c/8?=
 =?us-ascii?Q?76+XTdXgePfRA3A6H5tDne/NpPFsmmyUbR4GmoB6jN9JS+KLoLZ/lTK3jXrC?=
 =?us-ascii?Q?Rwl6CZkW/NBcLJ+npewultRwu1HvG5aF5if/r66V+FNHN2HtjLlovJQC5Mst?=
 =?us-ascii?Q?mDljoXnQW6Xbna5+IGyx/6Wdl1hN4G2b08HaoeDToH+ejJIqNzqzdvDPugDf?=
 =?us-ascii?Q?GEC0Qa+B0GwSB3c2/e1isvkLD24pyMI4GrhOPrTrhB4V3ZFd4dLuRtrf2yB8?=
 =?us-ascii?Q?wLjX0MTunhaU0BBHhAkctDVgyM8MJxGJjlZsuIEkoZrjzSn+51oP1ED2S1wJ?=
 =?us-ascii?Q?Ivm0BUjfbEz7+IKNZxexj4EGFTqHWgXu/xcDk6nwa9GjcUCIbioI+BjFwpQ5?=
 =?us-ascii?Q?X7QE4gFaazccCirIhT3XoNPcpGpVHIGsGddEaTHg0+Uv5L6gBxluATW6t8jD?=
 =?us-ascii?Q?jAc6FvdZVCqmCFCS5alHazotudDN2ADhrG5PfV0KM1swSX2AN6sJpYLYOOAS?=
 =?us-ascii?Q?thrXo2eLwvejKJk4k/S51m4a6LkP0cT3GnPTSmmprbggqa2prf13Dh8m/al0?=
 =?us-ascii?Q?qQwbv+3l9OoHp/Dowau6btayWghEnL/0S42TyY/ZPEXxfMZQB33hh0JiWjCL?=
 =?us-ascii?Q?ff5Kt4WrltZvWPQEOrg+vVppMufW34RRt+ypHSpb6ooSB2gErd+H7zNNaKFa?=
 =?us-ascii?Q?niZvtAEdhYpT1TPdtFCRlVAieYwsYsPGZ6KsIcWx2JkeEW5wTVo2Mw0aMsRr?=
 =?us-ascii?Q?HDO3+Nz6WiYPtvAfOYFPphi6RRiutD+wL9n/G3uVLtxuPViqZpF5X3rkC5sg?=
 =?us-ascii?Q?darZNOS9JG7Y5Z/QvmFUhcBfTVGA9a4g6fLNFSALm0ksiRLV3PAz5UxWQzgn?=
 =?us-ascii?Q?fDxaNhDm3UTzwl3LThmeKHlIPK+PpWFJ+Pc+wFI02oJoWJP6fpH413Tg/CH5?=
 =?us-ascii?Q?w+ydPJMfS+nVotyjjkLGuh8U4UAGhRD0jmqqdcpftkOMIyPXSVg5VFWrQL5m?=
 =?us-ascii?Q?shqjdFhpWLoe9zF3K0xNcsXsPJhwg1XyvasGJrvM8420DnwlGXNjBSPeZyL5?=
 =?us-ascii?Q?gJCbIv91LEbRIQqaOJH8SDQsAGaphd7RhC5Y9kBLCKRBq850P99xE7FjDGEa?=
 =?us-ascii?Q?6pvnlmo1mNw4Dz2hJtBRcvnNvda0OJ2MIbVEuMZovFDLkw7rlpaEa27Z1zFQ?=
 =?us-ascii?Q?p7sNXMVW4Pdzd/Hz8lCU0S7dcC1jdroXDetR+MlU/AbpcTVX6h2lT6I7/Vnx?=
 =?us-ascii?Q?EJPzJV7bNNUnXlGr/zmjgoFUvpqNUFyQSBz8+dZsUU7CstQVX62weEtqY1P7?=
 =?us-ascii?Q?lOJqvnGPxNA95ZkqInMhhQcZsK0fOad6Dd2ky286Jvlgbxuz78Odxlns3srp?=
 =?us-ascii?Q?HXLAUFPWNz5qif+t3FQpxE+xWEf+F9WT1AZyuWgOt7rSBMqA3aHFv9sPfVXE?=
 =?us-ascii?Q?7/2cnHFJlv4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aSDHpwrZbqoMyc1MaY9PwWUsnTUByZLSjUJpwbWFQQ2JQG94My2WVOg3dciu?=
 =?us-ascii?Q?hsyVmG0ubAlnMpyDoD4NaRzhoehpqyFcJ3BodjB3bmADu+lJhZSK9qBTt6I6?=
 =?us-ascii?Q?efFh5sog0diZauaHh5aTDU0w54y9DQfhkyjXGago+q/9IrdO7rQK1es6bqUy?=
 =?us-ascii?Q?WzL/cQ8Vs0YR0HQzmQ9gXTYtbLIoGf1QxYeiGZsuGDp3d3CR8aWk6utUdWpA?=
 =?us-ascii?Q?x/EA4rYrMl+hArnp8g4iRzSi+k0dESpDdylZBEsqC5cZ4xoQzn6PiRDrGwlM?=
 =?us-ascii?Q?8cih55TDe2xfw0zajBtOIWiY/kQWb7Y5erz02U1ydLKeQT8/POCvPmHUGsf3?=
 =?us-ascii?Q?4NT2OUAt6vI6Ps0QSP9I3UxYjacJxtA7Ub6O4+oMPFLQZVsqsmeguAMbj0N0?=
 =?us-ascii?Q?r0Q3BcLFHgl41ftAdvPTTdBjEEkabD3W3TQEZMyze86Y9B83KryKu+o7JLZp?=
 =?us-ascii?Q?uSjK0HgghNSJIHuiXj91awh9cmJ47lGLYuOrQfd2pDTf2ueEfjSAuyM4LGdU?=
 =?us-ascii?Q?YJ6tnwW9FcFAx0wILGVC2w+E7ZlkHOj7BI3g7yVkS/0xY1HJZXbzPqXUlfIS?=
 =?us-ascii?Q?AGie0dihHzHxT4KKwpMl+ESt9VJSWgzydY0AMGWQHlh+/FYnnKVfeOJ2SsbJ?=
 =?us-ascii?Q?Xwg96LN1YY1vDBY2s0/A0zoBmgVm097HHLTxZ4fIu6eJfzhSrRoHchqJNPVK?=
 =?us-ascii?Q?00n+eIhG0u/HPY+jZQI47TfDYMlbU9QNtPxnQpMoX5kheSF46udLjB4zgU+v?=
 =?us-ascii?Q?CC5Zzl0u9YbbznqYuEJ1jLK5Qv7PWSEPBOydtkICzNQsaQUbZVGTNvTz7fNP?=
 =?us-ascii?Q?Z2HMrZ8h9i3IK8eybVOixHKNZN41bb3aP/7vYeBaqTKw0f7hdluABkV7Fre8?=
 =?us-ascii?Q?5sHTy4JgSioYdqmtFYFCAouSFvrpXCJIipbJ7jd35Tax7xScQBlBD4tHLGla?=
 =?us-ascii?Q?YvamzIC+NUM8Mm0Ts/4Vypgr1jYGLs/BAH+a8/fuAPBoIRSOSD0bnHDp46ib?=
 =?us-ascii?Q?+YKwaD0R+r9yMNHZfhJj4Eq1H93W5zKXfXSqAtOiwb+XNQuj2StLt1QV54MP?=
 =?us-ascii?Q?ejcyLUgUmZ+R0vjqLeNp9WVZYzYY+VZd7U09fqqUCl/dgA1bInqQCrcNMSnW?=
 =?us-ascii?Q?m94f7lyvY3rNJdIeFVYryG4XIZGbugDUmla4aT8lUHkBRMj6tC01GCxOANd6?=
 =?us-ascii?Q?ZqNoXUaGdDIq8hSBGSIzSpdqCDhNfhLYgrMEPwzJjvLAHVHkDg4xdy50WHI9?=
 =?us-ascii?Q?2q1N8cvw1DODFuLeUZYapcKe9xUChWpzeoScRJQII3RGKIL/LQjDTQ8mC95m?=
 =?us-ascii?Q?zYr9rwb4iGbC/PLGBZYoXVJmNAqahM0N9daXIij+xTkxpxjlCeGvqyadO1EP?=
 =?us-ascii?Q?cgtDxH78/aDtuyS9fLDTk8vQQjjkBq7SBjS6lE3DdM64K0333+nzWU0WdlS1?=
 =?us-ascii?Q?yng42a4DeCs45hOixncaUwzdJY4zVZ2FUWjRaetoTqwnwoIVQ7J56ZViRDrK?=
 =?us-ascii?Q?Zc0YGEMNQQzLwa7dRAeg+62wOmUCmgzXY1Yx/MpgZifCxN5sdxXBfbOvLFCs?=
 =?us-ascii?Q?W+fArvYVakUIRWC8+cxIZ5Hef6xcPIa87opsLeg77jfKfDpgGHiALTeh0GiB?=
 =?us-ascii?Q?Xyvup+/hfzPUjREcG2tEH40=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb22c682-e95b-4543-275c-08dd8196b91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 12:10:50.6792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pst7zjURt1bjrn+2yHtpZB3l7NUE9KUsdVPMWBULg+vC5cW0hLCSKU7iWsQ0FovsXzoyc8mVUvMDEOP17W/lkNeUlEltE5zSGxd/UAe7m5KrkKhWtSCWmZQGPko8t8Pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11569
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 12:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18552

Hi Pavel,

Thank you for the review.

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix
> clock source
>=20
> Hi!
>=20
> > > > Claudiu Beznea (1):
> > > >   clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable
> > > >
> > > > Lad Prabhakar (1):
> > > >   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
> > > >
> > > > Paul Barker (1):
> > > >   clk: renesas: r9a07g043: Mark mod_clks and resets arrays as
> > > > const
> > > >
> > > >  drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
> > > > drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
> > > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > >
> > > > base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc
> > >
> > > I reviewed this series and 5.10.y, looks good to me.
> > > I can apply this, if there are no other comments.
> > >
> > > Test:
> > >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /pipelines/1778885218
> > >
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1778
> > > 885853
> > >
> > > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> >
> > Looks ok to me, too.
>=20
> > Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> Patches are okay, but we should wait for 6.12 "clk: renesas:
> r9a07g043: Fix HP clock source for RZ/Five" before applying this.
>
For 6.12 we should get this patch via stable tree, where the patch is alrea=
dy merged [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dlinux-6.12.y&id=3D56c29847bc4ca651ebeac0671f1a8519a47506e8

Cheers,
Prabhakar

