Return-Path: <SRS0=EUw3=EK=lists.cip-project.org=bounce+64572+5733+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C344CC2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 02:32:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0786C22264
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 02:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="d/yLvPes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0786C22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5733+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id F4sqYY4521723xwzgqxffdGK; Tue, 03 Nov 2020 18:32:10 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.7685.1604457128802144463
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 18:32:10 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0A42W0OM019523; Wed, 4 Nov 2020 11:32:01 +0900
X-Iguazu-Qid: 2wHHadmXNmt1z1JxAJ
X-Iguazu-QSIG: v=2; s=0; t=1604457120; q=2wHHadmXNmt1z1JxAJ; m=rEW1vRzi3DFIlPpYcdsQq3a3op10S0oBi42bHjj29ZI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 0A42Vxii033940;
	Wed, 4 Nov 2020 11:31:59 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0A42Vxwu008272;
	Wed, 4 Nov 2020 11:31:59 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0A42VwjK028996;
	Wed, 4 Nov 2020 11:31:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdQQHUc3vGROGfnyccmjkRZWb7W6fkoEFBndsWJvXEBl3LyPIyuzpeflMopNASiSL0zcDDkgIEBEnKvPR1xRIgnln/P5Wf6xpRymtD0+MMXSBcCw915nBHBUYzYnKmb6mb6PCpAnWmRLUzDshBWqyIqA/nymtLlOkxtJEfPNdPE6p7dQe16CbBn2jcknJW+xgBBiscfjOQ1M7nSAqTYLo5CXr8VCFR4LYR0w7EapPefqkpsVqQnPCvS3zAmkxR3kGBkNladDpENDr9sxCZCecO1dQAqEHKKZYFNm6VOq4qWJnc60hOWsrWckeEnzah2FRIaQ5Hi42lOPwdB01Q6oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHvYt5I9jZl3HPzOKq2Qekol088Zkd2zKx79YjfmVHQ=;
 b=ns2jIePKZAeg1CPQYT4/p4YVkGfI56zLDY3PNZoaZcNzCAcS3bIE1bL6Bg+VGLwYavYfGqwyKXio60Bc4MQus7ZDZJk0BDUXGWTBrEG55OQbgFWhSrOOFMycwoScwhOq1E9TTvF68dQ6R5uvLKzgI+qc1Lh9T3VqzcXK1ecZx2mvRvRLmT3vw8Mw//EFgfS/HeabTgFxP8Av8auOebvJaiLYa1hM/3QDw5iTthApJqEBwDe8yU78hjsEDmY2KjpPS8zTuE7YYbP1HL4Gszmm+Cf2eOqD0xZUaEl44o9q0WKNUL/CipOmZlIA6h6fWPBLkQERiX0S5s38a1J6ElJO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Thread-Topic: [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1,
 DU, HDMI, LVDS, PWM and sound support
