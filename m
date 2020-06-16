Return-Path: <SRS0=VeJj=75=lists.cip-project.org=bounce+64572+4800+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F87CC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 16 Jun 2020 08:46:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843CB20786
	for <cip-dev@archiver.kernel.org>; Tue, 16 Jun 2020 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lza/5RX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843CB20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4800+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5IWtYY4521723xh2IWevZPzn; Tue, 16 Jun 2020 01:46:20 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.98])
 by mx.groups.io with SMTP id smtpd.web10.6397.1592297178812574012
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2020 01:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6DJ/Cm9Hpu16e/EH01WVtpH9IIAU/jFzkcLH71YSLFSpKPqYDfBS8SPE2mVjpX+R7mlj/MpAICarqt3AZfTQImv8+zLR3bluldPao7QZzR9rtg0rfVsc2IhN4r5GXBIAH9nUkE9POky0++Uw/F6jIy9cA9iVTLNnq7LPGe6ktFJxHyFmvtH8YsAxQaE80lm/6tA93HTSty1ZdNfN9zsum2Mmkgnfil8O6Dn1qUJU64Ln7mAEtxJr4MZUBo6fRiKnnF1PhbhIfC0BIur9qD/iAqjZ+WtvT41Py9F0kYy0xOa5UnNRtKszpxWwd3rHJLddId2zcrnTvEEIg4m/dYhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbX3XGbXAU6gFSHsN6stWStjM8N1AnetN8UI1zXTmH0=;
 b=AVY569r3RDvEBgwwFsRM4H8b6izDJ5cvLHBZQeJvLKtz7dGJy3P5xuQlrvbUfuy1gmCUgTgHtoIkDPn6OBTNlDOQ39Qy2IZZCmK8XuAldewn0n/XIIYVQAguLv0gcieTF2cNHZRGQy3X56mFwjwbaSzXmI7X2x46DH1jVVHPN9KIsGQ4J6x6awxoaJx0kDmMX3b/4Aflrh1eGEsNdn5JMlYX0mhByR5Kwe4cqUqhJprFNGfbQq3I3t8v4i+sBClcziEdiR43feu5hxmTd9Q3D8ypruBz9epyM39wgNxkGnQ9uaaxmIu2x6J+L10gqQFYlXKhciQmFx1g04+c4NDu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3681.jpnprd01.prod.outlook.com (2603:1096:604:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 08:46:16 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 08:46:16 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] FW: KernelCI plans for 2020-Q3
Thread-Topic: KernelCI plans for 2020-Q3
Thread-Index: AQHWQ6kV5EDPJ6EpiE6GSFw4psGhYaja7cAg
Date: Tue, 16 Jun 2020 08:46:16 +0000
Message-ID: 
 <OSAPR01MB2385F84F81A4447D80AA41CFB79D0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <4bdcfeaa-31bc-0b95-4b48-14dd4863358f@collabora.com>
