Return-Path: <SRS0=dxI5=E7=lists.cip-project.org=bounce+64572+5867+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578EC5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:26:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1889A2075A
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t4kByY/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1889A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5867+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SDdNYY4521723x5uU1I98PA1; Tue, 24 Nov 2020 22:26:40 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.3289.1606285598492449645
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 22:26:39 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0AP6QYso032489; Wed, 25 Nov 2020 15:26:34 +0900
X-Iguazu-Qid: 2wHI1rzKgI4MUE3TKl
X-Iguazu-QSIG: v=2; s=0; t=1606285594; q=2wHI1rzKgI4MUE3TKl; m=S8GR+0YomsCO+zuODcaBFJH8neBVvAtch6u/NJVshVE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 0AP6QXG3016220;
	Wed, 25 Nov 2020 15:26:33 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0AP6QXt7016366;
	Wed, 25 Nov 2020 15:26:33 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0AP6QW4Z001461;
	Wed, 25 Nov 2020 15:26:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfafqY+V9hyCpnuu3kOfyfuRDSUE4AuoDRm8fTbLhoqnVRM3cHw79k9buDQEii8ZDu8w1d60yWxsMpYJ8Tj2aaxb0N5neuDNIXOD9h3VVvC+TXK7pVUbfZWn+uhn8U49rBuJLb9E7UGc1/lOjzD5VLmnk7q0t2zYznb+kB208qr7meehF1+Rje/17yCWgpyGCW3yf2Gad7bEdIgoz98cVXo60VCnPM21pWDDOXf8yrCveuM4a3A1+WXIq/XeY/ghFed6ahXsSsRUl02fBs3m6PfvO9LZEqf1nTXl3/U4BwQc+GAd9W8S1MlTYmhe+Eubt4hCztcapAwfFxI4hrVVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD+m38FLLy1E8LcaslKK7SNNwkP2LvTp8tmr1hzweg4=;
 b=YCTe8nSntT9nOHn2MwC2o+2SxxHggo3EYnqQtVw7AzHc6LGFQ6h1RYZgJVttoet8nka6O312Prv8XAH/Rnd1HGV5rDqiKZxBG0C2X546MSVEDlryKAQ0z4r6c3ubz35GC4lmItOy8ZlVAHAyP8mVw0YqT3WtUlRMMrdUHrc55Gr80t71Tnlzjt7RCX9sx79R115j6TE9vDXlr5h29N0Oeo3Z9mKOvU+hWNY9xHNxXmpUoyEwOvNnNQx4YR+6M5Oql8TwuHrzvQfLUw8gM6N5Ci60mrxng7sDD1p/JtLhyLBwoXEXm46B582spWAUaKDyMFJT1jZa4TpVahp9kAC7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
CC: <Chris.Paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Thread-Topic: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree
 support for r8a7742
Thread-Index: AQHWwojykeDEnEGaeES+wgaaO8dIr6nXkakAgAABbQCAABeYgIAAtz2g
Date: Wed, 25 Nov 2020 06:26:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983B734A3EC71CE772DF84492FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201124174036.14934-1-biju.das.jz@bp.renesas.com>
 <20201124175808.GA2713@duo.ucw.cz>
 <TYBPR01MB5309F702E453CCBB5987FB8186FB0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20201124192741.GA4916@amd>
