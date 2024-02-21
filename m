Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF49C48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:27 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.45])
 by mx.groups.io with SMTP id smtpd.web10.8743.1708503781024895427
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 00:23:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OF+0Yx0o;
 spf=pass (domain: siemens.com, ip: 40.107.105.45, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORSr9vhgoeYo6EO9gLX+/8QjDgHb2HpU8h58yodAQpN8FCyfAK6dAYZB0IdbEsXtA1lcCEXcQnEVhVD0Ib+O7IAWAuqcd9MtriF9rXbcWBZpZmqKC0qxagFaZlCv1YL2zStyXmZcolINchivYJ/2X4MYwIa2SclqWB/taS2bl1pGHB75sKDexmfv2kZZIcICejrHlH7MhMfC3H6T+vhsKeOYkh11hcBE6oUFoTht6ZqVOrvgPuGm2/pDdIrsYqEGVhoRqlVrycGVnYFkdkIeQrLIwzB1xzO8jYO/emXU5AHFKoJ5OD3UmmtZG2OkbREDepGTTe4D7BhmtGvp0ykkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXkcl6KQ2BB9hj++cLhu+Ss/g3n3onPgZ2kRzZPWJiA=;
 b=HYjYJXmYof1RrUCYBRiRfaqQIa24xEzqcqZS6aUfQ4D91+fSPiYJACTP1CXv6k7mah9oMi4E9uydNQWwTlGOi3GtTt0ypZ9HpbasisHYDclv6owFwcYRCbW6/h3iaLcWWlXmSGz1V1oj8ckh1DC7TLFUpblPAuUbaAJY73UfyOjeoPyF7aQi6CWtCXbMHy7tXEDH0u0U/5JeDnQ2IAr7W67pavYmOBhfWZzAJBIb3nXx1npS7EFuxj3VktuD+hBwAnwVKRYvHSzXMt3fC6ogc4428Q+QCnS/YUtqgUgbQ0XHvlm0OFJz/nd1VO2ZDJZmTJmlxopWDnOIPyZ9FttWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXkcl6KQ2BB9hj++cLhu+Ss/g3n3onPgZ2kRzZPWJiA=;
 b=OF+0Yx0oYME/3fpu1SaXaPVjoDLkaFKvsEVxR40MjDKpCz65ztZvxVe7s0BorRL1Mxf0znpb6+JoxvB+sKuYOYx3nZq8V1nw9uQdozkT6jyWMnlSDRTiG5UA+j7Rr5L+TspMcgqaYfyWmGLhl5Viq4glXmHIkXBd7ZzveTK8L5dDxACbP9L1UWnCnwBRdVTluOu9awYoQDfGfRBqd3C7oF3pUJ0syIyjZZOu8YP5RBxnCCtc+t1d1/TpanRLbzBl+4NqwNmoaurjQIj2z10QXLo7VGIKrcDFZDx2UJLwsNy3FCgRvtHH9Q+Hbmt59hSP5Nuyf+H893jRWj701vEDEw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS4PR10MB5200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 08:22:57 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 08:22:57 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
Thread-Topic: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add
 SWU_EXTEND_SW_DESCRIPTION
Thread-Index: AQHaLC092wGU0aJu902bupmy5IjItbEU5f0A
Date: Wed, 21 Feb 2024 08:22:57 +0000
Message-ID: <217b7c161aa3a608ff107d5f2661d384722a259f.camel@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
	 <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS4PR10MB5200:EE_
x-ms-office365-filtering-correlation-id: df100b88-ffdf-47a5-ab11-08dc32b64f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NQ/MV+J4f7rcwx2dU0Ao51Io25fT5HykiDRG8va42oqv5xvpMKjfxCOQ5q0rfgwvn3E5zinnObTxo/PkiVBA7QEZujfz9iuyo330vDvZsuo5O6gNoGbZgLtsxlpoE/NmMys1sO8JSX2uKWxmBfSQcvl4KGMaii9Ni3sMfjxRpOQb/PLrC8SJcTM9ZBSTqEhGENojpIbVpe5lvsQ4be/nMe1JMIoV8S1Gba7w045mNcm9rZJpM3MtMRJiHGoHwRsr7lDYzX8HyzlyRRpJ/d+JaAyOhCq6aWpS+myZ9qhll/5X7Ca74G1WI5pnRljEpejN/XbdfpMbPyDtrA+/z/QqceJRMaGH+v03S2RzA74UIPzD4CVqfx+z7EPXgdlbaxp15DxQ8OVTDX3XhtVhRX2KnucBobtkJRjhHLlBsIqT+R1ZKc/mL3aVErF0Eppk91dllQDFNh0+LVL1zIw6gpnbArFB63tRF/exgwg7nB1cWMVs3ind0DSWtEfIqyDEjqEuef7EXkFhGQ8tG131dhCdlzpCfn7WzSQHUQrfPQo8lTRkJoKdbch5NNcb04jfbNXSbwIed7QZHwbt16baNBR/+7bRRrd/wawn15szlvplhEugpSo1jrZmD8Ap4BImimIj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RE5UMHhJakRMS253YTFUR1lXaldZMUJqcXljNkp4aGVVdTFYbndHaTVNUUtY?=
 =?utf-8?B?enczdlRJYlREeW9XelRaQkVjMHZsSDZoaWZ5Sk1yTVBLUGp5SG9HTUdPc2do?=
 =?utf-8?B?aHRVT1V3K0xIZDRsYXJTZGROSGJGb3FmdXh2SlFVY0dXS1U1ZTJYYTV3TkF5?=
 =?utf-8?B?MW1HSkJIOGsyNGpydnRHaWI4UHRJSFNiMnVFUVd2Sk1vLzdJbXZNMGJkSGNL?=
 =?utf-8?B?bjVQM1U2endhU1VNYzlDN0FqcVk3T3ZEaTQyeW5YYzFSZEx3UFpqdWxtR0pQ?=
 =?utf-8?B?T2FtQ2d5OS8rZHhmZlJTUGJHVVdsTGNMU1B1Z0pSc1Q4S3NYem1jUDdVM1dv?=
 =?utf-8?B?elMzK29FYlRsajVtcjFoSlc3TTkrNWptc1V2NkJqNUhXbEtESHdSWmt0YTZK?=
 =?utf-8?B?OS9xdFpoUThnaEhnYzZrZ1lPREhpNVBMNDg0WjBuMWNaY1lFRDNsa21SZTd3?=
 =?utf-8?B?bWxoVlgyVWZ0Y3hNMVJITkFKZmpmb2xjUXJlK3czUDR4UVY1OFBxWXFoUDhh?=
 =?utf-8?B?RkpaeldXZFA4SG9SRk9VZldFRHM0VnpUM2pYckE5NjBjZ2VoQlpNK1VrSWVY?=
 =?utf-8?B?eGxhUm84allNZlNxRExDTnJkUmpwenYyYjdYWjZSeUR4dHBudjVMQ2NnU3ZP?=
 =?utf-8?B?MzVCR2x1UlRranFOMzRXMVQ1aWs5bUJOZlhsNG54RmFZVkdJWUdUalFLSm5W?=
 =?utf-8?B?RWc5bWNNN2JnaGJaY3dZSEhwNmVZMEJnMno0MllIU1Ridk0zcUs2VFhZcjAr?=
 =?utf-8?B?SThIWTNxZGZGcGlBZVhuYitPazJ4cHlWOUQ0Z2d5M2t6S3NieCt1R2ZqdUZm?=
 =?utf-8?B?Y2JydVhIZlBISmpHd0xZdWhmQmF4V2Znc1VaWUMwOTF0cE5iSWJoMEZvd2NZ?=
 =?utf-8?B?R2hkbENLb1gwL29JdmhTamF0YVIzUkVjVWRnQnhnQVo4cnJyMVBTV2N5bVFW?=
 =?utf-8?B?QVIyWXFHNjRRVTFobWdoNHNoVnVBUEVMR014VmRSSEdXUFhnR0d6eWVvQVIz?=
 =?utf-8?B?ZUxWRzNGdnEzQVNCbnBWcWZ5QkgvbXF2cWxhMVB6aEZvSWttNlc5UktnZVZU?=
 =?utf-8?B?SlpKODREYzRLSUVGeXg0dFJxOGpndFpGT0tnVENLcU9TOXcvSkRENTYrellD?=
 =?utf-8?B?R1pLdTljTFI1NXV1L0hOSmgwMEcyeGdxcnIwOEl3Tk9zRThYdFNMbUxZb1Fs?=
 =?utf-8?B?WkxDaXVjU05CR21hMXloSTVWd0dPcUh1dnorOEZuZUxqR2U4UEd2NGwybmVj?=
 =?utf-8?B?ZjUyeGE0a3BDdG85eEhCYSt2SlNpcTVNQithUW43VFhiNjRnVGlmajFmUjda?=
 =?utf-8?B?TEl6eUN1Wmh1VlNDc1JJSTV0ajRvRC9lNW90aXRJcTlxL2U2RmJjTkt3MXZ1?=
 =?utf-8?B?VzR4VkdSUlNFU0xPdHFxZURRWlYyYjEyNDJab3dHY0RMdmwxc0JIU0k0dzAz?=
 =?utf-8?B?aTN3L2NGeVRmTXRJMlREek1SdUcyUG1DNk5qVStVSlF0Nlk1Q1hmN2NUdHdZ?=
 =?utf-8?B?dzRGaDVYeGRqbmJFVVkzUzAyb28yYVRkS2NQc1JBb3VTMy9IUkhvU3NLUFJQ?=
 =?utf-8?B?UUd2cE9XbmJ0c1IyamJuR2MzNG5vZmFSRW82YldScEViRzFyREI0NEtJdDYy?=
 =?utf-8?B?YVFZbFM4TXdGazR3cWEzR2E5OHdHTndNTjdtK3R3Z2dQUm5hUXJyaVpHTXoz?=
 =?utf-8?B?djQyNy91bkJDeEIrVWltak0vV1M4Nmx2RkJ5THdHVlVzZzQvUmxSOGtrd3ds?=
 =?utf-8?B?S1h1dE5ORW5LTlNnRzJtTG1WejREVE1kbGJ1Q2pMdFdKMXVhd1BiRXQ1UC85?=
 =?utf-8?B?TllwVzRhK0E1NnBUbElGL3h3Ykc0VVUwYzJIQkg1UzU2MWR4WUFDZkhzUWs2?=
 =?utf-8?B?MjZIK2NjRjBUWGR2QmxqUzlTaEVjSkUzTlJYMlRKN3Jza0p2aWZlakVxRjFj?=
 =?utf-8?B?WHZLdkFCWHFKSWJvUkR6MTM2SUh4Y2FTZVFTamVpMGFPRG1HZmVLYkhuQ2lv?=
 =?utf-8?B?WmkvTkdIalU1T0FRMUVXMmdKMjZzRzBQOCtacTZHQ2dCVHB4NjdIM2JpM2kx?=
 =?utf-8?B?VUpHWWRRYWZZa3hCT0daMm5wNmxpRmpoVER0Sm1oZFlidHZZVzZUSmx1OGxv?=
 =?utf-8?B?Y3EwTCtyN0lRMmFIT3V5djl4WFAyVXBzMWZ3K1cxWS9QaFp4cXF6dk11UGRv?=
 =?utf-8?B?Z1RpVXlqeWRCWnA2RXNhV2VyT2xtcnpMUy9sSmJubWFlZjBqa05MbTh5RlhB?=
 =?utf-8?Q?NZipAli4IhTSqYKzxwFfpQsbSToHmzEuleeqHr0n94=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df100b88-ffdf-47a5-ab11-08dc32b64f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:22:57.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05+g7eDRJhWpDycUJuq90mewGm0/ei40RvLYwCo00Of0gOtdPuo2sngTnya5MjOHplT7D64+nBnsoMf7Bvq+lVDCXRqY5T3Zp18nPmSCxuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5200
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA4367EF05FBA8469CE37F581D59030C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15051

T24gTW9uLCAyMDIzLTEyLTExIGF0IDEzOjE5ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhlIGVsZW1lbnRzIG9mIHRoZSBuZXcgdmFyaWFibGUgYXJlIGNhbGxlZCBhcyBm
dW5jdGlvbnMuIFRoaXMNCj4gYWxsb3dzIHRoZSB1c2VyIHRvIGV4dGVuZCB0aGUgc3ctZGVzY3Jp
cHRpb24gZmlsZSB3aXRoIG5ldyB0ZW1wbGF0ZQ0KPiB2YXJpYWJsZXMgYW5kIG5ldyBlbnRyaWVz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIHwgMTQg
KysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyBiL2NsYXNzZXMvc3d1cGRh
dGUuYmJjbGFzcw0KPiBpbmRleCAxMTdmOWZlLi4wZTk1ZTNjIDEwMDY0NA0KPiAtLS0gYS9jbGFz
c2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gKysrIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+
IEBAIC0yMiw2ICsyMiw3IEBAIFNXVV9OQU1FID89ICJjaXAgc29mdHdhcmUgdXBkYXRlIg0KPiDC
oCMgc3BhY2Ugc2VwYXJhdGVkIGxpc3Qgb2Ygc3VwcG9ydGVkIGh3LiBMZWF2ZSBlbXB0eSB0byBs
ZWF2ZSBvdXQNCj4gwqBTV1VfSFdfQ09NUEFUID89ICIiDQo+IMKgDQo+ICsNCj4gwqBTV1VfSU1B
R0VfRklMRSA/PSAiJHtERVBMT1lfRElSX0lNQUdFfS8ke0lNQUdFX0ZVTExOQU1FfS5zd3UiDQo+
IMKgU1dVX0RFU0NSSVBUSU9OX0ZJTEUgPz0gInN3LWRlc2NyaXB0aW9uIg0KPiDCoFNXVV9BRERJ
VElPTkFMX0ZJTEVTID89ICJsaW51eC5lZmkgJHtTV1VfUk9PVEZTX1BBUlRJVElPTl9OQU1FfSIN
Cj4gQEAgLTUzLDYgKzU0LDE2IEBAIElNQUdFX1RFTVBMQVRFX1ZBUlM6c3d1ID0gIiBcDQo+IMKg
YWRkdGFzayBkb190cmFuc2Zvcm1fdGVtcGxhdGUgYWZ0ZXIgZG9fZ2VuZXJhdGVfaW1hZ2VfdXVp
ZA0KPiDCoA0KPiDCoHB5dGhvbigpew0KPiArwqDCoMKgIGNtZHMgPSBkLmdldFZhcigiU1dVX0VY
VEVORF9TV19ERVNDUklQVElPTiIpDQo+ICvCoMKgwqAgaWYgY21kcyBpcyBOb25lIG9yIG5vdCBj
bWRzLnN0cmlwKCk6DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4NCj4gK8KgwqDCoCBjbWRzID0g
Y21kcy5zcGxpdCgpDQo+ICvCoMKgwqAgZm9yIGNtZCBpbiBjbWRzOg0KPiArwqDCoMKgwqDCoMKg
wqAgYmIuYnVpbGQuZXhlY19mdW5jKGNtZCwgZCkNCj4gK30NCg0KSGksDQoNCnRoaXMgZnVuY3Rp
b24gaXMgY29tcGxldGVseSBvZmYuIEFzIHRoZSBzd3VwZGF0ZS5iYmNsYXNzIGlzDQphdXRvbWF0
aWNhbGx5IGluamVjdGVkIGludG8gZWFjaCBpbWFnZSwgdGhpcyBmdW5jdGlvbiB3aWxsIHJ1biBp
biBFVkVSWQ0KaW1hZ2UgdGhhdCBpcyByZWFjaGFibGUgYXQgcGFyc2luZyB0aW1lLCBkdXJpbmcg
cGFyc2luZy4gUGxlYXNlIG1vdmUNCnRoaXMgdG8gYSB0YXNrLg0KDQpASmFuOiBUaGlzIGlzIGEg
YnVnIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQgaW4gYSBwb2ludCByZWxlYXNlLg0KDQpJbiBnZW5l
cmFsLCBpbiB0aGUgaW1hZ2UtdHlwZSBjbGFzc2VzLCBubyBhbm9ueW1vdXMgZnVuY3Rpb25zIHNo
b3VsZCBiZQ0KZXhlY3V0ZWQuDQoNCkZlbGl4DQoNCj4gKw0KPiArU1dVX0VYVEVORF9TV19ERVND
UklQVElPTiArPSAiYWRkX3N3dV9od19jb21wYXQiDQo+ICtweXRob24gYWRkX3N3dV9od19jb21w
YXQoKXsNCj4gwqDCoMKgwqAgIyBjcmVhdGUgU1dVX0hXX0NPTVBBVF9OT0RFIGJhc2VkIG9uIGxp
c3Qgb2Ygc3VwcG9ydGVkIGh3DQo+IMKgwqDCoMKgIGh3X2NvbXBhdCA9IGQuZ2V0VmFyKCdTV1Vf
SFdfQ09NUEFUJykNCj4gwqDCoMKgwqAgaWYgaHdfY29tcGF0Og0KPiBAQCAtNjEsNyArNzIsMTAg
QEAgcHl0aG9uKCl7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnaGFyZHdhcmUtY29tcGF0
aWJpbGl0eTogWyAnICsgaHdfZW50cmllcyArJyBdOycpDQo+IMKgwqDCoMKgIGVsc2U6DQo+IMKg
wqDCoMKgwqDCoMKgwqAgZC5zZXRWYXIoJ1NXVV9IV19DT01QQVRfTk9ERScsICcnKQ0KPiArfQ0K
PiDCoA0KPiArU1dVX0VYVEVORF9TV19ERVNDUklQVElPTiArPSAiYWRkX3N3dV9jb21wcmVzc2lv
biINCj4gK3B5dGhvbiBhZGRfc3d1X2NvbXByZXNzaW9uKCl7DQo+IMKgwqDCoMKgICMgY3JlYXRl
IFNXVV9DT01QUkVTU0lPTl9OT0RFIG5vZGUgaWYgY29tcHJlc3Npb24gaXMgZW5hYmxlZA0KPiDC
oMKgwqDCoCBjYWxnbyA9IGQuZ2V0VmFyKCdTV1VfQ09NUFJFU1NJT05fVFlQRScpDQo+IMKgwqDC
oMKgIGlmIGNhbGdvOg0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVy
dCBDZW50ZXINCg0KDQo=

