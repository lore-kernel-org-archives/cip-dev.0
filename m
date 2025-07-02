Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785DC83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 07:52:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.71])
 by mx.groups.io with SMTP id smtpd.web10.18298.1751442766229415943
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 00:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=YBiKPYOA;
 spf=pass (domain: renesas.com, ip: 40.107.74.71, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2UELdZwbYFwK1/AqPabgZwlVDrgSqQGVTAvoCgSMyCTUOXuMFBmg4RKYfGWrxzSfFB7NcYAOeeqGfQ5PoetY179hTwrjNo+GzUUqhMXohyTpEF408XCuq8Mns85tY07Qt5jC7wF04cNwzYfFRGY++wSUL9DRnE+6fajOAcjZyAJ96tL9pur3W6kNYl6IoD4jfqGT4JJwCw6GcSHlmGKcfm2ST+V5sK/W881mdPs3SS8OmuElOJDxfMZbiGS4mMT4p1x1xueat10kwx02PpApuSMxDBVqQAwaMX+d3fASz6//kwUYYHnMhR8tyBaeIr7UEbwNu/xnWWC84VEd/Rm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYoOT2iGTyZbHTaJ6L5266JOeox1jZoeBa2RMwXqjVo=;
 b=bIUf4uWcmvrSc5f+45IMeaawtypyZeoSJrmg4W9s9hCpNW9wGt4QyI4HYajyCfdMrVJ++Viv7U5xDDnJTzyVyQ6PbAGasEgHSi1xJ3DFRvPua0LLmhnxwVN7ufk3s5CvsccIGFoTtOQcGztNzfPTbl4At7yHl3PiK16S0gvL3EDQZZSrNQc6rxhdhBFJy6AvOk+5j7ixMNzIf0TpPJJ/1Xsrq6lBjnD/CgFfe75y1sJjuqQ57kr0U3sNZK7W77JJD4iUcAOYkoXLyWlq6azVJNK39vTnPcLdfqeUtAowF1m3zHkJLFV1qmBElHoe5r+CZBf2UkQ5SkTCvh366nhs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYoOT2iGTyZbHTaJ6L5266JOeox1jZoeBa2RMwXqjVo=;
 b=YBiKPYOAHC7OaiLukA6zXxs/Q1RFk9LmDlemTwSlB5G/xDqsEVldssmhf4qHZCCKvMDKxYOj1n6zYNxgF874JS1XPxfG7f3vTNAWOXBT22MOSkcK5gpDsAbNqfpxjuQTXLayFLwDesZ9TjhbbcJbrDWp6NiQMmdmpY6qdhULv9o=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OS3PR01MB8180.jpnprd01.prod.outlook.com
 (2603:1096:604:176::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 07:52:41 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:52:41 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>
Subject: RE: isar-cip-core: no support for 6.12 on RainboW-G20D-Qseven
Thread-Topic: isar-cip-core: no support for 6.12 on RainboW-G20D-Qseven
Thread-Index: AQHb6xvFb29a2XGF6kimwteHYEzTKLQedfqg
Date: Wed, 2 Jul 2025 07:52:40 +0000
Message-ID: 
 <TYYPR01MB15132BFAEEA45A9A5901AA347B740A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <79d6a898-a915-4e7d-8731-3b245e8d3ecc@siemens.com>
In-Reply-To: <79d6a898-a915-4e7d-8731-3b245e8d3ecc@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OS3PR01MB8180:EE_
x-ms-office365-filtering-correlation-id: 53c56c01-e571-4773-e341-08ddb93d6bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cGxXeWhHbWcwN29mTkZQSTVQZzhnZ3B0V0ZxOFhCaE5oOEJKUTAxYkFsdEJS?=
 =?utf-8?B?Mmt1UGRQQlRnbFFYM0VVU2piZkxzYmVFeE1xRWhPV3dCM0ZpUDM5UUtFczlo?=
 =?utf-8?B?c0UwelZSUnJYV0hVZllIM1Z2Yjh6ckQzMVFnQnUyUVBoanpEVVFsKzJQelVO?=
 =?utf-8?B?cjdvOUVQQk5HWmUrc0c2emRJcVZLdWkzeGJvTGFhOGRESXdhU2RGUFZnMStx?=
 =?utf-8?B?dTM5bGF3ZXc3ZkdqeGFCTDFHVGxlSVhDaCtUV29yR1p2WGtQMCsvSE5Zb3RH?=
 =?utf-8?B?WkdiOGZNdTkzU2E4SXBxY2JTWjRRenFkUEhhS2h3dFhaK3U2bFlQL1JLdmY2?=
 =?utf-8?B?Ym5UZnAzQW8wa3hYdWtwNEZuRTJCTVZzdXFXakk4VnZ4VUt5MEsyUHlLRXA5?=
 =?utf-8?B?SUhEMS9LTmQ1K3IyTnpiYmx3VTBLUVpjeHN6eDEvdVYyQnBaVVhhTUczWjVV?=
 =?utf-8?B?RG9wckc1cGx3dHB5bVJQOWtZQWFBa0dtbnpLQnFzMXNrNDJjc01VMmZoVXdR?=
 =?utf-8?B?QnNSWG5GalBLWm9mendtbm9KbFdmSlp0K2Q4YTV4RXFkQjlFT1FkU3AydUVB?=
 =?utf-8?B?ZHhuU09ROGt3VkY0bFlDWkRwZ2dWYVF1cGdxMG1GdWwveHQ2VG1rNTlTQTdx?=
 =?utf-8?B?YlhzZHo2Q25XcFQyK2V5TzROSVJ6N0ExT29Nc2RJaWFjaWxGYXJ1RFo1b2lT?=
 =?utf-8?B?a0VFOVRRcVF4WnQzdVRjMy9lbkpHVndJbmxjeTVFTDA4S1lWWWFXWTBuNkZH?=
 =?utf-8?B?bnZ2VGlzcXQrY2R5VzRyUm9CekE1Q2N2ZFEzeDBOcWI3Wnhqbk9ockdkbXNV?=
 =?utf-8?B?NEl3ZFd6Y3UzRzQrT2RlUGpKSEYvZEQxTnltNDVYNndiMkg2TE13c0J6MnZj?=
 =?utf-8?B?bDBVU0R3by9vQ3BOMVByUUxGYmMyTzFqY0FIMEpPSzNoK24rQ0N4TEtNV1hT?=
 =?utf-8?B?MTRlS25rZzFGVXVwSm80cjUvSlVkNUxyVHpVays3T2MvVGJ2ZDZMRlBIbEpH?=
 =?utf-8?B?Z05naTJQQys5K2hMMmxiN2E4VFhUMTQyMjhBbjJWZ2RQb2F3QTRaN0F4ZWtO?=
 =?utf-8?B?OXIwQlMxTDNTRHlJbCtpVFYwK2Z6MitVV1JpSzk1d3FJSDMrVUR3alVwU0hP?=
 =?utf-8?B?TC9zaXNrSjFHaGxHUktHeVdabDBwVTgwcjRyRE43M25CNCszbTdlenF2dHVz?=
 =?utf-8?B?cEhQbGh4N055N0xINmxtNW05eVRzemY5WlZXendDRmFOQlNvVitLUmZWS1lI?=
 =?utf-8?B?bUZYVittZ0Zxcm5jM25JSUpLOUJMSmxiZVJHRU1mQVpOVUJja1QrTVFranZx?=
 =?utf-8?B?T2tMNmo5UXdsV2NWbTdRcEFNVXh5SjFUKzE5MTRiSCtaS0srTElCa1FpM2lD?=
 =?utf-8?B?Q0FpWmRrbDVyb0N0WWxTSUI5ay8vbldwczUvRmIwOWIxNzBFdkU5Y0FPc1Yr?=
 =?utf-8?B?L2RjRHc2KzBDemE4ekhRbEtiM3FSNk1rTFlqOUlQOGJqU2tINlBqM1VhYmU5?=
 =?utf-8?B?QmJIaWl4VFoyWkFFV1BzS1VuMXFLUVZDbGhXWm1HN3EvSXI3TSt6b0FvNExM?=
 =?utf-8?B?TFJwVEl1cXJoNklGSGR0dkM0NjFWN00vc0s2LzBLSlBYMVNaOXVnenRtbmM4?=
 =?utf-8?B?elk0a3kvcjd0VkJUVjFUd0FhQlF0YmU5TFpEUHBBMUljTlU1OG5Gd3FuMFhC?=
 =?utf-8?B?Nmw4WFQ1cks0cHFPcTU1YUVuOWhZU1dZYTBpSUVnUEw4T3Z1V2lMczFab3BT?=
 =?utf-8?B?NDEwMVh0V1dqa1RQODgyTWlkQWpLajlkaFI2Y2JzdTcxUEMvWkpOU0srTjgr?=
 =?utf-8?B?OSt5dkduWUI5eVk4cnd1ejBKOTZzSjJFMWhRWlJkSUVMTVBoNGpJTldKK1dp?=
 =?utf-8?B?MkUvNFpBeTB5K0xjdlVJMS9xU1lSOW9mcURGek43clVBZTFzbVRwSjhBZStr?=
 =?utf-8?Q?8v/mHfb6jHQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y2Y0dG9Pek9HK1NuVlpSdENVaFgzSEM5NDBlU1g1VTZTUTlSKzUrbk0vVjdZ?=
 =?utf-8?B?OWRNUHNycmFBYkFDWnBweEZMeXI5S3pESG1aSFcwOWdDOFZJMlEwZmEwSkhO?=
 =?utf-8?B?VHdkL2NNT1dFN3BtbFFoOHN6ZXVjVGFIK1lYaDllekVBRGQvNU0wejRqSG1w?=
 =?utf-8?B?c2NCRU9JOVh1TFJXS1A2NVNMN1k3clVDVVgrR2dPTFRUdUNZMGhGeVI0SUNY?=
 =?utf-8?B?dE1HUkNCVmRDbHdlNXJ4OUljZ1YwOHB3RFByS2grcFQ3bzBEVTZwZmN3S2N6?=
 =?utf-8?B?RHJZYWNIeXQ0Q2ZVRW9vdlpmb2IvL0UxYVJHZ0VzN3lra3F6L0NTcGEzMUNV?=
 =?utf-8?B?SGdDQ2FNUkJwc3hVYnNMUXVXMk5EV1AzOVduOHZudVJFc3ZuMmpOL2FmZ0t1?=
 =?utf-8?B?b3RTYllseGFML2NnMkFFK3Rtd3Rjd1VQSnZWczMrNWpudmIvVkgwM3l3MEts?=
 =?utf-8?B?c3ZBMkRXZFRzNjd3c3U2cTRqUzhYRnJNWUIxQjExSTQyZmpjeDBMTmVpc05s?=
 =?utf-8?B?N3JhNElEWjJzZXI5dnlFc1lOM1dKWDU2aXd5WTc5dDA5dDRaMUlseEVCQjJm?=
 =?utf-8?B?NUdSanFsck9zUUFPMjFiY1FYN2xKZWdVazVQdERaODc3L1c5Y0hDNWZNL3Y1?=
 =?utf-8?B?MUcvRTVEVHpvSnNBRDRjWVY2cHI4OVRhbk0zN1d5SDFYV1RTYUJ5akorQjh1?=
 =?utf-8?B?QVBZMFMvcUJXcS9CMjZpd2w0TlVaVnFvSWV1blVBdW1abXBwcUpOR1U2bVF6?=
 =?utf-8?B?Y0dSNmZNbUNwdFhmb0lvNkIrbE1XVVpDU1JlSVpOV3VaQStXMUVadXE5TStz?=
 =?utf-8?B?VWlxeC8zakgxU0FxcDZCeStXS2szSExDSVZnMzJmbzlPOEU4ZDRuc1hKd2Fh?=
 =?utf-8?B?VW9VL2lYWWhvK1VwbjM4N3V1TmptdkJmSTRhZDd6V0JuQk9CYmgvVU9qSk5S?=
 =?utf-8?B?c0VQZ1IxS00rT3lEaXdqeU5ObE1xaXBtS3ppcTFmaUdMSkppbGlwSjlHUHFH?=
 =?utf-8?B?WGI2RUNWQ1NTN3ltcHJFcTVWRlZpODhCQk01alF4QlFySDB0bWdBdVNDRUw3?=
 =?utf-8?B?UWNDUCs5cTFwOEN3N1hyaklCd2g5cDV4SEVUTTBjbmpUaDNVWkFDUld1eGxk?=
 =?utf-8?B?Uk9Ha293S1JhUzdvYUZSSXdrY2U2amFMNmEvUHpBcDBkZU1mNHpNUGRNSjBH?=
 =?utf-8?B?OURicVNNYVJsMlhsQWJQZ0NzOUdYNk9zTXNhT0k0eUVyd2ErODFyc0VMb1FI?=
 =?utf-8?B?UzJEYnNtL3AyM2Y5R1JCdjBPUnFFS0NMaEt2Um5qcFNEWlNUODRkZWIwb0dE?=
 =?utf-8?B?Tk1WQmpHTVRxYjdFWlNEbW5tZjlEZDlvRURlVnVkUjBkUUlVbWNIM2xWRmJP?=
 =?utf-8?B?d3Y2TWxxYXUveCs4TXRpTlcyTDBGd2swbFJiT0hRd0xCZ0ludGgzRGtGTk5J?=
 =?utf-8?B?L09tREJVSmZpTTlPcXRlQ29SdGpwVkpYMFMxMTlQMStuWHRRdko1Rjc2TVpq?=
 =?utf-8?B?eXR5QVBOcjkzUXVGeHRheWx3Y2hsTkNiUEZMdFUzMFVtQzgwdUt1VTBMRnBN?=
 =?utf-8?B?N3JKREozRElDMFZRYStQNWFYQXJkQWFYZzN3RHZmQjQxeEV3WFYxMDVRb0dh?=
 =?utf-8?B?TG5iOGhTM3RDY256ZEQwdldtdzRpVE5EZnZCTmY3ZWhyakJub09DWG8rMUtE?=
 =?utf-8?B?ak95QlZpZWQ0VTdoQ2phbGVDRGtTd3RtWGt0U09XZzlRdFBMSmI4Q2oyOHdG?=
 =?utf-8?B?dWhBbjF0R3lHQ1lNZGIxTWZBSWlMblplUTl3VHdaK0dvcitJaW80Wkl3RTN2?=
 =?utf-8?B?NVVveXVFaERkbi9CQnJtaHExZDM1dkRKc2JBaXc4dEwvNS9qZjJtQ1lIblNa?=
 =?utf-8?B?MUhUVW41dlhTNExsUXI5U0JMQUtMclNKSndCeE1Pb1pxT0lYQjVuemRmREFP?=
 =?utf-8?B?VGlOTDFVNU1jS1NydjJpQ2FPVHplUkVwbHUzTXZBMTZqZ3JrZzJJS1hpNEkz?=
 =?utf-8?B?S3RCVWpLVlQ2azNLRFB5ZUVrMWpVMDdsSDJjU082SFVVV0UzU1FSVnprY3FD?=
 =?utf-8?B?Ykx6em5kNVQvRjlTVzRBZ1dCRUdIR2ZUOThxQWljcE9Xa1RlbFI5dnpndlZo?=
 =?utf-8?B?NlpoV0xtdlgyYklHbUpjTFdtamtZK21qelB6R01IT2tVa0lXS0R0ZHh1eS83?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c56c01-e571-4773-e341-08ddb93d6bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 07:52:40.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4zp7WxMZy6Zm+2EZdK4kxkyi2VJ+rtgNkOPAF6ids7dkpkLPkWvc32CJm3Hg70doCtrhB0K8xWhr7hUD4Fn2Yp9eC3wpkdSS77NdM0WeAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8180
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 07:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19280

SGVsbG8gSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDAyIEp1bHkgMjAyNSAwNzozNw0KPiANCj4gSGkgYWxsLA0KPiANCj4gaXMgdGhh
dCBjb3JyZWN0PyBBdCBsZWFzdCB3ZSBoYXZlIG5vIGRlZmNvbmZpZyBpbiBjaXAta2VybmVsLWNv
bmZpZyBmb3INCj4gNi4xMiArIHRoYXQgdGFyZ2V0Lg0KDQpBcyBwZXIgWzBdIHdlIGN1cnJlbnRs
eSBoYXZlIG5vIHBsYW4gdG8gc3VwcG9ydCB0aGUgSVdHMjBEIGRldmljZSBpbiBTTFRTIDYuMTIu
DQoNClswXSBodHRwczovL3dpa2kubGludXhmb3VuZGF0aW9uLm9yZy9jaXZpbGluZnJhc3RydWN0
dXJlcGxhdGZvcm0vY2lwdGVzdGluZy9jaXByZWZlcmVuY2VoYXJkd2FyZQ0KDQpLaW5kIHJlZ2Fy
ZHMsIENocmlzDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9LY29uZmlnIGIvS2NvbmZpZw0KPiBpbmRl
eCA1ODJjZWRkYy4uZTA3ODg5MjYgMTAwNjQ0DQo+IC0tLSBhL0tjb25maWcNCj4gKysrIGIvS2Nv
bmZpZw0KPiBAQCAtMTEyLDYgKzExMiw3IEBAIGNvbmZpZyBLRVJORUxfNl8xDQo+IA0KPiAgY29u
ZmlnIEtFUk5FTF82XzEyDQo+ICAJYm9vbCAiS2VybmVsIDYuMTIueC1jaXAiDQo+ICsJZGVwZW5k
cyBvbiAhVEFSR0VUX0lXRzIwRA0KPiANCj4gIGVuZGNob2ljZQ0KPiANCj4gDQo+IEphbg0KPiAN
Cj4gUFM6IGRlZmNvbmZpZyBmb3IgQkJCIGlzIGFsc28gbWlzc2luZyBpbiA2LjEyIC0gd2hvIHdh
bnQgdG8gZm9yd2FyZCBwb3J0DQo+IHRoYXQ/IENhbiBkbyBteXNlbGYgb3RoZXJ3aXNlLg0KPiAN
Cj4gLS0NCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KPiBMaW51eCBF
eHBlcnQgQ2VudGVyDQoNCg==

