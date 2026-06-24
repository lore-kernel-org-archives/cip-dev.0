Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3ACDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 09:11:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2923.1782292252480350703
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jun 2026 02:10:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65O9AnUk3164075; Wed, 24 Jun 2026 18:10:50 +0900
X-Iguazu-Qid: 2yAc042kWPU3GMJz6I
X-Iguazu-QSIG: v=2; s=0; t=1782292249; q=2yAc042kWPU3GMJz6I; m=aaChf0CaqnorxkwsMp0VH/opOR4UeFMt3F0UbuLv6Jc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4glbkx3lPjz1xnZ; Wed, 24 Jun 2026 18:10:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R647z09/ll6qOMvco5ldhFgffCW0Y2059IKu9/Hnfu0g7pQMXn8H3bVTmGVfFZNEgXoXTs/TPxtbMVqzl3ZTBVQYyCyYhxpyBR7ua8lF7QuDLEwC5+zExMeD0hQOvnXP0hN96t1D2PR5Jw+IDAQzWvuwE0mX7VLslNW6fTRDIiGgYWKdcyR4vLggwjgQQSdBJ1hbuogVZCOyC9wtSGwWDcYbSueg8v6+JziiAXtVK41l9Edan/ybueN9MlRoYuHU7jp6jdEbAwASr9Gu8xFpOzMk4Gz0AYIfJutlAFlGW0b7wU3C+6fQjhBMAVSyCeU2O12p+SUkeY9G0L/03HxoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ttNIU4TOnHYlkeuj7KxoZCAey/1eXjB+LCBgSB2+Jw=;
 b=gNrlyZn8x45QfK3YotAXzFyXt3nlPzxIVvGgv9Y0+hTaXNrllYKg76Ym+plzeM9N/y84DknJ3stiTNYOfHz6Xg44xpiO1AaH2E/r+V/lO997hlWncIeCvGbNDNeyldRwHpYMovmvl7zoexVIT5ODzUiSVjdJJgN96Wl08OQzaS82QrijT+upGRQCEgMneZ1pCtTKOQljqWRg7hmJQDP1/uRfXXCzRuXnThUaxb4CfCfK4gE6FD6GP3dMBsFMN+MJjpqzGG/GxYU7Z6El8HSpIEuALdd1yc9NmBM3rmTpjskzxAYBASUbZS8tR9ewD0ltRgxL6lTakCb68PHhx5XDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Adithya.Balakumar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
Thread-Topic: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
Thread-Index: AQHdAwA8qMvU1l8IBUy43zfJEDocSLZMFT4AgAACsQCAAHxkAIAA09uw
Date: Wed, 24 Jun 2026 09:10:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB110635B2601B887DFEF2DCB27C7ED2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
 <TY3PR01MB11075746DDA24B486D0D524BBC7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <29837d2e-3205-4d02-9b02-f26d86bfc198@siemens.com>
