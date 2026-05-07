Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BFDCD3442
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:41:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8705.1778150498265807058
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 03:41:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=v+yC8+ZL;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1778150496;x=1779360096;bh=KBrmeW+2Gu2ocYHd+VCCru3DGMS/agiHuC8le
	761P+E=;b=v+yC8+ZLBG7ugt5GHUlpndZOzsLUuqnodyD9wCXNxdFHMqP1E6vQtaZnLXB5IvfmyTx
	78fIIVii1NISVKMeezexxcErpc81cMooXH6NrDcy7ZPa7ka2EsEHO4AsA2HPQucRYwDS75R7W7eM2
	DABVvjNvVM9V8wyXfMO/uvbCHP6q16rq3H4qISnmF1iaNO/RIVOQJrMQHAFaRQtgKE2Q3LhVZylBs
	27x3tt5pjLZmmkLgc8dGwar1W01b1dhq0xFrUlq3fYxo9eCJMtJlxNr2MHpDngWGfDu8LqwGKNt1o
	7w6dYBNwQXk1nnfkjtt+eCJ9vhGJ3E92kFtGHhiD8gjQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 647AfZ3U1881727; Thu, 7 May 2026 19:41:36 +0900
X-Iguazu-Qid: 2yAaXzkwkLr7ttedSE
X-Iguazu-QSIG: v=2; s=0; t=1778150495; q=2yAaXzkwkLr7ttedSE; m=sQhkz35eDoX6mzgFJQF3EdBUHZjcoPh74kPJ9g7YMBs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gB81q2pBJz1xnZ; Thu,  7 May 2026 19:41:35 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW1wW43GtfAypISdGomLF/iPZ/9X1v/7lYeVEB9EUTN5UAkoCrWG6vFtfAvtNpdNJ3IlC0w8AhSc1+2WO0BMfSoLylIOHfnJ5LziNEWJeErrTBn4NmjncfmmwD5sT+rfnvY2Oi75djDU9mjVWvw6FpcJvecGZFwgRFAc3ieLcUy6PINb99z13iLgU/3zeAgdo04gQvUtLUThAqo8aWYtcgTeEzhtBElWZeklrYFLzG5lu4+4Ok6WewsFMTgvOC/1Jsq/HOH2gVJLQsHdNpY9p4z1QNoQoJCWPo0dF1IsJ5WWqZu/VlWMtG6/CoF+E5SYO3gISFEyoY49pU15r3uJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBrmeW+2Gu2ocYHd+VCCru3DGMS/agiHuC8le761P+E=;
 b=XfdpkJeS9ERo/708D4yjuIrYkc+XjicOfM8cHRJmG6qFQyM2py7h92vokL+0r+PH9jN/xskg/UYGFtMHLUnK8qJeXYc/zY+oRkjIHwRvf6LZIFXqgkoPXVGJuNEXLiCPiy/3/bMVTJv8ZD/QOdXvskS5xkp7zPgQipFO5eHzpMGksPlbZIuONaf5ZAjCM/Qk0QZsG6APwHilW+HgAfobFXF8zK2fiPjheG17QXYdlxThvCrtNI/gyG1HrRJ13XYNOiq5WAf70hFZN3e+xjDOD9pv0K37CsC4oxQlCyHaYlAPFhJ/gmJcNsIDBPUZ1bi/2TL7jUsv1fpU8vpxrutUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHc3eenvVHghKxuHUiyUQncxO/CrLYCXLaw