Thread-Index: AQHWsgd//I5iIs3v20mmEg7J7HgJK6m3P6TA
Date: Wed, 4 Nov 2020 02:31:56 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5575827-bdac-4964-a1d9-08d88069ccf3
x-ms-traffictypediagnostic: OS0PR01MB5300:
x-microsoft-antispam-prvs: <OS0PR01MB5300A2A8758457D9B14F587092EF0@OS0PR01MB5300.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7hJreZvL1crT+PGo2KObwQ7MQIPykuY15NSc58Tc4VOCBOE10MyA268FnL3J13aJYAd6JL9B3cX8vtwIFP+YK/x2OwqDqN7vVrIapO0aJEkflP7Asq2RLhhmy15BwYUNKS5XySHOjYdgAwjquY2si/M8xbV1UE7BzAugsCBCpWC408qGn+l3Tw4lGTNNUEbby0V0O4QI8QGPQrMYoJlF+ngJ7T+SfmpZa4E/tJD+ambmvZENOQX/lzX1hSF/M8aL2N+umtevG71NZLQusDvsUspdGVRty28JzvbTW8zt+TrVbXyg+nDD35jLxG38HkvKJGEGxCBnqM/WRdXmTKUMhw==
x-ms-exchange-antispam-messagedata: 7zPjzybO0Bc7XamWdGa9leQx4Mvpnkey/cS6e+YYwIPbNW0Yky/0Sel3Xs4tnOOfdyqB/nX0SlllnKKGsMhxQB2/kloIthK2921/aDfEGgwqORr0gc/bJBYMgIeBhU9p9VskuEg6aO799sYtZcz2CWk5o75Gq2XdK312ly4j41Ik61CR2k3yJ+B9cR4hBDiSibTI5zqnno5CUpj0r9D80Y/VV5/XFdI8sgWgH3X7MP2ELOHUbBUGwFwQuDIGMq+TV5yTG6bwyQPKCbbTOJONoGc3OBQMguREB7wTbIhFT6jioarSF08u7Pt8SScATjHGhobS3E8rnF2mpteBxkaqf5Dg98CCW4BG8mrqv05VPTyq7wMmqW4u78opy/iA/X+kkExyAo8TlENQ8D/Fy2s8drgKSfySOjMF6qFYc5/3hTmSDoPIeFWH0Dyc6Aw3BhdhD9iP4heZCCfJzBIT2hx66gm8lUSEA2oibPkUqbU01DqlXu3o3cdDS1llR91zJeOP3b5r+fFTePrWP9pzSVG/pI4EKpHBH8DSGAT49DaMoB6Dl7rv9ym1oNjD/AtDRMXX0KQdDAGxPhNLpa3VjPmjqEVm+ZI7XZXKi+bMrrFh6DtAeVp6bsWD+z5VeDwxiZHxliEAgYqMqAJpjjzYCVJkdQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5575827-bdac-4964-a1d9-08d88069ccf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 02:31:57.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTQ/CCb6g9HxX8Z2MRe5BhCseIhU0UZTPz7AKT7HuezlPyobAlJMNPDcJplIUKiTQxZcEz2D7nWwSNcqPeLjULx+N1E903nVIpoqD0rSCQrAF/NqpnWvthfziK4BffYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5300
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mJCp22Qt5IxJn4Aozz10JCowx4520388AA=
Content-Type: multipart/mixed; boundary="UDeC2bhaDUk1EoxQ2hYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604457130;
 bh=7c0RSjI/T5OBFuwvTF4340COBOg510FZWe2AAhiFB/c=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=d/yLvPesa7iYV5ZyyIYRN0BOQ7/drcXGu82W5gacaTS7xxSC/0CzkbRWRItX+nkRszJ
 blWGYPder+WozkMG0mSRWJdR4MF8/0avhwmnPWlTFST9o9ABhsvIntNsbtNQnm5f1w5Pa
 xduf2z/SOH4Sgu3Vtm/KwkYy8T27TyOq1vo=

