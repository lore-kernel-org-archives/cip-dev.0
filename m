Return-Path: <SRS0=tGxh=BJ=lists.cip-project.org=bounce+64572+5056+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B2BC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:56:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429732083E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w71jSvtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429732083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5056+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QV7jYY4521723x2xIjEa19rD; Wed, 29 Jul 2020 18:56:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.5648.1596074191166547070
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 18:56:32 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 06U1uTKn023403; Thu, 30 Jul 2020 10:56:29 +0900
X-Iguazu-Qid: 34trpDa8NpCTvE7UJc
X-Iguazu-QSIG: v=2; s=0; t=1596074189; q=34trpDa8NpCTvE7UJc; m=8as/3XYfi4J46NvStM7+0w5vU/5FWKOxZvlc7Vk3u3g=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 06U1uSBK018318;
	Thu, 30 Jul 2020 10:56:28 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06U1uSJL021635;
	Thu, 30 Jul 2020 10:56:28 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06U1uRMs030824;
	Thu, 30 Jul 2020 10:56:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me16Bk08HwGZIckzTIeT+5vjt1ybxl8L955nhqofIdZc6tiP26IMugpnGh3/KtfkxmGM54++OUwO/uEupYU8MWOF58FVMRtTelLnYJCbCsEFTjtCrqV6IqncOQhHBJfD4MVoQ0uTO5zJiODrVcCmtSL/OZEcIPSu4JuzSU+r1IfX5MpxL8LEKsqE0KjzODsjK7aS+eDClR7DIJo/tuNPzsB0ZSyVXBeD83WZygc0netNZM42aymo2uqkwHra28wSnfe5bbv2AeZuAYTgjU8tjpjUI9ZjVdSwSs691PGdIlVer5dPSQeqw9DFoluUjgh2J1huBfJZ6SIq1/9rPEGPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTd5yjYRTBpGsGFx6HDhHztRz9siK2zbkHJW/m9YAyM=;
 b=almR1luPU4uB1Kf2+mk2kSLaTu/jn9wDYjT0UyXvXtdj+RVNq2AEiKYjX9UljJutDjheBys17TwIB0vmtBao5WAHbh1xDWfXb8JpZ/iPC4PUfRiXaaxA57T1wEMRvKki6Dg5YTUpw9IQP5EzXxTBwgliebHF0ebC+ZMHWu6sVeyMPpax8qCecQPqNQr/8H914Bd3TpqGZ2nm0NoEuYPFDRfUWz5Lwujz5196/brqSyVcnxf1Q8jNvTA+Vu7QrnnRCMiTBwqDw9zlezSwWcduaznzgUHjSkCY9KYkFnLM16VXDn8yBAlp2skuoeVLE5jmP3xSddtETXl9qGaOiBIFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
CC: <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core PATCH v3 1/6] kernel: add fat for qemu-amd64
Thread-Topic: [cip-dev] [isar-cip-core PATCH v3 1/6] kernel: add fat for
 qemu-amd64
Thread-Index: AQHWYct2tnLUt157KEaRMKURRENNMqkezEwAgACZZXA=
Date: Thu, 30 Jul 2020 01:56:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053F9F66FFC144E397B6A25D0710@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200629125400.13968-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-1-Quirin.Gylstorff@siemens.com>
 <20200724150147.8253-2-Quirin.Gylstorff@siemens.com>
 <abdbf160-34d1-0d84-f218-2efaaf9dd355@siemens.com>
In-Reply-To: <abdbf160-34d1-0d84-f218-2efaaf9dd355@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 521fe71c-1b39-41ba-8879-08d8342bc487
x-ms-traffictypediagnostic: OSBPR01MB3255:
x-microsoft-antispam-prvs: <OSBPR01MB3255948FC446159228BA5EE8D0710@OSBPR01MB3255.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pDxFhy/Fv62y4uNTa3ae5vTCKakIcaOzG84Ro/COwSguZOPxXzVWhBlrvoTwACscyUwcz0XHBrWyA/ntAI3Yi5cVPhGbbIi42026KQ6Bzu4ACf3sNmelwSqUK6iK4K4HSMjfPf/FC8T4x5hcYoIwjXqSX4UFkZVKWs+IglnwA+jZUawK8Ev3UjZ3eVMnGJ5zJ6LI67a1ThG2J106GUHdxl9CsXok2lKoUXoLvQuQiUT9kKDpVYABEiNM7xi9VBuyuuQQpuBHK6j1moK/SgTBfjCxUTeJU0uS9SyGt6gzu4hV7+rHcFWTkN9o8y6k8inHOtYtOmGyN/8w3ciOIw0wzA==
x-ms-exchange-antispam-messagedata: 1/f/hOzaoIJKpPhoobSSns620XhoEYYGs73LFS4FSu1x5/cMV8CjUp+TSyYDDfkSNX/jvzYHrxLX2MrD241iwwumDgENgEyikTDXRH8lY6AsTToOu3TCd4Bx+yqSkWlnPKpAswYQtq55iJDj365NLGBpst/7Ku6vhPmuH0u4erlHSEyF7x316FFRA1CZiH37MSfrGcN26O1JoNHeFcEfXhKs6HUHiPMGQA00W5vgMIKKMVZP1OxKZMPtiFniJFtrJ7MsGwI/Kfe2y/kMC/LxcYuKYqoOBR1Kzqt59DxBhUa5g6OsOqI5bHc6uI6tYcPMXPmaYpd0bbNmDXPtbKjFAswz2l4+lANHi3RPJQCJEcSFcnXfMwB39jdm0LLGtYIeiIvXo7i9elMM/hbLDkCbABM/y71UOzXF6zsvSqWi6eMy2NsS63SzHRTfJvuHAGEV2czdctVBNxQuxtDnZDnPCc2dpS5Smtw/eSp5R3b8zKY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521fe71c-1b39-41ba-8879-08d8342bc487
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 01:56:25.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKRs6JgAUWxmteLi6qurdM4kUWa0smEckAmXeOvsR9KhulXpPQ8vpi4woJNUxDB4gnzTSczvBDRXZj2Z/NzRTF8IJXNaMo6UBgUJFw3ALvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3255
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: myMpwzcOkaLivFZ5vZfjOQJfx4520388AA=
Content-Type: multipart/mixed; boundary="mKx6Z6KYnzyx1VfMr4sU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596074195;
 bh=Sxiohjiz634bTh0Tl32f8iRMxtfNf4jlt0MrGOv5b0w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=w71jSvtBME15u/3bv1VVdsJB0ZWY3pnKGB912B729tcJEW5Wvs/NhAHSd3UT6ocrUMM
 wKJ26xn+K84uSWPKooHDYJ7UJ/qwJFnclBw0QzpqgvDCVm6sQwWpB+7I2fyRQA669qTwx
 iaghZLiMRUUzeM+XzdK+j2Y88L3rWW1udFA=

