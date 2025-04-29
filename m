Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07539C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:51:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.7])
 by mx.groups.io with SMTP id smtpd.web10.13878.1745916691218547598
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 01:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=iJZOgnyq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.7, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujQoKSwa1S+vXanO8Vq/GBSNJX99bDwYlJ0naNOvxWgLlNSI5YbP5LBErUKtYYMaUkwoPxOO6Wt2S2qhpzhpy4XaMOEa0R1RWqJ8ujGhpbQnwLvZm4PSylgrUyGBNDMbJA3h8uH4iQxUaNEL9SetuEBZtH0ne1n9++1F7RlUP66lBV4JLX2ch6fDpBZxjLcAQc5IUzwomvGqvtnGj78I6Cx5nu7SvCGS+8PlAnC4tCKTcXHIGT4F+6V9KhmJ3GcIu2rOhAq7NB8XX6gXFxiE25r5n41fOjcXoJIscGRKzvYA0bxwVBXo5GiMsYV1HWCDlWVKQpf4gFhoF3WkRD1acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REx+SSyYRoMKpddfexFmiWDqZOb+QZsMmLeQ5ceLY30=;
 b=m40C3hxsodEPv8AmBDwFoGkqHIQS0JoVFM/Eoj4A9z6eEcs1GwP5ZVEShBE4xMq07FCB2f0pRECt6IRQCqAthcqCoAp+2Ohyy54KG5/wBV06BqO4ZYt4xdk3t7z0vNOQeOziHt3ihBDcT+azUNJU+3u0YG/st0jLz6g0jVwd21o5YGnMPJeA2MyVdFjVzaOG0aeNlKNHcw+qltHoZlpea/93hSCPIZcCwrw7CsQoejOlmwm/Yjw6fa4PqDmgX/8DXuFPFU4Ru7QjBasLLr4Foe1N2Mb3xG3lKEFGRJ2AHbPpqVxMgzBuFpHyKfrH3CrBfsYHbH/Qcxi2TzJJ+SiJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REx+SSyYRoMKpddfexFmiWDqZOb+QZsMmLeQ5ceLY30=;
 b=iJZOgnyq+6943PN/W/thVx65xX+rZ/eHFAjHWYh7135nBiohU7v2EUIImy8jjt1oOkczH7nMbHofqr0E6BPK1eEmeXT5y10MZvfQNmY79S2vezv2amPlnYIJHex9Wk0X23MBD+fRhEfknCmyI/Qb5aWLp1z/oXWWILzameFJGFY=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by OS7PR01MB11517.jpnprd01.prod.outlook.com (2603:1096:604:245::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 08:51:22 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::39ac:b8e5:61e:8037%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 08:51:21 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for Renesas
 RZ/V2H(SoC) and EVK
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
 Renesas RZ/V2H(SoC) and EVK
Thread-Index: AQHbuN+zGFMahQZhyUW9cHBQ9xk/2bO6Vd0A
Date: Tue, 29 Apr 2025 08:51:21 +0000
Message-ID: 
 <TYYPR01MB70247182B6F080BE5EBE5E4FAA802@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aBCMB/ipNRSXCtPX@duo.ucw.cz>
In-Reply-To: <aBCMB/ipNRSXCtPX@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB7024:EE_|OS7PR01MB11517:EE_
x-ms-office365-filtering-correlation-id: b7ad2476-ca80-411b-0961-08dd86fb03d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gFAJ9Cu4tdaXWKP9zJiP0T9bI3xEG4INhUkL6dA1OFAHs6d50prWWRgP6Co8?=
 =?us-ascii?Q?0ErXeT2S9uORkyqGwb1LKQBT5muwnB+tmjFDXHMzy2ggDAqTUa7irrixK30d?=
 =?us-ascii?Q?K+VVbSdkmTXu61WU+FVQXtFtCsTEOaTpMoF1sU5YKK3u5Qea7q0Igt+v2QUJ?=
 =?us-ascii?Q?9XNsLZVCJbzKJ3DXEkB4ppapm2smcqwF3UmW/1QhXdjtVsemwa90gfRuYEKy?=
 =?us-ascii?Q?v+A10RNf6DsKh7NvKnPpkkyRFTmK3BmbO+Tpq1832zeO6uHL3VMq7KQ+7SeV?=
 =?us-ascii?Q?/JxQFXZZqEPjfCpoqU2qd6b4Rpp6aopOHxuZe+ICl4tuTV157m7JT2wGWajx?=
 =?us-ascii?Q?YaOk0OOSXG1SZSLtjRwKVoGviV2wFL0b0Zl+bhc6XZhJY0euywbztQSAThTh?=
 =?us-ascii?Q?pnM5fWWfVlTJQckxwlCCFnzAaZOA4fLRcvMNBQOGaq3Y8zoR8MNONci7U8EG?=
 =?us-ascii?Q?ouu/BWluy9Iw0YzCfXuTyamHpQYdpZwkEfzKVM1YOQ6XOksCBpIMhZ+Q14MR?=
 =?us-ascii?Q?auszUAZjXzcDE6Gtx9pLVlL45nXfLuxTQ01eCzAqcltblXdarDpPdIyTcxGV?=
 =?us-ascii?Q?A6hKFOh9PTV4pJrCp7/fKBKWhK0TpIMe8sV1DCRD/iWY7c3HuGky59O0EzQ9?=
 =?us-ascii?Q?xX/GKecT0RDdHIleLHnJ/mf3vIzp0h8mk5QAfOnPD+sOFwnzZ25Xz/gp1gpz?=
 =?us-ascii?Q?pi0VWGcpkmvofX+8s48YYjcD5F0h1yjGj8WE3oygmCtajQ/02m34dPkpGBZP?=
 =?us-ascii?Q?eale3JhV2IU9P27oF5G5W+K8iruhIaUjRc3PlPQhe/9j5h5swBGcfFp8/KCz?=
 =?us-ascii?Q?gt7Bb2g9i5/D2GIgOb5Ly3P/uvHlxAUQbnaO9yokBCwt5Ki2LLqieINtTT3/?=
 =?us-ascii?Q?82Sal7CS6uh4UZ/kezUOw41es9VvukRIGzDE67WKBXXy8XOf4TbQheFPumOD?=
 =?us-ascii?Q?3n/IqFn2X9XrO0rXbMHU7rBLLRhmYeaYrWINJ/piQZLPiy9Oy2zXnNlQka2b?=
 =?us-ascii?Q?Res+lLLYtJBeJGFWyuNeURooxgdE3nw1/qPyHH3XuWBATDoxqD0iH1O6Mnbf?=
 =?us-ascii?Q?Sckpygx0pjLC8mf3T8AS20iVF7r8Ok9w/6AUHbd26BNn1S1e/mzFnI7DyZuj?=
 =?us-ascii?Q?eckybOWJXRtWmRjyxNkYb/fpc7hhoG2XhcvqltMutV6wYd8iZsTMGzfBsim1?=
 =?us-ascii?Q?2WwQ5VNTJ0ZvbE+4l2dUgURFjwfVMg4mT5SfPBM6uoU1SDEFg8+sEImm8T2e?=
 =?us-ascii?Q?pdytbcWNG68bYhK9AJR6qSZ0oupKpGr071RLcXA6ckMHCo2pXYfqegxQt/uV?=
 =?us-ascii?Q?rOJ/I+GzWGZ+eGRYco13n33iYzJPSPY9oA3yN7V0C3xMdaxIbc0+GyUR1icY?=
 =?us-ascii?Q?vIgX+hTCqaMJ28DO8EHYF7VXT4dpnAH1RfbPr5mV0BAvLmkVal9Fnf20o+gP?=
 =?us-ascii?Q?9p9MRkCXA1e76oFLh/YGIhFzcf90o7QLqiL+MqqI1+sc4Wg3n7+jB5E7maCd?=
 =?us-ascii?Q?DAjqdj1dyfJ86mw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WfP1mtrZW7iJ13wHqcePHRjXaBfSofAAaU8Wbb0ewxjdQtQ8m3wiBKKunEK2?=
 =?us-ascii?Q?yNpKMob/7pXLeLSsigQ/WcsQjDYPR3jsCStB2Kr9221yeBjM5MtTTPsr+YG0?=
 =?us-ascii?Q?1j9d60ttt74r3Y6/NjIwCFSc93R4ktWOni02a/cT6uCq5F89hcSIZCDqgPQh?=
 =?us-ascii?Q?lFos/QfIhp151fCAX/dIaC5ACnArE2N0ui3ZC2J30KZnKZlIqNjFdmjr2+2t?=
 =?us-ascii?Q?gvKfiaTJzq08Z4kffMNOwv2Is7jqTnw3aD3keaeUd3CG6p+GOtrvSXWOwWm9?=
 =?us-ascii?Q?6F5kgMfpGC11oEU0XKxi7m+A3zZIhYSOtUpT20tOVVfWcVhSJyvmHbsy9H23?=
 =?us-ascii?Q?EH1GD6B82gq97kQ5DdIKZaURW66/SaBXR346comVmNyOl8jpfFAIbivZQaZo?=
 =?us-ascii?Q?1fDZjosx2NVz+Lz787P3QJreRF/4PE/TSeRJbQGGE9GF/DDARLj//XSAertX?=
 =?us-ascii?Q?i/f0z/TaPMHGHYO2BZLqs4ZwgqPBqid7RdTpiHxJuouBmDU5R3KzxE4X/Y4J?=
 =?us-ascii?Q?NSNkLN8sJJqhABVyqkfpDlCN8T3XBFUiNOhP6jU4UB8eDix+WVgMmw2sn2F3?=
 =?us-ascii?Q?AcsdAa5KFEEtBsAzIgVJlJInSTpYqcVmNSQ7n4UcLftZ7/vi2XW3z7LR8b8G?=
 =?us-ascii?Q?4yqeoJwyAwjOhBDKn+2DvGH+VWAHHyhuf9TVe+T6fAhArzKOBg49XpqYrB5f?=
 =?us-ascii?Q?TlRoLTvl7TmdC84zWC4hy6LpteV33xOv8OUHIcTnlJ/EFjnkeGutmhPqOiRm?=
 =?us-ascii?Q?iY4TV1I/JsQuce0I0sVHxItbSPFh6UV7HIdz6BSqfuQKJgem9iEHJE5YjouG?=
 =?us-ascii?Q?QC5nHZ5Hd04fb8O71R7CLEQCAEq9YloQG4x2N3AY5DPViKnkBU4j4Cg3rlJt?=
 =?us-ascii?Q?NFvQR208FCI1xc2ciXLWMfwZc5rKAOisW8jKwebPLafZDTiDO86/H4vND4YV?=
 =?us-ascii?Q?xiDj9/60vD5i/Xd6e1k8NeCWoASWiizGdsIEb+WyLcdoD+3k5HSAAJmCJ3Pq?=
 =?us-ascii?Q?106LgRcX5+eE2f8djSiMMAXSCMNGQ1YN0Uo+d7nQlM+j2N/lunNRlyVBIHep?=
 =?us-ascii?Q?5Taj/anTgiumk5eGPQHYb3XPQ33CvRGl0aYDewtd9SkHUCcyPSsw4HpzYmq2?=
 =?us-ascii?Q?BiCrQVTj9U5rvzqYECLi/QgfNLbKZbmyEmtggrUE6KJabIXPGfPVTaPJtpCu?=
 =?us-ascii?Q?xmrp2hdFOv7L5J9GPVTkedc8rxRffDlur2A2Nd+04ROZHc8B45ZNzF8l4NLn?=
 =?us-ascii?Q?HZnnlpRWAHYZP0iGSFSrnyDCSDm5mTzIIFHNzWyrLbIuz8qi7Se6w7uoj9p6?=
 =?us-ascii?Q?6NkcG2Ied2Tff7stPM8T8RxpgwTso6xZ8czAu9iK7RmmXLbawWCI8KqpqTKh?=
 =?us-ascii?Q?yQlwPrMi6kMtdxber4nVsppVWaep1+WS4DOUfJdr3KO4yMrxwPmPdK3dqhqD?=
 =?us-ascii?Q?01dZjnJBjrsMFBmBz7NRz73Sv/7CgUy68p7vreAb0/O3394O4WHwyeNyUCU1?=
 =?us-ascii?Q?qupAPcEpGf++VZmgn1HxAiPdVa6uRQcsCEj0o8NtaRThobEbaRKkPj80pBQE?=
 =?us-ascii?Q?cxk9otUqbLsH2PWLSO2SYmE8P/jZSZ/a7MSpKO9oaQQX4Ua2Uu7aQU8jrXfG?=
 =?us-ascii?Q?G+3aThACohVljhP4rl3pP70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ad2476-ca80-411b-0961-08dd86fb03d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 08:51:21.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDqPln5fozGkG3GtLZoWOTy656qVYXNm1X9eV/6sqpXIQFpt7WOLorLkrc3p7u6HG4rr73KNU3Y/umcnHgAuaB0Td+o2y1IICT8iwfFGR3lKGM7dcqZH76uJyytXQaqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 08:51:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18708

Hi,

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
> Renesas RZ/V2H(SoC) and EVK
>=20
> Hi!
> >
> > This patch series aims to add initial support for Renesas
> > RZ/V2H(P) SoC. With the initial patches in, the EVK platform can boot
> > up with the below features enabled.
> > - EXT CLKs
> > - 4X CA55
> > - SCIF
> > - PFC
> > - CPG
> > - SYS
> > - GIC
> > - ARMv8 Timer
> > - SDHI
> > - I2C
> > - OSTM
>=20
> Thank you, applied.
>
Thank you.

Cheers,
Prabhakar

