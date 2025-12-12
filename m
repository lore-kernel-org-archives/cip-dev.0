Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A2D59D80
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:08:27 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.207.1765562899005209883
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 10:08:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KVGrfPs+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.18, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrXRJ47noxwqkK/DMlib4eNJ1C48F2yr8UoRkK/CejG+GRIIoJgfLEOAdNMA02Na2dEW/M1PoOFwvL9IaRmcSVQUsESlysZr9x3G75/1PBhL0VOZtXfgZ+tO2PdcZf8PDw1v11GzvXA6lWcklZ5DiZeFiSUZm0OdIdVtkbrx60TE5eekHiX+AvSwIkXkp6jpZI5h0FyvrqWZdaBHB5iSJJCuVYO3OCIZ7PxOP00EBaOsCdiBDwj5sky8DrcP82Uci+5OUQgvBA4nenOy/N0ZqBXR8/bOFt4Fau/oVZniNa7lxbbWfT078CXM/PXGvpuqANtUN1YBpOLUu4ro6QiPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w92AlZoNEF/2oC6DOepVWzsKgpLfQpkfobxumRnnL8=;
 b=aLNLfCTixUIhbLjdBns8dFgVQnfUg+nq0Xv8xqiKD9NVAofb+zVXKqkuNfZUYmY5QkqHVJeNLZ0mDgRgqCSZucI0BWfEF0XHj18FZqYCrxZ1EqeTn1xsrF6YL0Yzj5OXfkyknxa7NJtqo3dGvv0mS0nbouQBN3VsdRdQzdUsJV85tc3SiAgOmW+IyMSeGuuyX5d6fJHBJhyTosgWScgsYPoY9uc1NlU9s2EoCaotzjCHhKfs/SgO0Hw8duQldn41unC5FaOPkG+jFCCmILsfLFwu73hN0lKGVMEQg91r49o0WFSvLDAi7Jeol/Q45JgBcDagByJvRp/KKaeJ41abNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w92AlZoNEF/2oC6DOepVWzsKgpLfQpkfobxumRnnL8=;
 b=KVGrfPs+w+LrlHJZ4QfsIgNMcnLrvbq/qqfxuRBvlthNRwiToTN192DNyU60m38yi5ZN1AlyiHk81iUrqkYjNlSgmtWObkFdmNfShttqhE8aPSiPPP3E3Bcc0N5MmEGFTl3ADUjsCaggSoxg1aZli+TSn4kq2Q4sYsENJLQzKwI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYYPR01MB14116.jpnprd01.prod.outlook.com (2603:1096:405:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 18:08:13 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 18:08:09 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 16/38] soc: renesas: Add RZ/N2H (R9A09G087)
 config option
Thread-Topic: [PATCH 6.12.y-cip 16/38] soc: renesas: Add RZ/N2H (R9A09G087)
 config option
Thread-Index: AQHca2ZynUs5Ne7GXkexqYHGGrduj7UeTZSg
Date: Fri, 12 Dec 2025 18:08:09 +0000
Message-ID: 
 <OSZPR01MB7019CFE9386E57C331C38603AAAEA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aTwQZyolWR8CqoOz@duo.ucw.cz>
