Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141BBFA1FFF
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 21:42:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.93660.1776894158311925068
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 14:42:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=D7d6Hx48;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776894154;x=1778103754;bh=Z9xRn41fwMaalv/0IMYmeUBcHWnyW1DT55mIL
	lTZkHY=;b=D7d6Hx48AG1JTgIurbRslnbAJl63Jd4Sf6SWhV0RYUS3XHuuVLfT7JcRMaX5rzcroNa
	CUY6DR7FUSzCD1vN4CiKhJPDSdY/T15nglEF8+hQ1sgQud2QpzebQD5CK1ocqUs3E3yT5C60eLjSM
	qWFINKlYwpd66E5YsfOMJMVc7yJVx9kdqdaHnZIVFklAcCXglhE/s3Lpjld4XEjltE6cE0j+Zt4uH
	wh8SyGpBEHPrFmL7tMTfPXi8a6GDsaA+2L7jR4W19EZW6jnCiXHhSm1mgYcvgkQ+24LiVjNA2HNh3
	aUEIEbkuhjRwUT9bpj/G3aw/aBcLUgtE7ZSZxLyuS8JQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 63MLgY2Y1874211; Thu, 23 Apr 2026 06:42:34 +0900
X-Iguazu-Qid: 2yAbEdUNPAuGgG1CbY
X-Iguazu-QSIG: v=2; s=0; t=1776894154; q=2yAbEdUNPAuGgG1CbY; m=RpvLIfonqRRwgOdajDVCAlZ7WQ5D4GKiBQZKmCZ7h4U=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g1CPQ0W8Bz1xnZ; Thu, 23 Apr 2026 06:42:33 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSXv+Ha+yC3pgZkd5nXI2p4AEf6tQ/vnV0S2lfe6lMAyH2s1y9Pzu2OSeaM9xjUVTq2sh8NQBC/glX9Yg7PqIApnZvLhQ/ZtLl4g/edpiGGWjyGTucN93VBMmSpSu0QrBFPurZncnp2aUFrSSxMlykLWqvcM1/9mk+rR/aAZTkcGikVesQyT/Ve693Ne2VX/9FPKvGd4zd+SMBeQ5Vucx7tcnYC3zXAYlEMF7uCvVVsCVDmGq9WQEz1AQ6Tf5EnLFrzgc/mF5s695HWk+QuZFpg5jGPUNDOBOn7AO4QlsrUBASKsmS/JY2fmOSby3zxZqJ+0N7DJsQr/WveQNhRe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T+ErbqVudzw7G68n4VaEAxtSkY4OVHApY8W4QeMfz0=;
 b=jadyAHX8AjMUDk/01urLYC2kAqibg1HHWk9z4rL6lY+0TC9sYs4t4LSwQld3O7ZZPl8XNgYGbAbwiAUtoCV3oUv1OR4Sqkh+evsdi75Nzp6uaTAMQ/wzEZICRZV8xsw4sTo4AGIztmPomrc1nDf8HyhJ4+VTZDQ9pyd4A5tabYO1sjsGmNIeVRjxgPFV/kTG48OHPX0ph5cfmHk190gF4N62t19WZJI27CErdTbVompWQHIQPTLG03sFGIUc8UFLhUHsak/qhSZTT1zH9RFnCmGoXn0Dtr6CehlCNZySqTir3CyJyqRkX1RkwiP5y+KZlbETtZQh+wtyn6ENtAVtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <chris.brandt@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variable
 size
Thread-Topic: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variable
 size
Thread-Index: AQHczQRDi5unlHxi+0OhObi0LrWetrXrpa1w
Date: Wed, 22 Apr 2026 21:42:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148187DC9C6369DD3CFCEFD29CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-7-chris.brandt@renesas.com>
In-Reply-To: <20260415181810.4073807-7-chris.brandt@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB9535:EE_
x-ms-office365-filtering-correlation-id: 01f2d888-b9d2-434a-3ed1-08dea0b80e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 RUfYXmRU2fu3/5DI0naxyBMbqQdjQvZPGUCgXTKcBmbxSqUWYbG9s74hX6Dlf4ib8QVElAUJjfEhZM1x80wpGbTmDiJKjul38rdtjYtiilPoStfSTvCV2aGdcVKDMeA6U0gi/zc/3+H7yGmdnBa78JsVCjko5AWLaHUVzEEJOKJ04UJsSVqfu8H2+CE463sYKQ8izIWqquYljrsIlKKhqOJVyqjEw56EFuIc5DF5gTLEx7i1hubiKHH81npMzS6+LptE5ywxDh+6bN5yubzZVCcA6lOiUaH0CFlkh8tFnkXUrYuJzlm/FLrUcBHJixHqjIe/zabChSopS/xS/8u4x9glDjtpNcgKWFFc8TJCInK3HUEC7vDTfCDkFU/7XAxBXAjGbKFMm1ZYxFsNL2VEgCnKnDLKZlsIJdf3X27eLvGc+skAkNo3EyrKpGWdaZb7kgx+gImKEYz8JPSzaEGUh1HqYhSm0hDS4d5E9l0y9lmK3xEMhqNvaDoZF1fX0A62g4tq6PyNyLoyFaP9FNHMhtENA+ubywbTrF1rOsDVX2itK8fF1N4V0QKjfMVI1pR0ytlpOnH0g5eb5nMwcZNHIpJr2FTI3t5xJjCutNtfZqwNAonjYK03hn+RWaMqNh6ZEtcKod71DJZXgQSgJdjjTR8h+4hU9VwDNwHHrkFxW14FzxngOcf0Lb1+nBTUfKVGx8n8eviPKpfxdOWD8ZWAzmJkVTrFAyola6NcsMUeEDp9uOeqsy/xeN6+szKzFjIN
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VFYvOXpFOXN0NkxWQ29GT2d1cm52emZ2dllsb3YrUW5OL3FQRDdKWVVr?=
 =?iso-2022-jp?B?M1lCN2RoV1h5UEJXeXVOeEF0eS96QmpGL0JSaTFtalRzczlpeVJ2M3hu?=
 =?iso-2022-jp?B?Q3FSSmdEQXFXcjQzTjVPblp5dFd2c1I3ZEh2bVNUQW9admJGcGNJamlJ?=
 =?iso-2022-jp?B?ejg1QklJMU9yVTFrL05yVjh3dGxJMGpEb3pjeTlmQzJlTXZlemszYVVs?=
 =?iso-2022-jp?B?MS9vOXU0L0g5MnBXcUpBU3NobVg3ZVVOemhIeUh4dE4vRUhqM0VhaUxQ?=
 =?iso-2022-jp?B?OHBjREJJNmlmZzZpTU1ZMnU1Rmk2U2RwZm05OXYvaXZWWWYxRFBQRGNw?=
 =?iso-2022-jp?B?Z09nK0trcTQyNEFIei9aeFl6UlRCVmM3TFQzTWo3V09mNERPZ3Uwclg2?=
 =?iso-2022-jp?B?TzNXSC9XVlkxQ0h2UzlhK3JpTXVORldEUWNiZGQzbkxPR2NMWGVrMG0y?=
 =?iso-2022-jp?B?SmFGQVZkMDR4YytqL3JQLzZvcjFCVnBabG0vZ0FTMFpHNTIxQmVQazZL?=
 =?iso-2022-jp?B?VCswSTNWMUNyL3BRMk8wZWxVNVMzdll6SDNtK3JvT1Q4b1ZpQWFJbGtF?=
 =?iso-2022-jp?B?TlFWTCtVZDkxVG9CU1pCYmdWMnVEbm9CWWFhdjgxaDl1RS9LazRiYnhy?=
 =?iso-2022-jp?B?YVMrL28wZEw5NlhneEF1Slpad1ZKYWUzbVYzT3lFdUk4WnUvZGo0dEpF?=
 =?iso-2022-jp?B?VFVpcVBwUW5mWkRSWnJnS1VlOGJEWFY2TWNZNDRiU2VYR29FU08wdVpS?=
 =?iso-2022-jp?B?V3BNRGJiZXhyZFNOU0xEWE1iRGhKQ2FXZS9nbzMxaEYzRzRMMlV2bzQ5?=
 =?iso-2022-jp?B?K0tCV0ZZS3dtdGs1YTMwV3hReENjZGt1aFlsSHY0bWNsc1JXM09iT2NN?=
 =?iso-2022-jp?B?UFJFdStEbjkvTEYwTFYvS2lzOUZKSTJRODNqeS81dzRsSFZWVlJNSElK?=
 =?iso-2022-jp?B?UURDZlpZMnVSK29MazVHRENsRVdoY0pzOWFqdmVkcFZKTlRIOXlIRVFF?=
 =?iso-2022-jp?B?OURySHp2RmFsNjdZV2NuZ2UwTHVuS2d5WGpXZ3RvdXJ0RFg0LzkzbFV6?=
 =?iso-2022-jp?B?UXRiVElOMng3S3FTaGdwNGdybFBzWXNOT2tMazZTbkR1Wkx1UHRKeW83?=
 =?iso-2022-jp?B?Qys1Y0kvYm0rdlRmcktlWjI0NVZzSFJialpFVlFGRjRCSEJYbUE0VUM0?=
 =?iso-2022-jp?B?Ukpta0JlS1VFT2RlR3FlZFNXRTM3eGZ4VE43RXg0OEx0eDlXaS9HRkVZ?=
 =?iso-2022-jp?B?THo3c3B6WTEyc1piL1drYnpFUzI1LzlONXpsazdQNnM2clNPWDJ1bnFT?=
 =?iso-2022-jp?B?U3JrS2dqcWxYano5U0lPaUR4ak1YbWF4UHpnUmtWNjRJSFpBZlNjRVdT?=
 =?iso-2022-jp?B?TENOY283d3l6ZWl5SFBnTmRMaDNwNHhERnZqV0V5K0k1RHlBYnNiUDBF?=
 =?iso-2022-jp?B?ZDBseDE2L3pSMkVYamZob2RZQzJVUVlJR0cxSGZod1VndUlHQzJlR2dw?=
 =?iso-2022-jp?B?c2NCQ0taV01hSDVnNTZiSkJ5Q2FQdEQ3OFVjZ0JYTnc0Y0R1eDlBZzBx?=
 =?iso-2022-jp?B?cTlwTFIxbHRQVk91K0tmTURwazJicXlhVU0zQTRsVVZRejZ3N3dYaXpQ?=
 =?iso-2022-jp?B?R0Y2SnJlR3lXMlZveit4K0VLWVpCUXdCSGxRMVBxenNFUE5hbTFPdWF4?=
 =?iso-2022-jp?B?bTVITFU5M0o1MkFPcFBCK2o3MTRuWHVVOVRsajhvQnB5ZUg5bkIvVlps?=
 =?iso-2022-jp?B?aW9qUEJ2d3Q3NkxrYnVOR3R2c0E2d211VG5rRWR2Z2tBK0lFNVQ4R0w1?=
 =?iso-2022-jp?B?UXZNWVFRK2RHSTAyZC9URUlOeCtlNXZldTRaZ05kbDltSjk4a2tDYmlP?=
 =?iso-2022-jp?B?NWM4KzNzQzJHTjBIL2VlTlh6ZmxHYWt1TTJVLzZteCtzbVh3anpIMEZi?=
 =?iso-2022-jp?B?QkNPVFkwVk85azBDcWR5RkF6NlJlRWgxdkpqNGRGTVhFYTM5SXpUWlVM?=
 =?iso-2022-jp?B?aUV6VldLR2Uxc2xkVEJzMkxOaTVQMVVhbUNGcVJ3TjF2bEwrNDMvSXFW?=
 =?iso-2022-jp?B?S2N2bmYzK3ZwNTNiZDNDS2JvWTZqTXFrcWlpV2V4RithNUxnK3hMaktV?=
 =?iso-2022-jp?B?anErNE5kUmRzc0o1MjdtV1drMHJFUndUWW8rK1QzZ2JJelJ3RnA3Qmla?=
 =?iso-2022-jp?B?Q0V1TWpaNTZYeWQySDN2cmcvb210SjU4eGYvY2E3NEdMNmNrYzcxaStv?=
 =?iso-2022-jp?B?QlFwZitvYmdCVmZXNU1mTzcySUs4VkxtZTNDcHJnazhuN0lxaU92TW1r?=
 =?iso-2022-jp?B?eWdVeGFIR1hJVG13bzNkaFVYeC9UWWNCWVgvem5BNkNKME9UaEtuR0dq?=
 =?iso-2022-jp?B?Ri80VVY0ZFNnVithcXN3cWJaMHoyK0NESWZzWGVIcWpmVnhXaHdlOTdS?=
 =?iso-2022-jp?B?Z2VUbGovT0hFN3ZNbFMyKzFZUzl3TEk0UTRPckZSbFJlaDZYcE5rRUl4?=
 =?iso-2022-jp?B?WXR1WFphblltcXZzcG1acno4YWlIczF2Q29CUnExRFJjbnl4UXgwT1pp?=
 =?iso-2022-jp?B?QnJJTC92ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	EfCyLgz7gRbCVuah4MX1m/whh4Hv0j5/XL1ZGQlOY4wkmI3L863f8H1gZ6px5jlxf2KBXRc8NWYdzm33XL1NAvYqu8HGAI6RrgKcHssSDAbfQldu8mtktFAbYsP5TcoFLI1tcMMCNlENp0opQVYH2WQuHSDUEJuXzkJ1PoRAhs2ICbOsF4a/ucx7qIp962jS5H3HRgkGfwSF+U8vYfIiqI3gCEMpmMctKXi5dr4TZ9wqXiBAamcf/omfQU8rM2wX8iH8mkDLVqv6JheuBvp2KW5nBrU3a+eqOhEqzQNEc/r6gLNEwkmVzkIZ3S/0RJQyiLL3izsIPEOJgrWBi4aoqw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f2d888-b9d2-434a-3ed1-08dea0b80e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 21:42:31.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF57BBc/rtAWZhKBxHxbi2fqPgxllseBboewF2nuTP/MPOi212xu+6QgUku3cX+nBPiUI2GD1Ip7+ip1vVdkcsggy4vZc8C5ONjC6/OTbAOZzMgdVAXNqrENPs7Rfnrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9535
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 21:42:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22785

Hi,

> -----Original Message-----
> From: Chris Brandt <chris.brandt@renesas.com>
> Sent: Thursday, April 16, 2026 3:18 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Subject: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variable=
 size
>=20
> [ Upstream commit a00655d98cd885472c311f01dff3e668d1288d0a ]
>=20
> INTIN is a 12-bit register value, so u8 is too small.
>=20
> Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> Cc: stable@vger.kernel.org
> Reported-by: Hugo Villeneuve <hugo@hugovil.com>
> Closes: https://lore.kernel.org/20251107113058.f334957151d1a8dd94dd740b@h=
ugovil.com
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20251114193711.3277912-1-chris.brandt@rene=
sas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

It looks like you're backporting patches from LTS.
Could you please backport them from the upstream kernel?

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-=
cpg.c index 0c0d9d76c4d6..c45c22190fcd
> 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -121,8 +121,8 @@ struct div_hw_data {
>=20
>  struct rzg2l_pll5_param {
>  	u32 pl5_fracin;
> +	u16 pl5_intin;
>  	u8 pl5_refdiv;
> -	u8 pl5_intin;
>  	u8 pl5_postdiv1;
>  	u8 pl5_postdiv2;
>  	u8 pl5_spread;
> --
> 2.52.0

Best regards,
  Nobuhiro


