Return-Path: <SRS0=ZNGs=6A=lists.cip-project.org=bounce+64572+4583+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471B1C352BE
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 10:14:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D8421BE5
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iUDOZi62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8421BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4583+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vpitYY4521723x5f4E6bS4em; Thu, 16 Apr 2020 03:14:53 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.124])
 by mx.groups.io with SMTP id smtpd.web10.3514.1587032091849521315
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2020 03:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6KeJ7DfXonHZezTk5d22xOLTOBEAXzqAvxJn9oymxZOwt8Wme39AnOAffnMZCn+vk4Sp7MlluhZMedFYYv5POVRnKwDxJ9/Pv7kdcQij2Yujo06svk+7uVW8DQTQjS+FfrjaHL9ofm9Dwy7uEiL5+W7HLGcLnR90635DyH3bpJpbJdPuFML2Jro4NArOlioml4zADYMSCFvRSzBgqRan8atjLlhAR45vQnL2lG+3dOnHpd0EaEi9owz0/9NsmNx6nX3T3WIQRGWcr2cooRjUZ+LLb41BE3NrDdJFDCxMup/GjHj0AM1agDje+kybHzVtGhtibQFtTJEX9U/+Agbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp+XYMjMexy/wjEa9Gi6P+6D8SleqVTApSmfS//o07U=;
 b=AajEWIk5R8NG8A2XA0SXMTvTiKNtV8+LG/kqQ5qdEM8p3HFGXWYXxoIf6gWguP3LjFHZS+djs9WX8+gAsdJuWcHVIo8LzdNETUY0+Zz8lJ+Dyr2r2Ksmnnq/v+6Qdddv0gaiacbw0B0t/8Fn392ga63rUru0d96Uars0xdNe+54cZcQVWTO12bjizJ8V+BSOwUsovlZyGD5kDUXVE7bT6cDp240NShmudwnSp+SYGrQqWuNkakZUHY7USS1/5RBJk57qXIHGtbICQ1p4ATf7rT1mz2xrI37E4SPx5cBU6JXDUKJyduCo6d1OlUFgnnWBMnbb32SlD2vVhHOWYtFLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com (20.177.101.84) by
 TYAPR01MB4894.jpnprd01.prod.outlook.com (20.179.186.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Thu, 16 Apr 2020 10:14:49 +0000
X-Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::958e:eb9a:9175:b3c2]) by TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::958e:eb9a:9175:b3c2%4]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 10:14:49 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-security] [cip-dev] Python 3.x vs 2.7
Thread-Topic: [cip-security] [cip-dev] Python 3.x vs 2.7
Thread-Index: 
 AdYI0Y7wF02Ds+P+SQqCBlZlaiG5IABL904AAH62CgAAGFYHgAAR8NGQADgryrABkyHcAA==
Date: Thu, 16 Apr 2020 10:14:49 +0000
Message-ID: 
 <TYAPR01MB239905C2311C07AA482C3E78DFD80@TYAPR01MB2399.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <20200403214708.GA32080@duo.ucw.cz>
 <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
 <20200406215205.GA14162@amd.ucw.cz>
 <TYAPR01MB2399CAF8B56C489427E7A791DFC30@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <TY2PR01MB4972F1FB23E46E7D2DA46482A0C00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972F1FB23E46E7D2DA46482A0C00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:268:c05e:3df6:ec27:e88f:9d8d:45e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb37371f-9d4e-4118-2a0a-08d7e1eefeed
