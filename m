Return-Path: <SRS0=nOag=BN=lists.cip-project.org=bounce+64572+5084+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0DFC433E0
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 23:12:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5D520781
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 23:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="X4IFZLJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5084+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uTB7YY4521723xTBLEK2xZDp; Mon, 03 Aug 2020 16:12:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.8342.1596496370702132004
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 16:12:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 073NCdbw020675; Tue, 4 Aug 2020 08:12:39 +0900
X-Iguazu-Qid: 2wGr7dZaRScEjhDKMq
X-Iguazu-QSIG: v=2; s=0; t=1596496359; q=2wGr7dZaRScEjhDKMq; m=m6paHnE8PzgYuM6KhOnSIWXqDJK3M+AKU8sz/QNkuCA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 073NCcvV019290;
	Tue, 4 Aug 2020 08:12:38 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 073NCbbO000434;
	Tue, 4 Aug 2020 08:12:37 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 073NCbg5018007;
	Tue, 4 Aug 2020 08:12:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZgGXKNUVjI1+DBDxgbRLVDN8Vlbjxnu853UDfqF+OPntx9UDuT7787TKFx9xY/Q9xPJBjnIo5kk/RT9kZHwslHTeWlHjNUL8RgZKAaL2f7q+i8414779MW0CzRDXexCLxt7WyhurukLg06Z4NjFCyHjLE+FGrAS26924meLKnfqLcvRoLMM2gO/pUbyg9TTPml8JniTPX6mfYuyMaK2VldYpkxXuvaIzzAjK7kYu8IloBwwEshr/ha2Sy7fL/QG1BQGzYPg1v4T+RN+Q7OOVXHjXRSbRI3NQObRwzYPunqGcyxPSrk8mls088whlR4adeRNMCi/4wX3H5drYtRY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSnlf6jN0e7frH7loPLe1fUDBOvfjuV8z33uh+DQQls=;
 b=k3eEozioghx8CJwBOlt0I2WV3LwXUdDIerAesne87oK9xUBLZHRlzq1zhBdE0t/cnI/QmR3s2dQ2dcOKisB6C+tcmVoJ6CGPLGAcrNvOrpmjzplzaeTi6ebspc5/lzBTbOtoxovHDXkEZ84EtYV8zfRyw3fjlmVdDa/yt2/3BHkz0z4ZxB/2MIPlaGtDY7ONVeY5gXTEBflEG7v15eUi2FcdGmvVzG+5EH2oFDeViJHru1/Ow22KrZbOZ4F/dyFjflq1L98RLbqRMqsI//8K9bnMuZy7oACULU8PkPa6dNL2yy4AaaxZG6jqvd2eTnhy7c1xvxsU58V6fDhjBwCIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: of: Fix double-free bug
Thread-Topic: [PATCH 4.19.y-cip] drm: of: Fix double-free bug
Thread-Index: AQHWaYdSqQL+gwkxGUq/TmKngf1Wvakm3jQAgAAkecA=
Date: Mon, 3 Aug 2020 23:12:35 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29839AA74ED88985B18C61CF924D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200803111441.3157-1-biju.das.jz@bp.renesas.com>
 <20200803205700.GA16969@amd>