In-Reply-To: <aTwQZyolWR8CqoOz@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYYPR01MB14116:EE_
x-ms-office365-filtering-correlation-id: 0e201a59-be71-4453-38c3-08de39a96861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?SRaNPjjVXFSWE7L/XTf6oCpZ0xh+QJtzgWwj7XsiLzumaCG1mHejRQQYna/e?=
 =?us-ascii?Q?QvYzVrtt+L0nzb3hpF4g4SLkQKrUFkA+INu0mM7e01tdsdhx+XFN9jwFAi58?=
 =?us-ascii?Q?Y+SP7TDb97HRgsYF1l3ADeSNu9XQW7gqO98EdSo0tWccT4Gg1defq2ni3el3?=
 =?us-ascii?Q?v+FR8crh/cap37QoeZJRKpO+VX0FmuXm6Y5HxYmN/lAu2aDDTLp6IZeZFNKx?=
 =?us-ascii?Q?IcqSiRqebMDDKy+AqPRGIPwHOW4TaEd1eSVDnyIVjmd+R6aCvnVCeV0zLvQ1?=
 =?us-ascii?Q?MLAMNVplW6uSgVNdsVWC/cAzFHL2PPiUEHDGbYp0jGDLq6P4Qj/QEIjSL2yq?=
 =?us-ascii?Q?lo1CxA7O9aSqcEusvY+TUuGTwv7iVs7PDX+adhRWx7G1t5Horou+T6RFYR0C?=
 =?us-ascii?Q?BNDH2EKQCvOVeBrvRmi4ggZNBdUz6vB0whko5haKRSPEBRxUaNu/Y3Y652cg?=
 =?us-ascii?Q?F3OXCQHuameH7w+CV3LpEqB0gsDVV0SBt6eQnPtM4x1p+/0X68RLTQ/RBz/o?=
 =?us-ascii?Q?48HbOBAfYXyylzjFMhtH8Zwo/pnaNkouRSzCtJg0aBfrRDJjSi0Al82nZ50Y?=
 =?us-ascii?Q?JZ2N5nwolZJ0bZ2/JeC2W2UzkTTQPXf4MaydtLzaU6EgrSZJjWG5gjVFcMIl?=
 =?us-ascii?Q?6IjYwytmCShaiaJ4t2W7U17Q51vv0CduuToLEwFAQ3auahAzWBhu9/vLugn5?=
 =?us-ascii?Q?XD4/1dmSTA4+Up/QpFvYdOOeGNiaakUh66XcMKUzXPaeo//M9pe+h/lXnXkg?=
 =?us-ascii?Q?BGP+LL0vBGd4vck5Vnab5zHffHrrClkXxrSudMVHI1PhgybScvTGYOK7xOqU?=
 =?us-ascii?Q?x5WUPkSL97iZ2JCduwIZChlzuR+6bqGlESxj8TmtVJvD73bcSUUeyVal0Gq7?=
 =?us-ascii?Q?EokS+SN951rgIgUGXOHN/Q/QR6q0AdweQ7O6KXk3bkSVf1y6/s6DXtPFMdDk?=
 =?us-ascii?Q?Ehq4irXPoa+RCEDkUvtkTRPGAQh9Wjusbi98hN5JIP1cdXtmLS1do5CPdTqV?=
 =?us-ascii?Q?Z4QT4FFHr67QMSeD4Wu1NTImMRECFr/27yaf5Pkt6z4EZweX/BJTOtCOETQZ?=
 =?us-ascii?Q?FvDNWbomYRUb68vegqVaeDBvo7C4Pv3QfltDOZ1l/LsXqz4jR1E15fnt0xEq?=
 =?us-ascii?Q?tQESysuqxmGSA2M6fOcu3Pd1tWGQHzhnCpKaG0N9b1DAHkfALu+OOm6L9qZf?=
 =?us-ascii?Q?6geOjaytCWxbVvs2jWJc3LXcbrSQdY1GZQaRVIvxHHOzvEnZn7niVAEsKWlY?=
 =?us-ascii?Q?sdrLTWVFxzjp2b26GBBcxkgUDij4fpw5Bwg0riXxjwwthDyvl1TOXnJhLuNy?=
 =?us-ascii?Q?ncIQULAOy3sC79xPemVW2Q7LgLoYvhx+7eZazMll2UJ8Ik0kBJ97DvQXQJRz?=
 =?us-ascii?Q?DIgkjnJ77AcgwhuE68iUbzlmln/hEsnJZayPdIUus0EYA8hqchd8GBEpM11u?=
 =?us-ascii?Q?y3aeihPkd/gNHMHznn+4EhEGgScaTRaVP40OCxyEaycxUcGP7o1t/+zOiyz/?=
 =?us-ascii?Q?Kt9F/RRmXubWTruXYjyjGDWJr7jYe+mspHH4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?LksxUR4z/465ajpgfck2T5rDRW4uoxNgV3Ee9cpkrrXA8OQETSnMuRsn9mCj?=
 =?us-ascii?Q?NQeh0qwzSqfttdh8LabxqsioVpgCwiQW5idlzEo2xGIKukgi9g5jnc2ROEgQ?=
 =?us-ascii?Q?qZB9yuOMrTkDU/HxQA78rxnyK/ZFxpBYFCB2qlWg238LewR3r1v22Ve3ROo7?=
 =?us-ascii?Q?hDwCIKC0VC2jfqql/bGb3tfQPtrm/3ITMxdlsvBAmvwopu0SeznPQojg9J6s?=
 =?us-ascii?Q?S8DGkG0W2TG1nR5pDUORKbhBOZX7lZa7bh5t5oFjZ7lzAmb4ttmLcj9/v3lT?=
 =?us-ascii?Q?R9XXtyJoVhjpCOXY2R3Pz/ztf5S2B2o7JPN1W9bhY0Ok2UUcuVEiiKqH2w5i?=
 =?us-ascii?Q?j2913LXwxZju1oSFi3z7ptd0J2ELfgupzfI3lLbXx6/CxW3jIiYmWwoKM2On?=
 =?us-ascii?Q?eoN9hjwMEdDluPuF6NU8r4zHvVq4zbkfPwF91GR+q7S2nZBXKK2DuG9xcSgx?=
 =?us-ascii?Q?+B/syqmp4A3/1/Rud695pBjVFpja6ORxbiNopF9qCDCDirT8PfjIN71nQiJC?=
 =?us-ascii?Q?BxNuCL5CuMUtiaLg+QGwXUc5fWSQ2D9ycMDdJ8Z61jJk31G8pNZkDzduE2D2?=
 =?us-ascii?Q?uM/kaxyLnVJsYYoHRA0GI9xQ1147Zsgm0wsAhwOedZ0tk5s8kuG5EcetJ7FB?=
 =?us-ascii?Q?BG6Im5w/BPeyynCHzJdBv0BhQTmaHW3gREaHbe1+98Gk11S/57Ov0jZgPCna?=
 =?us-ascii?Q?NcW/SqfSa9T7cWQSQrMJxqb6zZ6YhwsXJyoIXh6/yHADGeoBMm8QTMQiPGga?=
 =?us-ascii?Q?XwgcUlLn/N29ThqlzM+IkwRduB70YKvgR98ltr814yrm1Hr1KA7tnEopfUkE?=
 =?us-ascii?Q?rSGl6t3Ke6wtSteiSoTuXlaQ2E3+PEqOXZhhdj25am4ERx2DeOw0AkAQcMWy?=
 =?us-ascii?Q?ghcsvfoDhU7B7qZBKG9PThobh5gKnyGJ6oi3vmW6SC1MFQcKIuaNTC4aL5/W?=
 =?us-ascii?Q?sYs9IFhDksYM7QQZFFFm4MBiFcHvbRWa5BaW2ZK+zc4d4e8KdYTP9eoDlhLJ?=
 =?us-ascii?Q?9nHXOX0aGJaWO6/GE6No5C13ccdI9D9UdR5/93lVrdW4O2FAdNoQlag/Cdm7?=
 =?us-ascii?Q?MF6UZaiBHYcOvPlaA0+ATregWzHDpttjKGUzS1tNLzBFYeprcJX7ttLQHXhe?=
 =?us-ascii?Q?xth6fWSlt2VoIkbzNc6CRRA1KP0iKqdp0JDes0a/w9RSLoMwl/mMslP+lxij?=
 =?us-ascii?Q?RMu81UhPGUdgBnogwyJ2nmo/STRSadIea0mxiKJGjbT08BbnDFSwWg1C6qyt?=
 =?us-ascii?Q?Vs08CbRoabK4s5xchws1qhC8tdBGgzJH0M2nKuSSPlDJ7LFinwtk6FNa7Rcc?=
 =?us-ascii?Q?tS/Vji3B5x4kTtxBDzXX2YViZ/jgsKwUoXhv4xaE/qh6SFjjnx93MIHlE3Do?=
 =?us-ascii?Q?DeUvBwT0Pr1xZ11puqQJP+J0A9ZSpqV1fZF4oZDWLKbKiB9B8UuvUFAkvU78?=
 =?us-ascii?Q?doxgHOZ3TWSQFCwMJY9f2N3JXDAN+ffZRiTvMS/Z7bSp3eGenQ17hyLPWgoJ?=
 =?us-ascii?Q?HZqVEVvQqlx3K2TrDJBnqgTpoz6JPIpsPby7FaETatcrGWDn4JV6uDH3MGQ9?=
 =?us-ascii?Q?7UunryjFYdAkXl0wXZWkMex/dG8is5jYKuukRdvSi7gYyIXeauRZ+9v7Atu6?=
 =?us-ascii?Q?fu0o8IyHwaVMNCbQwafExJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e201a59-be71-4453-38c3-08de39a96861
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 18:08:09.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIJEmBo+9PHBzh5RSBb5Da8zyJqNYDPRu5sUOWzK25Lah1PxCNRXa2nEMrFziXWv1iVNbgK/gjs9XmDyk2LnZg4nsImo2SBWq1R+601nnRFPKmvZq1h0O5/UDTmnzhNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 18:08:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20990

Hi Pavel,

> Subject: Re: [PATCH 6.12.y-cip 16/38] soc: renesas: Add RZ/N2H (R9A09G087=
)
> config option
>=20
> Hi!
>=20
> > commit c7968f5e7c7c7b46cad1e92294c211417a7ba90f upstream.
> >
> > Add a new Kconfig option, ARCH_R9A09G087, to enable ARM64 platform
> > support for the Renesas RZ/N2H SoC.
>=20
> I would not mind 15/ and 16/ to be the last, so that config option works
> when it is introduced.
>
Fine by me if you shuffle them while applying.

Cheers,
Prabhakar

