Return-Path: <SRS0=6j+G=ER=lists.cip-project.org=bounce+64572+5790+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D6C55ABD
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 13:18:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0052074B
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BYYYnMtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0052074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5790+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JKdbYY4521723xxc5x1lIbtO; Wed, 11 Nov 2020 05:18:49 -0800
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.91])
 by mx.groups.io with SMTP id smtpd.web11.6623.1605100727565878897
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 05:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/uRhjBPloNBY03GkjawnXzoepFUw8HP0OchoxK/ucDyW5nmIt0XHVGKrGCkPMTA+F5FkhlIEdp1u04ec/1hxqMl1+CszwruNh5KLn1Vu9EtilpYeAMYosQHlWKT/aWamUs49h5mTMkTsqAPJ6vUOSJ38fiR84EmbSF2PK1SA6koBIAABvtwzC+JLdnSGIhJMyz3xmPgcsDefC1TxhSdG2Zbggw9L5UD7jH7lAyItyRyxp5y3T3/Gcju8Q1VlTCS3NKuJNpWngkuFrpNP2QrBQ0owg3y4Wn1i3dzZtpT6k4UbHtiQYH+wS78kka0wBYriSdVjMlB50lpVCOB6JkpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb72GDGx70udXQvY2OAFt0dkRoj5i8jBeDEU/RsQGe0=;
 b=FXM5d4Fwl2fnj3XSr9VNSNYwl0rfK1ae1f9zfhHC9i2C91DJ9OxGqSjTQLMLF865FtyjetRVw2ZvqDvHdddn2ZR2cYxN3iGQU+cLd4uzrhr5LyLY6N2V2RtsD5/p1FxpJq9UaCCFbulku7+AhFrGCfH5jpSlagCEaCJF+2Avm7z7cw+1tibNbyz5Mazo70+Iaj4xuxOa/NfX/OkUkVJVq/WH1fXU8fQXGlgh3v9u3CwT5GS0Aw9FNab90ANTgyaf78KijTCTfYXV/+PaL8eS1HSYiMwjXpRIiPFsS64x0CAwdZDU0cl5gI88mQmdzhJ/ytEOegKYjLTVsDMhmyuQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3403.jpnprd01.prod.outlook.com (2603:1096:404:dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 13:18:30 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 13:18:30 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Thread-Topic: [cip-dev] Backporting of security patches for Intel i40e drivers
 required?
Thread-Index: AdadV2Jnu1CNqzkrSoynC++LmpFHXAAeQTNQAA8zFIAGh1Kw0A==
Date: Wed, 11 Nov 2020 13:18:30 +0000
Message-ID: 
 <TY2PR01MB4972EDB29B2AB0B3AE5E363DA0E80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
In-Reply-To: <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 721369ab-9b61-4dd1-a92e-08d886444849
x-ms-traffictypediagnostic: TY2PR01MB3403:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3403B8488B1A8A680F7B8802A0E80@TY2PR01MB3403.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 lwOWJ9lt4SA0Q6VBuEoaS0MPUoorM5cO4ZmYpKM1bb1MdW6OCX9QV8fwUgBVZ+amscyWu+VXfR/qfs/8m/HjRTgRMovCd5ao+W23HPWX2CzCcXTWQO0qqU4lI2MkNlwHGESpaF5XQoexDmbNC1NxhgVOdzjGSHJigcsHGkRHWOKP3fRWI+ALyKleA3lqd5ZhVosihRTR6FzPJGq2qvs1dBRV5VxnXHL6iqEy+Loo2o6NTXtkz0Q3F1nL8FD45z85zoTomnndyj5uEOH9Tise3AOHQ5KvlfzUicF4vBmilWa578qBPpN3WLCjjyFk3ghp0PWIUUO52SjGiH3dW1RcdR2/i6KAAQidupQp6Jg2w6Gxh4DCPq1mleezu17SG0jxdRa+94n1qRjCwYY4AIEJ4g==
x-ms-exchange-antispam-messagedata: 
 L3+g2Chfz6ZcqbyFKJv+o/J0VcJcZNnsdG0Dq+9Gytg8o/wKw8OnnGLUSf6pf5cJblSUHt+csUpcDHmpd8BSvwbbRmzDpYaGVcTlvJW0M6KglSvznyVCqzO8KIYDsfGYMOvhWzS+KOfjOMmTSIN8nLQuOLQa++HgCCke876yzGlo+OstnjDsYAhpS+wv+BZ2dI8DyGbW2IyWGYTmXoHVaoTuD+SWNtVgPfWvWnbU2rWEAg2BqRphO5cw1lb21+/KS35BWqUMHvghTdW8tZQgTCuWsTcyXONUa3WI882RmUunPvs7lZQV1wYFYWoWuckCzckcNGCt9vZUnSbXWlkmAfEEle637N+D/ZaPCF8xBZzYy8AA1pFkn3g4rDTlNwg8G6Ue5PuPo/bmbG9zW38mqw/kg/KQ6HtQaa+4QvQYMXzZVXCYhS7f+pr64Ckwg7EaCzSTcJ9RObjgYm0cSykVTsjYsatyLpixKy6bZfiSOFkMBrGuITuzFrlKLGgPlwC7Q5u9Rsu/NsK/uCzcLik0QRCo5MAReg0iAywDAJ742+WZOtekX2dRrrTtdCGR/iIXyz+l9DyJH4njsiEFsoZuhpP1QM9/jZcXY0TreHW/ItHp/x655oBQOGnE/xuoCC+uL+wlemes0VZn+ZZoWtIiQw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721369ab-9b61-4dd1-a92e-08d886444849
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 13:18:30.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6J1mQXnXoS9LjiHZcsjkH27diMWSAQI56O0fF1trYGmHT1e/x7rNF0h03XonBFwoh/H4kBc97JVMPbay5LcJ8qxlv/MPSxdpHZoMtf1LUBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3403
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rsrvPC9z6ZI11PQp4ZYTPhOwx4520388AA=
Content-Type: multipart/mixed; boundary="PwJYrf93iIoqBmwa7Vud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605100729;
 bh=HzRpoLFZUBu3hiULKuHwvF/8DKoED6VEXu9I1hM5F58=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BYYYnMtrocMuQXDQ2czZesTLJWGfuiHrJpwrTylQaBkiDImUUvyCI2oxeQ20mr83+Hv
 LeijFa5RUbt1RBTDCewHl+8GB0MO1fwNZg6xt06FKWd5yKrRBYopf/2mWN1xYUo3VGPHO
 hwY7AZYbJr9BnD76lFCGfi9a4eTb1PGaxXQ=

--PwJYrf93iIoqBmwa7Vud
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIA0KDQpUaGUgb3RoZXIgZGF5LCBJIGlucXVpcmVkIGFib3V0IENWRS0yMDE5LTAxNDUsIENW
RS0yMDE5LTAxNDcsIGFuZCBDVkUtMjAxOS0wMTQ4IGluIHRoZSBmb2xsb3dpbmcgZW1haWwuDQoN
ClRoZSBrZXJuZWwgdGVhbSBkaXNjdXNzZWQgZm9yIHdlZWtzIGhvdyB0byBkZWFsIHdpdGggdGhl
bS4NCkFzIGEgcmVzdWx0IG9mIHRoZXNlIGRpc2N1c3Npb25zLCB3ZSBjb25jbHVkZWQgdG8gaWdu
b3JlIHRoZW0gdW50aWwgSW50ZWwgZml4ZXMgaXNzdWVzLCBiZWNhdXNlOg0KIC0gVGhlIGRlc2Ny
aXB0aW9ucyBvZiBwYXRjaGVzIGFyZSBub3QgY2xlYXIsIGFuZCB3ZSBjYW5ub3QgZmlndXJlIG91
dCB3aGF0IGlzIHJpZ2h0DQogLSBUaGUgcGF0Y2hlcyB3ZSBpZGVudGlmaWVkIGRvIG5vdCByZWFs
bHkgbG9vayBsaWtlIGZpeGluZyB0b28gc2VyaW91cyBzdHVmZi4NCg0KU28gZmFyLCB3ZSBoYWQg
dGhlIGZvbGxvd2luZyBBSSwgYnV0IHdlIGNsb3NlIHRoaXMgYmFzZWQgb24gdGhlIGFib3ZlIHNp
dHVhdGlvbi4NCg0KMi4gQ2hlY2sgd2hldGhlciBDVkUtMjAxOS0wMTQ1LCBDVkUtMjAxOS0wMTQ3
LCBDVkUtMjAxOS0wMTQ4IG5lZWRzIHRvIGJlIGJhY2twb3J0ZWQgdG8gNC40IC0gS2VybmVsIFRl
YW0NCg0KQmVzdCByZWdhcmRzLA0KLS0NCk0uIEt1ZG8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBKYW4gS2lzemthDQo+IFNlbnQ6
IEZyaWRheSwgT2N0b2JlciA5LCAyMDIwIDQ6MjQgUE0NCj4gVG86IG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0
OiBSZTogW2NpcC1kZXZdIEJhY2twb3J0aW5nIG9mIHNlY3VyaXR5IHBhdGNoZXMgZm9yIEludGVs
IGk0MGUgZHJpdmVycw0KPiByZXF1aXJlZD8NCj4gDQo+IEhpIGFsbCwNCj4gDQo+IGdpdmVuIHRo
ZSBleHBvc3VyZSBvZiBzdWNoIGEgZGV2aWNlIGJ1dCBhbHNvIHRoZSBmYWN0IHRoYXQgSSBjYW4n
dCB0ZWxsIGZvciBzdXJlDQo+IGlmL3doZXJlIGl0J3MgdXNlZCAobm90IG9ubHkgYnkgdXMpLCBJ
IHdvdWxkIHJlY29tbWVuZCBiYWNrcG9ydGluZy4NCj4gDQo+IEphbg0KPiANCj4gT24gMDkuMTAu
MjAgMDI6MjMsIG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gSSBoYXZlIHNvbWUgY29tbWVudCBmb3IgdGhpcyBpc3N1ZS4NCj4gPg0KPiBo
dHRwczovL2xpc3RzLm9zdW9zbC5vcmcvcGlwZXJtYWlsL2ludGVsLXdpcmVkLWxhbi9XZWVrLW9m
LU1vbi0yMDIwMDgxMC8wMjENCj4gMDA2Lmh0bWwNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3N0YWJsZS8yMDIwMDgwNzIwNTUxNy4xNzQwMzA3LTEtamVzc2UuYnJhbmRlYnUNCj4g
PiByZ0BpbnRlbC5jb20vDQo+ID4NCj4gPiBUaGVyZSBhcmUgbXVsdGlwbGUgcGF0Y2hlcyBmaXhl
ZCBmb3IgNC4xOSwgd2hpY2ggY2FuIGJlIHNlcGFyYXRlZCBieSBmZWF0dXJlLg0KPiA+DQo+ID4g
IC0gaTQwZTogYWRkIG51bV92ZWN0b3JzIGNoZWNrZXIgaW4gaXdhcnAgaGFuZGxlcg0KPiA+DQo+
ID4gICAgICBUaGlzIGlzc3VlIGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUzMjE5Y2U2YTc3NTQgKCJp
NDBlOiBBZGQgc3VwcG9ydCBmb3INCj4gY2xpZW50IGludGVyZmFjZSBmb3IgSVdBUlAgZHJpdmVy
IikuDQo+ID4gICAgICBlMzIxOWNlNmE3NzU0IGlzIG5vdCBpbmNsdWRlZCBpbiA0LjQueSBhbmQg
Y2FuIGJlIGlnbm9yZWQuDQo+ID4NCj4gPiAgLSBpNDBlOiBXcm9uZyB0cnVuY2F0aW9uIGZyb20g
dTE2IHRvIHU4DQo+ID4gICAgVGhpcyBjYW4gYmUgYXBwbHkgaW4gNC40LnkuDQo+ID4NCj4gPiAg
LSBpNDBlOiBGaXggb2YgbWVtb3J5IGxlYWsgYW5kIGludGVnZXIgdHJ1bmNhdGlvbiBpbiBpNDBl
X3ZpcnRjaG5sLmMNCj4gPg0KPiA+ICAgIFRoaXMgaXNzdWUgaGFzIGJlZW4gcHJvZHVjZWQgYnkg
ZTI4NGZjMjgwNDczYiAoImk0MGU6IEFkZCBhbmQgZGVsZXRlDQo+IGNsb3VkIGZpbHRlciIpLg0K
PiA+ICAgIEl0IGlzIG5vdCBpbmNsdWRlZCBpbiA0LjQueS4gSG93ZXZlciwgdGhpcyBwYXRjaCBo
YXMgc2V2ZXJhbCBkaWZmZXJlbnQgZml4ZXMsIHNvDQo+IHNvbWUgcGF0Y2hlcyBuZWVkIHRvIGJl
IGFwcGxpZWQuDQo+ID4NCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBl
L2k0MGVfdmlydGNobmxfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2k0MGUvaTQwZV92aXJ0Y2hubF9wZi5jDQo+ID4gQEAgLTE4MSw3ICsxODEsNyBAQCBzdGF0aWMg
aW5saW5lIGJvb2wgaTQwZV92Y19pc3ZhbGlkX3ZzaV9pZChzdHJ1Y3QNCj4gPiBpNDBlX3ZmICp2
ZiwgdTE2IHZzaV9pZCkNCj4gPiAgICogY2hlY2sgZm9yIHRoZSB2YWxpZCBxdWV1ZSBpZA0KPiA+
ICAgKiovDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBpNDBlX3ZjX2lzdmFsaWRfcXVldWVfaWQo
c3RydWN0IGk0MGVfdmYgKnZmLCB1MTYgdnNpX2lkLA0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICB1OCBxaWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHUxNiBxaWQpDQo+ID4g
IHsNCj4gPiAgICAgIHN0cnVjdCBpNDBlX3BmICpwZiA9IHZmLT5wZjsNCj4gPiAgICAgIHN0cnVj
dCBpNDBlX3ZzaSAqdnNpID0gaTQwZV9maW5kX3ZzaV9mcm9tX2lkKHBmLCB2c2lfaWQpOw0KPiA+
DQo+ID4NCj4gPiAgLSBpNDBlOiBNZW1vcnkgbGVhayBpbiBpNDBlX2NvbmZpZ19pd2FycF9xdmxp
c3QNCj4gPiAgICBUaGlzIGlzc3VlIGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUzMjE5Y2U2YTc3NTQg
KCJpNDBlOiBBZGQgc3VwcG9ydCBmb3INCj4gY2xpZW50IGludGVyZmFjZSBmb3IgSVdBUlAgZHJp
dmVyIikuDQo+ID4gICAgZTMyMTljZTZhNzc1NCBpcyBub3QgaW5jbHVkZWQgaW4gNC40LnkgYW5k
IGNhbiBiZSBpZ25vcmVkLg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+ICAgTm9idWhpcm8N
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+PiBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXBy
b2plY3Qub3JnXSBPbiBCZWhhbGYgT2YNCj4gPj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28u
anANCj4gPj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyMCA2OjQzIFBNDQo+ID4+IFRv
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+PiBDYzogamFuLmtpc3prYUBzaWVt
ZW5zLmNvbQ0KPiA+PiBTdWJqZWN0OiBbY2lwLWRldl0gQmFja3BvcnRpbmcgb2Ygc2VjdXJpdHkg
cGF0Y2hlcyBmb3IgSW50ZWwgaTQwZSBkcml2ZXJzDQo+IHJlcXVpcmVkPw0KPiA+Pg0KPiA+PiBI
aSwgSmFuLXNhbiwgQWxsLA0KPiA+Pg0KPiA+PiBBdCB0aGUgSVJDIG1lZXRpbmcgdG9kYXksIHdl
IGlkZW50aWZpZWQgdGhlIGZvbGxvd2luZyBuZXcgQ1ZFcyBhcmUgbm90IGluDQo+IExUUzQuNCB5
ZXQuDQo+ID4+DQo+ID4+IC0gQ1ZFLTIwMTktMDE0NSwgQ1ZFLTIwMTktMDE0NywgQ1ZFLTIwMTkt
MDE0OCBbbmV0L2k0MGVdIC0gRml4ZWQgZm9yDQo+ID4+IG1haW5saW5lIGFuZCA0LjE5Kw0KPiA+
Pg0KPiA+PiBUaGVzZSBhcmUgZm9yIGk0MGUgZHJpdmVyIGZvciBJbnRlbC4NCj4gPj4NCj4gPj4g
VGhlIGtlcm5lbCB0ZWFtIHdvdWxkIGxpa2UgdG8ga25vdyB3aGV0aGVyIHRoZWlyIGJhY2twb3J0
aW5nIGlzIG5lZWRlZCBvcg0KPiBub3QuDQo+ID4+DQo+ID4+IEZvciBkZXRhaWxzIG9mIHRob3Nl
IENWRSBjaGVja2luZyByZXN1bHRzLCBwbGVhc2Ugc2VlIHRoZSBmb2xsb3dpbmcuDQo+ID4+IGh0
dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVsL2NpcC1rZXJuZWwtc2VjLy0v
bWVyZ2VfcmVxdQ0KPiA+PiBlc3RzLzc1L2RpZmZzDQo+ID4+DQo+ID4+IFJlZ2FyZGluZyB0aGUg
ZGlzY3Vzc2lvbiBvZiB0aGUgSVJDIG1lZXRpbmcsIHBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZy4N
Cj4gPj4gaHR0cHM6Ly9pcmNsb2dzLmJhc2Vyb2NrLm9yZy9tZWV0aW5ncy9jaXAvMjAyMC8xMC9j
aXAuMjAyMC0xMC0wOC0wOS4wDQo+ID4+IDAubG9nLmh0bWwNCj4gPj4NCj4gPj4gQmVzdCByZWdh
cmRzLA0KPiA+PiAtLQ0KPiA+PiBNLiBLdWRvDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUIFJE
QSBJT1QNCj4gQ29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--PwJYrf93iIoqBmwa7Vud
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5790): https://lists.cip-project.org/g/cip-dev/message=
/5790
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PwJYrf93iIoqBmwa7Vud--
