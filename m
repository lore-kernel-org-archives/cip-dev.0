Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744CEC43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 07:43:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63986.1782978198816766326
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 00:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=SrLkxGOm;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1782978194;x=1784187794;bh=yOClBOeTel3Ap/DzUi/NA/+MoYq49hR9A9QjG
	SuvmmM=;b=SrLkxGOmP7w0r8mpz9WGL2aHqJqHd9zaIraFikSJlxn35qraGfo2qIBRBEqM4QoBFoA
	73IbRxWFm86i7FjiqRhQu4tCx4WpZNyM4rVZaKLCYj8EQdB8iSz/rhtuVPasjf8GbkN6TLlIu+vdC
	SpKu196PZa4dlvMaKXFTOnkRzEnH7/8suikRmo8UuKs56tRLWRJmjHutdMnA8sthLWx1xjxLuovQ8
	ETvKNsdVL2O33WjzMeGm0/IUvRVqmSJvkAcHdKn5ktleAdCgDYoDDkeV7dtF/sIoYUQSHgOX/oJR5
	LTI0vwTX5gQK/TPGu0K6rwyx0lUH+THDJgrv5gqNBnzQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6627hEF22075013; Thu, 2 Jul 2026 16:43:14 +0900
X-Iguazu-Qid: 2rWg6M5YhEMVWYvxvo
X-Iguazu-QSIG: v=2; s=1; t=1782978193; q=2rWg6M5YhEMVWYvxvo; m=X3oXlHmEnWbp4r5Ui4nA7C97+l/rsBQxP8+txM0eMAs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4grTQ91NKgz4vys; Thu,  2 Jul 2026 16:43:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs1k+T9xqCRRRJ5EnuF2avZi8dxXD/knMN7KGVCjA58pv0b04hp9QWn8X9DIlQfvR7pWoeXJmlwLeq++JjAfv3iud3AjSRQ1MPtAM0RZDOQ/+L4IVdo0eKZBVBy6vzSrQ0LDJLRkmrX+Hg7ohYi4UzpdrcowJjQ2FqKAcKGBMh0qjTQrAl+Cb3rh/WidRW2I6A5CJbbm2Ttymj6hAcNRrNfcM8qJbmrp1+jqZaaQbmDvinZPVzKqCDGb3EewYQxy/YMcQIjGv/V0ktdN/eKR91Ay0S5fra5CsJAJY19whSAuBbFSoTh5Cthg/erxvjzoH3/z2kWQvbPpY7BcX8PVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAreafuuvNclU6Jf5l3JUOlhyaQYzYI8/FosxwLeCq4=;
 b=QuY1vArGARfE0ZIHM5iUmKLpxQkgk05UEygbKbvp1nyLEVucHmKduYR0W+XkZ+/2JtsCm2zTGjgdL/9xTcx2QASFghuzQuit3OWNW13r/ve22+7bWsVomgc8QNo7qLTKVTWXDZVZazca3UQj6ZUdOBDGShsE06+AoV5TKGZp6lagwPNlIMLHBlwOvMXRcSHxpVLKJY8ekg7A+Xi68reVQtkE/BcyuDHMRcxE34bDNTG6gujIVUzzX7drtrgsPEWcKiOdsothLNeNu7SEA+SLlXicsmXuPEj2xSdc26Ltxp0ncZN73WVCM/GF8M5D/9hp7JMeDub6lNZ53LmmsWISVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.au@gmail.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support 
