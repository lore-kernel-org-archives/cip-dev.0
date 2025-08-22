Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33420CA0EEB
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 03:44:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.809.1755834289122157825
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 20:44:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=G1cLWvYV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1755834261;x=1757043861;bh=Vyy8GXQoeNteO8pWybhV9l12K1tMXVrTjSbqS
	BvhS7k=;b=G1cLWvYV0QzFhH+WfREiHrn0PznVauINR164Rh+N9928NXuqWQVMrZui1ChZsZjfNAP
	4T4tIyQeIkGL0pFOnUDXQgy02Bwi7DjlDStRGaXV5odOSyF4yCuJs1SrajAL7bsjtJg1ONrYZG10K
	sluQnfavvCYSj3iMakRLDwmebP9hejXoRmChGp0HKyjk2L/uOm218woNar4DfeZTpAmlzkOUGrWdl
	Ng0154+xagITmZpw/mVaWIdoQ1EvAMtKmmd09wYjyv6M8RU671OaiMOf2AoGZt0SwpiuBQmmlAMqI
	mCnshJl6GcyxC2ieVnrr789iHoutP+nCB62m0nBhuUJg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 57M3iLt62437402; Fri, 22 Aug 2025 12:44:21 +0900
X-Iguazu-Qid: 2rWhWAeBooqYfs4pls
X-Iguazu-QSIG: v=2; s=0; t=1755834260; q=2rWhWAeBooqYfs4pls; m=EfrpnsisN6fFbEFy+51Ad5Ge3CqMIFLzbj2Kqg7W4Xo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c7QzR5qQgz4vyh; Fri, 22 Aug 2025 12:44:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr/f0MS1T4771T32CU1n9A7vy6eoPolrw8+HVqzPleEBmCKm9DORCGn+SYc37sEg9k33fF0P8zJaGSQlY3jTXxlVKcX+aCcHcUgftFW96JsQqu1WbA1/8GO8YEOTIyZEiwlLtHZesQA04gozxtdMsH1mmFurGHP+4ry1+zqy8AOhGDLPChL6b9rROnW40rnW3r0UfbohBhgtsGTbrtkhHwWx/tYxgfZQxAoaniCRh2P9vJTPj6WMPtwtGQJgxM4ALY9fI50SmZ9quGZbV/zEjeF9PbPp7AShKd53Dhg7/33Ae5he1csXlByfLl0osM9MkR24dblhmgUGSFHmWP1ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvLULMdeex5aa+eEPZTYWtNGe3M9zTxTneXsmWCHXKg=;
 b=qb89pQqsNMrm1HrfvcwJ9ol5cuGbXoJhxKehcQ9PEbF+m7rseuuTyXs4KR4omwFVqG6gSisps6ezNPYAE2Gi7ARe7UAy1Cm1TB8UzV1QtohWKpHcjkZIHHWcTZeLoGtyJqQ9oSA6BhjlP3saCQLOrioFoBgkbjn7s8TjzmoDCa7iCoBb6i205TEZjIcdovv+9A9rrlWuAK/ikOtGigGbcPMw1GDJGa/huCBaqJft9BglIKQb8PNyZCYXpgNLNhqXFoPohjke+LqtmSGKBkCaOc98RQwxdRo+XMAgQX0TTxUCUJCUh2sLSvkxRkXhZlzr3g6zjp6Z4JCGYB9suckNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>, <uli@kernel.org>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.4.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [PATCH 4.4.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEduSRu1SQBhfN02W1Qm30CfworRuCfGA
Date: Fri, 22 Aug 2025 03:44:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CAEF06B6B8663014ADEFCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250820140553.4730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250820140553.4730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14397:EE_
x-ms-office365-filtering-correlation-id: 273fbc4b-a167-42d0-d2c1-08dde12e2bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?OXdvNVk4WDM2dTZPY3JZdXlLWDNjRjlDVjVwODRTZk0vcnFXQkhPSGdW?=
 =?iso-2022-jp?B?RmZHZmUydCt3cXRmZitNSm9FUU5pYjRGejJHT0QwQVlpQThTUm1oclJj?=
 =?iso-2022-jp?B?QUVkRjFsMTJFVmE2MnF5U09rYThYUVF3RFZFbkQ2R3dpVGZnUGVXMmJu?=
 =?iso-2022-jp?B?a3BQQmJpeFdySXdoNnpTS1k2S1ZwU1A2cm50S05YbG5CVWRTajlqak5p?=
 =?iso-2022-jp?B?NU5vRU90VU45TU4vOVUxUDI3UThEZHRWZmNLemZFSXlQeitScW1TUnA3?=
 =?iso-2022-jp?B?K3JyOWVDZnJ3VmNUTzk4VkxMdGd6WGVZSlc1QTFnaGFSd3VQLzVZZEZP?=
 =?iso-2022-jp?B?RjJBVmJjVWpqbDl6RmlWd1k0OUl3VTRPOGgrNVA4K0hqYTMreDNFbVZE?=
 =?iso-2022-jp?B?dUZkSGxrVkcrdExJZ3orY1JTN1NTTDFQT3hXYUdJeXRTNDZaQU85WXpM?=
 =?iso-2022-jp?B?V1dCLytxbmppMFNqMFhBeUNNUG41QUhPUEM4OVlTQWgxd3pETFBkbjNJ?=
 =?iso-2022-jp?B?ZTVNU3BrbkxCbnpjOGlvbE11RFRJckMrNXQ1UzVuejVwUjNOc2ozaXJJ?=
 =?iso-2022-jp?B?cXp2b0Q0MGg5elBoaGpDTXlhaUM5SlB3OGlCcE9FWDVlWmF4SXYwM1U0?=
 =?iso-2022-jp?B?MzZWWUVCVWFOdFNEWHkwWXdyejZDNnM1TVZLUFBJYm50ZGxPaWFJcjA4?=
 =?iso-2022-jp?B?Z21ad3YrSTJoU3JwR2RGbXVURnJvVlVtek1zUldTblhTeUkxUVVmT3J2?=
 =?iso-2022-jp?B?T2lFNDBqY0JlbW1WWTZkNkQ2Wnp2aS91VXpsbnlQUFFWem9GSmZXOUlI?=
 =?iso-2022-jp?B?TjBta3ZMVFBFQTNCOW9PNmt2NjVpdjBYa2tMMC91ZkQrZldNdUw5aUpt?=
 =?iso-2022-jp?B?ZlArT0Nzc2w0VGw4REZlSUt6RjNKa3h4M2lVQ0xjQ2JWNEIvTXBMS3Fm?=
 =?iso-2022-jp?B?UGorRDl4bDdxSVlQQlNadXJuY3NlaWx6SERscWw0a29IL2pTUEkyb3VD?=
 =?iso-2022-jp?B?c3RVU0swOXBLRjNneGF0NUxiNkZtUnROTWVGaGhZYXZmbW9oT0FsWjB3?=
 =?iso-2022-jp?B?NS9malJ3elRucUVMTDl6ejdUOFpsWEpzSDR0alBUWVljakRaem52K0dC?=
 =?iso-2022-jp?B?REw5NWY3RmxVamRJc2J6V211d2JHSUZqODN2QnBmc0daMzE4V0EvbUZQ?=
 =?iso-2022-jp?B?ZkZCMGV3MjVXanVjQmtGUDE4ZEpIY0tVK1ZTM3Nmc2NseVI3MGxOZUQy?=
 =?iso-2022-jp?B?cVdxVDVhUHBGcDZmbTZEQ0IvVGxJa1k0dlZFYXNQQlkrT2dBYnY4V0Qw?=
 =?iso-2022-jp?B?ckNNOE13RjVkZTZSNlhGeXdEVXgreUc2Z3RwYlc1dDViVmhWSVI3cmtB?=
 =?iso-2022-jp?B?MTV6MFArV1p0aEdMQjIzZEZJZ0NuQm55UEcyS2l4dy92UW5kU0tIZGhO?=
 =?iso-2022-jp?B?bE5qVGltQk5jdHErV2dVL1dpZ1NaN21nQW05bGE5NjFaY3Q5clNwUzRl?=
 =?iso-2022-jp?B?VjlVMm1EZ1hWbmZicHpaL3drT3l3WjY3eHZFZE5CUU9BSWZoeUxEalln?=
 =?iso-2022-jp?B?dGRRUTk5MTVwOFg4dTZFUjR2b3BnaVhqWmp5S3ZQQ2NxcWlkU2hwN2Ja?=
 =?iso-2022-jp?B?QURCbzQ5cXNORUFyWktCcDFTemFSVnJjbG9KeXpuNVNtS0JYOTI1ZWxq?=
 =?iso-2022-jp?B?am9HNEhhWmtSQWhRbjU2VzdxcWpjWVllOC93TE1jZHByb1FBSTVLZ2VQ?=
 =?iso-2022-jp?B?c0I1Y2hKVmFycE9kSFZ1WW9GcFhhbUlzWlVNcjc2R1ZlYW5GOUxKL1Ur?=
 =?iso-2022-jp?B?czNOQ2lOQVhnRjFQMlZsaWVqb2FGQVpCTE1HazJCcGFMakt4ZlV4WFgz?=
 =?iso-2022-jp?B?RkxXMVU2WjNIRDZxNW5jdUczbXhramhna3MyeVZLRFFhL1BHN1JUbTdS?=
 =?iso-2022-jp?B?T1p1OXhzaXBDaHhyaFp3YkhFVHNDTHdySHZoZjlaZUg4MGNmaGtVK3BN?=
 =?iso-2022-jp?B?R3RDR2p2MzAyQ1R6MFBRMFErUjdzWW12M0JKTk4wZmRzKzlHM05lb0Qy?=
 =?iso-2022-jp?B?VXZpcjZNWStBelg5Q1BPdUNqNlJXbDBsQ3AydnNRL1A2R0dJYVpoSnRv?=
 =?iso-2022-jp?B?WWxsMjljN0xmZW5YZHNnZ1g2OC9mOVZEWjk0UnFPVTN0dzdKL3FDTWJh?=
 =?iso-2022-jp?B?K2VBPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RjBHdWFaRGxPc05rbFgrKzA3SG1oNWpoMUp3M3J6N2dqUmFmM0pDc1pC?=
 =?iso-2022-jp?B?ZllzeFppeEtJUmV1eHMxdnNIZkJybzlsRlA1amVla3UreGFuQWoxc3lU?=
 =?iso-2022-jp?B?OVhqOHNHSExNSE5JVWJPZEYva04zS2RsMTM4SDk2MDN6UWxVRVNGaURo?=
 =?iso-2022-jp?B?K2I1R1lIVmo0Y3N0by9BZGdpcHRXaWozMjdUeEd6M0kzZGZDZ1Q0Y1pr?=
 =?iso-2022-jp?B?Yk1FRDhlWEFwWWRFa285Z1Y5NExUMTJqakp3U1pEMm13L1VrSXc2cE9L?=
 =?iso-2022-jp?B?S1cvckdFSnE1RHo2UWZxYzYzekpBdmI1RWpkNXNuUnZoaEtnOCtodGl4?=
 =?iso-2022-jp?B?K1JLeXZaN0R5SFk1aEFib3ZDbkVMVExMcExJeFhlU2kydVhUMGFVZVpx?=
 =?iso-2022-jp?B?UEI5SnlKdHJlei9NL09oQUdZOTl3QXcvak0yUVFlTUdWSE5jeVNMWEw3?=
 =?iso-2022-jp?B?TWdFYURSUUg5dExQZE96YXJSaW5KNVhiWkNIU1F3VkUwWmc5aGJhRDdM?=
 =?iso-2022-jp?B?V01jYytsT050Qmp3cU8zbENDR0xOdmZQeVRNcDRFeFN1ZDIrN0s3bVRR?=
 =?iso-2022-jp?B?U2VrbktVTmtNL2dBQU1KV2F4K2dMejFlVnAwb21SNWJ0RmI0V01TUmlF?=
 =?iso-2022-jp?B?TEU0TmtJdzNOeDJ6d0JjL1hJZlgySUFPN2VXL281Y3dVaHpoWFZKd2FQ?=
 =?iso-2022-jp?B?Q2lma2hwd2FDUVVmNGpUNGdxRzdyeGk4b2xMSlkrMEpQY0VjWE41NWhU?=
 =?iso-2022-jp?B?RFl6TS9LSXhWSXJWRTRTMVJ3aW1tRlRRYWZBdDh4VGU5Y2c1MG9IRytE?=
 =?iso-2022-jp?B?d2xRUHQ2VENZbUVVa0pPS2Q3OHBuYUFScjFVTFI4VnlpWktFaUZxZExR?=
 =?iso-2022-jp?B?OWNuNFZaZXJuUDViVTkxaWo1TDlSRGl2NmFJYVVlc0VISUl5MjRYeXBN?=
 =?iso-2022-jp?B?dEVKU3dBMklrZVg1ZkxLcEFja29DQVEyeWw2LzkycjlaZUIyZ2JlaHB6?=
 =?iso-2022-jp?B?Y0NEZHVhWElQc0gzSHM1SEF3ZHlMZWFSMXZFN0dEbGtTZ2doVnZ3NVRX?=
 =?iso-2022-jp?B?NzlxTWNqYzRFRzdIVkRSVVFzRk43UC9SWUd6L0dvNFVINlV0VitQbGtG?=
 =?iso-2022-jp?B?TTZUekhvd21GZHJGWENiM3JwTVQ4T3Y2Vm5SZktxNklVOEJoMXVqZkJ5?=
 =?iso-2022-jp?B?czVVZENBUTVxenhpUVIwUUczNERDYkQ4OUMyR0RWY0pYNzlZU2h3MlE0?=
 =?iso-2022-jp?B?UVpaY2N0akNMWm4relEwTFlCWnBWeC9MaHZ0V3RFWG1UVFdXcGlKcEZo?=
 =?iso-2022-jp?B?K1YxbHUwMis3di9FTkZRajZqSzNSSkFiWWdybkpmMGJJQ1JRWDVCL2Nl?=
 =?iso-2022-jp?B?TVpiRGRLVGFRekVGcHpXcFBQUXgwSnAwd2gvdlZoRGp5M1NGNG1OK1Ft?=
 =?iso-2022-jp?B?YmpDOXNvTnQrMUhlY0o3UTZTRGVHODVHT1JqQ0E5OE1hOCtSUzNYM0tP?=
 =?iso-2022-jp?B?UW5ibGpmRE12Y2RuNjFLYkh4RGxxWEUrd3ZaZVJIVHhZR1VUNC9SU3Q0?=
 =?iso-2022-jp?B?VFhvOWg1aW13QlhySHlmM242L010YUVpclM0Nnh6Mks1alpDcTAyc01X?=
 =?iso-2022-jp?B?NkcwNTJTc0pqbmUvOFNOYnRYOHhuTnFlNVNtQ2pQYUdsblg1MG5Sa2ds?=
 =?iso-2022-jp?B?L3ZWOU9lQXM3TjlGVi9CR2JWdXU2S0FBMU5RS3ZWTlRFQjRaaytjM2w1?=
 =?iso-2022-jp?B?Wkt3ZXFHNWx5RnhLVnZwU2xoZzFEZzFWUC8wRWV5aXRBTllFOEg2ajhk?=
 =?iso-2022-jp?B?K2Y3QkxmanYzalovcWJnWHJISXJhUDZkajZOKzB0WGxzY1p6a1ljM3lR?=
 =?iso-2022-jp?B?eWhCM2Npc2NoM0EvT0htMTBRVzdqS2tmVFMrMDIrVVpVZ3BwVks2aldi?=
 =?iso-2022-jp?B?cjN0M0d2M21pQ2hrWXY3UkdUQzZwRnV2VEdxMWJFSCtiWEtoTnFsQzNx?=
 =?iso-2022-jp?B?VjM0TW9zMURDZEFUNDE4eXlIaE85cHZJZE12cG5yTDQ5QmN0SS9xRFkx?=
 =?iso-2022-jp?B?M1FPQVlDUm9mYzRzRXJZQ2M5YlFQdmtCUW9naVpETi9Ub3YzcGllUzhW?=
 =?iso-2022-jp?B?d0ozbnJIQU5mTnROZ0hyS3U0dXRQOW5kL3ZsTUNKN003SnlTbXB0Zldz?=
 =?iso-2022-jp?B?RjZQeXE1S0pGS204bWd4K1FYN3hBMU1VaFBCK0diL25OU3NtdkVoWk9P?=
 =?iso-2022-jp?B?eWVlR1pXSGcrcG5KTC9VYlBTRk9iQ24zb0J1VCtnTnZmN2xFOWRzS3do?=
 =?iso-2022-jp?B?TTl1NFA1N1FZUk1NRlpZbWNhM2lGdjhjc0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273fbc4b-a167-42d0-d2c1-08dde12e2bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 03:44:17.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmxOczsuRyet9nTnh3pqKzDbA3BSO8HbUQgRQv/a4wDXVf+nfZqQlAAxkl6MuyjYSU8w8wZJ63gDJkT+e2UjqIRjyC6ucg9hJV4t3scp1WvF61fZO/8XjDmEeVcoUHAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14397
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 03:44:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19939

Hi Lad Prabhakar,


> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Wednesday, August 20, 2025 11:06 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>; Ulrich Hecht <uli@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 4.4.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
>=20
> When performing continuous unbind/bind operations on the USB drivers
> available on the Renesas RZ/G2L SoC, a kernel crash with the message
> "Unable to handle kernel NULL pointer dereference at virtual address"
> may occur. This issue points to the usbhsc_notify_hotplug() function.
>=20
> Flush the delayed work to avoid its execution when driver resources are
> unavailable.
>=20
> Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of
> work_struct")
> Cc: stable <stable@kernel.org>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link:
> https://lore.kernel.org/r/20250225110248.870417-4-claudiu.beznea.uj@bp.re
> nesas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [PL: manually applied the change]
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


