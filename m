Return-Path: <SRS0=RC3W=7P=lists.cip-project.org=bounce+64572+4657+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB78C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 04:36:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112C1206C3
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 04:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ktSZL3+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112C1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4657+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JE8PYY4521723xYja5RpXlai; Mon, 01 Jun 2020 21:36:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.3766.1591072559720162030
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 21:36:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0524ZvI5011277; Tue, 2 Jun 2020 13:35:57 +0900
X-Iguazu-Qid: 2wHHbNmoGr9MjkYySQ
X-Iguazu-QSIG: v=2; s=0; t=1591072556; q=2wHHbNmoGr9MjkYySQ; m=zy5gz0RUzy6sm7PtgRAXu6Su1/nuz5zVdSXSbi4eJYg=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 0524Zu6E021912;
	Tue, 2 Jun 2020 13:35:56 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0524Ztbt028218;
	Tue, 2 Jun 2020 13:35:55 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0524Ztad008444;
	Tue, 2 Jun 2020 13:35:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP34S8pZWwFDFMJ3/spkquu5sDwlLjCwCcylFc4pHib68BlWOz8fj0kaSU16joqccK5sThwEo6hN2xyNzNP3HeNJ61jUT59C4QpEACZGmc3u5LqZvs+qVcprzIT6rtrMZ7f0MqcP9Al9UI6ukeWqL9GFuxfBpY2HPuHB/re7ahUDvRDPOVY6GYGFpblq2w1q4NOr7dHOumVNypENKEig0SQPo094rmOu3NP4tpInu7M5D9oBPCgo2z1RA+9qOS+G0oRft874LygyvHXJgMZuC9GkBvTKega23pTIx2pTX4guIfKhDjRE/4YIn2G/L51MED6ui2YkNe95GtN4V5Og/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elqztic5Jecb2FJV0wQf2hcCEtbw05AOZ5Or7JYxS4Q=;
 b=bT/wSGKR/xprL0uK8V73GrAetr5Mp+Zbyk265UPS6yCAdlxBsdsAhJVuu8ZKnSOKVyzkM5hlW9WuiIwDQYAeAB+YhR9lq8AHpDJMGvE6wJa+tUF5d1SfDQnkFFfRmmTDALjJwsTa+tkZNAJWUInOCwo7ve2MKQRC5LvcaVfSYFW/TxaS/zlPA7rK0yKEV+qXr0qmv9h0p3vkEK4bajWqrtz9HgRJcv5weDtBBuZ+/ZzMS9ENbEnAg8zYHLZe8GMsHaGmz6ECbnOlQ+tsCge/d4uoRYjuuPK1xDZxGkFwtxPZfXD/ir5uX2TTMwN+0VRPkYXbywtOV6P70TUnnJMK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD
 support
