Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B1FC433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 11:29:54 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.109])
 by mx.groups.io with SMTP id smtpd.web11.5148.1639740591637268667
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 03:29:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=N+zVX9B3;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.109,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq2mP//Tz6VLMbbwXq3epg40LLrLXfnBWLMcJ7QGwQ/fM2XGUUFPxgy9E25qPmzM89dse5xpfVIJPi2YTRIb2h70h5W3Evk3f/iyJzs3duXu1wHe+6/Vp00fs4GrAnQnWhSvyWqbg7u7UBDmVr0ZZLh0MZWdDKXfzLGjlLleBVKKkImgBrGPBqu6mCEUT+hVwMRn5qvZN6FlUFek7Q3VvyZhrCsuZpgpJTFneqpqw3/YUV6nfD1uPJTmYYfixr/MOtkDI36NqX7eYf5ZtHgwHXeFO/+vz7hqEJWsiQTKOuOCGoFado3lNCEX31n3Pk3yF3X9jIGFwXNeGJTXuusqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqyGTGhcpM3Jsk47Oog0ePS9Xa8hrG9DR82yvadD3kY=;
 b=X/tO2FlXEP8sjY2mAUeCA0BB+czLJGfjKFGqmFzNY5QEnSVDBnFUf86vUp9s7rJjIyraYLUdwFQLZupZT0aLXhI0Ysu6FdolG8r2BusyjQV18Sa4jKGXdUfcpKORxu8ci8eqMF4wHchYIlu8T/N6xWHjtI3Inyllsy8wJ2/h5q0Iaw3INNCuXcC1Hdxt7hivvdRao/EBRUJRerF4Vyv2Ps8Spxy9bUy5JGdAsmrUfcgp4hhP2MZQKSDF7hpuGoPoRclie9x+Qg2zt2odlQhH7SpL+XhmuvlAyQobscDWIcEU2GEjcHaulHibS0D4DPcu2mbPB9m4n4K+JlD+dIq+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqyGTGhcpM3Jsk47Oog0ePS9Xa8hrG9DR82yvadD3kY=;
 b=N+zVX9B3V2rf50TIa3PZpL/aZQJ47GJ2vTDFgkz31qo10SlyqjBXdX5jk7mgQXvvUFITstsWa3qFTJUMHcH2Qnp4QGffAtMVadbN6gvs/qD8csVwCr0pSHZTG01D56Kfh1wCskFtbmZZzeo2BQRBBdsQqAi4yEv5jdHm0jZjuRM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2244.jpnprd01.prod.outlook.com (2603:1096:603:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:29:47 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%4]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 11:29:47 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 23/24] clk: renesas: rzg2l: Add support to
 handle coupled clocks
Thread-Topic: [PATCH 5.10.y-cip 23/24] clk: renesas: rzg2l: Add support to
 handle coupled clocks
Thread-Index: AQHX8zI8YMsu7LfiNk6nvBtkf4HTPKw2iWJw
Date: Fri, 17 Dec 2021 11:29:47 +0000
Message-ID: 
 <OSZPR01MB70195C368AC8C818D5179F59AA789@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217103827.GC17079@amd>
