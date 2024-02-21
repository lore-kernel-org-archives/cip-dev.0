Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DABC48BF6
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web10.9212.1708506370158878992
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:06:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vrzh6oDJ;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+pm5KiSBQ9CAfHe4TjrtS+t/P/Dwu1IP1W6zxdb4T1MNh7qH8e1BmVv3XWWPpz9eB9SeBLnf+hk/LoMSG9lWtdJDfxCpNHYMa1d8YEl8zbb9J9K294G3tkhW2ywWRfPWA07Kg4jQ/n/OIrfxC2WaLe9ynWyE3/yso0tqgAPvpDRFpi+3T7XdO5mGaW8RUp6GqIsnb8Lry0y6k/YZ7gYl6QsDSH7cnteqVa3W9HhWM3k2FzGEWcfxiCLP8LReEQp/BjUWBhtqJgWuHe/4rx9j+80ajmSn0KtmGUE5fk4rijGooCyp47JSdF0oB64vWL0wQ9wRS5kqs3mxlylijHp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mONKZIVOBAY+8a4jI81uXFMt+WR7V3NqVsXfTSlTcJU=;
 b=MGz8MRCih36nV9hFuJgXUZwVh9cKWkg9xYSV4S5QerNPXIuTAOFeaQFKydN/2wCIHQlDyFKg23jem1z7dwAbEx0UTpT2H2kVKSgiM3OqmXCtrFbmiTxGOL0hquLpAUKWmbprO+iG6FFN5FJkKKv7d23CFh7c4Al8un+Hsuui7+mtHlLES4ZamlMLDHuJderHQMzElUm16j82txcLG33AeLcMMEbHr0Swp/3OEOULeeCt2OepsnLPYsVYnVKcvNDOYdwAQ6MHUg/mxAGCgws5+eYwDdxso8gdGC2oTahc6BgdmSjoiPNSYe8b5BoODMJMzchYDdlmPZjJNaS8wmdhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONKZIVOBAY+8a4jI81uXFMt+WR7V3NqVsXfTSlTcJU=;
 b=Vrzh6oDJC750bETfUiUkllysZn1nkc8kThpSZHGXroTxqCoNc85IFNsMji+bWNI8XAABAL68l65GVQmrqowqUJOtqI4S2b17GWXI9+xEIxcZZp9JDZijrGwYzYK6Tl6Brw0AEJ1v1XWOW+dvYy6K7ZNp4N6KbCamTiDX5slBHOITCsS74KBETHvnnmC76qM5Gy7625EBwGFhrzXXdwVod0ukCTkoSG2liYp1+gJHQSZLbelE75nTqrqmEij01R52IBL8uD27viutCJz4IlPAVdcnXbU16CMC8lLXU9Sr0j2toDSJIX5MV5D3bYmqbx0t35R1KZir6dxeIlhQQwa1RQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAXPR10MB5160.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 21 Feb
 2024 09:06:07 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:06:07 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
Thread-Topic: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add
 SWU_EXTEND_SW_DESCRIPTION
Thread-Index: AQHaLC092wGU0aJu902bupmy5IjItbEU5f0AgAAIiACAAAOHAA==
Date: Wed, 21 Feb 2024 09:06:07 +0000
Message-ID: <402501ce19a19e4717d7b62ebdc495cd4fc853c3.camel@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
	 <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
	 <217b7c161aa3a608ff107d5f2661d384722a259f.camel@siemens.com>
	 <10f157f7-4b0e-4900-a7c3-2ef1f08c5c8e@siemens.com>
