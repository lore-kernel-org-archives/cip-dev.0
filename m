Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC868CCFA05
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 11:40:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7638.1762342850399162466
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 03:40:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aZwdniCT;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRk9wZ+g7HMpT18SHzRueKPQiKQ4d7cSxGVHw3Kc5m1BHyS2RY4rdItK2suk5XbqwEIbxDQ7prIP2sDLB16bAjLHTcESJIYUvWLUmoYCA7s7rxz/k2MOIxKQbdJUdoVh8eUKwJm26rse5K70mopi8kgPZ41pkx7R6MJGnwwN6OXMMUa/sqP0TDN0WUINfIfXM43Xst7qlrZ7V+uUAUFea72DfEEW5HJfVc+waT2CmXvBWffd4phBmSQA8uhSuh57cLol0qIf2h3olsENTfhiKX5EZVQNEdynBssKtn12dYw9vHqh3S6hUSFinn5GyHGHmMDp1bSKj2fVHj5iavCzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg4fIN2aZRMiZP9VWWzb3vXfIBWfDQmReDd8vE8GUd8=;
 b=Lz/ji00ccAcyiLQlmMX2qCu2M73eP6lP8iYMcDwK4clFPkYeVuDaMaF8rJ04HHF3Skvx3ogkqkkLFWHNPC5YJiDj8d5CFdRo4QjRbURDcgoCImySYMNR5Wb1OyN17pF6hgaWjCL6iItIAkfJd2aeXDNg6KlXh3ZPpqAC9Le/+Abe2799PWw+QG2p3XuRpykPAwH3kusWqdhv6nDCbsPK6OdUSIrgMmpyay6k2D5wto1W7KRmIcsvl72mkkebI+WWI5D5FN9M35WWUgLFlxT+zINFku6JdAhpOsuoq0VE7JjkmBqa8mSqwS1fQ2RosboPStKMruNGhW2nWYD6j/gRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg4fIN2aZRMiZP9VWWzb3vXfIBWfDQmReDd8vE8GUd8=;
 b=aZwdniCTTvQe2bkywr2Hou5ofLBf9TG1R74Q4UxbGXEhNIlXiIu1fqISbNHnEaPS7awtzLcqmb2uixBxB8klNtZoGmXm75FrX+rfGv6HPBN8/4aFmZO0YKHd5Fz57IKQBim9PbSFwQBGO0GLuQEwHXIf/HvioUNUQUkv6xqmWf8=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSZPR01MB7866.jpnprd01.prod.outlook.com (2603:1096:604:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 11:40:45 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 11:40:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: John Madieu <john.madieu.xa@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Thread-Index: AQHcTLZdLSJVgPZ0o0qXa05vWiqnyLTj0YIAgAAB01CAABbLgIAAC9EQ
Date: Wed, 5 Nov 2025 11:40:40 +0000
Message-ID: 
 <TYCPR01MB11332F6D8A88A738C4F65BC4486C5A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
 <TY3PR01MB113467095AF7FBC653DD1A8C586C5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aQsrldDm96rIxlNU@duo.ucw.cz>
In-Reply-To: <aQsrldDm96rIxlNU@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSZPR01MB7866:EE_
x-ms-office365-filtering-correlation-id: 53fb85d1-33a9-451f-b8be-08de1c60258e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?eH2ULuvEZkTVeKO5eO7a3mEj/+oAq5T9YZszGe6+4/A8GgMYPr8EW0A0Efn2?=
 =?us-ascii?Q?c7RrSMtnQ4frNatAomuz1a23c8Fo2YsaMizd8UKxhCn/6Qg0uWSILhxHG6qv?=
 =?us-ascii?Q?N3+NZdbI6jmLJ5IXeAoKDq4w6lUIALpcJWa+VBiabhdF0y6vf90HhNo2fIcT?=
 =?us-ascii?Q?gZ4E3eMnaAovDp5B2NtX3RzcJZ61oPBhILxCAmHFxH6ABbdAKG04l8L+l7r2?=
 =?us-ascii?Q?4O4qpa/SDRrm3Y6CbBWbfD29+Ey03jfyqgIHxJj1Ify5W+TXxjWPsrU8S8+h?=
 =?us-ascii?Q?+79VVXD+S+Qhuol4ifmRrLYLKtA8FTAgs9r+3PTalB1lLlTbLRcgy+J8HWSr?=
 =?us-ascii?Q?XN4LOgorm+TFWDBJi1b9zORwlp85V9eq1OZf5cqc0H+9ypGHgpeom0JyX6VH?=
 =?us-ascii?Q?RfBEEqkZDAvhpzESNgZ7kMFkHWmz2IVsnQzqtphIbYAhlvhCLaQmftz64aoJ?=
 =?us-ascii?Q?f43xnddhVRpHsNhXeV6VNLQDtnlPLzb9EN2cKV5X/3Rc8rzuYUrvB59pEdU8?=
 =?us-ascii?Q?/MgquFtfbV9gvbNcYKbu16GP0WrrIh1TgDYN6VTCaaa0QbVsVz131pb5Qec5?=
 =?us-ascii?Q?Ix9yc/ChAiBrceSY4onQBADnZogH1hQDjMCZq6tCKAiuMPKDJCLsDyh+y6oy?=
 =?us-ascii?Q?CRury7h90d6vbqI6KXD2ivweOLTo7d4WZzi1kd/XPKvGCN946rvPbNMExlxW?=
 =?us-ascii?Q?B11dw3ADzn71GtlElb9ONFi1FVUvKhNbJ/g+oZ3Yj0vy9aZ9DywCwTkgPL0I?=
 =?us-ascii?Q?Lg3LNIPgRkWoQ2T/AjkrT2cp735hECUyeJunGyGhZtV/nM3IjHrkVWFAM9iJ?=
 =?us-ascii?Q?f0mJoBdDrdspv7PiZTCdV3IxdXh5Fm+152PG9IyQzv/VU64048eTicK1ZKVK?=
 =?us-ascii?Q?GDynpzXZAjoq18keahDFivcSZNpTBxlCUnCmN8hCJf7tEIMinNDMInhJ+cU3?=
 =?us-ascii?Q?WdGZYnqJlmrTgqrb3XFcFxsdM09NwADEfq0qoWrFp40TjRV/ia7n/cohbDKg?=
 =?us-ascii?Q?51dbS9m1AvoWuDffhy1Prfs3EPshbCQlS/JwJnVq2MgDOe4adsNVibr2cbpK?=
 =?us-ascii?Q?qOxfWvjYaEQsO3mJxPiprKwbvDVuZ7M//UgrEthv/dYLuZc0rfbFUXfE4xKQ?=
 =?us-ascii?Q?skCbhh55VYzKCtFu8jukhStZpckM0pOECkO5qkKVNG4EoHqhIM5SPiFLEkwB?=
 =?us-ascii?Q?255CYSar0jJmJm/KywwI9q9MWYx7QB3hn0Vr6t95AqAqA4nfy4BDBg29pqSc?=
 =?us-ascii?Q?OuyDEbEulPDHzoV6bmw/0ZqFQc0+Tq/6ZqzxLtbPOekJOPIGox3UYIcCEJ+o?=
 =?us-ascii?Q?bsnkvbVMdL+ke51AxmYJqwMin04RvZ/5TSW9Jn7NDjLKwTwU2jfyj3D185MQ?=
 =?us-ascii?Q?aNif31iTiQm6vJweWDvSOK5LlHpXQXbjfgWbjXlwdPsetsk/1x4dFmy915rE?=
 =?us-ascii?Q?2Y7TO5YSbm2qP5eGfUUnbOoMqBT5HU39mEk0WOuqve1MwtmHcbPUKNiLVgZx?=
 =?us-ascii?Q?hjHgk3WAVBCiowEzLfpjJN4PSGyJmg/fbN12?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?rLqlPdCsGtxA7KyBo7PYEcZ1Tu/07bLFEKee71gUfSXNNcJQzqTKh0Vg9wv3?=
 =?us-ascii?Q?TI/+gbJvVDnb5jIebmo+fElciFGtp/yfZbfKKMst+ox/bWOL1SO1OBEHJv3Z?=
 =?us-ascii?Q?pceI2dmGYOmhZjJm9li0rxQyo9sJ4vYh+cQXm/3+ixEtWPM0hU9087vTnNGI?=
 =?us-ascii?Q?UeJEHKpyDo/IOG96+WvqA5WkTMfAr0tOUFm2XtGvA/StEogYHNPhf0b0mGGg?=
 =?us-ascii?Q?26qhVydbNWPLQGikSqSY1U4c1iBCzlYXpxkvI9RH2BIKt6YVkhOeWVw9nq2/?=
 =?us-ascii?Q?K/pQIEzeUsqKrt3X7NKXCzdhSFu3RL3QKlQl4svkj0FHtPa2nlFStDj7CBXL?=
 =?us-ascii?Q?msvCgOvzdJpKf6472dUanL6sMazJxxqrlyllPnRW/bWImPBG6kRP65oXsFcU?=
 =?us-ascii?Q?8XTK4TcmXP/brvIshZ7VIIe6qrF58uQDBy9Ui2Q7AReLAQEkjY5JsXOsSjxZ?=
 =?us-ascii?Q?M4VEmKzaUlZrjgFWoMMpciTa78+XA4aBD9zp4jol3XP36yp0Q9+VqEG3QfDm?=
 =?us-ascii?Q?gB1FWF8s2QNhVH4O2KJoRDO9LMQrE0UnM97fNCSBi0SlcOHMMExuD4ZTrzvM?=
 =?us-ascii?Q?kCD6lkiNNzX4qnjaLmUYRUaf/5I/PD9aa0nPE8CaqIPpFf+LPCZrfVPQVTgd?=
 =?us-ascii?Q?Gmjkcqvc2IYfXN2/XzRCGLN7a063IxljfRTIhw1TJ5WuOVbP3jsR6LOAOH6N?=
 =?us-ascii?Q?XaTAmO3a/BCreCdw3oVyf+BfNCTgnU85AGVO1/sqxHLolw76GPCf5vXJMzdO?=
 =?us-ascii?Q?NH46W8oeKmdcBIWqnB+AY4VrNXlRiK6ko3cgQXjpvJT5UMi+xHJuV6+9Ot6r?=
 =?us-ascii?Q?VktalXzsjFKtdE+0lYQV1o5ogIy2i/af9xm+n2IHUF3brgFWbhUQV/ALzlAk?=
 =?us-ascii?Q?IoLeE+Sce1G8ZjA7fSad55qF8UDMZRvYlb9OecU4bZio0pUu/trPjeBm2G4G?=
 =?us-ascii?Q?KlVwFX1L1O5wvg20FulApL26hWZjGfZ3GR7MJw5chUnmRtERYdoDf9/aY3l8?=
 =?us-ascii?Q?r9nf+/qKYIR1+ff2g8VH2wUqdjAH5Ev0m9UiluFF0MGCSfycN5oojyGFOlMz?=
 =?us-ascii?Q?Lh59x8fkijbFUKP4JN0G/7ypbJU5+GM9ipcNya9X/UBMC9ixTJ3OBqqEsp9o?=
 =?us-ascii?Q?28vEmNN+XSveunk+rGpQRy6Y0FxDeTMaYk0ymQoz9bWo1mOdTi8S56i7CDZQ?=
 =?us-ascii?Q?6jrCyQX+U86oUzM5nllJfaM/PoX7w5aoxKUqGQg4pnn0IdQN7SC5Td5NkWKW?=
 =?us-ascii?Q?MgbNIedwI7qgKZVxRLwAyML3csPpbD1Ns1NWy+fyKfPOlXJy2C3OgqEWbqKg?=
 =?us-ascii?Q?eTs7LnulJXcACPIxe4x4bhTMArUsvia3Ar4QR3K291oqB5RVZtxymi8xP5oe?=
 =?us-ascii?Q?bdBm/FTCzzQMyOPybhktXDKheQ5WlNy+HBnjBCPOV+2MairDqUDG3cBDA2+r?=
 =?us-ascii?Q?t5Adg1TYHr6mwbR+gLUyPSL64U/RfMGllGcMx37fHhCu1O94KmR78liN3rc1?=
 =?us-ascii?Q?OnhWVsMlZ8eq5IxJzKSeq6Oo7P4pjobM1jumyu/+nxLE32PnxDfhIjkSSBQJ?=
 =?us-ascii?Q?NcM7GxBnNP8VK+VRAXZ7Ng/dGLDzzPr5PQ+6XoYz1CSKS/+e8VFgLTCjV5HL?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb85d1-33a9-451f-b8be-08de1c60258e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 11:40:40.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qtVRspbDV0u4zb5LblJXviuBg+FOYTFD3CbcFIYgHjBytckAQ73fLfyc5XvSN7uwowBcEm8X3V4z73qlw+mCGfMIwTxpLy99YZ9HpeAqDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7866
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 11:40:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20361



> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 05 November 2025 10:49
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: John Madieu <john.madieu.xa@bp.renesas.com>; cip-dev@lists.cip-projec=
t.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
>=20
> Hi!
>=20
> > > > Add RZ/G3E GBETH support to cip-6.12. While at it, also backport
> > > > RZ/V2N Pinctrl and OEN dependencies.
> > >
> > > I agree that most of the issues are best solved in mainline and
> > > should not block merge (provided this passes testing and there are no=
 other comments).
> > >
> > > Please take a look at
> > >
> > > "[cip-dev] [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option f=
or..."
> > >
> > > It may make sense to put that one at end of series, and I can
> > > probably do it while applying, but I'd like confirmation.
> >
> > We planned to add RZ/V2N later on 6.1. To cleanly apply RZ/G3E pinctrl
> > patches from mainline, we need RZ/V2N pinctrl patches which depends on =
that config option for
> building it.
> >
> > So, it makes sense to add Config option before RZ/V2N pinctrl patches, =
so that at least we can build
> it.
> >
>=20
> What I'm saying is that having kernel with
>=20
> +config ARCH_R9A09G056
> +       bool "ARM64 Platform support for RZ/V2N"
> +       default y if ARCH_RENESAS
> +       help
> +         This enables support for the Renesas RZ/V2N SoC variants.
>=20
> but no working rz/v2n support seems to be confusing to me, and I don't be=
lieve that's a way things are
> usually done. Can you correct me or explain why it is required here?

It is just added for build coverage for RZ/V2N pinctrl driver. If you think=
 it is wrong
Please move it to last or drop it.

Cheers,
Biju