In-Reply-To: <4bdcfeaa-31bc-0b95-4b48-14dd4863358f@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7bb704e-a47d-4daa-aa9a-08d811d1bb66
x-ms-traffictypediagnostic: OSAPR01MB3681:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3681ABE7F40D50F3B2492DF5B79D0@OSAPR01MB3681.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 A+7V/gbY3/8KrZAQIjJyWMqvPU95DGTFIkwNW5JF/lW0TLIfMy6OgU+ktFbw3vv/Jnf85b8AWesbOhzQf5LwlcQ9QpPT5xJBVWahCmLk8VhJSqO2HYADMF6B0d3OGCxqIaX+0gcu/j+LMSLYf8uku7pwrRgv5v0xSAZ+n+gueLBn4pH3Gm8HQoKwmEdCzwwF6OpY8xHyZO3GKH7FyfcDY2xSsCNc0hW7xcDhpDOW0Uz/G5d2g0xHUoHHFxzy1bd9mqOrhFEmRMztYTq+U/goHjzHI53KzHIawgJQEhdwznexmmqmqD+mUAi4glOdlQ61WRZzQH8I3/3CZB2SeaXoQ73Z2vf+E18sV8FUNJKae8GuHVw/Zh/MLjkCQPM5DOlcwxblh8a1CIRIsmorz65Y+w==
x-ms-exchange-antispam-messagedata: 
 GGr0wHTCYY1lSFdFUl1OxbjVIzHybsHwDrXRTzlin/5mKPAWCeDT2/J9OGuWpyz9UDfApN+DUKD75JHvC2WzuwHvAPghuLeSPKL2iFGXFmZrlMD36O6HJYvJ0GWkIrJ+DyJwOlYc8pZs4WzDPxkUA1fF5Oiw5YiPqXjjEcLlUDRMZcsXUE+AyBrj7wmldUVy+D38M5SE+0CK49ACYAy1bLP9t+BMY6KzLPm9e1Ko7to2YlrTOI/8mc/5W5/q6D1gR8IEYCb4hmqo92jaK2HZRlr5hsHboz6f4roWe49iUZKxgvwhbCLunyTJIiIOXtkOVHZAyPSih46zwbjQccT+e6wK/ypcR/LyQZQU5Nfh9jjECTFBKuvOqM4DW7bkZq+xGI9yI5EUO8w6wGIk9qmDqL18p46J0wWnV6nCITFjgfdKzhaYsOtHb3O4yBLcUznH92CxQuGuK+61TAPfGUqpfzY9I/1fb39Adsib5OWKSgptvUbuonaVpGm9jkGzny9Z
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb704e-a47d-4daa-aa9a-08d811d1bb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 08:46:16.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqTdHdcO49seHzeni0c9lL1YLE1ylaB3OrtN7LYARK6+Du9IQB9lEkYdLP+wAbJ2zzbi1JjHr+BvvNidKXFTFZmh1sNaOE08Kq7LXAlEQGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3681
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aLXk5IdCJPk4W7ccOrn4cLQ2x4520388AA=
Content-Type: multipart/mixed; boundary="AEoCJsY6JIiZTUZwrod0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592297180;
 bh=mpdS/crLbCvIAqLhHtnZDaO0NfqediU92NvReOFO1wo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lza/5RX7z+vfh1QsLUoXq4HbeFsxJ9c/38ssHY7sfMRBQb2m+Dq/O8fBeWh81TUWN7n
 oCA1M8T2hpWypGJZ2u/XuL+gFS900GdbDjlwyY53WigpO2uMNyNf5ZNrcx1M5+SIoXyOs
 QC4tEYJ6iIkBfAro6TV+OM2gV5NsVw9rtRA=

