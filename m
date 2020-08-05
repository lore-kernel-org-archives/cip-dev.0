Return-Path: <SRS0=jB87=BP=lists.cip-project.org=bounce+64572+5099+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31EBC433DF
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 01:28:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2202420842
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 01:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rV8RL2UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2202420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5099+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CjFwYY4521723xB8QH4HPtvr; Tue, 04 Aug 2020 18:28:04 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.1797.1596590879897260299
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 18:28:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0751RvGk031659; Wed, 5 Aug 2020 10:27:57 +0900
X-Iguazu-Qid: 2wGr7dZaRUTVkAfEWr
X-Iguazu-QSIG: v=2; s=0; t=1596590877; q=2wGr7dZaRUTVkAfEWr; m=/YrXsr5pzmtEk2VUh4qNi/XCWM3K7IsLKWqc+gOohkk=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 0751RuVd005542;
	Wed, 5 Aug 2020 10:27:56 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0751RuUO019549;
	Wed, 5 Aug 2020 10:27:56 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0751Ruvf021971;
	Wed, 5 Aug 2020 10:27:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ6j71uKRBPW9QiPJniuejR5cgo0LB4puBlRmEseLZPekPlwz/mFLYEtkXl6dMgzBrGrnZ/j1Nt82R8inBTCn3U26U1wgEUx4W2UYXMnDJJg/PGsEh0ThSaDqzJyYOBdz1oPwtqTT9J6ZhjWvT66KZwiTv5T7MSix43pb8FgpXhL0+tf/MzLhr+NAnKE0opv+yK661Q7VRJZlx8IxGVsqU+CxgstEzSA1jdcsevMNF1M4b2vmst/gv+NTwnzCbnYkd3Tqu948o/ycfaTkWYZyJKqMKvHXV2g1VtgGHi0hEh/jyPfDGspyzO9g/LQr1vOEySnxPUCli+awoXrw1IJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nBhT4JvywYawtMClUoorqWC0XOsvBrDngmCD7+0qSQ=;
 b=TS0VYDx+nkpSX4GdKP3IDEdch8+GbdxsONkfY3k4DoVPMXl0tuEc6YHhyqtr7etMw2tCv1uA2cnoRBN+nK0TtmKpkK6EiVqYQfSlz86JxlXYgIYg6BjYof8WvlHMRDN6WQKbbERlvoKqIlMNiIjw+fJXz5JHNSd6Pq1rQkAfBC4+kU/eqUbwfJn33leD1HmttolTwbvW3D3O6kShnAfNQlVfKCZPGAfFcAS0p3og7IKH1ucOTIiyeMmiDY2qqckuvRllL9rRwZkRgm5hDSOwWFItG8QQWC7fbscnUpSh/2y1wbUwS/N/xZsHiGCvTHa5U3baQrrLoptLJXzCOARpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core] remove remaining configs from isar-cip-core
Thread-Topic: [cip-dev] [isar-cip-core] remove remaining configs from
 isar-cip-core
Thread-Index: AQHWamKvrVvQ2U6WUkuOjKE5gS8qkKkotANQ
Date: Wed, 5 Aug 2020 01:27:52 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200804044724.629026-1-daniel.sangorrin@toshiba.co.jp>
 <0eca9df0-675d-ab68-f199-d029f4d779aa@siemens.com>
