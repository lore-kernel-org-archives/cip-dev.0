Return-Path: <SRS0=ODGS=B5=lists.cip-project.org=bounce+64572+5139+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC09C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:31:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069BD20772
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="n+6opXGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069BD20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5139+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FCa9YY4521723xAOZGUB9qVH; Tue, 18 Aug 2020 23:31:40 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.83791.1597818698302186028
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 23:31:39 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07J6VaTw003240; Wed, 19 Aug 2020 15:31:36 +0900
X-Iguazu-Qid: 34tKGq3o2bDPzqczj0
X-Iguazu-QSIG: v=2; s=0; t=1597818695; q=34tKGq3o2bDPzqczj0; m=/wHhzBXLeqXCQa9A/PRjG3G75CWCFcvdYqEjmdooVgk=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 07J6VZaT029193;
	Wed, 19 Aug 2020 15:31:35 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07J6VZ5i029082;
	Wed, 19 Aug 2020 15:31:35 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07J6VYZR011957;
	Wed, 19 Aug 2020 15:31:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEFf4g3BB3soHyl+OXoKQyp6JwH3VqFff3Slnxw3S/NEr/6/HB0QtDrQeomRU8pJ53dLm+5V+qmQ33XVA8WNlhUUxKwE0OuAZ8EQN51ooUWCjkvyJ/d2vMF8G6QLgBsjM0DsGdVrsat3nYQ33VWAPS6RnylCNFxVjgYgRUvlVrZwIWlHNM6T/2hU617UwloftIfefgZ+k/bmXctMdT3IaowULr9ct7mA8YivKbGU29/VbehD6kv3RZTS7VS5XiRvo7yT320EqLP3DZlD5fewTsXUfhqOFMSFtxt20kpWGu9GQuX8Egm7CFdzHcAaZu9sg/69Avb+Vlz4HBp3IHnNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3ilzq1vYhnJKh3jZBD6HaTkFYPUEyu7Z5ZCRPuGHNA=;
 b=Tvf1yDpHh/UvLY0/vHariAyyngy6Wndtql6ZyMSjREWGjri1Lfus1zxIkwDc08kM3MGvEPimvsCTAYQIYFrnG+pfmYtB9KRfI/hQCpmMeXxNWp/t/vE5QjB9yb3lkkZ4uBZErsat9O3/jua6gzdxcE4SZBJHPyTQUCLHvN62JLNNywbYlxRpowoONQShzqcMo+0/CmpoJCQ45sDGPTlt6yjKyJ3ounSk3Q3QBuuIS4cyZtiAw/A20I2L2kKNtbVgPFn6LQZbGYhazEP0upTrcBd7B50DC1uPj+0h2mDMmmEOjbHydFcmR0qfVu9fzbKh3SdoRDeUHFxWZA+urfPhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
