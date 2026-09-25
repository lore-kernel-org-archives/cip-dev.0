Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA3C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 08:24:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3550.1790324649242088116
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 01:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=kIgWNc4S;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790324646;x=1791534246;bh=76JAj8Uw27o08XkjikLjgsa49Ywoy3iStn2nE
	LAbTwM=;b=kIgWNc4SyugIwr/8V10Q1NoDfCAxv8P+XzTlZpUQWZGpmvO5legtlaCrj6/GU1zh2bX
	YCLCi2JUL0yqP0ez98dFlzAduWhWldF3q0lfE/LuT9IlKFmBn3rj0Q9MdAEE8ftkLXnZD4iaK/D2J
	MD/n+TE22Io+LRAllZCmIx/SRj2w3T3oEhWA5VFz/9bWtThj1UrcVdInAGivMTOcmexspTXDTLkOS
	NDOZltbNL1tNhRZfbu2uHg1+AWcZrjOYCgjPZNGUgryh8PNbGt8C6yk3/hW8dq4EVO2/Jhjx2BxH2
	FDUxfOjUThVHe/uL/Ap0o419tPg+waIkQ+I5LgC7aTYA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68P8O6h02353030; Fri, 25 Sep 2026 17:24:06 +0900
X-Iguazu-Qid: 2yAb15SChiFI4KOy0M
X-Iguazu-QSIG: v=2; s=1; t=1790324645; q=2yAb15SChiFI4KOy0M; m=XvX7v6YZ+zR84ARTzkIMt/6nRAqEHrBgTfJ5Qk1HIw8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hrkJ54K6jz1xnl; Fri, 25 Sep 2026 17:24:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQPNTLOoS7AXhy2fPmSNRmkleUkFjKBq7NBKxSWpkXNuvRA7mXksshttVj1z93e7hvaLTJmw6pm18eO4eLfwGrLFxgvj8Y0fg3hT65s8t1rmElDdk64n4c8LTJugNjvIWBRDkrxRGTN3y5x5FLuRB5omL6sP9l8EKlh0i9Vp5KpPWBP8QhoK96cOFc6XSnXLU8u4ZhLLgTmeAyd0NdDeHSydWWARX9YTpEm+sDBAOGRMxWfhgOqX6IuotcqalRub0EOZszuybU6a4HUicNuwbrtITxq+Oz9q+SKA9oopt/0i4wOzO3w3s2IfumF8Yx98EYzNFkwNjsJaAKxHwf2KZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iczs2VFKYVcLmLk08N4cpBfO7UbhHXIlUIU0/ElfJrE=;
 b=OpMgdyrbayyjxV5Lbpn+93lBfxFDyFPPsVV12jQuo/DT+xOtLD0zBA8nEyVzCy8dh8cGJn4Qw2mjShlUqeWgtqe4bIfRo421a9UVzxNU1WypePxg4HMI9ei90Rn1KWzsD19jHfWEQoXv8NlRfbMqINaM4xhCJHqUfDw8CrMuDIt3CygLgvGPvzxqHgmmx1fbGbPFckflxSSkDhvNEeDLv9wNJbE/wXsKTxZEUGX+o+LFf+ZRrtiTz0fyI3M+4myNxWpMJqqrx/3knTpCRur19AcRaICRjC59ivmpoubyC92w8OB5HsGsSunsNDAL9KptBAj542huBkj/cQ0401IRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Topic: [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Index: AQHdRoU8W/KcNieYG06hs/ObTUyBCbbfAKfg
Date: Fri, 25 Sep 2026 08:24:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BBA6AF0337F57A84D1F9CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB16045:EE_
x-ms-office365-filtering-correlation-id: 60a81851-13da-4c0b-8bd1-08df1ade5bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 pyu229C7y5RMjkgobdhE0Z3TDF2KV8FEIZrBq8ARriO6NQqlVc8BZ9wtDDex/Xpkp92V3T2xYwdkhpz1wmxYT8UC5qhVxcYhev8MI0JUGNl08J95kPejxpJGuz9X0ybThkkrz4xQHMMovVple+YGKEm68ecvz0AwZ+0WVOoh8dHMIozlajyb0BpftRKQdv8nHlFaSc2DXf4uAg06X+KLMugycFUzW0vls4gh9PdqjagQPnoW23Syg8cYrX3EsV85xQIvd/gkyXDoMDECE94B7Wpk6Cu4oBx7+N6aZr+qvyI6djHzvveoRea9jXAPE174Hr6LatojilqVf4y+aGYZ46D8+5TmkOk1DZEMM0BS5Mu0/VZUy6uS4Vj61Z9fvM60RyjrfWz3XfB+/X+HUXs9D3ijzTQrxaPtzLoKjg7Ht4tpr0KRZ0qk6Ojgtnz1aNWK6+B9NPrzfHacAeODZDDeQT4Pj2m3pDle6KfH3HcU9PjAHJ+6USq6ZNDSuSApVcqWJnCiOI+O8aIye7LlEK5XYxwBggsd7yg5JvaBS/UQF1qDqDTVbOM3kFzHNhunC3bdXMNTkidByK+UhJVDCwtAxP58H6YMubqJ7KmNGOJnsR93jzQ71si5jqy4XDKH+LRndQ6MGWIzuz5Sh69/rCW+SnzAh0Kcc4vBk3NEnoS8PzI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OWtBN3o5YUxIS3FVck5oRWYzVi9jNG5xd1VMN2l4MUtPU0c0a0J2QWJu?=
 =?iso-2022-jp?B?eGtXWTJyVVRCbExRQ3BPYXZVOXgzVUc0OTczN1Y4aTkzR1FmaVhKTnNr?=
 =?iso-2022-jp?B?eWNmN1gwdERSRDd1bUkyWUR3c3lZaTZkbUdyZkNxbkE1VmNRQzRHYVFL?=
 =?iso-2022-jp?B?Sm0yVzZVVGY5czY1bHV2YzcrLzVjYUxCL2RYMDJsTXRmV3FZUFhIL29B?=
 =?iso-2022-jp?B?WTUzTnQrM1FPaGpSdW9FQ3J4bGN1aG0wT05VSWMveldjSnRhM2c5TGpB?=
 =?iso-2022-jp?B?dERsMnVUWjRVVVJhMFVxTERMa2dZdURHY3RrZnFIcitZbVlpUTBEWUN5?=
 =?iso-2022-jp?B?S1ZuNUVWRXRScFkrQnByRXZ3YXJXQXByT0QrVTFNWXhEdWVpZ1lBVytO?=
 =?iso-2022-jp?B?WHo0bmJELzVtYXg0SUlRdCtBUWpIVGxzRWJZUEtoRGZyMC83K1N6cWo3?=
 =?iso-2022-jp?B?M2FkejlQb2dUSktVQzQ4bUx5L2Q1VzJvRXMycjlVL3NaNmppQkRhUFc5?=
 =?iso-2022-jp?B?Z1pEWDBTQ3p3Mm1uVlN1bmpzbWkxYmVUdEJRc1k3SS9ic3FNRVVnTE00?=
 =?iso-2022-jp?B?NFdrRFlmVlJnOW91b0ZobWk3REdsSFZkMGtyWXdiTWMyQUdFMlhnQUdm?=
 =?iso-2022-jp?B?c0FGK3VNVG5PL2ZWVCs3WTVqM3FtWmJZYllKZThVdXVxeFBUQ0J6ekJL?=
 =?iso-2022-jp?B?S29uTTFEaWxzWE5Oa29XSVpIUytFbmpuT0RCQS9BbTVEQno0ZEUzb2tk?=
 =?iso-2022-jp?B?ZkU5ZmFFclJuYnVKUlJIOG5wRjJTeXdKOUY0MnUwczQ4TFRBWmNzbjlE?=
 =?iso-2022-jp?B?TVkxZjJIdGVmbHNhQTFRdFhDL3hUVm4zMHo0NnVEdmhLM1J0bDFucTVK?=
 =?iso-2022-jp?B?OGdrT0V1b0VtUWx5bXFqZnhjTlhGWjVoOTV2Q2lDcDlzV3FPWk96RGNY?=
 =?iso-2022-jp?B?c2FscTVyREFsYVUxbUJxaHBPTFJGQXFSRFM0OWVmZTU4ckxVbHNOVk96?=
 =?iso-2022-jp?B?VGU4eUgwanNnQVlhd2JkRVZhc2QrbnZTN3NFc0E3dWxXNjRqeGlENFhV?=
 =?iso-2022-jp?B?aXA5bG0zSEdFaVhpSkNsRW9IUTdRKytrSGRnaFRkeFR2ZGFITE13TEVn?=
 =?iso-2022-jp?B?NVdzZGtLT3VYTmNYekg1eXBGcVk3ZXJoMzYwZGhQK3pMYVQ3SjdYek50?=
 =?iso-2022-jp?B?TDFXbnBDVW5hUXJlbmpPK28rcnNKZW9vdXlzOE4vMklkMEdLWTBBdkVm?=
 =?iso-2022-jp?B?Z2Z0TTdLdXlSKytSWjdaVHVOdEZ0Q3RabEZwcTJlRHduNU1hK0dUcHN5?=
 =?iso-2022-jp?B?VXVnQ1N3S1hDN1owYkxUY0hUcEVpaDVWczc2TitmM1hzWGVmTXFTNjVN?=
 =?iso-2022-jp?B?NU53eWJTWTVaSGx2Zk81OEJIUUFHdll1bWViNStrY29BNFdRZUZGcWtC?=
 =?iso-2022-jp?B?WXFNTFNaU1JqeFZPd2RnOEkxRDNuWGgwd3Qwckx1cDlxb1F5V3dIT1JT?=
 =?iso-2022-jp?B?eWhZWGtTc2ZaQVR4bjFrSFBlOWFLTVNYZ1R2NzJsZlVSeVJhb2tvbUxH?=
 =?iso-2022-jp?B?S3Zxemx3Tm85VWJxQ2VQK1NPUDZZdUJvTDdIU3ZZR3hjZ1pxQ2RMb0hX?=
 =?iso-2022-jp?B?R21sVVRWZ1lrZW5KTHNYTVBzcmZkS3NVREgzWmZkR3dRbGNIU0xncXBa?=
 =?iso-2022-jp?B?Rkg0cStPKzduU3RPRUFyNUJxYUVXMTFqbmRob3ovdUF1b2lTRXAzRzlQ?=
 =?iso-2022-jp?B?YzJWcU5zS0lYbjUwRTFsaWNWVXptZWR0WjVWZWNIODNRUWFTODZtV0ts?=
 =?iso-2022-jp?B?d2FQQVdnVWs4TitIOC9KVXJhUkhwSUJrdGoxZGY1Q09sK0V4OGhaWm8r?=
 =?iso-2022-jp?B?dVl5aWpQeWxreks3VitZZ0hoajJIdEx6cjBRNURac3cyaHg4SlNWVWRL?=
 =?iso-2022-jp?B?KzF3YXJPQ05sWEppZXJ2dVBSWGRXKzRJVDZrNFBxaFYyTjRzcW1GVHlJ?=
 =?iso-2022-jp?B?cjBsNklsMCt6RDl6S0tRclYxVlFCUkxxVDZ2akNFdnlUanFOQlBTV096?=
 =?iso-2022-jp?B?a0REZld4L2REbytQN3lsd0gwVEs1ellwekRHcWRVODcyMGVsRXcyQkk3?=
 =?iso-2022-jp?B?YnZBdkVFenBGb1dHK08rQ1RKd3NhL2VnSjlqM2hvT1Y3dEZhNnBxMlhH?=
 =?iso-2022-jp?B?TGpSNW0rdnQ1Ym9XTkgybTluMFZWbWJyM0d4Rksxb0RlY21jNWJtdmF4?=
 =?iso-2022-jp?B?dnBhcVVmZXRMTzQ5SHRjdmM2WHM4dDZpSlFnZGVFMmRuQjcvUnF1T0hY?=
 =?iso-2022-jp?B?Z0xxaXhkZWNrMjJtcS9nTTE0MG9aVUpBUDFDdTBSMVE3TjZaS2c1VmF0?=
 =?iso-2022-jp?B?bTlWNHpIbEw2alhJQ0NLSVlqYXozZ1Ara0Y0ckJySmttc2FTTENnRk9Q?=
 =?iso-2022-jp?B?aEZvSzhQQytWZkV4S0FIelBuS2JGWGExejNLQjZGSEdJSURtSVFQYlhQ?=
 =?iso-2022-jp?B?cW9ZUnJLSkVDQ1k3RHRQVktwbE5VVWVWa04vRDFWYkFoQXFlamZMZ1lj?=
 =?iso-2022-jp?B?bHhybFJmUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	GK5QK7kPJguW2Of7UwjKie5FBRa0WUJfwci/ch9R+tgiiJ6q1bflTQhQDCfXzSJr0WkTmSK1i7JXonUlWvpCRcT4L/6gTz0CVvREtn2IwKXgnM8qCxRKEJ0A+iS2MSuf7sseM95NkXWul2cY6k9N0eNDiwFIcN0vZNbRVTlY4XOKypDWfKYdZttWNB//c8WLyS6ESPbW2+GZ1KFrUIy2jzNHegd706rn2NPlJ33YSo/dsar62MX2vGqoQrIriVhqUtoTbtmqho7vMwep985MC/zDlmvjHIvtTzy9HFNgiHLTCOtD+uCNMhgdqDFl6/Huclhf8zIKauWBmg3Aqb10og==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a81851-13da-4c0b-8bd1-08df1ade5bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 08:24:03.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6a4TAgcXBR//qJs6lV3l/PbDlv0cMiwEi0msnE4GUhm4YO8a5NzSnFpqNGovt1VaQRDa5/xs6z/9ii3w2opT/xUynLgrSqYUjjDMWVmLnQuG8pYGnNG455V35iOfi+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16045
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 08:24:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24344

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, September 17, 2026 6:16 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
>=20
> Hi All,
>=20
> This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP on
> RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for which patch=
es
> have been already backported.
>=20
> All the patches have been cherry-picked from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
> Lad Prabhakar (6):
>   rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup
>     error path
>   rtc: renesas-rtca3: Check RADJ poll result during initial setup
>   rtc: renesas-rtca3: Fix incorrect error message for reset assert
>   rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
>   rtc: renesas-rtca3: Factor out year decoding helper
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
>=20
> Ovidiu Panait (4):
>   dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
>   clk: renesas: r9a09g056: Add clock and reset entries for RTC
>   arm64: dts: renesas: r9a09g056: Add RTC node
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
>=20
I reviewed this series, looks good to me.
I can apply this if tests are no issues and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/288=
1566985

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


