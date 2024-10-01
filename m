Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D582CEACD8
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 14:44:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.35])
 by mx.groups.io with SMTP id smtpd.web11.83642.1727793884839411550
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 07:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=P7gWcc8r;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.35, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJWoXzX3Qb6oiXahKY4oCwuxONurFsnaN2bV5Sr9sSae+O6d/4IrOFp8Eqv1zqLbYjh+1R+Ayw3zeqYoDs6sPPSQmg7lsGb8BSSJCthM0vB8XMj79ZYRpiwuqeY9TY+j9u8RyIJBHCdA6+08FydaOYHtn+ipeQ0AH2T8rkSXNiSIJzDCPpPpiypNZGHzEbGDgXs9hCDPYKFpHFj2bRRbtCMr9/lqwHwU/t90kshgNmzSuyOTNRO8RBfb7hzlsiRYsb8FHHEZvJCidT7Unog7zvYdkobZ7ZIx0xZrJ/C9Ayzc2wmMVwUhIhaOb/bldgyr9+yfx3Q14aAUXwO4qi+y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axJklihBcWVtTJv5TbJzcZ3uvz9J0BYBn+h22Hg6XMk=;
 b=YTXFZNkPatA2MVaw2ndz6d5SRN09SPEPyEYP7Uh+HuNbUgvBEmd2GhUncfWQtLnhCoE+yyTbZF298OQlEat+H+75jnxVicg3bbVigBP8fVyJrpNEivdVombq+t27XQXD206Jrc06rAGH2b5AHchgHYW6iC0Slm6+wVBypuNjpQkQlPfNL9jMzQ0dNu8juKo9I5xs+0osgo0LoKm+CavWgMP3LQ6UMKmpIoq1fB8Nqo4z+CM3TiGlRMsagv6ds4XjqCqOsfawHnp3wAaSMns5VJPcRPEIMycCo9gRy/3Qg7J8jpxA2OE9Ktoh3RkfjEIe/5dSZDCWETfQEMas5XWAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axJklihBcWVtTJv5TbJzcZ3uvz9J0BYBn+h22Hg6XMk=;
 b=P7gWcc8rBNe8/FqcmO/amAzxcKRISPjrY99S8SM1dXLWXO5+SMyBIIso8EDYXFVJksdJJ/vpc1zD68cosaixqwpaMVfvDXz7hCSxsGuZ6uLgQrtqiLbzXeGRWJ39lq8954bu010TxywCpA6CHGenVmo9V5w9Q1xd9c8d1Bm4ilY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB10544.jpnprd01.prod.outlook.com (2603:1096:400:30f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 14:44:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8026.016; Tue, 1 Oct 2024
 14:44:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] Backporting query
Thread-Topic: [cip-dev] Backporting query
Thread-Index: AQHbFAhOCxXewe5AS0SunINIuwzhKrJx9t4AgAABqbA=
Date: Tue, 1 Oct 2024 14:44:39 +0000
Message-ID: 
 <TY3PR01MB11346AD1109A67FC9B29EE64286772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
 <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346B7F9FA61A31E428C25EA86772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZvwJNIjpEi+fjjCQ@duo.ucw.cz>
