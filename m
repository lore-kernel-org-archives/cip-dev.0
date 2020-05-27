Return-Path: <SRS0=BMwg=7J=lists.cip-project.org=bounce+64572+4645+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB69C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 06:06:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4056208B8
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 06:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ASg7RMQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4056208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4645+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vKbJYY4521723xC61ErX7OUi; Tue, 26 May 2020 23:06:01 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.717.1590559558373159047
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 May 2020 23:06:00 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 04R65tYE026535; Wed, 27 May 2020 15:05:55 +0900
X-Iguazu-Qid: 34trpDa8M4ipAtjzMq
X-Iguazu-QSIG: v=2; s=0; t=1590559555; q=34trpDa8M4ipAtjzMq; m=uIMGQQJCjw6Ni3PIvaX8vg5Ip80FFV+thB79NBPqwbg=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 04R65soF002691;
	Wed, 27 May 2020 15:05:54 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04R65srB021375;
	Wed, 27 May 2020 15:05:54 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04R65sGU002243;
	Wed, 27 May 2020 15:05:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJcfKnyQhA3oUetrJJpnuFGEpkt3B4VoEBcEDdwcZawZfSKJTHG9rBQ+bxxVGN1wUH+74MY5yUKy1lSRLzMeA4FKZTvUAranV/Y8QIobuOOrIIn8XjFTgfZ5eEsnzs3FMITHWcwWNSsRkLsGYZYhUNlmZhxhsibAkTVG49QLfIWF9LSiR/rcoaIZGxyoPKrC6W0qwP1Lg44M/plg1DL1A2NVLmWvv0Wf3Kn9FQCs9uNe9L6yyE2a7GaXI2uSaaYHL+Xrg/ExkDUAOTFYFD7cguiNODKV7e9Z6mG7tBF+fNGLHytBjqw/1A+eEb3XDn36x02c9pI107WEVzbtSbEZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGD2l63j63CCAwmS2aPQQcNG1Nwq0vpkM9IB+e1Jv/w=;
 b=d6Qw8mwuKaPaxGVMD64USA1rnzdDzOs3vCL47hMw0Du7ZI8t09Hf64fkKhchdDu9hIDYv+IVs4ztJXMrUazyakUzs9h9boD7OHqQwLH8YW3YOPdlvW9ETAo9qYVMjFF5sNNZHaLW2c477xejbcPwn36wwb+mI645ecx53pUKjDOkKhFoYuYsk708HM3VAPb64s0R8Wp6GPGUa77rSKkDl4SDxCIfKvRXG6dsXVyujiSg8u+/AwT93nGt/PVa5hwXE2bkjDKM4y9T3NAxyzn5zQ1xLpFpPp3P1KONYk0RnnkZBlPGGwBZvO8VfI8SQ1oe7a1Mw9ckTEqVs51tPSDoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD
 support
