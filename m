Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDBC5478C
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 13:39:29 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web11.98401.1709559418699019231
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 05:36:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VGzBz6ep;
 spf=pass (domain: siemens.com, ip: 40.107.20.57, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz7EI1Ja1CVs2EQC+YKTjrkx38OkAr03gR2TN/fhMwQwRRcZWrdPI9PMejRSKM2eIMLuM+mBHYjECRnlq2pezIykq4vTIqqO4Tl3VzkZUgSnrLo5+6lOfkquerpc83Hqy41kzmaOb3YXEVWSTgCcuxLZuxhe4gxGVTM1cJ49tP69z3QRjziFGkBfPs6FTbCC4JNzxvkjSDv2OI0+k4506LRdl6lwqbfy0VmqlPQbPfYN39iZgLAUJbIIHZO/rMMR/Ax4BdrgSedjj17q9sL7kMjt5Q7bNCUVnIWkHzrHoy2DbDc1TNCcDUQScZydNzh6UJokkjuqhMQvzcmJX+8JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFpZKI2W855loqyDl/OMr5IxSyFPf/PgW5B9mc3AjTY=;
 b=nLseBh/wTjvjFKOm8nUVkHid+TDiKReDYocLX28NSfuNHYAb+BEfvxxowT7dTu/LRT7NmO5WBt/IOSt0HdxzlFicO2BbDd+6fOn4is+/2s0eBWvqh1F/LaWIb6o7iLKxzfIjqUKuzMn2jI0uwe7vWhKkO2Fi95sByVxL/mrshnKPRuHdnVS8sH2u2JJnMk3no4oVUdk3DF9XXAIIvVjJPb+hlDZZUqAkvk5jb36At/tNVfrkD090b0zFlZx+uRGWNnczZZvQYEGPzjAOpP5JjtmYwqeLA2EEfjkFGKF9XwP4uCnWMhtCDu2aorI2IL12e4dOOLU0oQGZtN9THZw9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFpZKI2W855loqyDl/OMr5IxSyFPf/PgW5B9mc3AjTY=;
 b=VGzBz6epRaxoOvRxXQj8pazqqtmPIIIBDSeESvxzZMNBAT3Jv7yhIERY76Q5ejbaENmF1ygODHfHsPKK+BBZYxaz4Jbru1tlGp+wkOkShgk+TrvaSu9Rp4RmHD88mjQsnM2HHFUYahSQFMJzFveyz1gQ3lZtsYptWU1kUch+M/+uYCMEP4qADiS3GGK6SC1g1/t66uXzdLlPwHKVlBTiOSakE8TXIeqb+uRcpk4BjmxAUSqu6rx4K8hqfOLtKYLaS523nyTgJ7xXp6e47l3DTqu6Iqre6rAJyIbaIXbyUegOQl6377ubXCXxU+rMesJYOtz7A/XyczTk4cBQuWa4ng==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB7981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:36:55 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%4]) with mapi id 15.20.7316.039; Mon, 4 Mar 2024
 13:36:55 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Make swupdate signing more