In-Reply-To: <0eca9df0-675d-ab68-f199-d029f4d779aa@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea8e3dd-fb95-4e1f-434e-08d838dec605
x-ms-traffictypediagnostic: OSYPR01MB5367:
x-microsoft-antispam-prvs: <OSYPR01MB5367B5F0F2474BAB4FAAE9DCD04B0@OSYPR01MB5367.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AF1oq2LIclQ8FMLRyCZ3kTrdP9Zgzx6PqSdFsTOkCNk+5put1XNkgRWa0IEs5C+b0bvNvi+xqpxEsoqWuLY5u/Ij0mJ4BujbW3/4fmgkahdZm1A88nJ0NATC3DzG1jHBTkNRZBfB1k0y5AIq7c1xaZoo9eluAv34/jLTeWyh8H0B0E02DhJ3yvWWERJknNg41uLXHn7XXFRUi0ombEVDEMowlP4TaYGMydFFNEQUm7idwX9cpGJgIwLFK7D73bz+VkxWR/j2+UJIv6xLqlSPtLdbLOrCqFUeQBaB7l+67cJRv0q3HB/RmkFfvS0wdJWsD5qY/GAd31AMgrSz3tUf3l71JnYc8NHjrGJLYX02Fy/+51rtP0S4AH/+FZQw3OTNx/hi7DGyW1Zet9AJ4Z8fHw==
x-ms-exchange-antispam-messagedata: ELNPbdEJ5rx6/4/dDsEueSPxPqXb4tAA1O48Mk1R8P8Au53HpWZh1eudUsb7kGw0+CG6sIedCJmZK0qZU9854eNVuFeOcEIiFkLLleek4pVyK3q+eNinarDEeliB4d/e9IZP+XLLxtMIIJhLBoG5pa6hS+Kl5nbzwWxeCRddap79Rinl0GvkD6h0t+xU3up1ovdFgt+tqty4zQFjvuBLXsuQ4m2EZiNGT7XkqC7mzvCLaYL3gnm0Yq8gK6oGL4/oLMma2mDEn+Xgv+gHo6HOJ95AzRXtpqwnD7yA+Opy9HzlUJdSsbweCiUgtNMNJPIMrNMib/RJVQDU6Ho2ahWnhrAUfG+0dYLuGEDdqsZ0bNgEcDmUC4aiq5SzdP8hdNFR09PsZvwqcxnoeRGPtkW84ZwbM/ppxJk2RZO0nQhCZ1WcSxnaog02LKbPy/HS2mq3KBn2OaxqEgxRnHfRzkYTEJFO7D5u/r0nf+EkyKKVMRObKyaIStS4V2U3+/fLfP2RhpmRfDBV6IJEP8eOamWhfwctE0u8+rvHFG0uXzNlbnKJRjrpbE0xdGIm2kYNAJSnYkWHWbLz5D+PgskPO/M3aneVGOgKNQ7+QfGSXQBXRpOveVv+e+4YOfmYSOB3ES+Da8qYzq9nqk78Wq5kuqQkMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea8e3dd-fb95-4e1f-434e-08d838dec605
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 01:27:52.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcMRvDrQKFFrEI99ucI+xKyNISlV7+TjDJ6xhT2jXO348y4JLi0CaKscGjtmLZJYg5SOcg2W86M9QWjRcKMSCNHlq3o4YpngHbJNh3d25ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5367
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5uWg1apGe5fK21oA4mHq0JDQx4520388AA=
Content-Type: multipart/mixed; boundary="JvAFmoy4c3FPoJFB5CBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596590884;
 bh=L/Z+SG1/TFqnFBPk6kHqBUCmTqCfIW49VdmmV1x2jAU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rV8RL2UMxJFL4iHOfEDskbT6V4PaNFEggM353JtfQ8LW+HGU5zX4IrUfPcwqgobdZoL
 HINkbFh+5a2ryL04gRq5hCDsWbEN0TUjxndS7Jvt46zS6igiwZqMEi4IKSS6hRaKMd7LF
 TeSplBRIjkucwqIxWyMC3MksKGIxWp/oRnQ=

