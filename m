Return-Path: <SRS0=zGj0=CJ=lists.cip-project.org=bounce+64572+5343+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF83C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:52:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D3B20E65
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gCDsc9yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D3B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5343+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V3LpYY4521723xYdJczxvTK3; Mon, 31 Aug 2020 15:52:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.603.1598914323868233949
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 15:52:04 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 07VMq15W004405; Tue, 1 Sep 2020 07:52:01 +0900
X-Iguazu-Qid: 34tKSwRU91LTMV8xUW
X-Iguazu-QSIG: v=2; s=0; t=1598914321; q=34tKSwRU91LTMV8xUW; m=K+hoWfR6QbhIB/61kuCrqLb0z+3AVO3PG02WdkobFIg=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 07VMq0lT002249;
	Tue, 1 Sep 2020 07:52:00 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07VMq0oa003428;
	Tue, 1 Sep 2020 07:52:00 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07VMq0w4007233;
	Tue, 1 Sep 2020 07:52:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+BOgt0rQnuRA0+4FVcwPQgF62r8uNnyq3bG+Gvwug4atZKHZ2YlNJYcvTzrN6vTRVBCz+t5q3TU76Mz/iaB4jWLz4MHN2zL1iFqZXyhrT0+9IbNhLCb0/p8RlS8nvwVBq1AOqs4MQ1MK1Jm5x9SDv4Z6RB/95+zpmgBzD74zVZxnTf/h0N7WU14FsO/b3g49sNlz5m0AFXHBXIOsT+OBzgOR6RqQMQx+FAR9uSBZ6co/Cer+5uGM46I/2LV+VO7ccvILYEJjLY5X1zj+MowQPxV30XvLucG6okFBD2GXfT9h05vFU4Jl84Uxwmx8ajV3PpoSd82y6JOowdYU9vfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVy4apU7T6qgEpO/Xb7KVpOrL1KTS3ovdOskfd8740A=;
 b=jEUbLhdzjk0kUKwhK/LDwoBcQvbDrZ6qK+UH0BGo+ux8dhiasovjR4odl5vCqBvqEkM5xNd/9M6DeZHKSNXpQ5+20p6m6hNBwmovcQtPzSOtU3IbVTqaVYNBQVAbqWM+j61OaTHYAWc2Q61NUXiuhBu6s0goeK3MSboBDWB6+V1ka0mtvK1K6dglX4TMiIC11koOLng2k7z3MHdIr5I1QWv4h3l24RGa4NrJBTishJZ6SAmP9rPHZRh9HFlkgo+ij6Pbt+0DwA+f7gKK6qkra3GIEaP9keiRLSlI/S1vPbDgXcOMZrIxGj/rng9nOG6YLlyCmSkQmQjbAc8j6Zv97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/3] ci: Do not try to deploy the security image
Thread-Topic: [isar-cip-core][PATCH 2/3] ci: Do not try to deploy the security
 image
Thread-Index: AQHWf3gnAc5oyXBcg0uujlfgsYmDqKlS0ziw
Date: Mon, 31 Aug 2020 22:51:57 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E24BF973CB4EB355A9B592510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
 <83d75816ceb5f74802ac0cec5292bf257ffc2d48.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <83d75816ceb5f74802ac0cec5292bf257ffc2d48.1598865682.git.jan.kiszka@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5fb6e51-91ae-41ff-fdbd-08d84e0076dd
x-ms-traffictypediagnostic: OSBPR01MB1669:
x-microsoft-antispam-prvs: <OSBPR01MB16692364B5DB0991D253A03F92510@OSBPR01MB1669.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uD7MvU06iD8duVOyrVohN0Q7kDXpfDyViSHE2CSvBEXdUznQ5H7XEPpW83qHx0wo+pjUpRHPIwzWIomHrQdbYMPLrxUPTkCoRp/fz00yxHmWWx9Y92K4qqNtptL26Rgduh+GWQiQiPlY6gYqduLqKLUu0mejaccWFue9j/IDs3DpfY3yEvycZkLxHFw9pyXOGk8CbiIHitBGUK2nuv+4MZbWd8W/QK9tYO26u47G1chANmp2buwJ19Fx/C+LGYW3b1aG6gYZJhewMIAycFaB9dR33D7Ha6w/T4Zoo3ybuPeB0s42B+t/q6NOTR40FKgC+i8zuNlSy8taifPb/Sq8Yg==
x-ms-exchange-antispam-messagedata: MQXBEVyt9K7C7CVvh3DNoxrK/TXxtY7ocU/6NXFxYRD3StBXGeWvZsmHGauYtM4LdaPtPwXRfoeT5ZLVNwU54tx1hg1hlLAtcS+O8g3F/moVVq95pIrg7K2jg7n9WuUEb+ffnwNJ23VUCkkTTZlQRF99jLRCms7xtAE90FV3XQ8uGMh8OAriIWgtg7YxAvJSrapZSuqhnGr/P/JIZU1ryRc64WJYENjuapbKWl2JAmIGBmDJM/hKYhR9OlFrxRZmtoqIIeQ3pDuwfQtIMFe79o9qs18sD0tmMhSSYKrhG7t1sDrs2WiycDFaJ5xvX/1vWZT0/VAcl9yYLL08nkbm+o0jXjpK8EdOBLSxe5CfoXfnQ82Ddx5MBhna8RXayCe4t9X/PtzkO2SUNgprQCoRB13YKp/TZI74s1iDWf0jVllJRyw7sFzHC91NDs/6cYT5tFp3cDCHt7Vq/TxeaOnnQPv4pLJCpiaYbDdiseviODyTHlusqHw9w0tQ4XUiWveSY/y0AP2aRoXt77uNlnNXAV8Be4mFPYfO8JnIyKha++En6VB+AMKk+RnREELrhoOys7qIzDN3p/BJu1G0zHypq+vmvwzICcc9xIJClUrYIZ0+uHziTpGwnquV0IfwH/Fu0REzk5+obvbmRIyJLnEJUA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fb6e51-91ae-41ff-fdbd-08d84e0076dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 22:51:57.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E15auh8JBaNx85qWlCciud+Zkycjx7xArJS27W47JoE9epVwfaEM0a9PLrdAZfeWno+jJndrz6IcExyV6tNjZBtoDpR7ELHIxoFCCXc3BiFx1tVsAQadN8l5KPpBt221
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1669
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ipPHvebNEtGCJiMxqrvbSNaDx4520388AA=
Content-Type: multipart/mixed; boundary="laUgWpOPgjl1iP1W0hJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598914325;
 bh=GS4cTth6xrK+Gu9W9HxOCSQKOHSDOCyW8aOzucoB8Q4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gCDsc9yLDIp8V6RDo95cubu2CZJ2dztBltAiEJWKHl8Nz9r7OIjy3eDBzVQGR9O1PZx
 6gGWsxTmEGlPyRpKK2xszsmq2rT88vy0Bp4vxDpDG2lmot8h59yeoJkSLkIWhCyXdpCVw
 Gngfoaoaz9UwZDvwZRdhNmf9OqRm01+HFBQ=