Thread-Index: AQHWM7GDsb80CT+ktkG4UCP9h7+uGai7bxjAgAgzhJCAAR9fQA==
Date: Tue, 2 Jun 2020 04:35:52 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A075C8031715BBDE37CC928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1590534014-2203-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB2983BF3C515D310B603EF90192B10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <OSAPR01MB502894936BCCC76DCBEE8CFFAE8A0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB502894936BCCC76DCBEE8CFFAE8A0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d3ae7c-aa23-44f9-2cea-08d806ae6ee9
x-ms-traffictypediagnostic: OSBPR01MB3431:
x-microsoft-antispam-prvs: <OSBPR01MB343100C8FEAF87A7232424A1928B0@OSBPR01MB3431.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OPRhqPvaF+NV98z4qNhlVJkyEtXtJ+GqgG9VsrFCTqA1xUYE2OJlWPdgWzBWm7sT5QK+aWHWwMYIyeWwFxYQhsrtBv7RGSG+ikvYz41EjS2F9w1/N+Y00yFNsqaQP0SMYD8GCWsxtGLcpPx98+4t5tbDC/JYX+oTxLQ0fQ7CwbwknrKkni5um63CLMZOKZofDnKKKXYYyS9kopWD+fsFUy1OB0IyoTDjQ9XmE+xgbadrXdwaF8RhIRtmvaWVWo3zDz+++MRhKvJWCNAji6vkxFDuFj6Uk0zjuFvJEx/w3QQzSqwswiP1VwH2Fq+o4/cAi41prm3ROz3YwVzOgzZA00OSCM86uW3Bb3XgeLxWPy58eZB/YGxgb7s7z2A9efvhu4PlgiMHfKnXqEpa7a02BA==
x-ms-exchange-antispam-messagedata: a/82VybBzjV3th3D14F6HZPUn86906+BoNSLMVcrIeOMFlzcbIl6pPgiMnKEZtGakLGKjcBT7PMM2d2O9t4fklKnkm/KKrJDvNQ9Li2bCLmrn1EJtN464oqJMWwfBqR+RVrXZMZsd7WCxvD9R7vMfQTnOi26pogO6w4Km7lo6BMlFnPt1OjZzE0mJF2XilXkKhIJLsF2n+Z1qsFEmw0sXut9uHHAo5o99lsB9L7xRaxZzJgSCj09M0NOhI5VOsjlKN/CvY8OvpfS69T7SbofWI9qL+MfwS75fee0P3L6ITpEh++X6YwRRJva14+/ZbFAmpFfdKb6mfCX3+uQ276zoNvT38NXKjaFx5y21jqi5OiD7oPqaNRI6P91HLislWRO6TQDdeqnfLgEI0qcnRZc9VAmEPJUDD8EfIyOPRovKVA7yJRPj0AReEA8vrNFbUyBEqalgFA3uhCCp3RGsXpEKYGD1DDEitA+MwwO5AEyuTU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d3ae7c-aa23-44f9-2cea-08d806ae6ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 04:35:52.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nV2O9O2j1fpXsKTT0UfBFh7RVTd8J4XAIEmBS15o/176AQMSnSukWEw81PTHSh4vjvWIMfUm08LLqRkmxDVoggC1gS0Q2jon0PnWAlX65xsErhCm1SZPbKM51K8O2j8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3431
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yFofS3RlHoPYEp0GSO5vua0ux4520388AA=
Content-Type: multipart/mixed; boundary="KCdfrb0upY7YmbhKgdYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591072562;
 bh=NC/2h3XVW+d03hJAJQQzI9iITa+llMlU0Gsz0dw9pwY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ktSZL3+WaEC0Zt6qVgqB9XRWctMvUCjLIBgxXe7WSN0r9O+mc1hyTkFnDH2qOAu3fKd
 X8kQpV1wXp14kn07ilFLT0rywD41c4Jy9XYAsye3QCteFp3/VHzJUoSpUMie4+S9hg1fM
 t17DQTY7vuxnAbdh3OT6kEurR5EP8lCzVkQ=

