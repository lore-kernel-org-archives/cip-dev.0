Return-Path: <SRS0=1GHC=BI=lists.cip-project.org=bounce+64572+5043+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D49C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 06:11:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5024F206D4
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 06:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HqmnrY4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5024F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5043+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ckOYYY4521723xkEyuvWq8zh; Tue, 28 Jul 2020 23:11:47 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.581.1596003105387399993
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 23:11:46 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06T6BYYS001141; Wed, 29 Jul 2020 15:11:34 +0900
X-Iguazu-Qid: 34trJzXMYDFPW2TOuP
X-Iguazu-QSIG: v=2; s=0; t=1596003094; q=34trJzXMYDFPW2TOuP; m=jRwxXW7QuR83/p9JPxjV3eY3cSA1hfMxGy1E0Brn4YM=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 06T6BWRo034906;
	Wed, 29 Jul 2020 15:11:33 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06T6BW3o019151;
	Wed, 29 Jul 2020 15:11:32 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06T6BW7o011805;
	Wed, 29 Jul 2020 15:11:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBEQiyD4pt4zSEWW15w6fK/gK4y7liia4jA1YwXQiPbevZCzRFUawcoiDplQ0DCVCEtuNkPDDySKWZ3yOPhwq05pUku/A0B1rifYzCI8+iuyTp852rqRDzzeuIH4oIauLPqcOLuV8KGR46127vVb8TcBoUuYoNl0si85aZqGutam3wswiPzugDpI+smlT+BJyGbHdVUasjqfNvMbRcC1X/+psScpO9ct3IC//K6YIs9e4DtOWS7ma6eRZNInX+HNYSXWARqHAq3GAI85nGAkd8Zk2pAxwxFNbTP7rujZTdapWayLMkEAWoRmZ2dGkE24Yh3s0OjzrvJqCSgKOwsAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uofcC+T5RSKkCKwhEjVq7RO/Ksk+fOjx/jhDBJUjNU=;
 b=Se1UVfgfPxPSr94UtB+7MfzNgIBEQaa5WJyW3ledtZICEra8wxxQpJeKLqMqt3aCp37e+2pU4djfVbBL9mpb1ESoL+Ft48TpWmDqB9j/ADsFYTYNlMw/4pWXTIuOLsurGLkKHsMNwEbMG4MVP71ecoxiixM6pokn+zs8PRQrzAKRfjenj3R7wr1DNhF4UctsERW3JtPsV22bYB/38EFGvu8h1WgtJuvRQMjV9ldpE84I4JzPQ2q9vy4NDZTvntq0kZyMFajHJJIr8xu7EVyaUQAYzXrQQEZGKT3wdr3fKlCvimqiiw6eiTUeZz0eMMa9eS0ahZSGfJQdctTuI6qKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Thread-Topic: [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Thread-Index: AQHWZMv5Xnt/t1KFrUS7u3Ziwa4uF6kddQCAgACezMA=
Date: Wed, 29 Jul 2020 06:11:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29832471AA67B88DCAE5F92F92700@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
 <20200728204015.GA1012@bug>
In-Reply-To: <20200728204015.GA1012@bug>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cd6a044-d2de-483d-e3a3-08d833863998
x-ms-traffictypediagnostic: OSBPR01MB4005:
x-microsoft-antispam-prvs: <OSBPR01MB4005AFC280BD2F6342514C4692700@OSBPR01MB4005.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9OYtJpG1aYXPBidqK4RPQlkVtoExs07f4VoWU5rKr8SWQ+xe3GeEbiPjOr7RAo9Pzvp4cbv0dqrxtGsvtbGVWMEbuhSm556IQchtLaLGE0/YyAic3F6lhJRkSO3usmuDXNO+Cmc+aSW6t9TvGn2yp/k/KjBY0hBpHzLWx4wZTcnOq9UK98A4dyLEy8rimPHjRgDD3QsfDumvaFKltF1eL68yU31jgY/XcxH5su7p/CLMBhBzEOCYEV2O1UF4FTpVMGSBzCJIJLz7KqzsPfdLXTbVYt0qFE2RlDldKyZkjjjxwt8EQQTf1P83fFn6cWHxnNdeWaDUswKNFMMROH4FSQ==
x-ms-exchange-antispam-messagedata: m7OJqrV1mlNBLy2/Gg4diOZ1ZEYSNvw63qLPkesP4rjDtAUexsM75bfXQcV/dPz8Mc2xs74aahfbgRuadpM8Ylvls40FeAETTGNSVFXjNtQ7/+WTTxt08Kd+S5TBuSdG8JkhIjLaRZPctbWQsla7wkmfuEWmD0N/5kDSjdQbvGQ8DQvWouazEPJrwvwAwclgK0FVmBW4DNA0HvcW+AqYU4DyRjJZrknaPYwqGLnHa7AShvxUYRWOpLQxP3/JF+Lc2pgQzAKvwGNNpk+7HWIoreSUfAz8K2R38tCqKjAo5+axnxdRIgIjj7Dcdqvn3Kg54JxhiXq+PZo6r9M9r0xqfwkN08WxwXOrKPoTcfj0YyNunvhoT8qTRPjxn0vh1T/y/YlpkHDd+SvPz0aVf8jalZVRzhmB+C7HArU3VjR6Q9ksuwYfP0pt4wSERyuCzFtEp1JJ45dq5dvKsQqc4G45rz7hIixSe3do9KjcBb/ks4k=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd6a044-d2de-483d-e3a3-08d833863998
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 06:11:25.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeqVI+IohhzV5PLsZr9xChMMQRu35H8eMmzlRowje0eTrtwQznuE4Z/yDhI5x28M9j9DkysFNiNCRb379XgGCC2iXvJbmElDQ0P0NcQL2OUQCiylkp3wTN3tE4u0zDv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4005
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m0rRBciqc1wSZOuXcLebr029x4520388AA=
Content-Type: multipart/mixed; boundary="9yseCkdgOO0jMmXp65nt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596003107;
 bh=jl2LXrAnwV2lE5HgqKvprRxkPyxvd80zH8PnEMoOSOc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=HqmnrY4Gfgt1IbiSltqoLl1kVc7ifwaMdzfs0h7ZVD4/tyVDLUz3vvU5mNy/76soa/q
 Jn3dl+h2OKbPQCJJ7oYgAyqxsOO1ygDBpyB1zpwXJvdGZagbnJcS6stGRwRSUvJ+AHKyt
 5Pcbiiw+yvk+YN9JHRaZ7Z8efVLMIbT1TOU=

--9yseCkdgOO0jMmXp65nt
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyOSwg
MjAyMCA1OjQwIEFNDQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o
5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdh
bWF0c3VAdG9zaGliYS5jby5qcD47IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRlcnNvbjJAcmVu
ZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxh
ZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LjQueS1jaXAgMC85
XSBBZGQgTENEIFBhbmVsIHN1cHBvcnQgZm9yIFJaL0cxRSBib2FyZA0KPiANCj4gSGkhDQo+IA0K
PiA+IEFkZCBMQ0QgUGFuZWwgc3VwcG9ydCBmb3IgaVdhdmUgUlovRzFFIGJvYXJkIGJhc2VkIG9u
IHI4YTc3NDUgU29DLg0KPiA+DQo+ID4gQmFja3BvcnRpbmcgdGhlIHBhbmVsIHBhdGNoIGFzIGl0
IGlzLCByZXF1aXJlcyBkcm0gYnJpZGdlIEFwaSBjaGFuZ2VzLA0KPiA+IHdoaWNoIGlzIG5vdCBw
cmVzZW50IGF0IDQuNCBrZXJuZWwuIFNvIHVzZWQgdGhlIDQuNCBybSBmcmFtZXdvcmsgdG8gYXR0
YWNoDQo+ID4gdGhlIHNpbXBsZSBwYW5lbCBkcml2ZXIgd2l0aCByZ2IgY29ubmVjdG9yIGRyaXZl
ci4gVGhlIHJnYiBjb25uZWN0b3IgaXMNCj4gPiBiYXNlZCBvbiB0aGUgd29ya2RvbmUgZm9yIHRo
ZSBsdmRzIGNvbm5lY3Rvci4gVGhlIGRpc3BsYXkgcGFuZWwgYmluZGluZw0KPiA+IHBhdGNoIGlz
IGJhY2twb3J0ZWQgdG8gNC40IGtlcm5lbCxzaW5jZSB0aGUgbWFpbmxpbmUgdXNlcyB5YW1sIGZp
bGUgYW5kDQo+ID4gaXQgY29uZmxpY3Qgd2l0aCBjb3JyZXNwb25kaW5nIC50eHQgaW4gNC40IGtl
cm5lbC4NCj4gPg0KPiA+IE90aGVyIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgYXJlIGNoZXJyeSBw
aWNrZWQgZnJvbSBtYWlubGluZS4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHdyb25nIHdp
dGggdGhpcywgc28gSSdsbCB0ZXN0L2FwcGx5IGl0IGlmIG5vb25lIG9iamVjdHMuDQo+IA0KDQpJ
IGRpZG4ndCBzZWUgYW55IGlzc2V1ZSB0aGlzIHBhdGNoZSBzZXJpZXMuDQpUaGUgQ0kgdGVzdCBp
cyBmaW5lLCBzbyBJIGNvbW1pdC4NCg0KPiBJIGd1ZXNzIHdlIGNvdWxkIGxpa2UgcGF0Y2hlcyBm
b3IgY2lwLWtlcm5lbC1jb25maWcgcmVwb3NpdG9yeSB0byBhY3R1YWxseSBlbmFibGUgdGhpcyBp
bg0KPiBvdXIgdGVzdGluZy4uLg0KDQorMS4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAJCQkJ
CQkJCQlQYXZlbA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--9yseCkdgOO0jMmXp65nt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5043): https://lists.cip-project.org/g/cip-dev/message=
/5043
Mute This Topic: https://lists.cip-project.org/mt/75842037/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9yseCkdgOO0jMmXp65nt--
