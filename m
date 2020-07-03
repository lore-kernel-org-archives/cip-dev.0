Return-Path: <SRS0=Y03l=AO=lists.cip-project.org=bounce+64572+4884+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB09C433E0
	for <cip-dev@archiver.kernel.org>; Fri,  3 Jul 2020 05:51:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD5020771
	for <cip-dev@archiver.kernel.org>; Fri,  3 Jul 2020 05:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ELXgpM2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD5020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4884+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZYbMYY4521723xPmxReZhd1r; Thu, 02 Jul 2020 22:51:37 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.4728.1593755494513788056
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2020 22:51:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0635pUe1023611; Fri, 3 Jul 2020 14:51:30 +0900
X-Iguazu-Qid: 34trSYR0fuSqnTSzHW
X-Iguazu-QSIG: v=2; s=0; t=1593755490; q=34trSYR0fuSqnTSzHW; m=paIgzGM00ylqEcWB9T2VpC4ZF55/T0tAR/D5stylI8s=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 0635pTtt010226;
	Fri, 3 Jul 2020 14:51:29 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0635pTmG017286;
	Fri, 3 Jul 2020 14:51:29 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0635pQGL005157;
	Fri, 3 Jul 2020 14:51:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBThLztOOoRJGH3A1I+15B+Mo4eFBzHpWYT/e5AKzfXEbX3NCn2HjIRAw3LJOwUIPI+7mteSNLI8orEYoYnl/MiNTJYiYVwP51AMX2miHQm1HWG84hhYXs+K2ko+Akz/d/tKG3tezsjDrpWc9rSv1y+QgWzlDLmUkr4jO0ZPEPh/kPGOODcvEwC0J5OiOIgRF3K46uMhVqGRAjer/b3dNNwp4OpolrPIT59kir76ZJeUDkmWi99aNarQAzTb+86R109nWkD8JbVpCOPKFTnGb7epV1Nd2wRX0/FLpcg3OWy9I5Q3SX6ihtIhifZmzk7HTK5TwVyKq5CH6TgPW6RYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWhLQ/Hv3q55gTzFj7PHMi6m5BHcn2f2ZiAbyXMcnGo=;
 b=SwKgwZHnJCCUz9ZmkQ6iMVgAwKc984j8nq1/Ec+PxPRIzKDFcIF77fTgazUYWlrNcvIPS6M1gEz+1g8Y9YCglwxFSTeV5i8I7pLRJRm8y6ZCCXAU4lpWoBF6DJmeGzCyixqnjRM9+17i7Hj/4Qx1osgHno4tBWQa7JcRO/DPYTISCFae45S255I2LYTKA18I4GbaRobRZDOHgZVb/N+Rxtv/nNZNaGNEc7qV96YPyIjHpKu0niI5zkSOfDZPMs3wOZHG2kavP+pJCl5MTZottQ0I3rj/IaeQIxhs3tjZ+JIAosjdj5KTCrs0mhNMgoffrV3j9KEdhwVQYbJ4Sz01hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <quirin.gylstorff@siemens.com>
CC: <mab@mab-labs.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Working on HTTPS connection
Thread-Topic: [cip-dev] Working on HTTPS connection
Thread-Index: AQHWTjZwZGeyLbMNKk+UNRR4NHCw7ajz+BAAgAFXG+A=
Date: Fri, 3 Jul 2020 05:30:05 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB5334E9505C5DD52E9ADB2E02D96A0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <CALkjhPpsdM8ZoC4QcT1EL8iQob4-pj3MWkesEvnNEFBOZ6LVOw@mail.gmail.com>
 <3e827924-5e07-2d2f-c714-7290b9574ab8@siemens.com>