--JvAFmoy4c3FPoJFB5CBZ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUXVpcmluLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4g
T24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYNCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDQs
IDIwMjAgMTA6MjUgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENj
OiBqYW4ua2lzemthQHNpZW1lbnMuY29tDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXIt
Y2lwLWNvcmVdIHJlbW92ZSByZW1haW5pbmcgY29uZmlncyBmcm9tIGlzYXItY2lwLWNvcmUNCj4g
DQo+IA0KPiANCj4gT24gOC80LzIwIDY6NDcgQU0sIERhbmllbCBTYW5nb3JyaW4gd3JvdGU6DQo+
ID4gSGkgSmFuLA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBqdXN0IHJlbW92ZXMgdGhlIGFscmVhZHkg
dW51c2VkIGRlZmNvbmZpZ3MgZnJvbQ0KPiA+IGlzYXItY2lwLWNvcmUNCj4gPg0KPiA+IFtpc2Fy
LWNpcC1jb3JlXSBrZXJuZWw6IHJlbW92ZSBjb25maWdzIHRoYXQgYXJlIGFscmVhZHkgaW4NCj4g
Pg0KPiA+IEkgZGlkbid0IGtub3cgd2hhdCB0byBkbyB3aXRoIGJiYl9kZWZjb25maWcgYmVjYXVz
ZSBpdCBkb2VzIG5vdCBzZWVtDQo+ID4gdG8gYmUgdXNlZCBhdCBhbGwgYnkgaXNhci1jaXAtY29y
ZSAobWF5YmUgaXQgaXMgaW4gYSByYXRoZXIgb2JzY3VyZSB3YXkpLg0KPiA+IEhvd2V2ZXIsIHRo
YXQgc2hvdWxkIGFsc28gYmUgcmVtb3ZlZCBhbmQgdXNlIGNpcF9iYmJfZGVmY29uZmlnLg0KPiA+
DQo+ID4gVGhhbmtzLA0KPiA+IERhbmllbA0KPiA+DQo+IA0KPiANCj4gSW4NCj4gaHR0cHM6Ly9n
aXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS90cmVlL2NpcC1z
dy11cGRhdGVzL3N3dXBkYXRlDQo+IGJiYiBpcyB1c2VkIGFzIGRlbW8gc3lzdGVtLg0KDQpUaGFu
a3MsIEkgZ3Vlc3MgSSB3YXMgY29uZnVzZWQgYmVjYXVzZSB0aGVyZSB3ZXJlIG5vIEtFUk5FTF9E
RUZDT05GSUcgZGVmaW5pdGlvbnMuDQpCdXQgaXQgc2VlbXMgdGhhdCBsaW51eC1jaXAtY29tbW9u
LmluYyBzZXRzIHVwIG9uZSBieSBkZWZhdWx0IGlmIHlvdSBkb250IHNwZWNpZnkgaXQNCktFUk5F
TF9ERUZDT05GSUcgPz0gIiR7TUFDSElORX1fZGVmY29uZmlnIg0KDQpJIHNlZSBxdWl0ZSBhIGZl
dyBkaWZmZXJlbmNlcyBiZXR3ZWVuIA0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2Np
cC1rZXJuZWwvY2lwLWtlcm5lbC1jb25maWcuZ2l0J3MgY2lwLWtlcm5lbC1jb25maWcvNC4xOS55
LWNpcC9hcm0vY2lwX2JiYl9kZWZjb25maWcNCmFuZCBpc2FyLWNpcC1jb3JlJ3MgYmJiX2RlZmNv
bmZpZy4NCg0KQ291bGQgeW91IHRyeSB1c2luZyBjaXBfYmJiX2RlZmNvbmZpZyBhbmQgc2VlIGlm
IHlvdSBuZWVkIHNvbWUgZXh0cmEgY29uZmlndXJhdGlvbiBmb3Igc29mdHdhcmUgdXBkYXRlcyB0
byB3b3JrPw0KDQpUaGFua3MsDQpEYW5pZWwNCg0K

--JvAFmoy4c3FPoJFB5CBZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5099): https://lists.cip-project.org/g/cip-dev/message=
/5099
Mute This Topic: https://lists.cip-project.org/mt/75981585/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JvAFmoy4c3FPoJFB5CBZ--
