Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DACD5BAF
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 23:42:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6809.1779406918754353972
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 16:42:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Y1yjbt8I;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779406910;x=1780616510;bh=Lg8gGJy5JYdLYUOTYUAFNjtDNt+pQHH/YLffh
	SpSxsA=;b=Y1yjbt8IUaQwDCs/ypc7D7yQ0A+ZzqAvnBKsexUJpJHt5a7Ln9+aU/hmdpE/w4z+5bl
	QnwYx7ENVnzGLjmlc9y8Tx9/TT/KWjT7Cv7G6bafroYY97AkKKWI8zLPGmN6D2qd7r1QhdqBmZtWT
	p4XK5oSxGduDKkE4FyTnH+U4kf1DxtpgvxX62skDzwwsCU7WHAqWOAL+g0oYvmM6ieBP8mdBWuY8E
	+3BETsBr1/Ec5D/vD39Rave9v12N5lZV8oLn9MBKTzKWnNtt1YzQRXNy0eHJSscxdTodP3XddNaML
	LFr3frjC9AZNn9mn5QsyvkQLDgwsBpH4G/AfC1vDvH7w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 64LNfnH22534786; Fri, 22 May 2026 08:41:49 +0900
X-Iguazu-Qid: 2rWgBpEpjBxTZ04VHf
X-Iguazu-QSIG: v=2; s=0; t=1779406908; q=2rWgBpEpjBxTZ04VHf; m=E6dTXAQbjlOCY+l+WuH3up71TdYm0jxlTvRKhOV1O1U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gM4gb6Q5fz1xnZ; Fri, 22 May 2026 08:41:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmva0s15epsBfhruDLTSvPpXsW6ci3HqCZdIsPydBZ+9NxfQWHhz9LMlPsVR1RdhcYgknlC97hI8LnAID/MP0TZCHZDgbo61fqshrJBKNw2aEy8SEWnNxYYvzw6KxDR7192iUilp49RdGnygk7x+ln12QXevooEZsEp2MjDSEN8SUymvMir7+wG7lBnfP2Z/2bnoTE4pTuHLteUceBn609AGBdkBdyiIxhW4FXzYio0OaP6KL6OKhVc+caNDBsZLxf3iy+0qvh84CaAQtuj/mDDnNA9kOP/bSmMhGPr9M3lvU5d6XWiuATRmKlqKN4eVWPtMbb0O3TLQ/LIbm4kMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jnz0kNCSxYEBNPKr18NbgI5Em1t+quGJh1zIrvb7FY=;
 b=jkEzMA54Qi8PKHYJntXTqvhVQL6TsAONmZ/fc7fjx7Oc5ceP/EF+0Z83TN6kM45pWG4JJ0/01xlPdz2HGh1202ODY6RCcZqjTy1a3PNxkEjEnqOwXLFH9oi7yf9baN3JSp7HNV755r1G9WzZGPa2aUSEs35jF52lMKW8MrPNNeCofSis5jg9BEx6+PA65AIEEbd5jlPsI2mII7rdkpqupERJb3sOD+FhHQZ5PZ4mzANj/khjM+tlUvCYCV7ISVuk4R9s9McEqwANTqQUhY5PjNDYr9FiIYNwYIjZ4b0GSOPqNqNoZ91zxCqsf/aSKmZMHzffRwCtWs4T8uFLgpW+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <john.madieu.xa@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>, <claudiu.beznea@tuxon.dev>,
        <john.madieu@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Index: AQHc44YB22ldBFq4R0uQZZrEuIwlVbYX36qggAB0XgCAANtsEA==
Date: Thu, 21 May 2026 23:41:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185260482FA754B8DF6D45CD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
 <TY7PR01MB148184CC9DDA8E51E85ACB89ACD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ag7f8NjbSGWZA7_8@duo.ucw.cz>