Date: Thu, 7 May 2026 10:41:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D667724D1C9E246F5C29CD3C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <91059c44-aa54-4918-87e5-2d76dde2331a@siemens.com>
In-Reply-To: <91059c44-aa54-4918-87e5-2d76dde2331a@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10525:EE_
x-ms-office365-filtering-correlation-id: 6065fb0d-e73e-440c-6e41-08deac253474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 5AEAkQQ1KWi3SIKxyOuoGIRc0c0K/i8IsiaMFXLo+uAvNKvCvlNysZ1llkUGpIU7CrQ7V0tKH9ZceoHg6o3we/IMkr6ZO4xW+NjRN/1A828XVjMwcBykGTYLM8kIQsuS0MmwcDhu9beslN+023j1Akna5pFhG2GnNal9oHEgoFkeYdMJoDK+1wpE+VoGAMWmMR5QsuyLuVArm37Euv7gKg5wiTxZIUCbTOoJ+hja0R0tM8G1gB35S9uK5YDWJD1MHNYJIPfxe0dsqetafb8KAm+FhuNRLm/N7jYOEFMb2pJ97zdGZtmIeMu9A7igfOvrNPLVNoqwiLadMk5o6SVWuN8iLDeIJDWhYabzi4CjG8IuhhsV4z9Z7dIbpKNSQgjo0Zz0XyHnnbkJc/jc8o1in04xbtvZ1LfJF4T8P8dKnjGeOF0d5ba1d8KWGmYeykGgbQL6b2WYmdlhW847MlKlTVdtKzYYAdHp6EffkLwKaJnJszpSpQfqsmEf5LGbHKyfahdtIrBEjJ/zLp1nTv68XSLbREArPcRYkaOJSUiI+bDvNKeI/pGeu20wY7DiTEanUpU6m8zld9JqICJwMnYGeJeAO7v4avutZ29w/BJLgGgRmzFqyySQ0BI41xB0SVTrkx7OpZB9li7D158cw2MpjPUVrkBFCqRSInfOhJcs+dAyPdPD7nxRILI9ljAaOsc0ivtbruhC+qYGP81qfexNvA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aDV6dUQ5MFlxQkNRdmdLTEExRnpIVDREQ1NZYjRUQTlUTlB0K0hHSXZSMVlY?=
 =?utf-8?B?VXR6MXFmajI1Y3o0blphVkd1THN3RDUvOGlhWlpVWXE2alNNRk5uWDdXMWEy?=
 =?utf-8?B?OFhUR0pBUFgxNUdYN3Z1MXFxMVJWeEZ0QUN2czlCUHRva3k5dnRDZUxtWWV1?=
 =?utf-8?B?OHJ6RGRYamlpaGc0T0pwRE90WWdyam9aTkZQS09wY3g4RW9DUlk5N1E4RHVk?=
 =?utf-8?B?MmFCd3hUVVZoTkc0UktveFY0b2YrMTlpM0s3TGY3RVg5c1pZL3pETDVXc2J6?=
 =?utf-8?B?dXRkY0NtZ212NXAzTVE5bkttNEZqS25xUW5wSHBudTJaUDB5alp6NFJ1SE5r?=
 =?utf-8?B?b1lYSktobVdobmlOR0tsRmh3KzJHN3lMR2t5d3RWRlBIckpEQUNDLzV5aktZ?=
 =?utf-8?B?QnNZcE5zeVpycUVjWGRCTDdjZzJOTEV2QTVzSFNrYjZVVGdLbzdDUWdHOURK?=
 =?utf-8?B?Z0Eydy9sV2kraURiZ2Y4aEcyNkhXcXBQVjAzd0J1ODVSd01wUTFpaTJ0VzdP?=
 =?utf-8?B?VjVrZnNaTmR5NEM4bjF0ZDJ4c3hSZWt6STkzYUt3VVpGQXI2dUtzNitQWmhj?=
 =?utf-8?B?cWlXZjlsRkFOYzdUYUJ3UjdLNzh6bWZ0RVp2SlFMVGdFNEkyRDdSTWJwRjhK?=
 =?utf-8?B?M25UdnZGMmpGWERIZkZ5TzNIMW1DVU1ReG4rcHJFMm1Bb2ExSzFNZCtGVFNS?=
 =?utf-8?B?VzA4VjNkb1dMSmdVVVdhNGFhRGRDRm52dFRWNlZNSzN3Y1NFbXRzemtrRWgy?=
 =?utf-8?B?Nk8wWGdvSzBBRUYyNXdqVnQ0cU1QTHE2eEFiZzJOS00rUVEvVTl5Q3hRbUQv?=
 =?utf-8?B?c1hCQlIzTkt4dWdPMlJVV2ZJeGNWQjJWV0dXUDltaHkwUnoyc1dWNkticUlH?=
 =?utf-8?B?VncvTFZ6bmdDRTlSS2lGQmJiV1VXUElqRXg0cTk0NGh5eHhHaVBKajVITE5D?=
 =?utf-8?B?dkxhWnJKeVd6QTlpcnpkdjd5NHFSMWJscklRc1FzbnR3ZTh1VUExSHRQaHpn?=
 =?utf-8?B?d2hoY2c5MzdSNmVDUzNQVVFVRlpUcksxeXk2cGtEZzlkL0VKUU9IbEVReTVt?=
 =?utf-8?B?S0paSkZ0USs2UnBLV0RodnRlL2J1U0lkQ0FBN2xzWWZtMmcyVHlBb3QzSkI4?=
 =?utf-8?B?TlNrWGZGNi82TWg5NkpvVEQrZ3VjWjRFVnVhQlhFY2VncEdGQ2lsSVUvaFQ2?=
 =?utf-8?B?OURKYXZ2bCtVTCtYMHJqWDR1YlYyako1cSsrZE1zejRXSCtWK1VLMDZla2Vw?=
 =?utf-8?B?Qjc2cXpTdEtBM2Zaa04rcHZINzkxaWtFWFNFQ0tKMC9reTJPMzNZSFhWN0Uz?=
 =?utf-8?B?YkFNbHlKbnNGL3haemowQXFLTEMxYzY0UDJpR3ptK1BhblVGbGhhK2dzSnlj?=
 =?utf-8?B?RG1MZy8vNGtLb0s0VE80UHhYSXB4eUJPRkpzblVjQWpoNHVvd3JJYjRDbGZV?=
 =?utf-8?B?bjc0Z1lOdm4rcE84U1pocEZvRm45b0g0Mk41WGJRNlhLdTcwRm50TEpweFNz?=
 =?utf-8?B?dzNLVmlFRDI4eXp6bWc4djgxbkk3aTBMemttN3Z0aXFab1A1ekdNem1FYkxX?=
 =?utf-8?B?MHMzdzdSUFRYaFBNUHdEazJhT2IxUHAyYWJnc0hKdE5hS0h0RGpTM29SZHRZ?=
 =?utf-8?B?ZnFPOTNIdlY0Wm5Id20vNUgzMXRFN2d4RklkRk5XMzhsUUdTeFZOQ2Voamh2?=
 =?utf-8?B?dTA1SUxFTWQ1MnZ3R2FtbEV4bEdvNTQwVldLSS8wNzRSaWxIc2NVeEh6Wmx1?=
 =?utf-8?B?ZVNQamkvdFlGeENvQ1l0VnBBSFlTQUIyQytnVTR5c1NxVWl2alBXbEtCSklP?=
 =?utf-8?B?UHpDaWY3d09vUjVwYy8vSnh5SUhWWnpkV0E0L01IU3VZMk1aODJIQldaN25X?=
 =?utf-8?B?azlGb1NtdVZvaUQyVy95eVZPVVNTYVB5UXZKY2E0SnJmZXNQdVNEZ3k3UWVL?=
 =?utf-8?B?ZTdubU9ER2RjZlVHTFN4emM3VjkybVZIZ0EvVVI3WXVOVVBPbTI1TkpWOTZp?=
 =?utf-8?B?UnA0RkRhUm0xM1FlUDJtSUM4ekpDSUtjRWtBN0w3VXJOQnVQMm83R042Tm84?=
 =?utf-8?B?VjZoK2Q1eHBxZFNwclhWeXQrSkxUbHNTbFFpUkxWMnhUeEM1RXVKVG80WnBG?=
 =?utf-8?B?TGlFd2hPNnUzV3BncXkwaGFjK2xONWNuS085c3JPL2UrR3NBYlo3VVNZaW5N?=
 =?utf-8?B?a1AvMTFTUkxDV0FFSUdlYlZ5Q2xuTksxVDNqYitPYUlpc3hzRXp0STV4cXg0?=
 =?utf-8?B?b0xuZHk4YVRuM2lqRUFTMWgxeGFPcFRmRWQ2ZWduWGxQY0JXM3hnVTF5cGZQ?=
 =?utf-8?B?T3JFY0tZUVpiTTJuU0hjRTk1dzBXcWYyYTlpTnRoSWlNWUVMQ3BOT0p2Y2J4?=
 =?utf-8?Q?CYJnq3ezWCcjFw4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	WFqPhaOUs/RvISwEnP8zSUJ7wX2Gvmb6yJYmDPHLPGZ+nhJRsGh5n0YhWOi4Yp4MLUz8JxMcQN0236ZWNJsOE+Y45QNTP8Zci54Wg1c/o/Xm7m1K6bDeG8sdC012I9d3Fb0jbwy8zk+yl2/q5zQ7MB7NtdEQPiFJvaKZ3D7ANaLFa40ihtQMMoOpqZuvFj33uj7jUYnSr6FWJCrDIZ/Xb6DW1hjXD3y7Hkq9BH9ezkHA5P9rDekdcPUg05M4LWyZdUtN8tqcm8WO+RhvrnXVVwk5PPC57RWIqGC0Z7KeWYWjcAbopsusuZHPWy+VP8oi/tLV8ix17HsbavIxt8bZ+g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6065fb0d-e73e-440c-6e41-08deac253474
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 10:41:32.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqLiD38LzS0gb2+768gqlVxmuBUNJdqyegX+E/9tD1Tv9Cf+70X4JWv5lSRsKo8p8V+SBQI/bT/CgWA9Zkg6TSQuBHrUbUY1phlGMNxguBNJcEw9cNNaLpAz7KifqkTz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 10:41:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22901

