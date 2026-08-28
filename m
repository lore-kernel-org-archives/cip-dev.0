Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7EAC61DC4
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 02:05:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.407.1787882740021592515
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 19:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=oacH3ij9;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1787882732;x=1789092332;bh=Z0/dRkD81kbYpsKY5PvKcoZaydNzGfX2hgiyY
	a1vU3Q=;b=oacH3ij99zAv/fwYRvRElqA+GQZrpTsFwZp7LE/g9UVG6UlOl/2RfMOYnZVBhOL6T5c
	0pgupUixEeIRf3+MmdElq3vbxQTKKMfyu6xbemm5sE3HR6Yua2FffINpKvePSrS4Eetr0XPtFk0qm
	27gdxocD1Ze9ByPGYCJJ0L6PTDTOlRT1XSirsls4YUm4qjcHRY1gWkZGh8x0KK6DNi/nKvqL0IFmY
	O/ZFtTXPYFCETmpdT/2fA7YHXnPUFKIGWoFFSIoxssRigZQHx4H64eB5RCqQzRdnoCz24MD9VU6lA
	VX6oinWFp7kNKc4nzHFH1fgAEm89jxAED3+1oec4tgTA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 67S25Vdi3127142; Fri, 28 Aug 2026 11:05:31 +0900
X-Iguazu-Qid: 2yAbeCtgx25iMwOzUg
X-Iguazu-QSIG: v=2; s=1; t=1787882731; q=2yAbeCtgx25iMwOzUg; m=6pH8pYe4+esn+0e29KnaP0NxUXhk0CzJvJLJWdUxrDU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hWMDB3RyYzyPQ; Fri, 28 Aug 2026 11:05:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNAwRmWEPRuyQZyA8U54IbpjbPWouI7wIn6jixyVfbMLLRnv13qo8FbVyxmnX1YIDmrtp3WJctLEKT+tdlyP/HNWT4eKivbsc/+4IxVpc8cRdVnxwyGQ1+EIHu3sHgLAMZ7CTqJqq9869u2LW8Ukur6p3fKS8Wg6NGxhMKNp+lO8VVIKDf/tSwc+WmP3ATxPIejc/BJ540ngZc96LeXgn1oC4IOYawWDQi975bSsCuZ8I6mwDDVY0b10CH6so4KzwTmohiecbNYWHEt6SeCHt31cExvrHr2/TP+aE3lCB0rm7FS+xuFoByU7M765Q1hGoI5GL3gmFjqi3XnnsnpBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCNKg5Rr/NqIhX6AitJr4iwEomewnLA1ClBKpygGEbk=;
 b=O4dTihnARPuXT8fhh59KOnxaCTUXPLYnTxrM32jxBF0wE974xEvwbooBDKnjFLMHNJg/ZOaR7JJvHB//nKZO3cEvQSeYhI6Ia2BsWIROB7dfqGhdfOjziAHfRZZvT9ljv2WMKKVqgYj32nWeyzIk2Nk/ArlpUOyHf/IrHn7GqOuHh7/mh73ApOPSUQlyO5k6gaSllmTqggcCiTVuSUJMOGpziah3GuVRyu631y9Oo9PWaWhmTWRBkqZXeTFPTfyOkXNH/iMtiZPOQD5DJph0Q63Jv6OuPx+DxIFd4Tf/ryZAd0w84UPZ5PgLKVEqRwuUxre7xP/N5onqWREsrrs1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] serial: rsci: Fix symbol namespace of
 MODULE_IMPORT_NS()
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] serial: rsci: Fix symbol namespace
 of MODULE_IMPORT_NS()
