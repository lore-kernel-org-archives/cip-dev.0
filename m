Return-Path: <SRS0=KN10=CL=lists.cip-project.org=bounce+64572+5362+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE89C433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 09:02:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107A2071B
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 09:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tY1ytp1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A107A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5362+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m3mUYY4521723xB7lnnnoc2X; Wed, 02 Sep 2020 02:02:27 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.3228.1599037345036163699
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 02:02:26 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 08292GPV020834; Wed, 2 Sep 2020 18:02:16 +0900
X-Iguazu-Qid: 34tMd2lTh1n5W4er69
X-Iguazu-QSIG: v=2; s=0; t=1599037335; q=34tMd2lTh1n5W4er69; m=iJU3Fj2eJCe7bXJ/voyv8MJ/RXBMsbHe+JBIbwHWgNY=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 08292EHE009428;
	Wed, 2 Sep 2020 18:02:15 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08292ET1003568;
	Wed, 2 Sep 2020 18:02:14 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08292EWf015565;
	Wed, 2 Sep 2020 18:02:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpKVt/5cNLKiSWmEfVZqwdMczCH6kZRemhKIPMz6trTV1cuLJepyNq5NvEI/nO9VCnbt8dJiiNtCF8BMmuehWzbIRbRo4wH6AGfqYf83ECuvfWmQGcYDvSKBc8xehWXn/OskxKD/n8Ztbmnp3ygvCgeSmUzoEJ26FyuEfSW5CsHB064iYkdVIx/w89hPfOmA0Ro/7pjpQWtmkVkRLrs0CdPcQml2pzUnCTbv0G1q/B0OpsRfkZ10w0mmEMpqMkRrbdmhu4IPTh1GXTC1pfa1yUd6XQuVnMM9sX4iqygyKXwoe4I+D5u48YIyjPmjYq0r2czH/bpuyZ7nRDowRzAs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DUclOtr22zW5uR6oRaOnrndQuWFTYZ05SpoxJ4Bj0Q=;
 b=g4usfUxm6Wc+fdSRCo2061DB4iw8gjKl/2gD30kPcVwWHGfBe/tpAC9663JEm7fIFQ/S+8jSjpWStI5BmK77ufjW17qed3tabP/4dPEa49315arSwIDIirmUDfwwrAD/EodK5QfM8XmG3rvxOFEmDIEB0wZ62TkMtfHzavGz6OdGyXSadDffMbOkx0F4qg8/Q09zTL08E7CWlp6QBMxb9kYcnmtyy6GCSCMDfUrZzzVR0pE6zU5s/Qf7olzVRLB0NhTzzyLZlnYH95PjkhKW13jx/T8nyzE90daZmQ1Yp0dL6XqiZTMpCOeuhdEQt4eUpTTHwdbg8188uyy4UG2jMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/5] Add RZ/G1H MMC/SDHI support
Thread-Topic: [PATCH 4.4.y-cip 0/5] Add RZ/G1H MMC/SDHI support
Thread-Index: AQHWgP3P1wCFnMPi/Eu5XyhaeNBWPKlVCDtQ
Date: Wed, 2 Sep 2020 09:02:12 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29839D5D38C48CF0899AB729922F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fbc8eff-1d1b-4f5d-07b6-08d84f1ee1c5
x-ms-traffictypediagnostic: OSBPR01MB3751:
x-microsoft-antispam-prvs: <OSBPR01MB375109FB55C9A8ECB625FE70922F0@OSBPR01MB3751.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFsa6F7uXFKsdXcwwHCJ/Hnzh8WmOqCwXQN591G4rpbviMhztxKvrUzIFkskjfePzHPm+DzDFHDxh+yn8GWG616yk+1/BSh640aK79h6VmGka6sWDhO8ZWyNTWxsFMc/RfWXIPquD4ArZgEwCR2pA/O/I3Z94d/EZNn7jOTdIR0NSHgb2HySSObbTiU3OsuDpeqZE/tpuP18JzaeZ1yrEbBCk+CxNs71asrFoTx8typMkXGsb8dnS8N0aEHkfWPD1oME9HbB+g1tPFgCpD0Fw9d38nUGnIra9YWmdf5Sp851QBKwhkkyMjNvZBN91+1Z
x-ms-exchange-antispam-messagedata: qb5Kr2cpPNq2GkI8yHmsDFru1YH4FQLKLWLvUPUvTI09Pvz9MlKjUhIkadEWHn4r0ByCvgwpSxf9coEk49ddjaO5m/3rG+4NhWFrLtsGDR/Hh1LyAQkbmmDt85/v/04bjMr2CFCyPGX057HrFgzc58Ko5ivDqqmtguXoL283Ia/oxWn1/ark7/I6/gsfIJUTlieLSplA2lItV2hS0nUX1PJpmnZwEzxvN9xg7klEEFdo9e4PbvT7YyLY9/WxxCG9MRKPt4ecJotsFVkl2gpUkIcWkr4yn/FrJqsZTx1+ZnHFwHw1zaitpoBIS8JdzUBTmBdatYcgK8BVuyNyB9FgqA67mOdH3zTDD5MOqAV+ySokWB1vxmBLWRDzDqPAXFWiyDMmzYGKvmyXrd5V3E6QpJj8Zs8IBgI0zgiFMu/AvJvRrC8pXZWcNR8rTHFTkvRqlrNFiS4FLI5THlD91rmNDkMWEvtabrPFak4+Fa/qm/sAMxAnTqb3rqhpElC2PNcvQLquO+VhDmkZWI8OzJELuacjnJSPNYbu5uf0Ux1KYA1wcWgYOpWE7kVAWsAZBJ8j9gd5lZoP/oxsigDsuQgfvpPc7vP8MSkSlKhp1K3CbM3iLx3sD3Z+iMgJ0X0ZQ1+URpCFIkF+PSJFHIWy09nlAA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbc8eff-1d1b-4f5d-07b6-08d84f1ee1c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 09:02:12.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKHYF9zuUth+Fu6KwLq8MTWWp5WZ6uCGB5elVmsZAYTgBT2dvXsyZhU3FaTyYoDRFvPJrlzjDBLICtZ1mMwTRbCw92gjcZQNEJkh6yLbrL+yPJ0Yf3yXTdKfa7Fw7K4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3751
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6svgzCsVsLcZG2hiCDhSm9Cgx4520388AA=
Content-Type: multipart/mixed; boundary="ayuSs4qwgQstwmG0ibbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599037347;
 bh=Gj9wAGi53KMgr4fszrN9sdiPDcXp/T/pYr97LO7hnNQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tY1ytp1E+rD3L8vpQ+BIxr3tWP82i4sP0EVbgbjfSyADtEOByVQLjnkNxvE+BFzSe1l
 CFF5hhAEyW2FNVQCtT7S37tKYEoLbTRKq+ATq+lc71xJ5djtFAaztihVlHGoztUNswD5E
 QOGCDx/2Vp4T3tKTeP1eH0MsepkgGdLmoQc=