Thread-Topic: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support 
Thread-Index: AQHdCIZhk9rqjd5IZki4hXiV//cBvbZZ27dg
Date: Thu, 2 Jul 2026 07:43:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184B8AA70882BB40F17F53CDF52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB10200:EE_
x-ms-office365-filtering-correlation-id: cb4dde2d-cf9f-4e2b-ab9d-08ded80d9092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 v3mIZpoxzC7eESpvSVjqYwl4NlOoC1AW72Ejb/fjQHttUNSODbOlbsDYy0/gZDZdWnBcVatFHl5UrwNmnvU7tCi6xoSfyWpUvTYWVllRtXlP+oHp4eXCKG8TpVcGYPzNdXUV2tX8ijUTp68BQ40pUlEk6GmvSfR5fCs/Ob4vl5Q0EKdoHn9APr/LUsDzyueVW1P/FJ+Km4FLjnI3ioMSgT8FBwItNB8ahMBnjReZmi5S5mIt0Sh47laKfSqv2TxT1NiEai+si5u5qLA0fjCpd4g55jDpUC2vTFQhVDkH5s4kPDMRbw6rWmtT48DivexyVBpgS5cMVngaCxLHVBgH1MWzNn1t421TXT0b1mC+7NiSXQDNrmv2zq/RjHgI4l2pAIETuTSPBFmHe6gVyUzLYSY9hDdlUB+XEPye2Bb7m3amvQguf6puUZasQpszXcOMiscLrrjzrk5hgM4YsLRi9MC+utWZD3OayRAOco1RHD7ykEwGre9ShWXTZg5Qeu6JxAQ6FrQeGUJVbrqLbC/m4EEnxasePbf2IVR/XmKevioDgdz5DwHegSk1e7BO8JFiw/aS1v1qCzsszMzct4ZlVytRdyvoekfDKKCZlUTsHNy3fjb3Yn6SodwapGtMBPqOdphyzluNyqVQmhpASMZFj7959hzTv+/uxnAH8D5vO6KlKu/GxcY+pX27wcHPiyXcknQXHnBwmTO/c3aSd+KyzH8+iJ0d8hTEBHAQqGQGgJ8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U05ZL2VEOFEySTJEOEp1ODJYZVpGSm91MWZVZEVCc1BFV3NMZzJzaStR?=
 =?iso-2022-jp?B?aXQ2Qi9UaG5JZUxZS3RJQm80d3hIMVdkWkQzY3Z5TlUyVnU4M3UrRkdL?=
 =?iso-2022-jp?B?ZDZCRDFab2RxSEc1MlJYby9CQ1dNWktzTHVnM1hmaFg1MUVLMjBvcFhn?=
 =?iso-2022-jp?B?ZzBaeW1yL21jMlZxWFBweEZnWUFwREJCaERCa2RvVXpOQkxkL3UrY0RM?=
 =?iso-2022-jp?B?Zy8yNEtERXlEL285YnZQVHdBdmprV09pSUFqUWJ6Q0htcUtwQ0JoQXM1?=
 =?iso-2022-jp?B?WFA3dVEvcWNKSjNZV1o4RjFxaXEvVzhsRk9OU25KLy9Fb21qTUJnd21m?=
 =?iso-2022-jp?B?ZkFzbGtCb3l1aUlvUU9WOS9tMjVzc0hPL1Iwa2xubFZySDNsNmJPa2VF?=
 =?iso-2022-jp?B?WkZrVmF6MDd0VFRZcFlEZEhXcW9kRTZZaCtVajNiT3VrYWx5TlB3eWpB?=
 =?iso-2022-jp?B?bU9aejR5cW1iMXh6Y1pEa2k5UFZZOU1jZURHWXBjRWlkMDQ3elM5aGx4?=
 =?iso-2022-jp?B?bkNDd1J2b2k4RTlvS2MwY0x1VFNicHZwUGxkSWt5WGVtM1ovQ1d4UEdE?=
 =?iso-2022-jp?B?emViVEdVaDR4eTVhdXZkYlZDZ2xQTmJzWHlMMG5WVlF0bkdvL0E0TlBO?=
 =?iso-2022-jp?B?bUZNR1RsMVFVK2trNmhmOW9qbVRNNXF3MEtZSWtjUkJsQ0tQTnpyU2p6?=
 =?iso-2022-jp?B?Z1FaZk9FdmI2QnQ2czNudDVFbDBXV1EvZERnUGtvdXQ4S293RmQycmYw?=
 =?iso-2022-jp?B?SXo0TStQY0JRSlJXTU83MW9oVHZ0ZGJ4YWYrVVJob3poN0ZCaXpTN0Rt?=
 =?iso-2022-jp?B?MEJlaWYzNTZvQnNKbUxRbDVFQWQvTDh0OWVCWEhTa3JNcFBoUVdEb2JR?=
 =?iso-2022-jp?B?OTF3Y3dTMHNOWEM0aHVPdjlOZ294Zk1lNEUxQ0R4QU1EeVRDdmpLUmt1?=
 =?iso-2022-jp?B?RWJjR3pZWXpuZUlGZzB5M1dxWWc3VzhzMUhHcEV5RWxlT29XNWlTWDJv?=
 =?iso-2022-jp?B?SFQxNlVkTEUwSFhzVXhxWDlQTHJXUmtVTmRNOXZ0MkVaLy9TWmNlUlI1?=
 =?iso-2022-jp?B?MDRMNlFvMGxBbHhnaThHeUwyRWt1QjkrZS9XRGhrOWkyM0MyMXZ3c255?=
 =?iso-2022-jp?B?RDFFQlUvZXhrNzQzTTZkNVZucGpmMGM1R01nMUdqL1BYREF0eVd5SU90?=
 =?iso-2022-jp?B?VUFmMVI2ZHZCMTZ1ZE9WMW9VVWFkU2lVN2M5dm9JaXpQLzBFaThRTWRz?=
 =?iso-2022-jp?B?a3pSUlhDbkZqaXVWbDNsaWVKMHhEeWZuUTh6K2k5NURGemxoTVJ3aWpo?=
 =?iso-2022-jp?B?eEt6QklwbmZNbVZ1OWdlS3M4R0NFZDNhejFlbUVpOW1Vc241b3IzNGZF?=
 =?iso-2022-jp?B?Z2RRVkk4RHdqT3ZrR3MvVXQyU3dVN1BaSGx5TGM4OFZNMmErOHJJOCtn?=
 =?iso-2022-jp?B?NTIrZ3k2Q3VOVHRKcVB6YldLaGE0aHFicWdsMzNsQkZkUHBwNmNldVAx?=
 =?iso-2022-jp?B?RnhqSVIvVCtialdpWkg3WHdyVnZLS1ZYdmhuUkd6ZjNHVzUzckFLdzdK?=
 =?iso-2022-jp?B?c1FvaVlycDlDL3o0d0J6aXNENEtONi9TUUhzdEJQR0FCV3djUWh0UGkx?=
 =?iso-2022-jp?B?bktCbU5JNXJTLzI1SU9zVTVML1dtRUVheFBqR2ZSSE51VUxmNWp6b1dj?=
 =?iso-2022-jp?B?UzJDMVlEWTJWS0txc1k1S2RTMkFWTm1LdE9Tb09rcW5BcTNPU2hyR2U2?=
 =?iso-2022-jp?B?MTkwMlBzMWhhU3FnazJQZmRXYWFZZEI1akxkbnF4U3kxSGNuRDA1cmJl?=
 =?iso-2022-jp?B?L3o1Vis0dCtGcGg5ZXgxQ2lvWnhYYzh3dTNDdjRES2Q3VWdTVTVtSFB6?=
 =?iso-2022-jp?B?bE93Q2RDQTY0aU5qZmg3Nm5WbzIwdk5aSXI0RnJMc1hYekhXRloxdzdW?=
 =?iso-2022-jp?B?N0dmUUlYU3F3cU1GanduMFZHaUJvL0VrK0VlZEQ4YU9MeDhMdXFVdnBC?=
 =?iso-2022-jp?B?NXhTNmJPK1FVZWY3OWx1K05WaSs3QXZNSDhuZG84c0xkdzRoT0p3Y2tP?=
 =?iso-2022-jp?B?QnI5UzdDdnFTQTdRNjZiUHM2YXNaeUJkbHg2YUVDakpjQzcvREV6S1U5?=
 =?iso-2022-jp?B?SysrVEMvU2N2eU5PYklFL1JxREVpbiswbVl0NDE3U3BKOGp0R1FsaEhu?=
 =?iso-2022-jp?B?c1hQd0MyVDU2S1NzcWgxMTBheG9IcUpZcnNkaUVyUDNUaDA4WXRIUGVL?=
 =?iso-2022-jp?B?OTc0b0tpMmJyZnVYREtsTGp4QXF2S2hoM1NrM3ZWbFA0ZStwU0FwOTZq?=
 =?iso-2022-jp?B?cDZnR05JVG8wbjBLZXNxQWkyUXY2RytuSzlOb2VyS1pyWDJoMC8xMnJV?=
 =?iso-2022-jp?B?TFp2a3N2RWt2RThoYXUzT0VneUt5RVJ0ZzRSbVpQTjhkUHMrZ0lxVlE0?=
 =?iso-2022-jp?B?UGRsZjNxYzV1eTdJbEJLTjhGTmYyd3htN1VFbWVIQmU4VitWSHJjTWJS?=
 =?iso-2022-jp?B?SGYvRGQ4RzM4U2czUTNlb0V5ei9teDVsNkJMbE5qeVBwRTZ1QWg1eUo0?=
 =?iso-2022-jp?B?SHNlcU42RT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	VqFYYqu5dQugPbEKZOZeWQqBwLUpMdhlK2u40IRE9HQTu4EMDlmhM7UPlWnuvreMqDw06x1A7cfVG68C6O3Bu9cIK9YVNpghulcqDYY5Ku9/o1y2sDTTJ0CUH1bh3vZamyMZ146GL2NP2PFMiOavO1OQQsOsRtEDk2y9wXhjlDBPj5WtCzs0SXKGwapK2EBUI9N19w8sEdmPRBJeXcMZmp8QjSsqMwViTRLRKK51BlTI3QKtVWWf6cZK7mkPBMCfIQuJRhFFmAXo+mgEoNQWofrWUFm4Wvra36p92UuemuEyg1RRx/f7BhSa+9aVYW1h01gOD/+3Pi1H7tLuTfNaSQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4dde2d-cf9f-4e2b-ab9d-08ded80d9092
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 07:43:10.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tDE2vZ3cV1cEej8MG/8BgsPj3XGe6xsjXgiJ19t8Vow5gFJ3Hwpft0p4Ch+ps7zDaF+y7A74na5yULWEMJ9l6KR5XUljixILR9V/yqM+JQo4Gn8mct+pEoATwJ4blG0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10200
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 07:43:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23375