In-Reply-To: <29837d2e-3205-4d02-9b02-f26d86bfc198@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OS3PR01MB6593:EE_
x-ms-office365-filtering-correlation-id: 2c887671-d1d9-4521-b15e-08ded1d07a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|4143699003|6133799003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info: 
 VlReUwj3FlIiLxIPwgOBWF7Eh4tvrFDVT2R0Q9Y7HN9ZBtwG8ZuYaqzY5l0ftKHCSXaeurmo+NNTD9E7U6HdKdVgpQd4vIdrAT5C75BiMjOMN+/hQAC698yibzeUZin/csCT2FMJEweWmZ/5w4RaujqYYgSlc4yrzvV6ZJW0Stfm8J4Ru3m+nNsgz1MpLCZgx6NnmrQT6Fkbb33xHKNBVmoTov3YB/QOyOjiB/AfVuYnh3SHWYj31rL0FDuCJ1zxEMNDwIDhX31XyriSpq9OoRC0p8J4dqPSm3nmgEGL5qmK//dMvjvynruiHqilJss6JyIVq83F6KPa5pnRMjE0bHvZRc7HredEJo359uNPmgtpjUmuCxYvA5lcYGv+wgVhmE5Td5FYAM502M7RyBzE3T11j/GG0yOy9Jb430aTB9NgkFJr9c8NztUtEbooaufLuAFJ6d+GOrVzGOyuXP35ZdSPRoqtmlAPt2zSKonT1TgMzeVkqmBG1cq6JVZi0jLy6ELMQUvzXMSH72GCd6PbwBIc5AC0tkhhSMs+k62vfBsf4tkcQvOPUPiaic8UYuYNC1RrxQFR6LPq31402wT1j/4HJRgNdODg2rKFcWVJkDi8TF2wMBfIK1NCk0FjFRn/c+gua99H10pJNT5N06daXxr3pScGf/vGUK3/nltYrdPNLKjkLw/XZyHM7pts7XRyt4/3/ZhAXDyzzhpewl74syx2qiZomxldFyGAEdYKkgQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N3NCWDNuUUtEOVQzZHcxMDNmR01pbFBYc3VHalJhUFhFNEdjQU5ybXErRFJ5?=
 =?utf-8?B?MmhmV0xuMGo4ay9xWW5tRCtyaE1QemI5WCtaNzFidEsyVERPYTZlTFN5U3hM?=
 =?utf-8?B?ckgzU1RiZUNpTFVhVnI4S0h4UzZ3RXlZYlUwaExnUXM4dkVTTVE5TVZsbGdi?=
 =?utf-8?B?Z3hsbnNzN3l5Vm5Ed3AxdUhrejJMdVFWZ0F2WG1NaGNod3U4RWN3M2JpOHF0?=
 =?utf-8?B?ZEtqaTNFaS9SeXhVTmZrYzI3cVhKU2ZOUW1hN2d3QXBUb09OZmRMT3A3SFRi?=
 =?utf-8?B?SGVHRUhFUmhqSDZnWE1oVUtWSld6VWJaVTg3RVFpQzdQazRvQ1F3ZE5uNURG?=
 =?utf-8?B?SUV2SHd6NnBCa2s3LzNTK043K3NqUzlxRFJGa0h0ZVVkZWZQMDY0RUpublRm?=
 =?utf-8?B?NFhFMXd1TzcwWmlqUUlSNEJTMkw4emkxTkRCVEtsQ2pHMGNqSmFNY2xob0lX?=
 =?utf-8?B?WmliVUt1RzRVVnhNNExob05tbi9oT0c5NjBWR3Z6cDdiSS9HYjJHem1uS1Nt?=
 =?utf-8?B?WXZjbU00NUMwQlp0YkpXaWxTNTdJT2pNd2lKWnhOWkN3Ymh4TGNlYzdpQ05q?=
 =?utf-8?B?UnErTnVFeEUxTWxVa0MxTUl1MnBvTjczN1FKK0c2VzNWU0tYRVZaRW4xQm5D?=
 =?utf-8?B?bGVWNVZXa3ZwakJva1U1UzJKQ0hQa0pnNHdTTEczWEdPZEJuUUZTc2FGTGRE?=
 =?utf-8?B?VFZlK1NYenVZM0Z1YTlZQ2pxQWRWM0Vka0Yva2YrOHZxTURTT1RoWkxnYW85?=
 =?utf-8?B?bG5QbXpoUGRIRExJQWE1NHpZcFRmZURzMGpTNDRBbHJQNFRqZjlaYnc2ZGR5?=
 =?utf-8?B?V3FOb3FHdG5FU1RYVXFGaWdJa2s5N0l5ZllXNDdST2o3TTJrenBwY0F1YVAw?=
 =?utf-8?B?VGlmaU5oMXJDRFg0cGNtQjl5bFJ5eE5XUnZES0N5ckNsNlBpV1FlcGd1anFa?=
 =?utf-8?B?ckIxdEdLMytJblBEeXJRa0NST2tuaDRaUjJUdnc5bnNIM054V3QwUndFb1d2?=
 =?utf-8?B?TGMzU2FoenlkTHlwQWVPNkNnTWJ2a2NHTTByaUhnNjUwaGhTc21lNmdTNnBn?=
 =?utf-8?B?bG5SSVRyRjRTcUpnMEIrMkEyLy81Q0swdUFKekxQcWFna1JDU1RtTVErUmNL?=
 =?utf-8?B?Slo2WUM1dEk5czRRM05RSDhJUDVQTnJKYmV4ek5JeDhGVHVMRFJSZko5d05r?=
 =?utf-8?B?SHAySk53RnQxQWt6TUpRcGpwbk1GVURMT21TTSt1YnQzVzA2MXhGSjh5azBR?=
 =?utf-8?B?WFhBSlBaZGtmdjE0N05XSG11UHBIeCtHaXZ3U084OUlkMUtDWVc0Z3pyd0JX?=
 =?utf-8?B?cUozazQxckVQNFZYWEc0czd6Q2lxR21YQkNHcFhlZ1g3ZTZvZExWSmVESDNr?=
 =?utf-8?B?eVA0RjlCcFNabkZueUJkN01velIxd29mWElVKzFmc3k4WDZTY0QreSt6Mmdr?=
 =?utf-8?B?andDVC8zU1h0aWxWYW5nSUFNaEt4N3R0ejMrckdCdWhWYlUycWkzM0QzbmtN?=
 =?utf-8?B?R3FwV0s3cXdqRWlaNVRqUHI1SmhOZjQ5c1FkS013bW9HR1dTT0FTVWNyczQ1?=
 =?utf-8?B?elhXbncvMzRxcGFmSHlqM0NxZ1BJQXpacXhmNWlQVG1aVjM1OFlRaklza1d0?=
 =?utf-8?B?TU5MbE0rRzVEZkQwaU1CQVg5M2NjcUUxS2lXc0ZkQk52T25ZSG1NMlZSRFhD?=
 =?utf-8?B?VlJwV1JoSElMU3BwTXRFTEtCbFc1VDc1MGN5RXlCNVhTNmZNdEQzRHZ5eDBu?=
 =?utf-8?B?ZE5YRExlbVVESmFQd2RSdkxJS013WEVrNTdtVTRNRS9hVXJpS0RtLzgva1k5?=
 =?utf-8?B?NnlVbEQ4clMxSWpiM0xRcG0zTEdkdWl3MmdIU3hjTkdSaFB3OXQ2M0FvL0pm?=
 =?utf-8?B?OWRHcE5tRVkzVURkeFgvZW5iS2dnNUZ3clhTUC90dVBvSS9iUUtEbmpGUFc4?=
 =?utf-8?B?NXJKcTlFdHRBVi9HcHNIdEpEYVJEa2dOeUVUMFhhNlJXbGVZTXJhdHlGNGdG?=
 =?utf-8?B?dTRoNnhGZHBlMkZ2OUN0bUpja0NKa05Ba2RIL3VUdGNWejROU2lKSUg1VEx4?=
 =?utf-8?B?YnFsRHl3SmVCTGlNVVdubkJ6UXVOR0toNDJkTzdkYk5LTEpBNlJwWU01YlZB?=
 =?utf-8?B?U0wvSURiN3E1Q0NNSkErdGdDc1dGaUowbTJBR0RMSCtYenNwWTY0M1VRRFA5?=
 =?utf-8?B?akw0eVRYYVpCTVhQQjRIemVLZW80amg4UFcrQ1FMdnRhTml1aFN4MUtSTU84?=
 =?utf-8?B?TXB1a0RQaFlGYUJBWHB2bzRhSHRQNmdiQTQzL3VaclZOUmZOR0xCRGMzeVJ0?=
 =?utf-8?B?SlRCOXZLNERCelR6R3pXblB3NFRIL21GaDhUd0JJaEdxZit4T1RuenVTcDhn?=
 =?utf-8?Q?Pq6MAiHOjLoKRIEs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Hq9iF4ZdYuHNvkMzySnk3O8LZfmcua/rRgzDTmSf0DvWlwNve1OUUt0Nhw9ftaj5i9EM2+DQOUd9NeT5jYwof+4sVLFCHt3gu10s5drM3mMPefQjHJKQ/v4cPsp2u5LLOA4lQLyN+fVSP+dqOuOZ2oetzL0GocameVkf+Oi/R+1+mdEDjfoJgX1oV28qjPXh1zXTtUsHzXYa0wkoqArlklQ2VlP1tgin4RB99sMPZ/uvjEqODs/pog88Qysa6Bb3OzRnV4XqAVSY6s9LQIDAZwuslkJTMfj5unYdvNbJqxz2HkxmL4xeBNhG3MT4v0i56eDpCSqU1CECZ6FkNs4t0g==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c887671-d1d9-4521-b15e-08ded1d07a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:10:46.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+37ATMDGNsqBTQUN18qdWXyIZbecMrqN78WmnJKLfN17bvwXEvlWAus7HR4HNKVDnrEyOn++TWCewNfxbSy2XrgbE+C0YD/u+vrulPdR5Rrps4E8tCEs0Emgv5Y9596
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6593
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jun 2026 09:11:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23276