In-Reply-To: <3e827924-5e07-2d2f-c714-7290b9574ab8@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c030d0e1-0d09-45b8-0e74-08d81f122463
x-ms-traffictypediagnostic: OSAPR01MB3618:
x-microsoft-antispam-prvs: <OSAPR01MB3618534932C4BBF4ECC33B95D96A0@OSAPR01MB3618.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6vthIIS+UEPzdgsPFkObYvdekvTqbbC+Je+vu/vIiHGurMlXk5MB5SE4ksaWDguWs3bv0+V7MQtEToj6+1TkvtcuMEZO70tOBFWXR8X9X/lQPmgfBwrFDresjoQnBXNSEsWBvF0yswdSzxy3dKnWysMATMj077kYBn3eDcxH8FBcY7xP6s4moHtp0ypTkPxS/LNjTcPdyaWBdXM5ziYJwskiK4juIh63ZsMYoTarbY8ue2+lI37wXk8SoPmjHBvZ1ASZuEdamc9sxxyi4qXpE1kF26UASPufvIT8Na59gq330HVp0pA52ySzkTz0Y/jedD1rhASXV17I5TmGsEG1spFPhKelYcslLNW7J6NiCuazCBI4hPgjgIcdenvQHbGLRtKW84m0gVvh+LZZT2qDNw==
x-ms-exchange-antispam-messagedata: Ek75/WHgl+KifwVfYzlM3VT06Fr7FSrBgbJwtp+gGwc5XvtzrKOXO/CHTeg1adrA+wK5wnQLwaQcpLFtYZTvdcMZY6mi/ComQ1Kz466HJJYKd4hvNQGTUPiLV+LK4sCJioY0s3b4JlhCg5jQ90rd6NVAHK3GxRVzgLasUZGSGnHUYmvEC/zEEax8nNqjRzXXq9uAxPE8r6zWP0ftw/vhZ4WFgTeFc+InQDWyzqoamtoYpMBkUgYzYGvsQxslyo9+H50Rdsf/bVu1BD6nwCaeNAhQuE8u6x6/kryf8eK5ZgZxm9+njqBv9zCJO8b+/W9yer3g3Taetwy7rFlx+duw56M1gpApg7GPvfODXl2F9oOCpd96EoX0uK8D2Po1Sp1xdHLooMm4WoEwOQQqw0C6/NW7gKcpqec3uousNqfJviwxNXbchOPl8qPIcSD/M/XXv08WvRA/XH+yOmLTDhmRtlHw5nUe7Mr6qKW6Op2axMI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c030d0e1-0d09-45b8-0e74-08d81f122463
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:30:05.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfxIYR+CQk77veDjOMVw1crnOcJp6rSe6K/hnlhd7LI6eqyV6SU2mOcXMhAcdFRzY7AEqH7d+2WWvQPyApIgntu0xxuY+N8LpNXsmwcjW88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3618
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Cgd1HOGgBSMYVX0ypjydfHwux4520388AA=
Content-Type: multipart/mixed; boundary="Q2vGpZN0iS9sjGT69wAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593755497;
 bh=Ojo1ytYkb1jjISXv3KOuvMgI2RjNlX39kL/RexRjAXM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ELXgpM2VVVXzuD/oznRa6qqiLJciL72OjGyyTxM9rdzBHJRbC7r0tjCxshzUpWgIghN
 PkooxRso1fvK9lxHCAbsGtn+2UrCnzJbZScdO4baB+QQNTN1yTqUvHXVtjG5z66zc+E3T
 YJZfW5CIzpR3X6jmywIZtkvanbMtZ+ZllfU=

