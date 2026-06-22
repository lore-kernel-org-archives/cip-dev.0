Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B7CDB46B
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 09:08:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39037.1782119303135534367
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 02:08:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65M98KH8108000; Mon, 22 Jun 2026 18:08:21 +0900
X-Iguazu-Qid: 2rWhvgZcOCEoJyMp8T
X-Iguazu-QSIG: v=2; s=0; t=1782119300; q=2rWhvgZcOCEoJyMp8T; m=9fxujNxIvZjfUqKeTXlTTgXJq8xV2+ZIX0CudWLxJhs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gkMn04G2Fz4vys; Mon, 22 Jun 2026 18:08:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtOJ9RveL9Mm2nTUnK4CYnlxvdLLING3+MTZqGTsmnClolQkj796j/2GqwMBdtgCmv6B2mq71XYIrUJa9/4st6DqzmMMn/LZCY7d3VkyzEEI/W1JxnE/Wq95a60PdNkkfiMelmAlvhWSIKMxHWv/0+m597TgZTWYw0O4VS34S5u2qVKC5ayEoQXPfWymK85e2w3UaJNM2QjNf2d23kmw4iXyqJfumoML/FRx/5O/M5hhhOHCgJxW3owHTIsEhb+Kep8ESYNe6x4bJyA9mf8fuey+ZsAOcNgpxvPTJolkHrtaV1CzJfNYs7YWwklm+7mrNOxv8YjMytQzHyfEQr3Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSyF/jGa9oKuocbQS3K0LRz06VGDJv6tfqIP1kB5Wtk=;
 b=Wl9iByX79en8DtmEYxK/4mSXmDIW5/TxKfomzuAApfDx28OiL5/oq/osirGXrnNm73PuA6Q+h7fYjx5e3YeAibVhOtSDvGt+Z96PkhILQksT6IDR/iGcRoiknnd1L6m1BAEx4eq/vd/dDHYYscMIEoXKBcNYmtBP0Ag1WExFADVwSWK4Jci17s4O5fU2tCwrjxwiaJMiFqIch4zLlUtTMpOxUxvyUuuU15mICE772S5GQ958/cNQTSliFoNGWy0YApFG2Iyvc9estSf6dby8KyQXb/pTwWmInfIlak9Jstl3aOxWZJO3M2TEiFPyy/AkwAlj3lha+gRkOSxRHA4mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Enable Debian Sid support
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Enable Debian Sid support
Thread-Index: AQHc/U+0vEOD/PNnpUKPY4U0y5kdqLZDxiWAgAaL5oA=
Date: Mon, 22 Jun 2026 09:08:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11063FF31D3364774AC9FE026C7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260616050628.3560536-2-Shivanand.Kunijadar@toshiba-tsip.com>
 <8c762450-50ca-4aa3-8b88-42d067ce0e16@siemens.com>
