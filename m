Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA118FD007C
	for <webhook@archiver.kernel.org>; Sun,  1 Mar 2026 23:33:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.149142.1772408036983537232
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Mar 2026 15:33:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=UBHneY/S;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1772408031;x=1773617631;bh=QO5+95tTcH+sOiNxLw2m/ALfrWeA9aTHs0oYP
	07DY9o=;b=UBHneY/Sykd7scyIzcP1IpDUKeIuO8L+eH01jVtV3/SgNjAXNHupZ0vDT8TaSQa8FeU
	LD8O1z1Iqn1/Wb0SJguM71tNpgrhPL+cnASuORCx5oExUv6hMYp/LyeaP7Q/S9oaNK5IN435lZ9Oa
	PMDuvwBhGAlmTn9Ix8zImROd0lHGuJZ0LDMzWM/QpcXWcXDx7bfIno6OPoieorl9UqjAm3VgsrrEQ
	iEztsWHnqdayjaIDpaz/lsY6zwO2rZ8A1rjiJxfwroG7kZgsEEXKnl+tZqxo/IPxpf+Q/Mg57iXSr
	IRjx3UNfu6Q3nIhZtrsxAfNJ0FAtXZK/hQFxn3XWqeSw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 621NXoj23357660; Mon, 2 Mar 2026 08:33:50 +0900
X-Iguazu-Qid: 2rWhTylF7phXsIHfWB
X-Iguazu-QSIG: v=2; s=0; t=1772408029; q=2rWhTylF7phXsIHfWB; m=XTcNQmDTYo+Nr07hhWW6jS6KSkP2ZaMWDlHU7Fb1Uag=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fPJKm4pd9z1xnl; Mon,  2 Mar 2026 08:33:48 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBbjoxLnSae+CRkAUMEAsVIJIB3q2An6pP7mpSujENqVDtjFu38TSRJ8+jwQhR+FxPnWlvS/kQNJQdS8bEEjWwggjQIjwqUO21Do7Ir5ULguUmhYnXMJa+XNlxI1BBM/esRvXCy8rivAG3PO4O4AWcovuV1Cfejv7VP3NN10uWSgDYWskKbCEcJ7HLvgvKYngK4Q2kA7LhpKm9PVYgZkD3k5ZybrHYXnCQm3NG8xRmJzLLOP+tNyYCou+oKzUOfXCNupicrixd8shVsCj8rusaFzURL2xHIgYFti/EjvZvJqAM6Ciei+WlagvRS4w/xJZJ9ZSWv4Q8P2LWjEGAUDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia/IjMvHNRUInz++UpO0cdKeJGHMZs8j6b9e3TuCuSw=;
 b=mTvPsRu312iOQH7mpd+OTv4OKt6qL7JxQKgPF8aFO36TYCIV+pPiuIav54ajSAzXyEOLcRBIuNexukExS0oE1kFiCTilCbR3VkhMv+9eAq83ITWaTkkADdsIDspykpJLVRlswN0V1570IGAoKLjuu0ngOqQeV0KXL4dpqtbqAz0mx6YgFp2nw8jBIoYFk64REnsKLbF0biIwdCfc0syaB0WdrpzyNT/0k70vrwc2uUSxtUw+vYppOy+NCZZBcnhaGz1HfjezwDdYp8/bYm9KhBBPDO1y4pSv4TiEiw5Goi/fVXw+BpOACrDSZWBVjVbO1mdNaOOT66bpT43/5wY9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/9] RZ/G2L SSI Improvements
Thread-Topic: [PATCH 5.10.y-cip 0/9] RZ/G2L SSI Improvements
Thread-Index: AQHcp1gXWBzrgQ+UQ0mvxXsdqz+2wLWWSoqAgAQOCOA=
Date: Sun, 1 Mar 2026 23:33:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D15676D869483ED5F241CD71A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
 <aaFluc2RTIQHJGP2@duo.ucw.cz>