--mKx6Z6KYnzyx1VfMr4sU
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBK
YW4gS2lzemthDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDMwLCAyMDIwIDE6NDcgQU0NCj4gVG86
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4u
Z3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNp
cC1jb3JlIFBBVENIIHYzIDEvNl0ga2VybmVsOiBhZGQgZmF0IGZvciBxZW11LWFtZDY0DQo+IA0K
PiBPbiAyNC4wNy4yMCAxNzowMSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBR
dWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+DQo+ID4g
QWRkIGEgZmF0IGNvbmZpZ3VyYXRpb24gdG8gYWNjZXNzIEZBVCBQYXJ0aXRpb25zIG9uIHRoZSBx
ZW11LWFtZDY0DQo+ID4gdGFyZ2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5
bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHJl
Y2lwZXMta2VybmVsL2xpbnV4L2ZpbGVzL3FlbXUtYW1kNjRfZGVmY29uZmlnIHwgNiArKysrKysN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9maWxlcy9xZW11LWFtZDY0X2RlZmNvbmZpZw0KPiA+
IGIvcmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvcWVtdS1hbWQ2NF9kZWZjb25maWcNCj4gPiBp
bmRleCA3NDg3MTUyLi41NDQ5MzE3IDEwMDY0NA0KPiA+IC0tLSBhL3JlY2lwZXMta2VybmVsL2xp
bnV4L2ZpbGVzL3FlbXUtYW1kNjRfZGVmY29uZmlnDQo+ID4gKysrIGIvcmVjaXBlcy1rZXJuZWwv
bGludXgvZmlsZXMvcWVtdS1hbWQ2NF9kZWZjb25maWcNCj4gPiBAQCAtMzUxLDMgKzM1MSw5IEBA
IENPTkZJR19DUllQVE9fREVWX0NDUD15DQo+ID4gICAjIENPTkZJR19YWl9ERUNfQVJNIGlzIG5v
dCBzZXQNCj4gPiAgICMgQ09ORklHX1haX0RFQ19BUk1USFVNQiBpcyBub3Qgc2V0DQo+ID4gICAj
IENPTkZJR19YWl9ERUNfU1BBUkMgaXMgbm90IHNldA0KPiA+ICtDT05GSUdfTVNET1NfRlM9eQ0K
PiA+ICtDT05GSUdfVkZBVF9GUz15DQo+ID4gK0NPTkZJR19OTFNfQVNDSUk9eQ0KPiA+ICtDT05G
SUdfTkxTX0NPREVQQUdFXzQzNz15DQo+ID4gK0NPTkZJR19OTFNfSVNPODg1OV8xPXkNCj4gPiAr
Q09ORklHX05MU19VVEY4PXkNCj4gPg0KPiANCj4gVGFraW5nIHRoYXQgZm9yIG5vdywgYnV0IHdl
IHNob3VsZCBxdWlja2x5IG1vdmUgdGhhdCBkZWZjb25maWcgaW50byBjaXAta2VybmVsLWNvbmZp
Zy4gSSdtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGFueXRoaW5nIGZvciBxZW11IGFscmVhZHkuDQo+
IENvdWxkIHlvdSBjaGVjayBhbiBwcm9wb3NlIG91ciBkZWZjb25maWcgZm9yIGl0Pw0KDQpJIGNv
bmZpcm1lZCB0aGF0IGNpcC1rZXJuZWwtY29uZmlnJ3MgcWVtdSBjb25maWcgYm9vdHMgY29ycmVj
dGx5IHdpdGggaXNhci1jaXAtY29yZSdzIHN0YXJ0X3FlbXUuc2guDQpTaGFsbCBpIHByZXBhcmUg
YSBwYXRjaCB0aGF0IHJlbW92ZXMgdGhlIGxvY2FsIG9uZSBhbmQgcGlja3MgdXAgdGhlIG9uZSBm
cm9tIGNpcC1rZXJuZWwtY29uZmlnLg0KDQpUaGFua3MsDQpEYW5pZWwNCg==

--mKx6Z6KYnzyx1VfMr4sU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5056): https://lists.cip-project.org/g/cip-dev/message=
/5056
Mute This Topic: https://lists.cip-project.org/mt/75767901/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mKx6Z6KYnzyx1VfMr4sU--
