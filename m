Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16718.1792648643929822265
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2026 22:57:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=K0Tnwds2;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1792648635;x=1793858235;bh=/+czNN4rLfyk5VKR7pFoyUSRe67eD0nkULMaz
	cpTAYo=;b=K0Tnwds2OKimVlbEOuF9O1yd33BSusu+RZr7gGQ8+TArwkD66yzqEAd4jFBeGrtdxRV
	ZKxGHFs6Hf9LqSchUG2CdlOfx+o7SQfoQeP1600WvN3Bcm8l0FBOvTjTX/VzVFyncYZL7LI3JkeC4
	Zri0csdrkyoLMNZMssVGsNx3IHVqeWoC3x8fBOGIDsynCxGZ8pDt0s+nwV2Fen40954cWb7w6y+/L
	rZP6SnR4u+D2G1XHie+W8m8QSAy3qLcmAEYQftoQmTMdv32+bJUcWHmuR/qJ7T5F8Bwe4xaPViexw
	l+OEbKJCHIUpokpV1bx3M+33Ci1oeBNq2lb6fTy5TmqQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69M5vFAN109619; Thu, 22 Oct 2026 14:57:15 +0900
X-Iguazu-Qid: 2yAaCwNmAY6abB8Laj
X-Iguazu-QSIG: v=2; s=1; t=1792648634; q=2yAaCwNmAY6abB8Laj; m=WqqOWKSNlrNEnhzPhI7Qv/8JUa9G5M2NZMfOHEWjQiE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j9FmB0MF3z1xnZ; Thu, 22 Oct 2026 14:57:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXS4k5zX+JEjxk28RFkku2TUmjpUpBKR/WdxwTwx91we0BR37pnWwg2tc4BxkV2DRi79c155axNorwl3IBV/Ye0TZZ1nk/km96YcOmIgoGLUXEyuiLtAdUyXXnaAiTGa0cwFNGd5/07nK8FQA58wVo5S2l7TYlob6j5xzP9Hh+dZIwqbPYr7OsKkxHGvJKtex0R/kD9QFJf+e2aX8UWP6DGeH6ca/7pAKZKs7DsEHZ9XxkDaVylZC4WT8gYzSGHiEZyi3jw73Pwnlv/1fSK1KNP42uzAD923ucDp2QKgtbOQ1KV8qSAycNKRYCGHPggh1XQihZ2v/edhYU3XgVkjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+czNN4rLfyk5VKR7pFoyUSRe67eD0nkULMazcpTAYo=;
 b=CIWZoZG+8cKqjqbwSMI57nlymTiqD0CCV0R0uevFTBrbMOBktEoP6wWBVjrI4y7OTmuV3+0lzspB650U3visDgtUpKFcWy8Y4OnPuiJoOS+yg6lsue1f4ul8IIqJjERtAZSnlJvBjWu85tPzZl26dbEQE6co64T2UIFfU/VlBWw4yD8cQ8lL+8ejFSly539QgYGq5MuNKKfnACKKJfJ12IQ3VqQKAlD7spGa5ROIUDJoxjtTlwYtibMCjC0h35M9nzq41A4NC2PVaCF2p8fyzYiZXNxDj4x6S435I/G9guxwN5tBHlDVcAYuhp8ESV25Gq0wqKke5R0XfxdkzKSftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <uli@fpond.eu>, <pavel@nabladev.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
Thread-Topic: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
Thread-Index: AQHdSYo5K25Fl8ZA1U2zi6IQkLwqPrcGA6eAgAM8PSA=
Date: Thu, 22 Oct 2026 05:57:11 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818A01246D77659CC94005FCD652@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
 <e5bf8a6c-2617-4da6-91bd-1c256e06e2b5@siemens.com>
