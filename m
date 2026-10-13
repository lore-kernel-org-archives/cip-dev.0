Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC07CC6B03
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 05:05:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.625.1791867916078415862
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2026 22:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=eEyJLgIF;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1791867911;x=1793077511;bh=k5f2mBco6/cyTwCgX1L54826kG4DrlDFrGFXK
	eAVt+o=;b=eEyJLgIFhurhBSywUngWhX7xsFTsG0LjZouC2Ygv7nNFGSZC3janbs2s/kEukCyDRdH
	lWZIGfA3x6FcXDXUxFpdy3g3Qg2Ht9w7Uq6Kl62ib0ndpFvbaUm02vBPw9eIjihl3TYHl9onBZYBu
	N2QHnlkNKr9ylKHrk1ZgRrGWTHwWiI0MZpB00xQ2hnAIpeJLPSxKUw8ENSR3OkzN93GgPXS3bLHk+
	FevcXQuUCBgnNDL2zgv3VCt3No7urJd9daJHtSx98YEXWUSsFuB2K5xo7CUwMD2YlEkFANopvNmmF
	YD9SWluwxCkFwee/0ssK77th8uWA4wm35dddmK8B2YBg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69D55Agf2009268; Tue, 13 Oct 2026 14:05:11 +0900
X-Iguazu-Qid: 2yAaMsnyJxibiIqnfJ
X-Iguazu-QSIG: v=2; s=1; t=1791867910; q=2yAaMsnyJxibiIqnfJ; m=tGl0E+OfHt3wcB+MAfKe1Gppyv1IPIvn3JQhTfy39ys=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j3j2F5bNzzyPQ; Tue, 13 Oct 2026 14:05:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJX9hl2/znZ8onIrkpoL0grRdIWHbcGGaY4oKPElUtZKnFkiO7vqhtNrt/ijBnkm7JxulLQFl1ac3TADbtqnh4GXHZv/Vq3/mmOhkzkAUnw2ICechuM7wVevaUjhYIKNko3/78SwiQhsOk7VtvNbhFTckLmsYbVJFHNyjxEndIvCk0UIM+leOmIGDyND1q9TSFq/eYXeXf4D4rojLhXSmQt/TF5K15a54GrpIJ54/+0fdUCJI320DGICoSX81bDeCh1W7/T4baCk75Ydq6RrEkonI/RXbnFp8WyNeQqh9jvgvb0LDO1nQrxZIq6aAL6iBFsInqwpfoLhyEdJ8giwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsbao1ykXO/crcK8041Qs17HDZe2XbYQwFye5zm3zDM=;
 b=obABA+rYSoLqvWZvo9Y2T3lYPwLZ5P7yYAA7yViG1VhSVtthsEaavxyHqBIdY/Llkdu2BXZK4IpL/RjFFzkiY191VMM8GS7aAKrXFw4LNfsIVHX0TOFvDtgdiEt+ryIrXgE74VNTJX9+XykUB2g7Kb775oe63soHsM1I7KF4exqTGxs6gPlej2p5URocsqzeM/iWkXUFU98pGjcE9WbSZdqwMeB4/rC8Bhb7KEQ5kDBcMIpyljBuOEKXIQ61rbMstx4owJtUMYMJ8UqFVXn6XSe+ZUsvx9+27h4iMOIX4oFOMl+zzFHabJ8vFfArr6EmejVx89wJJlcPSMwOMwLJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] irqchip/renesas-rzg2l: Fix loss of interrupt
Thread-Topic: [PATCH 5.10.y-cip] irqchip/renesas-rzg2l: Fix loss of interrupt
Thread-Index: AQHdUmy2QnjJ1RuMtk2Obzb7MWXo77bqOfuAgBDBziA=
Date: Tue, 13 Oct 2026 05:05:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB148081D0CE32FE137C9BCDB8ECD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <20261002125054.360202-1-biju.das.jz@bp.renesas.com>
 <ar-tTUo5zWBE1kMg@duo.ucw.cz>