x-ms-traffictypediagnostic: TYAPR01MB4894:
x-microsoft-antispam-prvs: 
 <TYAPR01MB4894AAFC24FEF77E16A3C29ADFD80@TYAPR01MB4894.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 dMeuORNpH6tCXMTDarh7y2O11YvQya1vBIhydknKd7QjttWg9zYtRj4ApEanUSVE6S8foDFo1He2jIcWfwMegGM70fU4LLlBggDWsSGOnkXXWF+hY3/VD9xGnJuNLWeu+wGfXDgCtKV7Rqi/fGiQ8qmijDgOhaEjkMV/z/6Y0tGUpkr5bEMmQ8V5ZxzZgLWLUA1B3NzHKWWmp3nJZouonWAtuddhRvuUYx1ABMRrpO/NpdatntTUdiQbGsJTrcNw9Oe5/O6x1DyUytsh8beAXl3mnSzukFzuaUN0woSolX6EDLoEKyU0lEwLj5SgnwhSXVOMuKthp6PIbkbrGjONN1yXjrVofZWQWMjggCT5oD+zKWmvIjiePz4n14enHG1++lIJVto6J/4VvWZKHi9CqGv1DznL2uXulWf79bNH0gFbtDIxMg1g60JJSA9uVBUU+5nRwOAM55EfIn7VmLjtiSjHDoDiRX4FAd0nBsvtYtEevcTLcrLCtypzJwsNc5lRR2kxwYIIEc0IWPR90YWYdQ==
x-ms-exchange-antispam-messagedata: 
 tGOtcGXaKxM4Gt3+uSYMsif+4BUBVVEeje+QqEKU0Ou+78hvHsITnHIf30Alx5AQfmBW+lMOTAxE9B9nTWnll43KOPsPgYz5Hk3XIdYM8/SWBi7Ul9ydObAmb0poTwSqSKqTGYu84wyjGssHvaNdKTQIul9IwgadQgLfhk7Y19LabYWlE5SfedT1X/sNgUacwHXAhkAv99qD4DbqIU6oKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb37371f-9d4e-4118-2a0a-08d7e1eefeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 10:14:49.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rU9ZgD/w72xCCUTL/2qVIvUKb+VVclkMPJO59jDOjOhw28TtPXI/4oyjJPIV4u7vblUjmeLgNKc4iQoM8k/FiZM4ayTTKTt6t86XbZ/JGMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4894
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bTOgCbbWVM1nPitSx85NwON5x4520388AA=
Content-Type: multipart/mixed; boundary="j6RutiZ0Cl3nwrE4LNoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587032093;
 bh=s71ZAG3nfH3nCNZkr6JvgHki4rAxV6e/otxH7n4iHkQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=iUDOZi62nFl1bZDVFlE8ozrS9M/ThE8xlwqNRI5TAFc7s4qiEB59Y3HRXiJhGhUdc1M
 FIQuFrWuM5OhQhbX1sTKk8SKhoDqnpcmpj6Dxw/IYq0yaL1akRhvr5n5iaXoIr6pbBcKS
 3V3/q1pqYIHwsF/+JPwB8kvZLu0alvrAV7k=