In-Reply-To: <10f157f7-4b0e-4900-a7c3-2ef1f08c5c8e@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAXPR10MB5160:EE_
x-ms-office365-filtering-correlation-id: 1124a1df-8180-4a33-dd68-08dc32bc56e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OrgWq1TP3TPo2J2Ti8BYFy51zG+y6qcrq4RCcNrlgfNZmHergBJTXTq7HCgT1B7M2l0vEin9VNzizMn1+kgzd9EbBV93TeirzuXXswDg7Lb33vumfkisME4ytlXHHsXIVr+aM1QjNpMpeVJi4zTW4uz48aCZavytlXX1pwNilEFvxlaSHH2wNO1upULY0JSnFv2P75ZcwSm0pWYe5ToRPFi+7jeOsYMRjIVYsu0hE/B9UF1FOqMr0chrZy7exWbRy4ScNuY3T1J4Ci4CaPttdxL06roorAGY0xCQyGBY/RApc+5A0U0ybkQeRc5SyDfl8B79U+iIZcyGGrOBBVS5Nz61p/kW4mopAdlvFXTYOBud/aUG6t+vfa1b5oCkJAhWYxIC/nCYWuRq+zJQmJRC2ZYn+RH15FQRY2eKPj2Uqe4mR4MJZ9c0gEuQt9xHA+6dKXsHvRLFXS2+tFFIRqA/7nGlb6RMXKFvtTQiUcNZXsE1PEDTZjv39cxRd65i95X5hYUxvlOznFzdHlKJmGKvKZC3EnRtV9njk4y2P8WWijj4q4gU7uxYYZliET/mvoh5zxPk73q1x5VH9mVNfWVQjOqJMFaIUIyaThC7mJjyxYV4vJxDjAICWtdwrZaugsCm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y1RjRXBSa1lMNXR4a1hWVnZlczhCTTlGSkx1b2lVSU9aeUt0RFNtOFBrN3Q5?=
 =?utf-8?B?QmpLM1ZDWUtTVzJoQUI5WGswc0ZhOTkwTXdlTmR6MXJNYWxQSEtMcDFBNGtC?=
 =?utf-8?B?NWh5QmJxWGhKK1VKdEdOQ1FVUHoyY0U3KytFVk10ZWQrWVpPNXZydTJRYnJO?=
 =?utf-8?B?aG1kNXdXZ2JwV0k2N1BwMHVWSE8ySjF0czdWeHYvNHpQaHVuY3pHNmNWd256?=
 =?utf-8?B?M3VJUnFrTFZFRnJjQWlLRW9lQTljQVQvVFRjdVBPQ2NVRk5MSHJ1SFJLbVBw?=
 =?utf-8?B?Z2hiS0dDUktZaTlpTmFRL1NWQ01OOTAxejF0SlZGRXRnbzR4dm5VVGdkSjNt?=
 =?utf-8?B?TWNWVGpGRG9PTEYwYVVJWGI1cVhLR2JCakhieXhIVXp4b0huMll2L1JMMzQ0?=
 =?utf-8?B?TXc3Mm53MXRmQUZjYkFmYnRrTytyQ2svTmdKU2o0NjBQRVRVWTl5MTBEVWdo?=
 =?utf-8?B?aUdheWRtL3pXWVFpeWVwSlM2YTZxZzkzY2NkNmpJYnVjd0xDbi9GeGRERWpW?=
 =?utf-8?B?YWROeitnS3FPMGluang1NzNZQU85bjc3Z1oyU1pvSm1aWkFGRlBYc09MWkQ0?=
 =?utf-8?B?QTFaeEJWRys3aDkzaVVJZHBtTU1KZFc1K1F1Tnc3RmxRWEFQWEpRaVlTZnpV?=
 =?utf-8?B?dUZ2R1lEYkRtVFplMWRHaEQ4NFlXVFAzbUNaSmRpVkZPcUpPSHJSdFMwNU1P?=
 =?utf-8?B?ZC9Pd3c5c0ZkWjVCLzdYYkNrM0poak9OMDQ5dUpWNHZlWSswUXFXc1ZicDFY?=
 =?utf-8?B?UWllb0N1dm1Ua1RhbXMvQTB5VzNCazJaa2RBa1ZacFBsM3dyR1pSL2RWNG9Q?=
 =?utf-8?B?Zzllck42bFVVUFNONTBxSEZHeUMvVm5oY3BvZnRzbjZpeXJKMFJYY2hLMERX?=
 =?utf-8?B?Q3cwanpnN3ZvTVVQZDIwR1pLWWJ3VDhtNE5yWTlYWmFMbXBaVldaamx1elZR?=
 =?utf-8?B?WUlyU0tOR1cxWS8xQ2VmdDdFQ0ozTjdmSVd0c2VIUDBua0dScXJTVUo5Zkcv?=
 =?utf-8?B?ZnNMc1BPS1NSZFg1bm1kTDRENllwSzRjZlROOW1Tcmc3NXFXa2FFeEk4am8x?=
 =?utf-8?B?QnVrUlhidzJBNUd6NjRXYWFCbnI1TzBDZi8yc0UxdmtRWjVLMVByUW1BSkdV?=
 =?utf-8?B?cmNHMFFCS0wwOEorR096U0lobkZCV3RBdVpxLzFEaTJNdXQvUzc2S0ZZazhZ?=
 =?utf-8?B?aHNLdW5OT2M3VnNsNlIwWXlPcFloYVE0cmROV1NPOGg5MVo3WjZUWDdPTXox?=
 =?utf-8?B?eGFORHBHczQ3ZjV2L0IxQW5oemtJbmhKV1hObWN4NFFOeFA2N1RIR2ZEZmZX?=
 =?utf-8?B?SDd5WkxzTlA2QmJxaDdCaEU4UjVCWEoweGJvdXRyZy9lbzBkSjd6Y3pOTTNj?=
 =?utf-8?B?SXVWUXV6b1dKWGFQNGNITWllZm5DL25PeXE5bDZsVDBZZzg4RlNFczdvM2Jx?=
 =?utf-8?B?SFU0VmxaaDJZV2s4WDZqcXhDWVBQc3lHVGlobkk3MHJVK1VqRHlhTGVJWXNO?=
 =?utf-8?B?YXkwKzhoRHJHaVRTN3haYjY4MXd4eDg0UkdGNjFEZ3NWY1dZcmRGQjZKS0o4?=
 =?utf-8?B?VDJsMy83OHRmZGd2OCtQelVsSUhMU2xXaU1FOWdDdUp3dEZqL0FHVi9WaWlk?=
 =?utf-8?B?bldrdFhsS3lBajkxZUh3dXh6TGZUaEh3d0EwbXB4bGxVeERBZFVlRXFUS2FH?=
 =?utf-8?B?QjVkRGhacG5sWnM2cmFwaTBtdEI5elpzb0dlaVdJV3oyc2FvRnBqVERzMGFZ?=
 =?utf-8?B?NnRINzZxN3hYaFcva1I3b3NqcWZ1RnNSeEhPaGhlTXhQa3lTYWtpVEw1Z20x?=
 =?utf-8?B?VGUyMlg3djFkWGNDT0w0NmFkN1dUVFBSQk9LOC9hbGEzWlpoWDYyQVdOWksy?=
 =?utf-8?B?ei9lcXRoTzZzRW5hZ3R4dkppTTB3b0dTaW52N0dXa0o5cUtZaVJPYjJ6SC8w?=
 =?utf-8?B?TjBvdlVVV0ZBNUQvdkdTQkF3K2E2Q2NTZFJZNkozSWM1KzN3TmdCdCt3aHhr?=
 =?utf-8?B?b0tIUkJ3TVordjF1OHAyY0RKMzZqSVYwNzNJZUFTWG9zdFRxM0h6S2VVU0RE?=
 =?utf-8?B?ZUVRMHJoeisrY0NXa2NDL2pOOFJzMnhiQndMWjlRYVFxRlJJVEZEMVREUlZN?=
 =?utf-8?B?NHhpL2t1L3lpUzVORWhaOHpSOFdIWXlJbHo1UW1QSDRTVm5qc05YaTMvR1Uv?=
 =?utf-8?B?ZVRoMC8vNmptL21sMnJyQ01MTGdiT3JORVF6SzFUQWl6cXdsa2RIN0RZTjRK?=
 =?utf-8?Q?17atPvaOiyQJmKnl6Is7fJMZ5ZyWjSZeGzpxJyqJ/E=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1124a1df-8180-4a33-dd68-08dc32bc56e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:06:07.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: topzf4GZ2UQFDu1Co1a1pId38GGaTo6HnTXPDsYHtDPnpZAmiCcC7DwBjPucznyrhqKPeu8hxDzG0NYjtyS3BKwiowqPvbrEeXrHNKq9WwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5160
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C1FFC43EBC8F84980734ECCE6BD38B6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15053

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDA5OjUzICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMS4wMi4yNCAwOToyMiwgTW9lc3NiYXVlciwgRmVsaXggKFQgQ0VEIE9FUy1ERSkgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDIzLTEyLTExIGF0IDEzOjE5ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZm
IHdyb3RlOg0KPiA+ID4gRnJvbTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbT4NCj4gPiA+IA0KPiA+ID4gVGhlIGVsZW1lbnRzIG9mIHRoZSBuZXcgdmFyaWFi
bGUgYXJlIGNhbGxlZCBhcyBmdW5jdGlvbnMuIFRoaXMNCj4gPiA+IGFsbG93cyB0aGUgdXNlciB0
byBleHRlbmQgdGhlIHN3LWRlc2NyaXB0aW9uIGZpbGUgd2l0aCBuZXcNCj4gPiA+IHRlbXBsYXRl
DQo+ID4gPiB2YXJpYWJsZXMgYW5kIG5ldyBlbnRyaWVzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiDCoGNsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyB8IDE0ICsrKysrKysr
KysrKysrDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4gPiAN
Cj4gPiA+IGRpZmYgLS1naXQgYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgYi9jbGFzc2VzL3N3
dXBkYXRlLmJiY2xhc3MNCj4gPiA+IGluZGV4IDExN2Y5ZmUuLjBlOTVlM2MgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gPiA+ICsrKyBiL2NsYXNzZXMvc3d1
cGRhdGUuYmJjbGFzcw0KPiA+ID4gQEAgLTIyLDYgKzIyLDcgQEAgU1dVX05BTUUgPz0gImNpcCBz
b2Z0d2FyZSB1cGRhdGUiDQo+ID4gPiDCoCMgc3BhY2Ugc2VwYXJhdGVkIGxpc3Qgb2Ygc3VwcG9y
dGVkIGh3LiBMZWF2ZSBlbXB0eSB0byBsZWF2ZSBvdXQNCj4gPiA+IMKgU1dVX0hXX0NPTVBBVCA/
PSAiIg0KPiA+ID4gwqANCj4gPiA+ICsNCj4gPiA+IMKgU1dVX0lNQUdFX0ZJTEUgPz0gIiR7REVQ
TE9ZX0RJUl9JTUFHRX0vJHtJTUFHRV9GVUxMTkFNRX0uc3d1Ig0KPiA+ID4gwqBTV1VfREVTQ1JJ
UFRJT05fRklMRSA/PSAic3ctZGVzY3JpcHRpb24iDQo+ID4gPiDCoFNXVV9BRERJVElPTkFMX0ZJ
TEVTID89ICJsaW51eC5lZmkgJHtTV1VfUk9PVEZTX1BBUlRJVElPTl9OQU1FfSINCj4gPiA+IEBA
IC01Myw2ICs1NCwxNiBAQCBJTUFHRV9URU1QTEFURV9WQVJTOnN3dSA9ICIgXA0KPiA+ID4gwqBh
ZGR0YXNrIGRvX3RyYW5zZm9ybV90ZW1wbGF0ZSBhZnRlciBkb19nZW5lcmF0ZV9pbWFnZV91dWlk
DQo+ID4gPiDCoA0KPiA+ID4gwqBweXRob24oKXsNCj4gPiA+ICvCoMKgwqAgY21kcyA9IGQuZ2V0
VmFyKCJTV1VfRVhURU5EX1NXX0RFU0NSSVBUSU9OIikNCj4gPiA+ICvCoMKgwqAgaWYgY21kcyBp
cyBOb25lIG9yIG5vdCBjbWRzLnN0cmlwKCk6DQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
DQo+ID4gPiArwqDCoMKgIGNtZHMgPSBjbWRzLnNwbGl0KCkNCj4gPiA+ICvCoMKgwqAgZm9yIGNt
ZCBpbiBjbWRzOg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGJiLmJ1aWxkLmV4ZWNfZnVuYyhjbWQs
IGQpDQo+ID4gPiArfQ0KPiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IHRoaXMgZnVuY3Rpb24gaXMg
Y29tcGxldGVseSBvZmYuIEFzIHRoZSBzd3VwZGF0ZS5iYmNsYXNzIGlzDQo+ID4gYXV0b21hdGlj
YWxseSBpbmplY3RlZCBpbnRvIGVhY2ggaW1hZ2UsIHRoaXMgZnVuY3Rpb24gd2lsbCBydW4gaW4N
Cj4gPiBFVkVSWQ0KPiA+IGltYWdlIHRoYXQgaXMgcmVhY2hhYmxlIGF0IHBhcnNpbmcgdGltZSwg
ZHVyaW5nIHBhcnNpbmcuIFBsZWFzZQ0KPiA+IG1vdmUNCj4gPiB0aGlzIHRvIGEgdGFzay4NCj4g
DQo+IFRoaXMgaXMgdWdseSwgYnV0IHVuZGVyIHdoaWNoIGNvbmRpdGlvbnMgaXMgdGhpcyBicmVh
a2luZyB0aGUgYnVpbGQNCj4gb3INCj4gY2F1c2luZyBvdGhlciBzZXJpb3VzIGVmZmVjdHM/DQoN
CkkgZGlkIG5vdCBvYnNlcnZlIGFueSBidWlsZCBmYWlsdXJlIHlldCwgYnV0IGZvciBlYWNoIGlt
YWdlLXZhcmlhbnQgaW4NCnJlYWNoIG9mIHRoZSBwYXJzZXIsIHRoZSAvdG1wL3dvcmsvIG5vdyBo
YXMgdGhlIGZvbGxvd2luZyBsb2dzOg0KLSBydW4uYWRkX3N3dV9jb21wcmVzc2lvbg0KLSBydW4u
YWRkX3N3dV9od19jb21wYXQNCg0KQXMgZWFjaCBpbWFnZSBwb3RlbnRpYWxseSBoYXMgbWFueSB2
YXJpYW50cyAoZS5nLiAtY29tcGF0LCAtc2RrLCBbXSksDQp3ZSBhcmUgdGFsa2luZyBhYm91dCBk
b3plbmRzIG9mIGxvZ3MgYW5kIGV4ZWN1dGlvbnMuDQoNCk9uY2UgdGhlIGZpcnN0IG5vbi1pZGVt
cG90ZW50IGxvZ2ljIGlzIGFkZGVkIHRvDQpTV1VfRVhURU5EX1NXX0RFU0NSSVBUSU9OLCB0aGlu
Z3Mgd2lsbCBleHBsb2RlLg0KDQpGZWxpeA0KDQo+IA0KPiA+IA0KPiA+IEBKYW46IFRoaXMgaXMg
YSBidWcgdGhhdCBuZWVkcyB0byBiZSBmaXhlZCBpbiBhIHBvaW50IHJlbGVhc2UuDQo+ID4gDQo+
IA0KPiBXZSBkb24ndCBkbyBwb2ludCByZWxlYXNlcyBpbiBpc2FyLWNpcC1jb3JlIHlldCwgYW5k
IEkgZmlyc3QgbmVlZCB0bw0KPiB1bmRlcnN0YW5kIHRoZSBzZXZlcml0eSBvZiB0aGlzIGlzc3Vl
Lg0KPiANCj4gPiBJbiBnZW5lcmFsLCBpbiB0aGUgaW1hZ2UtdHlwZSBjbGFzc2VzLCBubyBhbm9u
eW1vdXMgZnVuY3Rpb25zDQo+ID4gc2hvdWxkIGJlDQo+ID4gZXhlY3V0ZWQuDQo+ID4gDQo+IA0K
PiBZZWFoLCB0aGF0J3MgbGlrZWx5IGJldHRlci4NCj4gDQo+IEphbg0KPiANCg0KLS0gDQpTaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