In-Reply-To: <aaFluc2RTIQHJGP2@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYXPR01MB15741:EE_
x-ms-office365-filtering-correlation-id: 9e88ee70-ad50-4cb8-9882-08de77eafb8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 yLU7TuZ8RUwg2MN33cEepykmMXdCNWTH5HO6c3ns1t/NOYgg6pGYpXHjJCBuRlPWy50L4a9xL0NLMatkZldEO5WrOFMmVQwEuy6pUyDnBiQQRnCIfmwrsZ2ihZ6yPfvvNjCzKrOWaSWBX4MV1RVrj2EuOjwsNoHKq3tsLgcpxHudXvwBUnEBhkUciadKXU9dItx8V99VCCvIbWvBr0SsUj/rG+uWb3tHwz9wKjp3++ehRGLlprlsBIctYmdmKnRk6G7eNUxT0ViIoVODop33c/GBJVPaJhxPGMs5vDgqLGssPp00ub6mnAzKQDjCf2Tlic9PWolfbj+Okg9hn+d3LBYBItoljwlM2d7DAErPkvdyn8hwG4e5QQMNnvb8TRSyt/UOYcGsQrx5KbOKwj70Bpe8gDrPTyBV8yVa7TRwkBiOiWJyuLRgsJ2raZ2Vy5+ed1hPR3BvFX2g2+BluC+AXxRX1hdrVbqvBsiauaTzXIxh+2wHVylS5KJbNP/gfO0YZ0gzSWpPfzbbGjNTGd9fgEON/AIZkMUqKkrToC/XSjW/4fRVsklOzTW4iQWw3HXjsqCiJVfyYwKITOXTqdmKvsn+gdguLpiyuGxZYocMpuNJykJy/QfFGMLIKwwdhLO8uwlE5Z0ovh8q+HgmxiPgvCX/NJNGWtgst4rauJEy1+dDJRRUM+WVJKw2FOneinoTuSSO7rn4Ui+VcOk6LNhfrPfpArinqJ5hyzHqo5/i8NaUJ6NMReWQoqf6Jpk7h3AWmemlUaqh1UC77+OrREObRNvRaxhYqIlBgmpwSOO+87U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aExORi95TFFlSjZNM2tjVUtxRHBTeHRzblFDSzJycnhjNXZ0UnIzVTBv?=
 =?iso-2022-jp?B?azBOWHpDVVBXcXB4d0tXRm1NcTd0VE9ySWo1OFdXSGFaVlBqRGF5bGs4?=
 =?iso-2022-jp?B?RUl0YWxFUVV5NTczQzlZbnJDbjhOelp5SVhKRzdsdS9QSXZ5cEtQU2ZK?=
 =?iso-2022-jp?B?ZnI5T1RHVFl0cG1xSnROeldBRmxPd1A5c08yWnVMUFNFSzZZWjVWenlD?=
 =?iso-2022-jp?B?YzNleEplMnpMeFNtRWJBTE5MMTUyQUk1UnVDeVg1V0FPY1FaekVMWXZX?=
 =?iso-2022-jp?B?ejdFditOMWJvck1qNm01YU1GNFk0T2MzSkdrOFBzWDJxeDBTNzRrQktU?=
 =?iso-2022-jp?B?aFJ2YldDTTF0cEJJNWlPTjJxaEhwTTFnN0tzTXJDWi9EbmRlYnB5NWV1?=
 =?iso-2022-jp?B?bGJ1WUFxRGZuQlNrRktPb1V6V2JjaGVXUzVhTzRiSm43Rm1tUnkvWndz?=
 =?iso-2022-jp?B?VHRVWXRURjZFc1ZpM1NmSU9BVzBTOU1PaFVtcUorNjhyUFM4RzNLNmts?=
 =?iso-2022-jp?B?ZzA4RmZJSzhMVmY5VnhldTdQbitnVWtacVhZNUI5MnhtWElRZ3BhSVRT?=
 =?iso-2022-jp?B?blJlblh3NkpwWkJzNGt3cysyQ1FkNGx2R2trWFo1VXl4ODF6QUJBT1V2?=
 =?iso-2022-jp?B?ZG00ZzhuWE5lcm5wZFVSRTl1RlpCSEFPOEFOTmNPU2YvbmJQRW82Vm11?=
 =?iso-2022-jp?B?WjFrSHQ4OGhCd3J0WGdSdVAxN29EVURTQnViVEx4TDVUVEJpNWFXckZQ?=
 =?iso-2022-jp?B?UXFTbWpURVZpeTZyVmpGRVdtZklyNDFKZGNxQ3FlRzloRUhXNEJSY1FX?=
 =?iso-2022-jp?B?UVdVZ1NhRU5kS3A2dzYzQjY1Z3FHanU2cDR5am93YmtGUDN2UTh2amdB?=
 =?iso-2022-jp?B?eU5Wc1drVm02b0RBeWpCUUJlNTNWSGZzUXhuWDZsNjBzL1V0R0ZFbHBS?=
 =?iso-2022-jp?B?d0gwSFFMeHYya3NyclNxa1ViN2dkNGNmTUxSc3ZSL1ROSUpvSDBINHB0?=
 =?iso-2022-jp?B?Q29DOUpWUDhmMTNoZWNhejd5eVBlKzZhY2tMM09uZVZYcEtqQWJNQjFK?=
 =?iso-2022-jp?B?ekFDOGRYUTlpWkdtMS9yNlhvYzNmZFYybVJPdWk4aVVsQjd2Y0szYWpi?=
 =?iso-2022-jp?B?czBaelEraHhHVnMycG5zalN4NVhWbDlteVM3NlVJa05ZVVlNYzRHa0Fz?=
 =?iso-2022-jp?B?M2xENVdZWGhTUWtlbEw3TXJKTFIyZ084SWZZcUhpNkhMSVZwUXJXQWow?=
 =?iso-2022-jp?B?Zjdyd2VpRnJkdDZ1SEY0WW9LbUJmM0lDSzJ0d2k1WEhVTDNkc3pEaG1D?=
 =?iso-2022-jp?B?MjAycWtqOUw2dDFLeEc1L0RlK3N6elVlL1ExKzBQL3RTV3FnblUzbm1U?=
 =?iso-2022-jp?B?TXg4SWR2MGhsS2hqZTFMWlFTRnFQenBubExvaW9qN25Lc1NKL082Uzdu?=
 =?iso-2022-jp?B?ajFYVXNOWHRIQjNVRU9HUXEzL1ZiRTdzUDRRMVRXb1ZjKzhrbmVUb0U2?=
 =?iso-2022-jp?B?OFo1bUxOaFlhcFZiSTlROG5rdTF6THdETmJEMkZPdk9rOFEvUUJ4MVQ0?=
 =?iso-2022-jp?B?S2dGcHB3UlFHbkRkdWhvOGgwY1IvR0FhRmRPRnM4dktpT1hOTmd4SzRo?=
 =?iso-2022-jp?B?SDJYWVZIY2lEU2ZER0xJbU5NL1B2SDhMTGNnQ1VyTXRaVk5sZ1hrbmVl?=
 =?iso-2022-jp?B?QkNaYTFwb0FFbjFqa0g0WG9pM1EybzZsSXlTOGVjczBGRmR6Y3h4QVZS?=
 =?iso-2022-jp?B?QkpRbGc5THZyYmJ2cWJEaDU4cHQwRUNwa1MxUm9oYXhmVDZoUGcraXpj?=
 =?iso-2022-jp?B?NkY0MHNSTU42SzRTdVZHazRFcE81UUxhUWVFVGltUWxLNUIydlFWUGkw?=
 =?iso-2022-jp?B?U21zMmdsc3o0MjFBMVFPdFRQMG1MTzAzbHVOYU5rT0FOVmthMS9TMGpC?=
 =?iso-2022-jp?B?OXZJbkQ0VUIzaTBybk5mOTVDaFNCWGFqZzF6VmFlTk9Nc3VIZFlMcDAr?=
 =?iso-2022-jp?B?TEtzSFI1YjBlN1pTTE9uT1lSeEtzQ203aWc1NmRLWElUR2M0eSs3b1Vn?=
 =?iso-2022-jp?B?OGpBN2JjZHZockhob3dLOTVTL2JWb3dWNHV4cCtYZm55bmw0YnFobUNu?=
 =?iso-2022-jp?B?NHNQZWJUUkQvL0NiRE1MYisxZGhUaXdOWWRmL29keFBVUGRNaXdJd01G?=
 =?iso-2022-jp?B?UXpKUVRIWVV3bkx0ZTNIZ1Jwd2xaVnFHM1E0TEEvanBkMG83Rnk5VlFq?=
 =?iso-2022-jp?B?MEllR2pTSURuaVhzWlFSWkR5TTdFZFBDRENESWk5cWc5RXRpeTZZRHhl?=
 =?iso-2022-jp?B?bnovQXRqSUU5aHF3Qi9IWG5OU1RrTHhwNWdYT1JXM3FtWXdQMk5ML2NQ?=
 =?iso-2022-jp?B?Wlgrc3pQWjcxYjVDbmlVWHlUdFpTRW9vTU45alN1ajlJby9BMWhGM09q?=
 =?iso-2022-jp?B?NWU3UVJqYjNCSHNLRC9keTE0U1QrMFptSVlWR215cmxha005Mm8zSDN6?=
 =?iso-2022-jp?B?cmJEYnl5UktBeDh5TERlcHJmRHFrTk15S0hPZFpBSG1WZlRxUkZMUDN6?=
 =?iso-2022-jp?B?VXZrRG9xVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e88ee70-ad50-4cb8-9882-08de77eafb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 23:33:45.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ana67HEJSOynhrT4iQoIPGePENojjTFKAQaT2kg2hvRMoeUVMuLd3AdT7p0HFDGQBm3warU73Zqq6Rc3NGRPPeBerm2XhJT2aDXJdnes9QgiWp5ZU1MHnXL4EkIZXngc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15741
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 01 Mar 2026 23:33:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22030

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, February 27, 2026 6:37 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 0/9] RZ/G2L SSI Improvements
>=20
> Hi!
>=20
> > Add support for 24, 32 bit sample format width. Also fix channel swap
> > issue.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good too me too.
I will apply and push with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhio


