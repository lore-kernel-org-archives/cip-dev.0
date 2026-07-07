Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E36C43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 23:01:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.414.1783465284498316132
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 16:01:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JlvIs4zP;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783465278;x=1784674878;bh=EZPPDRro259SdlEdLUIzCohkCelnKGW1VeGfb
	mr/yUk=;b=JlvIs4zPNVsAtoyZ3N8VochoLDZIo35WlC404fp42yjWmtCMT2W1tvjW3La7ULoLp15
	3V1dK4gmIu/on7X2O2Gq2fy/d6bYbTwSsUjva9M6FPfuuePYyNT0K6ooyWKdjSzFRu7vjan9X0W/c
	TfV7y1vhwtvhXKq7BCpPZJnG0KkA6H9CXflbhdidwn15pj/35EmCQqaXMk+ZIn77L9nIx4zs+sO1L
	RxpKdU64P4LPm2l1YKhNfdkxcvfisoNfSV8Yraqx/71A4A13LzOBVef5oStlKJm6AUYg7cDRBI4po
	XvVSj5CD9ab+b4tUVKzag0XKiSX7ds5DaoQ3UVX7UO8g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 667N1Hng108576; Wed, 8 Jul 2026 08:01:17 +0900
X-Iguazu-Qid: 2rWgmtUYtdnqI9CIgT
X-Iguazu-QSIG: v=2; s=1; t=1783465277; q=2rWgmtUYtdnqI9CIgT; m=GKsfcj4yldnTd8GofnLgFDmd6XPqgRAL2C6TwSFoCDo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gvxY846Ybz4vym; Wed,  8 Jul 2026 08:01:16 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyBPo8ntSd6US9Gu7YfaghWrlGb/lWSG3wfsZUjRimViejhi2XnVQjOaL0gKOJCDv6UdDEpwuQpZtlgvq0P8fY+SBxqowugHnswPsFLfBDW9pDLIoT+t7/desacGffi24THx87CToZraI3EEReBGBrwB94C+vPiRaUL7lEMQEmHZOCpw+B2mLi6BKrJrF/OrOwnazjYQAxI4DL3ABah0bFL4K0SqrLrIFjJEalvr4Tz07MCB/+ewC3kSKNQRv9+84Ih9o+gVvhjQnzwyKRstw6pr8wW2o9XNHor4IAHRSeRGyZ62UMGeoqevUbE6UhfmG7N9Cbigv4stKt+HCeDQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/0aYSGiH+/t7PsRrbpFSd3G4oEBOx7EVctclCZwE6c=;
 b=R9LdtKOWW0UVeTFF+Nx92lH1K8LylmQP3pNP/GFMq2VR6ASQ043YVGcerSSqD0T+ge8VgI0hayYuL0+nuzS3MjVqSwHF+U1907FgI1aL2YeJvZz9+txHekFXi1Lsi/UJbTfBauhu24dKSU5++ZJJ3umE9jOMYp457wGUeXlCJoXUZfWUortST91qn7ccMfElePim6ZktE81LoeDh3q5Gh1unnK7TXCbZTtxKlHbIpCL5qFMK1XHKmFUjX34Ts/i/gNO+YiouKlzAnhTA+yUeGuSGudr+g06GqfiqeiTsjUHVEqD5hi+aYpc0PzDKRuUsg2ahSP+8lnTS2M+482/Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.au@gmail.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Topic: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Index: AQHdCtPYZZsdljBfs0SRqWzEl+a5LbZisKMg
