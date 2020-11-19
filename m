Return-Path: <SRS0=bpvc=EZ=lists.cip-project.org=bounce+64572+5808+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F67C5519F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 03:22:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A6920679
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 03:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oNuynezY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A6920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5808+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HHHEYY4521723xpv27xYZQ3L; Wed, 18 Nov 2020 19:22:39 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.94])
 by mx.groups.io with SMTP id smtpd.web11.4327.1605756157549559796
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 19:22:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc5E39KwtWGfbpYNNZIYgoX1FE8oBVT/LYJ180iWhmdLaAzJp5EOkYsR5I9QNX7tk/zMmX2IPOERvN+rktnvZMRNKdErofgppvozIHvzJUOKPBELUNIqJUe9lAHTRpxs9fgEiqPDyNDQ0Vm3F3CH8YATEKq42e/9Q+nYpHI25op7CCjtn9/lkO4boVz0J+huV9xO6P+gNH5UKq4HHcYkdOoxJrOuw01+b799rlaWJsN9gc0W0r+zlZC6+bjCqBICYi6JCMyMqoKdlO5+5Z9L8vEREN5tMzR/lhIpIjXDfBXRG1dLHg17Iy2x4Dt3fDHW5wgOPJbPn3y3X8et+ZLu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKvtfG0w50KHNmYBrN85BzaOFxy8nOQqLzic2tqjKgg=;
 b=eAkyHKWL+uyOnTFMrTV/NU92OIWXOnV2U6DLJScxmhgTB8dpP4SIOUDImuyU8PBVW2bEDyBwgwFwyLLuDSk6jMs4tLgMXkRNUVmBAVwpM1VMxo1wCfVRokJ1KazNyCPlBW7js7wIAprjx73Rxo6jAlMMPSoSNGhlnXYAC0mtWyypEJPJa4V5bYi90VG60lVKnXFgeL/h2kyqMqO9nAm5Tl6hd3Bz64FrdVtka1Hl9JsaXGf3xWhWmaM9CQGEblsgFslm/sljjXZj7NwMl1MaAqJfxMANrJrqlhzLesuQLmjcvsfPRqbUOy/zEWmApOZC36Ai/41DFNfI4gX7BX15fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB1936.jpnprd01.prod.outlook.com (2603:1096:404:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 03:22:34 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 03:22:34 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: Ada+CY9Fxe+/1yZYSDWZKbr3HXyz7wAF58MgAAB5YBA=
Date: Thu, 19 Nov 2020 03:22:34 +0000
Message-ID: 
 <TY2PR01MB49728722C902D334CA92F20DA0E00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972BCCD6681428DE908F4C2A0E00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB29835AC4F2D486107716905C92E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB29835AC4F2D486107716905C92E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ca8b438-e58b-4760-5589-08d88c3a5bb0
x-ms-traffictypediagnostic: TYAPR01MB1936:
x-microsoft-antispam-prvs: 
 <TYAPR01MB193608BA2CDE68F386E2DB82A0E00@TYAPR01MB1936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 xt/zrzBfxozSMEbYq/OX7zzIy+UQfsCUMv16/w0f2L3SZrOrNI//DBeHcRt2GjsC8RfyGW5G13P4mIFO7aKSIBwetFh2dw/1pzB31UhtapLoWGUBZZKrHgMDfo2i7RxAtKjAGrHyfPAtetbzuYAJEc5kl0fd2DLGsE+RbIN9CxxLIudwmSLOJv9/pFLzsSiTf8Yo9odoz1Xyl0gTT35PEFWVb1YE8gwQ8vJC+o+9oHk8x9Zkum6XCGvv6yNw8nRR0jjFmPBAMwlZhXBukzXfJx9VvRzOpnnr7Hke3d+3UHkwRtfWbuE+3eqhO5jQIak1Hl7u2pp7jfdTjN6R+dgwqTlGgxsyYWVOIkN/v82WX4dDubYVD3t0mx53ok43UZCkynm+ebIuVzxi4hF4NHlUHQ==
x-ms-exchange-antispam-messagedata: 
 KBoNHevbeAvZCVFkrSZFfeUAHHS7VGQmjlropKnyVaRH3LAQ9AumYdou5YwJdRBkyYKQ1qMR1sNWZxU1H/lWY3DsPRjXEp3Ze5Y/a7oa5sKhuQphZ0w9Q8Xk8lvJUSe9Q/82atEw2llU/8oZsc63Iy/fAQYspVYf8wDZLb07oyuRI8LI1kJ+jt634HhrNU75QwXz17FiDQvymzbRTa1dkoFCA2oU/afEhmYxtMfMxuS46hIQvzl+WerYkQn3nkZCyZU65zBVtTCDU1VpUkuFh2n2Ve4TF7iekvu3eAoIvV9vaBgslSudlt1x7d/9bifMNAhtFnlI7H59L+5SA3YpnbPW96LarpYHSSaZ7YYoSbRAH7JYgtE7bc0FIWXeQUQIOQ8UC/5iEnJdR3xodWEBclGIMBVVXGrIoDDxyUQ4ttXvVGykQxWeF8hAK97BjCS71mL2MJL6SpK/Jr1iULj1YaDpk6+r4cShCSbM7Rez/AYvXppbJWo92+/H0OrzlPUZfgSLZqOnNTW1yl66ApTI5ev8RryJ00uSwCkS8QI8xBOK9HY3FmdluP16vJL7u41CbwxMjhjktKpf38hdbPNnnWWIwf0MUXkyu/l7Yoe8YHP8ezkDFcMtLAs1rnef+49vNkcE3vPaQeO9OeKf9YhUow==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca8b438-e58b-4760-5589-08d88c3a5bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 03:22:34.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EF+iEnAVHo6VuknUKV5Fh7oUViempxGMU/0y8QTKzyMLmPzudsV3iEpqUpPWxoyqrIcReYAE7zaoYHuFDwlmzEIEzpoqRTyx5Wbxvil4iHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1936
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s9yauFTSrhelHTivXBQd8EDex4520388AA=
Content-Type: multipart/mixed; boundary="bcpvW5wDIZPBAXoeo7PI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605756159;
 bh=fwZ8IUwzGIDOCn1dhmOBQXmc572uHRCYSOHV+uRHxdY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oNuynezYypDYB0LME+6daOWfpGjX4xI1TFbx8aqZeyyX9Ko3DYKBIKckUitwNZ+Q3Bl
 lqvygLDjirdI1AAL6bvZZOUbmkW2LtZ/98Oi9RZp5LhXmc0EkVMrYaa+DTqAi8KiEfJqh
 HFh6p8MmwtoL0jx431B72IXcFiXyJfIjE5Q=

--bcpvW5wDIZPBAXoeo7PI
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEl3YW1hdHN1LXNhbiwNCg0KVGhhbmtzIGZvciB1cGRhdGluZyB5b3VyIHN0YXR1cy4gQWxz
byB0aGFua3MgZm9yIGZvbGxvd2luZyB1cCB0aGUgQUkjMi4NCkkgd2lsbCBjbG9zZSB0aGlzLg0K
DQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mDQo+IE5vYnVoaXJvIEl3YW1hdHN1DQo+IFNl
bnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxOSwgMjAyMCAxMjoyMCBQTQ0KPiBUbzogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBDSVAgSVJDIHdl
ZWtseSBtZWV0aW5nIHRvZGF5DQo+IA0KPiBIaSBLdWRvLXNhbiwNCj4gDQo+IFNvcnJ5LCBJIGNh
biBub3Qgam9pbiB0b2RheSdzIElSQyBtZWV0aW5nLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4g
W21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mDQo+ID4g
bWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gPiBTZW50OiBUaHVyc2RheSwgTm92ZW1i
ZXIgMTksIDIwMjAgOToyMCBBTQ0KPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiA+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5DQo+
ID4NCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRo
ZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3Bp
Y3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5Lg0KPiA+DQo+ID4gKlBsZWFzZSBub3RlIHRoYXQgdGhl
IElSQyBtZWV0aW5nIHdhcyByZXNjaGVkdWxlZCB0byBVVEMgKEdNVCkgMDk6MDANCj4gPiBzdGFy
dGluZyBmcm9tIHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nIHRvIFRTQyBtZWV0aW5n
Kg0KPiA+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRh
aWxzLmh0bWw/eWVhcj0yMDIwJm0NCj4gPiBvbnRoPTExJmRheT0xOSZob3VyPTkmbWluPTAmc2Vj
PTAmcDE9MjI0JnAyDQo+ID4gPTE3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiA+DQo+
ID4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiA+IDAxOjAwCTA0OjAwCTk6MDAJMTA6MDAJ
MTc6MDAJMTg6MDANCj4gPg0KPiA+IENoYW5uZWw6DQo+ID4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5u
ZXQ6NjY2Ny9jaXANCj4gPg0KPiA+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiA+IGh0dHBzOi8v
aXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjAvMTEvY2lwLjIwMjAtMTEtMTIt
MDkuMDANCj4gPiAubG9nLmh0bWwNCj4gPg0KPiA+IEFnZW5kYToNCj4gPg0KPiA+ICogQWN0aW9u
IGl0ZW0NCj4gPiAgIDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVtIHdpdGgga3NlbGZ0ZXN0IGJp
bmFyeSAtIGl3YW1hdHN1DQo+IA0KPiBObyB1cGRhdGUuDQo+IA0KPiA+ICAgMi4gQ2hlY2sgd2hl
dGhlciBDVkUtMjAxOS0wMTQ1LCBDVkUtMjAxOS0wMTQ3LCBDVkUtMjAxOS0wMTQ4IG5lZWRzDQo+
ID4gdG8gYmUgYmFja3BvcnRlZCB0byA0LjQgLSBLZXJuZWwgVGVhbQ0KPiA+DQo+IA0KPiBBZnRl
ciBJUkMgbWVldGluZywgSSBjaGVja2VkIHN0YWJsZSBNTC4gQmVuIHdhcyBzZW5kaW5nIGEgcGF0
Y2ggZm9yIHRoaXMgaXNzdWUuDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9zdGFibGUv
ZjVlMmU4N2ZiMWE5NjEzYjE2MWU2M2NmNTUwNGNjMzc1ZTA5NWRiYy5jYQ0KPiBtZWxAY29kZXRo
aW5rLmNvLnVrLw0KPiBJIGNoZWNrZWQgdGhlIGNvbnRlbnRzIG9mIHRoZSBwYXRjaCwgYnV0IHRo
ZSBjb250ZW50cyB3ZXJlIHRoZSBzYW1lIGFzIHRoZSBwYXRjaCBJDQo+IHBvc3RlZCB0byB0aGlz
IE1MLg0KPiBBbmQgdGhlc2UgcGF0Y2hlcyBoYXZlIGJlZW4gYXBwbGllZCB0byBzdGFibGUgdHJl
ZSwgd2UgY2FuIGNsb3NlIHRoaXMgQS5JLg0KPiANCj4gPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1
cGRhdGVzDQo+IA0KPiBJIHJldmlld2VkIDQuNC4yNDQtcmMxLg0KPiANCj4gPiAqIEtlcm5lbCB0
ZXN0aW5nDQo+ID4gKiBDSVAgU2VjdXJpdHkNCj4gPiAqIEFPQg0KPiA+DQo+ID4gVGhlIG1lZXRp
bmcgd2lsbCB0YWtlIDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhv
dXINCj4gPiBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQgaW4gdGhlIHRvcGlj
cyBjYW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMNCj4gd2lsbCBiZSB0YWtlbiBvZmZsaW5l
IG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gLS0N
Cj4gPiBNLiBLdWRvDQo+ID4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gICBOb2J1aGlybw0KDQo=

--bcpvW5wDIZPBAXoeo7PI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5808): https://lists.cip-project.org/g/cip-dev/message=
/5808
Mute This Topic: https://lists.cip-project.org/mt/78354782/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bcpvW5wDIZPBAXoeo7PI--
