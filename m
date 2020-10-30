Return-Path: <SRS0=blo3=EF=lists.cip-project.org=bounce+64572+5698+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA824C00A89
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DFD206E5
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eOlc03gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DFD206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5698+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RZBnYY4521723xqRJpW7rjLN; Fri, 30 Oct 2020 11:07:33 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.130])
 by mx.groups.io with SMTP id smtpd.web10.18388.1604081251932870809
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2020 11:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQbU9I0N+drjpO7Rra90Xf5ybSfKI3BEO8T/lb1wV6f4z4Nameefkm8fqZFeWKPrRttwsArZnELrTc18Jyl8juWhCAzp4SZp5P/omOJjWo9tXmyauE3oX2/+k3IVIoGDTYd+Uy3qhu/kJjEzHMTUHnwmUxpNZ+xDRAHXy1Ac0ibUFTg4wVKItdYTTd1InBe9MN7Cnu1hOUkL10Ea7l2dO4wJGD1cnL4DZADZ6MO44T5b/aAMimfSnPRXSHOjSoEiqHbYXD/06IAvNo0ESxqi0o6T59gHSj7S0wp4sjZy9Je7XIWFxLlHx0Pza5CvX6oRsw8dg1tx2Oq0Lwn3d0lXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bedONrYplL1K+rlYor4SM4tgJ/jCVeROkb50bwEC+uw=;
 b=JmSf9z1HLNA9Ru7MFpbm6u4YoZ/A7ujAmsVwx07S2lb6qsggLm6IlJFYZ8FzUd/dEPvOCWamtgPGJNKISqBViJ+Hn4oFRjCfUWmhN8oSUHsRd2dx0K3kc51164eJf/DFMbIu5YK0oqjHm9hEyY0JLa8G8ciZ8otsy3onsLzXG22MW8JUNUYM2aTveBDzGUWZUrLiPZxkQBRvUZagBuQWpktUDNl6RKLQE9+GRlUwiWINA/YdtzE6V3ehFVBzylkv2a38LyjH+JnL61OVaVf4mkB5QWQ961H+DNxXuW7DqE42uU30N0DClD6y/QVYjd3HtaSDL7LKHs/MvqKikYnUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2133.jpnprd01.prod.outlook.com (2603:1096:603:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 18:07:27 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 18:07:27 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Topic: [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Index: AQHWrT64EZJU4dKxlUSorKTY6uSpvqmtIybAgALZZoCAAHeJMA==
Date: Fri, 30 Oct 2020 18:07:26 +0000
Message-ID: 
 <OSBPR01MB5048D4886CA5B213AD4ADF85AA150@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201028152635.GA26388@duo.ucw.cz>
 <OSBPR01MB50480539DF66856499012B1EAA170@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <OSBPR01MB298385E0BFF5FB709CAE432D92150@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB298385E0BFF5FB709CAE432D92150@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddfd56b7-afe0-4070-22d9-08d87cfea913
x-ms-traffictypediagnostic: OSBPR01MB2133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB2133C2B4781D778675008B45AA150@OSBPR01MB2133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ZSl6zuIWJPsFES3P/7kgTwDrRwaXaHhDaEdHw6ZO/eRHvQxjNTK+x/MWqPXYAFXwRvAnGcGlU9RHdRfU7G3HM6iuoqHkg4+i9eKlwWrHbneN1Q4HnIYfqzQs6i8IJ4QpfctN0QFEopSPNk1Ov37085C+pwGqS6PfAJkJ4/n8iF3tg0ThgLktIxeDVXKAt8hp5kvT6hsvePx3z3y3ZCQlZ3Mbg8xeExhGRhoLZ8tJgglfZWW4A/f4jdTY0JHC0io6ZbgZ0NSdpuBivi8yz61vo04jGU1/QDrytyTgRYGCdnqnxzkuFMOglxs810gCUEP4UeDWnBzI4E36aI3b2m8hasQ+YRfQWe6Wm1livC5ghsNEo5GvA7DF4XmWp8jgo17HsSpxINYRXf1SzZWs/Gw0Jw==
x-ms-exchange-antispam-messagedata: 
 Ykj8mOB7uI2eNBwc2REDyqf8818/5GxPk+Xl9iGJJnOtRNLjVgmxFbh/d10iXZIZ4Bobux1VKNeStMupKi9yr2qPkD7NItQ47TJZ6xEc3pGRYn5Cd+ylve44zPCpm5a5QXz3glP3smQ47AhG4RrV4aXnXiL7oKI88HnQ3hPlf9XCOboN1KM/1wXTAf9ShMmwNFjP4ZqBna5quqUSoOF1z6vVtTF935misHZ173AGlAa4WgdyWTiNYUgxCKjCm0NoKwlMLhIfftzAwQbLkKE7kRo0uk10MnkcOB2UPQCfju6D2WQ11YPJpgLwowDfW0HYg5qRlWt1DSFlvDyGUsfnrFvmrzHPIlbMLpVA8S2VQNn0uai8UVNuIVEOOdOqFGAKgPInH1ZUw6rmx30BJxHgYYU+HNn0iBxp7l829RbuEEwPYyjY/m9cAUk0FG+dRx0LFREQNMjaCyc01my+4mL6fBs+VUfcZ/81g9dm6BaiyFfaxSqCEgJ5Gd10WTt9YhSIAboJ70M6Iuxz2T/bnpC4yw7ANsp/fc8aR1jgMSQDwW+ykwGDWlZyziGl0kn4FL/zJcclJOdZACJUx8o/YUd272Ob2t6HXVY6v63LTVCp3+tAM2j/KZarMeRlTU4hrMOYFK4Vg5boFJQ7JTbSdcfwMQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfd56b7-afe0-4070-22d9-08d87cfea913
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 18:07:26.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDrU388dVke5xkUgyxL2XEiDH2/SjxW0+xaR/3nQqVGgMneQvoKa7U4UenAiT6W1XBpZw7JL3os044aMpcxdWJghAnO3neHcs5oCC2AKSFB5QBqMmrCYJyIV2K5DJe47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2133
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JTuNpxTFqM9N1Mc02sWpqnZIx4520388AA=
Content-Type: multipart/mixed; boundary="mrZDews8hsXwfJKEE9Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604081253;
 bh=xxmwDq6la2q3P//UXj6K83xXrdVvKQYunj6u0jG6oaI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=eOlc03gl0kurFix1o/8XRL2ZN9cTAUwP2gKAHH0GKkRzWTKRQzC4SHfQAo+DcT2CGB5
 7xBc/zPZDUfFAIj/nCnPEgwqTJU70pw2csACndaWGyHB/oBPY8yYvUgUqiYH93j/obYdp
 76JJiWxsOLHHY5WNoW/sBJZkDj34gieM8q8=

--mrZDews8hsXwfJKEE9Vy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwPg0KPiBTZW50OiAzMCBPY3RvYmVyIDIwMjAgMTA6NTgNCj4gVG86IFByYWJoYWthciBN
YWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgcGF2
ZWxAZGVueC5kZQ0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IEJpanUgRGFz
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA0LjE5
LnktY2lwIDAvNV0gQWRkIFBDSWUgRVAgbm9kZXMgdG8gUlovRzJ7RU1OfQ0KPiANCj4gSGkgUHJh
Ymhha2FyLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBy
YWJoYWthciBNYWhhZGV2IExhZCBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5y
ZW5lc2FzLmNvbV0NCj4gPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyOSwgMjAyMCAxMjozNiBB
TQ0KPiA+IFRvOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+ID4gQ2M6IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEu
Y28uanA+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gU3ViamVj
dDogUkU6IFtQQVRDSCA0LjE5LnktY2lwIDAvNV0gQWRkIFBDSWUgRVAgbm9kZXMgdG8gUlovRzJ7
RU1OfQ0KPiA+DQo+ID4gSGkgUGF2ZWwsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+ID4gPiBT
ZW50OiAyOCBPY3RvYmVyIDIwMjAgMTU6MjcNCj4gPiA+IFRvOiBQcmFiaGFrYXIgTWFoYWRldiBM
YWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IENjOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrDQo+ID4gPHBhdmVsQGRlbngu
ZGU+OyBCaWp1IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCA0LjE5LnktY2lwIDAvNV0gQWRkIFBDSWUgRVAgbm9kZXMgdG8g
UlovRzJ7RU1OfQ0KPiA+ID4NCj4gPiA+IEhpIQ0KPiA+ID4NCj4gPiA+ID4gVGhlc2UgcGF0Y2hl
cyBhcmUgcGFydCBvZiBSRkMgc2VyaWVzIFsxXSAoezQzLTQ2LDQ4fS81MCksDQo+ID4gPiA+IHRo
ZXNlIHdlcmUgZHJvcHBlZCBlYXJsaWVyIGFzIHRoZXkgd2VyZW4ndCBwYXJ0IG9mIC1yYyByZWxl
YXNlDQo+ID4gPiA+IGF0IHRoZSB0aW1lIG9mIHBvc3Rpbmcgbm93IHRoYXQgcGF0Y2hlcyBoYXZl
IGxhbmRlZCBpbiB2NS4xMC1yYzENCj4gPiA+ID4gSSBhbSByZXNlbmRpbmcgdGhlbSB3aXRoIG5v
bi1SRkMgdGFnLg0KPiA+ID4gPg0KPiA+ID4gPiBbMV0gaHR0cHM6Ly9qcG4wMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2h3b3JrLmtlcm5l
bC5vcmclMkZwcm9qZWN0JTJGY2lwLQ0KPiBkZXYlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q3ByYWJo
YWthci5tYWhhZGV2LQ0KPiBsYWQucmolNDBicC5yZW5lc2FzLmNvbSU3QzU1ZTJhNzBlOTBjNTRh
ZWQ0Nzg5MDhkODdjYzJhYjZjJTdDNTNkODI1NzFkYTE5NDdlNDljYjQ2MjVhMTY2YTRhMmElN0Mw
JTdDMCU3QzYzNzM5NjUyMg0KPiA4MzcwODE3MTklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMTAwMCZhbXA7DQo+IHNkYXRhPVA0ZDl6S3lwbSUyQjBrR3BtRDMyYlBpQzJXNlNY
TFg1RnAlMkZtOTlid3piNlk4JTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gPiA+ICAgICBsaXN0Lz9z
ZXJpZXM9MzYzMjc5JnN0YXRlPSUyQSZhcmNoaXZlPWJvdGgNCj4gPiA+DQo+ID4gPiBTZXJpZXMg
bG9va3MgZ29vZCB0byBtZS4NCj4gPiA+DQo+ID4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
bmVzYXMvcjhhNzc0YTEuZHRzaSAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YjEuZHRzaSAgICAgfCAzOCArKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhh
Nzc0YzAuZHRzaSAgICAgfCAxOSArKysrKysrKysrDQo+ID4gPg0KPiA+ID4gSSBzZWUgdGhhdCB0
aGUgbm9kZXMgYXJlIHN0aWwgbWFya2VkIGFzICJkaXNhYmxlZCIuLi4gSSBndWVzcw0KPiA+ID4g
ZGV2Ym9hcmRzIGFyZSBub3QgcGx1Z2dlZCBpbnRvIGludG8gUENJZSBob3N0cyBmb3IgdGhlIHRl
c3RpbmcuDQo+ID4gPg0KPiA+IEl0J3MgdGhlIHNhbWUgY29udHJvbGxlciB3aGljaCB3b3JrcyBh
cyBhIGhvc3QgYW5kIGVuZHBvaW50IChQQ0llIEVQKS4gQnkgZGVmYXVsdCBvbiB0aGUgYm9hcmRz
ICBjb250cm9sbGVyIGlzIGVuYWJsZWQNCj4gPiBhcyBob3N0IGFuZCBub3QgRVAgYXMgYSByZXN1
bHQgc3RhdHVzIGlzIHNldCB0byBkaXNhYmxlZC4gU28gZHVyaW5nIHRlc3RpbmcgaG9zdCBpcyBk
aXNhYmxlZCBhbmQgRVAgaXMgZW5hYmxlZC4NCj4gDQo+IE9LLg0KPiANCj4gPg0KPiA+ID4gQW55
d2F5LCBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cgaWYgdGhlIG1lcmdlZCAtY2lwIGNvZGUgd2Fz
IHRlc3RlZA0KPiA+ID4gYW5kIHdoYXQgd2FzIHRoZSByZXN1bHQgOi0pLg0KPiA+ID4NCj4gPiBB
dHRhY2hlZCBhcmUgdGhlIHJlc3VsdHMgZm9yIEcyTSBhcyBQQ0llIGhvc3QgYW5kIEcyTiBhcyBQ
Q0llIEVQIHRlc3RlZCBvbiBDSVAga2VybmVsLg0KPiA+DQo+ID4gU28gb24gdGhlIGhvc3QgcGNp
ZXRlc3QgcmVhZC93cml0ZS9jb3B5IGNvbW1hbmRzIGFyZSB0ZXN0ZWQgKGFsc28gbHNwY2kgb3V0
cHV0KQ0KPiANCj4gVGhhbmsgeW91IGZvciBhdHRhY2hpbmcgdGhlIHRlc3QgcmVzdWx0cy4NCj4g
SSB3aWxsIGFwcGx5IGFuZCBwdXNoIHRoaXMgc2VyaWVzLg0KPiANClRoYW5rIHlvdS4NCg0KQ2hl
ZXJzLA0KUHJhYmhha2FyDQo=

--mrZDews8hsXwfJKEE9Vy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5698): https://lists.cip-project.org/g/cip-dev/message=
/5698
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mrZDews8hsXwfJKEE9Vy--