--laUgWpOPgjl1iP1W0hJJ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDMx
LCAyMDIwIDY6MjEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENj
OiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8
tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBbaXNhci1j
aXAtY29yZV1bUEFUQ0ggMi8zXSBjaTogRG8gbm90IHRyeSB0byBkZXBsb3kgdGhlIHNlY3VyaXR5
IGltYWdlDQo+IA0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0K
PiANCj4gVGhpcyBpcyBub3QgdXNlZCwgYW5kIHRoZSBpbWFnZSBpcyBub3QgYXZhaWxhYmxlLCBz
byBpdCBicmVha3MgdGhlDQo+IGJ1aWxkLg0KPiANCj4gRml4ZXM6IDM1MTBmOGE2NmY4MCAoImNp
OiBSZXdyaXRlIHVzaW5nIGV4dGVuZHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2lzemthIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPg0KDQpJIGNoZWNrZWQgdGhpcyBwYXRjaC4gVGhlIHByb2Js
ZW0gaGFzIGJlZW4gZml4ZWQuDQoNClJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhp
cm8NCg0KPiAtLS0NCj4gIC5naXRsYWItY2kueW1sIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvLmdp
dGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbA0KPiBpbmRleCBjZDI1NDM3Li4wYjBhNzcxIDEw
MDY0NA0KPiAtLS0gYS8uZ2l0bGFiLWNpLnltbA0KPiArKysgYi8uZ2l0bGFiLWNpLnltbA0KPiBA
QCAtNyw2ICs3LDcgQEAgdmFyaWFibGVzOg0KPiAgICB1c2VfcnQ6IGVuYWJsZQ0KPiAgICB0YXJn
ejogZW5hYmxlDQo+ICAgIGR0Yjogbm9uZQ0KPiArICBkZXBsb3k6IGVuYWJsZQ0KPiANCj4gIHN0
YWdlczoNCj4gICAgLSBidWlsZA0KPiBAQCAtMzAsNyArMzEsNyBAQCBkZWZhdWx0Og0KPiAgICAg
IC0gaWYgWyAiJHtleHRlbnRpb259IiAhPSAiYmFzZSIgXTsgdGhlbiBiYXNlX3lhbWw9IiR7YmFz
ZV95YW1sfTprYXMvb3B0LyR7ZXh0ZW50aW9ufS55bWwiOyBmaTsNCj4gICAgICAtIGlmIFsgIiR7
dGFyZ3p9IiA9ICJlbmFibGUiIF07IHRoZW4gYmFzZV95YW1sPSIke2Jhc2VfeWFtbH06a2FzL29w
dC90YXJnei1pbWcueW1sIjsgZmk7DQo+ICAgICAgLSBrYXMgYnVpbGQgJHtiYXNlX3lhbWx9DQo+
IC0gICAgLSBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCAke3JlbGVhc2V9ICR7dGFyZ2V0fSAk
e2V4dGVudGlvbn0gJHtkdGJ9DQo+ICsgICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIg
XTsgdGhlbiBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCAke3JlbGVhc2V9ICR7dGFyZ2V0fSAk
e2V4dGVudGlvbn0gJHtkdGJ9OyBmaQ0KPiANCj4gICMgYmFzZSBpbWFnZQ0KPiAgYnVpbGQ6c2lt
YXRpYy1pcGMyMjdlLWJhc2U6DQo+IEBAIC02OCw2ICs2OSw3IEBAIGJ1aWxkOnFlbXUtYW1kNjQt
YmFzZToNCj4gICAgICBleHRlbnRpb246IHNlY3VyaXR5DQo+ICAgICAgdXNlX3J0OiBkaXNhYmxl
DQo+ICAgICAgdGFyZ3o6IGRpc2FibGUNCj4gKyAgICBkZXBsb3k6IGRpc2FibGUNCj4gDQo+ICAj
IHRlc3QNCj4gIGJ1aWxkOnNpbWF0aWMtaXBjMjI3ZS10ZXN0Og0KPiAtLQ0KPiAyLjI2LjINCg0K

--laUgWpOPgjl1iP1W0hJJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5343): https://lists.cip-project.org/g/cip-dev/message=
/5343
Mute This Topic: https://lists.cip-project.org/mt/76530563/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--laUgWpOPgjl1iP1W0hJJ--
