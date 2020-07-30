Return-Path: <SRS0=aqAD=BJ=lists.cip-project.org=bounce+64572+5053+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00487C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 00:07:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B632075D
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 00:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mOtcoTuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B632075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5053+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MK7bYY4521723xFokVBoqSr2; Wed, 29 Jul 2020 17:07:34 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.3853.1596067650767072362
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 17:07:32 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 06U07TqE014725; Thu, 30 Jul 2020 09:07:29 +0900
X-Iguazu-Qid: 34trpDa8Np4VK2lSVi
X-Iguazu-QSIG: v=2; s=0; t=1596067648; q=34trpDa8Np4VK2lSVi; m=eGMuf+MnJV4eFtXLaVRe7oDIUw15bZAnx17ybuo9iSY=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 06U07STw034614;
	Thu, 30 Jul 2020 09:07:28 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06U07RFP004451;
	Thu, 30 Jul 2020 09:07:28 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06U07RQ3018032;
	Thu, 30 Jul 2020 09:07:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V28XTikOE809BUpwuaMdnQrjPMHOCrf7gPERRW5FzQ6x8C5hwYKftHa1s/ZoOECdrBK4WbcS3ZFA5hbH5zQWGB4F4pXzsayinB0VxUSCTDZnVpB0rhPvZW1h2aR9jFoFshCmAdvBDfilxL8nB9IHlTbyOHoljAhsJLHgMDyiCsuIL6cuf1yrMwFZbDyP6eSdY0CdY6u8XMAPKPE26rVQ1eMYJqB0edvgysct2cNijalX23WZofuS+nnrGUBeyYXofxEVZ/2j/32n7KWYXVfu0CKsEoGhXV7TaMWp9d3R5Iokjm0KU4+GVl0L9PLOwJC+9HpZZP2P+4tW2Du8y3hZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwJFUpqcRcATOrC41kLQpd/7JIfYpRO3w/RbZppLc7Q=;
 b=be4IJkmxZvulmOZGDeDEP9ER/RmzeTCWHJVagA4l9Cuqr3t3uMIEajjQ+5fJaSyJpuS4lf5UZ+/mpV908hGMBPQKc7JGJpydsjF2WmvATaP5BCi0iDgfshfs2pKEP7LkmXx7EDjRS5FTC2GZQVa7lQ2IO+QZwONtz+jRlGBMsNikKLbMbZmMJJ44dapmLNkzySooH7WDWrRr4Fi8hnB5i5JSaXItxqqRyJUwETNKEhd8zHB3omT7EmHleO9kwqYS2l7Uir5oasIAMpHnDtYqNAcG//vjfG0N0LBjum8+rfJ9G5byhY9nThPi/DGDdkSWvIkZ1s1XnrAczUSATKU7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <Venkata.Pyla@toshiba-tsip.com>
Subject: Re: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security image
Thread-Topic: [cip-dev] [PATCH 3/3] README: Add steps to build cip-security
 image
Thread-Index: AQHWXzdHeKjS+n6aDEyUW7/yz0jp7KkU/MwAgAFUbwCACPsz4A==
Date: Thu, 30 Jul 2020 00:07:12 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20533E649110E28C3CB9B5E5D0710@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <544b0f34-c55b-2be1-d672-6a5eb796403e@siemens.com>
 <30764.1595573908018751968@lists.cip-project.org>