In-Reply-To: <e5bf8a6c-2617-4da6-91bd-1c256e06e2b5@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB7191:EE_
x-ms-office365-filtering-correlation-id: ad36d6d3-da0c-4a49-9356-08df300150d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: qQeOsu7Yx2dYedM9YBxAR7cEY+v/dXqk7tDrDO87kBiR1ycF893BkFsvWWdzp9+29OvzyxzsxgpURowRbJktNbKSJiS1gcGU+vdPVtJp8hrK81/6RTfnMafkJuvizbZSKiONFwEAJoWd7t6bLfp5Ib92RHiC2syzcAosX5wTmak/cXboAbpBJBf1AQJvlfrghPwiiI4nDKAydV9XxuhBI8RrcON1fXWFOrrLZTZxa5LWttM0Pue4XmLx7739OQjGMhxmjxo9J8GIrZ1aopODp93mfbR7E6ckQ0MOAVigJ4EvFY7rrArS72UR1Xmv6iTgRYr5ZZt6k1aY2eFju3H4PC756dCjwk8dTJIwTzR+/eJZr/je0o/gFJMuRurCsE2bfR5rZcmxQKQx5GOBlhNEWUh6MZqE82K2xqNioE1l2qVGdEZdT4IBWyTdJB/2mtN30AZY7Mbd3MG1gPmT57fNBg/zAXAPaD+vMwijFxMUg2kGsb6vM3qHdWHCfgRIUFKQ9srxfKz7UCJOMZb4G9JSvEMYWnHyQNjAg/U+KWK9vlOkkf1ktOBVdACvnp8kou+Qwt3ihD9ER3m1fhSMM5A/lsBXXBfzwSxSkfnNogtgtKwQSwlqpkrn8Uhle53e06LArpyt8uupQWxzI2i8AvmKZYzl2fuAoROipgBExWXcVvhvQopgYSTxXSBxPCbsxmXqZfV6PK7xFQhXu7Cv+K3Kjl5ZF7F8kyHppJxeH3bwU5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJHQzRXWXBMQkZoWXpsTUpVU1pyYXJhcEVZVzBDU0ZKYnU1TE12dm9WZlNU?=
 =?utf-8?B?bHEySnlKc0doV010Wkt0U3hDOEpRSCswODFLdnhLVWJ6ejN4cDNhdXlCVUlP?=
 =?utf-8?B?bWRTTm1WUXhQQXp0V1NjczFrZ1huY3AydFdJK3RPTElZeWdtRkI0K2c1OWdP?=
 =?utf-8?B?VUVhakJnbkRQbm1hcUoxKzlJcDUzaTdVd1hJcGpQeWVOUG56OFNRa1ZSaWN4?=
 =?utf-8?B?VWlFc0hGTmw0NG1YTHpZQ1pZREZrY09wOWlQbDY3VXM4Z2lDdmNVTy9mVysz?=
 =?utf-8?B?VkhpOGRreENxUzI4dFIvd1huekswRHh3RUkzVElFVktWNjhWSDR4eDZKT2Uw?=
 =?utf-8?B?UnhvZkp3L0NkM3ovRjU5RnJ1K1VuY2J6RXV2N1cxclAwUSs2Q3lpODZEU0o4?=
 =?utf-8?B?d2cvWUNLOWVvQzFWWitvVGRoZXBoWHFRNGRTMklkd2dWRlliUUFIaGtVRnBa?=
 =?utf-8?B?ejhIbTBNMllLVUgyUzB1SzVnZ2dsOE03NWxUbDhRaHFKQ00yM2NRSUYrVEtJ?=
 =?utf-8?B?WlpnT1VKc25xa25jN3BpNFlvektMTS9pVzBTZXVTSHpVTGtCSkxpU3BKVmVT?=
 =?utf-8?B?M0FCRFFtYnppazY4c2x6bllMdGdJK2FUL2xWSFRWRzNIY1lvNmNkODRtS3lU?=
 =?utf-8?B?UFlISDdCcFNhV0RpcGxGU1JZZ2QvbzAyQzBYc2orUklYQUM5dWRiVUswMW1F?=
 =?utf-8?B?aVZPUGRBemJMR0lLUzJCZUJ3UUZZTFBSMnRzL0ZPbHRhbUlFSWttYStLVC8x?=
 =?utf-8?B?WncyZU50K0JTakZtOXBLSWFKQ2NhNlcrRk1IT1VRYTZ3NThGQUZ1SVNxMHhq?=
 =?utf-8?B?RkVHTEo2R25DNXkvWFlCS0tmOXBkYWVNMko3b0l5VjBWSFZ4dmFPYWgwM1lw?=
 =?utf-8?B?VGFkM1Y1RzRjbG5TN3JxK1BNVy8wYjVOQ09Md0hKTmt5RzNUdmQzMFByN0sr?=
 =?utf-8?B?ZlBkTEx6WVpvV242dDVxYS9JcjFtLzd4QzZkdTlaamxxT1hPYXdFQ0dnMFc1?=
 =?utf-8?B?c0hhSCtpeXFPaWdCN2NnR0NBLzNZWWVIck5qUmZXNmpjQ0JnNHZJdmNFYWE1?=
 =?utf-8?B?b2NPVGdyaGoxcTd6QVIvMXpTNC9hVlN1L3dKcWhRcmlQTkRRV080c3NVK0pr?=
 =?utf-8?B?S3V1LzNUbExaS0tsVGdUemtFZjc2OFdxZHRNQ05Wc3pKUy9TdEVaeno2NHhQ?=
 =?utf-8?B?T1dOdU5ETXdHOXpiSHAxWEpQakM3NnNMZHVTTGlDdlg5QnpZYm5TaXl0RWZX?=
 =?utf-8?B?MzBGUXI4WUEwZXBweWR6NzhpRkFjU3ZEbGdrTXpZR1F6ZkZZbEwrd0VqMDJi?=
 =?utf-8?B?U2h4VnhucUVoajJ2aTRxVzI1d210U3M5WmpoQ1E2Rm9BM2xhVThjTkticER2?=
 =?utf-8?B?UlhOYldBRUhrZFVtUEJDT0ljNVd5Rmt2ZTBLVkIwV3IyOUJRTlllcmRWcGV3?=
 =?utf-8?B?ME1kMVJjdWNBYjEzR2p5RktZOHBZcExEam5FY2ZnNitJM1lIZEt0aE8rVUwy?=
 =?utf-8?B?Z044b0hiaTZpVlcwbWV2VldKVXJtRkxJLzRrTElocTdQcUhsdGNWYllFNnRJ?=
 =?utf-8?B?OEJyZzRHaUludUdsMjNRamc4UjI0WGxKNGtHdGk4am1ma2huMUVLSlRra3dl?=
 =?utf-8?B?Z3ZEME5uRG9qcG15THFvUkRQanJORkJBdG5XZkxwWVpDSkgwQU52UlpUSUlD?=
 =?utf-8?B?T2RGRm9pK2E4TGlZNWZMakZMeVVaendqZUZkOXhyb0pjZzlGSDhkVE9sZkp3?=
 =?utf-8?B?Q1VmU2E4OGVWVVBocWhtNm1UL0dBMGJiRGlJeXUrSXlwOW4wL0VrQnk4L2Fw?=
 =?utf-8?B?K05WQWZJY01pdktKem1FUjdSSUx3dlUyRng0cGdKOVg3STdwcXNyZ3BDTHZL?=
 =?utf-8?B?eUlyaWlhcUVSS1BFN2NyaWI5K3ZLV1hEUmw1TjR4b2Vkd0lwWDlFTWYyL3I2?=
 =?utf-8?B?SHN3T2VwMzZ4NHRudkVSTFlqNENjNkthS1ZqRGc2M2Z0UE5zV1huU254Z0wr?=
 =?utf-8?B?L3g2R3Vib3RubmdmdGY1Z21aT0NJdHFNajdST2NlMmF4UFhxRE1OU0JNeGRR?=
 =?utf-8?B?eUlwaXhuakJmd0F5cERoSDk5dkxrYU5UUzlGWm1Ra3g3aXJYVm1tRnNKdkJK?=
 =?utf-8?B?d3RuQ0ZXL0ZPVVJiRHV4Zy9HblpJczZOOE1WY29sL2xoUHZ0R0d2VzBZOFBz?=
 =?utf-8?B?L1BtY3dSNFVJMThTejNBV3N3UEtXVFdVcFFKOFdOWlA2ejBVTTF5a0RLSHdt?=
 =?utf-8?B?MWh5TnUxbGZHb1VGVzFXcUx4OHlSVnl4aUpKbTF6OUdsSlBXN0sxOXpTQ2Nu?=
 =?utf-8?B?OUM0eFB3bnBTODU1Y1k4V0JQaVVVdTBTbmpwa01TNnlHWnA4azd6a21TL2lD?=
 =?utf-8?Q?CdoHfE2Ivm0qYV3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: az8AMwLfXwGFzKQpiSi5JNoYBBz3W74OFcrD0s+dFaHcOEAq6sw1lH66M68FZcsb5jw9D5GlzsSnqOnT+wckOjW2Pse6ofG3kcTdJW+yGio9ChTCt4uDQH3cXztpzXuzdOJjP7LVCEq955rsmI5NrJP3Fcznn3NYu7SgZYsTriCMpI4JmcF7K8AQcjNZ40mX7N+k4wsJfCeVHS3VSALTH1S3BrqYGdbnqNwn9Eu38WCJmUjHXLsfwiB63vDYOv7fLO2kBAwhZidl2xdgl0tJ5j0/zvEEKimAxTKh1NczJViyzHdgj+zZEyFyPA+Hh9j99YDl/G08Z95nBFCSA0d8sQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36d6d3-da0c-4a49-9356-08df300150d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 05:57:11.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzZ7Q1PhanA4c2ftje+mbDzTjCIhDuwxaSbfph0/MW9Zm7fd9kf8ETNZk18IE+wPZ8OiAv6R5Gf/IPvADiughT0hsns1G1xLsCN1SR+ytrDt1oBLNWFFEGjaq9zxG9BB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7191
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 05:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24507

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjAs
IDIwMjYgMToyOCBQTQ0KPiBUbzogVWxyaWNoIEhlY2h0IDx1bGlAZnBvbmQuZXU+OyBQYXZlbCBN
YWNoZWsgPHBhdmVsQG5hYmxhZGV2LmNvbT47DQo+IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDk
v6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3Uu
eDkwQG1haWwudG9zaGliYT47IGNpcC1kZXYNCj4gPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnPg0KPiBTdWJqZWN0OiBSZTogWzYuMTIueS1jaXBdW1BBVENIIHYyXSBBZGQgU0VDVVJJVFku
bWQgZm9yIHRoZSBDSVAga2VybmVsDQo+IA0KPiBPbiAyMS4wOS4yNiAwNzoyOSwgSmFuIEtpc3pr
YSB3cm90ZToNCj4gPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0K
PiA+DQo+ID4gVGhpcyBkZXNjcmliZXMgYXQgd2hpY2ggdGltZSB3aGljaCBhcmVzIG9mIHRoZSBD
SVAga2VybmVsIGFyZSBoYW5kbGVkDQo+ID4gYnkgdGhlIENJUCBzZWN1cml0eSB0ZWFtIGFuZCBo
b3cgdG8gcmVwb3J0IHZ1bG5lcmFiaWxpdGllcyB0byBpdC4gSXQNCj4gPiBmdXJ0aGVybW9yZSBz
dGF0ZSB0aGUgdGhpcyBwcm9qZWN0cyBmYWxscyB1bmRlciB0aGUgTEYgc3Rld2FyZHNoaXANCj4g
PiBmcmFtZXdvcmsuDQo+ID4NCj4gPiBBcyB0aGUgb3JpZ2luYWwga2VybmVsIGRvY3VtZW50YXRp
b24gYWxyZWFkeSBjb250YWlucyBhIHJlcG9ydGluZw0KPiA+IGd1aWRlLCBsZWF2ZSBhIG5vdGUg
dGhlcmUgd2hpY2ggb25lIGFwcGxpZXMgdG8gQ0lQIGtlcm5lbHMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAgLSBsZWF2ZSBhIG5vdGUgaW4gc2VjdXJpdHktYnVn
cy5yc3QgKHdpbGwgbmVlZCBhZGp1c3RtZW50IGZvciBvbGRlcg0KPiA+ICAgIGtlcm5lbHMpDQo+
ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3NlY3VyaXR5LWJ1Z3MucnN0IHwgIDYgKysr
Kw0KPiA+ICBTRUNVUklUWS5tZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNw0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgU0VDVVJJVFkubWQNCj4gPg0KDQpJIGhh
dmUgcmV2aWV3ZWQgdGhlIGNvbnRlbnQuIFRoZXJlIHdlcmUgbm8gcG9pbnRzIHRvIG5vdGVzLg0K
DQpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBt
YWlsLnRvc2hpYmE+DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

