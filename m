Return-Path: <SRS0=zsMm=BQ=lists.cip-project.org=bounce+64572+5104+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CE4C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:13:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CD922D3E
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FHXNcnpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CD922D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5104+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GrXlYY4521723x6SrWVuUSMa; Thu, 06 Aug 2020 05:13:04 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.1201.1596696381184710017
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2020 23:46:23 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0766kIIm022711; Thu, 6 Aug 2020 15:46:19 +0900
X-Iguazu-Qid: 2wGrCcip2CXY2iB1ee
X-Iguazu-QSIG: v=2; s=0; t=1596696378; q=2wGrCcip2CXY2iB1ee; m=1/2dTpnkkhq5/wSNHb+fRcghO39RlLsHLIqZgklPd/Y=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 0766kHKN025531;
	Thu, 6 Aug 2020 15:46:18 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0766kGc0006956;
	Thu, 6 Aug 2020 15:46:16 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0766kE0H010120;
	Thu, 6 Aug 2020 15:46:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro0UK5qlH4vuglwv+heDNtAESkDXeN8xOnTN7+INI6OwXlAw8Ny2CnaBoZCz+kEghFenl7VKtYO3W2aTWs79NOy8HOIQRczO5sntZTLjrupwKAaTeBvQHyV2a6peiiklCQBENNdsOojkF87vzS2Ki4h2oINZjFMnY14DSuUD8mhxUasNvPvhMkO7R3Rq2J8OaqV8+HZ6Sr6sT2wLhRxhb40r8BMSpIVjsW8hfgR/yqYz7md1fpDlxjVoFUnP5hVqvL0zRWJC2C9JNUgo1MH/h9LrBme2cnpgls48sG35JmXF1IhlmNDjjYMQO/tiGJgzG/uDKofnsnqM4SrsrTDJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcNK0sKdmxIH430f3rWta+yRmW/dH34sW5/YfRIJBBs=;
 b=f7HiN3g8J2OhAGMF0Cqg34uwemMlhbXWYmNDHtvtmoXJYZx3K67mlIH+Br8G3EK/cEBs9sdK/yWf+j0wO3KIvtxcEph1jEfC3XDKS6uHldmJ/l07jiIKXNxpV52lzJrUX5wArjSOyJcEM/R0D7CUPDJOyX8KRMvw+0SgQlLuZAHY0VDqqGyzrt4YdIqEUuYP1hQRX0zzd2Td0tPCsdBMM1EHyexwlzU7vcBu++qPNWzx8g5/4H8oJFaLeEz/Ffh9F5M80y7LZqeUZpwRuucMh0Qgu7DNQu6FFATOz2WXTBM4WQhXv/4Fgb8zc4FCCBPyLs2bBVo+GU2RD3TShKdpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
Thread-Topic: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add
 EFI_STUB to config