In-Reply-To: <30764.1595573908018751968@lists.cip-project.org>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d00bffa-a137-4595-2e96-08d8341c829f
x-ms-traffictypediagnostic: OSAPR01MB2868:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSAPR01MB286847CBA70FBD46F96640C0D0710@OSAPR01MB2868.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5brX21ot8uRtDU09ILqRKNPh7nC5KuOirGa1IreiKH685eb7KbdPGEeDM8EIPtvkNKeuySZ4+r02qqh6BhxWDR8ssg2/E9fClw+B6fT+A27pEc/kyoltTFskF8NdOcaRBymeSsx+QrPHg12seO2zRQyKQcPuJ2QZDtwwm4J0MtrqSwtMfcAUgyipMc72zZRzTdSpvAQHDctAqbeXY3dGGqmGFNmEkGTDqI+fYl5glr4D3zm6zr/0t9zgds5IT9xGD60JwYp+FkzE6RmXbLQsvgTB6UY20ppmGoFHxcl9oQDiFrCgxqQ5TCFZKq2J2XHq
x-ms-exchange-antispam-messagedata: WWCVYB3Ced0qWV2cscnFi2T5xdi6azQqa+VjpGpxHlXkOcLbRYheJ1jFFu3wpg/13Zh2l7D/GV2UTDUr79415aT+X5cxblLhphNDUXN45/Hqojhr2xJc2J7Yc6xjqyyg/ZjCETVgp9nG2zH2ag22SBZF374V3QniejYnZGWxgsFA9FQwLNTWPBX0HICr9dXJvSeaczg8L85M0KGjfz1EZVfiNZPNmTOwCuBIiDMp64JmXW6W9EEZ03RMXT1T3lvAfG6sAenznYuFqWgnXNA6X4vwtIzqUiYlZEboYLntF8s+/azZUq9bxNwTFo2dRkyImaCdhPlQH1i9hNR9VtxD04BnvseS+vijYiLGhdytkCxbnC3s7/I8YRdU/mMageN8bm6QyTzkHuXsX8EaYz5kBYkf15K1FhOmxuB6G6zXrkmHrWqicQnqQKZ81k818ENB6IPcemmALLaLez6x0TablNKawQaSacMupF5ASbvFQs5fFsMpYgxnM+JZ0+D40FkOxNYJVlkCjHqWiR4HYAvwPWKb4/EmHwAvd0Nuuze+78DQRGuTgCTu7JPZutBVqvHpFMBYVBQe0R6kTBC55wC8T7Q22tkJINuHLE2WDuRwNt7NK57EsnZ9tR6FdCGKToRZbx3vs044dMwQ040+OI8nmg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d00bffa-a137-4595-2e96-08d8341c829f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 00:07:12.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUeZUq22QxC4s0zRAsxY7pkHxqRTvcrOV+a1Dlpy6xGS6jkZSeOTnyNdUrRhFMENotUoEfJ18d75yfbC6XGCiVz7GesbRdwQIs2h2CiOLNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2868
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ym0YjMmJqAyYo8JNPdMZbTADx4520388AA=
Content-Type: multipart/mixed; boundary="7riQuQEsp5R3MJwEREBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596067654;
 bh=EoMe4kdZlQ/xdqn678j3eb29k188aOMC+iYHpHVX3u4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=mOtcoTuy4bMdD7euNLwS/lMhqG5UJHlSCYpErVnnBUjTDh+bJ1jpfsuFx1eGG4OvQXZ
 h0gsNFYPGdqiDK2jkXKvGXsPVB/fRbtIpN0OnjxAQhQhV2G+Rq9OQ7qbZt7U16ZU8ktxw
 ZGxcZBkdis1pRDM+bK1i2jctJQY6EvTPVLs=

