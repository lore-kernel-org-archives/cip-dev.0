Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13186CCFA07
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 09:30:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5716.1762335043965995066
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 01:30:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=laECTgFW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouslGjTwVgNPCEV8gKsF6zn+rkpBg8BZ8QCT5xZ6I0x9S0MiJmH/3U37ur+Jk9usFn4P7TPW4AsF0cxuAMh+PoIA1TQuZLTCzZlcGtoBFUgMO7UklUW74ICj4bw2iQ3QqH3Ei0lzt5+ZaxYzJjjxVvFedXra8If7iMUiIFxT+p7Ym8PPhuIzhkz3H6ffHTHR1KeraF1mGu4ZRIf6/Le3o8AB88YHUXjJ2lVWhbq01ysnHMDmzSCshZPIMSdyoKikPRHHFxZXH6OMIZEoHHX/tkQuoI4BUiNfFBS7imfDVn+tiY1sdE6Odjz9t9S2qxRZFUNBO/jyoRCPCx61VaE7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUCfNDFvUVqCzqemE5XMhmtL9zUIO5qbz5HNggkQ/r4=;
 b=cecrLI/X/95Jk++Mz0gzt6sfffSYXTt+0vFiSVq+Dku6tXZN332iap2eJEercZ2ge/tBY1SxuRvOBAV2w7qwnVjtU4r5z+yWDm5uNY9M8EfKSav84pjl/5+3/fB38DNMa/JWzuMtmpinBr3j4GsbPcXAki1TBxKE7dG9dfLjPj/ZeN6EWP/tiwDYaIQkahUpH56opunxzmplLmTJk23OHDtZqh5wLjEO3w9FUnVrbUM3FHGxa4I6aqiDyqVltVhKzq5jiiIy4Zi9/RxQSti4iP/CbmbC/akKw5XcMKUYiL+4uG0o2Rn7TiFbCmVpSkxLeSvgQ+Uj3HVcES4FQKPReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUCfNDFvUVqCzqemE5XMhmtL9zUIO5qbz5HNggkQ/r4=;
 b=laECTgFWmw2opKJ8/xMxwdPwwwomtI7s5tU+dnBnhB4s1ZWfmkRcOykxotpxubs/j4ZRM9HPRmSdhHydmW9O2lTQpchUxl+QPimIYJLMVk5JnskERsNHBU2KvdlmFAD4ZFMvOsWCH/z20uiDMHbDM6+Zf0b0+P7ol4z9ASSLDkU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10303.jpnprd01.prod.outlook.com (2603:1096:400:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 09:30:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 09:30:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@denx.de" <pavel@denx.de>, John Madieu
	<john.madieu.xa@bp.renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Thread-Index: AQHcTLZdLSJVgPZ0o0qXa05vWiqnyLTj0YIAgAAB01A=
Date: Wed, 5 Nov 2025 09:30:38 +0000
Message-ID: 
 <TY3PR01MB113467095AF7FBC653DD1A8C586C5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
In-Reply-To: <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10303:EE_
x-ms-office365-filtering-correlation-id: ff5b854d-1bba-44ac-a6f5-08de1c4dfb6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?iA7BkFh+8X3IVyWpXIYXC/MvTaJsUdj+o6X3J6ZHtrQExZR0Fc7AfgCQ+TVT?=
 =?us-ascii?Q?mTJAWhaYjAxajpWSc3mM3aa3Gmpe8QXwMW0PzkqyDWOV01+DGQp94jZMNGUa?=
 =?us-ascii?Q?wDPNru7I0cW/8kPQ/q5ilPUSYzEwk8y24w0RdamWnOqR6tgyAMqFkyLiw/+G?=
 =?us-ascii?Q?LCw3fft8FRcGa4M1CrbQeWQTHZCjmfoghtMCkFyOhEhgl5jlnyb6tkVsa72A?=
 =?us-ascii?Q?tYJTec+q4Hszj6k4RiovFSx3hfSRyuvNOmHOn3IpcEJGl/jLkeae43Yv0lMl?=
 =?us-ascii?Q?YSaN0uEEW/52W78SEYAMaZHE/EZbTrsmPCsUSo0eE3xJJ65D6rPj0/nDwUND?=
 =?us-ascii?Q?z416zR/U/eudXOJYc7PZ0PZiHBaur2N6rx/s+VSDGEDaxFVQsxFNnCLsWFqP?=
 =?us-ascii?Q?L1QujqLvI/iqas66WUov8GrPC8GYLW7b/OSkbp8Fp05jxaF6uhsa7wKWX32H?=
 =?us-ascii?Q?bUKKRP4/SczSmwYmeCnILAEZnVuEIAgynh6XZww3Z2Otch9FLYHNp3Ms/di3?=
 =?us-ascii?Q?+LODWqi+750Wg7u3nUZ+8jvw3ExVq8XotAvo9q0QkedZ2iFqCh3c9/m5S5oT?=
 =?us-ascii?Q?3or4gjTxi0Sl7mj+0kbLTFEP1+PIlvKWkU/NOVDaC3WD8mZf6eYIG0JEKBqA?=
 =?us-ascii?Q?Yn2ZQMspPknJdOEeuZz0Xa5oT13KRX24mkW+QgRTBz4TSkVKI3p5e3YjfpqC?=
 =?us-ascii?Q?1P1rv1EriPfIZU0EbkOirGON7cw4Xt1szavJsvqScNKDuZ0nMkhF6j5wyi6Z?=
 =?us-ascii?Q?WEDfngZwhDs5p8S6WvUaIGeuh7XjNsaqQwichHonrhTtROXFmWYO9xBE3F5M?=
 =?us-ascii?Q?KdvRTs+oEtR9ySaVAiD5lA+HQXazQ3Q/rtu3UetogkHb3W19K1huUhHwFClY?=
 =?us-ascii?Q?OtMWenk7klN1AuPXcHG1dvabSaGcjMEi+GF5Nt9WFSxJYgyJ5KzIB9LyZPoT?=
 =?us-ascii?Q?bSuVnZx+ljAuGX9ztqXjGRy+S6gAO4Lu4ECl+JAiqiWCaYqkZX0h70g4pv57?=
 =?us-ascii?Q?PDrgyR0zOfipTJRm8ZK9MTohUzvOXcS/SVQaCo41FxylboTXrEAhdj8FcZ23?=
 =?us-ascii?Q?MAYJaE56ouwqM4iZCjqnQQahwq/gPUaaKpYit6L/duo9PuXVFqmyEowdLGDK?=
 =?us-ascii?Q?bQSxcCgDqDkpe7eEz1KGCBuQi8w6lXIdMOxur+nrJneMf3+ONEiwSMXnEpHT?=
 =?us-ascii?Q?Tt3ALWb3H4c5ag/WDWINDVn8KH1rG7gBthV6PPVWKJd9e3z8rKomHIJ+w1Ll?=
 =?us-ascii?Q?cZ546Xi1uJXKCUZMAH5gFV8nTAMz1SzLp3NzIFDa5w2IIdWoYPPKj1vvXwIS?=
 =?us-ascii?Q?2lXsXyYQBF4ZZ/8NRgyz94+mzdGxKZBPNBRq5PUzRiEtOPOJKWX0/tE/A9ZQ?=
 =?us-ascii?Q?4gI8wjtHguRw6rMHLrSzOwME6FcdN6UkVMOjQ0E2eSlyFoTDqckwCC73Ya0/?=
 =?us-ascii?Q?X/FPQD4reH209vR4/DLhiyHOkxgmTTFzE+tJVYBZgukuhsAp/WbTIrf361L+?=
 =?us-ascii?Q?ezIZwivWL3VBw5RggjAFCkfe/lpdyCWWNiZA?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UAnPdrlKkPvGor0g72ZCeIWnjKvun66Migr0LunotonMxjw3UrQG0e8uu3dQ?=
 =?us-ascii?Q?sDQ5fGRtOZ0FUYLOlT8XxMfXF8DS/eS7kwtE4FijNXtqlhXG2RevmiSTCxaF?=
 =?us-ascii?Q?c2rLyZ/+VAGgebRORZei5tgJ6TXOLiCX5MrOY+636ia88MkekN13hPnpELw9?=
 =?us-ascii?Q?fbwCF8VvnyH3FOUotuFNV9mueJakzRL4esXyTvZLuM+fAe/XpTKEhMc2A3dp?=
 =?us-ascii?Q?aYeQtyz+0NWBDl1EL4dzhQZHQMPLTS2/zRjS6wwfIynPlooevvrg4Z1pB9kr?=
 =?us-ascii?Q?pMCMZ3WAqvN6ZBWLuAhtpFVm2FlhX9Qv4op3s7+L5N1pgO/7W5rhEt9iMXfG?=
 =?us-ascii?Q?uLnAaALaMxb154NyKi3ywNMkieC7QipEmSBK+AMRf0vyqdOiiEaUqEYxB5ig?=
 =?us-ascii?Q?B2szq/rGDhXfJDZPPPBebU9/xM6MVLQ9gOls5Z1dQK7wfJk7mMXebGVAktf7?=
 =?us-ascii?Q?ooR5WdefSH1f4+aFXi4gAb4eChaifx7jBcQfZQkZr6fAJqLkVhpqLGWMiDpA?=
 =?us-ascii?Q?fEFNyxYradUNs31RMKMoW0SMVRQuLYiFtTiJeGkgAhQlnmu2mQByKJC/JMkH?=
 =?us-ascii?Q?TrdnKoXNE91AyUgF3VTvCUOvwHFaX0/vJJHBfgd968hZFwZd3Vv5bNYZ4J4R?=
 =?us-ascii?Q?dZC6/oratPss2TI/9Smy5xesMYa2Asl+fi/IgGRvqZ6+AVnqoKyfuw3cYBDh?=
 =?us-ascii?Q?XKL82CZ7/jSV4lHFE1OM+Zn0Jmhu9edS+qhMeDndtOf1m4sjsJ1kEA3g53g/?=
 =?us-ascii?Q?YnwoWpBbC97p4vcxLIc/mvyMBWo0jPheZudN76q4feC233MViP9yTxi0dF8W?=
 =?us-ascii?Q?wmay1Y7/S60AhKOHt+VTaWiOk96mz+aQwF8Fb7xNzbcQ+QFEORfELDmSYO02?=
 =?us-ascii?Q?pJm2MI/pMQDTFFm3nz6tM4srGZtWRPToY7aXUtc8Zp+NQ6cesBvHQOs1qL32?=
 =?us-ascii?Q?WLkFW+lWxIyxtd+H3HM8d1u63izDtPAddsRdSxmNJxQ7oFWT7ZqggRF5Qc2Z?=
 =?us-ascii?Q?P6bxPL7GwdYHtzYRLT8WcXgIxT/xu3TRQ1+latksFOb1Wni+TR/BOXpaF99j?=
 =?us-ascii?Q?tAp6v6bQlK6zRxMr4U2mtfsHSjcl65qcsW5seF5B6Jsnv/ZcgpwxW7z55Vk1?=
 =?us-ascii?Q?3NUgL6Ox6QQQ9s49zMax5ycvC0WCRzgjPDU7elB9zK7kVDVx78KHz53wbBam?=
 =?us-ascii?Q?oVcmgSUA8P7z1OHleT7Z1H05rUUYLhMtGCD4cIIZgbzeQ1QIVmkYLWfDFseA?=
 =?us-ascii?Q?dJAdVCRrfiXUzG1fMfkr7m+XwL7dgiWkQLBDIG24KLq9RRIZdIQGlLt/1tEy?=
 =?us-ascii?Q?0AS127zEGFUSfAu9OpIap3fYCwIz0CM8Tb64n7VL0G0plvIB+NVBT9opzAYD?=
 =?us-ascii?Q?7z2bSYOKgqDnN4aCVAG+k4oDHmG6DF8937b/gnTOSf38yGr1pbZiVeo8jms2?=
 =?us-ascii?Q?lgPQO7//qd/EiprtczggxlQLmNpVR20RZg+kBxyrJa/ycCX6VWxD2R9QrTI5?=
 =?us-ascii?Q?NRUEx/1d5+qb3AOt5XLRWARVM08RRaHFtNgRBHJlYkLxFx8wEfNzJ7uwSdpu?=
 =?us-ascii?Q?Na5yWZM/NG5WUmyoQ6mcXg71t8/ctsXIlTJvK00us1v9uwRRPupq/k8SLTIb?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5b854d-1bba-44ac-a6f5-08de1c4dfb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 09:30:38.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgxiQC1yeCEQEPWPI9qqmDlxX6QQx7xbWyFFzAw0ksjru1de8MKAE4bJYf+S0RRfTbqygY4M4T7tWOsSFY3o1c6X68IAC0JBDPlzh3US+dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10303
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 09:30:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20358

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 05 November 2025 09:21
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
>=20
> Hi!
>=20
> > Add RZ/G3E GBETH support to cip-6.12. While at it, also backport
> > RZ/V2N Pinctrl and OEN dependencies.
>=20
> I agree that most of the issues are best solved in mainline and should no=
t block merge (provided this
> passes testing and there are no other comments).
>=20
> Please take a look at
>=20
> "[cip-dev] [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for..=
."
>=20
> It may make sense to put that one at end of series, and I can probably do=
 it while applying, but I'd
> like confirmation.

We planned to add RZ/V2N later on 6.1. To cleanly apply RZ/G3E pinctrl patc=
hes from mainline, we need
RZ/V2N pinctrl patches which depends on that config option for building it.

So, it makes sense to add Config option before RZ/V2N pinctrl patches, so t=
hat at least we can build it.


Cheers,
Biju