In-Reply-To: <ar-tTUo5zWBE1kMg@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|OS3PR01MB7261:EE_
x-ms-office365-filtering-correlation-id: 933e211e-6cdf-49d9-93eb-08df28e78d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 
 aBijaYdI3pcdAj6fTvyd9k9xDVo1+pmWTXSsSnR7yMm8/eW/8xxKpuovd+p3Ut4KtFWRHb0W24hQk9xWkiKhuWGXwCDIkTVEicysDgAf3ODV4nieoDRAjyYNt0GyBKXfGOuV5WU0qncLMQGOCLTwMNx1oBuYpWKuadRU6Abpbikr5ZJfwBVpUGOceG8ZCtuCM26/uXOo5PFnVRA2xRAWGwmvfI4zkCF1jC42Lm4n6d7jEQPjHUFZAu3PD/p8BiPQbqVif2snT4mfWNYv8D3P+ur0okZ+WW4nEK1R431mbCMaHIC1FMucC0wEV1tYIaXa6GZUvGnU1hCjWVOauQ4E6qh9gowPEcSKtwjY2vHGqj0vaypvmAr16f+QTohwyYeloFeYLAnTdMj0cPMQsKH+JCyrtZcE8adAFzVAxrdAA83nHhRVzZ3L5oHo8559636gW5KOwO62zzlzi+32SFslaE5yts7g6WJcab3bzxJut9FxgawmS6PMkTAoCxxwhNfUEXFMmsX3V66vqLXzrKN9Xp0qIa5k5loH+o/EUJwul9NQkqPl7l1ptrjIKUDcVK3Dd6DPb5kyndSudazkNfVQW5IyfjrsCVJEMoJZLbBpv2aUMqAvvnJ7kaWr4khJFogf/PhYCa/yhZfOjQbpUkMrCYbsVm6uZeL4K4fN2Wh+HXXCU03T6/kS2q001QbKxbXGQ3pMNBSra1NDVViHneXwZih2ZZEMja0hzggzwvzG9kw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bEJQK3U4L1Zxa1RMdjRyNmJWUDlGcnQ4T0NKMEpLUWhxeTV6THdwTEpV?=
 =?iso-2022-jp?B?dE83RC9QVlVKbTNaejBCWWphNWpNNkx2OVBSYkxmT0ZNWWloaFJZOWIw?=
 =?iso-2022-jp?B?cUk1Q0lzSllEM2JqQjNmNVA0TU53QWlYdXdNN3VwNTVDUlk3OGx6d0RK?=
 =?iso-2022-jp?B?VWV1VzBhNWErREM0MzhtcFYyVndqZ2RHV3pJZm1KQmZzUjMzWXRhQWc5?=
 =?iso-2022-jp?B?SXhQS1B2SFBxY1RBcWNSNUFKT0RaTnBMdkpmNWFHQk1IWTFwTWdyWUVY?=
 =?iso-2022-jp?B?c2UweWFEQXVQMmZwRkIwemVUK2szYm11SXAzUUZRNEtGcGFobGFGQ0Ir?=
 =?iso-2022-jp?B?OEVMSjVBNVNVbzlULy9RMmdzWTZyQ2V3YytISWd0Rk82Mjl6ZnRnSkxZ?=
 =?iso-2022-jp?B?K1VQY1drNkJ0cmpUQ1VqemRpd2ZpWWJ2Tm1KRS9xdVk5Y0p0OWVhazJV?=
 =?iso-2022-jp?B?SUp3T3JydlRvZVcrQTAwbVVRajV4U0Y4Qk1CTmdkYUtaWkhYdmNrbGdE?=
 =?iso-2022-jp?B?MzF2QlFITnVsNndIeDR2Rk9qNllwOWZGSnlkbVlkZ2tFOEpJYXg0WVoy?=
 =?iso-2022-jp?B?bkFZWUg4MCtoM3NsTVRHbjlWY3hFNTFrRmJUS3hvT2tKcUNQNXdvbHFY?=
 =?iso-2022-jp?B?cDJhK1JJS2hDTTdocmRWZEFoYlNva1ZDekdTZG9nTkg1NGFBUWl1Mis0?=
 =?iso-2022-jp?B?dGRCeTFTNHMwZVd6SGRUdTdwN05oZVVZRjlnV2RTMUhES0NvTUk0Ni9R?=
 =?iso-2022-jp?B?UVV2d0tXRGFyZmRtU0h0RHI1aTI5N0dRcWI1QlRqdXVvcFFjUFFIcjFn?=
 =?iso-2022-jp?B?TU04NlhlOWJGZWx6QmJPcEtKcW1iaHd1Umx2cUpTTS9NT1VtbHZSelMy?=
 =?iso-2022-jp?B?TjhDOEl0VURXUjRtdTlkbGxtRVlwcVBIdEVTdWJYZlJjOE5maDQveThP?=
 =?iso-2022-jp?B?SVpNbDJtYnZXMXBsZmM1QjIydmpOeVJET3JnTk1MR0ZLeTd0eC9DSzY2?=
 =?iso-2022-jp?B?UFBvdUpsemthVjc0SWY3c29kWHdabzNiZmVTZzlwQk9OVlBBa0MyZFFs?=
 =?iso-2022-jp?B?MGZGYUVHODQ2d2FCbXhVWWVPNDk3b2FLQlByV3JsNG9yWEp5L2hmSnp3?=
 =?iso-2022-jp?B?WVQzMUorc0o4MDlhTWp2M24xQWFDVHJQUWFLcHhYK1RYNExxbkk5SndX?=
 =?iso-2022-jp?B?NE52emZkbTFFakR2NFU1aHRXejVTNHREQWVvaFY0UnNzdTVuM2dQby94?=
 =?iso-2022-jp?B?VEc5S3hwZHZIU3J1cVRIWDJMZTRCczRrd1BFRGJYTFQxK0x4TUNlVHFt?=
 =?iso-2022-jp?B?UjM2ZVVpQU5IZU0rK3ZXcVJWVnRRTDM0bXc0ZDltdWlieXBJWjVLSFBU?=
 =?iso-2022-jp?B?d0pIQUJFUnk4cDdmajhnYXpjVGY3S1hJaGM5eXVWNGk0VUtNL3owSnFW?=
 =?iso-2022-jp?B?b3NSL091TEh1TWpUdXZBbjB6Rm1mOCtOeFRhaWRiOUI0REpOSnNzYk9p?=
 =?iso-2022-jp?B?N3J6bkJaelZGaUxIelZxWVVUNmcvQ3U1Ly9ZZlR3Si9YTmljZmhta3g4?=
 =?iso-2022-jp?B?YVIzVEVvejVHZ0dxK1JYTnZXZGRSTERzZ0dYRmFneVRjVVBMdDFOSU4w?=
 =?iso-2022-jp?B?MHl6cDNDTHJSTVVBcnJZSENRT09oN1I2ZytuRkY3eGJSNGh0TW9VdXRU?=
 =?iso-2022-jp?B?UEVFSXB2c0ZEZW5Cb3dNQzFVem5PQU1lVEJoSXVUNzQ0ZktNeUpER1RO?=
 =?iso-2022-jp?B?K2tOYXN1V1hub05hTjh1V0hjUEx3OXA5OG4wYmcyRW9zV3Y2eis5SlpF?=
 =?iso-2022-jp?B?NW1yNXlXMFlyMnkxZ0VSNzUvYzluekpmTUE2NmFhU09hdS9KcjVjeGVE?=
 =?iso-2022-jp?B?amNUVGphUkV5OStBbFBIUTNCT3M5TXM2enJ6NXF0MnpvbHpZV0ViNUlG?=
 =?iso-2022-jp?B?TytOY091Nm44dEUyTHpNbmlZeGM5ai9iZk55Z3lrTmoyT1dwUklmdDg5?=
 =?iso-2022-jp?B?Z0pDRWJ2azRoMWdPS1k3ZDMwK01nZ1RFRjRBZENpRXozMFl2TTBsNi95?=
 =?iso-2022-jp?B?ZDA1b3J5QWh4SHU0cG81VFo5N2pBZnYxa0lET1A5RFNOR3FBVGk0azRJ?=
 =?iso-2022-jp?B?VkFiZWtsQjdyMHdxNW9CeHRiTG92b3FLVDE3VFNQYngvaU9XOVBvQnlW?=
 =?iso-2022-jp?B?cVUzcldtSk96Zk5TaEg2a09BeXA2WG1mSjdwWmZpR0VkWDl6UlkycjZH?=
 =?iso-2022-jp?B?ZDFVa2JIdktYTG1nMG8xeWE1UzNwbmQ0TXdYclFHaFdUcFN0S05URi9W?=
 =?iso-2022-jp?B?U0dId3ZuSXE4eUhmeFFKUW5IQW5pZ0pYdGo0SlFMaExUd3piVHBPQXM0?=
 =?iso-2022-jp?B?cCsvSkN4VC8zamdMS0t2WVI2eEhMSVFkQnlpdXhSdXRHNUIyb3RXS3lv?=
 =?iso-2022-jp?B?NWRXY2tpNEJKSm95bk1TVHVFREhTaWFreWJmbEN5cnB1em1heWdwalpj?=
 =?iso-2022-jp?B?QkxZN2l0cXFibncwcGs2VmZid2tCT3Y5dU51Sm1pU09keXhzZ3dUZzVL?=
 =?iso-2022-jp?B?UkxaOWVsOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	zHbm1fnvOnDaxsjEXu5D53Me4H+S2IElo7c6UlB4HyMPz5KKaXq2gCsFUvoH9ndHd7ftlK8Vb3fc9o3/pc13WvBPo0mKbwK3xawP7MfZFCtfYs0cz8ixLkI8pq4zq+EiMH3MkSjZvhlMYEUb2Rrb6hQbQEd4/ERidW181twD/RhIwpz7EyFf/708fdhETYvSzbpLk3atSp4D+IZnWXTWqebvGUsU44zcFIYL0jkAxIkq0AlAHOacPK9QCYh1ropXH0SlqQAxjGo3zYZ4Wnd6xVSkW0fclOaBO+NW1llVWVXttNJ2lqs8wUaxAFMnqW2xPTC+1kZz0PpFj4wVa+JKoA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e211e-6cdf-49d9-93eb-08df28e78d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 05:05:07.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6R8Y1RrtwugrsbWndb2jezFGtgVWtpqb5AvTgQ8Erjz+sbVemp24Y+7iSu2YyBGhTsf6T7r/IXB0ikdYnAU2U18co2cfZZSIa8Hl8VDA2mbLsyqV3TMWlXEbafyGytQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 05:05:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24448

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, October 2, 2026 10:11 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] irqchip/renesas-rzg2l: Fix loss of interr=
upt
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > [ Upstream commit 50b10bd0c2d721ad38abd1abe3acdefb6caa0944 ]
> >
> > rzg2l_clear_irq_int() and rzg2l_clear_tint_int() perform a
> > read-modify-write on the ISCR/TSCR status registers to clear the bit
> > for the interrupt just handled. Since these registers are
> > write-0-to-clear per bit, this is racy:
> >
> > If another interrupt's status bit gets set between the read and the
> > write, that bit is written back as 0 by the software-constructed
> > value, clearing an interrupt that hasn't been serviced yet and losing i=
t.
> >
> > This can be reproduced by triggering multiple interrupts at once, e.g.:
> >
> >   gpioset -c gpiochip0 355=3D0 353=3D0 328=3D0 352=3D0
> >
> > Fix this by writing back only the bit being cleared, with all other
> > bits set to 1, instead of read-modify-writing the whole register.
> > Since 1-bits are left unchanged by hardware, concurrently-set status
> > bits for other interrupts are preserved.
>=20
> Looks good to me. drivers/irqchip/irq-renesas-rzg2l.c does not exist in v=
5.10,
> so -stable can't pick this up for us.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply this if it passes testing and there are no other comments.
>=20
Looks good to me too.
I applied and pushed with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


