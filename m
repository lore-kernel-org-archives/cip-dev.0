Return-Path: <SRS0=lPCL=BJ=lists.cip-project.org=bounce+64572+5055+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A78FC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:12:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92451207F5
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YfkBAp0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92451207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5055+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RZVuYY4521723xFLmQjTtfHe; Wed, 29 Jul 2020 18:12:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.4806.1596071552291205677
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 18:12:33 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06U1CNTn011449; Thu, 30 Jul 2020 10:12:23 +0900
X-Iguazu-Qid: 34tr8v5ekCp2KZSeu3
X-Iguazu-QSIG: v=2; s=0; t=1596071543; q=34tr8v5ekCp2KZSeu3; m=pmCvGQAak4Y1Kz+6x/qKX/DS/9kSSZ2pg9i6qMR+8hw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 06U1CLxN004260;
	Thu, 30 Jul 2020 10:12:21 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06U1CLUJ027406;
	Thu, 30 Jul 2020 10:12:21 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06U1CLvP023033;
	Thu, 30 Jul 2020 10:12:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBLqCk6/X3yaShXYLpmWMSteZw8uYtHzml8CwlA4wdQPnhWmpzVwjLblp7x0ERek2JAQpgwNfnYf4gMENJaZGds9H9nWTw1wd+pMbEhePXdHnagNDQ8nR+YOTAbbSS76K9gTUCcZpGue8VjVI177WrvlO8/E3Wf/OS9wJBUUolNoK9pjI95XW4sPjD8FK5315HjBmz/CwMEsKAJdQ4qs41hksCzYlNcmnwJN/tAuxwBzDbGVAJS+4Juo0YJuJH1xPtKftSo9ox8hhViBWTn0qeQWL8XZRHf577cEsFLbVyRIHcuY4BQrz690K/qLjUpAFu4VSh7stgkzQiek2jJcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbpIDqCJeVmJWYOyXn+j/hi2D+R3gVYqoCX5G7HZUJ8=;
 b=luGR4PwB+LaFwciRJo1SlwJvRz2vxvxju+qOiabpS60H/emcp04H2ENIntnULVUazWRlaH+xLZLtSFIkrOQ+XULUTZsFzZxtItWDH6K0bK+2X6lrXoO47m2U4mtYh3JAZO3q26Sgj8yOS/55YPUQoYvdxQA3ACzaag+piPpPwn7avOiEdP0tBJdtJ5PT9j9qq/k97fHgPMZMYeUw5W0OTq8RH8mT3QgrI+wNcAJ65IQXdrU0ifX9MunVAFy38UzvktkogBDFgkThQKAsCeihZfAIbfuMj3PMi3gS1pKqEjY1ZB5fiPz/TuJE8XYfcVFtIHbqfgVv5ohknoJzTTyUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Index: AQHWZZbsTZShj1jcWUW22ApezgPMtqkfSnjg