In-Reply-To: <ag7f8NjbSGWZA7_8@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10172:EE_
x-ms-office365-filtering-correlation-id: 143b94d3-433d-4e38-4c5b-08deb79284b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|11063799006|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 qrqVe09/V6gQkir9t7+8MPahgtTNuRB60ym2L3zLtXPvwFV+EOosy8/kzNRJ9d/xd798ab86cTAkVI1lYCIbI200s9s1PEDn0xe94Ha0xNkLPTa04X7HaUYYsoDMFJ+wcX59lyqcZJb+OEpzNVThr4Q3/6tjqVqY8o/5Rf9rJf2s+DeAetz5G58ryyWXR7mP7dokccgBPJCESXsq1ivWrZTHTrNvv56hems1obIZHjM0Q6C/NyEc+DNyQwbmZ7OSUBWnMCLzVJBPcDQTBr1U+vIMqToCiuJd7quHdN5k4EPBKKv0x3h9x6Ov/QLoABBW1tOB6ca2CYOeJzN5RDpGC8x3y2+5AHAANGUuG8PnxZOMlwSJO6w2K5dOMVkh+I8BMI//TGKDTRfSkZ1fb6hFpdmdJhpbCu/dNp5cJkr+QOWIdNJJNl1/0+0WXMdlZCwEqaPlVMJmeDL6bHbZSkSsy8V3cKmN8HLq7megY24DmNojsJuTKBa+C6RTI/yzB7NxG09rDkfZ2VgoRCWNrQJTOJ7J+jw0rVvnGH+x9k5G/8apP3SZVMTipE7H1wBA8rYOxVRComoBU7sIGBW+oP7qX+4+HKgAWWrgT3ZWZyoyAV8bI0zkR1UJLin4xLtnvVI4HVT42Xqzfft1uUH5tfJPpC3+IugOedd5R394nTMnlmT8/gR9jx1Zsu5GaiyltLEZZWfxkPwy3UM91KIEGY2rvijXkH147JAM/vtc8u2fUpHSyRjlumIhOXLAIOTnwL3v
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUdBK21kUUZGSGFCSVNaUDhKblFIZkxzRVFqUDVDSklJckVQb01NaU1p?=
 =?iso-2022-jp?B?MVVQMzJmY0pRSUErYytTbnY4TW9hOWorZXliWVNaQ2c5bFdVeXIvRlMz?=
 =?iso-2022-jp?B?V0dLam4yYWY2bXFibEppRFhKTWFRUEhScHRDV2MzMHV4cWdjY3hZM1pI?=
 =?iso-2022-jp?B?TndXcDZvM1puZ2I1RVpCUmZSeUUvY01mY01kck5xZTh6RWE3M0k0a1F6?=
 =?iso-2022-jp?B?RStUSWM3NnNRMVU2SkFHeXpvTXNPYXIxb3hXN0lwcXQ5WWwvOVM3c3pQ?=
 =?iso-2022-jp?B?RC9LbTErMVdVZmJMYlpzSGpyMzZhb2dKcU1yVE83V1lZYzMwbmFVZngz?=
 =?iso-2022-jp?B?ZFg1UzVXcHBHN1RDVzd0OWNITkpvVTcxTW1ZTlZsL2ZJc1Z4TU9yT1Ny?=
 =?iso-2022-jp?B?M05TckVabUZjbmE1TisxSXhMdlNpZzN5QStKaG5XY3F1cXNvd2NGQUU3?=
 =?iso-2022-jp?B?K0RIRkY5d0Y4SHZJWFdIWEppK2RDdkVtbEdMcnRoRzJKOE4ya29yTmR2?=
 =?iso-2022-jp?B?dVNneE0xQWJtQjhjU3VlUXJ3S2svcGliWlNRMmVLeWREN0NLMFlrSXJ2?=
 =?iso-2022-jp?B?cGFKMG0zUTNJT2VUWXlpMVRVRGh1emVIdjNWN0I1WDhYOEVOZEkrT0k1?=
 =?iso-2022-jp?B?RnRHS0hPSmk1TlBYdjJHNkdycWZSTTIvMml2dkRGWkpldDdjeXNiWmha?=
 =?iso-2022-jp?B?WThlN0VkOU9sMzBiSTNzZ2tBY2VBTldLeXc2K2phY0M5eWFXbGF3T215?=
 =?iso-2022-jp?B?TUFLeU1mNHp0ZGRuUDVUSmVVVmxhV1JkL0dSM3NjYzZvOGg4bmhKcWJm?=
 =?iso-2022-jp?B?cGQrMTZ1Sy93RHpOKzFTcTlVbnV0OUNqSFprcmRkRFVTRGhldjY2Snph?=
 =?iso-2022-jp?B?TVFmamV2Mk5XY2FTYUxPS0FISS9OMklNZVpZRy9KbVFSeHE4MjVMbFlr?=
 =?iso-2022-jp?B?UnNlMXlGS3JFdU4rZWkvVlMzQ1RiZWtNK25vQVl3Q01YVHl5RVJEWUNt?=
 =?iso-2022-jp?B?MTlzcS9yTmZOZDJwMWNkSlF4bE1qdko4Vmw2Y2FTcSt4Qk5LS1MyVlpq?=
 =?iso-2022-jp?B?S0lWdDhSd0NRL2E2clFYSFB4b3BMQi96Wjh0VjJ3UlFYOG1WQ1VzenM2?=
 =?iso-2022-jp?B?TnNHZFA1UEQxMmY2azUveGJqQno4eHZEOEU4RzdNVnBjbjBWaUVaQUVG?=
 =?iso-2022-jp?B?Nm9lQ3VNSVZncVR2bjdJbzE4czBvb1lCZHNLTFprSTk2ZzBDYmZseW51?=
 =?iso-2022-jp?B?VDJWbXcrQSs0MnlhbHpkQncyRVlwWXpLLzRJRkFiY1QwZGhnK2FoOU96?=
 =?iso-2022-jp?B?VkxYZHdyWm5jdmtIbFN6a1IwWnM1eDNRTUJGSzc3T3pONk9teVgwQ3hH?=
 =?iso-2022-jp?B?Uk5IRW56RnhWYWRyWE04RmhtSUM4UHllTW5IWmppZEVKSHU2YXg0TUQv?=
 =?iso-2022-jp?B?d1lnLzR0QVJzaXNwZEVSSFpya0lZSmVLWHRzSm1kMlAreG1Tb0VHckVP?=
 =?iso-2022-jp?B?VEhwdFd0Mkx2U0dRVzhtME40bVZTU2IrNFY1RG9JUmpCQTgxVnBwTSsr?=
 =?iso-2022-jp?B?eGEydzhLMEtoNDhTUGxEVFlpeldNcTFmcVN1ZGZmbTYyUUxacDRhdGJ3?=
 =?iso-2022-jp?B?TUxpM05oZGpSS3N6cGxqYTNGbllaVTRsd2RIOGlNNjFHY1FLNzJSOEJk?=
 =?iso-2022-jp?B?azJyNU0zOTEvRDFVYWxlK1hocDA2OXpEeWtXN3JmU3FkY0xDOEVlQmQz?=
 =?iso-2022-jp?B?ZVFta3FLakphMkJZSnBkUFJFQ0pwMFVuaDZVdWZodW95VWZHV2lRUU42?=
 =?iso-2022-jp?B?QS9GWlUyRng2K01ncklITHVBYjM0cnVBMlNJNUJVTERpdWVRVGE5blVT?=
 =?iso-2022-jp?B?Rm95SmVVTXQ5TDBrZUE4b2VMKzFtSlRKazR2R1NPUVY2SHc1ZVVVZWJW?=
 =?iso-2022-jp?B?QitJbUg2SkNMTVhTWGxsNDQyTmp5ZlNvVFpUQlpsVzFwY3RXNVlhTlkw?=
 =?iso-2022-jp?B?T2RZQWNiOGZPUjc5bUNUSnpYNzEwNzIxL0ZTVThObjBNdTREUHVqSWpo?=
 =?iso-2022-jp?B?TVdSb2xCMVdkN1VKRGk0TXo3bWMwbkdoRHg4a29wTzdvbFFIMEtYMFNO?=
 =?iso-2022-jp?B?QVp5YWxVYTZlU1Y2WWtjSmxVbmx2THBlc0RvMWdSbkQwWGdRa1htUklO?=
 =?iso-2022-jp?B?c09DcGJuMHNYL3YxMkhtc0UyVnJmWDdoa0YyRnJOelBjZFJzbTZQVkNU?=
 =?iso-2022-jp?B?elRDZUI4Qy9URzB5aytLWUVUWDZBQ3hOUCsyZzEvNkM0RnplcWtLNm1w?=
 =?iso-2022-jp?B?TmN1RE56V29hN0R4aE9oUURZWTNnKzMxektRWVFOR3ZUc2hXcmhsWWg1?=
 =?iso-2022-jp?B?eWY3U2ZBR1FYd0dzaDBNcmRvVTRHdi9hYUVBdm52QnkvUk1tajdtdVV2?=
 =?iso-2022-jp?B?T0tMK1FWb1pkak9UTTlneHFWeFAzNFhWcS8yUnY3MHl6Vlh3b3MzQVFr?=
 =?iso-2022-jp?B?WmpVc2JWK2Nxb2VUb0hOTVdGZU9kc0J2emhOZkh2T2s0c29rdm9rWjIv?=
 =?iso-2022-jp?B?WjlaTmRPQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	MzvwSBV6jI4edt2ZsNJTph/3OhTlX6wepWVgyruSPvg28fSu2HL7CQcvChrQruoLieq7tglQ2cJv1fL9AWkI8cu92RQU0nezGP8fCSDPlJq5nQZ9VIn6+dmPCQiDJxbaUMuSx4iVmrdvnpiKv6fVPUM4BcsRijClm1NEznYjdgxDgDRrRIqeYnBXv08skyihK5aZ8RExqbKjwewz204yb1EwFXr8+8m6dLm0wlOs5LMQkMczVS1gxZs+GLlvIz8GKdx5OJ3rKioPTx3B1sSswdJxQjigIagqipcewcSp5ritB+S/hlz9xhI83XN0FL/KKUb+pPmbO6M4QDdz2qAhmw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143b94d3-433d-4e38-4c5b-08deb79284b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 23:41:45.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6chRzZPXrJWOaPMsFlciOREmLCv8A/4AWiF1qTWzArZ8/0xYN/VdiOLu6N3zjU/+34lbgL7nTAQrHbUQeJFZJqYb6snYebVJl0LUI+/+dytYYUtTaEu2CRi75cMnM6Un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 23:42:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22994

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, May 21, 2026 7:35 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: john.madieu.xa@bp.renesas.com; cip-dev@lists.cip-project.org; pavel@n=
abladev.com; biju.das.jz@bp.renesas.com;
> claudiu.beznea@tuxon.dev; john.madieu@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E P=
CIe controller support
>=20
> Hi!
>=20
> > I reviewed this series and 6.12.y-cip, looks good to me.
> > I can apply if there are no other comments and no test issues.
> >
> > Tests:
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/25422=
48407
> >   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/25422=
57325
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20

Applied and pushed with Pavel's Reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


