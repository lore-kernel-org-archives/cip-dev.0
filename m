Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25D10BA431
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 06:19:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67212.1774592354393867550
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 23:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=b9FHI5On;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1774592349;x=1775801949;bh=3ms01bnDX5l36ujCsZsGcq8y0KgOBU3C3u0Vf
	paB8oI=;b=b9FHI5OnWz9/eznnrp2lUNE/BOSbVs4XwGXLBuipvl6mfguUSVA50odceAAYz6xEK2i
	UReKKfrWw3oXFu/0pTTSkOuXeMV8THY0Hl48lBrv2ShjYQ+Nztb337ajEw3oSP/S51SsW4hDgKhoF
	VHAlX60SEn21/eEuZcaOKzlcjin9gWkD00rMv8Lk6/5CKw0s06SsXtFneC3hijDLwFk8LQZzdZqwZ
	pn/BKPmhLoVhTPE4ckgjt61RU0QtZW/sO0u69womMwjJmel/pfM+qH3SuTHtgpmQ0XmkZW1gC3AEe
	aXzpsxVTT4tZCYFGr2FuREu4K6OEeh5WMy7ztoV3JdVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62R6J9KB4125080; Fri, 27 Mar 2026 15:19:09 +0900
X-Iguazu-Qid: 2rWhfSiM6vPvzKHURd
X-Iguazu-QSIG: v=2; s=0; t=1774592349; q=2rWhfSiM6vPvzKHURd; m=YjEMcoptI04yuxEdJxlcPEXyweO+yh3s3yEs9KDxPbI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fhr7w2zbDz1xnj; Fri, 27 Mar 2026 15:19:08 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvbBQp/iT5rpFzE7ApXr9TN+yiWP6idZmdteWsqyESVnLBxxOJBKQILyTAq0Mn0LoTweXis2Je/2GC1bXvOIHCho+oIl6a4y0kEk9sXRpVa/6XKn0nS9s3iISWu5rhBJ5pWNKSyvUDFytoA3a5URCAKg+1Nw/VU3HDNk41uL4qVTn4s4Ok/bX4DZhUzQRXpLa8zTCeV2mRRHJByKm8IzpO5B8V41jxQ6/aZKeN8zjioVemr8VuqrVHP0SSZ0St/gT0HRAUvwZLJU6UqnXZyA+g5/k55KceAcs0wNnRxEKtx1+4IX2EiMU80B/Ug9tGwTBjwdxkNq4AHbWm8EMHKPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+V6iV41uVkGXY5cO8owd2rIRHFC56M+bHT0pU3cgsc=;
 b=dNUat1wb9Gtvl3UrogLvSLOehK5sLpt4oscngC6UYyD1GvQl22IDvFwDki7DkhcX6eP2lbhJ9NkDKtmD2JA7enbD6F19kea7hbt46oI/wyF3DuwTvBCT/cOIhbE/yhZBWVaeD+i1nacS97K1DFw5+kuAlFOWJdy2iCeYLo9FwsuuwdI+K3UYde2BHO26enua10pxtmhlKOEMaLAmBJ4B1YGaiWYjENj0+Sg8eKKu96dZvpum6L/nap732gjQZDBFhJJQ8yxvVdnvcd8jBVA+pqsp/SRp5MmzHpVDsPyoCPZNCpr/9Yux1MEwYeM1fPxJDnxlnjhJ7AbTqUxcaXBrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <biju.das.au@gmail.com>,
        <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Thread-Topic: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Thread-Index: AQHctf+lrnEHyGO3j0CCOOYHZ0oUSLXAbC2AgAGJKOA=
Date: Fri, 27 Mar 2026 06:19:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BBBAE28FD1EBB546EE7FCD57A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
 <TY3PR01MB1134618D8A4896B5FB8A8D3AE8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1134618D8A4896B5FB8A8D3AE8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15849:EE_