In-Reply-To: <20200803205700.GA16969@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44dd8d4e-3b43-427e-055a-08d83802b526
x-ms-traffictypediagnostic: OSYPR01MB5400:
x-microsoft-antispam-prvs: <OSYPR01MB54002825BCE2A867CC68E467924D0@OSYPR01MB5400.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X1lHthMbh93UMGyQDOrRWpR3c5XJI/UoUiQMwXooXmkkATMN0MzcChb7uEPAsDUfJCxijQuGFP2JTmhuOXHcEgssu/LtutluWyuzokwJmItMZzKB/TGYYawGmAELxA15KthYjgygiwiEvAZWjUpvEa1FxKzDHMcTYjl72TCvgsnAl2IqoM76OBm6++JeWp7hMBpTPSbPA3/NvApIkFUTUkqMzycjG76Cs6/y7M8/ZxQwEzAfyKERD1AXh7EggFtGPY+fLhw34bhcjV4MPpT8GS0wGbpFwF82h4G5D8Ql7Q+S/FmDbegDabZN8icllkEN
x-ms-exchange-antispam-messagedata: KTZnh9v+ih8eMyo0fVkeLm7gabRGft4jQvOx6S+VDpQXdM4Chqzk2LGlU2NmZ4uWah2YxCYmd6bOSfpAfjIKjYsIPVmC4Snv7fLgcbSQ5C5qqTpj1Ebh8mdXkZdsm7OCectEegC92rb/rgJWzfJAiSyRv91ClWWn1mWYpTduPZDXiwjN7LyIBGz6engT5PzSARav4tKw+QHQLeOunlaCwb+NjnecdZW5+HPBDAXEPQtXocO/DvPBKJSiIBuELLc2jFfdJrg4pEszJWNPf4L41YRFQBOoxCH9iIlCPmabVtdzYOa2UoNP7R9YKxLkHkbvLK46X18ZVfuhoK01FKa8DlgRvNMvfiIKrC6Odvpe5d+rbV3x6F41xIVAHGj1HlUpUnub7vGwzu0rMdPyNfuOj79MaHDPZXHPnRua0T9WMyPNQmMLSbg4AYqmntuDzuX7HDEJH89pC/OCfeH4pg/q3u639MqtTaySq2Net8+414Wagk8PQCFLcEg5tWBn9B1KraoR9ZxwjqRBvi3jQAjrK3lMDPlC8F0ieBandwawLORrqjopamDNvFXCt2iSvfZoU7HiTIBnT+UyEjSgT8pEkBwftVbWg9NXC28cL6smNCMMHuP1L6JOABTfukeJ936gajPtbB1pFxxvfuOAsPL+kw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dd8d4e-3b43-427e-055a-08d83802b526
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 23:12:35.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhC6pLuhbFt90hmZcSPdDspv1R1cdw19gY23pgqnoCXe0tXK7FaFPYYDDk0PJgfuCXKD4SyF8X6jkZkUir8XTf2BcJdzieKZM3My7X+P60aAQee4AImyjAjjbtQFqTfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5400
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2Oi7hSBtNGn7IvXlzm07d1NYx4520388AA=
Content-Type: multipart/mixed; boundary="lR4rrVLm4OLYABzxrOEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596496373;
 bh=r0FNK8tP3gbK8/XVTYCM7ES964MULX7MgnWWOsnLKZM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=X4IFZLJOpCx20ckEpjfQishzj86oqm6njIvcF9wSztVXaNrxQfuXOaEhjKKaJPgeEm7
 kfHqiMoNclXa75fW3IiPxBibhiX2mRxSGLkvAJSNDsXcmuIOqEz9bKb0fbDJNxTz1G61V
 upUAcO3/ZFf0F/5CSjSG+b4XTDgeoRdad4c=

--lR4rrVLm4OLYABzxrOEM
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDQsIDIwMjAg
NTo1NyBBTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBD
YzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqead
viDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBDaHJpcyBQYXRl
cnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPjsNCj4gUHJhYmhha2FyIE1haGFkZXYg
TGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggNC4xOS55LWNpcF0gZHJtOiBvZjogRml4IGRvdWJsZS1mcmVlIGJ1Zw0KPiAN
Cj4gSGkhDQo+IA0KPiA+IGNvbW1pdCA0ZWU0OGNjNTU4NmJmNTE5ZGYxOTg5NDI3MzAwMmFhOGVm
N2I3MGFkIHVwc3RyZWFtLg0KPiA+DQo+ID4gRml4IGRvdWJsZS1mcmVlIGJ1ZyBpbiB0aGUgZXJy
b3IgcGF0aC4NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuIEkgY2FuIGFwcGx5IGl0IGlmIHRoZXJl
IGFyZSBubyBvdGhlciBjb21tZW50cy4NCj4gDQoNCkkgYWxzbyB0aGluayB0aGF0IGl0J3Mgbm90
IHBhcnRpY3VsYXJseSBhIGlzc3VlLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gCQkJCQkJCQlQYXZl
bA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBF
bmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+
IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVu
emVsbCwgR2VybWFueQ0K

--lR4rrVLm4OLYABzxrOEM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5084): https://lists.cip-project.org/g/cip-dev/message=
/5084
Mute This Topic: https://lists.cip-project.org/mt/75963411/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lR4rrVLm4OLYABzxrOEM--