--j6RutiZ0Cl3nwrE4LNoW
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkknbGwgc2hhcmUgeW91IHRoZSBmdW5jdGlvbmFsIHJlcXVpcmVtZW50cyBmb3Igc3lz
dGVtIGJhY2t1cDoNCg0KMS4gUmVndWxhciBwZXJpb2RpYyBiYWNrdXANCjIuIERpZmZlcmVudGlh
bCBhcmNoaXZlcyBiYWNrdXAgKHRvIGJlIGxpZ2h0IG5vdCB0byBhZmZlY3Qgbm9ybWFsIG9wZXJh
dGlvbikNCjMuIEVuY3J5cHRpbmcvRGVjcnlwdGluZyB0aGUgYmFja3VwIGRhdGENCjQuIFJldHVy
biB0byBjaGVja3BvaW50IGFuZCByZXN0YXJ0DQoNCldlIHNlbGVjdGVkIHRoZSBkdXBsaWNpdHkg
YXMgdGhlIHBhY2thZ2UgdGhhdCBtZWV0IHRoZXNlIHJlcXVpcmVtZW50LCBhbmQgdGhlIGR1cGxp
Y2l0eSBoYWQgc21hbGxlciBkZXBlbmRlbmNpZXMgY29tcGFyZWQgdG8gc2ltaWxhciBwYWNrYWdl
cy4NCg0KQnV0IHdlIG5lZWQgdG8gZGVlcGx5IGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgcG9pbnQ6
DQoNCiJIb3cgdG8gaGFuZGxlIHBhY2thZ2VzIHdpdGggZGVwZW5kZW50IHBhY2thZ2VzIHN1Y2gg
YXMgcHl0aG9uIDIuNyB0aGF0IGFyZSBub3Qgc3VpdGFibGUgZm9yIGxvbmctdGVybSBtYWludGVu
YW5jZSwgaS5lLiBFT0wuIg0KRG8gd2UgbmVlZCB0byBleGNsdWRlIHRoYXQga2luZCBvZiBwYWNr
YWdlPw0KT3IsIGRvIHdlIGJhY2twb3J0IGZyb20gdGhlIHVwcGVyIHZlcnNpb24/IGJ5IENJUD8g
T3IsIGZ1bmRpbmc/IGV0Yy4uLg0KDQpJJ2xsIHN1Ym1pdCB0byB0aGUgbGlzdCBhcyB0aGUgYWdl
bmRhIG9mIG5leHQgQ0lQIGNvcmUgbWVldGluZyBhcyBhbiBpc3N1ZSB0aGF0IHJlcXVpcmVzIGEg
Y29tbW9uIHBvbGljeSwgbm90IGp1c3QgYSBkdXBsaWNpdHkgaXNzdWUuDQoNCkJlc3QgcmVnYXJk
cywgS2VudA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJl
aGFsZiBPZg0KPm1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwIHZpYSBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNCj5TZW50OiBXZWRuZXNkYXksIEFwcmlsIDgsIDIwMjAgNjoyNCBQTQ0KPlRvOiBj
aXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBkZW54LmRlOyBqYW4ua2lz
emthQHNpZW1lbnMuY29tDQo+Q2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U3Vi
amVjdDogUmU6IFtjaXAtc2VjdXJpdHldIFtjaXAtZGV2XSBQeXRob24gMy54IHZzIDIuNw0KPg0K
PkhpLA0KPg0KPlRoZSBzZWN1cml0eSBXRyBub21pbmF0ZWQgZHVwbGljaXR5IGFzIGEgc29sdXRp
b24gZm9yICJDb250cm9sIHN5c3RlbSBiYWNrdXAiDQo+KENSNy4zKS4NCj5PbmUgb2YgdGhlIGNv
bW1vbiByZXF1aXJlbWVudHMgb2Ygc3VjaCBiYWNrdXAgc29mdHdhcmUgaXMgY2hlY2stcG9pbnQg
cmVzdGFydA0KPmNhcGFiaWxpdHkuDQo+RHVwbGljaXR5IHByb3ZpZGVzIHRoaXMgbGlrZSB0aGUg
Zm9sbG93aW5nLg0KPmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvZHVwbGlj
aXR5LWFubm91bmNlLzIwMDktMDYvbXNnMDAwMDAuaHQNCj5tbA0KPg0KPklNSE8sIEkgdGhpbmsg
dGFyIGlzIG5vdCBtZXQgSUVDNjM0NDMtNC0yIHJlcXVpcmVtZW50LCBiZWNhdXNlIHRhciBpdHNl
bGYgZG9lcyBub3QNCj5oYXZlIHRoaXMgY2FwYWJpbGl0eSwNCj4NCj5CZXN0IHJlZ2FyZHMsDQo+
LS0NCj5NLiBLdWRvDQo+DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBjaXAt
c2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXBy
b2plY3Qub3JnPiBPbg0KPkJlaGFsZiBPZiBLZW50byBZb3NoaWRhDQo+U2VudDogVHVlc2RheSwg
QXByaWwgNywgMjAyMCAzOjQ5IFBNDQo+VG86IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47
IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Q2M6IGNpcC1zZWN1cml0eUBs
aXN0cy5jaXAtcHJvamVjdC5vcmc7IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U3Vi
amVjdDogUmU6IFtjaXAtc2VjdXJpdHldIFtjaXAtZGV2XSBQeXRob24gMy54IHZzIDIuNw0KPg0K
PkhpLA0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBQYXZlbCBNYWNo
ZWsgPHBhdmVsQGRlbnguZGU+DQo+PlNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIwMjAgNjo1MiBB
TQ0KPj5UbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4+Q2M6IFBhdmVs
IE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEtlbnRvIFlvc2hpZGENCj4+PGtlbnRvLnlvc2hpZGEu
d3pAcmVuZXNhcy5jb20+OyBjaXAtc2VjdXJpdHlAbGlzdHMuY2lwLXByb2plY3Qub3JnOw0KPj5j
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPj5TdWJqZWN0OiBSZTogW2NpcC1kZXZdIFB5
dGhvbiAzLnggdnMgMi43DQo+Pg0KPj5PbiBNb24gMjAyMC0wNC0wNiAxMjoxNToxNiwgSmFuIEtp
c3prYSB3cm90ZToNCj4+PiBPbiAwMy4wNC4yMCAyMzo0NywgUGF2ZWwgTWFjaGVrIHdyb3RlOg0K
Pj4+ID4gSGkhDQo+Pj4gPg0KPj4+ID4gPg0KPj4+ID4gPiBGWUksIHVuZm9ydHVuYXRlbHkgd2Ug
Y291bGRuJ3QgZmluZCB0aGUgYWx0ZXJuYXRpdmUgcGFja2FnZSBmb3INCj4+c3lzdGVtIGJhY2t1
cC4gVGhlIGR1cGxpY2l0eSBpcyB0aGUgYmVzdCBwYWNrYWdlIGZvciB1cyBmcm9tIHRoZQ0KPj5s
aWNlbnNlIGFuZCBudW0gb2YgZGVwZW5kZW5jaWVzIHBvaW50IG9mIHZpZXcuDQo+Pg0KPj4+ID4g
PiBTZWUgdGhlIGZvbGxvd2luZy4NCj4+PiA+ID4NCj4+PiA+DQo+Pj4gPiA+IDxkdXBsaWNpdHk+
DQo+Pj4gPiA+IEVuY3J5cHRpb246IFllcw0KPj4+ID4gPiBTY2hlZHVsZSBiYWNrdXA6IE5vDQo+
Pj4gPiA+IEluY3JlbWVudGFsIGJhY2t1cDogWWVzDQo+Pj4gPiA+IExpY2Vuc2U6IEdQTCB2Mg0K
Pj4+ID4gPiBEZXBlbmRlbmNpZXMgY291bnQgKGFwcm94KTogODANCj4+PiA+ID4gUmVmZXJlbmNl
OiBodHRwOi8vZHVwbGljaXR5Lm5vbmdudS5vcmcvZmVhdHVyZXMuaHQNCj4+PiA+DQo+Pj4gPiBJ
J20gbm90IHN1cmUgd2hhdCB5b3VyIGV4YWN0IHJlcXVpcmVtZW50cyBhcmUsIGJ1dCBoYXZlIHlv
dQ0KPj5jb25zaWRlcmVkDQo+Pj4gPiAidGFyIj8gSXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHBp
cGUgaXRzIG91dHB1dCB0byBhZXNwaXBlIChhbmQNCj4+PiA+IHBvc3NpYmx5IG90aGVyIHRvb2xz
KSB0byBnZXQgZW5jcnlwdGlvbiwgYW5kIGl0IHNob3VsZCBiZSBhYmxlIHRvDQo+PmRvDQo+Pj4g
PiBpbmNyZW1lbnRhbCBiYWNrdXBzLi4uDQo+Pj4NCj4+PiBJIHN1cHBvc2UgdGhlcmUgaXMgdGhh
dCBjb25jZXJuIGFib3V0IEdQTHYzIGFnYWluIChhcyB3aXRoIGJyb2FkbHkNCj4+dXNlZA0KPj4+
IHJzeW5jKSAtIHdoaWNoIGlzIGdlbmVyYWxseSBvdmVycmF0ZWQuIFRoZXJlIGV4aXN0cyBsZWdh
bCB2aWV3cyB0aGF0DQo+PmFscmVhZHkNCj4+PiBHUEx2MiByZXF1aXJlcyB0byBrZWVwIHN1Y2gg
bGljZW5zZWQgY29tcG9uZW50cyByZXBsYWNlYWJsZSBvbiB0aGUNCj4+dGFyZ2V0Lg0KPj4+IFdo
YXQgdGhlbiBlZmZlY3RpdmVseSByZW1haW5zIHdpdGggdjMgaXMgaXRzLCB3ZWxsLCB3b3JkaW5n
DQo+PmNvbXBsZXhpdHkuDQo+Pg0KPj5Eb2VzICJ0YXIiIG1hdGNoIHRoZSByZXF1aXJlbWVudHM/
DQo+Pg0KPj5BbmQgSSBhZ3JlZSB0aGF0IGJlc3Qgb3B0aW9uIHdvdWxkIGJlIHRvIGFjY2VwdCBH
UEx2My4NCj4+DQo+DQo+U29tZSBvZiB0aGUgc2VjdXJpdHkgbWVtYmVycyBkaWRuJ3QgYWNjZXB0
IEdQTHYzLCBzbyBjdXJyZW50bHkgd2UgZHJvcHBlZA0KPkdQTHYzIHBhY2thZ2VzIGZyb20gdGhl
IGNhbmRpZGF0ZXMuDQo+DQo+QlRXLCBJJ20gbm90IHN1cmUgYnV0IGlzIHRoZSBDSVAgcG9saWN5
IG9uIGFjY2VwdGluZyBHUEx2MyBzdGlsbCB0byBiZSBkZWNpZGVkPw0KPg0KPj5JZiB0aGF0J3Mg
b3V0IG9mIHF1ZXN0aW9uLCBJJ20gcHJldHR5IHN1cmUgd2UgY2FuIGdldCBHUEx2MiB0YXINCj4+
aW1wbGVtZW50YXRpb24gc29tZXdoZXJlLiBidXN5Ym94IGhhcyBpbXBsZW1lbnRhdGlvbiwgYW5k
IEknbSBwcmV0dHkNCj4+c3VyZSB0aGVyZSdzIEdQTHYyIGZvcmsgb2YgYnVzeWJveC4gT2xkIHZl
cnNpb24gb2YgdGFyIHNob3VsZCBiZSBHUEx2Mi4NCj4+U3RpbGwgYmV0dGVyIHRoYW4gcG9ydGlu
ZyBkdXBsaWNpdHkgdG8gZGlmZmVyZW50IHB5dGhvbiB2ZXJzaW9uLi4uDQo+Pg0KPg0KPlRoYW5r
IHlvdSBmb3IgaW50cm9kdWN0aW9uIGFib3V0ICJ0YXIiLg0KPkkgd2lsbCBpbnZlc3RpZ2F0ZSB3
aGV0aGVyIGl0IG1lZXRzIHRoZSByZXF1aXJlbWVudHMuDQo+QW5kIGFsc28gSSdsbCBzZWFyY2gg
R1BMdjIgaW1wbGVtZW50YXRpb24gaWYgaXQgbWVldHMgdGhlIHJlcXVpcmVtZW50cy4NCj5JZiBp
dCdzIG5vdCBkZWNpZGVkIHlldCBhYm91dCB0aGUgQ0lQIHBvbGljeSBvbiBhY2NlcHRpbmcgR1BM
djMsIHdlIGNhbm5vdCBhZG9wdA0KPkdQTHYzIHBhY2thZ2VzLg0KPg0KPkFueXdheSwgSSBhZ3Jl
ZWQgaXQgaXMgZGlmZmljdWx0IHRvIHN1cHBvcnQgcHl0aG9uIDIgZm9yIGEgc3VwZXIgbG9uZyB0
ZXJtLiBBbmQNCj5ldmVyeW9uZSBhZ3JlZWQgb24gdGhpcyBwb2ludC4NCj5Tbywgd2UgY2Fubm90
IHN1cHBvcnQgZWFjaCBsaWJyYXJpZXMgdXNpbmcgcHl0aG9uIDIsIGF0IGxlYXN0Lg0KPg0KPkJl
c3QgcmVnYXJkcywgS2VudA0KPg0KPj5CZXN0IHJlZ2FyZHMsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQYXZlbA0KPj4t
LQ0KPj5ERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0
b3I6IFdvbGZnYW5nIERlbmsNCj4+SFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0
ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo+DQo+DQoNCg==

--j6RutiZ0Cl3nwrE4LNoW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4583): https://lists.cip-project.org/g/cip-dev/message=
/4583
Mute This Topic: https://lists.cip-project.org/mt/72870644/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j6RutiZ0Cl3nwrE4LNoW--