x-ms-office365-filtering-correlation-id: 16abbbe2-3283-4e35-6668-08de8bc8bf6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 6md0JbSh5TNBqzl+g3ojOCdiA8FNDIRB71Uq8bnN/3T/8ysK71lb8VgEJek81sUbNOAkgmd8OKQsT12Svgr/FF/6MuxiTHWlu7BTm2romjyAsuUFF/5K3XuOfKCwj+MH0xpzemFeBnJyvln3DWKsCuh1mIFe08P2ZIqa5xiJJ9KXmvRS/Uc7QqK7iNS5SfzsIdstoRGhrw5A6DpaXZPnetgwAHFDvqJj8PzbGsL0xCntX2OFONLgBYDV7km1oVelRVvoBDXwOpST4S2j2dQhRRye9Kc9RWaQVXmWGdkhdIOgfhi3bG0aowGiFql3vo6JBz/eDNvLDS82+bkUeA1a6QCy/orV7VEmSxfDQdlB+ivRq70JKHrYBy61B+hhQl5ReQdJ88/oq3RxCOcT1GhmsoDlLS//BLwoR7EbJHcTm5jNfMr9z6WSRgMRhpXBZVO30mF2xDoIEe+/8CDAofkd6wWyJDavRgKmnnCIMQNRJwzQezYpiPHJxUW4hvvNFNbL1HOm0xK3Phs1N4dQ1tqIOYtxeuuyyKS5Sl/7CWz6tFnxuoonBbnsp8qM76jMqf1Nfve2kAIuoUaNIhuWMmHXYpLCyHmEQWD0oBbrx5xarBhFKqOqlipK3+R5tSTaIhdsZ3Sf53Y2WIG76KezwauLt9XIbHQxm1NqwegSy4DSHF1PuAN3E23TZ8IeiSKQCiztE9fAO2c/C6bwnjgF90MmCs610o0LKq7EYEBvCANDO1VkSuYGPiue7wObDPN5pSx7DO1LGhqE3tkOG3DQ6861barBczHQWBB87UhjHONTu/o=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UWgzNzdjL1hCbm0wYXVMQU8weURYdDFKREt6alRvU1dmeS82a2VjRWpw?=
 =?iso-2022-jp?B?OE9CNWNhTjVkQWdLbG5MN3NBSEtaMURzTFFVS0FHN21hYTVOSmhpTTl5?=
 =?iso-2022-jp?B?NklDTUlrSjFmQ1p6bEtFcWlDSmxKcUF0cVdBT1hpdGRxUE05ZS9Tblhm?=
 =?iso-2022-jp?B?NlljZ09tY1JTYVg0Qzlaclc5UTAzaWdIK0NIZnVIRTdQNitHVVdOQ01p?=
 =?iso-2022-jp?B?YXdMcHVPSE1Vd29RY3RvYzIzV3ZqRmJwOXhpT255dlljZTRSNTNaNFp1?=
 =?iso-2022-jp?B?TU9rMzFTRVBnWjF6MTRGN1VtdzdsUDU4WVhaYmxBYThtNWpwZkxKWk9Q?=
 =?iso-2022-jp?B?NHdIbTFtVnNFMnBtaUhKOTEyM25KbzREL1Z3TDZNSEt5WG9RdWJLc2JF?=
 =?iso-2022-jp?B?UGgzcDBHQXNjZlhxUGFWVURBQTRBMFZ6YWRLd0Q3ajNudkt0V1ZJQ2tB?=
 =?iso-2022-jp?B?QVQxd3FIcnJxdUVnNnN6dytnT0puQnU1RnErT2dnWHJFc01hb2FlVkJu?=
 =?iso-2022-jp?B?MU5FbkFHaitlQ1dLcUdyN1ZXZFdhMSsyT2Z4dmNRTXRvNHBObENiNEJW?=
 =?iso-2022-jp?B?SDBoMnlOcFdRWXN3SkpqRkRUU3lrVlMxbjkxdVo1ZUFLSHlXaEJ4ZVpo?=
 =?iso-2022-jp?B?eTZzSjBIUW1IVkhnYWt3VVNnUHNuczFsd0tiUkl4NnRwUTNLRmpWc2l0?=
 =?iso-2022-jp?B?NnJuZm1NbVZ4NGdLNkc2aS9yMFYwZ2g1K0tSM1l5NVRjdy9lSnN2OFZV?=
 =?iso-2022-jp?B?aU94eVZPeTFuSnVzZFJXc29vSkdHc0VyQWlPTHJXaTVod1NRdE1mWjdU?=
 =?iso-2022-jp?B?eCtVOUU0WGZ6SVp3Ni9jN2lQMmwvYnN3V1d5MCthRDhsUnZDTGdtLzZC?=
 =?iso-2022-jp?B?bmlsUzA0WHBSQlR3UEJ2bERqajkrYzdVV3l3ZGhraGlBbFpHNWdKQWUy?=
 =?iso-2022-jp?B?aTFETGNZZFJTTjFSdEJxRzdsYmdMUGk2YlY4dmxOaWdaOE1ZU3JOc3ZH?=
 =?iso-2022-jp?B?Wk5ld1hWZFpXdlZmaGFjangwd2tHV3hFSm5ieEpUeHY2ZUhON2xwU0du?=
 =?iso-2022-jp?B?U25GVjcxZkdoS2tWZUUvM2N2SVR3OExMWGs0K2srZHBjWGYyZTAwUk5G?=
 =?iso-2022-jp?B?V2I2RGpiQzhhczNsalIvRXY5bVJXbG9PSTJLelNQVmJObUJ3MC9tSjNG?=
 =?iso-2022-jp?B?ZXZOZ3l4ZWUxUGVmbFlvYnN0aDk0KzduRmduUW0xWWFBTFBQU3NpR09Q?=
 =?iso-2022-jp?B?aWdQaUwxUzNOMjlBNWFGa1RrZHkvQTM4V3RGTG5sNUxsNkpPUHQ3R1g4?=
 =?iso-2022-jp?B?WTR3bCtUWDVhN091TXhKQ1ZHTlRGd1RxbEF1Tk9XVWROeTNtTUNDZE9W?=
 =?iso-2022-jp?B?aFIxZlNSOFZsYjhocWZZNXl3VWJSQm5qNU55ZU83SFFBN3Q0WEVDaUVi?=
 =?iso-2022-jp?B?ZEl4N0dOdUNrTW1GRFNaZm53THFXdXFXT3FOdVM0enF3bndjbkNHekFx?=
 =?iso-2022-jp?B?TkZVRVRIVzNwaVQ2eHFEUHpBakJjZE1pYmNhcHZhUWc5WElLSkhFVnZR?=
 =?iso-2022-jp?B?TmpONDhhQ2Qxd3M2cmxWVVJ1UGMwa2VKRGFBVmxaa3N6RzQ2eDkyNisx?=
 =?iso-2022-jp?B?VlZjd3pRRWc2VUt3T0xrU2VTWnRFRXMvRGZhelYzU0YxY05VNzBZUFVS?=
 =?iso-2022-jp?B?Nzg4UE1rejRmRnl0VTFtOUk4N3R1eVRPTUlpTTFUVWFKeWJOZXRLMCt3?=
 =?iso-2022-jp?B?ZWp5UjRnSUJOTk1qMDZ5a3VKOEdMN28vdzVGaXRRdVIyNXFMU1pCSGpL?=
 =?iso-2022-jp?B?SmxJb1pIN1R6MGlDSklmYkxHSmhiejJYRm0ybmMzdW1CeDg1SCtET29x?=
 =?iso-2022-jp?B?RHJ0T0hrK25La0ZsMk5NZzZWb29VK2lIRDI5bHBhbEVBTDZkdFdYdmZ2?=
 =?iso-2022-jp?B?ZzExc0FHRGFMdVlySGlLbFlIVWJJU2JmbnZjeGlYSml5TDNoVUg2S3JP?=
 =?iso-2022-jp?B?MGZzcTdKL1RrckZzL0VtRjNpa0tnYXNNVndESkhJb0JXYXN6R0xXUjJO?=
 =?iso-2022-jp?B?eGR6YllVOVFxWUU2UzM3UkRNdmZlUFBKallHUEovbVo0cEMyQWEwQ2xZ?=
 =?iso-2022-jp?B?QmRWUVBhWWI0UWhzZWdVamhkejhWQVRZVjZFUU55M015QlFtREUrUUNw?=
 =?iso-2022-jp?B?dFJUaXJ1ZWRuNnBjRGloNHVQdkFzYkVDb0ZPRmNTVXM2SDFWUWpEYjh5?=
 =?iso-2022-jp?B?NmplRmc2ZjQxNkt0YnJvMTV1Q1cvbWwrV294TEdKZ2NHVGJGVDR2RktW?=
 =?iso-2022-jp?B?Q2dIVTdmMFNvN3VYYTQrWWxqZnNlaGx4TVNrWUJ2T3NiRFA1MGVSdE1O?=
 =?iso-2022-jp?B?dDRuVEFWa2EvZjJhRkM4cWVpVnpTeC9PVXJ5WUlJR0dxSWhRQk12Rzdj?=
 =?iso-2022-jp?B?T0RIWHhhbUVma1dEc0g0Q2VNYXNrKytlcnNOMFZyYWowTnB6TUVSQlQx?=
 =?iso-2022-jp?B?aFNwMG1DVitWWkxrK00xQTNSWEljc0Zzd0hWcXIzWHR2MnNCUHFtQk9P?=
 =?iso-2022-jp?B?anRHa0FUND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	cGX3FZlUKvcI/xD8hHmnw3KQCGlbDzqGqH4gv3aBmWpnUfAhjmHtyD+Gj56Oqj4U5tNQlmeoSotZQOrYUUA8tlTzTTOxFLANT7o2kUa20CyzTWYmmEhdzsx0wYAJBhyMnmSPimmrqqxh032AeFlTQhToHpq6p6P11fS+kCuTqZ8DSfXR49vp2zyioRZ7q9VMtZr7CxryCCHUWCpdkx9OCx12DO1i7YJ4i32eOo9SeEe1wnV9815JUUsw8A27LiRJq0OtFv/rTRsISo7cLG0Zf1+XQdpTZzna4B9AlNrPYcsOIGNdVuI1WbVLY5mHZGKTAmqmMwvC2F6AP4naw9+1kA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16abbbe2-3283-4e35-6668-08de8bc8bf6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 06:19:05.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkZKj1fgh71g4QHT+O6lP/YULSUpfwIeepXp+BFoBeMY401W0kgVeYal2AKoUD0N46FRN6RJ+DC8XBAiyvyqaaIGhJcwSGZ+Mcaf5sYPD3kY1k7NP24TFEuAXKtjtvKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 06:19:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22588