--Q2vGpZN0iS9sjGT69wAs
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUXVpcmluLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4NCkkndmUgYWRkZWQg
dGhlIGluZm9ybWF0aW9uIHRvIHRoZSBmb2xsb3dpbmcgaXNzdWUuDQpodHRwczovL2dpdGxhYi5j
b20vY2lwLXByb2plY3QvY2lwLXN3LXVwZGF0ZXMvY2lwLXN3LXVwZGF0ZXMtdGFza3MvLS9pc3N1
ZXMvOA0KDQpUaGFua3MsDQpTdXp1a2kNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZz4gT24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYNClNlbnQ6IFRodXJzZGF5LCBK
dWx5IDIsIDIwMjAgNToyNSBQTQ0KVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBt
YWJAbWFiLWxhYnMuY29tDQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFdvcmtpbmcgb24gSFRUUFMg
Y29ubmVjdGlvbg0KDQoNCg0KT24gNi8yOS8yMCA2OjU3IFBNLCBNb2hhbW1lZCBCaWxsb28gd3Jv
dGU6DQo+IEhlbGxvIQ0KPiANCj4gSSBqb2luZWQgdGhlIG1haWxpbmcgbGlzdCBmcm9tIHRoZSBy
ZWNvbW1lbmRhdGlvbiBvbiB0aGUgSVJDIGNoYW5uZWwgDQo+IChhZnRlciB2aWV3aW5nIHRoZSBD
SVAgdGFsayBhdCBFTEMpLiBJJ2QgbGlrZSB0byB3b3JrIG9uIHRoZSBmb2xsb3dpbmcgDQo+IGlz
c3VlOiANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1zdy11cGRhdGVzL2Np
cC1zdy11cGRhdGVzLXRhc2tzLy0vaXNzdWVzLzgNCj4gDQo+IEkndmUgd3JpdHRlbiBhcHBsaWNh
dGlvbnMgKyBkcml2ZXJzIGZvciB1LWJvb3QsIGhhdmUgd29ya2VkIG9uIFNTTCANCj4gKGFsYmVp
dCBmb3IgQW1hem9uIEZyZWVSVE9TKSwgYW5kIGhhdmUgSFcgaGFuZHkgdG8gaGl0IHRoZSBncm91
bmQgDQo+IHJ1bm5pbmcgKEkgaGF2ZSBhIERFMS1Tb0MpLg0KPiANCj4gSXMgdGhlcmUgYW55IHVw
ZGF0ZSBvbiB0aGlzIHRhc2sgdGhhdCBzaG91bGQgSSBiZSBhd2FyZSBvZj8NCj4gDQoNCkhpLA0K
DQppZiB5b3UgYWRkIHRoZSBmb2xsb3dpbmcgZWxlbWVudHMgdG8gdGhlIHN3dXBkYXRlIGJ1aWxk
IGNvbmZpZy4gSFRUUFMgDQp3b3JrcyBtb3JlIG9yIGxlc3MuIEkgZGlkIG5vdCB0ZXN0IGl0IGlu
IGFsbCBjb25maWd1cmF0aW9ucywgb25seSBmb3IgYSANCnNob3J0IGRlbW8uIEFuZCBzb21lIG9m
IHRoZSBvcHRpb25zIG1heSBub3QgYmUgbmVjZXNzYXJ5Lg0KDQouLi4NCkNPTkZJR19DVVJMPXkN
CkNPTkZJR19DVVJMX1NTTD15DQpDT05GSUdfU1NMX0lNUExfT1BFTlNTTD15DQpDT05GSUdfRE9X
TkxPQUQ9eQ0KQ09ORklHX0RPV05MT0FEX1NTTD15DQpDT05GSUdfQ0hBTk5FTF9DVVJMPXkNCkNP
TkZJR19DSEFOTkVMX0NVUkxfU1NMPXkNCkNPTkZJR19TVVJJQ0FUVEE9eQ0KQ09ORklHX1NVUklD
QVRUQV9TVEFURV9DSE9JQ0VfTk9ORT15DQpDT05GSUdfU1VSSUNBVFRBX0hBV0tCSVQ9eQ0KQ09O
RklHX1NVUklDQVRUQV9TU0w9eQ0KQ09ORklHX0hBU0hfVkVSSUZZPXkNCkNPTkZJR19KU09OPXkN
Ci4uLg0KDQpRdWlyaW4NCg0KPiBMb29raW5nIGZvcndhcmQgdG8gY29udHJpYnV0aW5nIHRvIHRo
aXMgcHJvamVjdCENCj4gDQo+IC0tIA0KPiBNb2hhbW1lZCBBIEJpbGxvbw0KPiBGb3VuZGVyDQo+
IE1BQiBMYWJzLCBMTEMNCj4gd3d3Lm1hYi1sYWJzLmNvbSA8aHR0cDovL3d3dy5tYWItbGFicy5j
b20+DQo+IDIwMS0zMzgtMjAyMg0KPiANCj4gLS0gDQo+IE1vaGFtbWVkIEJpbGxvbw0KPiBNQUIg
TGFicywgTExDDQo+IHd3dy5tYWItbGFicy5jb20NCj4gDQoNCi0tIA0KUXVpcmluDQo=

--Q2vGpZN0iS9sjGT69wAs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4884): https://lists.cip-project.org/g/cip-dev/message=
/4884
Mute This Topic: https://lists.cip-project.org/mt/75196049/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Q2vGpZN0iS9sjGT69wAs--