In-Reply-To: <ZvwJNIjpEi+fjjCQ@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB10544:EE_
x-ms-office365-filtering-correlation-id: 678115be-cf0c-4b36-4ff9-08dce2279403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?bZeK6EchM35+ulzA3OoQtMaL5TA56qNef//ygBj/xwMg98OP/FZBUvxjp751?=
 =?us-ascii?Q?MuVnmPK3HAbgbpI4/AJV0DMj0xHyO71w1XdaY8fKbBDtmQmjSg81EzJz6W3G?=
 =?us-ascii?Q?wtcjPruBFrxb22aedWzcxBlcRXjEOiILasWewdcWrfQwLR/mIUrrzV/c+kxJ?=
 =?us-ascii?Q?kjyZNYfjbhlRJRllUA2tScaCN+W237veCNds3MmUuvw2Qcx9r0F3OMxZ7WAm?=
 =?us-ascii?Q?6vwsUvla12pcuLOa/USea9hgOhKgLgha2oryOTCk4FPoXLBxWM7x/8QM2jkS?=
 =?us-ascii?Q?nG0bOVU2jAij9GHiiEKgTGDpZLXOPCrDnlvfAE2Nkcl7LsuofC3pBxqOFRip?=
 =?us-ascii?Q?eBoa8ZxnEZJDnkjpoisGxHN1lFHpByvqZUVQOb3TaJtW1iamD7mwOnkhyGmK?=
 =?us-ascii?Q?GwmIWGOjgPfjEQl4zHgfoF8SP8P10Bm3IYUq2KB84cmA5eU4GoLdjgH6+R1T?=
 =?us-ascii?Q?sSDckUc5FGc2bB800wwAyS3UioLa9QPL2Du9gOScz2wMKA4tu/TzzVXvEJS9?=
 =?us-ascii?Q?jU96SPiNd21vybfloohWEVbH8hW4eDBT5SkXXgQaxo7S1IcSJxNjucOZ+g2G?=
 =?us-ascii?Q?l+yFIjXtqtG7e7chTI3eeLz4iE4inUbD6jATKkbiqR1WOKsB7U3t7aJGaEFh?=
 =?us-ascii?Q?NckS+mQQIPpibEtoShZerJAL6tnCMlRgAJs4InIK4p7yvCCDg+gPVO6o2AbX?=
 =?us-ascii?Q?v+9jf9Tvnf26cEqOM3fTXZKGe0VxSvXwm4yD5y0x6OXXzUpJtDs7AvsbuRgu?=
 =?us-ascii?Q?nPumTiFwYfK49xqc9vnJGggNnFmib4oUJd1epVNQZPlIwfUCn7+iP8M+6JKl?=
 =?us-ascii?Q?o1bYiVU/MykExVCobSdsOwV8Z7dZnm5Napa+Lcd5mni//RoKcuDUxNdxizcI?=
 =?us-ascii?Q?QTiVZssvdPihZ0Sc8az89hQsQtuoMH9JFqb42rXH6YaUl6zIHI2vTZN6Qxjd?=
 =?us-ascii?Q?N+S6OIq4AFFmX4W3ZvyYLDA3GHvYB66/58i5lNLzoXEMVlZ1JXtqRwKmQxQE?=
 =?us-ascii?Q?cJSNFqZc93vmAoaF2OnlQFoyfSoOOwBf3LexrnlRYkLvESQZMpZKP1SaHQ+M?=
 =?us-ascii?Q?V//KxMm493u5/hcy/mt9gU2V9k3LUDN1DmXgZ21r9L2gxf9DNdhcxvYrJD6n?=
 =?us-ascii?Q?y8EMAwPyg9rnR8ReqEl6clA13nsn4ExCeYE5XMDBKRo/TQIuyKwqTZ8X4ihG?=
 =?us-ascii?Q?GWY91rk09s3jS2nidqS08m/uPGukv3p/EeDRdHNsSUT8n4oGXNzPlSua9Y44?=
 =?us-ascii?Q?5TMqc1IPcd7IlFqz1PLIhT62WMN2jrkdW1RDPSPmG1yOEAiZN4N/GK5eOx6e?=
 =?us-ascii?Q?EwjkXfw9uzIXjos4WnCBFCSA+Oc+iWmkqmmcqRExDJEcEafJwz38mhuM7Ltw?=
 =?us-ascii?Q?06R7gE0TbFxWjDH+wPtfHQQJsygT+RgUidCgx/Her5cV8z54oQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?a3RJRZG8uMfclGqTLuCw6V9vGiV+BZf28dOGjfrNr0BeZKpEDA3ihj2OyBv2?=
 =?us-ascii?Q?DaV9564nipmzFD/YsS2ixiOM9CZrwDu29Bnkd+7pUHeOwnt44AjxjnIygaVj?=
 =?us-ascii?Q?8qikArEx5aqJGJDVMyZvLJW3xoGxL823cIfDRnJWynUj3EYZocSu1EOhVYxA?=
 =?us-ascii?Q?e+5PV4tWCt+M2PRdYscrkLRz1uO/fvMr/f+ncDVDgrePo63W2aox2dBWQ4Yv?=
 =?us-ascii?Q?dCi1x/kY0Qe9Rak1GAy6fqEyQMotIJQ2nKXf1dyXy1/ObWNnnyxHxidaU4BG?=
 =?us-ascii?Q?C00Uty5ko0ryHNvuCu361eGHkjGHdufNP3r1EKnfZXy2VdO2jH003ZUAzkE9?=
 =?us-ascii?Q?HtyLpuhjqN/W2S1aXmEQWOuCSFtzHEuGFXoeA5gf0rnxMTVP3djmk2OmuNCL?=
 =?us-ascii?Q?/lpuT9/gC/kNp1phoL7bDiDYInI0dR+GXfozmV/TL7l47gdtuU+ZnlgEo9BO?=
 =?us-ascii?Q?Kp+tIKqfCHm7jrJ5JWpMrwR5Z0f8j0mrBzoJNgUuCs7m+JKov4JP8IRzb3Xf?=
 =?us-ascii?Q?WzfF7xvtnobQH7vZMO4VGTtZDhaXQ7Qa/YWu5oT9XE/E3itNEK7PVttBOVYe?=
 =?us-ascii?Q?zRcr/rEc52AF6RERm3leGhmXIBlRnrzUATB/aDHJLZxOjElwfCoOUBDNByA1?=
 =?us-ascii?Q?z+RP4LOAQErbfqiWpajzUNMp6P9gITYCWmJFP9J5Pyn2MaxKTUzznO6TwbhZ?=
 =?us-ascii?Q?XExDS69MlwAimMgebrvw5GQXNG/UxP3OD2Mb4NThPHjvs+s5j05xtuZp5Voq?=
 =?us-ascii?Q?xR8TAAyJCYXOb1Mk7E+WSt27E4WuTFTMEb/YA13x9pKIbyVlzgT1Bh4AnYR1?=
 =?us-ascii?Q?roNs/bzsacNspEM9wv/F49A15jo1kNYVJCDo46AekayKCsuRVPjVis5QC5Xu?=
 =?us-ascii?Q?Nu7JFPXVLjeBZ0vfsUIj+S/25Wb6G6go3R233HSOZ5EUDxqxy1z6JJGVn77Y?=
 =?us-ascii?Q?5sk5Niw0WunDERqkLYVyScpdYivGVeD8+ownfSuAzVumi+reQEyka+gAyxcA?=
 =?us-ascii?Q?X0VmanicvevWG9H8WFSVzgo5MSCsublzbF9En7jYnzygatnmfvVWYZimmS4b?=
 =?us-ascii?Q?l5P7nOarmusn9dUtE24RvoLFgtdTXO7uE5uzVygK58y6sao5RMDpQ4gcpjTE?=
 =?us-ascii?Q?BhXV4eKaZUxBl4Kbz0Ji/cb1P9aXbi8GRKg6c4iXId1cdeWTjvjRRdq19sKz?=
 =?us-ascii?Q?A22eMCarU3BFSywCVJQ0HiDeKKeIh8F6k/Hsw5O4eLnPWSGgnf2lT3xXxuVa?=
 =?us-ascii?Q?R+k/XhgytgnwefrfCQOawp/DBpEMUHBHEtVbs7k8mxqEK4ydcd+3D2K7YAPV?=
 =?us-ascii?Q?VR/MjPcmxuARg+/8/359pA2qVlarXYZuB4SOLWDh4nCovBeFHq7zQ9zjLUO2?=
 =?us-ascii?Q?bgoBNDn8icFILrl1hm2pQNwEeUkk9inX4gVUfgxM/frt/hU2R20zvj/v7Di9?=
 =?us-ascii?Q?9pFnm1DWM7wJguLTphYlmRHG+4uYuDYwV9QMdO8R5Tu+uru4ZLBZT+49JHjj?=
 =?us-ascii?Q?TdaWxR2Eo40n0xxej2dTSGz7xg9dW+hPIsxT2opuRLZoM8akxqxynJxejDy8?=
 =?us-ascii?Q?YCHmm24QVuIDMxygb6W5SUiP8jb+n3JS0X2KeVzyVgvopyzrdUFgrIMJuKbg?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678115be-cf0c-4b36-4ff9-08dce2279403
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 14:44:39.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 784Nh3+HC7mThMODXpZqjFC6MK739TLlHaZ2YDe4Aqidp+4KdCmubfz6ei0FJkZ3zYsFkaMHZ09Y+/HkpEdK5dzSh0/7u/4KLNrZw8lmmWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Oct 2024 14:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16946

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, October 1, 2024 3:38 PM
> Subject: Re: [cip-dev] Backporting query
>=20
> Hi!
>=20
> > RZ/G2UL display support patches are now in linux-rc1 [1].
> >
> > Previously as CIP policy, we are not allowed to backport anything from
> > linux next, but ok to backport from rc series.
> >
> > Is any CIP policy is changed for back porting recently? If yes, for
> > new feature/device support patches like [1], without any fixes tag or d=
ependencies, how many rc
> cycles we need to wait?
> >
>=20
> I don't believe we have strict/firm policies here. It really depends on m=
any factors. If you have 3-
> line patch that enables driver on newer hardware, we can likely take it d=
irectly. If you have 3000-
> line beast that includes changes to mm/slab.c, well, that's different :-)=
.

That make sense.
>=20
> If the patches are very simple, very safe and well tested, feel free to s=
end them directly.

OK. Thanks for clarification.

Cheers,
Biju



