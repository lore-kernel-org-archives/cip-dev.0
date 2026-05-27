Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD2CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 22:55:33 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32964.1779922531489344520
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 15:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=vbRjrsAs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.66, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iga7kyVLYWBYP3plxIlxkvG6FjhTm1MItEDkyNvVkb3kqJO96QCMI+x/YRPnHcZ3+wSU+ldeTjYoDDYmdM3ULXfIdHbmqV2DcmXCnq4ijGW7rd0nc6UcOyTnIA+VVM/9I6vWz0FTqgMHuKcjo0x/UEuZwzD7QXrDMo/BqmcaCb0hfaIuXsdGZ4OsNaPeQtg61wmO91SaTIy21uOzZCK9X/ZRxKUXgXigqQcx7M4pckvxYagsxQVLXBEE1l2mPzUg1me3jUap+UeqRtMm2LfmXAlB3uFQbA5w6OEofv5W17uDmu8iWt9+gNUPI7mrWzbVTfAkMkK7mFGsh8YHQWu+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r+C8cQdeMrGEGaaGTscDfPfuZvhkPC9/PX0wm1yHDE=;
 b=jAG9KuVMxHnlUZRXl6beKGVzmm8/FLIvdJR5hydIzuTMY/x0gesW3SjkZEc8tkxoB2PikCnI3XePJyl+lnu+hUTQDrPl40ZeIsKDI+14UkScKlVbJs/aseIN+Cpss7d1+M5ieHw3c4eZ+fijGRC3+NenpiSVpVqDhlInY6+4GLHJHkKAgCrh+4kvpz4lr1qzArFchMtOc9ZUARGUSXpMPv+hY/Y/bopEDBYYeCjjAHHbXFkfZ9HGpQ2nfNNGgab7MR4IDToLjdZeet4xVKYSF3wm2gmv4D1hGyU6u9su4K/LbpKlqWKdex2fXscWE2TWGeqLxYRGEoeM1rmR6a/tjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r+C8cQdeMrGEGaaGTscDfPfuZvhkPC9/PX0wm1yHDE=;
 b=vbRjrsAst8qEBzjf8aVUzZXyI/bE0JMKNIO9xmw0KUWI9e7hJkRFD+CFat0dAUHXuR6NIiI7AjDSQvoeJ3KP2lLEdZCR1DOHT5VsJyxcQWXTn5OCf0UYDSJgqS10dTJmToMNAgF52FAi6sSw3ViGnp+QqOxZFXMiA+wnPVgY/nQ=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TY4PR01MB12925.jpnprd01.prod.outlook.com (2603:1096:405:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 22:55:26 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:55:26 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Thread-Topic: [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Thread-Index: AQHc7h36w5n544Qr0UaSUGAUJnHTMLYieyZA
Date: Wed, 27 May 2026 22:55:25 +0000
Message-ID: 
 <OSCPR01MB143155261CC58BA2BCD8F7BA4AA082@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ahde-JBeE7BGLuJh@duo.ucw.cz>
In-Reply-To: <ahde-JBeE7BGLuJh@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TY4PR01MB12925:EE_
x-ms-office365-filtering-correlation-id: 9f5e438c-f0c9-4d7e-9cce-08debc430ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 GamaWK4bceIXKf0HgDW1YmZm6xwNjd/uHvl/AqsWL+2TIGsikb+MqTD3OOt0OP0tezjI1NIG3bOG+nUSQXO4Z+aUR7YWx6CUv/8J8Mc46nl982NsgNFTYK8fHNuLloxeqcNyxoZY51zoaFB6lZdRX3WZr2xCh+kSs6PJlWD3VeNMJQZBRO/DOSmEVyTzFEa9MObMi5n2d4ZwLe9jp22EUYz60zFh7LlGVAyGv2eEsvVMGUer83y5K5r9w7u4E3KqREodyL6XQgkzhXYxiyJQ1qVgzouRejTWAVdmPrBKUzwMa+QlTkGMLATYZSMHPgIS7qa/gYlyK426LH4iVavYvuvi9XR5MCZwZLZaHjrnSYj9W79PkaoPnpgd0r83OUn9GOFjXCaZ0WD2G35vSIsH/9cpAc27eelFwV7XYVV/f0HbA6LjYX4lT0EiGqXDGJZHGpDCsDfYVOXxxCOogYelfYFgi5DM1Kkk2KC6cEZfWwYX3gCkrCtbYC/pF4YY0Aprxx9GrgTPRCCruU90WBk9oq1UzDC4YHFJUTSjk/AgMlWp4hhTnRrbLn4rt6qDHPoOiswZAwJffVdClByOUQclmZJqYdFGFv69oz+L5sOmpayqfdi3RGotdceL7W/mN6fvJgCgfJbgg89dx2J0qvzj4Me8nudM+4Si+eRiQWvPLGDLTtgmihzILXG7+vVyEdU0Wn2P1Sy9lTxlF6X5BQeCA6g12srT4vubZx/MEnKhMc27DRxDH4FfKb1cpf660uTm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVRucmFpZ0QyZFhjNUpHbG1nYWVYNTk1aTRDVThlUTdYYy9sUHpuYUgyVEp1?=
 =?utf-8?B?S1RjY0p4eC9uaWhXOWdEL3RxUWhlOVBmNVZRS2ZDSHoreG1QM0MrQU5Cd3F0?=
 =?utf-8?B?OFZld3o4bmZoQ2dkeUVrdHN4SEZkMjVJY29MOEZsR1JoY2k2OW9UWVNPMnFX?=
 =?utf-8?B?OWNyYWRKL2dCR3RVd2UxOWtseVlXMFVsVm9ZMzRERWZPYjB5ZXNiV0ozaTJD?=
 =?utf-8?B?RUwyeVRqelhsM1pWS2lEUXowZWhrbUpmeWZIbkxWcElUd0JDQ3ZmMVZDSGIv?=
 =?utf-8?B?TUJvYk5xYnRWREtVU0U3aTBCTWVFOFQxZXV6dG82WU1PZTlsZm1najFGODI4?=
 =?utf-8?B?RWtpQmNROG42Y1duaHk1WWdqQjN0angxMkowaVNqeE8zSUo1U2hpOHdFc0dX?=
 =?utf-8?B?anlCbURUZlQ1QlltNDlkYnpUOVlQUFVOMEd3T3lvdG16NG1hQUlDZG5xSzM0?=
 =?utf-8?B?UnNYM25kbnAxa0hib0pjYUlJY2Y4UGVWbVU4NmZzVG5zYVNnNVh0VlZTMTVs?=
 =?utf-8?B?cVM0VTluZkY4WjdyMVZjdTRPSytibk1ySFZyZ3pBS2VwajVXZTFtdDQraUxo?=
 =?utf-8?B?N2xHcUVBZTZnekZreFFESk9pNXNLT2JYTVZFcW5jYjB3TkhkQUxuditGTXdP?=
 =?utf-8?B?K2xDRUZaUGhkUzF3Sk1kVUUrSDRsaFoyUEQ5dGFycDFyMEpyblVjbEJCRisy?=
 =?utf-8?B?MkNNNy9kbWlXdWwrd2M5VnlIZE9OdHpYaERmdVE1SE1xcndpSjRpOUZZVSsz?=
 =?utf-8?B?SjhQM29YS1IxY04zT0I5OTRuVW9TUkFSMEl0cmpBcGFPRzQ0aDhaaWVkd0Zu?=
 =?utf-8?B?UTkvNEwwd0NYUWhuSWh1cXl2M3hXWEp1WTZ0Sm12QlV2Q2VPdklTRmRaUU9N?=
 =?utf-8?B?ZlUvWjZsNXFNb2ZNaWlhcTh1cjN1T1hqT1JaYkwvcmtSckxhMTR4QWpFTGpr?=
 =?utf-8?B?QVVLdFFxU2s4ZUUzQnlNTVd4TEQ5ZElUcGpUQVI1aitOOHRiNUZ2TEw4Yncy?=
 =?utf-8?B?UjJYTERBeklXNTAvM0dDRGVBMkZqSWgzL2dRdHhRSGtIVk9yREhKb25WcFNM?=
 =?utf-8?B?L011ZW11MUU4aC96UDY4VnlaZmx2NTFibGRQQkpKQU82VnFGakFrNE5hS2xB?=
 =?utf-8?B?Ylo5SDd2TDBpSUFkcTFQYktwUXJwdFdJOVRZWTdFWGRNSklHc1pvRXVoSWZ4?=
 =?utf-8?B?cmt1ZkNXRG9sb25iWEZqeDhFbGtSamdYMHR4K2QxYnIvYkxsOWRDRmZWZmdT?=
 =?utf-8?B?MXBNQWVOb2lHVk9oZXZQemZ4Q1ZpQlppcFNLNjdNR0g5SU1WTU1uRW1SUHlU?=
 =?utf-8?B?akJHRG1reldvaVlNZ2hsUkY1YnNzZGF6U01EOERDT1JYK0FUNGtQL25HSkhL?=
 =?utf-8?B?dVJMSkh5OXo3LzQrbXVYa25TczBTQkNhdFE1NkJUc2FhK3IwM2lXR1lXb1A4?=
 =?utf-8?B?b0lrUVRZaEhocklRSytGWE8zN3huVUIzZkxaYnhtbU93VldDMnVIMVMwRXV0?=
 =?utf-8?B?L2prSXFYQVJmQWQvRkgvaGt5ZjhubXAvRjNzUGM2U1ZpUUE1N01VUWRESkUw?=
 =?utf-8?B?eUlZMlR1d0lJUXJMUjlscFlWcFJrMktybSs1K1YwTlFobHpncjN4cVdUdGVM?=
 =?utf-8?B?dFlMTCtuT3RTYkg0a2FuK0gyT3RuR3ZTeWtCd3FqdXA3YUFDZjd1VVMyNW5x?=
 =?utf-8?B?QUlNMXVBT2NsMGFBRm8ydTdKK09Kem1PSTkwcU55cUI5d1ROa1JNZjhiWmIx?=
 =?utf-8?B?ekZJaUJIa2p2TkFCYVFWaXVwTG9pbmxFNlk3c2d2VFArOHBIVGFwR1pYTHcv?=
 =?utf-8?B?bVFnZVV4L3FBZWJFMTNFS25LU3R4VjJaYWNGbjNWMGRvVFRuQnJ1UGxQWFlH?=
 =?utf-8?B?Q3BiWHZYMkpYQm8weVE1akdGYnJnODVFYVJ2MDJBRmwvbTRoYVo2ZlUvRVF4?=
 =?utf-8?B?aDVhQU1oWkVmc2R1YTBNSGM0K1hySmVxak1ZT1pkREIwd0hhbTlBNytBTW5D?=
 =?utf-8?B?OTByMlJGUjdTWk1RN0dXVk9IQlhvSXQ4WGpzNy82UWdUdEh1eDVmSjU2WjFD?=
 =?utf-8?B?SmlONmRUZ2g1amsyOHVYWTUvbStvcFhOMFE5V05WbnZ1TmRnVkRSY0p3V0Ro?=
 =?utf-8?B?ZVZ0YnJBK3pZeFpxbVRaMjBUaFdvS1UvVE1zVHdULzJySlpBVmI5ZkVKWlE3?=
 =?utf-8?B?YThDMXhackNpNGpnYUxrSVNHUjB5YXFXT3I2RE5EOTM3WnVSNERKQ25kLzVx?=
 =?utf-8?B?TG1SMXhkMVRrTFVFY2tqQVh6M2xnYmxtdTRGL3hISnFVWXVUUkdpbjk5OXNs?=
 =?utf-8?B?OWJycVpvN2R3QnlEL013QXlKdzdLVUNKM2o3NkVuRDNHamthM3QwKzZMN3Nx?=
 =?utf-8?Q?5B9/2bQgGHcjWPz62g7HSF8W63JzhiqWVd2tH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5e438c-f0c9-4d7e-9cce-08debc430ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 22:55:26.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zu6CalV85Ad4tBfhtdguKOMJp9vHlLwlslvX+bctqHclIB2jhShHUXyrltqoBl85X9DOntCVZMfb1X/NVng4WnKilGu07c6dqTMSiHRB/qs+bPFgbB7ddW0bS6XLTPt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12925
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 22:55:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23029

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIDxwYXZlbEBuYWJsYWRldi5jb20+DQo+IFNlbnQ6IDI3IE1heSAyMDI2IDIyOjE2DQo+
IFRvOiBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5y
ZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBOb2J1aGly
byBJd2FtYXRzdQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT47IFBhdmVs
IE1hY2hlayA8cGF2ZWxAbmFibGFkZXYuY29tPjsNCj4gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUuMTAueS1jaXAgMC85XSBpMmM6
IHJpaWM6IERyaXZlciBlbmhhbmNlbWVudHMNCj4gDQo+IEhpIQ0KPiANCj4gPiBUaGlzIHBhdGNo
IHNlcmllcyBhaW1zIHRvIGFkZCBJMkMgYnVzIHJlY292ZXJ5IHN1cHBvcnQgdG8gdGhlIFJlbmVz
YXMNCj4gPiBSSUlDIGRyaXZlci4gQWxvbmcgd2l0aCBhZGRpbmcgSTJDIGJ1cyByZWNvdmVyeSB0
cml2aWFsIGNsZWFudXANCj4gPiBwYXRjaGVz4oCLIGhhdmUgYWxzbyBiZWVuIGJhY2twb3J0ZWQu
DQo+ID4NCj4gPiBBbGwgdGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGNoZXJyeS1waWNrZWQgZnJvbSB0
aGUgdXBzdHJlYW0ga2VybmVsLg0KPiANCj4gVGhpcyBsb29rcyBva2F5IHRvIG1lLiBEbyB5b3Ug
cGxhbiB0byBkbyBtb3JlIGJhY2twb3J0cyB0byA1LjEwPw0KPiANCkluIHJlZ2FyZCB0byBJMkMg
ZHJpdmVyLCBubyBJIHdvbid0IHBsYW4gdG8gZG8gbW9yZSBiYWNrcG9ydHMuDQoNCj4gUmV2aWV3
ZWQtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAbmFibGFkZXYuY29tPg0KPiANCj4gSSBjYW4gYXBw
bHkgdGhlIHNlcmllcyBpZiBpdCBwYXNzZXMgdGVzdGluZyBhbmQgdGhlcmUgYXJlIG5vIG90aGVy
DQo+IGNvbW1lbnRzLg0KPiANClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KQ2hlZXJzLA0K
UHJhYmhha2FyDQo=

