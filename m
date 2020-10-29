Return-Path: <SRS0=m23T=EE=lists.cip-project.org=bounce+64572+5688+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C0C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:46:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A708D2076A
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TAQ9IzGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708D2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5688+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q052YY4521723xIa1paKTK04; Wed, 28 Oct 2020 19:46:10 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.90])
 by mx.groups.io with SMTP id smtpd.web12.3173.1603939569338674422
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2020 19:46:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC0xgVseQD6nNoq9kQ8Sw47CsNrI0yBf2nNHKlur6FUvRxMA+sKpHIINPRAGqwGf8HNrbJBY9W/2zf6ZcU6nWwn5u5b6PtLHuqCNaeMrufLrgRM0IzF3MqtrGldNXE1H/IRxVRg/XBzkDjmwO8BsseiEm+2f2LiXlWt8pSjafmuYBxvx2/LX50UIPyxgwxKqV7HTfhBxl4/AkO5zBfqsMvojAZYyrWplh+oaZhPIieXrz3gsKotmzuZBIyHWvvTsBCpUzk0mCbd/17LmDr30xMhEbBOzWsthuReucNiIIMP9NXO/u93C1/7aKPqSzrn8ObW5AlN7MIDpLqPOMU1ZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNMtLgg94oIk2DKr03OsT7BF8dIBbC3Cf5Oi6VoS8dI=;
 b=dvhcVRolvZXLohPdgG/xiqWYBtvnNY+BWwK1oZREYeU0nqr8OBDnCqSjtpXCoVEsxet3KaMacEu1+/A5Kh2VvPQpqGum3lwc1DLqyS9PAT+rx6+iwPG7E+JtOG5h70HrIRTNIcSYPyOpYnoEXEV+N295Rh1Zi9p4t8Hiunlrc9qvRPyOduCnO4S9qywMPe2YJNTphQzuhah7Efd3+JiacO/Be175Sam40uvckQKeLWd/L/HDHNO64ToQ7ztpADzOPQuEgOrck2l9FIWe1y6PRE8bEgCsJOaA1DFzf6Dku+WyKW17dLkB3Te+0JpLQ7LMMqPFwLzkf9xl6bosSZT49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY1PR01MB1850.jpnprd01.prod.outlook.com (2603:1096:403:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 02:46:06 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3499.018; Thu, 29 Oct 2020
 02:46:06 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] cip-kernel-sec Updates for Last Week of October
Thread-Topic: [cip-dev] cip-kernel-sec Updates for Last Week of October
Thread-Index: AQHWrZ0nV2HyxxuPxkyCk6v8t+wZFKmt34+Q
Date: Thu, 29 Oct 2020 02:46:05 +0000
Message-ID: 
 <TY2PR01MB4972ABE5D4C4B9454DC87984A0140@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
In-Reply-To: 
 <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30354f2a-79c8-459e-a9e8-08d87bb4c871
x-ms-traffictypediagnostic: TY1PR01MB1850:
x-microsoft-antispam-prvs: 
 <TY1PR01MB18509A60FEBE8716BD283AEBA0140@TY1PR01MB1850.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 V5iwKkRXcNLtAAOoMKTuaa4uUvB4RSPzeN3T0Z9v33lJnBE5PQa3hZ03KQK6TTCU4TRzO9HeopjigwbrKTyK3+6N5er11RLVEnWQWvTl0I/fqMnc/RnRGBqY2niIRbkVHtYSdE4VcF0x9PLTcNky1k+SzshBESuDiXP/3Jn9bDlG96ICO71yom1MKi0fodaBfAeOK4U9TRT0stC5tnmGH4QXhqT4dON85dPU6vjKUbK8c+J8f1t0enFKRwk1FM/YFajX15ixZbuTR7UFhbyUE66TGit+sfmUd+iEJlsj0ZjG+a+XLYrwmTAM69wQo+x9iIwFnsxScupztVK2A7HQAA==
x-ms-exchange-antispam-messagedata: 
 9JMu2Docnr/HZRUjz+s57+g2pIR80dtYJ0ayU+Pa85igU51P9i2yH12FICVTVfFyp3cimIdm31ybPlvE81jL4qbRbshJpIyrlSReCuabMW537zbBrVIhGaSWHyeGHIsTAOYw8ZmSFuzKQXPuY5eGRyNPYMyHxP5dH5pov8geliuLc1dGkWXuWnKjqsIlLjCDT6u010bmuYbZ7JktSW9LPKYjvAmJ5IBqqplHpybigqsB7ffyoNUfiCgUH44Kq0VtDpFTf0RUxAIWbVDbBrYQ712KqUTNFKd9Garkhas3FLOYhb/0spQiYi6+Qfeabh0BCTbZFywhCHie6XN/fwatXHtEVGiu7wmgflCFq4RSGZjAmKV2HqSiuz/2KjKihTtSYQzJ5077t/s+QhXzsL5pCjMS7oS9rCizIpudL2toufVcXnwvQjlPrEv+nrHWUvRbCjyOaOIL70lBrhxOruD+CHmET1MKpzh6n69/jVUMWDPbGhwAQkSkA0fhw80l0MRZZP5aA12RbC0YCzuuLbbwdJOPcLNnhQAB/a9KqPssObz+Ajh1qd1bsDQ6nx6N+ebvJrvaksoTtTygGT7fE2IdPO6x+xEFEUxofLoIXyFbkvbul1t9SPn1ZeZtQeYfu5qwtHrX2naNFnS3w5WCr/+Wog==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30354f2a-79c8-459e-a9e8-08d87bb4c871
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 02:46:05.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMk+fqDkMVqgccRqS2Y96gKwStTW8eggKZl9SBO3GZsiHwXzqtSks/lOhCZIlnkG8nOoV/m59x8fVF/IIzvOSowfN9I7PjK5LNHPhW+GMbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1850
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: A4b8qhfRIaqOjwsXZJBkb4SWx4520388AA=
Content-Type: multipart/mixed; boundary="dgpQATrFJcnbnc0GPKAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603939570;
 bh=MZz3W4h9t56ItntpEh57ps99bvPIZ3+9nAA20MOs74g=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=TAQ9IzGJynnmS+TnP63nQEyIXTMvIH5TGawtXr6lmcYhDQA+t7BF2gRS/E8ocwja9pR
 Mn+QYbo0DRyULHwW3A5Df0/FgAwsZlYVBl3dBuvNbL+qy0jcR7e3iy5xaFVk2BXGKSq+4
 FKMnypnEIycbcZJt1GnwnnxXWmkCmclSbUU=