Thread-Topic: [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
Thread-Index: AQHWdeMimvCiSuPwBES9XOG7ooREhak+9ScAgAADS0A=
Date: Wed, 19 Aug 2020 06:31:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983FF1811B79A187E85921D925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <436e7176-7fd0-086e-6aad-784e3ea1e68f@siemens.com>
In-Reply-To: <436e7176-7fd0-086e-6aad-784e3ea1e68f@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 348874ce-0043-4369-f188-08d844098401
x-ms-traffictypediagnostic: OSAPR01MB1553:
x-microsoft-antispam-prvs: <OSAPR01MB1553DD1071159C61915AE8AB925D0@OSAPR01MB1553.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cR/igue5RXJkYn4Yn8TdidKR8KqlKEjj8cq7LpdOwrZuWZYDgcec4mZkq/8qBk4P+BnercoPd6Bia6UGkPHPgFr5FlBCWkn5HJ+zog+d78wBxx7+impJgis4bnFjCjvaJ7nKOc4+TVS/qWbbVxlruPTrrJ5EgstyF3ouSODX4A5aA5c57LuLbyrDzg9psW0H4fAHaUgKBHUmvK4nRMMqbpxAiRDeQtRyEd4AhKhjFwILmCRrhRus3EfbdHwI4QN9pj+7+f8QBkAvgDypAXaRNQwjjofu6CUii7MW7tqGFZ/KUK0KHTbSmLaxssF0ukK1Vcy9Jnu9cUWlKI3EbvLxzl1HGQgH28frS/lzHDvjERUloaSon0lSnOSDOXLc3YLy
x-ms-exchange-antispam-messagedata: 8LmAgs1JxjH5sF+0dHTxKexJInLXn1WjWScL+3IuM+hXriLm7+Xfkopnpv01B8UoldXZrMPfCKsBHRY+R55hSXtY7Jck64j9KoqarYSanBmt+Fre1t5qX1aUujrfbcAUUR+XdFN/+sx8HkJnzS+WsdJK2QZRjAuuVJcgp6sa4HNtGzJZ0PYXVnbWL1ciPisxiSQPzFLJja7Li5a8sjsq06icS5lnOVb4C2ETHpe9UONN2Ry6Ir6Bix+rVw1Xqu+zB+Ye837FTNu0a8cex/8V49bugYt1uUpB5Ubu//03+7NA/FH8MbtRpbgAtasf+RyP46P+jlPlsa1mma9X6201DNo488EPK9ZQcw5AT35uuAgSIqWJKg51TWSJ0ONKF39pkRKOO2gnfj8XVc9XIwkniktM/r71Umq8/0z+OSb7CGWgg+2Xb6zhTiRThroVadAF3M1DkHfp5OLIO5fjJ6+UDImZLG7mHqizrwak/LC4ftUjAnSdmjCeYrOQgASe5q3QWIGAR+qIxQjua5jLn225AScl8fTasQbJ0l0Nw2DufF2QwNsdLjIpeKRHvxMjoIuhkFUfwOX5YBgqKekI/yOScLGWoB9rpOJ8KGjHIjQFo+nUF73LlYh3KT4L3nM9KU1QzrJ60y+kp6mIqYOAjJ0mlQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348874ce-0043-4369-f188-08d844098401
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 06:31:33.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSQ8YVdOk73ZcfehLEsM1d78Xg6UFXtySPspB/7uXpU56X2jJ4uYCcjLtQUcbMAyCmrETI4yP/qWmPY9U8K3HkDLWQW/oJ8NJmcSke8LXM6XPNa9ajJwM+4fPvCoXptz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1553
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OY4dZ8wB1y0LzMvdYSsa6aRix4520388AA=
Content-Type: multipart/mixed; boundary="ijOcsAzAc3oSiRmh5GYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597818700;
 bh=x81/e/2tMbUXYQghxqn1d12a/hlvNGcH/eks8FNYOAI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=n+6opXGPxdzgEyBWcHHhxO1E9PgrW34BBLEmR7yBI9z9+RXorn3deUZPPy4U+pfHBa9
 kLs3WdmKU/+He4s7f6a0nQA2iN1Yze2FcDvNEt94aXeAtw14KlyMkndsA7gYpmTqii3oC
 1AXXGkK0bEDinbGrVf/4BzphQTSzTRMxogQ=

--ijOcsAzAc3oSiRmh5GYo
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0
IDE5LCAyMDIwIDM6MTggUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg
4pah77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28u
anA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2lzYXIt
Y2lwLWNvcmVdW1BBVENIIHYyIDMvM10gdGVzdGluZzogQWRkIHRlc3QueW1sDQo+IA0KPiBPbiAx
OS4wOC4yMCAwNjo0MiwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4gQWRkIFlBTUwgdG8g
YWRkIHRoZSB0ZXN0IGFwcGxpY2F0aW9uIHRvIGVhY2ggaW1hZ2VzLg0KPiA+IFRoZSBmb2xsb3dp
bmcgdGVzdCBhcHBsaWNhdGlvbnMgd2lsbCBiZSBhZGRlZC4NCj4gPiAgLSBsdHANCj4gPiAgLSBy
dC10ZXN0cw0KPiA+ICAtIHN0cmVzcy1uZw0KPiA+DQo+ID4gQW5kIHRoaXMgYXBwZW5kcyAnLXRl
c3QnIHRvIHRoZSBnZW5lcmF0ZWQgaW1hZ2UgZmlsZW5hbWUuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
DQo+ID4gLS0tDQo+ID4gIGthcy9vcHQvdGVzdC55bWwgfCAyMCArKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQga2FzL29wdC90ZXN0LnltbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2thcy9vcHQv
dGVzdC55bWwgYi9rYXMvb3B0L3Rlc3QueW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwLi43NWIyNTdkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2th
cy9vcHQvdGVzdC55bWwNCj4gPiBAQCAtMCwwICsxLDIwIEBADQo+ID4gKyMNCj4gPiArIyBDb3B5
cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMTkNCj4gPiArIyBDb3B5cmlnaHQgKGMpIFRvc2hpYmEg
Q29ycG9yYXRpb24sIDIwMjANCj4gPiArIw0KPiA+ICsjIEF1dGhvcnM6DQo+ID4gKyMgIE5vYnVo
aXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPiArIw0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gPiArIw0KPiA+ICsNCj4gPiAr
aGVhZGVyOg0KPiA+ICsgIHZlcnNpb246IDgNCj4gPiArDQo+ID4gK2xvY2FsX2NvbmZfaGVhZGVy
Og0KPiA+ICsgIHRlc3Rpbmc6IHwNCj4gPiArICAgIElNQUdFX0lOU1RBTEwgKz0gImx0cC1mdWxs
Ig0KPiA+ICsgICAgSU1BR0VfUFJFSU5TVEFMTCArPSAicnQtdGVzdHMgc3RyZXNzLW5nIg0KPiA+
ICsgICAgREVTQ1JJUFRJT05fYXBwZW5kID0gIiB3aXRoIHRlc3QgcGFja2FnZXMiDQo+ID4gKyAg
ICBJTUFHRV9GVUxMTkFNRV9hcHBlbmQgPSAiLXRlc3QiDQo+ID4gKw0KPiA+DQo+IA0KPiBBaCwg
bmljZSBzb2x1dGlvbiB3aXRoIHRoZSBfYXBwZW5kLg0KPiANCj4gQ2FuIHlvdSBmb2xsb3cgdXAg
d2l0aCBhIHBhdGNoIGZvciBDSSB0aGF0IGFkZHMgdGhlIHRlc3QgZmVhdHVyZSBhdA0KPiBsZWFz
dCB0byBzb21lIG9mIHlvdXIgaW1hZ2VzPyBJIGFjdHVhbGx5IHdvbmRlciBpZiB3ZSBzaG91bGRu
J3QgYWRkIGl0DQo+IHRvIGFsbCwgb3IgZXZlbiBoYXZlIHRvIGluIGNhc2UgdGhlIENJIGltYWdl
cyBhcmUgZGlyZWN0bHkgdXNlZCBmb3IgdGVzdGluZy4NCj4gDQoNClllcywgSSBwbGFubmVkIHRv
IGRvIGl0IGFmdGVyIGl0IHdhcyBhcHBsaWVkLg0KSSB3aWxsIGFkZCB0aGlzIHRvIHYzIHBhdGNo
IHNlcmllcy4NCg0KPiBKYW4NCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAt
LQ0KPiBTaWVtZW5zIEFHLCBDb3Jwb3JhdGUgVGVjaG5vbG9neSwgQ1QgUkRBIElPVCBTRVMtREUN
Cj4gQ29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--ijOcsAzAc3oSiRmh5GYo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5139): https://lists.cip-project.org/g/cip-dev/message=
/5139
Mute This Topic: https://lists.cip-project.org/mt/76280651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ijOcsAzAc3oSiRmh5GYo--