Thread-Topic: [cip-dev][isar-cip-core][PATCH 0/4] Make swupdate signing more
Thread-Index: AQHabhw/mOQL1x9O7kKunfvOpK0xZbEnldCA
Date: Mon, 4 Mar 2024 13:36:55 +0000
Message-ID: <73e61f626f9f5530afcefb93af6d626f7f6087af.camel@siemens.com>
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB7981:EE_
x-ms-office365-filtering-correlation-id: deb11f59-a030-450d-9af1-08dc3c5028a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nBCGOPS5HwGpu8frFP3FDokJbUG6cHY5uPzN7UM9lRd3LySelUciN9BbYFCe2aN58uW5nzWlmkcrUjMKoAzDAdMBkfc1WbqhaZLd5ZSMp8WprlU+z6c+QB4Esm9lOLbgJCgskx6xRD9etcnaoSphRVBxxQdlWCkhYa2a4WxAS5pgnKYtZ/4QwHuBJzbbHvEdZgA2G6MHCNVaW6aww8bWmv+T3jAArxsUvwBWEO02lmRq9KvewiqtddLE0+g6/0XtdcM0b2E8f5dHXckhIgy4ad+33NozscaHZOb4WG4HnsUYQZbNXVjYWER7jEaWYMRcDmsxaRmhKfyYxoi2vdoyhKMp3aIOq/exGcuo/Bk6Pnr3tSiLJh3yd6Pg7zyV2U+wlQq9XZx+reDNmMd5TKyNtQBp1OG4BP6rFC8UmTKae35a7wUvzAqKYdaIkLt4em6GF0gPP7RK8bfODvlepz3oKB7kzaxNf0f0PKNa8dRu5+CIddQzxkSQOdpc/kHZZibV27FTJTi+0I0TMRYjnK6NyJntm2H+E0nDLt6o2zArhVspiYz2QlrFaEizK9dUTukcnluvPNLyiHZdN9HOAup9iJ0yJMiTViQSJGSuJg5PNLdYmcnKgx+ld4C+gFxWNIO4D/Ve9+32Q+zsS99IX+N/RbnYqjWKJh126PDSj7yVke3en+5Hj/5POpeLV8kuJTlgr9+NZWlzYCFP1e5wXTitXd0qnQNoIYx/3VlZCfXctu0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OUNzMHRXNWdJWEJxUEVBRXdYMjNZUUgwcWF0RTFLMDJ3RWViS1pFbk8wM3lX?=
 =?utf-8?B?T092TnhWRSswQ2NvNkg2NVVRTGZ0MG9oRmxibXZqZjAyaWxwQW0wV0Ivc1FS?=
 =?utf-8?B?dHl5UUlwSXZTUWszbGhlSU91NXIzTlRDcUJtRXFXTE50U0FWcDc1dEg3eGhL?=
 =?utf-8?B?cG1qYWxyc0NMZUtYVWJwL3RHcVN6NC9HbHNtSkJZTHRVMzhUamt0Z1h2Z0RS?=
 =?utf-8?B?K2Q1TFhZMGhodityR2tKOXYwcUMvRnBlN2I0UHgrUDZOSnNUU08vNjI1cEJS?=
 =?utf-8?B?b3J3WU9wU2lLamhDSEpjS2kyd0FGa1NaeU1Na2lTR1Fxby9RdnB0TUpNMmNO?=
 =?utf-8?B?bmpLWnJlMXZpd1JNemRIcTVPWFd0RUl3QUtUeUo4TzRlMEljNDdPNjNNb2Yv?=
 =?utf-8?B?VHV1Qk5WR3FrM1VuUm5wZlRZbWhqb292ZTkvNitEQnpKdFV6WXRqRlplaHpK?=
 =?utf-8?B?U094d09wSmMvVm5RYjI0Q2NsU2ZadS8ya3F5ZXozWjdnZjROMTZ2U0NCTXRz?=
 =?utf-8?B?M1VSNFcvVDF5ZDliNlF6eEdvUUx3RlY4ckwxMzRLcEMyTlBjSytRUHhLbVVK?=
 =?utf-8?B?a2lGcUs4a3FGWVBxNjVhOTNPU2t2a2Q1STAxbEhpZVB2b2lCMDRqOFVEbDhx?=
 =?utf-8?B?QzdkZHZ5M0JLYjNubWhzOTBWdkhGalNvQi82VWo0NkVQUE96aG9FZ0hQS2Rn?=
 =?utf-8?B?Q3ZnWHIzWXVzQzViZGs4TVNBVWNuV0Z2NmltMnlWOHFUYVRGL0hlenZBMDZL?=
 =?utf-8?B?a2U0SkRRR1hycmVjaWJHTGVlRCs0L2RTOVo3bjYzYjhzaHNTQnlMeDgxY2ZW?=
 =?utf-8?B?Znc0bmFmV2ZMZTVhbG4rQ29aWnVCUlZ0dGZDVmRSNU9BZlZWek1YTFc1Q1l6?=
 =?utf-8?B?VHVhd0M1VUFwU2tPSDVDdlRnVVJjeWRTRFErSzBZWHV1aDM0NG5tZTJzVUVm?=
 =?utf-8?B?MEJ6QUNJZWF1NDlLTVdOOXZ2alRQWHA4eXZwRUlXaS9qZ3MxcU9WWGhHb0kw?=
 =?utf-8?B?RXF4Rk5SVkduN05YMVgxVUp1TGtudW40VWxOVVRwOVcwRFppWEx5UWQ5ZFU3?=
 =?utf-8?B?Z0hKL25Pb1RpdDhsL3ZoeEFVTmlqbkxYRWZqeC9MMEg4aFlhSDZmYzNSRVJr?=
 =?utf-8?B?MURjNFFCbytrSDl2SURxWGdlYWZ2aWJuRHA4VFlNYXNwY2E0eGpyTzNBR1k4?=
 =?utf-8?B?WjJIR1ZFd28zVmFBTU8yZ29jNXJUL01xUExSNWM1WHhNaXcrbmEyZEI4eVd1?=
 =?utf-8?B?WWNkVXRPWXU4TXoxU1JaOWVFcklnZkttYkhoZFJkMkJlanZybDNucC9pTGhI?=
 =?utf-8?B?eXJtblJ6TWQzaUYrdm9FUEl0aDlRbEhLUG1abGxFK1JFTFg2TURhTUNGa1Ru?=
 =?utf-8?B?TlYvVHZ0ejFnMTFySS93S2xwczVxUEJzYjRPWHMzQlBWZUdWZzlmU201STh2?=
 =?utf-8?B?bVNsMC9hUVl3Rm1JemNLcGRLSVlBZG9NN2srdjh4Q1ZoRmFaQ1lDakN1eUk2?=
 =?utf-8?B?ckxOZGQrR1kzYmtBY0lWRU94ekR0c2FsclRBR3QxSzU1WG45djI2T1VTNCty?=
 =?utf-8?B?bFBiSGZka3VyT3JBZ0xzaTEzV080bFZDdkFROUtMRlFBejFsMmkzOXFOMjVq?=
 =?utf-8?B?cURac041MDJkSUhlaEFaaU40MWw5b0V3WlFqZEhFRnl6Z3dpMkU5QmQvN0ZV?=
 =?utf-8?B?U0ZZdUwrWFFCejMybm1nUE9RQnhGL1ZOUlBrS0x2b0d6VFFtQXE5NktzZy9p?=
 =?utf-8?B?VmRwNzBEZWIvYW5JVXFSYmpxM1JyVVQxaHdzblRVd2g4Wk5RWTBZdGFUaVpV?=
 =?utf-8?B?RWR1MGg3bVpFd2lpQ0ZJRHZsZFA1Nzcrc0N3Q3BxWkM1ZUJHSFhiTWdML28z?=
 =?utf-8?B?bHdKbjVtZE5CdjhhUUpDS1FkamNtNXU0dzluUlhSRVlKaGdMbEd3YklxSEVJ?=
 =?utf-8?B?NGhTSlNKcW83enM5KysxaHY2TDNQdVE2amxOV08veWM0NGVwQ3J4bjlEZTFR?=
 =?utf-8?B?Slg1Y3VqSTJhekJlcCs0K3FGMnhoRGdFaURwUEZtMlJpL2FBSStweVE0a2NH?=
 =?utf-8?B?NVgraldsbXlabW9VN3Fwa2p3K1V6UHV3MEExa0JQeUp0NHk1cjVVaXZBUXcx?=
 =?utf-8?B?Y1ZLMzdRM0ViZmM2enZTSnRJTXhYTkNlY0JaOHJ2VEE5NVNSemxraEJIZXV3?=
 =?utf-8?B?MzN5UjdKZk16VmJKTkVPZXV3SWY4WHI3YVN0VGFDZHBVdkIxVkhlZllKQVJN?=
 =?utf-8?B?eHYwZGpYYm5iSTdKOUJCZVRKc2l3PT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: deb11f59-a030-450d-9af1-08dc3c5028a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 13:36:55.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2t6Q6aVcFsADCsQUaXBn4s566gH/3sx+vO5qYtMuFK80furIZDkBx09H51tEPiAPRJYCJjtY9b6OGwg41sIGUbiL3JPs53DxEp9WS2BrT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7981
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <23FD8729F35CFF409224DC6E9C71401A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 13:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15196

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDExOjA4ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBwYXRjaHNldCBhZGRzIGNoZWNrcyB0byB2YWxpZGF0ZSB0aGUgY2VydGlm
aWNhdGUgYW5kIGtleSBiZWZvcmUNCj4gdXNlZCBpbiB0aGUgc2lnbmluZyBwcm9jZXNzLg0KPiAN
Cj4gQWRkIGFsc28gYWRkcyB0aGUgbWlzc2luZyBEb2N1bWVudGF0aW9uIGFib3V0IHN3dSBzaWdu
aW5nIGluIGNpcC1jb3JlDQo+IGFuZCBmaXhlcyB0d28gaXNzdWVzOg0KPiDCoC0gYW4gZXJyb3Ig
aW4gdGhlIGJ1aWxkIGxvZ3Mgb2YgZG9faW1hZ2Vfc3d1DQo+IMKgLSBDcmVhdGluZyBhbGwgZXhp
c3RpbmcgaW1hZ2UgcmVjaXBlcyBieSB0b3VjaGluZyBTUkNfVVJJIGluIGENCj4gYW5vbnltDQo+
IMKgwqAgcHl0aG9uIGZ1bmN0aW9uLg0KPiANCj4gUXVpcmluIEd5bHN0b3JmZiAoNCk6DQo+IMKg
IHN3dXBkYXRlOiBjaGVjayBvdXRwdXQgb2Ygc2lnbi1zd3UNCj4gwqAgc2lnbi1zd3UtY21zOiBj
aGVjayBpZiBrZXkgYW5kIGNlcnQgYXJlIHZhbGlkDQo+IMKgIGRvYzogQWRkIHNlY3Rpb24gYWJv
dXQgU1dVcGRhdGUgc2lnbmluZyB0byBSRUFETUUuc3d1cGRhdGUubWQNCj4gwqAgZml4IGRvIG5v
dCBhZGQgZmlsZXMgdG8gZWFjaCBpbWFnZSByZWNpcGUNCg0KV2hlcmUgaXMgdGhpcyBwYXRjaD8g
TG9va3MgbGlrZSBpdCBkaWQgbm90IG1ha2UgaXQgb250byB0aGUgbGlzdC4NCg0KRmVsaXgNCg0K
PiANCj4gwqBjbGFzc2VzL2VmaWJvb3RndWFyZC5iYmNsYXNzwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMSAtDQo+IMKgY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgODMgKysrKysrKysrKysrKy0t
LS0NCj4gLS0NCj4gwqBkb2MvUkVBRE1FLnN3dXBkYXRlLm1kwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxICsrKysrDQo+IMKgLi4uL3N3dXBkYXRlLWNl
cnRpZmljYXRlcy9maWxlcy9zaWduLXN3dS1jbXPCoCB8IDI5ICsrKysrKy0NCj4gwqA0IGZpbGVz
IGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gDQoNCi0tIA0K
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