Date: Thu, 30 Jul 2020 01:12:18 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48021d3d-41e4-4484-1940-08d834259a6c
x-ms-traffictypediagnostic: OSBPR01MB4005:
x-microsoft-antispam-prvs: <OSBPR01MB4005535707E510ABC5AF321C92710@OSBPR01MB4005.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YL7eRjzhYRrhrNitHEgdQNgQwm8nPwNq+ywHs5MC4Ph2m+5txm2V9DGPN5U0XgwzdrAlkqlBUl6Im8eqTQd3qBW0CVe6u5cnkr6dM8zyMCboRzvjenJpbuYfmnEot2cF3sPKfR2ow+OK/GN4nHguJrG0qjB7t5bV7R+7iKCmBmf002AjNHMzbqUpfdLQqUpfYN6enepbp4t5apsNESi0K+jAXhl9OjuqbviEQA8P0jNiyX3QQatYqhw39E/wG071VoiQE/KzguGNBhQulEvkt4ALv9bTrRp4nsF6Qgh3fLQomj3gfbX8BUFFPiP9f92MIku9B1DL4yALzoOZpLVLVe7fqtuw+dy4xPnW8dX9aymR47D0kVgyU5eiXxds6dISKfeJNv5TyaHrEb250pB/NA==
x-ms-exchange-antispam-messagedata: mjkoJ8GqqkQ38otGdNUgnfRCdys37NgJyjbq+gqYIrlmuC/hAfrnC8T3X20I+HQM3+1Fe4JN+tpzwijFNLMpd3p9Qed0eZBJzm+S6lqcY2jlhFQp/4cJBsGqAFfWJF9yeMEc+VqWfSWeoalbCj1V817FX0+F5Cwvboj3+fxknw7NmHaX6ly1vT/QIyfOKyqKb59oCQO93+3YjVCTnrrfUo/H8DzyKWfeOB5dY0NM4c86Tgqf98yGCAExbVAyczVia99R7ClT69+3bflVWsJLNqMivbChtJ6vPBOHnB2blMZub60asyhggZHP75akmqK/r4N7h49UJ0ctY0CrNSmL2qoPsddLYnp0OA5nGhsR3IMLu7lCDEkH97fsK94Pb7p8l3uKPZ3xoniieg0MYxMEJ0ctQtFZfpIF2KHtpiK6QYEDA6I5fF8CCnCKrssCNFtbJfmZmNEMUZyXC+GDpnuVDVJpJ1CSqriGNQlM7ruBgN7VB0LUz6hVJblZ56anktDNY3OpDtnN3ADPj8agT31JEuixjwZMbD8y+pWhTQ/s1piNtN6jiuqD0IXUkk927vJNMxv/mFxi624mWgJTxhNGpb7QQpFR22yLa/TRB1RKposZaBAG8slzc07EQTB7GrvtH8MXTGIZr6ClICugGLheAA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48021d3d-41e4-4484-1940-08d834259a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 01:12:18.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4zId3/QxKvUOVzEyDwZphoF4EBRRXUh0RmqSNDhHix54V2c6VMG0ns0SyDx+K03Ef3V/NtKEoyJXY5oYZQcxI37pVlxACctI5XudZg+h0cTcnqYNe1XW4cTkGDo93gT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4005
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rZ60heFwhbHVk9FdYQ7m5UxHx4520388AA=
Content-Type: multipart/mixed; boundary="7SUIXHAVjU1izkISrnIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596071555;
 bh=mPmTKRVLtJREf4D3kdE2GjW1gwQGcIkCD5AUO/XRkhY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YfkBAp0+rYJfbrk5K7PxDrv6FdRF1VKdv5OQOnu0kjKVLJw+n8tHvFkygGO/9hBHUFI
 WAntlM/ItOsj73EKMygYd0bYiWya9UIbpYRkmVrwDfAU+FWksT+R8K/QIYCWNN/rxCF5H
 h19J0B9hX3131M8F34ihLq0tYRnzF/m8v/g=

