Return-Path: <SRS0=ZKZl=E7=lists.cip-project.org=bounce+64572+5873+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D1C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:53:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22D120637
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tCIAbnNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22D120637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5873+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4dlUYY4521723xvx7Ni4gk9a; Wed, 25 Nov 2020 00:53:39 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.102])
 by mx.groups.io with SMTP id smtpd.web10.4265.1606294418226186271
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B79L4mTu0/jqvp27JTeslMaR0SufT7U/XzOEkXvOuKsw5jVwli/W5AefTLaColA/w3nm16XbO2/uctpwgiOm/0ZNhrmFrYeysahj36A34LELfTKtjJ+j+F8X1u4CDAftgd8J6SDaaWREH1C0tHwfTq5fqb7uw2IJ4gg8h3wNZyWBkGv4OL9pFOAg9hSOVNG39v4p3wjQEB4cjItzugLwaJ21qCaIS8iUhjxAn8VFgvDNW5Bc77uZnEqrBmUa+uWAPBowynm5pmjZVTYHzKYOqiWQiP6nUZkPxFQQKj3W3A9VFGB0mLbvcYMWrjN8dszHjRR+tCOnt/SskYRYnfXt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj01+cOXg/8MTVuC1xqwhtrFRBVr/SJ1lIM/cemtzRI=;
 b=W1lihBPyw6PSFUwQ6U2qOxOBAxIdEX9q6B5/KMrUNwZEtWmpbpfcroXy32flv2BLFsaA51kvMb6bwCdipscAD+uVV7P/a9o2hZbYYiAHQMN4UnjhJJFlmXmHtFUBu1cIM0l22QCbrMoCCzZQFllCbL74rETsrTvtuExXtoJg2wLYV/432/rMaQD9POazRA6Ye/wvaJO3e8vI5BCVtjaOdi12yFv/cWCKWr3G//G8gfmR0PWCBfurflplSQWStf861j5NeuTR9Up80cnlr//bKFXjLeyOqGEhca9YUX3P01OR/iyL4pIUGBkQmolQyl1Y665PLmWnpOz9TMB9/hZp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5731.jpnprd01.prod.outlook.com (2603:1096:604:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 08:53:35 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Wed, 25 Nov 2020
 08:53:35 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Topic: [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Thread-Index: AQHWwprqAJYvGLScc0eNiEWnfsB2T6nYaKuAgAAiJ6A=
Date: Wed, 25 Nov 2020 08:53:35 +0000
Message-ID: 
 <OSBPR01MB50483461DBA0EBB7755239B0AAFA0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201124194918.GB4916@amd>
 <OSBPR01MB29836A77BD78A934014C517992FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB29836A77BD78A934014C517992FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5d56e89-f9f5-4a45-1a71-08d8911f97f7
x-ms-traffictypediagnostic: OS0PR01MB5731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5731BD92368448B0A509F930AAFA0@OS0PR01MB5731.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 x5ggn7/11EySth7VxaXUVUvpUnheKiZDReGAwlTdrn8eiwwuYw1tk+poUVSFIMC3uw2N+T5cmM8MwA0nQf5qRCmIh+cb6gknXBdIQyDVszgNV4uacn4AJSQ80gCqxYbCucJb4rg3Hz6gk1AXeqOfVZmOKTy1bzkzj3/JoWtuScnzCZEBVPph9+lawbL6hbrf7elx0umhHCBkLNBXMl14zppbas0K9enQijFVKS0NwbsmivXf/x2bPcIjBkmEIc50OXW3NHyJHd2+7KlWCqkjFfxP++ZZhnV+EYzj5f6N6xwprOgXay1ExxQ4vR2Cssc7wP6ZQVGp0Rco79ndmcEGLQ==
x-ms-exchange-antispam-messagedata: 
 Q7IfHF2nIPlGOdqLjsd7d8MvS++wmQvjtfHRkzuSA8vaWi1Prv3blA8bY7a+r9yUsXPzWARx2JlgQ+7kBzYUKzO/A0vusuy13XD2AhPB82TIl5RnESVLs4NWzrFfN9dB2DRdYi6ioxlMHkT73J7gbq9y9Z5AWAi8o5HqLB6+ksq++n2cr2cAaLycLgwzBwWLPuLyJyxULKQ0+pvMCnqRcaT9kql3JQNbAZNLbhFion98m8c+qEvBEy0zi8f5F5NGTMZj+V3pOGUbS4gIzE2T520CDGQO1soeT//1Afe85eION94EqLL9SwaGARNXfRvwRiaKqXalqjaJEqIhW9+fG2On87DUPWiaa18SnWoNNnwwKTx+23H0RH+FAzdcsKhlZa03mjYF3W2eCBaK0nDlany5GcfMc8bApv0Fxz7Rlm1li47sLyxp6EPN/+Uo27nT7g5QipIw2UYr5oVDx+dDuEBKxgszjVczVqzxylrEc+CG3XrH9Bv5ZLZwNdICqHbBvE3nRplRzAHLgaRfPbkKOUxQedilFXvobik9fSFVeAaAXP6oQPuCRjBcmpSa92FfNuJKKR1Uk9/Mn3b9v3Gh7UCVNhBUAx8lZ3qiWr4WWxoIAX6m8r5oQ6xdaRRT5laK+t+sObbBRuBwE5f49QX7sRdJfhLshvUAVLw0MFgYIl7ZB26M7RlqvBDwOW4b9TPCIZR737kqaKknZe1cJiY0HKw+2eueZZMEFukMrEGhbyOEV0ft34mNTG69syiC0JkdQr+HMbf1VXDjEmShFsDAN9sTJCbn7+9yTRLJzDNzpRNPFNblDjhqk0lwIqMH8fYO/X+yd+UrSEKGTXMU/jrF+wzI/1xM/qXVw+7KeExiER01lV4g1dVmiWnsKNJ0NpHX5ATGQZIKjWb2/w/jwtQzIg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d56e89-f9f5-4a45-1a71-08d8911f97f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 08:53:35.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEW7f70koaNMPyy9SEKfwK3x+1o+vrrQXh3mldaG4WjTwUx+t1PQDGGCRLu+JNpF7VM1ZCAY8fld2//eC1d5D+KEfc5tYMxqATA2fomoLByULLwjRM3+yLHCqnEpxivy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5731
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iq2d2AQKHgfsa6Hh4hEkJFu6x4520388AA=
Content-Type: multipart/mixed; boundary="INB8OFVrzIQvdUIYWRKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294419;
 bh=AEAuR9OB4v1CXjfviRtGuPIs93MPSTOEkEYfmfATslo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tCIAbnNeHsqwGfsrR+snJ4mB3ailbcKqsTAuRzHljxmqcgoZba7OgGRQZosy1/Xe+Bl
 pqhpXPWzdEL31G+xJ0YG0GXNp4HOAYCKFx1mP2H4TvJ5bgGQ3YrknvVVRwa5ESXPgj0AU
 V5ahcgN9W4/P6cwo+Ise6D8BaF6ulTYhQFM=

--INB8OFVrzIQvdUIYWRKH
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwPg0KPiBTZW50OiAyNSBOb3ZlbWJlciAyMDIwIDA2OjQ4DQo+IFRvOiBwYXZlbEBkZW54
LmRlOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5y
ZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIg
NC4xOS55LWNpcCAwLzddIEFkZCBSUEMtSUYgZHJpdmVyIGZvciBSWi9HMnggU29DJ3MNCj4gDQo+
IEhpLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhdmVs
IE1hY2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+ID4gU2VudDogV2VkbmVzZGF5LCBOb3Zl
bWJlciAyNSwgMjAyMCA0OjQ5IEFNDQo+ID4gVG86IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiBDYzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj
4pev77yh77yj77y0KQ0KPiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBh
dmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEJpanUgRGFzDQo+IDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDQuMTkueS1jaXAgMC83XSBB
ZGQgUlBDLUlGIGRyaXZlciBmb3IgUlovRzJ4IFNvQydzDQo+ID4NCj4gPiBIaSENCj4gPg0KPiA+
ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBTUEkgZHJpdmVyIGZvciB0aGUgUmVuZXNhcyBSUEMt
SUYuDQo+ID4gPiBBbG9uZ3NpZGUgcmVsZXZhbnQgY2hhbmdlcyBmb3Igc3BpLW1lbSBoYXZlIGJl
ZW4gYWxzbw0KPiA+ID4gYmFja3BvcnRlZC4gVGhpcyBlbmFibGVzIGFjY2Vzc2luZyBTUEkgZmxh
c2ggY2hpcCBjb25uZWN0ZWQNCj4gPiA+IHRvIFJQQy1JRiBvbiBSWi9HMnggYm9hcmRzLg0KPiA+
ID4NCj4gPiA+IFdlIGN1cnJlbnRseSBvbmx5IGFpbSB0byBiYWNrcG9ydCBqdXN0IHRoZSBkcml2
ZXIgaGVuY2UgdGhlcmUNCj4gPiA+IGFyZSBubyBjaGFuZ2VzIHRvIGR0cy9pIGZpbGVzLiBUaGUg
ZHJpdmVyIGhhcyBiZWVuIHRlc3RlZCBvbg0KPiA+ID4gUlovRzJ7RU19IHdpdGggYWxsIHRoZSBy
ZXF1aXJlZCBkdHMvaSBjaGFuZ2VzIFsxXS4NCj4gPg0KPiA+IE9rYXksIHRoYXQgd2FzIHF1aWNr
Lg0KPiA+DQo+ID4gV2hhdCBpcyB5b3VyIHBsYW4sIG1lcmdlIGR0cyBjaGFuZ2VzIHNvb24/IE9y
IGlzIHRoZSBkcml2ZXIgdXNlZnVsDQo+ID4gZXZlbiB3aXRob3V0IHRoZSBkdHMgY2hhbmdlcz8N
Cj4gPg0KPiA+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gPiAqIFBhdGNoZXMgezEsIDMsIDR9Lzcg
dW5jaGFuZ2VkDQo+ID4gPiAqIFBhdGNoIDIvNw0KPiA+ID4gICAgKiBGaXhlZCByZWZlcmVuY2Ug
bGVhayBmb3IgT0Ygbm9kZSBpbiBycGNpZl9wcm9iZSgpDQo+ID4gPiAgICAqIEZpeGVkIG92ZXJ3
cml0aW5nIHJldHVybiB2YWx1ZSBpbiBlcnJvciBwYXRoIG9mIHJwY2lmX21hbnVhbF94ZmVyKCkN
Cj4gPiA+ICAgICogUmVwbGFjZWQgQysrIHN0eWxlIGNvbW1lbnQgd2l0aCBDIHN0eWxlDQo+ID4g
PiAgICAqIFJlcGxhY2VkIHRhYiB3aXRoIGEgc3BhY2UgYmV0d2VlbiBzdHJ1Y3QgYW5kIHN0cnVj
dCBuYW1lDQo+ID4gPiAgICAqIEZpeGVkIGEgdHlwbyBpbiBjb21taXQgbWVzc2FnZSAocy9hYnNy
YWN0L2Fic3RyYWN0KQ0KPiA+ID4gKiBQYXRjaCA1LzcNCj4gPiA+ICAgICogRml4ZWQgcmVmZXJl
bmNlIGxlYWsgaW4gc3BpX21lbV9hY2Nlc3Nfc3RhcnQgZm9yIFBNDQo+ID4gPiAqIFBhdGNoIDYv
Nw0KPiA+ID4gICAgKiBSZXR1cm4gZWFybHkgaW4gc3BpX21lbV9kaXJtYXBfZGlybWFwX3tyZWFk
L3dyaXRlfQ0KPiA+ID4gKiBQYXRjaCA3LzcNCj4gPiA+ICAgICogUmVwbGFjZWQgQysrIHN0eWxl
IGNvbW1lbnQgd2l0aCBDIHN0eWxlDQo+ID4gPiAgICAqIFVzZWQgX19tYXliZV91bnVzZWQgZm9y
IHJwY2lmX3NwaV97c3VzcGVuZCxyZXN1bWV9IGFuZCBkcm9wcGVkDQo+ID4gPiAgICAgIENPTkZJ
R19QTV9TTEVFUCBpZmRlZiBjaGVja3MNCj4gPiA+ICAgICogRWxhYm9yYXRlZCB0aGUgZGVzY3Jp
cHRpb24gZm9yIFNQSV9SUENJRiBjb25maWcNCj4gPiA+ICAgICogRHJvcHBlZCB0aGUgbGFiZWwg
ZXJyX3B1dF9jdGxyIGZyb20gcnBjX3NwaV9wcm9iZSgpDQo+ID4NCj4gDQo+IEkgZG9uJ3Qgc2Vl
IGFueSBwcm9ibGVtcyB3aXRoIHRoaXMgc2VyaWVzLg0KPiANClRoYW5rIHlvdSBmb3IgdGhlIHJl
dmlldy4NCg0KPiA+IFRoYW5rcyBmb3IgdGhlIGNoYW5nZXM7IHRoZXkgYXJlIHByb2JhYmx5IGdv
b2QgKEkgaGF2ZSB5ZXQgdG8gdGFrZQ0KPiA+IGNsb3NlIGxvb2spLCBidXQgSSB3b25kZXIgaWYg
d2Ugc2hvdWxkIHdhaXQgdW50aWwgdGhleSBoaXQgbmV4dCBvcg0KPiA+IG1haW5saW5lPyBJZiB1
cHN0cmVhbSBtYWludGFpbmVyIGRpc2FncmVlcywgd2Ugd291bGQgZ2V0IGRpdmVyZ2VuY2UuLi4N
Cj4gDQo+IFRoZXNlIHBhdGNoIHNlcmllcyBjb250YWluIGZpeGVzIGZvciBpc3N1ZXMgaW4gdGhl
IHBhdGNoIGl0c2VsZiwgc28gd2UgbmVlZCB0bw0KPiBzZXBhcmF0ZSB0aGVtIGFuZCBwb3N0IHRo
ZW0gbWFpbmxpbmUgb3Igc3Vic3lzdGVtIHRyZWUuDQo+IFNvIEkgdGhpbmsgd2UgaGF2ZSB0byB3
YWl0IGZvciB0aG9zZSBwYXRjaGVzIHRvIGJlIG1lcmdlZC4NCj4gDQpBZ3JlZWQgd2lsbCByZXBv
c3QgdGhlIHNlcmllcyBvbmNlIHRoZSBmaXhlcyBoaXQgbGludXgtbmV4dC4NCg0KQ2hlZXJzLA0K
UHJhYmhha2FyDQoNCj4gQmVzdCByZWdhcmRzLA0KPiAgIE5vYnVoaXJvDQoNCg==

--INB8OFVrzIQvdUIYWRKH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5873): https://lists.cip-project.org/g/cip-dev/message=
/5873
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--INB8OFVrzIQvdUIYWRKH--