--KCdfrb0upY7YmbhKgdYV
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1DQo+IFNlbnQ6IE1vbmRheSwgSnVu
ZSAxLCAyMDIwIDg6MTQgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+
IENjOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgRmFicml6
aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbY2lwLWRldl0gW1BBVENIIHY0LjQueS1jaXBdIEFSTTogZHRzOiBpd2cyMGQtcTctY29tbW9u
OiBBZGQgTENEIHN1cHBvcnQNCj4gDQo+IEhpIE5vYnVoaXJvLA0KPiANCj4gVGhhbmsgeW91IGZv
ciB5b3VyIHJldmlldyENCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBG
cm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmc+IE9uDQo+ID4gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1IHZpYSBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gPiBTZW50OiAyNyBNYXkgMjAyMCAwNzowNg0KPiA+IFRvOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+IENjOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMu
UGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgRmFicml6aW8gQ2FzdHJvDQo+ID4gPGZhYnJpemlvLmNh
c3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRDSCB2
NC40LnktY2lwXSBBUk06IGR0czogaXdnMjBkLXE3LWNvbW1vbjogQWRkDQo+ID4gTENEIHN1cHBv
cnQNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiA+IFttYWlsdG86
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBNYXJpYW4tQ3Jpc3Rp
YW4NCj4gPiA+IFJvdGFyaXUNCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDIwIDg6
MDAgQU0NCj4gPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+ID4gQ2M6
IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+Ow0KPiA+ID4gZmFi
cml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tDQo+ID4gPiBTdWJqZWN0OiBbY2lwLWRldl0gW1BB
VENIIHY0LjQueS1jaXBdIEFSTTogZHRzOiBpd2cyMGQtcTctY29tbW9uOiBBZGQNCj4gPiA+IExD
RCBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm9AYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gY29tbWl0IDZmODlkZDllOTMyNWQw
NWIxZjU0ZDg2MGRiYmM4NGI0MmFhNDA3NTkgdXBzdHJlYW0uDQo+ID4gPg0KPiA+ID4gVGhlIGl3
ZzIwZCBjb21lcyB3aXRoIGEgNyIgY2FwYWNpdGl2ZSB0b3VjaCBzY3JlZW4sIHRoZXJlZm9yZSBh
ZGQNCj4gPiA+IHN1cHBvcnQgZm9yIGl0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZh
YnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gQWNr
ZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNv
bT4NCj4gPiA+IExpbms6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE1NzM2NjAy
OTItMTA2MjktMTEtZ2l0LXNlbmQtZW1haWwtZmFicml6aW8uDQo+ID4gPiBjYXN0cm9AYnAucmVu
ZXNhcy5jb20NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQr
cmVuZXNhc0BnbGlkZXIuYmU+IChyZW1vdmUNCj4gPiA+IHRoZSBMVkRTIGRlY29kZXIgYXMgdGhl
cmUgaXMgbm8gZHJpdmVyIGZvciBpdDsgYWRkIHBhbmVsIHRpbWluZ3MgdG8NCj4gPiA+IHBhbmVs
IG5vZGUgc2luY2UgdGhlIExWRFMgZHJpdmVyIHJlYWRzIHRoZW0gb2ZmIHRoZSBwYW5lbCBEVCBu
b2RlKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyaWFuLUNyaXN0aWFuIFJvdGFyaXUgPG1hcmlh
bi5jLnJvdGFyaXVAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9k
dHMvaXdnMjBkLXE3LWNvbW1vbi5kdHNpIHwgODENCj4gPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQo+
ID4gPg0KPiA+DQo+ID4gSSB0aGluayB5b3UgZm9yZ2V0IGFkZGluZyBhIGZpeCB0byBhcmNoL2Fy
bS9ib290L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ug
YmUgbW9yZSBzcGVjaWZpYz8gVGhlcmUgc2hvdWxkIG5vdCBiZSBhIGNvbmZsaWN0IGJldHdlZW4g
dGhlIHR3byBkZXYNCj4gYm9hcmQgY29uZmlndXJhdGlvbnMuIEkgZG91YmxlIGNoZWNrZWQgdGhl
IHR3byBkdHMsIGJ1dCBpdCBzZWVtcyB0byBiZSBubyBpc3N1ZSBhbmQgdGhleQ0KPiByZXNlbWJs
ZSB3aGF0IGlzIGluIHRoZSB1cHN0cmVhbSBrZXJuZWwuDQoNCkNvbW1pdCA2Zjg5ZGQ5ZTkzMjVk
MDViMWY1NGQ4NjBkYmJjODRiNDJhYTQwNzU5IHByb3ZpZGVzIGEgZml4IGZvciB0d28gZmlsZXMu
DQpUaGUgcGF0Y2ggeW91IHBvc3RlZCBpcyBhcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctY29t
bW9uLmR0c2kgb25seSwgdGhlcmUgaXMgbm8gZml4IGZvcg0KYXJjaC9hcm0vYm9vdC9kdHMvaXdn
MjBkLXE3LWRiY20tY2EuZHRzaS4NCg0KLS0tDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvaXdnMjBkLXE3LWRiY20tY2EuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1xNy1k
YmNtLWNhLmR0c2kNCmluZGV4IDBlOTlkZjIxODI1Mi4uZWRlMmUwYzk5OWIxIDEwMDY0NA0KLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWRiY20tY2EuZHRzaQ0KKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaXdnMjBkLXE3LWRiY20tY2EuZHRzaQ0KQEAgLTM5LDcgKzM5LDYgQEANCiAm
ZHUgew0KIAlwaW5jdHJsLTAgPSA8JmR1X3BpbnM+Ow0KIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KLQlzdGF0dXMgPSAib2theSI7DQogDQogCXBvcnRzIHsNCiAJCXBvcnRAMCB7DQotLS0N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IA0KPiBDaGVlcnMsDQo+IE1hcmlhbg0K

--KCdfrb0upY7YmbhKgdYV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4657): https://lists.cip-project.org/g/cip-dev/message=
/4657
Mute This Topic: https://lists.cip-project.org/mt/74489071/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KCdfrb0upY7YmbhKgdYV--