Hi all,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: Tuesday, June 30, 2026 8:47 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This patch series add minimal boot support for RZ/G3L SMARC EVK. All
> patches in this series are cherry-picked from mainline.
>=20
> Biju Das (31):
>   dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
>   dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
>   dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L
>     RMII{tx,rx} clocks
>   net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
>   dt-bindings: soc: renesas: Document RZ/G3L SoC variants, SMARC SoM
> and
>     Carrier-II EVK
>   dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
>   soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
>   clk: renesas: rzg2l: Deassert reset on assert timeout
>   clk: renesas: rzg2l: Add support for critical resets
>   clk: renesas: rzg2l: Add helper for mod clock enable/disable
>   clk: renesas: rzg2l: Add rzg2l_mod_clock_init_mstop_helper()
>   clk: renesas: rzg2l: Re-enable critical module clocks during resume
>   dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3L SoC
>   clk: renesas: Add support for RZ/G3L SoC
>   clk: renesas: rzg2l: Drop always-false check in
>     rzg3s_cpg_pll_clk_recalc_rate()
>   clk: renesas: rzg2l: Add support for enabling PLLs
>   clk: renesas: r8a08g046: Add support for PLL6
>   clk: renesas: r9a08g046: Add GBETH clocks and resets
>   clk: renesas: r9a08g046: Add GPIO clocks/resets
>   clk: renesas: r9a08g046: Add CA55 core clocks
>   clk: renesas: r9a08g046: Add WDT clocks and reset
>   clk: renesas: r9a08g046: Add SCIF{1..5} clocks and resets
>   clk: renesas: r9a08g046: Add I2C clocks and resets
>   clk: renesas: r9a08g046: Add IA55_PCLK to critical module clocks
>   arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
>   arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
>   arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
>   arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
>     board
>   arm64: dts: renesas: r9a08g046: Add GBETH nodes
>   arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface
>   arm64: dts: renesas: r9a08g046: Add OPP table
>=20
> Geert Uytterhoeven (4):
>   clk: renesas: rzg2l: Remove unneeded nullify checks
>   clk: renesas: rzg2l: Rename mstp_clock to mod_clock
>   clk: renesas: rzg2l: Consolidate DEF_MUX() and DEF_MUX_FLAGS()
>   clk: renesas: rzg2l: Refactor rzg3l_cpg_pll_clk_endisable()
>=20
> Inochi Amaoto (2):
>   net: stmmac: platform: Group GMAC4 compatible check
>   net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
>=20
> Tommaso Merciai (2):
>   clk: renesas: rzg2l: Simplify rzg2l_cpg_assert() and
>     rzg2l_cpg_deassert()
>   clk: renesas: rzg2l: Re-assert reset on deassert timeout
>

I reviewed this. and looks good to me.
I will apply with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


