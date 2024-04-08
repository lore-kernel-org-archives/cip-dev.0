Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD889C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 11:28:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.116])
 by mx.groups.io with SMTP id smtpd.web10.100600.1712560612881743941
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 00:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q7d9F28d;
 spf=pass (domain: siemens.com, ip: 40.107.20.116, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4FbKDi8GOWp8s6IYHGSY4//TbabrWJLAT/EXZO3eL+nyTkw/s20NPVYwUvlHq/sKuHshyh0ZX0acaawszo3/nJB8hfJGY8srMaWF1iwkkRzsCtk5BHJxeavUdyddlKvqBjV9qi3DZN4Nco68IE+co7p/4GHwJaXHnBqG9wQWG7LNrPO8EAMKopjQRPCtznUOtf6Ofiq2DYrG/Yo5ILJKlhGx4Z3YnGANdqao3agOJfxhL3ziy/YNFvJvYSCbtDmwNhaHb7OfLCLGOWUz+0VBpITepvLXSjCcnlJOf73AMMUcWTf2rIbahEJC3qqNreX3emN3iibEtMPytyMLfg6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnxpwCFWNQqq8zuziGAPzabwNBvvUS39qNnJ131v+dg=;
 b=cmDo5r9OSmp6h0aU+Oy3sH9H+6dnlROkDCwMNZsePkCX0BsRUzGEq1VQhkECoaXMjAh8Iv0VI1rZOF1ZEJh5W/EYGRFmLSvvYdeNvuBhqCE9EPyhUs4rdBwWS0l1gH45+eVgxzzQ7TAPPrlCTD2wbrIC3k8Of0BCzVbo8Q7YwuvAmXs9TIkI3YWQZlBlsBWImyTNi9Cq/HQx8Hin/fe6T0Vp+dd6QM71Ufjmy/ZAFnwxhieE9kSutr+w2ge/mlX2t9wSV5TnrZkzrcEfyghUWWOn+j89RIU7shMVyhm5aK/sF5ZIzb2938NWjcoJrTYzxUBWex5ciL4+X7mL9bBswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnxpwCFWNQqq8zuziGAPzabwNBvvUS39qNnJ131v+dg=;
 b=q7d9F28dGNxgumWSYw9Za6aCpI+79fmx0MCYtiqGJ4xJ/aUxpVVXhgdjFLxdDagvASYnuZ926jSgcyXCVisYvTCaMWOoXiGYqPooYR51r3MO5I95+4ZIquKgkfSCX3AqlizcxWGLSAYIFzI45meZLUqcxg7uZZZKtdU4LTMHSuPkQL2R3zyQHs8WzIdQAyxjM67wMF4bdxjMzhfN85POcxP3RJgrLLuREo869XHY2URChd8JBwC5eM162KFKnFd2ijGbtcVpU8F0IIM2RYgfOlyDvcaL1LZaebPdeazHRu3r/Rj+CabprnG05XXwkx3C5hQ6Uvy2zCKUltL3mwetFQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU4PR10MB9024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 07:16:50 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:16:50 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"venkata.pyla@toshiba-tsip.com" <venkata.pyla@toshiba-tsip.com>
Subject: Re: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf"
Thread-Topic: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml:
 Move SOURCE_DATE_EPOCH to layer.conf"
Thread-Index: AQHahyVDazvHnuRlHEKsSgAS91SS1LFZ9IQAgAQCmwCAAAQIgA==
Date: Mon, 8 Apr 2024 07:16:50 +0000
Message-ID: <5acc553aaee7b3cf78cac467e72194ee34c6e640.camel@siemens.com>
References: <20240405064757.378647-1-felix.moessbauer@siemens.com>
	 <9125cc93-e91e-4b98-ac76-dd5364dbf275@siemens.com>
	 <c98dffde-715e-4542-8277-8313ffff7dd8@siemens.com>
In-Reply-To: <c98dffde-715e-4542-8277-8313ffff7dd8@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU4PR10MB9024:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UaRoAdJ9Qh33K6/Cba5BMurkTMrQU+7CN6FHDXaNNvQZEBkjhy01TQq+kzPZdnf7Q20rC0Vjlu7/3Pb03HzMXTnmNrH77MzAQ3a/57+sOx/ru/trG7f9wTMbKHCJjUy1Fos7iqqhqhebDnVhfZDp5/BRtv6CMKML8O1YkYDr5CP7wj9pbJtkBfIJ60GJanrlGpIvTujiQuuWXFjR81+eq/BW1oyYpawjilMttunprKOdEFkfTinlXerVw3P9mTCkl9DyzWrbEhlCRUkz9c9poXY20HYXx3T8ot5ZeQC9upU19jABhWq1elDqH6q65OsIfDjXCHG8AG4NTUOnvRTvLizj/FrhdPx+1Ot07bmH7qyIQHBKkZ4Uk7XQyAiAptvBAMZnGhZ0ocugpIOEm5CD6yRjumAcAhYhzFmKENbmf6JbPHvIr/RVd5IMsSKLAgJihAN7EhMvg5gUoCGN9zznrN1KjGN62ZRnYK+/jeFqhaDbR2aUOkcDqk/OuFeZySDOgsXLJsLJiOOGuF1WKA3M0XZprVTB8dEsO72UTCDMvBTmYgZs3muzZPQURzcIvVIoMatDqiYcFBg+r9P4qzbmWI+jgLTDMnk4VryIAx7UXxWqIXlGnfHcrOpTufRg9+E63iyAdLi125clK83wtmPkTY51lPBKX3QkvVsSsxNocuI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWJ4MG96N2lMZkw0MmhGc2l2QTJXSFYxM01aMjU5N1JMWFprN3pFWTh1bjhn?=
 =?utf-8?B?eXlTaWtBQ3dCZ0tGTG5EYmJrMjFubHBkeVFlWlV6ZStwOXpCak1JcWxLZjJW?=
 =?utf-8?B?WUMweDNXOW5xMkpKQVQzM2hhZUt4Z2RKOEVZZXhmY2ltQ1lyVS9IdUZCRVRZ?=
 =?utf-8?B?Slhjc1Byd0pYVStpNXhYZWxmWnlXR25XaWl3Wkg2UDZkODFFam9LMm1pYnpn?=
 =?utf-8?B?VmhLKy9QaFJkc09RL2VONnpiQVpVSDUxbjBDOGlRY3lsb25rQ0dvekwwWjlj?=
 =?utf-8?B?RTdRejNTcVZqSzdWc205U2RNZ0dyVklPT1RuaVVZMUN6YXMyeU1TQ1lzODl5?=
 =?utf-8?B?TEFUUTNKYWVITU9rS08rd0JWd3lIMklUOWFrU3lGaFlLVWtrU0RzOXVjUEpH?=
 =?utf-8?B?alJWSm9MMVBIWk1KTFB2c1FpUHh0K0FOWldseUQyd1JsWHZXbHR0Z1loQWpv?=
 =?utf-8?B?MGxZZGJPMnprTDlMck9SR2xnc0dLVGFuUEYzSDBTOEpHVkkrb0lQeWJqc0Jn?=
 =?utf-8?B?N0NTRitlOHA0ZGhaNTBzNUhmUmJlNjQ2OWVJRXB2S1Z3anR0dnlveis0Nzl2?=
 =?utf-8?B?VDArM0hCS2g0OG8wREg1ZllOakRJV0VtWmdiKzUzQisxM21SYkhBVTNwSlR5?=
 =?utf-8?B?RVNZSk15aHhLdno4YTltT1FIclJsRGVOdmUzNXdFTTVtVDRsNXl1d21YMFJ4?=
 =?utf-8?B?VXNkVzg2TE10RWoyNDBMVVVVQURvZVlBclZvT0JOb2dCKzhYQlQrS2pScytS?=
 =?utf-8?B?ZG5sQVJ6b29EcmZYeFNPWnV6WUNoWExETHNVMTFud3p2RnZpRURlVkh0R21i?=
 =?utf-8?B?SHU4c05kT1pFeXRIcFE1KzZuaDY0cGw4Z0xCRkhuM1R4YjFYS3YrQWxud2hL?=
 =?utf-8?B?TGZOdjhkalFES24yT3N6ZWd2RXNHVGFkMENqUys4NjE2bHpmREFiSlJ0djFs?=
 =?utf-8?B?RjVDd0txTERRM3g0dWVwSmdkb1EybXBKV3Z2bmIrVW1nalJLaVVLZ0Q5cjRy?=
 =?utf-8?B?UkFKZmZ2bmVFS09XamN3NHMzbUV0SzVkckVVU1diQWc1YTViRGtjRmxwSTdW?=
 =?utf-8?B?Y285SE1tOVFpM25CMDlJNjRiZHhsVXR2VU9BU2JreXROMzFzcXFUZ1kzVDNp?=
 =?utf-8?B?SGpuTVJaZ281dStkbzFHbHlyQVArT0VLK1hCTTlpT01lUGxVMkd2ZzBMSkRq?=
 =?utf-8?B?YmROcmVlNTRGbkJxU2dNZWFsSjlvZkN2WGpjbXhvRGh3NGlyYmJmVnZ5cGgy?=
 =?utf-8?B?S2UyNGNNRlhpbWMrcXhJWFk1V080cURyMGphY1dTY1ZWV3FYQXJ4SGUwaDhk?=
 =?utf-8?B?ckJ0OUhSNzZDYzU5d2J5TDIzWTErRTFuNi8wekNaQlBLWndSMkt5Qk1TeU41?=
 =?utf-8?B?aEVOTW4wR0JZS1A4MERkUGRHOEtkS3ZsdjNRUlllaXFLWGYzamVyaVpBYXJO?=
 =?utf-8?B?clA5RzhEaXk3bmE3S25xZ1lkZ3pUb3NSd2xaZjBJK3JkQm14eWwzbmtFc3dn?=
 =?utf-8?B?WGFrWXNmRnVYSXJ1ZG0vT1JvK295L05QSjVVREM3VXFOaUFlWHQ3N1ZCWlhx?=
 =?utf-8?B?N2pucmRweUM4QnBGa0VaSjdERWJRaitIRmgxakFXRTFpQVg3b0lJNDNpUmJi?=
 =?utf-8?B?QWs3cXdjTHJtdHAzT1NYWkNKK0RIa3FidkVYRExiUUQ2ZHNsTTJ6MEJNTUFw?=
 =?utf-8?B?bnBwSktYaFA3Y3lwRlpHNmp4aUp0TERxTjRaTVVBaXFHSDVVUkdyWGI0bEpz?=
 =?utf-8?B?OXFNNis4TjhSODhPeGRzUTVxRGxvMGd2YVBmRHJiZlJuQnR3bXlVdWQxM0px?=
 =?utf-8?B?QmVTRVE0eXFWR0FtNG9UOU9NcEhnVXRqNENKb2pURy9Jdkw5SEdSZThmWW5v?=
 =?utf-8?B?STUycytFZUl2Y3oyWFc0dThVZGFiS1lna1drRUZQRzI2VGhmK3FBSHMwSnh3?=
 =?utf-8?B?anpCNGVVeWFNdFRhYnluWWNDVTgxUkdUaVl5R0pCZFhHdC9ncmNXTnhVTnYw?=
 =?utf-8?B?SnJVSzkyUTZQbW5rc0FrY3RrME56UTdxc25LNHB6RjgyVEowbno4UHZlSlJM?=
 =?utf-8?B?SWNGWXROVWFzaVBCSnk5KzhrT1J3TGJUUzUxamxnTUZIeGJ5NEVDVnRiTXNp?=
 =?utf-8?B?dklkNHhhN0ZpNThKYnltNFFocS9UQ2RyNjJpUTZMclhDL2liaksxYzR1Qzd4?=
 =?utf-8?B?bWh5M0NnWGl4dFB2U0wvWWNFODExOUxEOEpmeXlCSkxQYnlXN01nVnRGWmZn?=
 =?utf-8?B?SjhyaDVrVEZKbTIraEphcExNamVBPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a46d542e-977c-4961-bb2f-08dc579bdbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 07:16:50.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BRCf6ebzEcpPKSX3BNhgFBO+0kBWnO83jyw4bLTXRnmWphmyHxyIeDIySN3wIoJ6L02I6QCM45u6B5IfoXyj1Tj1RSBO1uWW66ih81etgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9024
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE8EEE72925D641AB6F41E7C1063778@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 11:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15499

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDA5OjAyICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDQvNS8yNCA3OjQ4IFBNLCBKYW4gS2lzemthIHdyb3RlOg0KPiA+IE9u
IDA1LjA0LjI0IDA4OjQ3LCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3RlOg0KPiA+ID4gVGhpcyBjaGFu
Z2UgaXMgdG9vIGludmFzaXZlLiBUaGUgbGF5ZXIuY29uZiBpcyByZWFkIGFmdGVyIHRoZQ0KPiA+
ID4gbG9jYWwNCj4gPiA+IGNvbmYuIEJ5IHRoYXQsIHRoZXJlIGlzIG5vIHdheSBmb3IgYSBkb3du
c3RyZWFtIHVzZXIgdG8gc2V0IGl0IHRvDQo+ID4gPiBhDQo+ID4gPiBkaWZmZXJlbnQgdmFsdWUu
DQo+ID4gPiANCj4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZmNkYmVjOWQyYWIxZGFlYmQxOWUw
MjFjMmI5MGVkMzBkMGVlYWUwMC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRmVsaXgg
TW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gwqAgY29uZi9sYXllci5jb25mwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiAtLQ0KPiA+ID4gwqAg
a2FzL29wdC9yZXByb2R1Y2libGUueW1sIHwgMSArDQo+ID4gPiDCoCAyIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvY29uZi9sYXllci5jb25mIGIvY29uZi9sYXllci5jb25mDQo+ID4gPiBpbmRleCA4MmI0MDg0
Li4yYzg4OGIyIDEwMDY0NA0KPiA+ID4gLS0tIGEvY29uZi9sYXllci5jb25mDQo+ID4gPiArKysg
Yi9jb25mL2xheWVyLmNvbmYNCj4gPiA+IEBAIC0yNCw1ICsyNCwzIEBAIExBWUVSRElSX2NpcC1j
b3JlID0gIiR7TEFZRVJESVJ9Ig0KPiA+ID4gwqAgTEFZRVJESVJfY2lwLWNvcmVbdmFyZGVwdmFs
dWVdID0gImlzYXItY2lwLWNvcmUiDQo+ID4gPiDCoCANCj4gPiA+IMKgIElNQUdFX0NMQVNTRVMg
Kz0gInNxdWFzaGZzIHZlcml0eSBzd3VwZGF0ZSINCj4gPiA+IC0NCj4gPiA+IC1TT1VSQ0VfREFU
RV9FUE9DSCA6PSAiJHtAYmIucHJvY2Vzcy5ydW4oImdpdCAtQyAke0xBWUVSRElSX2NpcC0NCj4g
PiA+IGNvcmV9IGxvZyAtMSAtLXByZXR0eT0lY3QgfCB0ciAtZCAnXG4nIilbMF19Ig0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbCBiL2thcy9vcHQvcmVwcm9kdWNp
YmxlLnltbA0KPiA+ID4gaW5kZXggYmM3MWYyOC4uNWQ2YTg5NiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiA+ID4gKysrIGIva2FzL29wdC9yZXByb2R1Y2li
bGUueW1sDQo+ID4gPiBAQCAtMTMsNCArMTMsNSBAQCBoZWFkZXI6DQo+ID4gPiDCoCANCj4gPiA+
IMKgIGxvY2FsX2NvbmZfaGVhZGVyOg0KPiA+ID4gwqDCoMKgIHJlcHJvZHVjaWJsZS1idWlsZHM6
IHwNCj4gPiA+ICvCoMKgwqAgU09VUkNFX0RBVEVfRVBPQ0ggOj0gIiR7QGJiLnByb2Nlc3MucnVu
KCJnaXQgLUMNCj4gPiA+ICR7TEFZRVJESVJfY2lwLWNvcmV9IGxvZyAtMSAtLXByZXR0eT0lY3Qg
fCB0ciAtZCAnXG4nIilbMF19Ig0KPiA+ID4gwqDCoMKgwqDCoCBXSUNfREVQTE9ZX1BBUlRJVElP
TlMgPSAiMSINCj4gPiANCj4gPiBMZXQncyBmaXggdGhlIGlzc3VlLCByYXRoZXIgdGhhbiByb2xs
aW5nIGJhY2sgdG8gY29uZGl0aW9uYWwNCj4gPiByZXByb2R1Y2liaWxpdHkuIFlvdSBjb3VsZCBt
b3ZlIHRoZSBTT1VSQ0VfREFURV9FUE9DSCBhc3NpZ25tZW50IHRvDQo+ID4ga2FzLWNpcC55bWws
IGUuZy4NCj4gDQo+IA0KPiBBbHNvIHNpbmNlIHdlIGhhZCBtdWx0aXBsZSBpc3N1ZXMgd2l0aCB2
YXJpYWJsZXMgaW4gbGF5ZXIuY29uZiB3ZQ0KPiBzaG91bGQgDQo+IG1heWJlIHdlIHNob3VsZCBu
b3QgbGV0IGxheWVyIGNvbmYgc2V0IGFueSBidWlsZCByZWxhdGVkIHZhcmlhYmxlcy4NCj4gRS5n
LiBJTUFHRV9DTEFTU0VTDQoNClRoZSBJTUFHRV9DTEFTU0VTIGlzIGZpbmUgSU1ITywgYXMgdGhp
cyBpcyBub24taW52YXNpdmUgKGF0IGxlYXN0IGl0DQpzaG91bGQgYmUpLiBIb3dldmVyLCB0aGUg
U09VUkNFX0RBVEVfRVBPQ0ggYXMgdGhpcyBJUyBpbnZhc2l2ZSBhbmQgcGlucw0KYWxsIGRvd25z
dHJlYW0gbGF5ZXJzIHRoZSBvbmUgZGVmaW5lZCBieSBDSVAuDQoNCkBRdWlyaW46IEFzIEphbiBw
cmVmZXJzIHRvIG5vdCByZXZlcnQgdGhpcyBwYXRjaCwgd291bGQgeW91IHRha2Ugb3Zlcg0KYW5k
IHJlZGVzaWduIHRoaXM/DQoNCkZlbGl4DQoNCj4gDQo+IFF1aXJpbg0KPiA+IA0KPiA+IEphbg0K
PiA+IA0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXIN
Cg0KDQo=