Date: Tue, 7 Jul 2026 23:01:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818699191B380C01E457386CDF02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11928:EE_
x-ms-office365-filtering-correlation-id: 71a95bef-e6e2-44e7-2c2c-08dedc7ba475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 
 l/71WzxaPYE8x8SQDGemrVRVsjwHK9MwG3jAw0cqG+EYbOKBWG91qE45JWLcTNGyhY8iajV0Zp0hVf2B8ewVfBwn314UFJYtlslwNn2vPj+nynoKrepkvc+jbi6VPJPnzCPIuRWW8DfynL/uWGZRpFl7mbwKGTDj3A/2cRwu/Gv+q6mdgjKajkslLHmDxekvCSoCZnB3vZA2m7UCNVAW442yOvfZhGBAwhLIzb7TNNkluJkdXXQT7bQc2opIR/isD/wTpVxxQeMhD94I2oE9xwcvzv7jCnj89ax4s8fREkSpWxK6JrbIr6woIu8IjXqTOuh3Fy9Om0+gKzQx9qJNrAf8gEVFR3Z5lvszv0x4rUMXtuVTd/e0O5zgIlUSk4opWg/hBYO3rCGJlE4RR7EddY/UHMjFhgvQnts2BPkRYvVrlJBrnVyhE80svQBMZhSwtrIZBJ1nkAxswj+seKsYXG58x+ia5pZw58dXotZfWtYuGAGsRl4bn1TRmmzgNPJ4z/LtJiFMjyGPdPWnbxQnu6SLxOnoRUsm0B+tt7OTpMtiYHq7uAafJFxrOFFjpAKX98lStwR5Z6LIuZZdUhFLJFkCirFVQ1gx8vYPa/hW+u9GHoopSZqx7PhQ89W0tulft9ea/xlYgyG+pRHqE3Lk2dkcYsII778dExQwstuL823z6DHLDDLh6kgojMTXUWm3kbwyCQnntBSlvTAG9vvLtx+9q4oMYO1zDJAYzWlMuDU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YnFIeHl6YXprMDR1bkFTSU9SZjhUNGxRL3JsN0NDRXZLekJXc0lSdHdI?=
 =?iso-2022-jp?B?Q0t3aEd5cDFhVVB4QnpuK1Q2K3VDZFZjUDUvZTVad3hsa2NxQ2pJbHAz?=
 =?iso-2022-jp?B?THB4OU1XWDNPVW10aDRQOWNnNmVDWnRQWHFvaGFhYW0wbHl1Q3ZoVFJ6?=
 =?iso-2022-jp?B?WmptSXQ2MTZoQzlHVFdMR2FqK0dqREgwaXdySURLYVBmVlNIRlk1T24y?=
 =?iso-2022-jp?B?NXZnNTd2b1dIRzdJS29qblcreTVYUnQxNFJSRG9uNTYzSlJsbTkzMjBZ?=
 =?iso-2022-jp?B?eXc3REIzQ05EcWl5c1Y4R3F4Z3VNQ2EzZTRMY0orK2x0cTUzeGZHNXZl?=
 =?iso-2022-jp?B?VUI4NDBWMm5RVk1ZaGlGRW9DQmFrOC85R0xwUzJKSTB1VkZoYlJrTkJV?=
 =?iso-2022-jp?B?aExSS2o5S2NzMDV1N3lQQXl0bHVMV2RxbFFUUytacEpGRzNoSGZ0TVVV?=
 =?iso-2022-jp?B?U3duOVRRQkMxdGJLanhFZzJrSjhQUVlrZ01yTm8zMlE5aUtaM3BLd25n?=
 =?iso-2022-jp?B?OUVoNFRSY2g5WjV5VEd3SDNOUFlzdzdXQVJ2eDhydHlLaFlRZEpMRU5y?=
 =?iso-2022-jp?B?WjhBeHBsSlVldjVkV1RXNTF5MVFENjc2WFBzWTRqbGZrYlVXNFQ3OGhK?=
 =?iso-2022-jp?B?Rmh0NXFhbXlGUkVlVEE0N0k0c3phUStQM0I5RS84NzcxNm50NmFmaGlC?=
 =?iso-2022-jp?B?eTcyVXpUQUcxTkdRckY5S2dxaW1YeS9vNWNOYVEyY2crMXQzSGRLL3Vz?=
 =?iso-2022-jp?B?dzJhc0x0VkJsVG44ZDhUYW1JdGVyaTVkSWI3Y3NSYm1weUt3MklnSGFW?=
 =?iso-2022-jp?B?ckZLUk5wUGlDL2Fpdm5tK0NtZDdFMk53YlBXNVVuTVViQnE2K2Q4Q3RV?=
 =?iso-2022-jp?B?VTh6NXY5UjQzRmNjOUlRbm5yWWdZdjZtWEY3cnk3OHNwM09KazZ1emVp?=
 =?iso-2022-jp?B?Q3h6dUVFaGtaTERSMm1zOVJxY3dqQ1dQWlZ3azlubDFIbU5RYkxXMS9J?=
 =?iso-2022-jp?B?em5mL0ZxakRSMHB3QWl2WUxMMWxOenp1L0pHeE1FY1pna1NnUkxlRXNy?=
 =?iso-2022-jp?B?WVJndmZJOFVZSTFFd3pwYWpYSmdHTmZxUmhWVmJDQkxYQWVRSURwOWxC?=
 =?iso-2022-jp?B?d1dUb2xTbE1JdFk4VTlwVHRPbWtrQlBVcWNPUnJaY1lnaUZWNWRxTVBZ?=
 =?iso-2022-jp?B?ek1UdVBvdUlLUVVoSXc4Z3pEc3R3Q3hTYkh0WHBXR2FVTEFTRzJjZEFU?=
 =?iso-2022-jp?B?K0hUT1lWYmJTWmwvSG44TWxUOXo1UFNWTHlsOENuWi90SVdZeGYwS0Nr?=
 =?iso-2022-jp?B?MGVoMkJBb3hBblBqNDVPUlJ4Y1RaT1YwK1JvTXJVYmhRczgyK3drNkVn?=
 =?iso-2022-jp?B?aWdZWkhGY3V1N2dWUkZDRVRxd0Z1clE1RHFyM0dxN1FDc2FaemhObEdu?=
 =?iso-2022-jp?B?Yk5KUk4rb3ZjZHVjSlBtUjF1eG4vaFRTY0gxOWROLzU3QUplQjJ5bHlp?=
 =?iso-2022-jp?B?QkRzRXQ3dmpxelhTWHllVFBlbmZhMnk3UVFDTC9OUm5yV3V6ZjR3bWNq?=
 =?iso-2022-jp?B?QW9IdjJsbUZnSVh2NjBQZnBWM2dldXdHNkd2djduRFEycjZ6R0wwRTRy?=
 =?iso-2022-jp?B?MVdBWnM1YlRnZm45cVhPQ1BjeHBaTHNqQjZLdlYzOVdUR2NOY1RPV2tv?=
 =?iso-2022-jp?B?UVFyWGIrL0VDc2pzQ1A3RmlNUWN2L2NRUXBMR2JtRkJtd2FFKzZ0dGtB?=
 =?iso-2022-jp?B?TitNODVHNTVZZWYrN2lnU2wyU1ZRbzRCUkFOT3MxSStZN210SnpjM296?=
 =?iso-2022-jp?B?Ti8xQUI0MXJmWnVkbzZESE1kMFg3NmRTTFZqbVdwb3NPWktwWE5LQlFU?=
 =?iso-2022-jp?B?djhlYkZiaUx0ajI5MEhFNVIwVHJWTytoNFdLaUZ5eFBNeDhLbElpOHRp?=
 =?iso-2022-jp?B?aVpNVzNHNTRQQ2RDWVV4aUdhd3loZHlMU0E2OFZFYWdreG85Q05LMm5L?=
 =?iso-2022-jp?B?aXZCOWNpZW9CMUwwSjJ1VU0wOFJpQlVnbmt6RzRVNEhtSzZKNG9MTTBE?=
 =?iso-2022-jp?B?WVlzdk5QVElvRyt4aGlueUdVb2I1NFhUMGJVTkNYNitJOE9lTTJQQkNZ?=
 =?iso-2022-jp?B?Mm5FcDhRRERmU3hCVXhoZ1ZWRFV3ZjJIM2lKSS90czc3OXZnTmRJbVVh?=
 =?iso-2022-jp?B?NnJ1bE1xTlZGc01lY2pUcStQM1VySjZqKzVCcXltYmtPNUNEZmNXclJX?=
 =?iso-2022-jp?B?QUJVbkpZc0s1QlpHL3FWWk1QbUVuYUhKL3NwMHdvdjJCayswdy9nS2tm?=
 =?iso-2022-jp?B?ckZnNVVyVzFGazdoVkNaMndRelN3SVZiM0RWUGloRE5mQVloZFpTT3VW?=
 =?iso-2022-jp?B?aVVHNVFDWE9nODBBOWZlNG1RYjVvM3V1T2VlRDYzbWNKWjVNOFRIb2FF?=
 =?iso-2022-jp?B?a29xa3JlbEZtNkl4Tms5ZDNRZjJVbGt3SnBlRFppVTY2Lzd0bXlSaHRW?=
 =?iso-2022-jp?B?Q3VOTlgyVUM2MjJ2TEFoTUFSd1RkSWIvMDZITWJ4WjJzYitPcWNudnB2?=
 =?iso-2022-jp?B?QUxDdlBpOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	RsmzCGhMUssLT/h5N6LPnlsXx3bO18ow7u9hdFe26a/2c7dqhbVGU+URc6EudfLxIoX0r1NyoJHAErJVHQFpw0lgTbDM1T72RuvnqZuOFGzfH1RA6fO45R5iwwacVgC0XiaBjj2ISXw0rkSNa+Nzcg/2BNZELJ+3IzK3OoJG0aOKbJAq19PSrF34canezjVUTPAKs3ZwGLzrD0Q7LmhBA8uQPicqQeykpArrAzxBmPmXadKtsA6xmw47IM4g5f0qmJAsZjea7cjQhsx5jl/8R1fgbNymn6R7gl+0zd3GEYdpHmpNbhkDxFgCLLvza+rtP0/kC6FNr93XVpo6z83f4Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a95bef-e6e2-44e7-2c2c-08dedc7ba475
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 23:01:13.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoWLm2REcQYS5Iir6bU01RXcax4qq9v2ldnleqvRNla6+4pvhCWzxqZqN77pQb/TQhIOHBeNTZVw18G7h3EgWBfGhMKz8D5pQoheB3XoIMcySOf3zi2M9Xcolsqy/ndv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 23:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23477

