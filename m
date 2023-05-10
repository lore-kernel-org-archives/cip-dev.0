Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEAC77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 07:07:07 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web11.10530.1683702420433211225
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 00:07:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=i2JPPMRP;
 spf=pass (domain: renesas.com, ip: 40.107.114.100, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU4WohnAAiu/hRT9tY6HbXOrsgtKI2Zfvn6W/tEGAYa0eqhULeNHEUunsBN0mf+ci0geYb9IzD8yDMsnibOJHEACs7kMPDvJY6NoXkA2d/oWdfC2SuRyjXwzDMppJ/MrYNiW85wcpvcGRjoQC1gpXA1tMg1mL/m6FjflBGrBVv3BebcV5MMTrBXuVXlQyU1wq0DY/+3coUBbd4h3PNDHeEUH5A6hyz7wh4mpc5oVkvEeNg7vsjavsAYiTOvU18VjLPFFO3zKk52KHmgYO4yeVubqnEexaUPicpfFD7VeQ6uziNcNmwQSv+K9K0/eCZ5lFmzgGZFPZkPENLgF8zFNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fep1haDYsP7HP4AR8o9MK6OrpKeSgZvg1k45GsNuow4=;
 b=UyDxuF79W4qHUy3sChHvblHldUQ1SYy9UwJR/Qyv7El0pVI2k2dYyfmrex2RQSmN7SVcN0UPhY1a/2+VTsLUdCW63YZTrEsS6vf+q3FuI2mT4fj4TjfWFxtpqh+zOQy0dE62+vgXpEio8LilxvrCPeNvlsGfTjRYv6ALBI/UBUkLCIVQZ+kIdlfguMCavkN8JAVfTuma9Wz5J2d36HqN8xtpyOji3Vtmjbn/PlxOZNUpxZcIOtuTSeaZw/hqH1LBoKdsb8KPL4AcrJGAmx4EBgGACmTx/mvZM7lnssFsepE5VbXRXYBEpAq7I3je77i49KKTEhljKCovGTLQ/ragrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fep1haDYsP7HP4AR8o9MK6OrpKeSgZvg1k45GsNuow4=;
 b=i2JPPMRPYa5RgB9h++Cen7qKplyVWRd6XkW4kC/osH0ix6fBAmIa4dfIoNBd9hIV9fpq3dXOS3SWmT/WITo3yi7r3S1u0rx2ijtD0X7h3QSFAg5AVoatiSy3fDZdVeFzRIgKTy0niyzDx1yg6y/Ozju1bxFyFjEgQGKV5+NtSfo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TY1PR01MB10786.jpnprd01.prod.outlook.com (2603:1096:400:327::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 07:06:56 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 07:06:56 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Masami Ichikawa
	<masami.ichikawa@miraclelinux.com>
CC: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht
	<uli@fpond.eu>
Subject: RE: Size limit in the cip-kernel-sec repository?
Thread-Topic: Size limit in the cip-kernel-sec repository?
Thread-Index: AQHZgkEC40jacwRpqkqontinFPUAda9RvUfQgADVkwCAAIFyAIAAAbOAgAABYvA=
Date: Wed, 10 May 2023 07:06:56 +0000
Message-ID: 
 <TY2PR01MB37885CE682D5F8251B1AC972B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9oaJ73uvgppYvcOBbM2xLNB1LQW34TZbjA3gd+bkAKaVg@mail.gmail.com>
 <63fb0d57-3550-1188-8243-7ea8c8b5ab5b@siemens.com>
 <TY2PR01MB37880583E930BBEC98A5803EB7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <CAODzB9rdcjQKhj9a0a6igrjHCbMwo0Qy=xenxmTXFryMkOhVUw@mail.gmail.com>
 <TY2PR01MB3788F4587077708C078522C1B7779@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <a7f4a174-6a3e-1cfe-2c7d-895ad11338b4@siemens.com>
In-Reply-To: <a7f4a174-6a3e-1cfe-2c7d-895ad11338b4@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TY1PR01MB10786:EE_
x-ms-office365-filtering-correlation-id: b86d4c87-161c-4ca4-8c61-08db5125243b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4AjZahbcJI3H+oCKmqbdMg6L8ccCwuzrPeOn88CWsV/A6BYUCz/eDJrotQKOdrL1erFymczEdW8cfs3mIpqiO/lRArzbCUYDONRPwA6901/Yu0pbRSSBA00UZoaoMEmLmA/M7IMYUJlXoOQFIZxoDdzZVTAQ8dyVZM3Uspot1n5JtC686XQ+o3+p1UiuSmC/VvAA18qicFgcKOnBlTfkoWaFo4DS3Mnn91hV1DAyLR7zW3s8D/ow70xJbEjyxUNSj2fQEkZ6GnSdwMgLSS9zelaXwmsf/Nb4digeNlRwZmlN+hfR43GXNJJ8e/CJ/LjvvQv5Sa5AfiKWBYBMvB9hJHFW/h7l23baPsDjgrUj58T8W5DLZEnMgmMP1iiqjnKCxuE1EsKbKYs0ozxtvkCuwRnXgPslPp0OGSKtwMPbvsHtV85McvBItlD6pUXyUYDwv1oRgd6c/52a7L+y3B3MnBruNmAjH6fFRwuXnDEa47WCQKcD7jRPoym8KcfUd5jPRapcftTmk11wCFUWFqGzDdpVieoRfqsIWXp9nC5kQ9maY5boT8+yYCa2ENURTuUqADgpnFSz5/yn8x9h1BFEN+UoD27xRZFjmP2o/hK3u4oorQwVjkaF4/5z71g25qN1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(7696005)(83380400001)(122000001)(52536014)(5660300002)(41300700001)(2906002)(38100700002)(8676002)(8936002)(86362001)(64756008)(53546011)(26005)(55016003)(316002)(9686003)(6506007)(38070700005)(4326008)(71200400001)(186003)(478600001)(33656002)(110136005)(76116006)(66556008)(66446008)(66476007)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUZhT2F3YVhpZkdLSFdab0tZR2Exdmx2QnlTU3ZXUEN0K3RIZ2RUQ2VxamdL?=
 =?utf-8?B?cEhNeWRCa0drTFJnT1N4aXYrYUhNMm1JbG5jV3RVOFVKQjdrUWpjWEtZZWhS?=
 =?utf-8?B?UmZpWVVpNjg5SGdKOEdPL1pyVzRPVGVaYzlCRjdJcjN1S0JZUHpzL2x1YVJ5?=
 =?utf-8?B?Q053YmM0b29LRG52RFB1ZFZrcUEzb0hyNnZodHNvdXV6ZTJPNzQzcDNQa0pr?=
 =?utf-8?B?VTkxa0I3ZTIyYjArZXRSUHVRVlk5YmZSSk1OZ2thYnd5RTdDRStXMzRQZHdp?=
 =?utf-8?B?UU9IMXp5WE1SeHh2bWdPWGs4QWhEMmRIYU1YOGVkZXMyeXhxMHcxWm5JaHY2?=
 =?utf-8?B?RGN5TDhaNnpEeGg2SzI2VTQrSitpUjVIY0E5K0JFMk52RndVSEQ5d2NQYnRL?=
 =?utf-8?B?OHVXaDZGNnVvR1NKVmVhZGZxSkZIbUtrWG1FV1AvYXFwU2txdHZFWGFRODQy?=
 =?utf-8?B?MzMxMVk3aXlRWGIzZlN3cnpmUXdMVHhWWHVuSUhSL05EQTkrTm9vVXVwcDBM?=
 =?utf-8?B?bzVPK3hLRkZUUE1aR0hhOTRjdG1rcWR2bzJYbWFINnloQWR2cC85TXJKbWhz?=
 =?utf-8?B?aHJvRUtieURnSTFaUUExSnppWTd4RWo4cVBmNURKQzh3djU2RE9rcnlURmps?=
 =?utf-8?B?Z21PWVMwWjYvbU9uOG9rRFZiZXd3Zi9jSTljSlFUOWdaRkZqTWg1RTVrVkp6?=
 =?utf-8?B?b0pEa3FpYlpnWnc4YWJvUElFbkJBZHBCd1I1RlEzbktlSDFQbnh3Y2thMlZq?=
 =?utf-8?B?YkNlZE1mZERPdXlVT3RLTjllN0srWkJHMkF2ZjZDQTdzUVhjM09PT1JseE8v?=
 =?utf-8?B?UEhTTHAwVGFqNFlDWjlxYnE4UGZKUlNCQ2pPRVowQWhPdGUzOTc2VzRPM291?=
 =?utf-8?B?ZVp2RVFmalc0SGdCQ2JUd2pScmZWaG1jVkRDVkE5bkdaNkpqMzJYQ21Gb28v?=
 =?utf-8?B?SG1lSGg0bEswTUJJUk1IcmZEczRYdE0yVVp1eGZMT2lWK1RKOFBLOXpwNDU0?=
 =?utf-8?B?ZXRpTEFlanEyQXk2SW83MjB6a1JDcm5SbHN2V1JvbjhZLzg5cURvNzA3WGlN?=
 =?utf-8?B?OGl5NGVRS3lMWkdCQkw5RFdJVC9tYVRBZ3NDVmYyeXVxOEJHZkdxRGYyakpD?=
 =?utf-8?B?RzR0Y1JKUXB4WExPS1RwWWpCYzFENmhNektrbUtBRUw2Uzh4TEQxaWFzV2U0?=
 =?utf-8?B?VlBqUjQySG9DRDRzYXlyV1dCam83TjlmSnVsWHNMZ3EzUHJpaDdRVlEwVnp2?=
 =?utf-8?B?MGNZYnBXTmQ2amsza2tnT0VmZTZ3dVJ0cGp5LzREMjJvdHAzdFZXaTRzS2Vn?=
 =?utf-8?B?ZTNCcUhYeDN5WGl4dGVobHJicXh1TDVnbUkvNTZjdEJOK3NEQmxVUDRsYk9S?=
 =?utf-8?B?UEFBTkFwajlJMS9xejVMaEUrUDc1bzhPVjJBeUczRGpEQkxlVk5kUGI3Zmts?=
 =?utf-8?B?aWZXNml0ZWxYSE45YUkwTkhobUtTY3ZhYUdLeXVXUmFPcUl3WGlVMHZSN3Rs?=
 =?utf-8?B?dmVwRnBjdVh1S1VKdWQ3eFVZRUlZb29Oc3lSa2MzTmJ5UE1pbjhNbnBacm1N?=
 =?utf-8?B?enFTOG1Bc3V2QUdjbXljNk1wNVFnTVNUcUZrb1RvTVNodU50dWtwWWFxNHFZ?=
 =?utf-8?B?SERDcXRWWFNsdm5KWWxNWWNHcDFmdjdjM1JyNnlZWVhxMnNORU5lcmUzVFBD?=
 =?utf-8?B?RUc0MlJCTGVxdlhrQkM0emJLaWt4bnJNWlgybUJ0bzhSSVZOSUJ6eDFmOG4y?=
 =?utf-8?B?d2huZ1FHekFjdmhDcnZqVllHelZuVlc3ais2RkdPRnRqMTFSbktaeFZHd3pG?=
 =?utf-8?B?Um9LQTIrcW9CaFVnVEZQRGJYSDBDUXl1Q2U4ZEdhQ2JvMW40OVBMdU43eUg4?=
 =?utf-8?B?SnZPOVBGditNaHlBak1FZTlMaitlNzB4RGdYQ1VjN0NzYU9oSUVOL0grV3JM?=
 =?utf-8?B?REo5QVR1Y3RxMEkzTjRMUk9jL3Z5ZVlJUUVlc1IrRHVKalEzckxUUytCTHhr?=
 =?utf-8?B?dmkvM015R09RK3JsVEcrTjhkbktxYkh0dTJQSHZKdmxoY0N3UlZGbXRRZmRm?=
 =?utf-8?B?L2xZYXFtdXlXVFIvMWpQcWd0UzRPU3ZkRXpXSUFOdjFvelFqMkhubTRrbmhH?=
 =?utf-8?B?K0tXZmRLZTlDOS85Ym9qdDFaTVU2RjlhVGpWbEdSLzN5TExEZFhWeXAxdWQ1?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86d4c87-161c-4ca4-8c61-08db5125243b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 07:06:56.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV5rDAqLgI7inn9KirnYh4B+cABkLLiBtQaq3heP3qmL93FclqZK1ZRDRms3fiypK+NKnDZTTF1o9QAMF+za7pOeKqLr57YOb3WJgCrBnSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10786
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 07:07:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11430

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAxMCwgMjAyMyA4OjAyIEFNDQo+IA0KPiBPbiAxMC4wNS4yMyAwODo1OCwgQ2hy
aXMgUGF0ZXJzb24gd3JvdGU6DQo+ID4gSGVsbG8sDQo+ID4NCj4gPj4gRnJvbTogTWFzYW1pIElj
aGlrYXdhIDxtYXNhbWkuaWNoaWthd2FAbWlyYWNsZWxpbnV4LmNvbT4NCj4gPj4gU2VudDogV2Vk
bmVzZGF5LCBNYXkgMTAsIDIwMjMgMTI6MTIgQU0NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPj4+
DQo+ID4+DQo+ID4+IFRoZSB3YXJuaW5nIG1lc3NhZ2UgZGlzYXBwZWFyZWQgdG9kYXkgKFR1ZSAw
OSBNYXkgMjAyMyAxMTowOTowNyBQTQ0KPiA+PiBVVEMpLg0KPiA+Pg0KPiA+PiBFbnVtZXJhdGlu
ZyBvYmplY3RzOiAxMiwgZG9uZS4NCj4gPj4gQ291bnRpbmcgb2JqZWN0czogMTAwJSAoMTIvMTIp
LCBkb25lLg0KPiA+PiBEZWx0YSBjb21wcmVzc2lvbiB1c2luZyB1cCB0byA0IHRocmVhZHMNCj4g
Pj4gQ29tcHJlc3Npbmcgb2JqZWN0czogMTAwJSAoOC84KSwgZG9uZS4NCj4gPj4gV3JpdGluZyBv
YmplY3RzOiAxMDAlICg4LzgpLCAxLjAyIEtpQiB8IDEuMDIgTWlCL3MsIGRvbmUuDQo+ID4+IFRv
dGFsIDggKGRlbHRhIDYpLCByZXVzZWQgMCAoZGVsdGEgMCkNCj4gPj4gVG8gZ2l0bGFiLmNvbTpj
aXAtcHJvamVjdC9jaXAta2VybmVsL2NpcC1rZXJuZWwtc2VjLmdpdA0KPiA+PiAgICA5MmQ2Nzlm
NS4uZWYxY2YxYmUgIG1hc3RlciAtPiBtYXN0ZXINCj4gPg0KPiA+IEh1enphaC4NCj4gPiBGWUkg
SSB3ZW50IHRocm91Z2ggYW5kIHJlbW92ZWQgYWxsIHRoZSB0YWdzIGFuZCBicmFuY2hlcyB3ZSBk
b24ndCBjYXJlDQo+IGFib3V0IGluIG91ciBsaW51eC1zdGFibGUtcmMgbWlycm9yLCBhbmQgc2V0
IHRoZSBtaXJyb3IgdG8gb25seSBwdWxsIGJyYW5jaGVzDQo+IHdlIGNhcmUgYWJvdXQuDQo+ID4g
U28gdGhlIHJlcG8gaXMgbm93IG9ubHkgNC4xR0IgOikNCj4gPg0KPiA+IEluIHRoZSBtZWFudGlt
ZSBHaXRMYWIgZ290IGJhY2sgdG8gbWUgYW5kIGJhc2ljYWxseSBzYWlkIHRoZXJlIGlzIG5vIHdh
eSB0bw0KPiBpbmNyZWFzZSB0aGUgc3RvcmFnZSBxdW90YXMsIHVubGVzcyBDSVAgd2FudHMgdG8g
cGF5Lg0KPiA+DQo+IA0KPiBTbyB0aGUgaXNzdWUgd2FzIHJlYWxseSBvbmx5IHRoaXMgc2luZ2xl
IG92ZXItc2l6ZWQgcmVwbywgbm90IGFsbCB0aGUNCj4gb3RoZXIgYXJ0aWZhY3RzIHdlIGhhdmUg
YW5kIHRoYXQgYWNjdW11bGF0ZSB0byBodW5kcmVkcyBvZiBHQj8NCg0KWWVwIQ0KDQo=

