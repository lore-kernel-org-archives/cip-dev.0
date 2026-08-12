Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73121C5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 09:26:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4143.1786526757753284841
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 02:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ElpFWle+;
 spf=pass (domain: siemens.com, ip: 52.101.84.56, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ostjYprIVP170ePNL/liqVtO0H5B3M/GzEYEyiSpHENBhHM9nsukJeEjUndodtLODsxZL000ESl4zlsOYRxlkFEXqyiqWwzxZx4ybUUbaZBDThBV8WtmgcZzNfdAbUk6dE02/GHqPOI5cp0pZKGcXIPqdm5q0HWPVnOKbs7+AXcEXRGb/74UlWRZuKcHwPcx53eYFz+yU35CPkIxK9oZfXs7eWP8M5mtir7WWJ7kHI+zkZWXZjn7rUAzudBCDmIsotIKfdhX9YyioimHmCJYTXw3n1VL+0ry4Nyh08mEoHXwKt7xz7OhI7SO+DWyLiweWJWzum0yAkxFg8czE6P89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRL8JUtTt73Hb4j71EBkztEkKS/MI21uIbzGNfSHSbQ=;
 b=yCZCZBqIxIRONpHSaP3FTHD3VRiu3BucZ+v9dcTTdIsIJ78JPsbD3PoaqErF7XgVh2zUaFU2uRFZNi9jlvEgxbUK3mCd7kS3vBPAVBTsf6N6zzqyMwfyPHDbQlD2vgTbdbdbGEINvQufz+VFDXehNDUh1D/fmPa+lbfezOE4eM0JDEKcYfi1/6tszbvKNxRoj9AmxRVza/oupxFuHcoJMQmbEFSqD8+lZc1NQTyp5XKGIPwmnKvBI8qPkArN5pq+vC0gChJQNVm0qmix0Q9MsaC/Nb5GMiNZS6tZg0ciHiQOjJW7wrxPQv3ptdvVlCRZB+9pd6NUqxaUpYx9+MTtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRL8JUtTt73Hb4j71EBkztEkKS/MI21uIbzGNfSHSbQ=;
 b=ElpFWle+mVgE4ke5PmNG9F6Gn7vY+AozNIff8mivmzJPxWsWryNo70HLDGVSEd/IYLhICxh4zkYedTLvCkDZdibQHWOhay4r0owSYeb65ExzmbIUIaf24r4B7VB27fmB39y9Nrm53R3gdyh0coCrn+bHwIMqj85rZ3RqNPDv/gQeesxdm4Kf5b2t/3JlAMs6k2HsTQtR5Vtc8dgYaKzg7PGNpOrL6HjI8djlGDjwwhtAAwkDWiShEvOO6vE6NRYcAc/uTNcpFQ4TZjy1IbjGu4hkQIkJnaOQkoc8WVPkn8HZM3me+aWBtSWtQ0defTroz2hon/OmVxnbgx4G2NgDQQ==
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by PA2PR10MB9018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:25:51 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 09:25:51 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Topic: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
Thread-Index: 
 AQHdJoO2k7qw2xocSUyik+HCHaPcK7aW3YyAgAA+dACAABcegIAAEhmAgAErfoCAAArVgIABsI6A
Date: Wed, 12 Aug 2026 09:25:50 +0000
Message-ID: <0b32da8016d7314c67aa5a5de4b57e112439880a.camel@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
	 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
	 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
	 <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
	 <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
	 <caf1c704548f130911b872587c82d15441ff88d0.camel@siemens.com>
	 <5dd841d3-abe7-4167-866f-9f84bfc25758@siemens.com>
In-Reply-To: <5dd841d3-abe7-4167-866f-9f84bfc25758@siemens.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB8045:EE_|PA2PR10MB9018:EE_
x-ms-office365-filtering-correlation-id: c5c42e60-83db-49cb-a2ca-08def853b37d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|6133799003|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|55112099003|22082099003;
x-microsoft-antispam-message-info: 
 gp8bZSaBAfFROXoGZJGpeZ7OJVv1cHYJVrWrygN2JzACDhurInKDrIcHBmABdFSaCWGw2tgjvDkrjaGW/0jAk4G2pDrzg5rYku5eEyfzgxrJevqi44agRxjOs6yaJhbFRKwxCUYk9orvc2RQlISLg+uU1fvA90quiWfPHS/5P7fmLGKrDUYNXaWLE3t80nuVVp14W9lNsHumhP1tFhLDmrTFjzaOIcSnaFTbtxgydMatNr8Gf827bjRZRzfudH1TxmY0DAzOVARsOX7K54KGy5X/S8WEF4AEH5Dx3CMHNku8lDSqj4FAdnyiMtbUHdMB0+/J/p2y+qLZSgrQT/3qwbphl2mVOjewZhYRRF/fIummyqxGKl3ycxEDlv9lQAEKWJDfDC329At3OXNPhUBI0VyicrHK3HdYiMFSwHlDno43wPCcdu2DsHQIZjuBr8YQEZA9KMwTxGbc7wnr7ELDppKq5JbXF/2Iev0FhbgtnWhpgQF/VJvVYPIdf9Vb2BL1QjHhWC6LrBA8q/atbsKa7v1zWuTt4935V+GcnimVZvnxS9tBNAPYAloCQE59ei3vPVQxs7aXzg8jclQE12fB8BpF8N7pJbW9hfjRmpTko/Ce7hXRNVu3SMWTDe6NwRzjpnbuVjU9OsP8NbZt/56EvZb5/gsM/el27QcNIWZH4PE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEdpUzM3bGZZYUZVT1E0b1QwcXBydmk4WERPK2ppNElxbTNVNy9hTnlDVmR0?=
 =?utf-8?B?c0VTbTBqeDBqMmFWbmpCRld4Nkp2VENGRjRZV0ZEQVZuTHpjSXZud1NndTh4?=
 =?utf-8?B?MGo1UGpGQUpXQlVhai9ScmxuRlhXZmxLekh0LzdSbjUzOU9hTEw4NDZGU0pJ?=
 =?utf-8?B?QU5vMVlDSzVGN0RXYlY1MkdKZ1gvWFRSSlRjelBOcElZZEZuOFBHZWNYZVJZ?=
 =?utf-8?B?TFJoVWJNL2JkMENrL0dCa212UFdJbVAweFFINSt1emJibkkwUThPclZJSG90?=
 =?utf-8?B?UDgvRkQ4NXFTSUhEZkxJMXZ6Qkl6N09lOFhselJReGtveTJEUXl1emZwN3ht?=
 =?utf-8?B?aXExbjF2Q1llM0tTMXF3K3FrYlNCUVZsVXdhV0hjU2MwK0szajVPZmpZNC9u?=
 =?utf-8?B?K3lOKzRWS2U5SXVLbGlhd280cTloSHJNSkNpNGVXOVpacVhKL2JidjVhWGJ2?=
 =?utf-8?B?MnRlb1hvRUorZHY4ZU50bDlBRTBFTnhyaFJDdnhPMFRRZFNVV1hyTysvZ3Zh?=
 =?utf-8?B?ZnZweStTQkJaWDZTY0l4SlU2UkpQd2tieU45NDhYMlVhcXdXNmpubW5JM21q?=
 =?utf-8?B?bmV0VUR1WmFCcTBxM1RqcEk5ZXRleVlRRzgvT0xtRFNmQlZQZmFwRGJCNUlm?=
 =?utf-8?B?SUZnbTdXanYyT3MvakJBazBmaW12VWtVMHVOcVUwR0x3Sm5PVEVqbGN0U2N1?=
 =?utf-8?B?RktWSEd4YVpPbUVTcERQNlFMbUgwOWczYUprYnRWTkhlWnJzZGdIK0x5dUx3?=
 =?utf-8?B?SC9LWGkvU0dhWDR0aGdRUE04OVFHNk9tTWRkNkRMVUpMMHEyUHVjWGdScENz?=
 =?utf-8?B?WTlYRVZiVXlFTDNmMGYxWkJBWVF0enpkR0ovbVh6QzAyQkZpZ1E3MWZBMjc1?=
 =?utf-8?B?Um1pMGQzZ1FWRnVrcDNVeS9Dc2ZNYVFudjQxQUxrYUoyTW9kOTc5aHpqYVoy?=
 =?utf-8?B?T1BuZVplUUZWWU5lVmVKQ3o4djJhWGZmYWJDeS9RdVB3MUxyTll2dC8vUWcr?=
 =?utf-8?B?QzVuZFh3S3RBOERGR3pFazVTcDRjY1JMZmVpdmh0WE5CcFZqWldzaFdUN1J3?=
 =?utf-8?B?NVhrU1RaMzVscXg1ZG1QaDRPWHZmNWx6b2RXdDhQSzUyYXc2TUI3eE5GWnp3?=
 =?utf-8?B?VXhqYkpZY1A4MUFURGhnS3ZVZzhpcnBSWGRvQ3NMdDl0dk9jY0xFOWFrV05R?=
 =?utf-8?B?WjBsS3gxNDJSYWhlVnJERWxJSVZiYkZycFg3RkxjTmlzbloxL1czMGEyT1dl?=
 =?utf-8?B?VW4xR00xWmdQUTQ3SVB2MDdobXZMbWM5VnB0MitYclZMemY5YkRUOGo5NnFj?=
 =?utf-8?B?Y3FRL09lQUNhUUR1eFBQL1dSb256TFVjVGwvU1VuWlR4K2xVeDZ4SHNEL0NL?=
 =?utf-8?B?Q0JSTFQ3ZDd5eGQrMTI2UmlveTFEMU9PbVhtS2dteUJINmlTQ2dvK01MeHhG?=
 =?utf-8?B?YlhWOGpLMFRLdzBsS29PNWx4WEdUaWw2VXZxYk85MUt4ZXBjY0FhQkF2SkJw?=
 =?utf-8?B?TWRWUUJCR0VmM09SZWxRRjFPRjhxeVh4alB1V2xXVlY0SEpJaEZyK3p0Wnpo?=
 =?utf-8?B?eHRud0tSbXlaekE0dkxmajdMV2xLL1RheEY2cjI3ZTRuYWgybGVDU1V1TWZV?=
 =?utf-8?B?M0tRS01QbHJXVjRSdCt1eVkraTlKL1J3aHNBS1I3cEFxWmVCSnIxQzJCZm9O?=
 =?utf-8?B?VFdTaGI4QXE2Mm5ZNkVKUFF2TWhmOW43OTkzVlYzVW81MHZjcFdPcm5DRlJX?=
 =?utf-8?B?aU1XOStOdWxRTU44blhobWFvREV2U2tnQzZ4Vmg5eWsxeGlQcGVqQkN0cXhV?=
 =?utf-8?B?bVd6aUdkODlWb0F2R3RrWTU2NkR0RnN0bkI3SzIxYXA5NGFEQXhHUStoNEhw?=
 =?utf-8?B?d0plNEFjLzRUUlJVaTdCek0zUGJvcW1pb3JHcHlhdUhHc3Z3TENSV1ptL2RY?=
 =?utf-8?B?QlF6eGMwc0s5eGpJQkNUMHRvU0dJamp3OUxqSURZcjJ3cStPbDdtWXdIT29U?=
 =?utf-8?B?Q2M0aU50UDNNOTFaMkpSc0Fwa2xnK0h1N2hVSG43d29ET0o2cm5kNzd6UHg1?=
 =?utf-8?B?L0tqWW11ejdkcFZjSlB0MHBiWXQ5K0QvRXlEM3NLVHIwVFhtY3JoZ3RkekxD?=
 =?utf-8?B?dmtKcUtidThvaThmZlVaTEFqRVFZV0xoMSt4dk1HTy9IcWxRZTk2cmdGVUlt?=
 =?utf-8?B?enhRRllNeTRaK3dXcm9pZWtqNXViZklXSFRTUHNaV1MyRU13Zlp6ZzFmNHBq?=
 =?utf-8?B?ZEttQnlVM3NSbTdmaDA5SFJpVVA3NWNEZTZyR1p5Rm5kTHNid0JoMHVBSUxr?=
 =?utf-8?B?Q0M2dFUxZUR0MjdjUkc4cVZqWDQvK3gwTzduQStkWUU4K0RqSUZBOE9MeFB2?=
 =?utf-8?Q?9C+MY5tw7CbdzEBw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D00F7415EA0DCC4D80A66AAD16229F32@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c42e60-83db-49cb-a2ca-08def853b37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 09:25:51.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i61TMDvshQAWs7SnfwM02/wwnd/QccI5FdCLUp3MPbHvNczsjbaIOGNx7KctW1n3m+ohsijBXb1+45qG0+PkRHzfYizJFoCU5PtsHwIuME4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9018
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 09:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23903

T24gVHVlLCAyMDI2LTA4LTExIGF0IDA5OjM3ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMS4wOC4yNiAwODo1OCwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQgUlBEIENFRCBTRVMtQVQp
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNi0wOC0xMCBhdCAxNTowNiArMDIwMCwgSmFuIEtpc3pr
YSB3cm90ZToNCj4gPiA+IE9uIDEwLjA4LjI2IDE0OjAyLCBIZWluaXNjaCwgQWxleGFuZGVyIChG
VCBSUEQgQ0VEIFNFUy1BVCkgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAyNi0wOC0xMCBhdCAx
MjozOSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiA+ID4gPiBPbiAxMC4wOC4yNiAwODo1
NSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBPbiA4LzcvMjYgNTo0NCBQTSwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMu
Y29twqB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRnJvbTogQWxleGFuZGVyIEhlaW5pc2NoIDxhbGV4
YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20+DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiBCeSBkZWZhdWx0IGZhY3RvcnkgcmVzZXQgY2xlYXJzIHRoZSB0cG0uIFRoZXJlZm9yZSwga2V5
cw0KPiA+ID4gPiA+ID4gPiBuZWVkZWQNCj4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4g
ZGVjcnlwdCB0aGUgaW1tdXRhYmxlIEEvQiByb290ZnMgaW4gZnVsbCBkaXNrIGVuY3J5cHRpb24N
Cj4gPiA+ID4gPiA+ID4gc2V0dXBzDQo+ID4gPiA+ID4gPiA+IGNhbm5vdCBiZSByZXRyaWV2ZWQg
YW55bW9yZS4gVGh1cywgdGhlIGJvb3QgZmFpbHMgYW5kIHRoZQ0KPiA+ID4gPiA+ID4gPiBkZXZp
Y2UNCj4gPiA+ID4gPiA+ID4gY2Fubm90IGJlIHJlY292ZXJlZC4NCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIHJlbW92ZXMgc3VjaCBjb21iaW5hdGlvbiBm
cm9tIHRoZQ0KPiA+ID4gPiA+ID4gPiBrY29uZmlnDQo+ID4gPiA+ID4gPiA+IGFuZA0KPiA+ID4g
PiA+ID4gPiBkb2N1bWVudHMNCj4gPiA+ID4gPiA+ID4gdGhlIGlzc3VlIGV4cGxpY2l0bHkuDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgd2FzIG5ldmVyIGluIHNjb3BlIG9mIHRoZSBm
YWN0b3J5IHJlc2V0LiBZb3UgY291bGQNCj4gPiA+ID4gPiA+IGltcGxlbWVudA0KPiA+ID4gPiAN
Cj4gPiA+ID4gUHJvYmFibHksIGJ1dCBpdCB3YXMgcGFydCBvZiB0aGUgY29uZmlndXJhdGlvbiBv
cHRpb25zLiBJbW8sDQo+ID4gPiA+IHRob3NlDQo+ID4gPiA+IHNoYWxsIHNlcnZlIGFzIGEgZGVt
byBmb3IgaXNhci1jaXAtY29yZSBmdW5jdGlvbmFsaXR5LCBhbmQgb25seQ0KPiA+ID4gPiBpbmNs
dWRlDQo+ID4gPiA+IHZhbGlkL3N1cHBvcnRlZCBzY2VuYXJpb3MuDQo+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gaXQgYnkNCj4gPiA+ID4gPiA+IG1vdmluZyB0aGUga2V5cyBpbnRvIHRoZSBib290IHBh
cnRpdGlvbi4gQnV0IHRoaXMgbW92ZSB3aWxsDQo+ID4gPiA+ID4gPiBjcmVhdGUNCj4gPiA+ID4g
PiA+IGFub3RoZXIgY2FuIG9mIHdvcm1zLg0KPiA+ID4gPiANCj4gPiA+ID4gVGVtcG9yYXJpbHkg
bW92aW5nIHRoZSBrZXlzIHRvIGJvb3QgcGFydGl0aW9uLCBpcyBub3QgYW4NCj4gPiA+ID4gb3B0
aW9uLg0KPiA+ID4gPiBIb3cgYXJlIHRoZXkgc2VjdXJlZCB0aGVyZT8NCj4gPiA+ID4gDQo+ID4g
PiA+IEEgcmVlbmNyeXB0IHdpdGggbmV3IGtleXMgc3RvcmVkIGluIFRQTSBhZnRlciBUUE0gY2xl
YXJpbmcgb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHBhcnRpdGlvbnMgaG9sZGluZyB0aGUgcm9v
dGZzIGFmdGVyIHRoZXkgZ290IHVuc2VhbGVkIGNvdWxkIGJlDQo+ID4gPiA+IGFuDQo+ID4gPiA+
IG9wdGlvbi4gQnV0IHllcywgdGhhdCBpbXBsaWVzIG1ham9yIHJld29yayBvZiB0aGUgZmFjdG9y
eS1yZXNldA0KPiA+ID4gPiB3b3JrZmxvdyBpbiBpbml0cmFtZnMgYW5kIHBvdGVudGlhbGx5IGhh
cyBzaWRlIGVmZmVjdHMgLw0KPiA+ID4gPiBkZXBlbmRlbmNpZXMNCj4gPiA+ID4gb24gY3J5cHQg
aG9vayBsb2NhbC10b3AuIEFuZCB5ZXMsIHRoZXJlIG1heSBiZSBhIHNtYWxsIGNoYW5jZQ0KPiA+
ID4gPiB0bw0KPiA+ID4gPiBicmljaw0KPiA+ID4gPiB0aGUgZGV2aWNlIHdoZW4gdGhlIGRldmlj
ZSBwb3dlcmN5Y2xlcyBhdCB0aGUgd3JvbmcgdGltZS4NCj4gPiA+ID4gRWxzZSwgYSBtb3JlIGdy
YWNlZnVsIHJlbW92YWwgb2Yga2V5cyBmcm9tIFRQTSBjb3VsZCBhbHNvIGJlIGFuDQo+ID4gPiA+
IG9wdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IEFsbCB0aGluZ3MsIHdlIG5lZWQgdG8gdGhpbmsg
YWJvdXQgaW4gbXVjaCBtb3JlIGRldGFpbCwgYWxzbw0KPiA+ID4gPiBjb25zaWRlcmluZyB0aGUg
bnVtYmVyIG9mIHVzZSBjYXNlcyBmb3IgYSB0cnVlIGZhY3RvcnkgcmVzZXQNCj4gPiA+ID4gc3Vw
cG9ydA0KPiA+ID4gPiB3aXRoIGZ1bGwgZGlzayBlbmNyeXB0aW9uIGluIHBsYWNlLg0KPiA+ID4g
PiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdlIGFscmVhZHkgaGF2ZSBh
biBvcHRpb24gdG8gc2tpcCBUUE0gcmVzZXQgaWYgbm90IGRlc2lyZWQgb3INCj4gPiA+ID4gPiBw
cm9ibGVtYXRpYy4gV2h5IG5vdCB1c2UgdGhhdCwgb3IgYnVpbGQgc21hcnRlciBvbiB0b3Agb2Yg
aXQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMswqB0aGVyZSBpcyBhbiBvcHRpb24gdG8gYnlwYXNz
IFRQTSBjbGVhcmluZy4gVGhhdCdzIGFsc28NCj4gPiA+ID4gZG9jdW1lbnRlZC4NCj4gPiA+ID4g
DQo+ID4gPiA+IFRoZSBwYXRjaHNldCBpcyBvbmx5IGFib3V0IHRvIGRvY3VtZW50IHRoYXQgdGhl
IGRlZmF1bHQNCj4gPiA+ID4gZmFjdG9yeS0NCj4gPiA+ID4gcmVzZXQNCj4gPiA+ID4gY29uZmln
IGRvZXMgbm90IHN1cHBvcnQgZnVsbCBkaXNrIGVuY3J5cHRpb24gc2V0dXBzIGFuZCBub3QgdG8N
Cj4gPiA+ID4gb2ZmZXIgYQ0KPiA+ID4gPiBkZW1vIGNvbmZpZyBvcHRpb24gZm9yIHRoaXMgbm9u
LXN1cHBvcnRlZCBjYXNlLg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGYWN0b3J5
IHJlc2V0IGhhcyBhbHJlYWR5IHdheSB0b28gbWFueSBsaW1pdGF0aW9ucy4gSSB3b3VsZA0KPiA+
ID4gPiA+IHJhdGhlcg0KPiA+ID4gPiA+IGxpa3RvDQo+ID4gPiA+ID4gd29yayBpbiBtb3JlIGNh
c2VzIHRoYW4gaW4gbGVzcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFdpdGhvdXQgbWFqb3IgcmV3b3Jr
LCB0aGUgb25seSBvcHRpb24gaXMgdG8gZGlzYWJsZSBUUE0tDQo+ID4gPiA+IGNsZWFyaW5nDQo+
ID4gPiA+IGZvcg0KPiA+ID4gPiBmYWN0b3J5LXJlc2V0IGluIEZERSBzZXR1cHMsIGJ1dCB0aGF0
IGhpZGVzIHRoZSBmYWN0LCB0aGF0IGl0DQo+ID4gPiA+IGlzIG5vDQo+ID4gPiA+IGNvbXBsZXRl
IGZhY3RvcnkgcmVzZXQuIFNvIGVpdGhlciBLY29uZmlnIHNoYWxsIGJlIGV4cGxpY2l0DQo+ID4g
PiA+IGFib3V0DQo+ID4gPiA+IHRoYXQsDQo+ID4gPiA+IG9yIG5vdCBvZmZlciB0aGUgb3B0aW9u
IGZvciBGREUgKyBmYWN0b3J5LXJlc2V0IGF0IGFsbCAod2hhdCBJDQo+ID4gPiA+IGRpZCkuDQo+
ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBSZXNldHRpbmcgdGhlIFRQTSBpcyB0aGUgcG9vci1tYW4n
cyBhcHByb2FjaCB0byBmYWN0b3J5IHJlc2V0DQo+ID4gPiBhbnl3YXkuDQo+ID4gWWVzLCBidXQg
d2l0aG91dCBUUE0gcmVzZXQgY3VycmVudCBkaXNrIHdpcGluZyBzdHJhdGVneSBpcyB0byB3ZWFr
Lg0KPiA+IA0KPiANCj4gT25lIG9mIHRoZSBsaW1pdGF0aW9ucyBvZiB0aGUgY3VycmVudCBhcHBy
b2FjaC4gTGV0J3MgZml4IGl0IHNvIHRoYXQNCj4gVFBNLXdpcGluZy1vZmYgd2lsbCBub3QgY2F1
c2UgdG9vIG1hbnkgc3VycHJpc2VzLg0KPiANCj4gPiA+IEl0DQo+ID4gPiBpcyBub3QgbmVlZGVk
IHRvIHJlc2V0IHRoZSBkaXNrIGVuY3J5cHRpb24ga2V5cywgYWxzbyBmb3IgdGhlDQo+ID4gPiBk
YXRhDQo+ID4gPiBwYXJ0aXRpb24sIGFuZCB3ZSBhcmUgc28gZmFyIHRvbyBsYXp5IHRvIGlkZW50
aWZ5IGFuZCBkZWxldGUNCj4gPiA+IG90aGVyDQo+ID4gPiByZXNvdXJjZXMgaW4gdGhlIFRQTSBp
biBhIG1vcmUgdGFyZ2V0ZWQgbWFubmVyLiBPciB3YXMgdGhlcmUNCj4gPiA+IGFueXRoaW5nDQo+
ID4gPiB0ZWNobmljYWxseSBwcmV2ZW50aW5nIGFuICJhbGwtb2JqZWN0cy1leGNlcHQtZm9yIiBU
UE0gcmVzZXQ/DQo+ID4gPiANCj4gPiANCj4gPiBJcyBpdCBhIHJlc2V0IHNvIG9uZSBjYW4gaGFu
ZCBvZmYgdGhlIGRldmljZSB0byBzb21lb25lIGVsc2U/IElzIGl0DQo+ID4gYQ0KPiA+IHJlc2V0
IHNvIHNhbWUgY3VzdG9tZXIgY2FuIHN0YXJ0IG92ZXIgYWdhaW4gY2xlYW5seT8gT3IgaXMgaXQg
YQ0KPiA+IGRlY29tbWlzc2lvbmluZyB3aXRob3V0IGRldmljZSByZXVzZT8NCj4gPiANCj4gPiBD
dXJyZW50bHksIHRoZSBrZXkgZXhwb3N1cmUgaXMgbm90IGxpbWl0ZWQgdG8gdGhlIGluaXRyYW1m
cyBob29rDQo+ID4gaW1wbGVtZW50aW5nIHRoZSBjcnlwdCBzZXR1cC4gU28gZGVwZW5kaW5nIG9u
IHRoZSBzeXN0ZW0sIHVzZXJzIG1heQ0KPiA+IHJldHJpZXZlIHRoZSBrZXlzIG9mIHRoZWlyIHN5
c3RlbS4gSWYgc3VjaCBkZXZpY2UgaXMgcmVjeWNsZWQgYW5kDQo+ID4gcG90ZW50aWFsbHkgc2hp
cHBlZCB0byBhbm90aGVyIGN1c3RvbWVyLCBlaXRoZXIgYSBrZXkgZXhjaGFuZ2UgZm9yDQo+ID4g
dGhlDQo+ID4gZGlzayBlbmNyeXB0aW9uIGlzIG5lZWRlZCBvciB0aGUga2V5IHN0b3JlZCBpbiBU
UE0gbXVzdCBiZSBzZWFsZWQNCj4gPiBzbyBpdA0KPiA+IGNhbm5vdCBiZSB1c2VkIGFmdGVyIHRo
ZSBjcnlwdCBzZXR1cC4NCj4gPiANCj4gPiBOb3Qgc3VyZSBhYm91dCB0aGUgYWN0dWFsIHJlcXVp
cmVtZW50cyB0aGF0IGxlZCB0byB0aGUgZmFjdG9yeS0NCj4gPiByZXNldA0KPiA+IGltcGxlbWVu
dGF0aW9uLiBJZiBrZWVwaW5nIFRQTSBrZXlzIGZvciBkaXNrLWVuY3J5cHRpb24gaXMgb2ssIGEN
Cj4gPiBjbGVhbg0KPiA+IHdpcGUgb2YgdGhlIGNvbnRlbnRzIHdvdWxkIHNpbXBsaWZ5IHRoaW5n
cy4NCj4gPiBEbyB3ZSBldmVuIHdhbnQgdG8gc3VwcG9ydCBGREUgdXNlIGNhc2VzIGZvciBmYWN0
b3J5LXJlc2V0PyBzeXN0ZW1kDQo+ID4gKHdoaWNoIHNlcnZlZCBhcyBhIGJsdWVwcmludCBmb3Ig
dGhlIEFQSSBhZmFpaykgZG9lcyBub3QuDQo+ID4gDQo+IA0KPiBBbGwgdmFsaWQgcXVlc3Rpb25z
Li4uDQoNCkhvdyB0byBwcm9jZWVkIHdpdGggdGhpcyBwYXRjaCBzZXQ/DQoNCkN1cnJlbnRseSwg
RkRFICsgZmFjdG9yeS1yZXNldCBpcyBicm9rZW4gPT4gc2hvdWxkbid0IGJlIGluY2x1ZGVkIGlu
DQpLY29uZmlnIGFuZCBzaG91bGQgYmUgZG9jdW1lbnRlZCB1bnRpbCBmaXhlZC4NCg0KQlIgQWxl
eGFuZGVyDQoNCj4gDQo+IEphbg0KDQotLSANCkFsZXhhbmRlciBIZWluaXNjaA0KU2llbWVucyBB
Rw0Kd3d3LnNpZW1lbnMuY29tDQo=

