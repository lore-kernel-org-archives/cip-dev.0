Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A2E77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:12 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.web11.125724.1734597369044017124
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 00:36:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=jOaHbCUr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPEF62liNXGBalzjjfie+yAO/02J4IlHwkl/9DWjO1n/U4JRH7/Ta+ZuZkXvsZpR2OXSmZbaB0G5Hw2+IOIgAPOB1dkSqf3i1N96Yke5zQPsTrXaLGJJrBNJOxD2k4tQa2KVNqCyaIrIne7LFYHu6Qg+kSk5hw6CQAGFvr5WeArYVjJ/77TVGNjAYbSFw2bRUgET9l/bROApqGvKsfKfhFcH1+HtUxu4eANJSTMXNC0pHoEgArbSfUi4nIE4SS/zvGg7F70tSOCdl2vTa49Kn+KrTbEN6QLHYwe2nWZ6JNtYHKcqfaOyQy5sFYiIzmHCYSpCqHAn43YWfVahl/Wu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNzWMCXkxlOjTC8ulCaEhfA3a3fInjqpA+k9SJsEZaE=;
 b=JEqZjCxWUpiF8cEFmpGA33vhxJygVQgO0BRbIlW+zlwQFMqa/XJePgtNzRZXXIGpRzQESETO/t8KwyvJfCQ3BTUYC3BJJtWVKN3BF2qNZPpdukh5iOicl0qnsO7OeeVq4PHoo/NP/Yem7/STlwEK3yPLmBoXwvoVEdIEcSPWRQUn/vPCAhaE5BGydC9rF1t6wlbR3Ya6sApV2mH8Xue7DbDKCe16G1BAkFqQPGwxQgrJVaALYWNAiIyLF6KeZwrR/UgsZlJamVWL0xp8TPmP4d5rhPQEIrDIsmMKC59UXg6x5XoH6O8HC6oGtgxi3DrQFaPyTn+8BeopJ1cTUHeP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNzWMCXkxlOjTC8ulCaEhfA3a3fInjqpA+k9SJsEZaE=;
 b=jOaHbCUrsNggpcqer8rQuAeVgGaDoVZroAcUdxG7HGNziwjCUes0RefFRx9+ubDc1O800n+kvpEh3cvZxCoMpK5vDyLjiLVrC9Am8egoXk01MmsnHkm9wscIJxtjP7KmxJXEZvCe9v2LZlSQdSAiETMHp/GAZlOIMtvYKP4Ykwc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB10854.jpnprd01.prod.outlook.com (2603:1096:400:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 08:36:04 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 08:36:04 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV
 clk
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Thread-Index: AQHbS/isN1RpgMbtP0GwjyqLJDZ/ubLr2iTwgABXpYCAARerQA==
Date: Thu, 19 Dec 2024 08:36:03 +0000
Message-ID: 
 <OSZPR01MB701960E1742A56ED759CFB9DAA062@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <181032168C715C4E.8579@lists.cip-project.org>
 <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
In-Reply-To: <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB10854:EE_
x-ms-office365-filtering-correlation-id: 6465fffd-cab7-49a1-7d52-08dd20082cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?42ebCpwvvr+Lw2Th8cPA5s0paeurn/tJbM+idyMmERFli4qkLLFoph6sNr4l?=
 =?us-ascii?Q?hZhv9DzB5C5Ip985gGnXgHgRykROzekVfsXhkVq62JzLUaHdXk0rGbY67C1g?=
 =?us-ascii?Q?5WrAO7H/hNwzT3ZNwecU53uxo+X5yOdgBVnJubWiLp2G9N+Hjme1WXC1mdgX?=
 =?us-ascii?Q?sBl4StO3lYqGXk75HYZUK+McDtc0AjzQwbHptTqZFjRPFR25eYcIZydSiE4B?=
 =?us-ascii?Q?W18mwD8xI3rbfaXs9pyeFciYoWwzA/DtvfuU6UXce7UVzlyx31t6xanU2kfQ?=
 =?us-ascii?Q?STE7MmTJw8uXOHM76sT6fMW+2xwiGIGORN2EOqsUa7iaQ6tElVhUN/d/iJao?=
 =?us-ascii?Q?xW5TfUouWNm1q+bp8caKuraiZEW4bTGAslRKgnzrEga2ozcaw9D1LFlrRt08?=
 =?us-ascii?Q?v24iDf45d9vTMBNKaMOzWg6lKl1+18q9KI8VOzF4cp7hA71ygpfFrkQdNKc/?=
 =?us-ascii?Q?+kc6OK/RF3SfmTpH7HjXXb17rb4GfTPiJ1sUXvThUhpJITEBny17wtBswURz?=
 =?us-ascii?Q?Uv8nzsqr+/gzXaJOPBa/Un/AZ/dgIqyMEVSPC2FVvF9Vv41JaoFkb1+LuEwI?=
 =?us-ascii?Q?3OP+rFWq3gMdwqApEgdFLv+6dUg4lggAWr2RGxwGWn1kWvApounffbxBNakV?=
 =?us-ascii?Q?hfiPcMnpQ5XY9L6cbDrF9u69TRwybLlK0NEzUetTr9oC0Z3DiOCnOT7f/9wo?=
 =?us-ascii?Q?rOyXoAqFThVSd2l88QLrgnuACk/IDQbSKvA7f1cYQA/8RnYfcH2KCY3Q+GRd?=
 =?us-ascii?Q?XwLRudBTnjtiW+7lhZVtcOVw72OJNbT6WHJE9BdcGZkevFCDDpYsuX7nlag/?=
 =?us-ascii?Q?FqglxU8xX3xI5aiEK6e25dn02lzauKlutg4sWt6vH2G50tMl7vQOdIN/maG8?=
 =?us-ascii?Q?M1x/5j6dwid0KB55GjabhP/vOfyAIWXG4k0PiZk9PBJMRZa29IYP7qpIf/eO?=
 =?us-ascii?Q?+kMzGL4N4QhbOrnl4FFCPzePtNSx9UYeeMdf73ulrCUGGPfOmcIHgjmshrWR?=
 =?us-ascii?Q?/SwmsZIVDE/lr+8VPks65tXdT4a9PFFyfD//I2oh8rYMc3jk8GseoDZXP0H3?=
 =?us-ascii?Q?PlG/yo/1tHSlD36QwoJXeZbXShJDb7NJ28aVC5mdaFdP9uMyPBFKtaWJGqGO?=
 =?us-ascii?Q?MOp7bc2AWxWp6AihxTnnu/oKraCtTiTJQsLuTNRZCmJ6/liRUNshL5UtDDNW?=
 =?us-ascii?Q?cTtNk4pxc2aNFiMk1oGHs9apTq8OQrf8NBB3IH+8ZyrBmj1+1Oj4lqz8A8Aw?=
 =?us-ascii?Q?1Grw4QdvD6W6G9B65FVarW/QNXr+2wesNwr9Lyo+JKQmJOSjtmSEjDZG9p4y?=
 =?us-ascii?Q?JJ5eCZu5ZWQ+ZWJLd+d29qCfU2nxV/ESDbFqG3ibM5qV1Thk8IdVLZ7pm+NS?=
 =?us-ascii?Q?U4wbfg9DF9wVsv0np4jvpvbNMHLyXKTLH77upia6KOdCcHmWeTcAf41gp+wt?=
 =?us-ascii?Q?z+i1F35CoVqEnNMLzS8Kl8aOhkGJZmoZ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?R4oNHj5nOnWgXFc27ExxD4WgpiZVCJxiBSUcheZXKjQjUdOpkaaqCB1lFfTd?=
 =?us-ascii?Q?c0OgNPQcigaMb7Ug3r55uDShqWaMeff7YqczHoJzdd98PTWqyTqmMgzJARBM?=
 =?us-ascii?Q?bTIK2rGNrzMP9SlSg7oCHa9CDv0od2WTgHqO7tQs8itfEJ0+VlbzWWHShaCD?=
 =?us-ascii?Q?2pZRPgsPBab7xdBKvtCee/v+33pun4iTutZVIBKwZ5XydKCxN8dRE6Dqm7NI?=
 =?us-ascii?Q?ZUit3FgbrzGL+pBu8X7/A9LStIgk9s6Z1VncPykWiBBwpzpfOTgDl3tjA01U?=
 =?us-ascii?Q?mp7BpmK3jeziEpItSxhLjOd++z7tAOdpGBsH+WyMBKTlVUjRtnLR9la+8WKV?=
 =?us-ascii?Q?vFJf64W0KI3vkOz8Drl3xvE/Ax4b00YjzlnrEp7A7ndJKMnih4VNePCQzxNZ?=
 =?us-ascii?Q?GAUqquT1KSX72k5CEljGk48kbcc1Rl4MBGmStzCqUeH2nbAt1jKvGCCj+SxX?=
 =?us-ascii?Q?bbroYoTRgBAyqp5xGFpsRTE1S+TyMOQJVEVLNnDVvqnoOUzhfHMlGqN5gvVI?=
 =?us-ascii?Q?gYbgJy9FEOO4Y69kjIHgtXA0pmFwFXYrsxfA/4mW9Bd170jc9mavlGwAUq3n?=
 =?us-ascii?Q?qQje6ifdtIzKSRgXcVZFMHuwdEwPRVgxCUPiUraP0L1viKzLlsM9DyyQ2q3p?=
 =?us-ascii?Q?nHPogTywJhlbULuEDMvIT0mOS8NNYDePu8SxaXIuoi/j8VKXjci3iqQ7LEgP?=
 =?us-ascii?Q?qXkp9URtext8Fplu4aul2o8gFamnI+md96fxcxbSpvAHDjEmgO+gpY3i5vpb?=
 =?us-ascii?Q?78Wf+s4XBfn/npUBxZgDCV4MREOjbAPXQu5ZbP7sjSEFTBLW+YKrIG/dU6uM?=
 =?us-ascii?Q?e8e2cjybKkIhFyOruRQ2e+3vm2wVRfd/mictmz08W8rGvmfd/xTJxP/Pwaif?=
 =?us-ascii?Q?WC1VjhU+9C4+efnDBFesuA/hAATQTNHt3PTQRacHnB7o+UVcn1P43EIlG7m1?=
 =?us-ascii?Q?HB6dT5CX7G3Bl1RQg6vv5ZMOaejXwji67B5SGZFtSThobDOiq3HuLerakFJ7?=
 =?us-ascii?Q?uJ3huOND4qNI3Ew5eSzReEJSHBKDl7N9w0F31N6adIGB5kmjiQqLtlJfvOiP?=
 =?us-ascii?Q?Ws7U6sl6EdtvbRTQzRy/RKgYfxQLTN4rC2kXiwAaE2Vhv/PfH5CkXco0a/mO?=
 =?us-ascii?Q?SeE9YgZsKS4tNoWW1nRloMPDa0y4mE5wJxxrPIMj4d9Z03d/xLDv4RKY+58q?=
 =?us-ascii?Q?l2mPY0coTQ10Cw/tBUD/lhs6u/ByzzdRZLP41bSwFmqMrxGR8PqB4T6+sDHx?=
 =?us-ascii?Q?Rpe63GNZPgeDXyCia/O6Zlkv+9i0bhzNyaTxNV2ejocUb3VtHd3xh6Btzu1h?=
 =?us-ascii?Q?RdldH7qiaZ0sMWXXJGyC+s8xSMd+05nS+IPFsz4iLHI41ZSNlIMsYIPBqRxV?=
 =?us-ascii?Q?1NVsdncONkuozJoCCu0KLevYRZrvVFRRHZQNb2zBndC30eYgQfFxOrTxWpmk?=
 =?us-ascii?Q?uSeeAqDFt5u5+Hp1RBa27A3ju58zMHLM9yGNC1AFUKC4FovzQpuZQpglqwOB?=
 =?us-ascii?Q?djKPkFWkO7Ojm6DVp2I27KfG2xyak7iyxyyOuRUi7rNTNyOFh3UoqtUO4CHf?=
 =?us-ascii?Q?JcxYoSSYJ9H8vmLmKnlBuO396N19SXfs+oy3rgVvQvIQWOBpnuI34dIPep/U?=
 =?us-ascii?Q?Qr8GjIRmPX4ZTVoXP5rEAHY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6465fffd-cab7-49a1-7d52-08dd20082cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 08:36:04.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9CH5Vj92DMAirE1ugVqirLkhAKhkSri6hFd7b0foSsqGt7tKOQWmCoNoHtRDCjwSs3ynZJ8lo65UZB8iTPYu7xYNPUex6FZdQZdDODhe6BN4XLbYn+u/R17ngGZPPj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 08:36:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17474

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 18 December 2024 15:53
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
> FOUTPOSTDIV clk
>=20
> Hi!
>=20
> > > While computing foutpostdiv_rate, the value of params->pl5_fracin is
> > > discarded, which results in the wrong refresh rate. Fix the formula
> > > for computing foutpostdiv_rate.
> > >
> > > Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk
> > > support")
> > > Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Link: https://lore.kernel.org/20241024134236.315289-1-
> > > biju.das.jz@bp.renesas.com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/clk/renesas/rzg2l-cpg.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > Gentle ping for review.
>=20
> Again, sorry for the delay. Should we have similar patch for 6.1? I can't
> seem to find that in my mailbox...
>=20
Thank you for the review. For 6.1 this patch should automatically land into=
 CIP
via stable due to fixes tag.

Cheers,
Prabhakar