Thread-Index: AQHWaX6lfBZmtPjHaUaZ6kNYeyjoB6kqp0XQ
Date: Thu, 6 Aug 2020 06:46:14 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 308cb461-fb7b-4133-6193-08d839d46a31
x-ms-traffictypediagnostic: OSAPR01MB2001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB2001040A67DC579CD5D5F62292480@OSAPR01MB2001.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IHlCnv19Oore+WxhKqBVEZP78QegLNW861RCVKBfS1AcD5FzttwKasKS7NjPtt+GtNlx2auVsFGteaLaDp/oEjnr7VrDoAlJu72hgSJKx0s193d4fJVoxJugm4/iAUWY+BZIYyz7ui0j2kPeoDCGY3KwUpnh1+x0rSAb0VjHutg9QCbg8srWC3tC7F1QaHypMtIX5zgjZ/6jRWq0tIrJ/DCIiv5oTb7vAFmqLLadh3N4uVyEE0p721Ud1wew6cpzd7okotvJ1CahOmOXKwa9yXA75G1bQev2gvlyeKeQu/Z8dbqkUDIwpIpqaRkzohYR
x-ms-exchange-antispam-messagedata: tj6bG1bVijxMxgaC7so8ePHZszuQG0IosTzyW22QZqRq6y8Y6ll0wgYbjDPHOvkgRbdQKJfnwlAmAEvnIDp8bvB6ArkWpvM3IG/0ea7BHyWsVjQ6EhhU4NOUhK+qGmwi/bV+MGzoMi4EEL8RkaqD/JsAhjnsCIVJcDyW0FBFliKk2sCcgYE6hwpjqEgWN+o8NVJKzsfOE7KnhA1X/YVmFTPt8HOS64TFx+OJsW9VPoN/y8YUDfx/Uas8wggm/HL92mZK9y7GAAYkTBbQlV6FD17ucFCC0tJpLmeBRFcofn1g5kwgqjir6MyUtfYuER5d8CmWxJtup3uQfC5FRv4mjTULr9Cwgetrn8jJnkz5kNfdf54jDhecnJMPC3+VJDTLHx/JC4o7g2PYKE9EE/iWe5AfSGgHTl2jG7gluOwX0IRwSVle70sXEyLZTFEbzzpkGxIl/DnsVtp8yOLGvZqrcS3QdtwPxMIEDly9Sd2a2rso9+bw2XlJ0OTFZz5J4s/AoE0vwyRGqaD+gkevUlDf3uo7av9UTTR4pwM0m7da7UG2v2tEgT7Gwtf5Rf6+7bC3G60mslnJz3LXFN4EzlhoS4YQsvExS2Fn23/T1OTcnddhwpNXLqLSFEpid06w+1CwDNbYu1hrAGvSayeb6OEuRg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308cb461-fb7b-4133-6193-08d839d46a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 06:46:14.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5eSW6peHS2vHutDktn9ygxhIOrtE6Vx6axvxCjyUviW2Lnqhveg6urB3SrPfiFtrYol8ITk1l1bsdHcwO4C7iRJDAA1S1LxXvX1HwDvgQbeoaJ4iiefo0Vq/xxWiMuB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2001
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uTV6erszTPvGuFXjgJOWMqWpx4520388AA=
Content-Type: multipart/mixed; boundary="xwN90kwoMHZcduMOBIlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596715984;
 bh=EyAItekTP868g7V95voy8m7QjY1H4DRG6mzDE1K8vJk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FHXNcnpCOhhazSjn7amkOzXJ+fkH72aT5qwgtNJg6xNglkX8prR+MdESkeV7tr5KS0A
 m3Ut3zRiYf0dQPYF569Rfwd6okcPTKGRwLWRxx63VBLGTlAj/6pVhXu7JSuSSTUoSBf1K
 QL6+haJVL/ueLE0GUYTIa90UuOGrKriQbG8=

--xwN90kwoMHZcduMOBIlC
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YgUXVpcmluIEd5bHN0b3JmZg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCAzLCAyMDIwIDc6MTIgUE0NCj4gVG86IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBzYW5nb3JyaW4gZGFuaWVsKOOCteODs+OCtOODquODsyDjg4Dj
g4vjgqjjg6sg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8ZGFuaWVsLnNhbmdvcnJpbkB0
b3NoaWJhLmNvLmpwPjsgamFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KPiBDYzogUXVpcmluIEd5bHN0
b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gU3ViamVjdDogW2NpcC1kZXZd
IFtjaXAta2VybmVsLWNvbmZpZyBQQVRDSF0gcWVtdV9jaXBfZGVmY29uZmlnOiBBZGQgRUZJX1NU
VUIgdG8gY29uZmlnDQo+IA0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3Rv
cmZmQHNpZW1lbnMuY29tPg0KPiANCj4gSWYgRUZJX1NUVUIgaXMgbm90IGFjdGl2ZSBib290aW5n
IFFFTVUgd2l0aCBPVk1GIGVmaSB3aWxsIGZhaWwNCj4gd2l0aCB0aGUgZm9sbG93aW5nIGVycm9y
IG1lc3NhZ2UgYEtWTSBpbnRlcm5hbCBlcnJvci4gU3ViZXJyb3I6IDNgLg0KPiANCj4gT1ZNRiBl
ZmkgaXMgdXNlZCBpbiBpc2FyLWNpcC1jb3JlIHRvIGRlbW9uc3RyYXRlIHNlY3VyZS1ib290IHdp
dGgNCj4gYSB1bmlmaWVkIGtlcm5lbCBpbWFnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFF1aXJp
biBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAgNC4x
OS55LWNpcC94ODYvY2lwX3FlbXVfZGVmY29uZmlnIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCg0KUGxlYXNlIHVwZGF0ZSBjaXBfcWVtdS5zb3VyY2VzIHRvby4NCg0K
QmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQoNCg==

--xwN90kwoMHZcduMOBIlC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5104): https://lists.cip-project.org/g/cip-dev/message=
/5104
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xwN90kwoMHZcduMOBIlC--