SGkgSmFuLCANCg0KPiBpdCBpcyBhIHByb3RlY3RlZCBvbmUsIGFuZCB0aGF0IGxpa2VseSBwcmV2
ZW50ZWQgdGhhdCB5b3UgY291bGQgZGVmaW5lIHRoaXMuIA0KDQpSaWdodCwgaXQgbWFrZXMgc2Vu
c2UuIA0KDQpUaGFuayB5b3UsIEkgY29uZmlybWVkIHRoZSBuZXcgc2NoZWR1bGVkIHBpcGVsaW5l
IGlzIGNyZWF0ZWQgZm9yICJuZXh0IiBicmFuY2guDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZh
bmFuZCBLDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IDI0IEp1bmUgMjAyNiAwMTo0Ng0KVG86IGt1
bmlqYWRhciBzaGl2YW5hbmQo77y077yz77yp77ywIERJVENfRElULU9TVCkgPFNoaXZhbmFuZC5L
dW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
DQpDYzogYmFsYWt1bWFyIGFkaXRoeWEo77y077yz77yp77ywIO+8pO+8qe+8tO+8o++8v++8pO+8
qe+8tC3vvK/vvLPvvLQpIDxBZGl0aHlhLkJhbGFrdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgZGlu
ZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGli
YS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPi
l4vvvKPvvLDvvLQpIDxrYXp1aGlyby5oYXlhc2hpLmY3NEBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0
OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIIHY0IDAvM10gRW5hYmxlIERlYmlhbiBTaWQgc3Vw
cG9ydA0KDQpPbiAyMy4wNi4yNiAxNTowMSwgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRz
aXAuY29tIHdyb3RlOg0KPiBIaSBKYW4sDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBtaW5vciBj
aGFuZ2VzLiANCj4gDQo+IEkgaGF2ZSBvbmUgcmVxdWVzdCwgdGhlIHNjaGVkdWxlZCBwaXBlbGlu
ZSAiV2Vla2x5IERlYmlhbiBTaWQgYnVpbGQgJiB0ZXN0cyIgaGVyZSBodHRwczovL2dpdGxhYi5j
b20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL3BpcGVsaW5lX3NjaGVkdWxl
cyB3YXMgdXNlZCBmb3IgdGVzdGluZywgYnV0IEknbSB1bmFibGUgdG8gY2hhbmdlIHRoZSBicmFu
Y2ggdG8gIm5leHQiIGR1ZSB0byB0aGUgYmVsb3cgZXJyb3IuIA0KPiANCj4gIlRoZSBjdXJyZW50
IHVzZXIgaXMgbm90IGF1dGhvcml6ZWQgdG8gdXBkYXRlIHRoZSBwaXBlbGluZSBzY2hlZHVsZSIg
DQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGNyZWF0ZSBuZXcgc2NoZWR1bGVkIHBpcGVsaW5lIHVz
aW5nICJuZXh0IiBicmFuY2ggd2l0aCBzYW1lIG9wdGlvbnMgKGlmIGludGVydmFsICYgdGltZSB6
b25lIGFyZSBmaW5lKT8gDQo+IE1ha2Ugc3VyZSB0byBkZWZpbmUgQ0kgdmFyaWFibGUgIkNJX1JV
Tl9VTlNUQUJMRV9TSUQiIGluIHRoaXMgcGlwZWxpbmUuIA0KPiANCg0KSSd2ZSB0YWtlbiBvd25l
cnNoaXAgb2YgeW91ciBzY2hlZHVsZSBhbmQgd2FzIGFibGUgdG8gcG9pbnQgaXQgdG8gdGhlIG5l
eHQgYnJhbmNoIC0gaXQgaXMgYSBwcm90ZWN0ZWQgb25lLCBhbmQgdGhhdCBsaWtlbHkgcHJldmVu
dGVkIHRoYXQgeW91IGNvdWxkIGRlZmluZSB0aGlzDQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywg
Rm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K