--7SUIXHAVjU1izkISrnIQ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5
IDI5LCAyMDIwIDc6NTYgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkN
Cj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWthciBN
YWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggNC40LnktY2lwXSBBUk06IGR0czogaXdnMjJkLXNvZGltbTogRW5h
YmxlIHRvdWNoc2NyZWVuDQo+IA0KPiBGcm9tOiBNYXJpYW4tQ3Jpc3RpYW4gUm90YXJpdSA8bWFy
aWFuLWNyaXN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBjb21taXQgOTlh
ZTc4ZjFmYzNhNzNjODhmZTcyNmM2NzZhZTk2M2NlNzIyYmYyMCB1cHN0cmVhbS4NCj4gDQo+IElu
IG9uZSBvZiB0aGUgaVdhdmUtRzIyRCBkZXZlbG9wbWVudCBib2FyZCB2YXJpYW50cywgY2FsbGVk
IEdlbmVyaWMgU09ESU1NDQo+IERldmVsb3BtZW50IFBsYXRmb3JtLCB3ZSBoYXZlIGFuIExDRCB3
aXRoIHRvdWNoc2NyZWVuLiBUaGUgcmVzaXN0aXZlIHRvdWNoDQo+IGNvbnRyb2xsZXIsIFNUTVBF
ODExIGlzIG9uIHRoZSBkZXZlbG9wbWVudCBib2FyZCBhbmQgaXMgY29ubmVjdGVkIHRocm91Z2gN
Cj4gdGhlIGkyYzUgb2YgdGhlIFJaLUcxRS4NCj4gDQo+IEFkZGl0aW9uYWxseSwgdGhpcyBjb250
cm9sbGVyIHNob3VsZCBnZW5lcmF0ZSBhbiBpbnRlcnJ1cHQgdG8gdGhlIENQVSBhbmQNCj4gaXQg
aXMgY29ubmVjdGVkIHRocm91Z2ggR1BJTzQsNCB0byB0aGUgR0lDLg0KPiANCj4gVG91Y2ggd2Fz
IHRlc3RlZCB3aXRoIG9uZSBvZiBvdXIgaVctUmFpbmJvVy1HMjJELVNPRElNTSBSWi9HMUUgZGV2
ZWxvcG1lbnQNCj4gcGxhdGZvcm1zLg0KPiANCj4gTW9yZSBkZXRhaWxzIG9uIHRoZSBpV2F2ZSB3
ZWJzaXRlOg0KPiBodHRwczovL3d3dy5pd2F2ZXN5c3RlbXMuY29tL3J6LWcxZS1zb2RpbW0tZGV2
ZWxvcG1lbnQta2l0Lmh0bWwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmlhbi1DcmlzdGlhbiBS
b3Rhcml1IDxtYXJpYW4tY3Jpc3RpYW4ucm90YXJpdS5yYkBicC5yZW5lc2FzLmNvbT4NCj4gTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNTgzMzM2NjUwLTI1ODQ4LTEtZ2l0LXNlbmQt
ZW1haWwtbWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20NCj4gU2lnbmVk
LW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpU
aGVyZSBzZWVtcyB0byBiZSBubyBpc3N1ZSB3aXRoIHRoaXMgcGF0Y2gsIGJ1dCB3ZSBhbHNvIG5l
ZWQgdG8gdXBkYXRlIGRlZmNvZm5pZy4NCklmIHRoZXJlIGlzIG5vIG90aGVyIG9iamVjdGlvbiwg
SSB3aWxsIGFwcGx5IHRoaXMuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo+IC0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NS1pd2cyMmQtc29kaW1tLmR0cyB8IDMzICsr
KysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ1LWl3ZzIyZC1zb2Rp
bW0uZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NS1pd2cyMmQtc29kaW1tLmR0cw0KPiBp
bmRleCAxZTMzMWQxZTQxNGIuLjVjZDk4OTU1NmI2MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvcjhhNzc0NS1pd2cyMmQtc29kaW1tLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9yOGE3NzQ1LWl3ZzIyZC1zb2RpbW0uZHRzDQo+IEBAIC0xNDksNiArMTQ5LDM5IEBADQo+
ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiAN
Cj4gKwlzdG1wZTgxMUA0NCB7DQo+ICsJCWNvbXBhdGlibGUgPSAic3Qsc3RtcGU4MTEiOw0KPiAr
CQlyZWcgPSA8MHg0ND47DQo+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW80PjsNCj4gKwkJ
aW50ZXJydXB0cyA9IDw0IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ICsNCj4gKwkJLyogMy4yNSBN
SHogQURDIGNsb2NrIHNwZWVkICovDQo+ICsJCXN0LGFkYy1mcmVxID0gPDE+Ow0KPiArCQkvKiBB
REMgY29udmVyc3Rpb24gdGltZTogODAgY2xvY2tzICovDQo+ICsJCXN0LHNhbXBsZS10aW1lID0g
PDQ+Ow0KPiArCQkvKiAxMi1iaXQgQURDICovDQo+ICsJCXN0LG1vZC0xMmIgPSA8MT47DQo+ICsJ
CS8qIGludGVybmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gKwkJc3QscmVmLXNlbCA9IDwwPjsNCj4g
Kw0KPiArCQlzdG1wZV90b3VjaHNjcmVlbiB7DQo+ICsJCQljb21wYXRpYmxlID0gInN0LHN0bXBl
LXRzIjsNCj4gKwkJCS8qIDggc2FtcGxlIGF2ZXJhZ2UgY29udHJvbCAqLw0KPiArCQkJc3QsYXZl
LWN0cmwgPSA8Mz47DQo+ICsJCQkvKiA3IGxlbmd0aCBmcmFjdGlvbmFsIHBhcnQgaW4geiAqLw0K
PiArCQkJc3QsZnJhY3Rpb24teiA9IDw3PjsNCj4gKwkJCS8qDQo+ICsJCQkgKiA1MCBtQSB0eXBp
Y2FsIDgwIG1BIG1heCB0b3VjaHNjcmVlbiBkcml2ZXJzDQo+ICsJCQkgKiBjdXJyZW50IGxpbWl0
IHZhbHVlDQo+ICsJCQkgKi8NCj4gKwkJCXN0LGktZHJpdmUgPSA8MT47DQo+ICsJCQkvKiAxIG1z
IHBhbmVsIGRyaXZlciBzZXR0bGluZyB0aW1lICovDQo+ICsJCQlzdCxzZXR0bGluZyA9IDwzPjsN
Cj4gKwkJCS8qIDUgbXMgdG91Y2ggZGV0ZWN0IGludGVycnVwdCBkZWxheSAqLw0KPiArCQkJc3Qs
dG91Y2gtZGV0LWRlbGF5ID0gPDU+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICsNCj4gIAlzZ3RsNTAw
MDogY29kZWNAYSB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZnNsLHNndGw1MDAwIjsNCj4gIAkJI3Nv
dW5kLWRhaS1jZWxscyA9IDwwPjsNCj4gLS0NCj4gMi4xNy4xDQoNCg==

--7SUIXHAVjU1izkISrnIQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5055): https://lists.cip-project.org/g/cip-dev/message=
/5055
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7SUIXHAVjU1izkISrnIQ--