Thread-Index: AQHWM7GDsb80CT+ktkG4UCP9h7+uGai7bxjA
Date: Wed, 27 May 2020 06:05:38 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983BF3C515D310B603EF90192B10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1590534014-2203-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
In-Reply-To: <1590534014-2203-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1eddf48-ad92-4a5c-8586-08d80203faa7
x-ms-traffictypediagnostic: OSBPR01MB1653:
x-microsoft-antispam-prvs: <OSBPR01MB1653574BA3CACE4795C9975692B10@OSBPR01MB1653.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:407;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3kIWvuD/V38wGa4ejnQGx+hBQzajpeEFxJYV+dWLWk562M0lFEkcBUQeFZ9uMMXC0J5q5uGzdkpW1hxguvZNZwq+bx0jcD55LKQhIdTKCfU9kQRBJrfz4hrnLGahUNqF/il4h9CbZ9G6KsVJ2olnGhLR2S4AcZK4HgXL3pEJvrY9W6zG1m9D0S7NsCo6jMelN6Tgmp3+tmDSZPFDJjzhRVrCSTUmNZ2/humhoyVTZTBPuXEACLQfpQfGInCTwf+jgN1UWqBKqHHoAe+NwoMAeYz7jRLZzHTiWoxtGyqthixpMNrTlAMkHANVEXz0llbOLq8vsDH3GTnUoYlIWqs9XNoSqnMjQSMNT/YI6EHRj5/kR9jxkaN0Q8NjWgjl0bxwdYVBbIyZVj33ptsSLWKCcQ==
x-ms-exchange-antispam-messagedata: 2vtWaO6Rg7lNS7OB2CftxhZ3MbZnHrZB+a4OQkZkv0Y4ak2+UCoNZ5F8DRfDFrtOr8TeVCU7vqtOeXZb/+Kz9jpIeZCTnymxRSnAkUe4nI23wjEsD9BXljd6DhHVLoKrxPO6Z28VHvBM9gp4q2GzJJW382z3zfF4GluPC4T/kSLcNTenpw0MYkVX5dd3+1sDmilSGqkuCQVoYMXjw2ZyYtxU0TeSOHHDTG+Jngr/goVs9ZaE3mHupkLWr4kijC2ix1hKmjKMnC2CuQrQYzPtO4Bs/JWWVJCTVetmVERK7HhJtZ1nZQ+L+zkS4oEGrThjIJstoW6Sij1ve0Ed5uuMg6POvdKW1QyGpJ/GCKPEETEZYSvv6y9KDe/HEdRqb9aUl0SgtfiQjJH4VTDAhKZuuoXxyu24IpnYxEuupnRcpFY1C9N7SgIc8AhjSVdpFNFV45zGZ8X5BB/MlpZZtii2+gwl+22g/3lMPIf3B1WMzMs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1eddf48-ad92-4a5c-8586-08d80203faa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 06:05:38.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPsnDnmVq8JFbApBgTJ3ZyW8gGVcko8XRJfrsLReUA1bBrUL4j7qbVeiWf5X5++9u8B3B3mch/WJtnYsvhCYQfxdvUWTAoSZ65/bjKIglqtTb5BqRPXauGJ3Dge0gYbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1653
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Y42t2Q74Q3cw7JdurPsysgQdx4520388AA=
Content-Type: multipart/mixed; boundary="D2PHMJMPwyH58I2hc5xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590559561;
 bh=Dj3GRD0IuJJ3LLH2FEIIGZZjKIq6NnE4zTyV+iDkTFo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ASg7RMQlKqNLXSzwfr7X5Ntz3zjlF6lyuvL2SIb4gU2BkVUKOU6u6Rw/ByD+rf+HHuL
 qocEkDAV55JuUmrllkdEByIlo2xySEITUxVQxrtb4zuszqTv+QqQp9yw0Fmwh/voyz9eT
 JZ+Ac9bvIBXKM0lzPXYXiwzQ8Qma5lcKOiU=