Hi Buju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, March 26, 2026 3:45 PM
> To: biju.das.au <biju.das.au@gmail.com>; cip-dev@lists.cip-project.org; i=
wamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel=
@nabladev.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
>=20
> Hi all,
>=20
> Gentle ping.

Sorry, reply was late.
I reviewed this series, there are no major issues.
If test is OK and there are no other commnet, I will apply this series.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/241013594=
6

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

>=20
> Cheers,
> Biju
>

Best regards,
  Nobuhiro
=20
> > -----Original Message-----
> > From: Biju <biju.das.au@gmail.com>
> > Sent: 17 March 2026 11:16
> > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > <pavel@nabladev.com>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev- lad.rj@bp.renesas.com>
> > Subject: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Hi All,
> >
> > Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> > RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E
> > has
> > 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> > (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> > resets. It has 6 irqs compared to
> > 4 on RZ/T2H. Add support for the hardware flow control.
> >
> > The device RZ/T2H is not present in 6.1, so squashed all the binding
> > patches into single commit that document RZ/G3E RSCI.
> >
> > The set_rtrg() uses field_prep() and later replaced by PREP_MODIFY But
> > field_prep() not present in 6.1. So squashed the commit.
> >
> > Replaced kfifo_*()->uart_circ_*() in rsci_transmit_chars() to make
> > similar implementation with
> > sci_transmit_chars() for fixing tx issue with 6.1 kernel.
> >
> >
> > Biju Das (21):
> >   clk: renesas: r9a09g047: Add RSCI clocks/resets
> >   serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
> >   serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
> >   serial: rsci: Add set_rtrg() callback
> >   serial: sh-sci: Drop checking port type for device file{create,
> >     remove}
> >   serial: rsci: Drop rsci_clear_SCxSR()
> >   serial: sh-sci: Drop extra lines
> >   serial: rsci: Drop unused macro DCR
> >   serial: rsci: Drop unused TDR register
> >   serial: sh-sci: Use devm_reset_control_array_get_exclusive()
> >   serial: sh-sci: Add sci_is_rsci_type()
> >   serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
> >   serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
> >   serial: sh-sci: Add support for RZ/G3E RSCI clks
> >   serial: sh-sci: Make sci_scbrr_calc() public
> >   serial: sh-sci: Add finish_console_write() callback
> >   serial: rsci: Rename early_console data, port_params and callback()
> >     names
> >   serial: sh-sci: Add support for RZ/G3E RSCI
> >   arm64: dts: renesas: r9a09g047: Add RSCI nodes
> >   arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
> >   arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes
> >
> > Cosmin Tanislav (1):
> >   tty: serial: sh-sci: fix RSCI FIFO overrun handling
> >
> > Geert Uytterhoeven (2):
> >   serial: sh-sci: Call sci_serial_{in,out}() directly
> >   serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
> >
> > Krzysztof Kozlowski (1):
> >   serial: sh-sci: mark OF related data as maybe unused
> >
> > Lad Prabhakar (3):
> >   serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in
> >     sci_shutdown()
> >   serial: sh-sci: Sort include files alphabetically
> >   serial: sh-sci: Merge sh-sci.h into sh-sci.c
> >
> > Luo Jie (1):
> >   bitfield: Add FIELD_MODIFY() helper
> >
> > Max Filippov (1):
> >   serial: add PORT_GENERIC definition
> >
> > Thierry Bultel (7):
> >   dt-bindings: serial: renesas,rsci: Document RZ/G3E support
> >   serial: sh-sci: Fix a comment about SCIFA
> >   serial: sh-sci: Introduced function pointers
> >   serial: sh-sci: Introduced sci_of_data
> >   serial: sh-sci: Use private port ID
> >   serial: sh-sci: Add support for RZ/T2H SCI
> >   arm64: defconfig: Enable Renesas RZ/T2H serial SCI
> >
> > Wolfram Sang (2):
> >   serial: sh-sci: let timeout timer only run when DMA is scheduled
> >   serial: sh-sci: simplify locking when re-issuing RXDMA fails
> >
> >  .../bindings/serial/renesas,rsci.yaml         |  160 ++
> >  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  220 +++
> >  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   64 +
> >  .../boot/dts/renesas/renesas-smarc2.dtsi      |   13 +-
> >  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |    4 +
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/clk/renesas/r9a09g047-cpg.c           |  126 ++
> >  drivers/tty/serial/Kconfig                    |    7 +
> >  drivers/tty/serial/Makefile                   |    1 +
> >  drivers/tty/serial/rsci.c                     |  728 +++++++++
> >  drivers/tty/serial/rsci.h                     |   11 +
> >  drivers/tty/serial/sh-sci-common.h            |  183 +++
> >  drivers/tty/serial/sh-sci.c                   | 1296 +++++++++++------
> >  drivers/tty/serial/sh-sci.h                   |  180 ---
> >  include/linux/bitfield.h                      |   21 +-
> >  include/uapi/linux/serial_core.h              |    3 +
> >  16 files changed, 2348 insertions(+), 670 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> >  create mode 100644 drivers/tty/serial/rsci.c  create mode 100644
> > drivers/tty/serial/rsci.h  create mode 100644
> > drivers/tty/serial/sh-sci-common.h
> >  delete mode 100644 drivers/tty/serial/sh-sci.h
> >
> > --
> > 2.43.0