--UDeC2bhaDUk1EoxQ2hYy
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciA0LCAyMDIwIDI6MzMgQU0NCj4gVG86IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8
s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
PjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiBDYzogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggNC4xOS55LWNpcCAwMC8xN10g
UmVuZXNhcyBSWi9HMkggYWRkIEZDUHtGVn0sIFZTUCwgRkRQMSwgRFUsIEhETUksIExWRFMsIFBX
TSBhbmQgc291bmQgc3VwcG9ydA0KPiANCj4gSGkgQWxsLA0KPiANCj4gVGhpcyBwYXRjaCBzZXJp
ZXMgYWRkcyBzdXBwb3J0IGZvciBmb2xsb3dpbmcgcGVyaXBoZXJhbCB0byBSZW5lc2FzDQo+IFJa
L0cySCwNCj4gKiBGQ1BGLCBGQ1BWDQo+ICogRkRQMQ0KPiAqIFBXTQ0KPiAqIERVLCBIRE1JLCBM
VkRTDQo+ICogU291bmQNCj4gDQo+IEFsbCB0aGUgcGF0Y2hlcyBoYXZlIGJlZW4gY2hlcnJ5IHBp
Y2tlZCBmcm9tIExpbnV4IGtlcm5lbCB2NS4xMC1yYzIuDQo+IA0KPiBDaGVlcnMsDQo+IFByYWJo
YWthcg0KPiANCj4gTGFkIFByYWJoYWthciAoNCk6DQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczog
cjhhNzc0ZTEtaGlob3BlLXJ6ZzJoOiBTZXR1cCBEVSBjbG9ja3MNCj4gICBhcm02NDogZHRzOiBy
ZW5lc2FzOiBBZGQgSGlIb3BlIFJaL0cySCBib2FyZCB3aXRoIGlkay0xMTEwd3IgZGlzcGxheQ0K
PiAgIGR0LWJpbmRpbmdzOiBzb3VuZDogcmVuZXNhcywgcnNuZDogRG9jdW1lbnQgcjhhNzc0ZTEg
YmluZGluZ3MNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTogQWRkIGF1ZGlvIHN1
cHBvcnQNCj4gDQo+IE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1ICgxMyk6DQo+ICAgYXJtNjQ6IGR0
czogcmVuZXNhczogcjhhNzc0ZTE6IEFkZCBGQ1BGIGFuZCBGQ1BWIGluc3RhbmNlcw0KPiAgIGFy
bTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGUxOiBBZGQgVlNQIGluc3RhbmNlcw0KPiAgIGFybTY0
OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGUxOiBBZGQgRkRQMSBkZXZpY2Ugbm9kZXMNCj4gICBkdC1i
aW5kaW5nczogZGlzcGxheTogcmVuZXNhcyxkdTogRG9jdW1lbnQgcjhhNzc0ZTEgYmluZGluZ3MN
Cj4gICBkcm06IHJjYXItZHU6IEFkZCBzdXBwb3J0IGZvciBSOEE3NzRFMSBTb0MNCj4gICBhcm02
NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTogUG9wdWxhdGUgRFUgZGV2aWNlIG5vZGUNCj4gICBk
dC1iaW5kaW5nczogZGlzcGxheTogcmVuZXNhcyxkdy1oZG1pOiBBZGQgcjhhNzc0ZTEgc3VwcG9y
dA0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGUxOiBQb3B1bGF0ZSBIRE1JIGVuY29k
ZXIgbm9kZQ0KPiAgIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiByZW5lc2FzLGx2ZHM6IERvY3VtZW50
IHI4YTc3NGUxIGJpbmRpbmdzDQo+ICAgZHJtOiByY2FyLWR1OiBsdmRzOiBBZGQgc3VwcG9ydCBm
b3IgUjhBNzc0RTEgU29DDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0ZTE6IEFkZCBM
VkRTIGRldmljZSBub2RlDQo+ICAgZHQtYmluZGluZ3M6IHB3bTogcmVuZXNhcyxwd20tcmNhcjog
QWRkIHI4YTc3NGUxIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTog
QWRkIFBXTSBkZXZpY2Ugbm9kZXMNCj4gDQo+ICAuLi4vZGlzcGxheS9icmlkZ2UvcmVuZXNhcyxk
dy1oZG1pLnR4dCAgICAgICAgfCAgIDEgKw0KPiAgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdl
L3JlbmVzYXMsbHZkcy50eHQgIHwgICAxICsNCj4gIC4uLi9iaW5kaW5ncy9kaXNwbGF5L3JlbmVz
YXMsZHUudHh0ICAgICAgICAgICB8ICAgMiArDQo+ICAuLi4vYmluZGluZ3MvcHdtL3JlbmVzYXMs
cHdtLXJjYXIudHh0ICAgICAgICAgfCAgIDEgKw0KPiAgLi4uL2JpbmRpbmdzL3NvdW5kL3JlbmVz
YXMscnNuZC50eHQgICAgICAgICAgIHwgICAxICsNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVu
ZXNhcy9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+ICAuLi4vcjhhNzc0ZTEtaGlob3BlLXJ6
ZzJoLWV4LWlkay0xMTEwd3IuZHRzICAgfCAgMTUgKw0KPiAgLi4uL2R0cy9yZW5lc2FzL3I4YTc3
NGUxLWhpaG9wZS1yemcyaC5kdHMgICAgIHwgIDExICsNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
cmVuZXNhcy9yOGE3NzRlMS5kdHNpICAgICB8IDc1MSArKysrKysrKysrKysrKysrKy0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZHJ2LmMgICAgICAgICB8ICAzMCArDQo+ICBk
cml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2x2ZHMuYyAgICAgICAgICAgfCAgIDEgKw0KPiAg
MTEgZmlsZXMgY2hhbmdlZCwgODA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGUxLWhp
aG9wZS1yemcyaC1leC1pZGstMTExMHdyLmR0cw0KPiANCg0KSSByZXZpZXdlZCB0aGlzIHBhdGNo
IHNlcmllcy4gSSBjb21tZW50ZWQgdG8gMTcvMTcuDQpJIGRvbid0IHRoaW5rIHRoaXMgaXNzdWUg
d2lsbCBhZmZlY3Qgb3VyIHJlZmVyZW5jZSBib2FyZCwgYnV0IGl0IHNob3VsZCBiZSBmaXhlZC4N
Cg0KQW5kIGxvb2tzIGdvb2QgdG8gbWUgd2l0aG91dCAxNy8xNy4gDQoNCkJlc3QgcmVnYXJkcywN
CiAgTm9idWhpcm8NCg0KPiAtLQ0KPiAyLjE3LjENCg0K

--UDeC2bhaDUk1EoxQ2hYy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5733): https://lists.cip-project.org/g/cip-dev/message=
/5733
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UDeC2bhaDUk1EoxQ2hYy--