Hi all,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: Friday, July 3, 2026 7:07 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The IRQC block on the RZ/G3L SoC is almost identical to the one found on =
the
> RZ/G2L SoC, with the following differences:
>=20
>  - The number of GPIO interrupts for TINT selection is 113 instead of 123=
.
>  - The pin index and TINT selection index are not in the 1:1 map.
>  - The number of external interrupts are 16 instead of 8, out of these
>    8 external interrupts are shared with TINT.
>=20
> All the patches in this series are cherry-picked from mainline.
>=20
> Biju Das (19):
>   irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
>   irqchip/renesas-rzg2l: Drop redundant IRQC_TINT_START check in
>     rzg2l_irqc_alloc()
>   irqchip/renesas-rzg2l: Replace single irq_chip with per-region
>     irq_chip instances
>   irqchip/renesas-rzg2l: Split EOI handler into separate IRQ and TINT
>     functions
>   irqchip/renesas-rzg2l: Split set_type handler into separate IRQ and
>     TINT functions
>   irqchip/renesas-rzg2l: Replace rzg2l_irqc_irq_{enable,disable} with
>     TINT-specific handlers
>   irqchip/renesas-rzg2l: Split rzfive_tint_irq_endisable() into separate
>     IRQ and TINT helpers
>   irqchip/renesas-rzg2l: Split rzfive_irqc_{mask,unmask} into separate
>     IRQ and TINT handlers
>   irqchip/renesas-rzg2l: Dynamically allocate fwspec array
>   irqchip/renesas-rzg2l: Drop IRQC_NUM_IRQ macro
>   irqchip/renesas-rzg2l: Drop IRQC_TINT_START macro
>   irqchip/renesas-rzg2l: Drop IRQC_IRQ_COUNT macro
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Use pattern for
>     interrupt-names
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3L
>     SoC
>   irqchip/renesas-rzg2l: Add RZ/G3L support
>   irqchip/renesas-rzg2l: Add shared interrupt support
>   irqchip/renesas-rzg2l: Replace raw_spin_{lock,unlock} with guard() in
>     rzg2l_irq_set_type()
>   irqchip/renesas-rzg2l: Clear the shared interrupt bit in
>     rzg2l_irqc_free()
>   irqchip/renesas-rzg2l: Add NMI support
>=20
> Fabrizio Castro (6):
>   irqchip/renesas-rzg2l: Use local dev pointer in
>     rzg2l_irqc_common_init()
>   irqchip/renesas-rzg2l: Use
>     devm_reset_control_get_exclusive_deasserted()
>   irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
>   irqchip/renesas-rzg2l: Remove pm_put label
>   irqchip/renesas-rzg2l: Switch to using dev_err_probe()
>   irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()
>=20
> Xichao Zhao (1):
>   irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM
>=20
>  .../renesas,rzg2l-irqc.yaml                   | 157 ++---
>  drivers/irqchip/irq-renesas-rzg2l.c           | 627
> ++++++++++++++----
>  2 files changed, 536 insertions(+), 248 deletions(-)
>=20

I reviewed this series, There doesn't seem to be a issue.
I can apply if there are no other comments and no test issues.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/26599=
38341