--D2PHMJMPwyH58I2hc5xM
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWF5IDI3LCAyMDIwIDg6MDAgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
DQo+IENjOiBDaHJpcyBQYXRlcnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgZmFi
cml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tDQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBbUEFUQ0gg
djQuNC55LWNpcF0gQVJNOiBkdHM6IGl3ZzIwZC1xNy1jb21tb246IEFkZCBMQ0Qgc3VwcG9ydA0K
PiANCj4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5j
b20+DQo+IA0KPiBjb21taXQgNmY4OWRkOWU5MzI1ZDA1YjFmNTRkODYwZGJiYzg0YjQyYWE0MDc1
OSB1cHN0cmVhbS4NCj4gDQo+IFRoZSBpd2cyMGQgY29tZXMgd2l0aCBhIDciIGNhcGFjaXRpdmUg
dG91Y2ggc2NyZWVuLCB0aGVyZWZvcmUNCj4gYWRkIHN1cHBvcnQgZm9yIGl0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5j
b20+DQo+IEFja2VkLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFz
b25ib2FyZC5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTU3MzY2MDI5
Mi0xMDYyOS0xMS1naXQtc2VuZC1lbWFpbC1mYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20N
Cj4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRl
ci5iZT4NCj4gKHJlbW92ZSB0aGUgTFZEUyBkZWNvZGVyIGFzIHRoZXJlIGlzIG5vIGRyaXZlciBm
b3IgaXQ7DQo+IGFkZCBwYW5lbCB0aW1pbmdzIHRvIHBhbmVsIG5vZGUgc2luY2UgdGhlIExWRFMg
ZHJpdmVyIHJlYWRzIHRoZW0gb2ZmIHRoZQ0KPiBwYW5lbCBEVCBub2RlKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpYW4tQ3Jpc3RpYW4gUm90YXJpdSA8bWFyaWFuLmMucm90YXJpdUBnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWNvbW1vbi5kdHNpIHwgODEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgODEg
aW5zZXJ0aW9ucygrKQ0KPiANCg0KSSB0aGluayB5b3UgZm9yZ2V0IGFkZGluZyBhIGZpeCB0byBh
cmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpLg0KDQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctY29tbW9uLmR0c2kgYi9hcmNoL2FybS9ib290
L2R0cy9pd2cyMGQtcTctY29tbW9uLmR0c2kNCj4gaW5kZXggMDExZGJhYi4uNTJjMTc4NyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWNvbW1vbi5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1xNy1jb21tb24uZHRzaQ0KPiBAQCAtNDksNiAr
NDksNDAgQEANCj4gIAkJY2xvY2stZnJlcXVlbmN5ID0gPDI2MDAwMDAwPjsNCj4gIAl9Ow0KPiAN
Cj4gKwlsY2RfYmFja2xpZ2h0OiBiYWNrbGlnaHQgew0KPiArCQljb21wYXRpYmxlID0gInB3bS1i
YWNrbGlnaHQiOw0KPiArDQo+ICsJCXB3bXMgPSA8JnB3bTMgMCA1MDAwMDAwIDA+Ow0KPiArCQli
cmlnaHRuZXNzLWxldmVscyA9IDwwIDQgOCAxNiAzMiA2NCAxMjggMjU1PjsNCj4gKwkJZGVmYXVs
dC1icmlnaHRuZXNzLWxldmVsID0gPDc+Ow0KPiArCQllbmFibGUtZ3Bpb3MgPSA8JmdwaW81IDE0
IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCX07DQo+ICsNCj4gKwlwYW5lbCB7DQo+ICsJICAgIGNv
bXBhdGlibGUgPSAiZWR0LGV0bTA3MDBnMGRoNiIsICJzaW1wbGUtcGFuZWwiOw0KPiArCSAgICBi
YWNrbGlnaHQgPSA8JmxjZF9iYWNrbGlnaHQ+Ow0KPiArDQo+ICsJICAgIHBvcnQgew0KPiArCQkg
ICAgcGFuZWxfaW46IGVuZHBvaW50IHsNCj4gKwkJCSAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmR1
X291dF9sdmRzMD47DQo+ICsJCSAgICB9Ow0KPiArCSAgICB9Ow0KPiArDQo+ICsJICAgIHBhbmVs
LXRpbWluZyB7DQo+ICsJCSAgICBjbG9jay1mcmVxdWVuY3kgPSA8MzMyNjA+Ow0KPiArCQkgICAg
aGFjdGl2ZSA9IDw4MDA+Ow0KPiArCQkgICAgdmFjdGl2ZSA9IDw0ODA+Ow0KPiArDQo+ICsJCSAg
ICBoZnJvbnQtcG9yY2ggPSA8NDA+Ow0KPiArCQkgICAgaGJhY2stcG9yY2ggPSA8ODg+Ow0KPiAr
CQkgICAgaHN5bmMtbGVuID0gPDEyOD47DQo+ICsNCj4gKwkJICAgIHZiYWNrLXBvcmNoID0gPDMz
PjsNCj4gKwkJICAgIHZmcm9udC1wb3JjaCA9IDwxMD47DQo+ICsJCSAgICB2c3luYy1sZW4gPSA8
Mj47DQo+ICsJICAgIH07DQo+ICsJfTsNCj4gKw0KPiAgCXJlZ18xcDV2OiAxcDV2IHsNCj4gIAkJ
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiAgCQlyZWd1bGF0b3ItbmFtZSA9ICIx
UDVWIjsNCj4gQEAgLTEyMyw2ICsxNTcsMzUgQEANCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9
Ow0KPiANCj4gKyZkdSB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArDQo+ICsJcG9ydHMgew0K
PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsN
Cj4gKwkJcG9ydEAwIHsNCj4gKwkJCXJlZyA9IDwwPjsNCj4gKwkJCWR1X291dF9yZ2I6IGVuZHBv
aW50IHsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsJCXBvcnRAMSB7DQo+ICsJCQlyZWcgPSA8MT47
DQo+ICsJCQlkdV9vdXRfbHZkczA6IGVuZHBvaW50IHsNCj4gKwkJCSAgICAgICByZW1vdGUtZW5k
cG9pbnQgPSA8JnBhbmVsX2luPjsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsJfTsNCj4gK307DQo+
ICsNCj4gKyZncGlvMiB7DQo+ICsJdG91Y2gtaW50ZXJydXB0IHsNCj4gKwkJZ3Bpby1ob2c7DQo+
ICsJCWdwaW9zID0gPDEyIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCWlucHV0Ow0KPiArCX07DQo+
ICt9Ow0KPiArDQo+ICAmaHN1c2Igew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIAlwaW5jdHJs
LTAgPSA8JnVzYjBfcGlucz47DQo+IEBAIC0xNTAsNiArMjEzLDEzIEBADQo+ICAJCVZERElPLXN1
cHBseSA9IDwmcmVnXzNwM3Y+Ow0KPiAgCQlWRERELXN1cHBseSA9IDwmcmVnXzFwNXY+Ow0KPiAg
CX07DQo+ICsNCj4gKwl0b3VjaDogdG91Y2hwYW5lbEAzOCB7DQo+ICsJCWNvbXBhdGlibGUgPSAi
ZWR0LGVkdC1mdDU0MDYiOw0KPiArCQlyZWcgPSA8MHgzOD47DQo+ICsJCWludGVycnVwdC1wYXJl
bnQgPSA8JmdwaW8yPjsNCj4gKwkJaW50ZXJydXB0cyA9IDwxMiBJUlFfVFlQRV9FREdFX0ZBTExJ
Tkc+Ow0KPiArCX07DQo+ICB9Ow0KPiANCj4gICZwY2kwIHsNCj4gQEAgLTE4Myw2ICsyNTMsMTEg
QEANCj4gIAkJZnVuY3Rpb24gPSAiaTJjMiI7DQo+ICAJfTsNCj4gDQo+ICsJcHdtM19waW5zOiBw
d20zIHsNCj4gKwkJZ3JvdXBzID0gInB3bTMiOw0KPiArCQlmdW5jdGlvbiA9ICJwd20zIjsNCj4g
Kwl9Ow0KPiArDQo+ICAJc2NpZjBfcGluczogc2NpZjAgew0KPiAgCQlncm91cHMgPSAic2NpZjBf
ZGF0YV9kIjsNCj4gIAkJZnVuY3Rpb24gPSAic2NpZjAiOw0KPiBAQCAtMjE1LDYgKzI5MCwxMiBA
QA0KPiAgCX07DQo+ICB9Ow0KPiANCj4gKyZwd20zIHsNCj4gKwlwaW5jdHJsLTAgPSA8JnB3bTNf
cGlucz47DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+ICt9Ow0KPiArDQo+ICAmcmNhcl9zb3VuZCB7DQo+ICAJcGluY3RybC0wID0gPCZzb3Vu
ZF9waW5zPjsNCj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAtLQ0KPiAyLjcuNA0K
QmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--D2PHMJMPwyH58I2hc5xM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4645): https://lists.cip-project.org/g/cip-dev/message=
/4645
Mute This Topic: https://lists.cip-project.org/mt/74489071/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D2PHMJMPwyH58I2hc5xM--
