Return-Path: <SRS0=wc1v=E7=lists.cip-project.org=bounce+64572+5868+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD258C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:48:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC4206E0
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TRqkacDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC4206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5868+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kWJaYY4521723xBp34wjX0jj; Tue, 24 Nov 2020 22:48:31 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.3401.1606286908606422218
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 22:48:30 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0AP6mL1E022100; Wed, 25 Nov 2020 15:48:21 +0900
X-Iguazu-Qid: 2wHHV20KQ98Up8KpXt
X-Iguazu-QSIG: v=2; s=0; t=1606286901; q=2wHHV20KQ98Up8KpXt; m=4S2OL1OS73ssgrfgXJbKtM0nh3gpwkVDHbEUb0ahbu8=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 0AP6mJUP007185;
	Wed, 25 Nov 2020 15:48:20 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0AP6mJ9t028716;
	Wed, 25 Nov 2020 15:48:19 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0AP6mJwB020399;
	Wed, 25 Nov 2020 15:48:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKo048av0kjpluQ4m/xElY0hCUjF8V8aJmiXuP4TEYzrufxHYnrF7qEVumdAMooegwZ/Lh21y5qVScBBGTgUaXY5PL7Wi2DCz/DJ0Ah/WuEXvureTMnWf6bKlbh/lk8E82bZXrf93FQtRJL0sZR5Jg3Fm92s2MCH9Jm2Hvw5qsrKQSzIpwDSGFD3kHT+JEKo4QSulDdanHmhHL5J1qcHpuWtcojxzXjO20mLw6SBSkNaM4TvbfXL/Qb1BqMy2uwzKJZYW+xj4zecSAt0s1MSgXyyAxIhpv5XkkjIGPsNY7q6vZ0PVzLQMXR97gtumvIoDdVd+iZe0gZVw3M09L+Lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyQ4zURE4SpWwdSq3ru+GTADZyp4UDW6FV2dX2peA5c=;
 b=Bwm1f5tFEdBCZqOgyH/+RwhjvA3Hlu970MaPsgFOjzSEAjeQqeNV27Dh+jG+uGYb2WwAl7mDt0qj8vofH9Ui1aNauoSWew2k0H0mWXZH85Y+7wjTpfD23ojF07kB8faNRg3QAtrJZAd3oZdVfX9H5Fpm+EZ/43+Nbr8M3MJdj6ZzbEFNRLWNo3zlvWTtvO7NYVa8tQXlQm9UQdXgg/3oWBacJSEpAPs1JeEuwSZNGGjz0+o84KtL224nZjh+HWm4yLIPOOOQwcp4kZkLO186YP15ZQIaQlXK6sBoPsO2WgL4wFLV057KE6NHHxNCQfO3/0EhzInM4XDNn1Qp5cxPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Topic: [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Index: AQHWwouNS/RQVgyoSEOfc8RBzPlWAKnXsLMAgAC1DDA=
Date: Wed, 25 Nov 2020 06:48:11 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29836A77BD78A934014C517992FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201124194918.GB4916@amd>
In-Reply-To: <20201124194918.GB4916@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab069e5-918a-494d-eb1d-08d8910e1393
x-ms-traffictypediagnostic: OSAPR01MB1841:
x-microsoft-antispam-prvs: <OSAPR01MB18418FC0959B001CFCE7AF9B92FA0@OSAPR01MB1841.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kQGcQl72t9tnHegDuICZdpLx1oQlWFhjNG62RFHLP6E6hoze2GHR2MRkBF+19yBUqVHbsejwxxDF0//1ggvKYEsdQSkIxG40XEqaWd01PYy5U7WDpGOaNZ7SkYisxFPkQdSdd652N9S733tv9MV2rZqvSAn69tHquJ7AxGsT1M1EtrebvhlvcHjDCaMm5TcSkpqVZEudMqDVh53oKI+rnXj+t01pMhvV+JBLvb+b5hlJVKk3y7Up+jpmf+4f6+V/WaDNJxnhIwOXhA2DHO4GDhWFYUNOQOyw7PWRDDCWuaHjl3+A96DCJjAROSS65cXVnPP0iTE0zSS2UfdVrVzUSw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlVtNTlhRzFtbkVqRlYxRUlHWCtJL1QyNHJHR3ZwOGtDZzdtYkhGblA4R040?=
 =?utf-8?B?d2NodUZCc2FITkZBWlpXM2NoRFFmeFN3bjVMdnBYaFhSUnRxdXNpSzRlNHds?=
 =?utf-8?B?K1NYemdhaUNLSTJsOUZrQlhodVZDbUFUSUdKeHZhOHkvWFJaV2M0TmZ4SURz?=
 =?utf-8?B?a211dUdrNm9NY3RaekQzMEZ5VXZYd25hekdTd1JyVy9pYmtVU1V4QXFqZUo4?=
 =?utf-8?B?RHFHZFVXbE84RzlOOVFXUGU1ZUQwVXV5SWFIOXg1b0FicHlxcTVtbFhCNExN?=
 =?utf-8?B?djRsb2xWQ0lyZHpaMDdxbHZZMFdRSGtmYUp2RGtacUMveVhpTGQ5NGdTV3I4?=
 =?utf-8?B?OS96WFBad3ZudDZ1aUpRNU9MNHRXYlBTNThwUGM2KzhDdzYzR0x6S2dEQ1JP?=
 =?utf-8?B?ZTg4N3kwcXUvUCtLMmw1SFFRaUNmWEFNaWN6WG9ONE1Gc2JadEVBTUxYeXRP?=
 =?utf-8?B?dk9FT1JpRXdiK1JZc243eWw4dTVtUENGYnVjalpyelJCMm5YejV5VlFiRGpz?=
 =?utf-8?B?djNBRnREblNOdm1LWXRrUEpETGZNb2h4dHJCYy9yS1VtVkYzWUJaQzR4LzV3?=
 =?utf-8?B?SVlieXVvWW9sclk0NGxNM093MXI5TW14MkVjdEoxdjg2QjQ3VExZaDFaMkJG?=
 =?utf-8?B?MXducTNPRTdYRDdaMTBJTzl3QTZGa1dMYTlWbWZYTEw1cjZQTHVabXMyUERi?=
 =?utf-8?B?dGRyaWJHcnptK1VEQ05NQ3pXTk91Qlg1YzRUQ2pUQ2d5cjR6TldiUmVIQjc5?=
 =?utf-8?B?MjZzWGVFWlBjOEVJSTZIZ1U0cDhFWjNSemZwelpCNEdqczJTNzdMZkVWS3NL?=
 =?utf-8?B?SURFUDdlN0hlWFlyZ3AyOVFnSUx1Qy94c3oxUExFNUJoU0JpY2hocHR6cEpW?=
 =?utf-8?B?di9mMjNIaG82QzZxRkx3SE5nT1UvbytPYVpDaEIvS0RPL1FCaDgxVXNiaGVW?=
 =?utf-8?B?VGwwZ0xoNWk0cm9CcVFOZDJkdXBWTjFVd1hyZTE0VEtIR2JTZXU1cmgxVzZy?=
 =?utf-8?B?STZOZ1o3WXNERVN2bjdpUGU2ZDNMVWQ5YVRncTM3RWY4bC9PczNRdHFJUE41?=
 =?utf-8?B?ZlU2NGtVWUdrbks5eUExdGlzTjNwbUM4bVhKMDV2aTdncytxUGVETGZ6Rmoz?=
 =?utf-8?B?S3NVTG51a00zL3NpTm9MbFBGMGtzeUR6TGpLMWwza2IwOStNMnpYM3hLNC9x?=
 =?utf-8?B?Q1VhSUJtb2JYZ20zNmdYR3E0anlOUEZTaXkwVStXaDBnaVBxMkV1OWw5NmRw?=
 =?utf-8?B?ZzBrOWNXOFhzdHViUkwyNkRmQWZJMlozUWVSY01GVm0ycjBhZnJwY2IyNFpV?=
 =?utf-8?Q?Zcz9ipFDA+k6o=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab069e5-918a-494d-eb1d-08d8910e1393
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:48:11.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V+IV9L7b7h9yqaDUa4cRa9B/YZ4keKyWBrhO9RsG+GarGkqDp1+cngshcbxJF5NBiscDOoXD003i5CdSWerv6US3xnwYDZHKFk3UMazKwGeWtC/+EE8T9sGq97bCsuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1841
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WT6g7t7UW8UdGswS97qhyX3Rx4520388AA=
Content-Type: multipart/mixed; boundary="sv0b1fry0X6Uk2xNvcYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606286911;
 bh=9+O9WZwj4XoFjzbTxectBZO39wMM0nUsHV0c492GWOM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=TRqkacDkojOxZEyVBbHkrYl0OS23HxKy81+vRRhTSc4dGWOLrPynH2sIwPcs9J9xCCc
 sKYs6hcvJAfzM11DZUb2LEXvV3/TMk3aeR7fWzzOOW9nbntv/H4WCw1lEE2hPXTJ4ZTFv
 XysR3UKFHvxBssbQTV82Vi3NiC6s4MuD72Y=

--sv0b1fry0X6Uk2xNvcYm
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNSwg
MjAyMCA0OjQ5IEFNDQo+IFRvOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQp
DQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2
ZWxAZGVueC5kZT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiA0LjE5LnktY2lwIDAvN10gQWRkIFJQQy1JRiBkcml2ZXIgZm9y
IFJaL0cyeCBTb0Mncw0KPiANCj4gSGkhDQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMg
U1BJIGRyaXZlciBmb3IgdGhlIFJlbmVzYXMgUlBDLUlGLg0KPiA+IEFsb25nc2lkZSByZWxldmFu
dCBjaGFuZ2VzIGZvciBzcGktbWVtIGhhdmUgYmVlbiBhbHNvDQo+ID4gYmFja3BvcnRlZC4gVGhp
cyBlbmFibGVzIGFjY2Vzc2luZyBTUEkgZmxhc2ggY2hpcCBjb25uZWN0ZWQNCj4gPiB0byBSUEMt
SUYgb24gUlovRzJ4IGJvYXJkcy4NCj4gPg0KPiA+IFdlIGN1cnJlbnRseSBvbmx5IGFpbSB0byBi
YWNrcG9ydCBqdXN0IHRoZSBkcml2ZXIgaGVuY2UgdGhlcmUNCj4gPiBhcmUgbm8gY2hhbmdlcyB0
byBkdHMvaSBmaWxlcy4gVGhlIGRyaXZlciBoYXMgYmVlbiB0ZXN0ZWQgb24NCj4gPiBSWi9HMntF
TX0gd2l0aCBhbGwgdGhlIHJlcXVpcmVkIGR0cy9pIGNoYW5nZXMgWzFdLg0KPiANCj4gT2theSwg
dGhhdCB3YXMgcXVpY2suDQo+IA0KPiBXaGF0IGlzIHlvdXIgcGxhbiwgbWVyZ2UgZHRzIGNoYW5n
ZXMgc29vbj8gT3IgaXMgdGhlIGRyaXZlciB1c2VmdWwNCj4gZXZlbiB3aXRob3V0IHRoZSBkdHMg
Y2hhbmdlcz8NCj4gDQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gKiBQYXRjaGVzIHsxLCAzLCA0
fS83IHVuY2hhbmdlZA0KPiA+ICogUGF0Y2ggMi83DQo+ID4gICAgKiBGaXhlZCByZWZlcmVuY2Ug
bGVhayBmb3IgT0Ygbm9kZSBpbiBycGNpZl9wcm9iZSgpDQo+ID4gICAgKiBGaXhlZCBvdmVyd3Jp
dGluZyByZXR1cm4gdmFsdWUgaW4gZXJyb3IgcGF0aCBvZiBycGNpZl9tYW51YWxfeGZlcigpDQo+
ID4gICAgKiBSZXBsYWNlZCBDKysgc3R5bGUgY29tbWVudCB3aXRoIEMgc3R5bGUNCj4gPiAgICAq
IFJlcGxhY2VkIHRhYiB3aXRoIGEgc3BhY2UgYmV0d2VlbiBzdHJ1Y3QgYW5kIHN0cnVjdCBuYW1l
DQo+ID4gICAgKiBGaXhlZCBhIHR5cG8gaW4gY29tbWl0IG1lc3NhZ2UgKHMvYWJzcmFjdC9hYnN0
cmFjdCkNCj4gPiAqIFBhdGNoIDUvNw0KPiA+ICAgICogRml4ZWQgcmVmZXJlbmNlIGxlYWsgaW4g
c3BpX21lbV9hY2Nlc3Nfc3RhcnQgZm9yIFBNDQo+ID4gKiBQYXRjaCA2LzcNCj4gPiAgICAqIFJl
dHVybiBlYXJseSBpbiBzcGlfbWVtX2Rpcm1hcF9kaXJtYXBfe3JlYWQvd3JpdGV9DQo+ID4gKiBQ
YXRjaCA3LzcNCj4gPiAgICAqIFJlcGxhY2VkIEMrKyBzdHlsZSBjb21tZW50IHdpdGggQyBzdHls
ZQ0KPiA+ICAgICogVXNlZCBfX21heWJlX3VudXNlZCBmb3IgcnBjaWZfc3BpX3tzdXNwZW5kLHJl
c3VtZX0gYW5kIGRyb3BwZWQNCj4gPiAgICAgIENPTkZJR19QTV9TTEVFUCBpZmRlZiBjaGVja3MN
Cj4gPiAgICAqIEVsYWJvcmF0ZWQgdGhlIGRlc2NyaXB0aW9uIGZvciBTUElfUlBDSUYgY29uZmln
DQo+ID4gICAgKiBEcm9wcGVkIHRoZSBsYWJlbCBlcnJfcHV0X2N0bHIgZnJvbSBycGNfc3BpX3By
b2JlKCkNCj4gDQoNCkkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtcyB3aXRoIHRoaXMgc2VyaWVzLg0K
DQo+IFRoYW5rcyBmb3IgdGhlIGNoYW5nZXM7IHRoZXkgYXJlIHByb2JhYmx5IGdvb2QgKEkgaGF2
ZSB5ZXQgdG8gdGFrZQ0KPiBjbG9zZSBsb29rKSwgYnV0IEkgd29uZGVyIGlmIHdlIHNob3VsZCB3
YWl0IHVudGlsIHRoZXkgaGl0IG5leHQgb3INCj4gbWFpbmxpbmU/IElmIHVwc3RyZWFtIG1haW50
YWluZXIgZGlzYWdyZWVzLCB3ZSB3b3VsZCBnZXQgZGl2ZXJnZW5jZS4uLg0KDQpUaGVzZSBwYXRj
aCBzZXJpZXMgY29udGFpbiBmaXhlcyBmb3IgaXNzdWVzIGluIHRoZSBwYXRjaCBpdHNlbGYsIHNv
IHdlIG5lZWQgdG8NCnNlcGFyYXRlIHRoZW0gYW5kIHBvc3QgdGhlbSBtYWlubGluZSBvciBzdWJz
eXN0ZW0gdHJlZS4NClNvIEkgdGhpbmsgd2UgaGF2ZSB0byB3YWl0IGZvciB0aG9zZSBwYXRjaGVz
IHRvIGJlIG1lcmdlZC4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--sv0b1fry0X6Uk2xNvcYm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5868): https://lists.cip-project.org/g/cip-dev/message=
/5868
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sv0b1fry0X6Uk2xNvcYm--