Thread-Index: AQHdMQBHLgrvVXHeLEawHkYJhDuIb7apuhWAgAkENtA=
Date: Fri, 28 Aug 2026 02:05:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818634A6FC06AE06C98F255CDAC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1787270513-25812-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <aolaC10D2GVjTNMa@duo.ucw.cz>
In-Reply-To: <aolaC10D2GVjTNMa@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15218:EE_
x-ms-office365-filtering-correlation-id: 32015999-6840-4cfa-f455-08df04a8d4bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 z39hIpzrsDnKQD23XPChHLzByhJwVtHtxP55lMr3kgHDD7k4rZ5fWoOCYPnN0xdqtpqCT/5xE86SR4/oKb1Nm2NnNADUuGlJg6IZ9pKznZXKiaJqD/pAVolRHywt8Sghpo8NrxYKqr7U+AsO9DhdUeTf19IZ+630ecj3PF4rhmwcr++md61ZtBo4RVd40cv+GSYw7kQwM7z3rcOK89hOfxnbSkW+bzJ+dK7I7syRGJq0P9meH6fINgunngI4dN4PhzwSBPPz4kt3GIHLmUUIuIxADNMAYxGSKGjPIjNNsepvzgpc2AClhgibwe1H11lnrqo5lr7gXnzrczbYC4+ShhBgYBlfv44O1yZo8ZGoPvHVMQLXQ3kr/smQhWC8zNXWGW98rcm9uD1PMzHheiNBg4rE6vNXNgQwQD00uL6kmAmYT2tMbyMpZSVEAZjyjCOsq36y1xyBaCM9EMbdxlG6TocYCLI9ig3bX0n84onVzGQR9fB3qiUZexJyM/srnrUlRSpA0wfOIwUlcjv2d+wLkaLUcxoBMy7U00dD62WYDC9q9aRCwd/ZgzhtVUc0qKzD5BdKSS33plL3o97rq13ApES+ngC4q7eca3O/vMLxttVLf4SHbs1cQDqdGMbwOBpdvYbX2UKkg18bifY9VRvTNQ24gWBRivmu3oyM8No4Fmmm6WXkjFgMYImAiQra2TYJQWWhsRwIhqu8U07/ABkMbpLpb9xrC/5xhpXfPE1t778=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QlBubkRCdGZYQzZJdDA3V28ybUwvY2daeE0rd0ljdjNoNUxzRUMrcVJT?=
 =?iso-2022-jp?B?Uk0vNzBnSTNPTjMvNmRaejRKQjBxL0NuNHg4MzBHQlNUTEUwM1gzMXRN?=
 =?iso-2022-jp?B?SDdBRHNzQzJmUXhoN2psUjZrSEcwbU9ZYVZQeUJBZ0ttQ0pSSXpVK2wv?=
 =?iso-2022-jp?B?dU1lVkYzb3FpcitMVmxkYXlmQzNqQ0M3cXNjc0p1Q1FsYVRLOFQzRkVM?=
 =?iso-2022-jp?B?b1MxZVZnQmw1djFlOEpSbTkxS0pDWWRqWUhEanJ1SUtEbUJKdEdaS2tl?=
 =?iso-2022-jp?B?dVRpdzc0UEUyQ0Y4NFRKcUR4QnhCcDIrMVo1NGEwYlZZZEdUbWl2VFN3?=
 =?iso-2022-jp?B?ZFBGR3VDdjBodXVvK3pUY0s0WGM1bCtCUGJZZnF0cjB6YWVTdkdHbndZ?=
 =?iso-2022-jp?B?WDJYaEx5bFlHeTM4VUZ0M0toYU9maXdFTnFYTTJSVjZLOHZmclVYMWRy?=
 =?iso-2022-jp?B?SHYveDNCTVZHUHlyVjEvNU1kUHZKNWpCZndEOHF1OXIwUUNDdnZkZmxJ?=
 =?iso-2022-jp?B?UGFUT1pVaGNjZ0lFeGd3UkVyUnF2aGJtc1F0dW9qL3d4YTkzaks5c2xR?=
 =?iso-2022-jp?B?QjJGSzExMURPUmFkY1dqNExVQ2tyUCsyM2M5T1U3VUlRWnoweTFlMzd2?=
 =?iso-2022-jp?B?UzlUSHVDSlpoZmdnRVBjMDRYUFlKT1pmT2dGa2QwUWV0a0R1M3ZrRjBH?=
 =?iso-2022-jp?B?dUNUMjRLUUJydFZPNitkZyt3NlJNMTBSUG51OW5MNUdzNERWaDJlUHpS?=
 =?iso-2022-jp?B?K0RIbmJWQWNtYU94SmpuTUcxMkxwVGxUdERuM2cyWXluem5YaytpaDNi?=
 =?iso-2022-jp?B?UVhkQzNQSUxVakhMa2ZzQ3BCQzhBUHpPbklZZ053TjhDaWFmalNKWGQr?=
 =?iso-2022-jp?B?cGEyU1J6NlN2Nm1PTllsTTJYUjZnbG9aZldnZVllRFN4Ykc4d1VsU2tz?=
 =?iso-2022-jp?B?V1FlZ1N6VW1qelpOOTgvZmNDblhHRHhRWWg4KytzQnNRMEZXVGZvTlF1?=
 =?iso-2022-jp?B?YXdCTDRyelFGV0laSEZ6dlprNWd5RW5YVjdkUU83amM2TWU2dkx6bXRZ?=
 =?iso-2022-jp?B?U29DdFhKZGhtTHRBa2w4TUxsQ2hsL1BPdkxkRWoxWUNhTThlR0NXdEZu?=
 =?iso-2022-jp?B?K3N5MzFqcEJhVHc2eXY3TGNGVUdPbERZUTlFRkRrVVpLRVFvTU5WM0Jt?=
 =?iso-2022-jp?B?dUhRS0NGSzZwSFBRTUZJU25IOCtMdllSdkhsRyt1TUNJU0RMREtyeE05?=
 =?iso-2022-jp?B?VUxqT1hnN2JIM0NxemNDTlI0dm5HdHhzblBhVG84WlBKYmtSUXoyejRN?=
 =?iso-2022-jp?B?ZnV4dXJHeHJPd2c5blBCN09xWmhzWmdGbjdDYnI2N0I2OVRIZS8zbkdI?=
 =?iso-2022-jp?B?dnNQbDV2UkRESHBram9HMVY2Y1JsSmpUazRBbW5hbGVaaWoyYnBwVHIw?=
 =?iso-2022-jp?B?YmdsM2R1OXhKUXRBa0RiNm1GbWVjdVdQVWhHODVWY1VlNzd4bVVHc1hE?=
 =?iso-2022-jp?B?a3dQOVRNMXB3akJhUUtUM2ZCMGVMSDFRczNYNHJzWXNld0VteFJQR09w?=
 =?iso-2022-jp?B?WkNwdGR6ZzJtbTdlV3QrajNWaXY3MG1SUzdQd21BKzhyV0Y4eGpIVXBm?=
 =?iso-2022-jp?B?YTdJTU5uU3Q2bSs3VGQrakFYRWdyWVpldnZlMUs5VmFSbURkbnQvS2RY?=
 =?iso-2022-jp?B?aXBSRTZPRlZVYmllbHBxZ2IvdFhKeEhrMWhYczlRc1hqVVc4VU1yNmtH?=
 =?iso-2022-jp?B?SS9ZV0Q2bnN5cTRLUU5RQm4zVEJJNGpVVVFCNWcxM0lzOTJUbEhudUNi?=
 =?iso-2022-jp?B?LzB2eGtCOFhiU0EyNGwrTG5IczlGdTluNjRmbHNVRGJ4WSsyWTlCT01r?=
 =?iso-2022-jp?B?alFTbzFyREIxbWpBMjBvNnZNREduMUZsdFFwSkpFMVZuZFc4NHJHK2Ji?=
 =?iso-2022-jp?B?QmRNMmEvWnYxY2E2ZDRSSkwvOE9LWkg4MS81bzJMcTFibnNWU3NQbVN0?=
 =?iso-2022-jp?B?UW56clBrbE1UR05lUUh4V0x2djZSRFJsSVB2YnhZUXI0MXZydFAvTEdu?=
 =?iso-2022-jp?B?R29DY1dRL1VzSnN1U29tVEFLbGNHT1RHMld0S2lsRVM2K0djYnIzdUha?=
 =?iso-2022-jp?B?VS9XOWZaWlVoK1FCTmd6VmRERU10TWlwLzJxazdkeURqMUZ0MDBlN1hG?=
 =?iso-2022-jp?B?aFlsWDdEYlFBWmNUbXBRVmlOVGREV2hsUGdXRFQyc3pqbHpVd2srTlZr?=
 =?iso-2022-jp?B?OGdRbVJ1bG5QUC90eWdqWFVaZW16WkF1bkE1YnpNampIQzc4Y2p6c1BF?=
 =?iso-2022-jp?B?M3FGSytrOUdZQlhvV3AxK0tXd1NvMTY2R3kyTWFDVmJTbVRSMlYwUjcz?=
 =?iso-2022-jp?B?TkhpdWFpRVgwbkVpUlJQcUhzMzhibkRuUDRjc21xOFVOYi9UMjl0Ujgr?=
 =?iso-2022-jp?B?MUw1UExTS3FFT2Q0cVdBKy9WbjMyWjNzd2JZTUg4Z3ZQN3hHUGhEQzlN?=
 =?iso-2022-jp?B?MW45L2l3alRkdEppRHo5UmMzMVQranhsUjJHdVJRVmZublhFR0hUQkp6?=
 =?iso-2022-jp?B?cSs4THIvZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	WaCp6UJOSdhXdsHhGqlFvRJ4fUChlCehTKfENdcmDk3mO41f1KI6JxIpTla4LjrtdJ6K/V/hh5eUQis2T+Hu1sLSzg60mMWuqUZAk13+xBI+LF7304/4zKnEBqJTHIUBrLt7RAL/jmCGuzPBY13FApyIKN45fQRwMb0TIGXpuc/LIIA4qCVdxpeEsglgXj55hgfzmQ5gPZuuDiewxw/ILUjqjP3URWmC3Kgk72iKASEQ+2/414q/zJnj3IZs9p0IFzKa0tDtQWoIXkw3iC9zNh77Yd5s9eWkd8WuoD5hs+wST5fDpdejBx8HE4A3qGOqakdiEmwgMuzLVXNQuG36WQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32015999-6840-4cfa-f455-08df04a8d4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 02:05:27.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IlAG1i6UXL/KDhkcD/vQRjaW6tUdDo/AkLj3rGY4norVE8iSKVWAVK68TZx8Qiy3TDiWzh5Be3+oiheMHrGwVxNWaGppbr5n9tXT61gXoJI41cPGh0MP215+6UkD/xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15218
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Aug 2026 02:05:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24044

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Saturday, August 22, 2026 5:13 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; uli@fpond.eu;
> biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] serial: rsci: Fix symbol namespa=
ce of
> MODULE_IMPORT_NS()
>=20
> Hi!
>=20
> > In linux-6.1.y, the namespace specified in MODULE_IMPORT_NS() does not
> > require a string. This removes the quotes from the namespace name.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thanks, applied.

Best regards,
  Nobuhiro