In-Reply-To: <8c762450-50ca-4aa3-8b88-42d067ce0e16@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OSCPR01MB14501:EE_
x-ms-office365-filtering-correlation-id: e0df609f-a2c0-423d-2a18-08ded03dcca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|3023799007|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 iQXFJ+kamuuaKABO25xtcAbo3K8nxfUIjuuCVvj7j70HAJeyLKW47ydKBbO6Mz44jul/j+JKc2MF/B+E4ctbSi50cmaue5kXblRpsBSzb78JDhYMaxx87d6xmaC+SyW6SQC0G7eZVlpAGx3pUj1VuM8woYq+d2qIiWmJtrUtvqR/ZsTFmxbeto13gkhiizyYx4KZDeRcQPzISyGhQsoiMUc05ZK3Zh79kr3eSmU90gxEx0vxMVB4HYJvkflao+YOY+G5xbAsfkvuGlz4Isiae9RXPACYdI+5J0FdhVo++iLGmdZjLb55aVMRebXe54s/QDh/13ooJ2dVW9oZ9hOZ1HwtlaywhOL1PD/ERnPkS0r3jcuSLb0DdZhBGsPO0Vh6SiY+rMUcovPvO1rPc3Wa69CPmFjq/hNxC9IHPnLXY4Oqe62QQkZ8d9WIkE1vVfw3koEy2a5tmFFHJd3oIKca5iJ4x1z3M5YrHX52e3bfVDE7//tpyxnr18MQZ29j6pIp+CwuodGbHGuwOZzDqzmoPseM54H4IQP/ZyPITMmzhOhwAY/2oJWNF2e17NZcvPrW9/aqystQkVrBCd0mfKBeKMZF++rlQWtF/192Z8gi2PNONZ6L0C7A1z2UD9kjKmSxXwT9zpLyxWSTah434QgQ7b8MpiXvZuOp4sbsC7fLWe14bmEOVTPv5+l2xwvJXiSAFlij1eWhGWtfhlJoaptAzDxz9P4kMTDaWsG/PClqcrY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWhKWC9lZmpRR3VOYi85YnlwZjZkL1lYWlplTWE5dVJBWnB1Tmg0SDlJVDFP?=
 =?utf-8?B?NWluZUszbzVtek5Cd2dTUVVWcS9SNjNYNVMvb0F4UFdhcXlkOGdST0RZVG0x?=
 =?utf-8?B?ekh4cTVybm9wdVJSeWxBUmFNN1l4dGQyNlQwTFRGL3FnTjc0cmV6TE8rWXY5?=
 =?utf-8?B?anM4Q0JJTkFqUEI0TDY3OFpkRlNzSzY2cWU4UUNzRGtpZHB6aEkreCtTNk4v?=
 =?utf-8?B?QTBtYXU5UXhUUitOMVhHUVRyb1NoRDYzYnoyaUVqNHhLeFYxYlU1WkxOMzlP?=
 =?utf-8?B?bGlibmR3MWFGWGwrQ2xFbThrZXY5SmQvU0MyOXF0d1BNbkM2Q0QxNTJGaTEx?=
 =?utf-8?B?WXdmQ0pJQ05QNE1NSWNNYW5NNi9YOHg4TlRrYVFLbFgxQXhkQ2NvTitQWGYx?=
 =?utf-8?B?bVJncEp2MmxqN3EvaVYydEFIOEZWUitueWhLb0RBeTRQWEJHODIzWU56TU1I?=
 =?utf-8?B?TU5zZSt1RURIN2xtZzV3MGhuVFdyQVRDOTFLR2htWkt5aXliZUJHTW1iRVBE?=
 =?utf-8?B?VGI1OS9SZDQ3L2drOGYvcklSTWhQSHZNWWc2ZjJZK3lSUWpUekdCL1hqczBZ?=
 =?utf-8?B?c2FxMTZEQkxRbEpYLzFYZEdxVmhkWEs3NkUwUUEvZ2dHcHVML0IyRTRTdzZI?=
 =?utf-8?B?d0hZUUhDQmZxczRUTFFMaERlcTc5TGpqQ2QzRWdPc1hJNXdVQ1p1di9BZVpQ?=
 =?utf-8?B?aTBHam1tZkZGL1J5bmRWNGhPMStDWFVZdTNCTEw4YzI5VzlkTHZOcVJxdElP?=
 =?utf-8?B?Yi9uUHkwMVFIZlFHQVNzVkdDcmxGVktkYnIyQkRkRU1GM1BTT1BnZ2xRYkt0?=
 =?utf-8?B?TE1qZEVmUGZBaDhaVkhzb2M1UU9NMFZ2bzhQNW5oYlRlRjNTSlRyam80R3V3?=
 =?utf-8?B?SytMMnNKZDU4elpEZlMrWGVFdjc1T281Q1pRQkdtek9Ia2wzSit4Q05iQmxN?=
 =?utf-8?B?RndrVWJkSldrbk04REdGeXRtNUp4c0trbFNzTHRnZ1dNUWM5T3VwRzh3TVdB?=
 =?utf-8?B?WHVKbmYxUlZhYlcwRWwvOU5TVDNWMXlHMXc3U2FrNTNuTUZEL1o0d0cxcXpN?=
 =?utf-8?B?UmNvek9uakR3N0xLRE5BS29lMVlreXFvbnh3ejFDNjY1Q2loUkdoeFdEYzR2?=
 =?utf-8?B?TGlTODBMQnRQdzRvUXBLRnFqU3dMQmNadmo0bUtoNUd3bG15MUNwbFROTHNz?=
 =?utf-8?B?RXMwVnR1YUxRc1U0Wlc2QlYvWHB5a3NzdXgwV3Vqek9OcFpoMHlMU3JNS1F1?=
 =?utf-8?B?ZGlySk5jZlhxcms1SWRFVm1QM24rMjljaE94bGUyQmM3Y0Q0SDlKamdRWnpz?=
 =?utf-8?B?RHpsVUQzWU8zNGlUcnpJVGtlcGFDQWdMNW9YeUgrUE50cnhnM2EzVFkwQmhq?=
 =?utf-8?B?bHY4RXVYajllbmZZb0N5R0N1Mlo1UnNFQ0NUZDNyNzhtUlg2VXhNOXhsd2Rx?=
 =?utf-8?B?cjNsZ0l2VlhWNzUrdzIxR3ZWRGtvc3lLTkpRR1VJd28rc2U1U0NIZlBuUXlU?=
 =?utf-8?B?L0JraTdHSy9lL2JjNTJNZUZMRDM0THJWaVpVMUtaZU9ZdnhlQlNxQnVPOHpK?=
 =?utf-8?B?SW54TVR4dkRYdE1QRWZtY0RZMjVVNHc4aHJyQlkrLzE3M0tJMUVWR01zL3JR?=
 =?utf-8?B?M2lVTUFwN3dpeEhlaE9TNkplZE15SXFvd1FwcUdwcWppcnFxTFJyUGt2ejI4?=
 =?utf-8?B?aGk3RkpEazlodERjcVZYVTd5eHdDN1FrQkk0eHdvSnMvR3BwWmZROEJaYUpR?=
 =?utf-8?B?VDNSMVRkbWY2U3BIRndhZjM3d0doQk02bG9mUkhwcHJkNGpVY2U5bS9kOG84?=
 =?utf-8?B?Z2REblN1em1ucEhMaUdTVVk4cm1XOWxKZVd5RzBBc0s0Ly9pbEVVWTFFbWk1?=
 =?utf-8?B?akR3KzcrWjF4QUQyV1Q3VGtuL1Ric3VGei8zQnljRFhaOXV0T0theFdhOFpq?=
 =?utf-8?B?YjREK29tL0FNTFo0aHd3SUlvWTY1RDdmMG95VGc2UDlUOWV2Wm9nd3pYVTVi?=
 =?utf-8?B?MWcvOGduaXVaQ2VpZEVWeGxOL0VoQ25DbjFVa2dUN1dRRGJLMk1xMUx3VGto?=
 =?utf-8?B?bEdTcDFVSGNydFZOZ3BuS1EwQkZaRUx4ZTNQUkNTbENPc3pvczV0Ym1nNFdC?=
 =?utf-8?B?UTBlUkl3WFQ4V3h5Q0F2UFVhUkVzcWxpMzJRWVNKZDBUOFpzZWhEVDU0OGtO?=
 =?utf-8?B?Z3JrVTAzWDVrbU9pOVEwbXo0ekltQ0prendjWHRzU2NrTHlBcTJhdlpHUlZ6?=
 =?utf-8?B?SGJRaU4zNVh0U2FWbzNqRmI0L0JaSUdqYmZ4TGlxY2FlQmkzTHMyMENMcmJ2?=
 =?utf-8?B?ZXUrbkRMaWN3cTZlRk1MdGtIeDhJU2loR1pCaGc4M1hTL0taMEZaNDJpZ0hP?=
 =?utf-8?Q?NwMLuHgUIq9dB3GE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	iGuupbvrOnedSM2ADpx6StdL5oTL1MAfxpRM0yA4cQPsq6DyIask8LDGP9AmnR/iu9b1WmWw/rYUZco1Xofn4FtEqMf/9/olsvE9FIO7GC2iX97Dsbqx7e6SCDFHfTo/CyPbknZHj1cFffaObn6bDwQwxwdzrmcP9WMsz5t+sf1Ou4c7/EUBBN7tMoHzWMf1ulsNbI0iuqs7Jtt6S3sVqvk323T1SqZv9Pg0mEWlvbnA/QcpEE7ZAP6xEK9WWwDIjJ4DFFHG1ClcM6cdO0jVglVa9wHuYRAm4KMQgpHOUFRgu3Y6JTl8LVODR6m2MbgjpR2FNbM4js4qAlnf9R266g==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0df609f-a2c0-423d-2a18-08ded03dcca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:08:17.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFNR16yDRC4mG1Ai7Z1bXjkUPtamIuKoF/tt3p+EbcPHpGIzGf/cHLFBj2Tl8eqEMNuauJl2epYGP3vbNNh/gUDYq3SyaPsRcN6gslQeKcmnqGX41DpzCJDJPCjV5dRl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 09:08:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23242

SGkgSmFuLCANCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudCwgDQoNCj4+ICtQUkVGRVJSRURfVkVS
U0lPTl9saW51eC1jaXAgPz0gIjYuMTIuJSINCj4+ICtQUkVGRVJSRURfVkVSU0lPTl9saW51eC1j
aXAtcnQgPz0gIjYuMTIuJSINCg0KPldlIHNob3VsZCBkZWZpbmUgdGhlIGtlcm5lbCBkZWZhdWx0
IHZlcnNpb24gaW4gY2lwLWNvcmUtY29tbW9uLmluYw0KPihleHRyYS13ZWFrKSBhbmQgb25seSBz
ZXQgaXQgdG8gZGlmZmVyZW50IG9uZXMgb24gdGhlIHJlbGVhc2UgY29uZnMgaWYgdGhleSBkZXZp
YXRlLiBUaGF0IHdheSwgc2lkIHdpbGwgYWx3YXlzIHVzZSB0aGUgbGF0ZXN0IENJUCBrZXJuZWwg
PndoZW4gd2UgdXBkYXRlIHRoYXQgaW4gdGhlIGNvbW1vbiBjb25mLg0KDQpJIHdpbGwgbW92ZSB0
aGVzZSB2YXJpYWJsZXMgaW4gdGhlIGNpcC1jb3JlLWNvbW1vbi5pbmMgZmlsZSB3aXRoIChleHRy
YS13ZWFrID8/KSBhc3NpZ25tZW50IHNvIHRoZSB2ZXJzaW9ucyBkZWZpbmVkIGluIHRoZSByZWxl
YXNlIGNvbmYgY2FuIG92ZXJyaWRlIHRoZW0uIEkgd2lsbCBzZW5kIHYyIHBhdGNoIGZvciB0aGlz
Lg0KDQpUaGFua3MgJiBSZWdhcmRzDQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50
OiAxOCBKdW5lIDIwMjYgMTA6MzgNClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8
sCBESVRDX0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8
s++8qe+8sCDvvKTvvKnvvLTvvKPvvL/vvKTvvKnvvLQt77yv77yz77y0KSA8QWRpdGh5YS5CYWxh
a3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgRElUQ19E
SVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJv
KOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8a2F6dWhpcm8uaGF5YXNo
aS5mNzRAbWFpbC50b3NoaWJhPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCB2
MiAxLzJdIEVuYWJsZSBEZWJpYW4gU2lkIHN1cHBvcnQNCg0KT24gMTYuMDYuMjYgMDc6MDYsIFNo
aXZhbmFuZCBLdW5pamFkYXIgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggZW5hYmxlcyB0byBidWlsZCB0
aGUgaW1hZ2VzIGJhc2VkIG9uIHRoZSBEZWJpYW4gc2lkIHZlcnNpb24uDQo+IEl0IGhlbHBzIHRv
IGZpeCB0aGUgaXNzdWVzIGluIGFkdmFuY2UgZm9yIHRoZSBuZXdlciB2ZXJzaW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2hpdmFuYW5kIEt1bmlqYWRhciANCj4gPFNoaXZhbmFuZC5LdW5pamFk
YXJAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICBLY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICB8ICA0ICsrKysNCj4gIGNvbmYvZGlzdHJvL2NpcC1jb3JlLXNpZC5jb25mIHwgMTYgKysr
KysrKysrKysrKysrKw0KPiAga2FzL29wdC9zaWQueW1sICAgICAgICAgICAgICAgfCAxNSArKysr
KysrKysrKysrKysNCj4gIHN0YXJ0LXFlbXUuc2ggICAgICAgICAgICAgICAgIHwgIDIgKysNCj4g
IDQgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGNvbmYvZGlzdHJvL2NpcC1jb3JlLXNpZC5jb25mICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+IGth
cy9vcHQvc2lkLnltbA0KPiANCj4gZGlmZiAtLWdpdCBhL0tjb25maWcgYi9LY29uZmlnDQo+IGlu
ZGV4IGJkMmI3Y2UuLjQ0ZjIzMzcgMTAwNjQ0DQo+IC0tLSBhL0tjb25maWcNCj4gKysrIGIvS2Nv
bmZpZw0KPiBAQCAtMjM5LDYgKzIzOSw5IEBAIGNvbmZpZyBERUJJQU5fQk9PS1dPUk0gIGNvbmZp
ZyBERUJJQU5fVFJJWElFDQo+ICAJYm9vbCAidHJpeGllICgxMykiDQo+ICANCj4gK2NvbmZpZyBE
RUJJQU5fU0lEDQo+ICsJYm9vbCAiU2lkIChVbnN0YWJsZSkiDQo+ICsNCj4gIGVuZGNob2ljZQ0K
PiAgDQo+ICBjb25maWcgS0FTX0lOQ0xVREVfREVCSUFODQo+IEBAIC0yNDcsNiArMjUwLDcgQEAg
Y29uZmlnIEtBU19JTkNMVURFX0RFQklBTg0KPiAgCWRlZmF1bHQgImthcy9vcHQvYnVsbHNleWUu
eW1sIiBpZiBERUJJQU5fQlVMTFNFWUUNCj4gIAlkZWZhdWx0ICJrYXMvb3B0L2Jvb2t3b3JtLnlt
bCIgaWYgREVCSUFOX0JPT0tXT1JNDQo+ICAJZGVmYXVsdCAia2FzL29wdC90cml4aWUueW1sIiBp
ZiBERUJJQU5fVFJJWElFDQo+ICsJZGVmYXVsdCAia2FzL29wdC9zaWQueW1sIiBpZiBERUJJQU5f
U0lEDQo+ICANCj4gIGNvbW1lbnQgIkltYWdlIGZlYXR1cmVzIg0KPiAgDQo+IGRpZmYgLS1naXQg
YS9jb25mL2Rpc3Ryby9jaXAtY29yZS1zaWQuY29uZiANCj4gYi9jb25mL2Rpc3Ryby9jaXAtY29y
ZS1zaWQuY29uZiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCANCj4gMDAwMDAwMC4uMGEyYTJk
YQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmYvZGlzdHJvL2NpcC1jb3JlLXNpZC5jb25m
DQo+IEBAIC0wLDAgKzEsMTYgQEANCj4gKyMNCj4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmls
ZQ0KPiArIw0KPiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjQtMjAyNSAjICMgQXV0
aG9yczoNCj4gKyMgIENlZHJpYyBIb21ib3VyZ2VyIDxjZWRyaWMuaG9tYm91cmdlckBzaWVtZW5z
LmNvbT4gIyAjIA0KPiArU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVCAjDQo+ICsNCj4gK3Jl
cXVpcmUgY29uZi9kaXN0cm8vZGViaWFuLXNpZC5jb25mDQo+ICtyZXF1aXJlIGNpcC1jb3JlLWNv
bW1vbi5pbmMNCj4gKw0KPiArUFJFRkVSUkVEX1ZFUlNJT05fbGludXgtY2lwID89ICI2LjEyLiUi
DQo+ICtQUkVGRVJSRURfVkVSU0lPTl9saW51eC1jaXAtcnQgPz0gIjYuMTIuJSINCg0KV2Ugc2hv
dWxkIGRlZmluZSB0aGUga2VybmVsIGRlZmF1bHQgdmVyc2lvbiBpbiBjaXAtY29yZS1jb21tb24u
aW5jDQooZXh0cmEtd2VhaykgYW5kIG9ubHkgc2V0IGl0IHRvIGRpZmZlcmVudCBvbmVzIG9uIHRo
ZSByZWxlYXNlIGNvbmZzIGlmIHRoZXkgZGV2aWF0ZS4gVGhhdCB3YXksIHNpZCB3aWxsIGFsd2F5
cyB1c2UgdGhlIGxhdGVzdCBDSVAga2VybmVsIHdoZW4gd2UgdXBkYXRlIHRoYXQgaW4gdGhlIGNv
bW1vbiBjb25mLg0KDQo+IGRpZmYgLS1naXQgYS9rYXMvb3B0L3NpZC55bWwgYi9rYXMvb3B0L3Np
ZC55bWwgbmV3IGZpbGUgbW9kZSAxMDA2NDQgDQo+IGluZGV4IDAwMDAwMDAuLmQ1ZGNlMDANCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9rYXMvb3B0L3NpZC55bWwNCj4gQEAgLTAsMCArMSwxNSBA
QA0KPiArIw0KPiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ICsjDQo+ICsjIENvcHly
aWdodCAoYykgU2llbWVucyBBRywgMjAyNA0KPiArIw0KPiArIyBBdXRob3JzOg0KPiArIyAgQ2Vk
cmljIEhvbWJvdXJnZXIgPGNlZHJpYy5ob21ib3VyZ2VyQHNpZW1lbnMuY29tPiAjICMgDQo+ICtT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUICMNCj4gKw0KPiAraGVhZGVyOg0KPiArICB2ZXJz
aW9uOiAxNA0KPiArDQo+ICtkaXN0cm86IGNpcC1jb3JlLXNpZA0KPiBkaWZmIC0tZ2l0IGEvc3Rh
cnQtcWVtdS5zaCBiL3N0YXJ0LXFlbXUuc2ggaW5kZXggN2NjYmVmZS4uZDEyZmEyMyANCj4gMTAw
NzU1DQo+IC0tLSBhL3N0YXJ0LXFlbXUuc2gNCj4gKysrIGIvc3RhcnQtcWVtdS5zaA0KPiBAQCAt
NDUsNiArNDUsOCBAQCBpZiBbIC16ICIke0RJU1RST19SRUxFQVNFfSIgXTsgdGhlbg0KPiAgCQlE
SVNUUk9fUkVMRUFTRT0iYm9va3dvcm0iDQo+ICAJZWxpZiBncmVwIC1zIC1xICJERUJJQU5fVFJJ
WElFOiB0cnVlIiAuY29uZmlnLnlhbWw7IHRoZW4NCj4gIAkJRElTVFJPX1JFTEVBU0U9InRyaXhp
ZSINCj4gKwllbGlmIGdyZXAgLXMgLXEgIkRFQklBTl9TSUQ6IHRydWUiIC5jb25maWcueWFtbDsg
dGhlbg0KPiArCQlESVNUUk9fUkVMRUFTRT0ic2lkIg0KPiAgCWVsc2UNCj4gIAkJZWNobyAiTm8g
c3VwcG9ydGVkIERlYmlhbiByZWxlYXNlIGNvbmZpZ3VyZWQiDQo+ICAJCWV4aXQgMQ0KDQpKYW4N
Cg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVy
dCBDZW50ZXINCg==