--dgpQATrFJcnbnc0GPKAj
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIENoZW4tWXUgc2FuLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwb3J0ISBUaGlzIGlzIHZlcnkg
aGVscGZ1bC4NCg0KQ291bGQgeW91IGFkZCB0aGUgYmFja3BvcnRpbmcgc3RhdHVzIGZvciA0LjQg
YW5kIDQuMTkgc3RhYmxlIGtlcm5lbHM/DQpXZSBtYXkgd2FudCB0byBkaXNjdXNzIHRoZSBuZWNl
c3NpdHkgb2YgdGhlIGJhY2twb3J0aW5nIGZvciB0aGVtLg0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0K
TS4gS3Vkbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24g
QmVoYWxmIE9mDQo+IENoZW4tWXUgVHNhaSAoTW94YSkNCj4gU2VudDogVGh1cnNkYXksIE9jdG9i
ZXIgMjksIDIwMjAgMTE6NDIgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
DQo+IENjOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBOb2J1aGlybyBJd2FtYXRzdQ0K
PiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFtjaXAtZGV2
XSBjaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBMYXN0IFdlZWsgb2YgT2N0b2Jlcg0KPiANCj4g
SGkgZXZlcnlvbmUsDQo+IA0KPiBTaW5jZSB0aGVyZSdzIG5vIENJUCB3ZWVrbHkgbWVldGluZyB0
aGlzIHdlZWssIEknbSBzaGFyaW5nIHRoZSBkZXRhaWxzIG9uIHRoZQ0KPiBtYWlsaW5nIGxpc3Qu
IElmIHBlb3BsZSBwcmVmZXIgdGhpcyBmb3JtYXQsIEkgY2FuIGFsc28gZG8gdGhpcyBpbiB0aGUg
ZnV0dXJlLiBUaGlzIGNvdWxkDQo+IG1ha2UgdXAgZm9yIHRoZSBtZXJnZSByZXF1ZXN0IHdoaWNo
IHN1bW1hcml6ZWQgdGhlIGluZm9ybWF0aW9uLg0KPiANCj4gSGVyZSdzIHRoaXMgd2VlaydzIHVw
ZGF0ZToNCj4gDQo+IE5ldyBDVkVzOg0KPiAtIENWRS0yMDE5LTAxNDYgW25ldC9pNDBlXSAtIGxp
a2VseSBmaXhlZA0KPiAtIENWRS0yMDIwLTI3NjczIFt4ZW4vZG9tMF0gLSBmaXhlZCBpbiBtYWlu
bGluZQ0KPiAtIENWRS0yMDIwLTI3Njc1IFt4ZW4vZG9tMF0gLSBmaXhlZCBpbiBtYWlubGluZQ0K
PiANCj4gT2xkIENWRXMgbm93IGZpeGVkOg0KPiAtIENWRS0yMDIwLTE0MzUxIFtwZXJmXSAtIGZp
eGVkIGluIG1haW5saW5lDQo+IC0gQ1ZFLTIwMjAtMjcxNTIgW0tWTV0gLSBmaXhlZCBpbiBtYWlu
bGluZQ0KPiANCj4gU28gd2UgaGF2ZSB5ZXQgYW5vdGhlciBJbnRlbCBpNDBlIENWRSB0aGF0IGhh
cyBhIG5lYXJseSB1c2VsZXNzIGRlc2NyaXB0aW9uLg0KPiANCj4gRm9yIHRoZSByZXN0LCB0aGV5
IGFyZSBhbGwgZml4ZWQgaW4gdjUuMTAtcmMxLg0KPiANCj4gLSBGaXhlcyBmb3IgQ1ZFLTIwMjAt
MTQzNTEgYW5kIENWRS0yMDIwLTI3MTUyIGhhdmUgYmVlbiBxdWV1ZWQNCj4gICB1cCBmb3IgdjUu
OCBhbmQgdjUuOS4NCj4gDQo+IC0gRml4IGZvciBDVkUtMjAyMC0yNzY3NSBoYXMgYmVlbiBxdWV1
ZWQgdXAgZm9yIHY1LjkNCj4gDQo+IC0gRml4IGZvciBDVkUtMjAyMC0yNzY3MyBoYXMgbm90IGJl
ZW4gYmFja3BvcnRlZCB5ZXQuDQo+IA0KPiANCj4gUmVnYXJkcw0KPiBDaGVuWXUNCj4gTW94YQ0K

--dgpQATrFJcnbnc0GPKAj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5688): https://lists.cip-project.org/g/cip-dev/message=
/5688
Mute This Topic: https://lists.cip-project.org/mt/77879900/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dgpQATrFJcnbnc0GPKAj--