In-Reply-To: <20201124192741.GA4916@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3848c279-20d1-4f14-9b4c-08d8910b0949
x-ms-traffictypediagnostic: OSYPR01MB5303:
x-microsoft-antispam-prvs: <OSYPR01MB530351E134DC431D187B95E192FA0@OSYPR01MB5303.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NwDeG9eu+LVb+LEqeRZIadi2H2N4TuJFVQaXhsTVK3Y4RqrE3++Dk6lx8kjLR9U0DkOehwro8xsrjurVRLSVZAtd7pazFidkTTip5iCV3ywp0T95IaCjFH21k+TcSbrE+iemPXFGXPs87CYisWhS9R9bqJP+YOeUaHEdD71StLerQwqW8KPb3D80T82jM77mcEghgkNBk+MPC/7iyEgfsxXH/XooZUe6WWXMD4nv00QVwF7WxyrzEYHaDlfMvFqJyHyWzpyF5iNlRLLNj7+W1qNYXH+36dxK5vV2D/pcRTg2dp7jjcZhXMplqBB2gla5QtUPiOA3ObMVSIP2U8ckMjh5xrHp3pWDXAnt5piBhMbPlU9XDI60wB3aay6dYGpD
x-ms-exchange-antispam-messagedata: =?utf-8?B?WVBjR01TTUt4YmpyR3crY0VMMFVFZEtaRHVPOG5pOUtOZ21UMExOTDYvV240?=
 =?utf-8?B?V09nZmhCNVBlbC85M25OS1lVaFMwbS9rT280MndtUHRZVW9xblBpaFQ2V3dG?=
 =?utf-8?B?N0NVUUZiU0hUY0lUeTFwWlZKYUR1ZEhuWGNhY0Z6b1pQMEVoaS9QRkNWZ3pn?=
 =?utf-8?B?QXdmcjdHSEFUdTFVdU15QkZMTDJFUUVsQ2RzUG9aN1loUnlzWXJRUng4aFpL?=
 =?utf-8?B?Sm51a2V4ZFlVTkl1QnIvRzZ1b1NFTmVvQjE3UGhhMW5ZaFNLL0pjSk16Zmt2?=
 =?utf-8?B?Q3JISGR0UHg4YkZBbVJYSGxsbmpXTTNpejBmRlVPN09iR3hNSkVjb3Y3eUpM?=
 =?utf-8?B?UXU1ZkhDeEVzYjJlVGFvQXlsc1M1UGpYUFlmVk5sWDV2REJwWTFuZWJwVGsy?=
 =?utf-8?B?RW9lZDI5WHZ3VWZQWHFTcXNmb2Vka2dieXVIbFFnMnBBaUV0bFUxMEZPS21S?=
 =?utf-8?B?dFJEclpkRFpPem1GYk1DaHpHRVIxNU9XMHZib2kwbkorVzZncEZKY3g4K3BL?=
 =?utf-8?B?R1F3NzVvMmdtaTJqdEpVdTdDYzVyamxsczA5by9BMi9YSUpIY3BhbU50THox?=
 =?utf-8?B?d1QyWi9sc3FjdjFoSWVCcGRLRmdwd2hiREhiUUZORmk0bUxkbGhZMVJUQ21s?=
 =?utf-8?B?MlRvMDV4djZxaU9OdnlOZUxoVVJyU3VXWjQ3R3JjazZIdkpyaVZkRTBIWXIx?=
 =?utf-8?B?SGdrR1JyaG5XQWx4TmdiUUROeUpEMXBlTmtPSWlzSlpxSHlINXJYS0NRRkZU?=
 =?utf-8?B?RFZzMFVYbVpySlFsbVpZMWJVMWhQb0dqQlVHalQvVTRKWE92TG5hcmhsQm5M?=
 =?utf-8?B?VzJaandoM09YL2VLVmlGMldIZ2NyNWV4UVBqODM0c3hiT2RSWHpuakRXYlBF?=
 =?utf-8?B?R2hDRnVOL2R1SHkrRkM2ZkhpUGFtVmlLUEZSTlNZUXI2NERnNFpMVDFoSzZy?=
 =?utf-8?B?cHJvODRIRjFrU3dJK1UrMElGMWNWUlRTb1ZRcmtQTnI0REpzbm03NUNzNVNl?=
 =?utf-8?B?ZXdUVjUxZDVhRFVFbklNK1JKd3pDaFV6M0YwWFI1cG91cmtEQWtNYy9GYnhU?=
 =?utf-8?B?VmMxOFgwQjV0TlpiZE9tUU51Y2VlaU5jbkhnUGppSmJOeHZUTlJmOHFaZjJy?=
 =?utf-8?B?S1ozMDltWmg0d1dpM3Q0bVZrSDJBRVR4c3I0VUxQY2FTcFhlK2JXZGJlb1Zh?=
 =?utf-8?B?YnZQaDFCTVRpMlNIYTdKUC9OZExrTnZueHc2UTRDdm9wZFNoLzNYZkRZNWh2?=
 =?utf-8?B?a29zejVTNEp2YmRiQmlMYk5Oa3lseVQvaVYxWmZFZ3BvMXRhYTNqaGczei80?=
 =?utf-8?Q?KhufNkQkujm9Y=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3848c279-20d1-4f14-9b4c-08d8910b0949
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:26:25.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AK4naAS9tGCU1XMObfuJGd/7AqdRzCiyy/JCOhL/T2godD/aaXIG/xUzdzocYGgoZidc2AaROSddpLxTfuGzJpb9QFGL2rOrsG9/87vKJBb/D10MBGvGA2eFUncJsK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5303
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DVhondkBpdnuEc5YCOyHiMkJx4520388AA=
Content-Type: multipart/mixed; boundary="ZsU4Bd6PaGdvtltt0mcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606285600;
 bh=2ijpHTV9ftG8htono7jimHOtdZRJkIsZHA9eelcctMw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=t4kByY/hLCXX+6vkHD6fWnSqm58gjHe4COT0dVTkfVCcVgoHRMgIbw5d5sjfypU8969
 EuKMOe7656yuGf7PM8Wh4llzM9eKzI/+8spEYZ+nMYPUH2bW6mfF9KPjyRUVPsAS4Nd+H
 UzyUKByVQTLUJFX1MM8/XXpnqYqRjzv0D84=