--7riQuQEsp5R3MJwEREBt
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgVmVua2F0YS1zYW4NCg0KTWF5YmUgSmFuIGRpZG4ndCBzZWUgeW91ciBlLW1haWwgYmVjYXVz
ZSBoZSB3YXNuJ3QgaW4gdGhlIENDLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIFZlbmthdGEgUHlsYQ0KPiBTZW50OiBGcmlkYXksIEp1
bHkgMjQsIDIwMjAgMzo1OCBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggMy8zXSBSRUFETUU6IEFkZCBzdGVwcyB0
byBidWlsZCBjaXAtc2VjdXJpdHkgaW1hZ2UNCj4gDQo+IEhpIEphbiwNCj4gDQo+IE9uIFRodSwg
SnVsIDIzLCAyMDIwIGF0IDA0OjEwIFBNLCBKYW4gS2lzemthIHdyb3RlOg0KPiANCj4gPg0KPiA+
IE9uIDIxLjA3LjIwIDEwOjE2LCBWZW5rYXRhIFB5bGEgd3JvdGU6DQo+ID4gPiBGcm9tOiB2ZW5r
YXRhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiB2ZW5rYXRhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gICBSRUFETUUubWQgfCAxMCArKysrKysrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL1JFQURNRS5t
ZCBiL1JFQURNRS5tZA0KPiA+ID4gaW5kZXggYmJhZDFhMC4uYjJjNDE2NiAxMDA2NDQNCj4gPiA+
IC0tLSBhL1JFQURNRS5tZA0KPiA+ID4gKysrIGIvUkVBRE1FLm1kDQo+ID4gPiBAQCAtMzYsNiAr
MzYsMTYgQEAgY2FyZCwgcnVuDQo+ID4gPiAgICAgICBkZA0KPiA+IGlmPWJ1aWxkL3RtcC9kZXBs
b3kvaW1hZ2VzL2JiYi9jaXAtY29yZS1pbWFnZS1jaXAtY29yZS1idXN0ZXItYmJiLndpYy4NCj4g
PiBpbWcgXA0KPiA+ID4gICAgICAgICAgb2Y9L2Rldi88bWVkaXVtLWRldmljZT4gYnM9MU0gc3Rh
dHVzPXByb2dyZXNzDQo+ID4gPg0KPiA+ID4gKyMjIEJ1aWxkaW5nIFNlY3VyaXR5IHRhcmdldCBp
bWFnZXMNCj4gPiA+ICtCdWlsZGluZyBpbWFnZXMgZm9yIFFFTVUgeDg2LTY0Yml0IG1hY2hpbmUN
Cj4gPiA+ICsNCj4gPiA+ICsgICAgLi9rYXMtZG9ja2VyIC0taXNhciBidWlsZCAtLXRhcmdldCBj
aXAtY29yZS1pbWFnZS1zZWN1cml0eQ0KPiA+IGthcy55bWw6Ym9hcmQtcWVtdS1hbWQ2NC55bWwN
Cj4gPiA+ICsNCj4gPiA+ICtSdW4gdGhlIGdlbmVyYXRlZCBzZWN1cml5IGltYWdlcyBvbiBRRU1V
ICh4ODYtNjRiaXQpDQo+ID4gPiArDQo+ID4gPiArICAgIFRBUkdFVF9JTUFHRT1jaXAtY29yZS1p
bWFnZS1zZWN1cml0eSAuL3N0YXJ0LXFlbXUuc2ggYW1kNjQNCj4gPiA+ICsNCj4gPiA+ICsNCj4g
PiA+ICAgIyMgQ29tbXVuaXR5IFJlc291cmNlcw0KPiA+ID4NCj4gPiA+ICAgVEJEDQo+ID4gPg0K
PiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBmaW5lLCBidXQgSSdtIG1pc3NpbmcgNC80OiBBZGQgdGhp
cyBpbWFnZSB0byBDSSAoc2FtZQ0KPiA+IGNvbW1lbnQgYXMgSSBoYWQgb24gdGhlIE1SIG9uIGdp
dGxhYikuDQo+ID4NCj4gDQo+IEFkZGluZyBjaXAgc2VjdXJpdHkgaW1hZ2UgdG8gQ0ksDQo+IGkg
bmVlZCBzb21lIHN1Z2dlc3Rpb25zIHRvIHVzZSB0aGUgY3VycmVudCBmb3JtYXQgcHJlc2VudCBp
biAuZ2l0bGFiLWNpLnltbA0KPiANCj4gQ3VycmVudGx5IGkgaGF2ZSB0aGUgYmVsb3cgcHJvYmxl
bSBmb3IgdXNpbmcgc2NyaXB0IGRlcGxveS1jaXAtY29yZS5zaDoNCj4gMS4gaW1hZ2UgbmFtZSBm
b3JtYXRpb24gaW4gdGhlIHNjcmlwdCBzaG91bGQgaGF2ZSBhbm90aGVyIHZhcmlhYmxlDQo+ICAg
ICAgICAgIC4uLi8kSU1HX1BSRUZJWC1jaXAtY29yZS0kUkVMRUFTRS0kVEFSR0VUDQo+ICAgICAg
ICAgIHdoZXJlICRJTUdfUFJFRklYIGlzIGRlZmF1bHQgdG8gImNpcC1jb3JlLWltYWdlIiAgaWYg
bm90IHNwZWNpZmllZA0KPiAgICAgICAgICAgZm9yIHNlY3VyaXR5IGltYWdlIGl0IHdpbGwgYmUg
cGFzc2VkIGFzIDR0aCBhcmd1bWVudCAiY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkiDQo+IDIuIGN1
cnJlbnRseSBzY3JpdCBpcyBleHBlY3RpbmcgdGhlIGltYWdlIGZvcm1hdCBpbiAqLndpYy5pbWcg
c28sDQo+ICAgICAgICBmb3IgcWVtdSBpIHRoaW5rIHdlIHNob3VsZCBoYXZlIHdrcyBmaWxlIHRv
IGdlbmVyYXRlIGltYWdlIHdpdGggZm9ybWF0IC53aWMuaW1nDQo+IA0KPiBvciBmb3IgdGhpcyBz
ZWN1cml0eSBpbWFnZSBkbyB3ZSBuZWVkIHRvIGRlcGxveSBpdCBzZXBlcmF0bGV5Pw0KPiBwbGVh
c2UgZ3VpZGUgbWUNCg0KU29tZXRpbWVzIGl0IGlzIGJldHRlciB0byBzZW5kIGEgcGF0Y2ggaW5z
dGVhZCBvZiB0cnlpbmcgdG8gZXhwbGFpbiBpdCB3aXRoIHdvcmRzLg0KDQpUaGFua3MsDQpEYW5p
ZWwNCg0KDQoNCg==

--7riQuQEsp5R3MJwEREBt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5053): https://lists.cip-project.org/g/cip-dev/message=
/5053
Mute This Topic: https://lists.cip-project.org/mt/75699595/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7riQuQEsp5R3MJwEREBt--
