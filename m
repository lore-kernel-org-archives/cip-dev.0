Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B2CFC518
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 09:16:17 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9998.1763889367111196387
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 01:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=sN2fsT/r;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.60, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehurrCYBgJhPBGJ2qqc/CMVbT8RplnCW+W9KEEfxq+nO8pagOkypzJVeaG6XM2vd7D7Ng+9HL4HKdIlkvbcNdcXJY50QWPIwSdxa6ZwsTbulU+EJGKfrw8vSz621iXsITqa+tGq7Zjv53xDOgB/yFZK846++Q7ToP6gPBdnah93r6eCZQfJpPz9AnxQpCOAt99HiewEAlf9X0tQ4V3iTXkaS9bxrphQR6hyEqD3OhGAJghQDPVkmJP1P5Oyzb07BUSk0i/4fhfOkPcXNnQ5PrvAY2JuOJbftoqPfndbhG82CZoTw9p75VZMi/MrG6eemMCpgfv6uqhH1Zq50ccO+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvCCwVyJqbYXwd3FnQDN0H+KrI4gJxTdStU9xx2gWZw=;
 b=rhX4SZMOiByW3xQUkOpTvqz95evV3la3z/KxbyWUiSA38nUg7FmeJFQu8+Wm/E64ePB+WbnyzfcRetFz5uT9dhkVXpVkFIQlPIRI65rOTXEyf2xNBH0yf55mvTXHU6w3hGQjBOySo4134KlGCpA9YdEYXvv2YuifvPe4zpwEP6DrvqyKtux76iV2Ew8rgoI3I1A/SIqCexS35KzjCS3d36Gtxzr/xaXWdGCra7J6jrov2LMnWwUytb9GkphGQwojXWFwJdj3gStqUbrUDtencgS43QqRvpD15jsUnabcSNPOFjVxylEf+hIDAzzDCnE9gJNUfz/JZP8SSzrNCtiDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvCCwVyJqbYXwd3FnQDN0H+KrI4gJxTdStU9xx2gWZw=;
 b=sN2fsT/rBFoXS7UuveETErH1fhWI2GrtW4853rBVy5UidgXwjiFwD5GDcYKMdo9CDF05bRW1BVQ97fzfSicyr8MX5UhMdO4uyf4Hno5gv/db5DWlNRpGOT8sCsKnnGWvYK9SnT9aULknmYra2oq5Pu0pmVAt89lae9xhNEDlp/o=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8399.jpnprd01.prod.outlook.com (2603:1096:604:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.6; Sun, 23 Nov
 2025 09:16:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 09:15:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Thread-Index: AQHcT1Ljsx4Fp9uZFk2HxnInwr5567T9K1UMgAAPwoCAAANdgIAC1fKQ
Date: Sun, 23 Nov 2025 09:15:55 +0000
Message-ID: 
 <TY3PR01MB113467C7D29D1ACED3381BDB386D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
 <aSBslxvWFIij/zGh@duo.ucw.cz>
 <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
In-Reply-To: <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8399:EE_
x-ms-office365-filtering-correlation-id: b8995670-b47d-4c10-78e4-08de2a70e86b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dDZlVys4OXJCaVJqKzhkeGVTTVAxaFNWQ001ZU1rUitIODF2K21xYkxIbWpO?=
 =?utf-8?B?VTR0NUE3bnpveFcyRTNuTXVSck9udmRaaFBXK3BmTVl3cWQ4dTFNbEw1bE81?=
 =?utf-8?B?RlFsMU43Q3lteWhlcGMwMHkyMXFnTUpYaWNIOFpOVXNFQTdkSk4yVE5hNkxr?=
 =?utf-8?B?b0lkSEZyMHlISzcwY0tUdlY1M1FZeDR6aG5RbmUwUmVwKzVDWkRZZUpRaDZ4?=
 =?utf-8?B?V1VmQTJpZFdKWEUxdDI0bzQyazdYNkxDUnBiYk8rOXhMUnhIVkFpR1dlYXlH?=
 =?utf-8?B?TzhtaUljTDNJMjh0dXNYTmxOdmZ0aTNRNjBzZXcya2RCLzF6dXRSZUhCS0RV?=
 =?utf-8?B?cFY4eFZXb1A3K0pObjAxUFFZVTZTeTVXenFWc012aXg2ZzJRdENKNU8wMFg3?=
 =?utf-8?B?eEdwOEE3QmlQdUU4bm1qeE9xVDNkTDBEWkFHc1hTTTkvakIzTUI0dWZZMlpy?=
 =?utf-8?B?bldZVS9YRzA3d3J2RUNyWGhyYStkNE9RYlVsVEg4bWxSK0tpZmNaWUF1bDBM?=
 =?utf-8?B?MSt5a1UvQ0tzZlZFM3NvSkM1TTFrRjhsdWFMclYrZFY5TmVyaXlTNWZYWkpj?=
 =?utf-8?B?cXlRS05mVnVOMUZhaHF0alAzL3lLVlZiTUV6ZTFQRkxMN1oyZ0JOQXBhMWly?=
 =?utf-8?B?TDUzME5nTDRCaHdYb0d5aTNYZm1yaXgwemhWalNWWXlEczljYjIwNVVLbG4z?=
 =?utf-8?B?Q1pxM3paaUgyL3RManlDdHlWcjlTRHd6V0JtOUlBVUk2QWNwaUJJQUIrSmdy?=
 =?utf-8?B?aEttOGkzVWZXRWJXU05YOWF0cko3amU1NmtBdUVQYlR2bjFPb0doU0x4eVZN?=
 =?utf-8?B?dTliTXdTOWt5SjFvU2NpREJOR1pKbzA1L04xQnpHQlJWN2ZJeEU2WDNDdGxR?=
 =?utf-8?B?QlEwTStmWlFKZnZrQzg1cjlKbGhKUlpCNVYwaW00ajNKZWo0cVIzM0p1SlR1?=
 =?utf-8?B?S1oySVhBa2ZQQzA1SktmVGxiUWtLOHpjR2NXNzdnR1dIYkx4R2RnWnNQUjEv?=
 =?utf-8?B?MWpGZ0ZKSko0SXFnMGwrbzRZRmNDOHRZbXp3ZDBVNEFGNmpFV1ZKMXR1TDN2?=
 =?utf-8?B?cnJRVkdEWmo1dXJ6OFFrbU5oTEVPMWRFMlBjN1BIUlJYYnBpNzc3MjZTWDg5?=
 =?utf-8?B?ZEdrOFUwaWUvOG95OWFpVVN6V2lIUktYL0kwZ3pCZ2tSYzM0ZlFDY1Z3a05S?=
 =?utf-8?B?Q3lvQTV4alprMlF1U3R2NkVtN2gwSFgrVGxSbk5aRXN4cWRKNXdpNVRLejNw?=
 =?utf-8?B?cHB2QjZxa2lyNkk3amx3eGpPVzBkQVZubjlZdVJ0QVcrWDZ6UFQyQlpLUjRn?=
 =?utf-8?B?OHdqUjZzemxWTDRpMW50R0VTVGtVbFp2Qit1bmlLZ3pHL1VoZGppcFpNVjI0?=
 =?utf-8?B?Z0daK1RUQnVwWER3bVNrMUFhajhacTA4aVdXZGJvbENWSHdROUhHMFl2cHhi?=
 =?utf-8?B?eHlsMi91dHFvaHN0RnRIZEFYUHYxODgwMzJiK0lRZHpmVytKOVBST1RpN3ZY?=
 =?utf-8?B?TWVOWU9CWmw2b0wvWmM5Y0N4TDFUbWhESUQ5YmxYMUlKVjBDNjRWdVM3YkFt?=
 =?utf-8?B?a2NNODZqZGhLZm1jejNmS1FJeEFybWEwVzhKNzNob0k5ZmF5eVpBbWVjaUJ3?=
 =?utf-8?B?NzFaQThqTU9TNHlZa0liQ1Q4R1BydGVUemVCd3MvbTlCMDhkV29FV1BoZ01P?=
 =?utf-8?B?cUxVdXpPY09QTVJlRE94ck41bk5Rbk8ybld5OW1KUU1QbWdwdmgvQ0tFOGxT?=
 =?utf-8?B?eTFwUGdaelhZZlZZL2hvZ0Vwa3VZbkk3M3pPbVNuM2xZWUs2ZlpDS2taUVdW?=
 =?utf-8?B?TDQ0aDhPYUJ0OTVJVXBsNEd4R3QreW1rbURrOU9ISGdKaVVodERqRjlJazBm?=
 =?utf-8?B?N1UrWHhmSDBnKzA5L1VUZ3VISm9nWWppZks2K0lTTWZZdllHdDJKZzVLSzFL?=
 =?utf-8?B?aklHdTloSW1KTTVGNmNWTTdKdkdZZk5lMHBwRFpSZ3BCM0hkSHlGb1IyYWxn?=
 =?utf-8?B?dzlTM1FzTmRuWWZsQzRDemZ4VEVuSHJZT20wVTFFWkNjY3hEME95aWNDMEFB?=
 =?utf-8?Q?rPoHmi?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V3lPSmYyRUxDRmZDUlRiZlV4NXdrK2FEamxid3lIaUducUxFTUhqcWQrZXdP?=
 =?utf-8?B?SHJpaC9vUkZtTjloNzNkV3c2bWd2SEdTUGh2b0dHTDBJWkl0QnJZMG1xdEtI?=
 =?utf-8?B?bEhkS0Zzd0lrVGNaMCs5LzB4SjAvNUdLNmZnWWZsZzdqbktwOXdZRmlZUFpK?=
 =?utf-8?B?QWVoQkFTaHRsdEw2MVNQcGZzWW9ub09EcDRsY293WFJSVU0yZDdwa1dQd3hN?=
 =?utf-8?B?bncvclBBM1N0bC9RWGNFMHRBdUJ4Y05oWGJEUlQzWnZqQm9OdVdqaHY0RjZL?=
 =?utf-8?B?T0gxS1lGVzRBMm9ZN2xUMXJneWxDWVZITlFuL2VUYmpHRUxtQUtjMjREeENR?=
 =?utf-8?B?VEkxWjBuVStUL3dIVnBzYmZRNk42bkxCOTRra2ZBL2cwYzBpZzUybWpYbjlC?=
 =?utf-8?B?d3hEaUxoZFFTOUF5NFVmV21hOGMrc3NhNVN1UXdKS0FDU0NCeDlXNTVJWTBM?=
 =?utf-8?B?OGd5NUtlaDgyTGNhSUUzcDVrQ0k5MU5xS1JRdmJ6U2Q1YkpMUG90cTRDdzdE?=
 =?utf-8?B?RGI2b3QwbnBwYWhwM0ZqRzhZbHcybUxOUjR0QWFMNWFIOXZKK0hGMmoyS0xS?=
 =?utf-8?B?ZjBsWkwxczRoRVFsdUFlTHZ4YlJjeHNGUVR5RENUWVBmbmtTcWw5TDBWMTJG?=
 =?utf-8?B?Q3VJT2MzU3dPbFphK29zMUVwMU04QUJMQnprWk9qSEFGSi9xMDlzYkdYaEov?=
 =?utf-8?B?MEluVE11L1RyTTI1U2NUenEvT1dWeVM2ckRBOEQ4RWhJRkpMSk5OM01UalZo?=
 =?utf-8?B?YXhtVWZZMktkMHB5RmVkdzJDaFc3WHpGUWYyQ3o2cWVZV3dKRXk5N3phUStN?=
 =?utf-8?B?WjU5VnZUOGFFanE3WVA3cGF4K3N2enc5cjNhelVUOXBlcTVwSHpGTlFrU1Iy?=
 =?utf-8?B?Nk9vb29WMmVVVTlsalN2R0ZyUFRkMDNlMmdNd1Nkei9DMzFxL1VHcFZwNmsv?=
 =?utf-8?B?dGpvRlp2OWlkVUN6T1d1dngwSHFHZ3N0ZTlzMDI2MU9yellBUXZEMkloNFV1?=
 =?utf-8?B?dElhazBsUGMycUx2Q2FuS01LWDlnQk9CVzNCdFJMNjhlMWlOZ25LOEpzeFJY?=
 =?utf-8?B?RmIvVXJFRHFhZlZVWUx6Mk1IdkdDMDJYR3lNZkRSMU50MkxLb090L3lhT1dW?=
 =?utf-8?B?Q2p0VnoydVBhb3FldmhIaW9GdVhyRlE2bkxhQUtMeVd5TENIT1NQSm0ycTcw?=
 =?utf-8?B?bU5OYzVGbWk0bzhGUXFjSVUrbnJqS3VNL1pTWEFvaW5rVEZLSStsWTRQbjky?=
 =?utf-8?B?SXNYNHFjbCtQSkNlcHhGclREblhQWExCRUdOeEFPMnVxSEoxcnpVSllyVktT?=
 =?utf-8?B?RmY2T3h2d1o3L2dDM3pZZEdYa29RajNTQmNuZ0lUT2ZzQTdCbnhzSWJTaHYx?=
 =?utf-8?B?WTdwSWs5d0huVStaSEwyY0RyUzhTOGdTNFA0Zjl6UUhmcWhTT1paZXZrYnN4?=
 =?utf-8?B?aGJ3TWNPMnNYb3pUZDJpeFFSL3RJeWxpczRtZjY1dVBRS0I5ZWthMlFtQnN0?=
 =?utf-8?B?bElVdWVnTTMxTnNQQ21KSVpIeWFPUHpodWM1N1M0Tm1QZG5mcnh6dUs2Z3Ey?=
 =?utf-8?B?STYyRno5UzNjR0h4Q2xhSCtaa2x5YTlpbS9yZmhtWHpHTGY5ZHRLUXAySml0?=
 =?utf-8?B?SGRqT2wxUC9pMWltT3ZJK3dxK2h1SXVlVWZsdG9KL2R5bUpuci85Ynh2Nk0x?=
 =?utf-8?B?WDJvQjQyNEREVFZZZEUvK2JwclZTVHBvdVBlUTViNDNUVlFuTVVSdk4zNUlQ?=
 =?utf-8?B?emliUytTYldJcFZNdWw2T3hZUUJUb2YyK0hSRGtWRVdFK1FDL2RrZnIybzZy?=
 =?utf-8?B?Y3g3V1prZC9FY2hnOEVNb2RsanNqM2hKR0YrYW90MExGVDE4a1JISGpYaHFt?=
 =?utf-8?B?V24vQXB6MzBWTFczYlpXT211czg2dWFMd3FtRkhocFpia2J3bE5ySC9KU2Nv?=
 =?utf-8?B?UkxmOXF6by83NTc1NldIQWNsSnFBbzRhMUZkTmJuRCsvRnJ4ZHhHaEtDbVM0?=
 =?utf-8?B?UC9Ja042SkJvL0U2NDlPVm9Rc0c5bjE0L0NuVW15LzZ3d0lCM2w0aXhvZXV5?=
 =?utf-8?B?Wmk1b3pBN2JDK2hkNTQwVWVxbFN3Nno4aVBEai9IZGd3bFNHeGhrT3lKcUdy?=
 =?utf-8?B?SERzblhnS1c2T1Fhc1A3MXVPbVBjcTBVM01Vc09UQzNJQlBoRzhrWXJ3TVVs?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8995670-b47d-4c10-78e4-08de2a70e86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 09:15:55.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlY7mqh7e3auM06ismBZfc+3fu5iTyGbAnJU9XbKttoPcyrzNDRNa3tIQfY/dOcZiVRAOgApia0JLBFoYPLp71WO1E5cfI8zFtoGn4Vh3Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8399
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 23 Nov 2025 09:16:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20696

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYg
T2YgY2xhdWRpdSBiZXpuZWEgdmlhDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDUu
MTAueS1jaXAgMDAvMjJdIFJaL3tHMkwsIEcyTEMsIEcyVUwsIEczUywgRml2ZSwgVjJMfTogQmFj
a3BvcnQgTVNUT1ANCj4gc3VwcG9ydA0KPiANCj4gSGksIFBhdmVsLA0KPiANCj4gT24gMTEvMjEv
MjUgMTU6NDMsIFBhdmVsIE1hY2hlayB3cm90ZToNCj4gPiBIaSENCj4gPg0KPiA+Pj4gRS5nLiB3
L28gTVNUT1Agc3VwcG9ydCwgaWYgYSBkZXZpY2UgaXMgcGFydCBvZiBhIGNsb2NrIFBNIGRvbWFp
biwgaXQNCj4gPj4+IHVzZXMNCj4gPj4+IGRldm1fcG1fcnVudGltZV9lbmFibGUoKSBpbiBpdHMg
ZHJpdmVyLCBpZiBzdHJlc3NpbmcgdW5iaW5kL2JpbmQgSQ0KPiA+Pj4gY2FuIHJlYWNoIHRoZSBw
b2ludCB3aGVyZSB0aGUgcnBtX2lkbGUoKSB0cmllcyB0byBydW50aW1lIHJlc3VtZSB0aGUNCj4g
Pj4+IGRldmljZSAoaW4gdGhlIHVuYmluZCBjbGVhbnVwIHBoYXNlKSB3aGlsZSBpdHMgY2xvY2tz
IGFyZSBub3QNCj4gPj4+IGFueW1vcmUgcGFydCBvZiBpdHMgUE0gZG9tYWluLiBJZiB0aGUgZHJp
dmVyIGhhcyBpdCdzIG93biBydW50aW1lIFBNDQo+ID4+PiBBUElzIGFzIHdlbGwgdGhhdCB0cmll
cyB0byBhY2Nlc3MgdGhlIElQIHJlZ2lzdGVycywgcnBtX2lkbGUoKSB3aWxsDQo+ID4+PiBjYWxs
IGRyaXZlciBSUE0gQVBJcyBhbmQgdGhvc2Ugd2lsbCBmYWlsIGJlY2F1c2UgdGhlIGNsb2NrcyBh
cmUgbm8NCj4gPj4+IGxvbmdlciBlbmFibGVkIHRob3VnaCBQTSBkb21haW4uIFRoZSBpc3N1ZSBp
cyBleHBsYWluZWQgaW4gdGhlDQo+ID4+PiBkZXNjcmlwdGlvbiBvZg0KPiA+Pj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMTA2MDgxMjE4LjI1NzQ5NTAtNi1jbGF1ZGl1LmJlem5l
YS4NCj4gPj4+IHVqQGJwLnJlbmVzYXMuY29tDQo+ID4+Pg0KPiA+Pj4+IENvdWxkIGl0IGJlIGRv
bmUNCj4gPj4+PiB3aXRob3V0IGNoYW5naW5nIHNlbWFudGljcyBvZiBleGlzdGluZyBmdW5jdGlv
bnM/DQo+ID4+Pg0KPiA+Pj4gT3RoZXIgYXBwcm9hY2hlcyBJJ3ZlIHRyaWVkIG9uIG1haW5saW5l
IGFyZToNCj4gPj4+DQo+ID4+PiAxLyBvcGVuL2Nsb3NlIGEgZGV2cmVzIGdyb3VwIGluIGJ1cyBk
cml2ZXJzIHByb2JlOg0KPiA+Pj4gLQ0KPiA+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjUwMjE1MTMwODQ5LjIyNzgxMi0xLWNsYXVkaXUuYmV6bmVhLnUNCj4gPj4+IGpAYnAucmVu
ZXNhcy5jb20NCj4gPg0KPiA+PiBPbmUgb3RoZXIgc29sdXRpb24gd291bGQgYmUgdG8gb3BlbiBh
IGRldnJlcyBncm91cCBpbiBwcm9iZSBhbmQgY2xvc2UNCj4gPj4gaXQgb24gcHJvYmUgZmFpbHVy
ZSBwYXRoIGFuZCBvbiByZW1vdmUuIFRoaXMgd2lsbCBoYXZlIHRvIGJlIGRvbmUgZm9yDQo+ID4+
IGVhY2ggaW5kaXZpZHVhbCBkcml2ZXIgdXNlZCBieSB0aGUgUlove0cyTCwgRzJMQywgRzJVTCwg
RzNTLCBGaXZlLCBWMkx9IFNvQ3MuDQo+ID4+IFdpdGggdGhpcywgcGF0Y2hlcyAwMS0xMSBmcm9t
IHRoaXMgc2VyaWVzIHdpbGwgYmUgZHJvcHBlZC4NCj4gPg0KPiA+IFRoYXQgbG9va3MgbGlrZSBm
ZWFzaWJsZSBzb2x1dGlvbiB0byBtZS4NCj4gPg0KPiA+PiBUaGUgc2NvcGUgb2YgdGhlIGRldnJl
cyBncm91cCB3b3VsZCBiZSB0byB0cmFjayBlYWNoIGRldm1fKiBjYWxscyBmb3INCj4gPj4gdGhl
IGRldmljZSBpbiBxdWVzdGlvbiwgc3RhcnRpbmcgZnJvbSB0aGUgcG9pbnQgdGhlIGRldnJlcyBn
cm91cCBpcw0KPiA+PiBvcGVuZWQsIGVuZGluZyB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIGRldnJl
cyBpcyBjbG9zZWQsIHNvbWV0aGluZyBsaWtlIGJlbG93Og0KPiA+Pg0KPiA+PiAtLS18IGFueSBk
ZXZtXyBjYWxscyBhcmUgYXR0YWNoZWQgdG8gdGhlIGdyb3VwIFggfC0tLS0tLT4gdGltZQ0KPiA+
PiAgICBeICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+
PiAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+
PiAgb3BlbiBkZXZyZXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb3NlIGRl
dnJlcw0KPiA+PiAgIGdyb3VwIFggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBncm91cCBYDQo+ID4+DQo+ID4+IFdoZW4gdGhlIGRldnJlcyBncm91cCB3aWxsIGJlIGNsb3Nl
ZCwgYWxsIHRoZSBkZXZtIGFjdGlvbnMgb3IgcmVzZXQNCj4gPj4gY2FsbGJhY2tzICh0cmFja2Vk
IGZyb20gdGhlIG1vbWVudCB0aGUgZGV2cmVzIHdhcyBvcGVuZWQpIHdpbGwgYmUgY2FsbGVkLg0K
PiA+Pg0KPiA+PiBUaGUgZGV2cmVzIGdyb3VwIHdpbGwgYmUgdGhlIGxhc3QgdGhpbmcgaW4gdGhl
IHJlbW92ZSBmdW5jdGlvbiBhbmQNCj4gPj4gbGFzdCB0aGluZyBvbiB0aGUgZmFpbHVyZSBwYXRo
IG9mIHRoZSBwcm9iZSwgdGh1cyB0aGUgYXBwcm9hY2ggd2lsbA0KPiA+PiBjaGFuZ2UgdGhlIGRy
aXZlcnMgZnVuY3Rpb25hbGl0eSBpbiB0aGUgd2F5IHRoYXQgYWxsIHRoZSBkcml2ZXJzDQo+ID4+
IGZvbGxvd2luZyB0aGlzIHBhdHRlcm4gd2lsbCBiZWhhdmUgbGlrZSB0aGVpciBwcm9iZSB3aWxs
IHVzZSBubyBkZXZtXyBoZWxwZXJzLg0KPiA+Pg0KPiA+PiBJJ20gZ29pbmcgdG8gc2VuZCBhIFBv
QyBwYXRjaCBmb3IgdGhlIG1lZGlhIGRyaXZlcnMgdXNlZCBieSB0aGUNCj4gPj4gUlove0cyTCwg
RzJMQywgRzJVTCwgVjJMfSBTb0NzIGluIHJlcGx5IHRvIHRoaXMgdGhyZWFkLiBQbGVhc2UgbGV0
IG1lDQo+ID4+IGtub3cgaG93IGRvIHlvdSBjb25zaWRlciB0aGlzIGFwcHJvYWNoLg0KPiA+DQo+
ID4gSSdsbCB0YWtlIGEgbG9vaywgYnV0IGlmIG1haW5saW5lIGlzIGhhcHB5LCBsaWtlbHkgSSds
bCBiZSBoYXBweSwgdG9vLg0KPiANCj4gSW4gbWFpbmxpbmUgdGhlIHByb2JsZW0gaXMgYWxyZWFk
eSBmaXhlZCBieSBwYXRjaGVzIDAxLTExIGZyb20gdGhpcyBzZXJpZXMuDQo+IFRoZSBQb0MgcGF0
Y2ggdGhhdCBJIHNlbnQgaXMgaW50ZW5kZWQgZm9yIENJUCBrZXJuZWxzIG9ubHksIGFuZCwgYWxv
bmcgd2l0aCBpdCwgYWxsIHRoZSBvdGhlciBkcml2ZXJzDQo+IHVzZWQgYnkgdGhlIFJaL3tHMkws
IEcyTEMsIEcyVUwsIEczUywgRml2ZSwgVjJMfSBTb0NzIHdpbGwgaGF2ZSB0byBiZSBwYXRjaGVk
IHdpdGggc29tZXRoaW5nIHNpbWlsYXIuDQoNCg0KV2hhdCB0byBkbyB3aXRoIE1hbGkgZHJpdmVy
IHVzZWQgaW4gUlove0cyTCwgRzJMQywgVjJMfSA/IE1hbGkgZHJpdmVyIGlzIHVzZWQgYnkgb3Ro
ZXIgdmVuZG9ycyBhcyB3ZWxsLg0KTWF5YmUgc3BlY2lhbCBoYW5kbGluZz8/DQoNCkNoZWVycywN
CkJpanUNCg==