--ZsU4Bd6PaGdvtltt0mcj
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI1
LCAyMDIwIDQ6MjggQU0NCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gQ2M6IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8
o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgQ2hy
aXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47IFByYWJoYWthciBNYWhh
ZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBT
dWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRDSF0gZHQtYmluZGluZ3M6IFBDSTogcmNhcjogQWRk
IGRldmljZSB0cmVlIHN1cHBvcnQgZm9yIHI4YTc3NDINCj4gDQo+IEhpIQ0KPiANCj4gPiBUaGFu
a3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+ID4gPiA+IEZyb206IExhZCBQcmFiaGFrYXIgPHBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4g
Y29tbWl0IGQxNmQ1MzhmZjQ5MTQ1YjE1Mzk3NmJkOGUxMjQxMTZkMzY5ZGIyNjYgdXBzdHJlYW0u
DQo+ID4gPiA+DQo+ID4gPiA+IEFkZCBzdXBwb3J0IGZvciByOGE3NzQyLiBUaGUgUmVuZXNhcyBS
Wi9HMUggKFI4QTc3NDIpIFBDSWUgY29udHJvbGxlcg0KPiA+ID4gPiBpcyBpZGVudGljYWwgdG8g
dGhlIFItQ2FyIEdlbjIgZmFtaWx5Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBTdXJlLCB3ZSBjYW4g
YXBwbHkgdGhpcyAoSSBhc3N1bWUgaXQgaXMgZm9yIDQuNCk/IEJ1dCBpdCB3aWxsIG5vdCByZWFs
bHkNCj4gPiA+IGFkZCBhbnkgc3VwcG9ydCwgaXQganVzdCBkb2N1bWVudHMgdGhlIGJpbmRpbmcu
Li4gc28gSSBhc3N1bWUgdGhpcyBzaG91bGQNCj4gPiA+IGdvIGludG8gc2VyaWVzIHdpdGggcGF0
Y2hlcyB0aGF0IGFjdHVhbGx5IGNoYW5nZSB0aGUgZHRzIChhbmQgcHJvYmFibHkNCj4gPiA+IHR3
ZWFrIHRoZSBkcml2ZXJzKT8NCj4gPg0KPiA+IFdlIGhhdmUgYWxyZWFkeSBiYWNrcG9ydGVkIFBD
SUVDWzFdIHRvIExpbnV4LTQuNC55LWNpcC4gT25seSBkdCBiaW5kaW5nIHBhdGNoIHdhcyBwZW5k
aW5nLg0KPiA+DQo+IA0KPiBBaGEuIFNvcnJ5IGZvciB0aGUgbm9pc2UuIEknbGwgYXBwbHkgaXQg
aWYgdGhlcmUgYXJlIG5vIG90aGVyDQo+IGNvbW1lbnRzLg0KPiANCg0KSSBkb24ndCBzZWUgYW55
IHByb2JsZW1zIHdpdGggdGhpcyBwYXRjaC4gSSBhcHBsaWVkIGFuZCBwdXNoZWQuDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg==

--ZsU4Bd6PaGdvtltt0mcj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5867): https://lists.cip-project.org/g/cip-dev/message=
/5867
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZsU4Bd6PaGdvtltt0mcj--