--ayuSs4qwgQstwmG0ibbo
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rcyBmb3IgeW91ciB3b3JrLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEJpanUgRGFzIFttYWlsdG86YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb21d
DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIsIDIwMjAgNDo1MSBQTQ0KPiBUbzogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6Hm
tIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hp
YmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IENjOiBDaHJpcyBQYXRl
cnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkDQo+IDxwcmFiaGFrYXIubWFo
YWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0LjQueS1jaXAg
MC81XSBBZGQgUlovRzFIIE1NQy9TREhJIHN1cHBvcnQNCj4gDQo+IFRoaXMgcGF0Y2ggc2VyaWVz
IGFkZCBzdXBwb3J0IE1NQy9TREhJIGZvciBpV2F2ZSBSWi9HMUggYm9hcmQgYmFzZWQgb24NCj4g
cjhhNzc0MiBTb0MgdG8gNC40LnktY2lwIGtlcm5lbC4gQWxsIHBhdGNoZXMgaW4gdGhpcyBzZXJp
ZXMNCj4gYXJlIGNoZXJyeS1waWNrZWQgZnJvbSBtYWlubGluZS4NCj4gDQo+IExhZCBQcmFiaGFr
YXIgKDQpOg0KPiAgIGR0LWJpbmRpbmdzOiBtbWM6IHJlbmVzYXMsc2RoaTogRG9jdW1lbnQgcjhh
Nzc0MiBzdXBwb3J0DQo+ICAgQVJNOiBkdHM6IHI4YTc3NDI6IEFkZCBTREhJIG5vZGVzDQo+ICAg
QVJNOiBkdHM6IHI4YTc3NDI6IEFkZCBNTUMwIG5vZGUNCj4gICBBUk06IGR0czogcjhhNzc0Mi1p
d2cyMWQtcTc6IEVuYWJsZSBTREhJMiBjb250cm9sbGVyDQo+IA0KPiBZb3NoaWhpcm8gU2hpbW9k
YSAoMSk6DQo+ICAgQVJNOiBkdHM6IHJlbmVzYXM6IEZpeCBTRCBDYXJkL2VNTUMgaW50ZXJmYWNl
IGRldmljZSBub2RlIG5hbWVzDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3Rt
aW9fbW1jLnR4dCAgICAgIHwgIDEgKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi1pd2cy
MWQtcTcuZHRzICAgICAgIHwgMzkgKysrKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhh
Nzc0Mi5kdHNpICAgICAgICAgICAgICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKw0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvcjhhNzc0My5kdHNpICAgICAgICAgICAgICAgIHwgIDYgKy0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDQuZHRzaSAgICAgICAgICAgICAgICB8ICA2ICstDQo+ICBh
cmNoL2FybS9ib290L2R0cy9yOGE3NzQ1LmR0c2kgICAgICAgICAgICAgICAgfCAgNiArLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NzAuZHRzaSAgICAgICAgICAgICAgIHwgIDYgKy0NCj4g
IDcgZmlsZXMgY2hhbmdlZCwgMTIzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpU
aGlzIHBhdGNoIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLg0KSWYgdGhlcmUgYXJlIG5vIG90aGVy
IGNvbW1lbnRzLCBJIHdpbGwgYXBwbHkgdGhpcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGly
bw0K

--ayuSs4qwgQstwmG0ibbo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5362): https://lists.cip-project.org/g/cip-dev/message=
/5362
Mute This Topic: https://lists.cip-project.org/mt/76578438/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ayuSs4qwgQstwmG0ibbo--
