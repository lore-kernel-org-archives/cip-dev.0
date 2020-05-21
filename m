Return-Path: <SRS0=3x/w=7D=lists.cip-project.org=bounce+64572+4637+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28358C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 06:08:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82951207D8
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 06:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JMBJA9Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82951207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4637+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8G6lYY4521723xdD9jKcLwqB; Wed, 20 May 2020 23:08:27 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.802.1590041304225001969
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2020 23:08:25 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 04L68Lpg013643; Thu, 21 May 2020 15:08:21 +0900
X-Iguazu-Qid: 2wHHbNmoGWre4ZGAbo
X-Iguazu-QSIG: v=2; s=0; t=1590041301; q=2wHHbNmoGWre4ZGAbo; m=PTUWKKyBOqOguWI9D5H7Qu628BrVF1tqD6xIgA1W2c4=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 04L68Kc8005207;
	Thu, 21 May 2020 15:08:20 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04L68KCe009090
	for <cip-dev@lists.cip-project.org>; Thu, 21 May 2020 15:08:20 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04L68Jvg020932
	for <cip-dev@lists.cip-project.org>; Thu, 21 May 2020 15:08:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnF+UpWPebXBqZtq6RcPQTzBZz3a/BryKaykRXIh6IHTPjdZeYrKEuOAZx5g+VntEvlWYBfi7WgO1ODRd3it3VlFb5ExEmBa9mk/LmzKT8EoFuJW4/ZDwlYnZaijWGKa2aL6NcL4rLUcPWNm7BdCQHYm4K5767+5AjkE2IX6y0tetJUOet6n8s3XLzhbym61nY/4hz6i8Qaailq9J9LFW7pXP9Jum+/nx5k6iykmX0Bzqf8n93i8wLFt/kaW9GrIrpacchhFhqISqP267gubm3TIolUlfWMwFnNFY2x/Vr+PyoaukjmgB2SZvVQI3pGD9o59rKc8WGGBXNzBvu0WbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsJx0csixu2+EsZ2RLYGeUZ+VS+/yEBM43V9kGZz4EA=;
 b=STZxmgZgAlUlm7GPzmTZm4zwFDv6j+v39quMemFfHiAXQjSychqAL48gADDbAk9/BxTMnfSCpetIMC0jSgJKareRwKmXYfh7y8J7KeBY6Hv4HMpoxyOizN4fOgYZ7qx1IFq9HBn7nnhqcRJYKk2HBbC90yx6aQtGaOrKcQRoWzw1P7E+mboPzxDhcLxRmW0VShoJAaeTnet5MO8EdwxC0WPKPgaYl0DyRylmuAOPQooVFmjFkVVJ8hsLvBETQcyoNUYTbKiuAfiHTDP2/WihuD57RDRSUYx5x4xeF7cvBLJ6vEABwryL/fM+eGlTRIbQSLtZyAl5ZfwmYpLaqbOg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYvB7QVKLJJTSekT7GTmv8mJ06fZwALeVzA
Date: Thu, 21 May 2020 06:08:17 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983629D897D216A673CFB4F92B70@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972A13626095E5A9810C62AA0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972A13626095E5A9810C62AA0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9783f56d-62f8-4dab-8658-08d7fd4d5abd
x-ms-traffictypediagnostic: OSBPR01MB1974:
x-microsoft-antispam-prvs: <OSBPR01MB1974CAC936CCA9985C4FF07892B70@OSBPR01MB1974.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1NHwFS+vGbO+yMddMHehoWqPCInar2kPz0m8n857B5oy0VbeCdgvbsPRUnPY6paz7JsFQApqxmqse7Cy8TYkwEaxN/XlgOuYcIiMJihoYS1IvDpefUMRjh8lizgCSv34PwMWI9SKi6gU+6ieYBfPNAJEZ/oksyokgLHO7H4G/i+2tr8FwSnzvNdxQsL1T/U9YKpVmvzmR35nqMOZMdx1WjnGUmiv0Y6qrvAkXHaDnFVWv4BX+EwImAjzShVtwuMuR6jNSuh8n8UzYTuVkvOaPDXX7HtGH999oBzjm2xzShHUK7bWwWlq4AKMeHI1EO7FOejae+1r4xjH6Ih8X/BbCHG08oQLGM+HiI0QpZ1uQQZqGf9WF88xArc3LuPgGBF1ddPrmOQvcKpv7m2VadabICOsslSwwdGEhHaQej0ZHfL1KO5ypPBcXW5TcYXV61VaaKvObnV4v6DnhleZ4SG3PvcHBKjYYZOjsatLGE3Dry++CBDctAeW5Jm4CryYBtJwfDUDxojRahsqZDzGc/njyQ==
x-ms-exchange-antispam-messagedata: KniMCT5NDQ4zmR8Iii11V++Q9byASDBWLrf5lD/PNYXu8hm4CKvQpYv0Sn4EZmCP4YMLSjfd3wVuocuOSILwcTNl/duae/QTPIKfmwa5b+mQ8ZPgGpG8suwKJWvC0+aAdXCIjmqfTwDxWdLva/lKsHGwOVSvWAC51fkVHNc4Qev+49BKYO2D2+/h88ia2bT9nUH2qiyYqjubsakv34zcRKLKVV2uoJx0l5J2DjLjaMIM1Nbf6zuN+o7Sd83kPDJ+QFjxtLmQnqLC+7y7qV6ob/wBgCvQ12UfHvyEt3Khj7hER4CoIHTvf+JAuiuq5Vt8UA9ghGPhOjOyhs5cQx3Pnyb3D7DKOlhpV08vIG8BAFtAEy4fWznh04GFTxJ+/DaHlOeiBMBBZmH2wG5e93psPQVXpqxKkub77TqSh2a3dESRElrhKt/bYwVGulukwMx6aouIaS0lYOosrH0DmgR+tZssn03E00TXiUmZM7afCq8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9783f56d-62f8-4dab-8658-08d7fd4d5abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 06:08:17.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZJv5DIXNCSPVcS2R377QC+AkBSCNCPTz56A6zcbKwfl+4q+ZDji6KmEQT0fp9A2+EIoDCU88lBPPYf739nE3NyBjQNFSUsy65Z48CDzAtBVKICDjMBqK+M2+18/IDnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1974
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XjA9vU7Jqed9X7VyIBoE3wXBx4520388AA=
Content-Type: multipart/mixed; boundary="mbamePLIogKn5rQLeuoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590041307;
 bh=7AE+aiVyMLotkfuaPCslfIdQp2IxawZwcJG3HvEMmTE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=JMBJA9JxqwkT222PMzY4xVgwdDvvsQHxOX68UkVNgTry1/Tgdc0rDVGRGlyK91yyEdq
 Q0T0cvkCrcSbJrENf8DF2C8r2oiVHdxQCByqOh5DhSM3YaootCHAkVsQEYu7RyKd3DoOK
 bjSJgu2xLILP+sKqW0/UQ4Ywof5GBNKAJmw=