--AEoCJsY6JIiZTUZwrod0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RllJDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiBGcm9tOiBrZXJuZWxjaUBncm91cHMuaW8g
PGtlcm5lbGNpQGdyb3Vwcy5pbz4gT24gQmVoYWxmIE9mIEd1aWxsYXVtZQ0KPiBUdWNrZXIgdmlh
IGdyb3Vwcy5pbw0KPiBTZW50OiAxNiBKdW5lIDIwMjAgMDc6NDENCj4gDQo+IEFzIHlvdSBwcm9i
YWJseSBhbGwga25vdywgdGhlIExpbnV4IFBsdW1iZXJzIENvbmZlcmVuY2UgKExQQykgaXMNCj4g
Z29pbmcgdG8gYmUgS2VybmVsQ0kncyBuZXh0IG1pbGVzdG9uZSwgYXQgdGhlIGVuZCBvZiBBdWd1
c3QuDQo+IFdoaWxlIGl0J3Mgbm90IGVudGlyZWx5IGNsZWFyIHlldCB3aGljaCBvbmxpbmUgZm9y
bWF0IGl0IHdpbGwNCj4gYWRvcHQgYW5kIHdoZXRoZXIgd2UnbGwgYmUgYWJsZSB0byBkaXNjdXNz
IGFsbCB0aGUgdGhpbmdzIGFzIHdlDQo+IHdvdWxkIG5vcm1hbGx5IGRvIGZhY2UtdG8tZmFjZSwg
aXQgaXMgc3RpbGwgYSBrZXkgbW9tZW50IGZvcg0KPiBLZXJuZWxDSSBhbmQgdGhlIGtlcm5lbCBj
b21tdW5pdHkuDQo+IA0KPiBBIGxvdCBvZiBwcm9ncmVzcyBoYXMgYmVlbiBtYWRlIGluIEtlcm5l
bENJIG92ZXIgdGhlIHBhc3QgbW9udGhzLg0KPiBMaWtlIHdpdGggYW55IHByb2plY3QsIHNvbWUg
dGhpbmdzIHN0aWxsIG5lZWQgdG8gYmUgY29tcGxldGVkIGFuZA0KPiBvdGhlcnMgaGF2ZW4ndCBl
dmVuIHN0YXJ0ZWQgeWV0LiAgSW4gb3JkZXIgdG8gZm9jdXMgb3VyIGVmZm9ydHMNCj4gYW5kIGJl
IGluIGEgc3Ryb25nIHBvc2l0aW9uIGJ5IExQQywgd2UgaGF2ZSBvdXRsaW5lZCBvdXIgcGxhbnMg
aW4NCj4gdGhpcyBzaGFyZWQgZG9jdW1lbnQ6DQo+IA0KPiANCj4gaHR0cHM6Ly9kb2NzLmdvb2ds
ZS5jb20vZG9jdW1lbnQvZC8xS0NJdjZMM1hyc05GSXU0R3pGTVRWN1F4NkpsbTJ0cg0KPiBjLWJ2
UkliREVWVjgvZWRpdCMNCj4gDQo+IA0KPiBBbmQgbGlrZSB3aXRoIGFueSBjb21tdW5pdHkgcHJv
amVjdCwgbm9ib2R5IHJlYWxseSBoYXMgYW55DQo+IGNvbnRyb2wgb3ZlciB0aGUgYWN0dWFsIGNv
dXJzZSBvZiBldmVudHMuICBCdXQgaXQgaGVscHMgdG8gaGF2ZQ0KPiBzb21lIGd1aWRlbGluZXMg
YW5kIGFncmVlIG9uIHdoYXQgdGhlIHByaW9yaXRpZXMgc2hvdWxkIGJlLg0KPiBUaGF0J3Mgd2hh
dCB0aGUgcGxhbiBkb2N1bWVudCBpcyBoZXJlIGZvci4NCj4gDQo+IA0KPiBUaGVyZSBpcyBhbHNv
IGEgbmV3IEdpdEh1YiBwcm9qZWN0IGJvYXJkIGZvciAyMDIwLVEzLCBmb3IgdGhlDQo+IHRhc2tz
IHRoYXQgZml0IGluIHRoaXMgZm9ybWF0Og0KPiANCj4gICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9v
cmdzL2tlcm5lbGNpL3Byb2plY3RzLzINCj4gDQo+IA0KPiBUaGVyZSdzIHNvbWUgZXhjaXRpbmcg
d29yayBhaGVhZCBvZiB1cywgYW5kIHNldmVyYWwgb3Bwb3J0dW5pdGllcw0KPiB0byBncm93IHRo
ZSBwcm9qZWN0IHdpdGggbmV3IGNvbnRyaWJ1dG9ycy4gIEknbSBzdXJlIHdlJ2xsIGhhdmUNCj4g
dG8gb3ZlcmNvbWUgc29tZSBjaGFsbGVuZ2VzIGJ1dCB0aGVyZSdzIGV2ZXJ5IHJlYXNvbiB0byBi
ZQ0KPiBvcHRpbWlzdGljLiAgV2UndmUgY29tZSBhIGxvbmcgd2F5IGFscmVhZHkhDQo+IA0KPiAN
Cj4gVGhpcyBpcyBvZiBjb3Vyc2UgYWxsIG9wZW4gZm9yIGNvbW1lbnRzIGFuZCBxdWVzdGlvbnMs
IHBsZWFzZQ0KPiBmZWVsIGZyZWUgdG8gcmVwbHkgb24gdGhpcyB0aHJlYWQgb3Igb24gdGhlIHNo
YXJlZCBkb2N1bWVudC4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IEd1aWxsYXVtZQ0KPiANCj4gDQoN
Cg==

--AEoCJsY6JIiZTUZwrod0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4800): https://lists.cip-project.org/g/cip-dev/message=
/4800
Mute This Topic: https://lists.cip-project.org/mt/74912377/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AEoCJsY6JIiZTUZwrod0--
