Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99686CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 07:42:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.124526.1781509326867819023
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 00:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=C5qo+NqZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.23, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4NaUZpZk+2PBq3PgtycvxYKq7fbtgLKsRi7IF5YUgrpzaD2A+3gYYfIFF5gw2sjyIhqIaip6xGbCtRslfe2d7pcu09INSZebWNVeIGQPKSKEYKzqM+uLCMsm2FCLSkTJ10Hv4wIfp5s2QFqeWqYvn+FT4bkOdfio6QxgQIeD+PF+Vk+KYI9VQPVVBIWCXNZZ+TWnFS4Cgw0SgMV6YsHMk/o1/ycXv7SWIZUJ85Jz8Ke3IVsjaJjx3a8n+PLHDIDR9ipa+KWv9MjocHXuKoIecxkMZHbXheFECTzWIam60o3FxO9ulfPiZGFzgUFF+jAlYjjiPlvQkAQs8Kqd73pxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31c26eznH4/j+Fnc9K469CXQF2xumTxtdsQ3zfNOUFM=;
 b=WU1lS9DS8q97n7RzZkSIX65wK0InUlYig3h6CdyXZFWX5pXmeAURRfFkrSPHwsBRhQeIUPeEwKyllxoQsafUL9TRwC3FxK6D9mqxpZOhmA+9PaqqzpmJeI5F2lFEn9vcamCnhDwaYUT5OjfLTDRHsnIibPDwf16fLwHTCt5qYF2M34jC9gI1Gy9XFaIwTWlx6xNPaMnHoDklDiNg2K13VduEOSaYSjtM4XErSP1HnvJQEDzoEZEonZpD0w2ZZpBIKxLq9MQlfRj8hYhyXPv68cAHcM/+MmGS9tQj0QlirC5gZS7Qq1K+MbwgK9skdPuLrTVMosYese42mnWf7FZOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31c26eznH4/j+Fnc9K469CXQF2xumTxtdsQ3zfNOUFM=;
 b=C5qo+NqZOsM6pBU8XLFOwmvgvzZI9Dbb9Ufpnjalx2NhHsXJvsvpQ8hongt9Qdcs4PJwPVRZExoxJt8dd0dZISWD1LbPstEi/g+RQSQ2WtJTFAa+jxTsYe6k0GTFpVQU/miHPQgx939uZz6CemKL+Vbu43nAAphZUWFs352I+Ik=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11270.jpnprd01.prod.outlook.com (2603:1096:400:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:42:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:42:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding
 attributes
Thread-Index: AQHc+Y+haEmEo1k0l02s8bsIFTTJ97Y7+31QgANEdACAAAClcA==
Date: Mon, 15 Jun 2026 07:42:00 +0000
Message-ID: 
 <TY3PR01MB1134635C825ECECE8BADF32AA86E62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
 <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
 <TY3PR01MB113463A4C767A966DE71DE7CC86192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5dd61d89-971a-4a8a-a95d-c3d9723f6566@tuxon.dev>
In-Reply-To: <5dd61d89-971a-4a8a-a95d-c3d9723f6566@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11270:EE_
x-ms-office365-filtering-correlation-id: c11ce209-a870-4ae8-fc73-08decab195cc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|5023799004|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 BLcFpoBPLyxd412Jh4YAlCAU7XsjSS7y8uDUit6cOGSAbbsKwOjr/SFoGEUikzzPV/x8NK4tp6dgHgYSUZZwUgavDF4hIqb3Eivji+qO7oW41TgE1bSPoDKWI15iLhPYUMo5lwYmWKsSL8QO7c28awkTz0UT/kR3QnlVmJoZWnh3aYUGOnjIzNY4+zKXj+tdxycfHDzYBD4X3Bw1uWxA2bbajiVWO9IsIAZU9zUJ0LHaMI1o0Q5et8VMpEX06DrPZkf3kQ5OyTSAeu37st34KzsiAYx8cGAIYioXC37iNN8JkUvJcJyqMOvn3wAIzDMuIBwU5ZOJvShgAOC9rFLNoPyAkrFfUmPKzkkcZsBBzjyU+J05sLL9o6SYy+xhyi3ZZoy0PJeXdb30mtL2FOT2H8AB+GD1otA7efwTg1R42e6SG0e3lvOsMVDIc3+tv6wKcc5rPdNc6MiRbG39lckqGTxe36I3LpjJ3noG8rI9tsJTtIOCJdH52rzV0qr6LHjAnh1WU6bl7ouPL6y+15Db6uzL9jO6HeGXs/69RsIRRz2gkqgOyqXwYBdsnCSB3Vvu6oimFmEXLBNJWpxI4mwl77oQNGc05ElJtO64HEho2fU8LVokn7d5Zu29whnhc2TOtCBF7GjJxazNkMM7IWWzxyzLirswUAVAhb3gg+YZuP3vnBfU2zh6W831gcl97pq8t8ltgGSQATvHMeAB+T3xPvfisb/VkuG028CB7wuBhRLGP6DYUSI8dXlE6jUns33p
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emc3NkhNZ29yVGk2cTY5TmF1QmlTOWhhK1hQMnRWU0hYT3U4T3RIT3VucDg2?=
 =?utf-8?B?a1ZFRVRCTk1IUnZib2I4aEIyQ1o4aXg4R0F5YzBuYXB1R2s3cnF4dVZJS05h?=
 =?utf-8?B?TForelRhczFIS2FXcTY2MnBja05kcldWeVVEc2t3cDlqRUNlR3Jjd1lxNzN2?=
 =?utf-8?B?TmJFeXlrU2dSZm56RUlJY2RFbDBwQzFLa2FrZzdTL2doRlpvUE42T0lUL2pt?=
 =?utf-8?B?Ym1uZEk2cXdBM3ZrZ0hKV2dRWWh1RkYwNmdmV1EwYUJ2SUYxVGFtMXpCMGhN?=
 =?utf-8?B?WnhsQTlCOGYrTHZRRmx0UGJ6MUxCSzFYRmp6MlVvWWIrYnlCR3JGWDJNM3Bj?=
 =?utf-8?B?dWpIWWY5QjRCSUtTdmFmRFVFYVFNRDJFMHUzV0dJNTUyNmNRSGd0TENRVE1H?=
 =?utf-8?B?UE1xVHhTZ3dFSkhzdXV0SGpiLzV6QTBxTkdWSlVZR1hnZ2t1VmZPMmhYcnlm?=
 =?utf-8?B?U0grV0tSZ3VENkI5OVZFQURYMlZ3SG5ZZUFIRzlIY3k5WEZwRWhOc20xYjRq?=
 =?utf-8?B?TlpMSFZFTjQwUEpoOElqREQvSUNQZ2NUQk1NazFsSy93NmdTSU5jZHdKUmpt?=
 =?utf-8?B?Y1RseXRJR2FwamNTaXdHdDM1d0ZIV2hPQXd0bjFSQUk5UVUyUXJ3TzhhSjU3?=
 =?utf-8?B?N2xmMTZOUnoySGF1c1FnM2p0bzJhOUpFbzd2MjBZMWdhWmQ1a250M1lMaXBX?=
 =?utf-8?B?Q1dpbnNhR3pVeTZkYnZSb3E0RWdPV2VkcHEzKzZqcnlDWWx2MDZRSS9Eb2FR?=
 =?utf-8?B?aUxJZkNFaCtyRUVXQW1VMWpKWkNENHg3Q2Z1RzNDWEdibjhpTXBZU2dxWVBH?=
 =?utf-8?B?TXd5bUs2NHJ4SkFSb051ZTRNWDR5QllBWEg2R0c0L1JGN0p5b25yWUU2L0hS?=
 =?utf-8?B?L2FKQ3hMUzFhd2hxc0lDVFVYWFdSeWR0OUFhUDlzMjYvV1lVdmF5YXdqakFO?=
 =?utf-8?B?UHR4akxEaGpkUG10bC9rRHVqL1VXa1plTk5MMk9rQVZYeVNqK1IzMXpFbURZ?=
 =?utf-8?B?a2k1dS90bXhYblNScFg1bng2Wm42L2lLOU1GOWdVbmZ1RFhlUU51L0xUUlMw?=
 =?utf-8?B?WGgrK3h3SkJQMGtwMmlWQW5talZlcUkvS2FjS3lWOU8rUVdzbWNVdjIrZDhH?=
 =?utf-8?B?NDV2bzA0cittUjZqallmSnFiZzlLWWxlaXhaWUgxb0oxVENzSXdIeU5SRDh6?=
 =?utf-8?B?NS9uN3RJUDNrc05RckRocGdmczN5QzNxUUt5cFJtRkFiUXFnQ3NGNm9YL05p?=
 =?utf-8?B?MWt3TkcybzQzcXovZDVMQm1mZkJhenl5U3Rwd1RmeFRHZkMvcmtYYnBtemtl?=
 =?utf-8?B?cmZvcVJNV2VWenJxQ3BKRGRseHFYTkF6U0lYcVRmUWhhUXdMZXFLaXk5TllJ?=
 =?utf-8?B?dGlXL2Nubkk0YlBGeDlxdW5FZDM1QyswK0NBTDFxbFUxOXBINklsSHE1SzJB?=
 =?utf-8?B?UStxWFdXYWZWbStkaDNrOFJKNDFiU0FhNGNLT0h1VVNrQy9Vd2lOZ3Z6OG5Z?=
 =?utf-8?B?b2lFVVZCcVd0R3lxVFRock9wd1IyanRSdTdkbVJsMU5qR0lVTFBmUWZWZDBZ?=
 =?utf-8?B?WjBHTnhBdVhKc1cyWmRHVVFZb3N3VFhsV29VOG1reDhkZFJqZkNvQ05Rbm4w?=
 =?utf-8?B?TlhQdVBmSWwyY0ZNR3F2NDNpOUh6c21KRGpiRVVqd1BweWpudENaSTVuNkFy?=
 =?utf-8?B?NFlROVNaVkdLV1VwWUVYNmJxemxocFVPKzNPNmZ4dWhIMW5rdThPOEJSRWNX?=
 =?utf-8?B?dzJpaUlaSWpFNVZDdTJMQVBQeDBpUWxsUnlvUjNkOGE1bmNRajBxamRCRHhI?=
 =?utf-8?B?N2RLNXdXVUM5aDBYYkI3YWk5dFBKQ1d1N1QvYU9rempqNGhpM3B2WmZSOG9l?=
 =?utf-8?B?Y0xLdWNMb083YStaWjk4WjJNN0dXL1dNTS9KK1ZsV3RxVjlXMUNHZXEvelNw?=
 =?utf-8?B?M3laaWlNNzRsdWdONnY0QUNaNFhaZ1I5aHdrQnRtS0hRaU80K1JmQ3ZkZlBt?=
 =?utf-8?B?Z2hKK01RLzNsbmVjcUNoQVhRL0xDUml1Z2ViOWNpNXd2dWRSZVVIcitPc3hW?=
 =?utf-8?B?Wm1GbzRwV0JZcXVweUw2aG93bWg0MkdmbGtjc1MyMUhBeU42R1M2NXY4WVYx?=
 =?utf-8?B?ajVPWU5GaWNEUVduMU42aml4SDlGUzg4UWM2RDdralBlSk5HZzFpMTAxeWpS?=
 =?utf-8?B?YnB1UmRUSUw0ZVZJL0g5NmtwRXg2UTV6ejdpRURWUjlOMUdQVDdXQmJ6a1JE?=
 =?utf-8?B?YVNpZ2MrZVRFT1lrbFd5eUhsYVgzZDFBbnlRR3JMZVA4cW9ia3pnU0I1RHV2?=
 =?utf-8?B?YXRpeTFTK1Y5OXFxUTZxRXB1Ty9IeVQ1M09HeEcvcGdibzQwOWh4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11ce209-a870-4ae8-fc73-08decab195cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 07:42:00.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoIeDfRLqd+lVfSRp3RT4JYne8V+njbrnMbq1wNNE1wHAJAqhU9cE7UhO0WqWaLzSkRWWMu42qqWpXMmsL20VbimEurWD6bijpvBC9jdNYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11270
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jun 2026 07:42:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23136

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAxNSBKdW5lIDIw
MjYgMDg6MzUNCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggNi4xLnktY2lwIDIxLzIx
XSB1c2I6IHJlbmVzYXM6IFN1cHByZXNzIGJpbmRpbmcgYXR0cmlidXRlcw0KPiANCj4gSGksIEJp
anUsDQo+IA0KPiBPbiA2LzEzLzI2IDA4OjU0LCBCaWp1IERhcyB3cm90ZToNCj4gPg0KPiA+IEhp
IENsYXVkaXUsDQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+DQo+ID4+IE9uIEJlaGFsZiBPZiBjbGF1ZGl1IGJlem5lYSB2aWEgbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+ID4+IFNlbnQ6IDExIEp1bmUgMjAyNiAxMTo0Ng0KPiA+PiBUbzog
bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYTsgcGF2ZWxAbmFibGFkZXYuY29tDQo+
ID4+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+PiBTdWJqZWN0OiBbY2lw
LWRldl0gW1BBVENIIDYuMS55LWNpcCAyMS8yMV0gdXNiOiByZW5lc2FzOiBTdXBwcmVzcw0KPiA+
PiBiaW5kaW5nIGF0dHJpYnV0ZXMNCj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBJbiB2Ni4xIENJUCB0
aGUgZHJpdmVycyB0aGF0IGFyZSBpbnZvbHZlZCBmb3IgdGhlIFVTQiB0byB3b3JrIG9uIHRoZQ0K
PiA+PiBSZW5lc2FzIFJaL0cyTCBiYXNlZCBkZXZpY2VzIGFyZSB0aGUgZm9sbG93aW5nOg0KPiA+
PiAtIHJ6ZzJsX3VzYnBoeV9jdHJsDQo+ID4+IC0gcGh5X3JjYXJfZ2VuM191c2IyDQo+ID4+IC0g
b2NoaSwgZWNoaSwgcmVuZXNhc191c2Jocw0KPiA+Pg0KPiA+PiBUaGUgZHJpdmVycyB0cmVlIGlz
IGFzIGZvbGxvd3M6DQo+ID4+DQo+ID4+ICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPj4gICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPiA+PiAgICAgICAgIFwgLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+ID4+ICAgICAgICAgIGAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4gcnpnMmxfdXNi
cGh5X2N0cmwgPC0tPiBwaHlfcmNhcl9nZW4zX3VzYjIgPC0tKy0tPiBvaGNpIDwtLS0tLS0tLS0t
LS0rDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
LS0+IGVoY2kgPC0tLS0tLS0tLS0tLSsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICstLT4gcmVuZXNhc191c2Jocw0KPiA+PiA8LS0rDQo+ID4+DQo+
ID4+IFdoZXJlOg0KPiA+PiAtIHJ6ZzJsX3VzYnBoeV9jdHJsIHByb3ZpZGVzIHJlc2V0IHNpZ25h
bHMgdG8gcGh5X3JjYXJfZ2VuM191c2IyIGFuZA0KPiA+PiAgICBPSENJLCBFSENJLCByZW5lc2Fz
X3VzYmhzIGRyaXZlcnMNCj4gPj4gLSBwaHlfcmNhcl9nZW4zX3VzYjNfdXNiMiByZXF1ZXN0IHJl
c2V0IHNpZ25hbHMgZnJvbSByemcybF91c2JwaHlfY3RybA0KPiA+PiAgICBhbmQgcHJvdmlkZXMg
UEhZcyB0byBPSENJLCBFSENJLCByZW5lc2FzX3VzYmhzDQo+ID4+IC0gT0hDSSwgRUhDSSwgcmVu
ZXNhc191c2JocyBkcml2ZXJzIGdldHMgcmVzZXRzIGZyb20gcnpnMmxfdXNicGh5X2N0cmwNCj4g
Pj4gICAgZHJpdmVyIGFuZCBQSFlzIGZyb20gcGh5X3JjYXJfZ2VuM191c2IyDQo+ID4+DQo+ID4+
IEluIHRoZSBjdXJyZW50IHY2LjEgQ0lQIHRyZWUsIHVuYmluZGluZyBhbnkgb2YgdGhlIHByb3Zp
ZGVycyBpbiB0aGUNCj4gPj4gbWVudGlvbmVkIGRpYWdyYW0gZG9lcyBub3QgZm9yY2UgdGhlIHVu
YmluZGluZyBvZiB0aGUgY29uc3VtZXJzLg0KPiANCj4gVGhpcyBpcyB0aGUgcHJvYmxlbSB0aGF0
IGxlYWRzIHRvIGZhaWx1cmVzIChpdCBpcyBub3QgYWJvdXQgdGhlIGhhcm1sZXNzIHN0YWNrIHRy
YWNlcyBmaXhlZCBieSB5b3VyDQo+IHBhdGNoKS4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY29u
c3VtZXIgZHJpdmVycyBlbmRzIHVwIHVzaW5nIHJlZmVyZW5jZXMgdG8gdGhlIHByb3ZpZGVyIGRy
aXZlcnMgdGhhdA0KPiB3ZXJlIHVuYm91bmQuIFRoZSB1bmJpbmQgb2YgYSBwcm92aWRlciBkcml2
ZXIgZG9uJ3QgbGVhZCB0byB0aGUgdW5iaW5kIG9mIHRoZSBjb25zdW1lciBkcml2ZXIuDQo+IA0K
PiA+IEluIHRoZXNlIHNjZW5hcmlvcywgdGhlIGNvbnN1bWVycyByZW1haW4gd2l0aCBzdGFsZSBy
ZXNvdXJjZXMuDQo+ID4+IFN1YnNlcXVlbnQgb3BlcmF0aW9ucyB0aGF0IHJlcXVpcmUgcmVzb3Vy
Y2VzIGZyb20gdGhlIHByb3ZpZGVycyB3aWxsDQo+ID4+IGZhaWwsIGVpdGhlciBzaWxlbnRseSBv
ciBsb3VkbHkgKGNyYXNoZXMpLiBSZWJpbmRpbmcgdGhlIHByZXZpb3VzbHkgdW5ib3VuZCBwcm92
aWRlciBkb2VzIG5vdCByZXNvbHZlDQo+IHRoZSBpc3N1ZSBlaXRoZXIuDQo+ID4NCj4gPiBOb3Qg
c3VyZSwgaGF2ZSB5b3UgdHJpZWQgd2l0aCB0aGlzIHBhdGNoWzFdPw0KPiANCj4gVGhlIHByb2Js
ZW0gYWRkcmVzc2VkIGJ5IHRoaXMgcGF0Y2ggaXMgbm90IHNpbXBseSB0aGUgaGFybWxlc3MgV0FS
Tl9PTigpIHN0YWNrIHRyYWNlIGRpc3BsYXllZCBkdWUgdG8gdGhlDQo+IHJlZ3VsYXRvciBidXQg
cmF0aGVyIGNyYXNoZXMgd2hpY2ggbGVhZHMgdG8gc3lzdGVtIGJlaW5nIHVuYXZhaWxhYmxlLiBU
aGlzIGlzIGJlY2F1c2Ugc29tZSBkcml2ZXJzIGFyZQ0KPiBzdGlsbCB1c2luZyByZWZlcmVuY2Vz
IChlLmcuDQo+IFBIWSBoYW5kbGVzKSB0byB0aGUgZHJpdmVycyB0aGF0IHdlcmUgcHJldmlvdXNs
eSB1bmJvdW5kL2JvdW5kLg0KDQpPbiBtYWlubGluZSwgSSBjYW4gYmluZC91bmJpbmQgcmVzZXQs
IHJlZ3VsYXRvciwgUEhZIGFuZCBob3N0IGNvbnRyb2xsZXINCldpdGhvdXQgYW55IGlzc3Vlcy4g
Q3VycmVudGx5IHRoaXMgcGF0Y2ggcmVzdHJpY3QgdGhlc2UgZHJpdmVycyB0byByZXNldA0KdXNp
bmcgYmluZC91bmJpbmQgdG8gcmVzZXQgdGhlc2UgZGV2aWNlcy4gTWF5YmUgaXNzdWUgaXMgc3Bl
Y2lmaWMgdG8NCjYuMSBhbmQgNS4xMCBrZXJuZWwgdGhlbiBhcyBJIGRvIG5vdCBzZWUgdGhpcyBw
YXRjaCBpbiA2LjEyLg0KDQo+IA0KPiA+DQo+ID4gT24gbWFpbmxpbmUgd2hpbGUgYWRkaW5nIFJa
L0czTCBVU0IyLjAgaG9zdCBzdXBwb3J0LCBJIHVzZWQgdG8gZ2V0DQo+ID4gV0FSTl9PTiBmb3Ig
cmVndWxhdG9yIGVuYWJsZSBjb3VudCBkdXJpbmcgUEhZIHVuYmluZC9iaW5kIGFuZCBpcyBmaXhl
ZA0KPiA+IGJ5WzFdDQo+IA0KPiBJcyBub3QgYWJvdXQgdGhlIGhhcm1sZXNzIFdBUk5fT04oKSBi
dXQgZmFpbHVyZXMgdGhhdCBsZWFkIHRvIHN5c3RlbSBjcmFzaGVzLg0KDQpMb29rcyBpdCBpcyA2
LjEgYW5kIDUuMTAgcmVsYXRlZCBhcyBJIGRvIG5vdCBzZWUgYSBwYXRjaCByZWxhdGVkIHRvIHRo
aXMgaW4gNi4xMg0KDQpDaGVlcnMsDQpCaWp1DQo=