--mbamePLIogKn5rQLeuoW
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClNvcnJ5LCBJIGNhbiBub3Qgam9pbiBJUkMgbWVldGluZyB0b2RheS4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YN
Cj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gU2VudDogVGh1cnNkYXksIE1heSAy
MSwgMjAyMCA5OjM3IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBT
dWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheQ0KPiANCj4gSGkg
YWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRp
bmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5l
bCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3YXMgcmVz
Y2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAwIHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IHdlZWsg
b2YgQXByLiBhY2NvcmRpbmcNCj4gdG8gVFNDIG1lZXRpbmcqDQo+IGh0dHBzOi8vd3d3LnRpbWVh
bmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIwJm1vbnRo
PTUmZGF5PTIxJmhvdXI9OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3OSZwMz0xMzYmcDQ9
MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiAwMjow
MAkwNTowMAkxMDowMAkxMTowMAkxNzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBpcmM6
Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0K
PiBodHRwczovL2lyY2xvZ3MuYmFzZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIwLzA1L2NpcC4y
MDIwLTA1LTE0LTA5LjAwLmxvZy5odG1sDQo+IA0KPiBBZ2VuZGE6DQo+IA0KPiAqIEFjdGlvbiBp
dGVtDQo+IDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVtIHdpdGgga3NlbGZ0ZXN0IGJpbmFyeSAt
IGl3YW1hdHN1DQoNCk5vIHVwZGF0ZS4NCg0KPiAyLiBTdHJlbmd0aGVuIHN1c3RhaW5hYmxlIHBy
b2Nlc3MgdG8gYmFja3BvcnQgcGF0Y2hlcyBmcm9tIE1haW5saW5lL0xUUyAtIEtlcm5lbCBUZWFt
DQo+IDMuIFVwbG9hZCBhIGd1aWRlbGluZSBmb3IgcmVmZXJlbmNlIGhhcmR3YXJlIHBsYXRmb3Jt
IGFkZGl0aW9uIC0gbWFzYXNoaTkxMA0KPiA0LiBQcm9wb3NlIGEgcmVkdWN0aW9uIG9mIGtlcm5l
bCByZXBvc2l0b3J5IG1pcnJvcnMgdG8gVFNDICAtIG1hc2FzaGk5MTAsIHN6bGluDQo+IDUuIFBv
c3QgTFRQIHJlc3VsdHMgdG8gS2VybmVsQ0kgLSBwYXRlcnNvbmMNCj4gNi4gQXNrIGJvYXJkIG93
bmVycyB0byByZXZpZXcgcmVmZXJlbmNlIHBsYXRmb3JtIGNvbmZpZ3MgdG8gb3B0aW1pemUgYmFj
a3BvcnRpbmcgLSBtYXNhc2hpOTEwDQo+IA0KPiANCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBk
YXRlcw0KDQpJIHJldmlld2VkIHY0LDQuMjIzIGFuZCAyMjQuDQpBbmQgSSBzZW50IGEgcGF0Y2gg
Zm9yIGZpeGluZyBDVkUtMjAyMC0xMjc2OSB0byA0LjQsIGFuZCA0LjkgYW5kIDMuMTYuDQpUaGlz
IHdhcyBhbHJlYWRseSBhcHBsaWVkIHRvIGVhY2ggTFRTIHRyZWUuDQoNCj4gKiBLZXJuZWwgdGVz
dGluZw0KPiAqIENJUCBDb3JlDQo+ICogU29mdHdhcmUgdXBkYXRlDQo+ICogQ0lQIFNlY3VyaXR5
DQo+ICogQU9CDQo+IA0KPiBUaGUgbWVldGluZyB3aWxsIHRha2UgMzAgbWluLCBhbHRob3VnaCBp
dCBjYW4gYmUgZXh0ZW5kZWQgdG8gYW4gaG91ciBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2Ug
aW52b2x2ZWQgaW4gdGhlIHRvcGljcw0KPiBjYW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMg
d2lsbCBiZSB0YWtlbiBvZmZsaW5lIG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQoNCkJlc3QgcmVn
YXJkcywNCiAgTm9idWhpcm8NCg0K

--mbamePLIogKn5rQLeuoW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4637): https://lists.cip-project.org/g/cip-dev/message=
/4637
Mute This Topic: https://lists.cip-project.org/mt/74364606/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mbamePLIogKn5rQLeuoW--