SGksDQoNCkkgY2FuIG5vdCBwYXJ0aWNpcGF0ZSB0b2RheSdzIElSQyBtZWV0aW5nIGZvciBwZXJz
b25hbCByZWFzb24uDQoNCj4gKiBBY3Rpb24gaXRlbXMNCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2Ug
dXBkYXRlcw0KDQpJIHJldmlld2VkIDYuMTIuODEsIGFuZCBJIGFtIHJldmlld2luZyAuODIuDQoN
Cj4gKiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ICAgIC0gc3RhdGUgb2YgNC4xOSBjb3B5
LWZhaWwgcmVsZWFzZQ0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogQU9CDQo+ICAgIC0gQVJNIDMy
LWJpdCBSVCBiYWNrcG9ydCAoaWYgbm90IHN1ZmZpY2llbnRseSBjb3ZlcmVkIGR1cmluZyBFLVRT
QykNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgMzowNiBQTQ0KPiBU
bzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFtj
aXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0DQo+IA0K
PiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkg
bWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzIHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAg
a2VybmVsIHRvZGF5LiBPdXINCj4gY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAg
IGlyYzppcmMubGliZXJhLmNoYXQ6NjY5Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBz
Y2hlZHVsZWQgdG8gVVRDIChHTVQpIDEyOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRh
dGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjYmbW9udGg9NSZk
YXk9NyZob3VyPTEyJm1pbj0wJnNlYz0NCj4gMCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwND0zNyZw
NT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVLICAgICAgICBERSAgICAg
ICAgVFcgICAgICAgIEpQDQo+IDA1OjAwICAgICAwODowMCAgICAgMTM6MDAgICAgIDE0OjAwICAg
ICAyMDowMCAgICAgMjE6MDANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczov
L2lyY2JvdC53bC5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdzL2NpcC8yMDI2LzA0L2NpcC4y
MDI2LTA0LTMwLTEyLjAwLmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAqIEtlcm5l
bCBtYWludGVuYW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KPiAg
ICAtIHN0YXRlIG9mIDQuMTkgY29weS1mYWlsIHJlbGVhc2UNCj4gKiBLZXJuZWwgdGVzdGluZw0K
PiAqIEFPQg0KPiAgICAtIEFSTSAzMi1iaXQgUlQgYmFja3BvcnQgKGlmIG5vdCBzdWZmaWNpZW50
bHkgY292ZXJlZCBkdXJpbmcgRS1UU0MpDQo+IA0KPiBKYW4NCj4gDQo+IFsqXQ0KPiBEYXRlIHRo
ZSBkYXRhIGlzIGNyZWF0ZWQ6IFRodSBNYXkgIDcgMDY6MDE6MzkgQU0gVVRDIDIwMjYNCj4gbGlu
dXgtNC40LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNl
IGRhdGU6IEZyaSBBcHIgMjQgMDY6NTQ6MDkgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBT
dW4gTWF5IDI0IDA2OjU0OjA5IEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBs
aW51eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJl
bGVhc2UgZGF0ZTogTW9uIE1hciAxNiAwOTowMzo0NCBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRh
dGU6IEZyaSBNYXkgMTUgMDk6MDM6NDQgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNr
DQo+IGxpbnV4LTQuMTkueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9u
IHJlbGVhc2UgZGF0ZTogU3VuIEFwciAxMiAwNTo1ODoyNSBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0
IGRhdGU6IFR1ZSBNYXkgMTIgMDU6NTg6MjUgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRy
YWNrDQo+IGxpbnV4LTQuMTkueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2
ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1IEFwciAgOSAwODowNDozNyBBTSBVVEMgMjAyNg0KPiAg
IGxpbWl0IGRhdGU6IE1vbiBKdW4gIDggMDg6MDQ6MzcgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6
IE9uIHRyYWNrDQo+IGxpbnV4LTUuMTAueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVz
dCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogU3VuIE1heSAgMyAwMToxNzozNyBBTSBVVEMgMjAyNg0K
PiAgIGxpbWl0IGRhdGU6IFR1ZSBKdW4gIDIgMDE6MTc6MzcgQU0gVVRDIDIwMjYNCj4gICBTdGF0
dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUuMTAueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAg
IGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIE1heSAgNCAxMDo0OTo1MSBBTSBVVEMg
MjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBKdWwgIDMgMTA6NDk6NTEgQU0gVVRDIDIwMjYNCj4g
ICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTYuMS55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+
ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgTWF5ICAxIDEyOjQ1OjAxIEFNIFVU
QyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogU3VuIE1heSAzMSAxMjo0NTowMSBBTSBVVEMgMjAyNg0K
PiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4xLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBk
YXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IE1vbiBBcHIgMTMgMTE6NDM6MzEg
QU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBGcmkgSnVuIDEyIDExOjQzOjMxIEFNIFVUQyAy
MDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC02LjEyLnktY2lwOiBpbnRlcnZhbCAx
NSBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBBcHIgMzAgMDE6MzY6
NTIgUE0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBGcmkgTWF5IDE1IDAxOjM2OjUyIFBNIFVU
QyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0K


