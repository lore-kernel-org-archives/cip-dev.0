Return-Path: <SRS0=zdoE=EF=lists.cip-project.org=bounce+64572+5697+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE440C4363A
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 10:58:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F87206E5
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Dxzzc8Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F87206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5697+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5DlSYY4521723xyVtHA1eBRQ; Fri, 30 Oct 2020 03:58:11 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.11717.1604055488729314378
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2020 03:58:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 09UAvxQw002964; Fri, 30 Oct 2020 19:58:00 +0900
X-Iguazu-Qid: 34treJXbvYVuv24iWq
X-Iguazu-QSIG: v=2; s=0; t=1604055479; q=34treJXbvYVuv24iWq; m=GnszBwund38ZMTRncoH99zFPZ9OOIdxHv35CIP719Nk=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 09UAvw1b040190;
	Fri, 30 Oct 2020 19:57:59 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 09UAvwBB016663;
	Fri, 30 Oct 2020 19:57:58 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 09UAvwxF022710;
	Fri, 30 Oct 2020 19:57:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX+1kqqkHEnETY9SfZpoqrurSX6Os7iDkb7sffhx3OmX7xnXxSPp8jQlLdlVcAevu7Xwl/MyJWXOVXQpliib2GoGQCrwL3U+g9CBUriidCSZHlk8QsTbimQRL4WzflLZyALPrb0/T0SRLoy00kUNKwv3kaPd4Gr7roXBRDfGvedTmqNnWqN4nJxzqL1L3quHJAc3nTSzWHV+v7cKHn/RVCHYgQhvUukq9i725XzVSA5aAH7FZb/7o1eqkFjvwLmHVe92U6JV0lUTppB+Qj0fRVNgigW2HRyrJfd+JDf1GAm544UyTakK8wpqDennPi25xP7AyEeVYD6s0dPQtp04cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvaqndMX5+UzNeRz4NFf+fYXLREHIrwCUokzSjwbzfI=;
 b=gyHwjou8Cxk00beefgDyD6O3Z8DQGVzIkRqcd4ciT23nd8M1mpVa/hQE4Pg8rmsAleaQ1ueSGTXkHcozWPX5A8RXDvQMuch2piFPI6AjU0aNvKLru6Nbs2KdS9J2a/MMNg+2zdlp3RDyw4gMyuJGOwZEg3dpB3CAwj3Wu0z3i/ZTdU+OAzTml7SKD06Yq8ZmiUTf/C+i7Tch9T8irGmVqtHPbIshGN5nb3pFHdZ9tfsTabmfcYAMh63wIYkyP/Bz6KJtkwiohkkz3/3uXWqijHPIHWuNWtJJXHNfXx7TeSogfRP1gDSdIpCfFnnPjq8/KfF1l6c8SANsYWt/FE9tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Topic: [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Index: AQHWrIIjEZJU4dKxlUSorKTY6uSpvqmtJGyAgAACjoCAAtZ3QA==
Date: Fri, 30 Oct 2020 10:57:55 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298385E0BFF5FB709CAE432D92150@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201028152635.GA26388@duo.ucw.cz>
 <OSBPR01MB50480539DF66856499012B1EAA170@OSBPR01MB5048.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB50480539DF66856499012B1EAA170@OSBPR01MB5048.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdfa763c-bc32-4d82-7a38-08d87cc2a7be
x-ms-traffictypediagnostic: OSBPR01MB1830:
x-microsoft-antispam-prvs: <OSBPR01MB183001D567AE6C33B9C22D8992150@OSBPR01MB1830.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xw/8wNv17WRYiksfSm+akntsqwUqEOcgsNyaK5Jb4yAF5ykQBlRFudv/5csuxpifojqMUoK249YUAhDZniAxXWQbuOOvdNdlKqDBdFnevB24zXtYoqAiWR8eLAiiT8VNJ1a88t0LgD4i9Dnre7XiX7Y8CpMJJbVSTzrkwwyH8Td2szytEMepW9Ke9hbr/lfFlYnpf0ePMdvfw1UJ8ROFDY5+PoNEKvC0PW7BrY7IXTytR2kN9WHzO3Q8uTMdJmzUkkLuxE8NJIJPTLZJV/g9Jd2GgyLp+pz6R6BP9nkMIJEw5yIXRCQT+h5bZLCJXZti6fhOdY8SLxDjU8jJOG24j2GKKX4IA8zr+vRlM+pyBJ1O2B5SuqsNQLZvQxSMpgQaofHccriAtMS/zORP+eJOdQ==
x-ms-exchange-antispam-messagedata: srbc5ND50P3oKYIEq5W9KnPXVh1srwQsnhDPJa7vA8K7yeulVwMbkOm8YkZ8xgxx6/jFrga015qCJrLm/HvnFUHJjBgHqhju3zJAxYnjBKjdFD6UkiReOyAVPssmfgTwjBXvnZfz6NGNHqelpKoVRJ8h1q0ZSXOpnCvQMs15DD/1zjq4/STXVNxjsXEFUCY7M4HR9x2WgB/b+toCrVzJgI0JXzBnpn9EbMO5JXcbEsyV40C7GwWR6CK7RWifkicC3a2CyaoaBbJS0juXlaK2a4NK88WF3LqEJYJ0OWfWyOR1NgIYOHcs1ia9bHPyV/jGPPjJ9FEyIDiN2Q//OOfAbzpkE16XyRSOnw2A3mBDiWB97RgimBy/al9BTioPogGYbrWPgYEmnNe5I1K5RfWDJtNKjnW5BHjghl5b/Wh9dNq/0wgjh2PWEozYLDv9f8269TQr4MqFz1Ut0qxudoDKBOAaiOW04hD3tHaIWmH0mW8+IeXBMD5lSK5QC4Y3e7HzLJ1mgS2WFpDFOLamPy4ol2YYhIuE1KNOA4axvIZPvAnfHJkFCZjw0LLMYdVCq+Qh5hCIE4HFs0CfBo+acVU2gC661zq/Mav4avQ5w7TtWpwLAscBRum5I1Lw58c8s5oawHAeNDFJgCWCrTPREVBlsw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfa763c-bc32-4d82-7a38-08d87cc2a7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 10:57:55.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lklXfw94eEwA9xDBcMLXA4mqqOejAs1k/IlYwPIMQRoCEmyvFcAWCNGzcLRTeRIewdB6IwfNfxkoGnFNLBdryXKnDTatW7YlaVFgqjAiOa1jY4ObRc9Ivg81Qh61oxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1830
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: R67nGDwAiB5WCQByCDMdW5hax4520388AA=
Content-Type: multipart/mixed; boundary="KxMMIng6nL4ijdGq4tRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604055491;
 bh=rDHHCjeoG7s2dMDGLATvgCtv4UV+zFsxm7EC0rOZJmE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Dxzzc8ZhRdwgMU4ZIe+tJgnNN6To1aSVPLTKdoD8FrnNQXXdQU1AEnBaOauCq/A+5Pb
 vUJ5LAN59SWdtMDBlVt7nOK5jWvsbChvQ9D7XwyzF+itNl4AG6tXnyk8O7c3WrZHpZVAU
 f/Zinlz3lwo4TxQ0vSTV7lCJj+lltsZyOyY=

--KxMMIng6nL4ijdGq4tRk
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBy
YWJoYWthciBNYWhhZGV2IExhZCBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5y
ZW5lc2FzLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjksIDIwMjAgMTI6MzYgQU0N
Cj4gVG86IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8
t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsg
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIDQuMTkueS1jaXAgMC81XSBBZGQgUENJZSBFUCBub2RlcyB0byBSWi9HMntFTU59DQo+IA0K
PiBIaSBQYXZlbCwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+ID4gU2VudDogMjggT2N0b2JlciAyMDIw
IDE1OjI3DQo+ID4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYt
bGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZzsgTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
PjsgUGF2ZWwgTWFjaGVrDQo+IDxwYXZlbEBkZW54LmRlPjsgQmlqdSBEYXMNCj4gPiA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0LjE5LnktY2lw
IDAvNV0gQWRkIFBDSWUgRVAgbm9kZXMgdG8gUlovRzJ7RU1OfQ0KPiA+DQo+ID4gSGkhDQo+ID4N
Cj4gPiA+IFRoZXNlIHBhdGNoZXMgYXJlIHBhcnQgb2YgUkZDIHNlcmllcyBbMV0gKHs0My00Niw0
OH0vNTApLA0KPiA+ID4gdGhlc2Ugd2VyZSBkcm9wcGVkIGVhcmxpZXIgYXMgdGhleSB3ZXJlbid0
IHBhcnQgb2YgLXJjIHJlbGVhc2UNCj4gPiA+IGF0IHRoZSB0aW1lIG9mIHBvc3Rpbmcgbm93IHRo
YXQgcGF0Y2hlcyBoYXZlIGxhbmRlZCBpbiB2NS4xMC1yYzENCj4gPiA+IEkgYW0gcmVzZW5kaW5n
IHRoZW0gd2l0aCBub24tUkZDIHRhZy4NCj4gPiA+DQo+ID4gPiBbMV0gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2NpcC1kZXYvDQo+ID4gPiAgICAgbGlzdC8/c2VyaWVzPTM2
MzI3OSZzdGF0ZT0lMkEmYXJjaGl2ZT1ib3RoDQo+ID4NCj4gPiBTZXJpZXMgbG9va3MgZ29vZCB0
byBtZS4NCj4gPg0KPiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3NzRhMS5k
dHNpICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlbmVzYXMvcjhhNzc0YjEuZHRzaSAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrDQo+
ID4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGMwLmR0c2kgICAgIHwgMTkg
KysrKysrKysrKw0KPiA+DQo+ID4gSSBzZWUgdGhhdCB0aGUgbm9kZXMgYXJlIHN0aWwgbWFya2Vk
IGFzICJkaXNhYmxlZCIuLi4gSSBndWVzcw0KPiA+IGRldmJvYXJkcyBhcmUgbm90IHBsdWdnZWQg
aW50byBpbnRvIFBDSWUgaG9zdHMgZm9yIHRoZSB0ZXN0aW5nLg0KPiA+DQo+IEl0J3MgdGhlIHNh
bWUgY29udHJvbGxlciB3aGljaCB3b3JrcyBhcyBhIGhvc3QgYW5kIGVuZHBvaW50IChQQ0llIEVQ
KS4gQnkgZGVmYXVsdCBvbiB0aGUgYm9hcmRzICBjb250cm9sbGVyIGlzIGVuYWJsZWQNCj4gYXMg
aG9zdCBhbmQgbm90IEVQIGFzIGEgcmVzdWx0IHN0YXR1cyBpcyBzZXQgdG8gZGlzYWJsZWQuIFNv
IGR1cmluZyB0ZXN0aW5nIGhvc3QgaXMgZGlzYWJsZWQgYW5kIEVQIGlzIGVuYWJsZWQuDQoNCk9L
Lg0KDQo+IA0KPiA+IEFueXdheSwgaXQgd291bGQgYmUgZ29vZCB0byBrbm93IGlmIHRoZSBtZXJn
ZWQgLWNpcCBjb2RlIHdhcyB0ZXN0ZWQNCj4gPiBhbmQgd2hhdCB3YXMgdGhlIHJlc3VsdCA6LSku
DQo+ID4NCj4gQXR0YWNoZWQgYXJlIHRoZSByZXN1bHRzIGZvciBHMk0gYXMgUENJZSBob3N0IGFu
ZCBHMk4gYXMgUENJZSBFUCB0ZXN0ZWQgb24gQ0lQIGtlcm5lbC4NCj4gDQo+IFNvIG9uIHRoZSBo
b3N0IHBjaWV0ZXN0IHJlYWQvd3JpdGUvY29weSBjb21tYW5kcyBhcmUgdGVzdGVkIChhbHNvIGxz
cGNpIG91dHB1dCkNCg0KVGhhbmsgeW91IGZvciBhdHRhY2hpbmcgdGhlIHRlc3QgcmVzdWx0cy4N
Ckkgd2lsbCBhcHBseSBhbmQgcHVzaCB0aGlzIHNlcmllcy4NCg0KPiANCj4gQ2hlZXJzLA0KPiBQ
cmFiaGFrYXINCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo=

--KxMMIng6nL4ijdGq4tRk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5697): https://lists.cip-project.org/g/cip-dev/message=
/5697
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KxMMIng6nL4ijdGq4tRk--