In-Reply-To: <20211217103827.GC17079@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d40467c8-e1c3-4b13-e944-08d9c1508801
x-ms-traffictypediagnostic: OSAPR01MB2244:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB224468FD7BD239A565168E23AA789@OSAPR01MB2244.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8G8ctqR3ffjcOQDnZklkAAsdlAUJaAurjwnHxeoVvg5tFDKuhLPcnWD5uZ30j9zgRzl/POApuku/1SF8SaCwecxWBiQiMGmB3Hu9m6k5Wh2hDuBBo3e2duP/WqQHjBS9Jx6PFHrC7UomA5NFtY+BY2QDUaevB/nN7cRT34Bhm4Es7VVm2E6z57lXVxSyAp+aWs0oApnrIw18b5HbKl9jBXrxBECWLJQScXYxH63Y73G5R8oTKfNZlsezHscK3aAHNnpyB4F57ohe4MdGKQsK3ey0Dnl9gBbSLvarsi4rwVCqDiazGhlvUtbMcHbsmHrLEF5sFKyThl0+xKqZVg+Ruf4dbqMhoOMccwx6mOa46Z6XtUHrRBMBQYKkchLIn4brDj041TDIEKmNZ1Sa627PuRclBwaAU2Ynu6nEZ4EkZFegmd2mfBOS073eTEvIn8mUYzmKmCeiZotBT9dwuKTY3JS5cQyomK5uELZ1JbDcZH/+Xn7FTf3wmE3D+ItrpLIasHQip2cwudD8L88EYqRP7j4iar3imPc1x+VHJt6LGLhfEAHjdFjjnWY43ngBq9L5CiM2V/y6BaS3ZQZtU1kSiMV/d46pW0YWhC9DJ6Xn7LmaMqCBhEphhUonOlkqNudCyiYxHTdKbwPHXqI0SnMQXTklMOWODho+WD2Xv6qbNVZlrgnDIfUFM5b87YMVl55oTIodHeqH6V9aPnXQcrxDlA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(4326008)(316002)(38070700005)(8676002)(2906002)(122000001)(52536014)(186003)(53546011)(8936002)(9686003)(55016003)(54906003)(5660300002)(71200400001)(38100700002)(26005)(508600001)(7696005)(107886003)(33656002)(86362001)(66476007)(6506007)(6916009)(66946007)(83380400001)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZcSuwvz94itnDlDGq2bIJcLDXl0/ZnR/JsYOY2T1Eb3KIxv+4NNuOayHip5/?=
 =?us-ascii?Q?frahkXXfPpM07dm8Nphpt2uFwovKLN6+4Wiv/DbLhZnTr/sjpXjXGMBt+QNG?=
 =?us-ascii?Q?9XmYqxiJ2IYykbH7EFq10eVosOgCQueStQr33q7nYw8gw8D78T43b2IML8vr?=
 =?us-ascii?Q?BgQdq4UkPvFGsoX/8E/Ns7BBaF/XYvQObObjTC+lFiHizcQ7vi43+w47nZ9i?=
 =?us-ascii?Q?pM6bX5E3zKmlitAJTFtOD/BEGFhkzLQ5PjefN5jPkhKSURTvAyeBDUVj0a82?=
 =?us-ascii?Q?dCwx+E0r7thrnOBEYbesFWPtMhBjx3Yo5VZzjYWba9IJUIQdCbRmvGaVSfwU?=
 =?us-ascii?Q?9EdUErULqqM7o30SFi11yNJwqTBEivszySa6nlF+aHw+0Q1IH/cFW4zdBrG9?=
 =?us-ascii?Q?1n6wgIP2d5PraSTAmQjxpohhwuU7bRaxlQZndrJuzW8RcRQNNo5/g293DJrR?=
 =?us-ascii?Q?Ud0HvYb6J4obyPdnw0p/Vzm27FGeLys5Aut9p54jRSBh0d0llnJkNyYWfIKV?=
 =?us-ascii?Q?UltbB3D1yJaZzmuJsPO7jvQnkJ4wjC1PQbTmhpUKhXqofviDrT6IiY3b3A85?=
 =?us-ascii?Q?Tt18BvH1P1GlZoARLM2W20MSPDuu5Ao7mVcxdfu3MPaDYe7AaS0j7TDSCPdu?=
 =?us-ascii?Q?psVIBE9e3nGOvYDD7cOjNabjVreUzoD2T1OtJFxgk58kk8MuCGb1QYHSMbWx?=
 =?us-ascii?Q?e3zIElT75mw7NOvL0WVVJAdH6fbWsneApS4/+YokVvE57/R0EMdH1w5FPrtS?=
 =?us-ascii?Q?fiR+N7VRnr3tHLxj2reTFhUYdCCvzufWoZjXB4MAoxtyZWut+WnD72jjODz6?=
 =?us-ascii?Q?CG6LNgVkUNNjcG8ALmNpDrDsnmHKx/eUhdL/Q3nH+C6fT9LIY09GYDQGrBm1?=
 =?us-ascii?Q?faV+Q23dfGpE8HjlYObCZ4KvsMAgbkTsQTR8Q7iooEcVbcohzAlpesiI27No?=
 =?us-ascii?Q?yEHhbh+gwtAp/5X87tY/WwLIQNYnkAHZN0knREVhRLjZMV9VKwmBnvMifIgm?=
 =?us-ascii?Q?jiYb1hgV1TxKVM+AJb89Uf3rk073AGCkcJUGhmUb1ZseeRCWex/DStap8++E?=
 =?us-ascii?Q?MfkrAHy1IdHZi3ML2Nfp3XEfo8ZKs6mxh+EDP28JLZ+fZcrTrc+UeN9Gf+4U?=
 =?us-ascii?Q?9RdZSUbpr7801MCtlAZd47c4/5wO/m1ANXIqwTBVs0E2paMuDgG9L4JZOcxN?=
 =?us-ascii?Q?jqZFGjMgYVTsZfSk5ELmUj5oMsTQS/uq2uJR3lqeHRwQIEs+FSw2cse33Smz?=
 =?us-ascii?Q?O8KQZgzPHNR39olBNTifT9J0oGDDvCI/zlVy1YOF94wRxB4vaApidE+ObIcL?=
 =?us-ascii?Q?saeo1Jbfmpy8KOiQXoIU68RL0XB2yCb53q71KgeV98wS4ZkgljcOY4ZnrnEd?=
 =?us-ascii?Q?7kdOcV4ELRjhOW9Y/tEFBEOz4VVbSfyGRVvEeJTxIV60uolRdaSIX86Cebfk?=
 =?us-ascii?Q?4nix3Tzua9W6VSOL3vhj7MWk2d9bOW35tcFVWeTU3YQ1UGvF1mm7ULPyUeD3?=
 =?us-ascii?Q?f1zT//drM3gjoqFxhhR3c1Zapcqst7MHgGTWQQBStVc67LDrMWoaMf7rk238?=
 =?us-ascii?Q?qbjSikyJefxFr2AeeJy1AHSfC8gkBTfoCAhOJxsVKiuGVow4qSBDsAmMpDti?=
 =?us-ascii?Q?5oOzshzQNGbiOeR07FNc2SjUj8nyvjWg1TpezRLkJgzLW0Fw0CfyeNWIRUGF?=
 =?us-ascii?Q?J0NFKk6QYITvKRyuUBQ6RBqV0ZuVpU5IE/YBmBEm0pbqBOKzm5LdTh7274vt?=
 =?us-ascii?Q?/HK7b9ltsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d40467c8-e1c3-4b13-e944-08d9c1508801
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:29:47.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 bangglNgW3a09uvG0Cv5GnVJgsRPchAwx0OX4ilzUXxtbNhADLjoICjWwv9HYWuQ3DieVl1yXjAg6ShQ7gBxcw/KIVOWSkJgDIO0F92BLog1p5E5QjmN7or89HWA8C49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2244
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 11:29:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7176

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 17 December 2021 10:38
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 23/24] clk: renesas: rzg2l: Add support to=
 handle coupled clocks
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 32897e6fff196a5de4981030466ae391dfe56c7b upstream.
> >
> > The AXI and CHI clocks use the same register bit for controlling clock
> > output. Add a new clock type for coupled clocks, which sets the
> > CPG_CLKON_ETH.CLK[01]_ON bit when at least one clock is enabled, and
> > clears the bit only when both clocks are disabled.
>=20
> So the clocks can have different properties (frequency?), but can only be=
 enabled/disabled together?
> So  we can't handle them as one clock?
>=20
Since there are two clock lines going to the IP with different parents and =
just one bit to handle this, for this reason its implemented as coupled clo=
ck.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

