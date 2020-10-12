Return-Path: <SRS0=13Fs=DT=lists.cip-project.org=bounce+64572+5518+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BCC433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 09:27:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ADA2080D
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PKbO9vC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ADA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5518+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q2xnYY4521723xeE3YHD8r20; Mon, 12 Oct 2020 02:27:13 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.134])
 by mx.groups.io with SMTP id smtpd.web10.36693.1602494831627819920
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 02:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ3Lq5krMSQnOsHq4iS+Jg5bQ+6nJryYG4jeVLpFeTxCmibkiARJ0x55+U6xz6hKXQMO1NXt1+kAywOIMVRo1cyuvoUDCFOlsQLiChFe5A84SoW8D051T5U5mM0W8Rez9+R0DNvwzKRA1Iqa1GgXWy/cZ1dabkaFUzY+g2oNM1bbg8MXi49p3jPtfKMobcK8podhWvggSM0uERKBZCwIleEqxOB2bQBbwkr6MHbf4YmLP8X/qpYvQ8nU2BMnpQTgNNX+BisdiOuTqnkBqdBNTb5zsWavoLXks7bs7ffeT4v0xVYb3k/UxZTYUQAEhJ26AYSd0IHXl8pIXZCeBYjinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuMG00slI8sQEYmDDAaD/nbxLYH3L2yn2wcqfr9ZZR8=;
 b=llI3tn3ZCdKYOOGYzYEM90L6FyDhAIEn/Nnyqx5zyes+5uv9C6QZKPYfHRHIfa54DzVq0BHoN23A6HTddIX81WzNE7Ot8/bz5zpDT6/qOq7VmXWnuu+QnTXWMQJ7w1CDy6RIe41WP0ojRKbo3zBwdWys2UQ6aAHK64pU8PxzUaWyae2lUMBxverOnmIbBQakE9dKbCT7WaytJo1fxKNzFreZ367f5FgFnqH5SnyggzZD0UUh5wHlgMJCUd6jdB8LJkBZxu1Gc6bi23/LOwZYGmzWAcpry8TNu9lnLiVqrpUgGxV4icM9q9zJCDwINuFdxNOa1sWjf4TntwbmCnmxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4092.jpnprd01.prod.outlook.com (2603:1096:404:cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Mon, 12 Oct
 2020 09:27:08 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 09:27:08 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Thread-Topic: [cip-dev] Backporting of security patches for Intel i40e drivers
 required?
Thread-Index: AdadV2Jnu1CNqzkrSoynC++LmpFHXAAeQTNQAA8zFIAAmyaLQA==
Date: Mon, 12 Oct 2020 09:27:08 +0000
Message-ID: 
 <TY2PR01MB49724DFD4869803722FD36E9A0070@TY2PR01MB4972.jpnprd01.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 28e1bbdb-4629-4d8d-da6b-08d86e90fddb
x-ms-traffictypediagnostic: TY2PR01MB4092:
x-microsoft-antispam-prvs: 
 <TY2PR01MB409253A8A22DA15338C264F6A0070@TY2PR01MB4092.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 zPIXHiAVYrznHxsyjkiW0krq23E57mQlC8OinILbP+zogFoFEI8NGlOxfVF1zp1gs1FLevLJ6zb0SfRW7yCJnDOlthgyVgVTzQRgXPaC4MVleib9qK7xLYGZgdHDEwwF7unPJ3aRx4SA8fKL8l8YxuI6isYtmlRR52CyCWTpA4zMLZf0GWN+ov6StHxZuMCAWKm109Le84C0tyz8UCh8ErDzyP/Z45/EyMVBN1eDKJyHum3U/GwbrIahgcd6QoskfSQaGLBrepGr8GXnxNEfPQ4oXcgFB1m2l+qJk41jtE/S0T/QdyAMeVQ/0TcskPqbS0UO//ZNzvjkKxo+r7aW66wZFBTFvequ6HkaCGUfCACiaGIS6AiP+eyvSQ7XR6G0RKaEKCZVim8DRqKOVklmpA==
x-ms-exchange-antispam-messagedata: 
 PbL9SVH4YttxrSejMR985PctSlsm7RzKRVo7vjprSmCv2EGBFw8b1XY9X65RgICCCUnPKO5eij9e0K4ztzv/yrVcQRG0C9wsSeE6W9BMyabts2wN7DjJ9L/OIbQK80nUcQI8xZO0ePffdO2diauUUGfLoX2B+7LjCHNbWjoh48e/SYmMk07lx38mV0yd1zCqf6urevqbhWDjiHIpjo1BBMeOOMf4TD1APHNPYV+gjkgGbgs9W6f6Fxkf0ZN5V7wmTDg+MvA1Y82FA7GTVNiGIfOHYyf0NUM0HvVDgaIS6c/F6ptMULN7OsnJ31WuDgJvqfp4mOHT5B+kBiZ3sGNMxnhhURCUnHvGFXf4WszQ6WOrWmNnBuo39NINQaK+AcBKvOz9xSGC6uBvaIoZmIfV5MhzjHo7RbkKIVY4OZzS1MNs1MtgXTOlC+nYGz2geAXKs7XUpC4KAnFUwhnp1GskP59BIgFSyuOH2PCGzsd29v9UbbGu2uJ5cragnd075StvtUCV1ZC0ynEn0PblZkP3CHrSIJWQwnGb+ix+GdY9X8AVZXTXYuFfKzG3zDpUXjA5Fzkql4xkm2bHUdl95c8NQcXZMO2ZpecLBWy7Xo81f1M0oU8i1ps+bgWGfy2kNtGuRs+0TxnxBUZXQ3UqjNC7+A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1bbdb-4629-4d8d-da6b-08d86e90fddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 09:27:08.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnOZZr23LN3tbIOlzy218619SgNBI3ebvg4RB0ZGFjWbgu5W7Qg0ifYoaQcLqJ+O8iEodQlO9ciKHxA1ouZ2ZOvobDS8e9iMUOMYiT/bzO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4092
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EBYNrfsc7kPBKJ8WRvp9g0R2x4520388AA=
Content-Type: multipart/mixed; boundary="wkDBUmVn1coyP4IVb6pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602494833;
 bh=rIdoz66pVs6SqF6lYUwTeR6MwCnhew0PlQYGgPqmfus=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PKbO9vC9GmxXh3L4KxzHgo+96W+clL2oE3zQOAqVJkV4YUmGK+LhJw/F/x/3luNs+Lq
 p0Jlb3zwXdvGQiaxhQ7JuED9qrbbX41097H9DuQm+Sc4INEXXoZWtZ+OzkeJOL2qZMzFP
 HAosq+dmDM+W0mv1TxOuW0aj7rmjsH37nB0=

--wkDBUmVn1coyP4IVb6pn
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEphbi1zYW4sDQoNClRoYW5rcyBmb3IgeW91ciByZXNwb25zZS4NCg0KQmVzdCByZWdhcmRz
LA0KLS0NCk0uIEt1ZG8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmc+IE9uIEJlaGFsZiBPZg0KPiBKYW4gS2lzemthDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA5
LCAyMDIwIDQ6MjQgUE0NCj4gVG86IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwOyBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIEJh
Y2twb3J0aW5nIG9mIHNlY3VyaXR5IHBhdGNoZXMgZm9yIEludGVsIGk0MGUgZHJpdmVycw0KPiBy
ZXF1aXJlZD8NCj4gDQo+IEhpIGFsbCwNCj4gDQo+IGdpdmVuIHRoZSBleHBvc3VyZSBvZiBzdWNo
IGEgZGV2aWNlIGJ1dCBhbHNvIHRoZSBmYWN0IHRoYXQgSSBjYW4ndCB0ZWxsIGZvciBzdXJlDQo+
IGlmL3doZXJlIGl0J3MgdXNlZCAobm90IG9ubHkgYnkgdXMpLCBJIHdvdWxkIHJlY29tbWVuZCBi
YWNrcG9ydGluZy4NCj4gDQo+IEphbg0KPiANCj4gT24gMDkuMTAuMjAgMDI6MjMsIG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gSSBoYXZl
IHNvbWUgY29tbWVudCBmb3IgdGhpcyBpc3N1ZS4NCj4gPg0KPiBodHRwczovL2xpc3RzLm9zdW9z
bC5vcmcvcGlwZXJtYWlsL2ludGVsLXdpcmVkLWxhbi9XZWVrLW9mLU1vbi0yMDIwMDgxMC8wMjEN
Cj4gMDA2Lmh0bWwNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIw
MDgwNzIwNTUxNy4xNzQwMzA3LTEtamVzc2UuYnJhbmRlYnUNCj4gPiByZ0BpbnRlbC5jb20vDQo+
ID4NCj4gPiBUaGVyZSBhcmUgbXVsdGlwbGUgcGF0Y2hlcyBmaXhlZCBmb3IgNC4xOSwgd2hpY2gg
Y2FuIGJlIHNlcGFyYXRlZCBieSBmZWF0dXJlLg0KPiA+DQo+ID4gIC0gaTQwZTogYWRkIG51bV92
ZWN0b3JzIGNoZWNrZXIgaW4gaXdhcnAgaGFuZGxlcg0KPiA+DQo+ID4gICAgICBUaGlzIGlzc3Vl
IGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUzMjE5Y2U2YTc3NTQgKCJpNDBlOiBBZGQgc3VwcG9ydCBm
b3INCj4gY2xpZW50IGludGVyZmFjZSBmb3IgSVdBUlAgZHJpdmVyIikuDQo+ID4gICAgICBlMzIx
OWNlNmE3NzU0IGlzIG5vdCBpbmNsdWRlZCBpbiA0LjQueSBhbmQgY2FuIGJlIGlnbm9yZWQuDQo+
ID4NCj4gPiAgLSBpNDBlOiBXcm9uZyB0cnVuY2F0aW9uIGZyb20gdTE2IHRvIHU4DQo+ID4gICAg
VGhpcyBjYW4gYmUgYXBwbHkgaW4gNC40LnkuDQo+ID4NCj4gPiAgLSBpNDBlOiBGaXggb2YgbWVt
b3J5IGxlYWsgYW5kIGludGVnZXIgdHJ1bmNhdGlvbiBpbiBpNDBlX3ZpcnRjaG5sLmMNCj4gPg0K
PiA+ICAgIFRoaXMgaXNzdWUgaGFzIGJlZW4gcHJvZHVjZWQgYnkgZTI4NGZjMjgwNDczYiAoImk0
MGU6IEFkZCBhbmQgZGVsZXRlDQo+IGNsb3VkIGZpbHRlciIpLg0KPiA+ICAgIEl0IGlzIG5vdCBp
bmNsdWRlZCBpbiA0LjQueS4gSG93ZXZlciwgdGhpcyBwYXRjaCBoYXMgc2V2ZXJhbCBkaWZmZXJl
bnQgZml4ZXMsIHNvDQo+IHNvbWUgcGF0Y2hlcyBuZWVkIHRvIGJlIGFwcGxpZWQuDQo+ID4NCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfdmlydGNobmxfcGYu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV92aXJ0Y2hu
bF9wZi5jDQo+ID4gQEAgLTE4MSw3ICsxODEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaTQwZV92
Y19pc3ZhbGlkX3ZzaV9pZChzdHJ1Y3QNCj4gPiBpNDBlX3ZmICp2ZiwgdTE2IHZzaV9pZCkNCj4g
PiAgICogY2hlY2sgZm9yIHRoZSB2YWxpZCBxdWV1ZSBpZA0KPiA+ICAgKiovDQo+ID4gIHN0YXRp
YyBpbmxpbmUgYm9vbCBpNDBlX3ZjX2lzdmFsaWRfcXVldWVfaWQoc3RydWN0IGk0MGVfdmYgKnZm
LCB1MTYgdnNpX2lkLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICB1OCBxaWQpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgIHUxNiBxaWQpDQo+ID4gIHsNCj4gPiAgICAgIHN0cnVj
dCBpNDBlX3BmICpwZiA9IHZmLT5wZjsNCj4gPiAgICAgIHN0cnVjdCBpNDBlX3ZzaSAqdnNpID0g
aTQwZV9maW5kX3ZzaV9mcm9tX2lkKHBmLCB2c2lfaWQpOw0KPiA+DQo+ID4NCj4gPiAgLSBpNDBl
OiBNZW1vcnkgbGVhayBpbiBpNDBlX2NvbmZpZ19pd2FycF9xdmxpc3QNCj4gPiAgICBUaGlzIGlz
c3VlIGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUzMjE5Y2U2YTc3NTQgKCJpNDBlOiBBZGQgc3VwcG9y
dCBmb3INCj4gY2xpZW50IGludGVyZmFjZSBmb3IgSVdBUlAgZHJpdmVyIikuDQo+ID4gICAgZTMy
MTljZTZhNzc1NCBpcyBub3QgaW5jbHVkZWQgaW4gNC40LnkgYW5kIGNhbiBiZSBpZ25vcmVkLg0K
PiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+ICAgTm9idWhpcm8NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZw0KPiA+PiBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhh
bGYgT2YNCj4gPj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gPj4gU2VudDogVGh1
cnNkYXksIE9jdG9iZXIgOCwgMjAyMCA2OjQzIFBNDQo+ID4+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiA+PiBDYzogamFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KPiA+PiBTdWJq
ZWN0OiBbY2lwLWRldl0gQmFja3BvcnRpbmcgb2Ygc2VjdXJpdHkgcGF0Y2hlcyBmb3IgSW50ZWwg
aTQwZSBkcml2ZXJzDQo+IHJlcXVpcmVkPw0KPiA+Pg0KPiA+PiBIaSwgSmFuLXNhbiwgQWxsLA0K
PiA+Pg0KPiA+PiBBdCB0aGUgSVJDIG1lZXRpbmcgdG9kYXksIHdlIGlkZW50aWZpZWQgdGhlIGZv
bGxvd2luZyBuZXcgQ1ZFcyBhcmUgbm90IGluDQo+IExUUzQuNCB5ZXQuDQo+ID4+DQo+ID4+IC0g
Q1ZFLTIwMTktMDE0NSwgQ1ZFLTIwMTktMDE0NywgQ1ZFLTIwMTktMDE0OCBbbmV0L2k0MGVdIC0g
Rml4ZWQgZm9yDQo+ID4+IG1haW5saW5lIGFuZCA0LjE5Kw0KPiA+Pg0KPiA+PiBUaGVzZSBhcmUg
Zm9yIGk0MGUgZHJpdmVyIGZvciBJbnRlbC4NCj4gPj4NCj4gPj4gVGhlIGtlcm5lbCB0ZWFtIHdv
dWxkIGxpa2UgdG8ga25vdyB3aGV0aGVyIHRoZWlyIGJhY2twb3J0aW5nIGlzIG5lZWRlZCBvcg0K
PiBub3QuDQo+ID4+DQo+ID4+IEZvciBkZXRhaWxzIG9mIHRob3NlIENWRSBjaGVja2luZyByZXN1
bHRzLCBwbGVhc2Ugc2VlIHRoZSBmb2xsb3dpbmcuDQo+ID4+IGh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAta2VybmVsL2NpcC1rZXJuZWwtc2VjLy0vbWVyZ2VfcmVxdQ0KPiA+PiBl
c3RzLzc1L2RpZmZzDQo+ID4+DQo+ID4+IFJlZ2FyZGluZyB0aGUgZGlzY3Vzc2lvbiBvZiB0aGUg
SVJDIG1lZXRpbmcsIHBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZy4NCj4gPj4gaHR0cHM6Ly9pcmNs
b2dzLmJhc2Vyb2NrLm9yZy9tZWV0aW5ncy9jaXAvMjAyMC8xMC9jaXAuMjAyMC0xMC0wOC0wOS4w
DQo+ID4+IDAubG9nLmh0bWwNCj4gPj4NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+PiAtLQ0KPiA+
PiBNLiBLdWRvDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUIFJEQSBJT1QNCj4gQ29ycG9yYXRl
IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--wkDBUmVn1coyP4IVb6pn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5518): https://lists.cip-project.org/g/cip-dev/message=
/5518
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wkDBUmVn1coyP4IVb6pn--
