Return-Path: <SRS0=x9Vk=BK=lists.cip-project.org=bounce+64572+5078+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD17C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 31 Jul 2020 20:05:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF9A22B42
	for <cip-dev@archiver.kernel.org>; Fri, 31 Jul 2020 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pb5zdD10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF9A22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5078+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HAEBYY4521723xsbsn9Bq70h; Fri, 31 Jul 2020 13:05:14 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.3018.1596225913393167429
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2020 13:05:13 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 06VK54mI032615; Sat, 1 Aug 2020 05:05:04 +0900
X-Iguazu-Qid: 34trSYR0gh3lubPGb2
X-Iguazu-QSIG: v=2; s=0; t=1596225904; q=34trSYR0gh3lubPGb2; m=X8vkmNb213m+0ZHnsUhgFrzw9NT3STJjtBfH/XP2iNk=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 06VK53BV007352;
	Sat, 1 Aug 2020 05:05:03 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06VK52KB011054;
	Sat, 1 Aug 2020 05:05:03 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06VK52qp022347;
	Sat, 1 Aug 2020 05:05:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePgbFJW8Kxl/cdALfiviAw4FTiUAbEcl3VzMnsYLtxrgIruyRzVvttt2J6epacv/HqlkAqNmK3l1T5VrbF1QHjFGwoZeBOyTn10LuSb5/lAX6FwfC91syC8DyGLzddf6mnhAxPr6aHA7ZHsASvHoyhuW2/DxlgxmBjjUxIf7I0Us3HlgM4xmRyohjLbQSArr5gmAfITpe75KI9FXvxVS7gGofhzO41gxrht3czf7STuZZtN4hVCLFd6c5lyR/OJ9btuCB+Bb79C6pJihfMi7IMsdtXXoqb3lCThNisivGOmqjrC3Ormq8cNYuZnR1v0HJ2roxMWlUkwss/2ULD5ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D9rCtmTYoTwgfRObmt/qVjpQMhgTgOfXmSJ11EIELg=;
 b=KK6VL8Mk1WHq1/0gmTINlslkMMgqNHvZY0uOrLBhb7FLNZ5PLXxLg5mfi9xgH4AYMO1TJPfiLT5kU3eoApFchA5K2Pw2TfgkGZVCjaPaR283LuAAl5DKg2rAN62tgrpmlrxTokO/9aGOoQhIRgdzH0H2yXLZ8I0BjFepKfo6cD1nIWmMrNEDJOjn1GPxheO/ajKEORTPJvdjElIvzT1WbLhdmskraxC3u1Ik+vZUv9+YP/1t06Hxq9a80UJhRzfDldbO8APshUkLVL/+pweVpDWVM+10q32vvbyR/stt6II9V66PCMUCrAarPeJ3qH7HAcu79t2pRI2sL/nJ5gUE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>,
        <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable
 touchscreen
Thread-Index: AQHWZZbsTZShj1jcWUW22ApezgPMtqkfSnjggACXOoCAAj6dIA==
Date: Fri, 31 Jul 2020 20:04:37 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983BC4D6C3FB06EC23DF626924E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20200730094729.GA683@duo.ucw.cz>
In-Reply-To: <20200730094729.GA683@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d7f3e35-12f2-41ee-3f91-08d8358cf415
x-ms-traffictypediagnostic: OSBPR01MB2245:
x-microsoft-antispam-prvs: <OSBPR01MB2245D6E98D066BA35A2CB332924E0@OSBPR01MB2245.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JLIvGIkzwk//Yvb3Jdoz7F/wKAQpk3/RdiGnmmOHSOV7rWCtKtjNRbn7mgEEqbPZh4p0l0JMDPMHX7592J2RjqwVXYxurNJQ9DQTmzCSTx3jj/fstOZ5vxOV1z6VfB3ULW/YXUXgT3Vmvib+ErzJw/bTe4afkvaaKJBf1AMVRMdKFW/K5gp7RCd2b3oXwPm0p7DUuaH5suQ3QUkA17xu5WIYycyCDSbf/yuhYpjPgjG/6WAGzwiLfx/7WZfVK+xkb+GK5q7LfPqYBL2D2JT+ROdxMRMis/I3sao6bqriZkkTkw32OhnngF+jxNN03cNF
x-ms-exchange-antispam-messagedata: vLz4NRJobBHhdGmOrBnA4NrY6Mh7PzGss0OKumpqV0NWZk2lPjcviT9n3MppzbNJ2a8q3puKOR06GDE1en7zEbwnBkODGI14FfAFwQEoTgly8WGs4at59achQbcgzBt8UlygXdqPjIG1Qmiu9pLcz0Y4+aUkOYEvd/AoamhS6o7pCJD55YZhLWYve6UQ5apvHaQZPPiyHuJd69hgxbDN4OCfW06gm60Y5zlN6lWYOpuvDrVK6ahMpS1z9tFfP1rzPKCDVfSyBH0XZZOG1y+mmjPGadFD/LaXCCbpFyk65xx3SPXyCxELYsEdfWdy8C9peLd3g6dsDVrIhddfulrMthXvJ2Y+O92eWT032pyYbFOcGnv92en2YrD0aomu2JPLFv9WQq9ZcFamtmb/Q9OHy+PYRYXxbte2h+rqHI5cjKaLRSa1xEi1FL6dTvdbAcFred7c1ierid1yIdfnIsXwydvMXZDbMRWQ7aVkihVQQs4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f3e35-12f2-41ee-3f91-08d8358cf415
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 20:04:37.8772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bNOrZCUJ5xUiTsI9ZyYpeMHFAl2lH21p02JgFpw/MPKMm5aLEY66ePZwMboZsGDfC3SfBxwDlVhsm+669vyXC4FilSMOd6x+K8yZvLcyCFE8cUAJh9l481p6sgRFMOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2245
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uYKza8jZfI6QQkyrLhLkXGKUx4520388AA=
Content-Type: multipart/mixed; boundary="4733J2M2dcH14NfbT9yw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596225914;
 bh=Csrf9Q+4sr2iitU5Y+bmyII+DusaLtfrjaL9FHwMkuE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=pb5zdD10QP4T86pKClNicxxBIOBuYu6xNEYrjy6Jzac10SHpjuW34yyORQjfXAv7V2W
 WlBzK0LcR4e4si498KPqMjy0LeQTu2JEyzf1Fxg/nD//oIuISbDcYbr+JRtZ7jq43WhsO
 1z+/MfjSXSr0zjENxd740lFOqOzST6lUeVo=

--4733J2M2dcH14NfbT9yw
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAzMCwgMjAy
MCA2OjQ3IFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8
t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBD
YzogYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb207IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnOyBwYXZlbEBkZW54LmRlOyBjaHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb207DQo+IHByYWJo
YWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW2NpcC1k
ZXZdIFtQQVRDSCA0LjQueS1jaXBdIEFSTTogZHRzOiBpd2cyMmQtc29kaW1tOiBFbmFibGUgdG91
Y2hzY3JlZW4NCj4gDQo+IEhpIQ0KPiANCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCA0LjQueS1jaXBd
IEFSTTogZHRzOiBpd2cyMmQtc29kaW1tOiBFbmFibGUgdG91Y2hzY3JlZW4NCj4gPiA+DQo+ID4g
PiBGcm9tOiBNYXJpYW4tQ3Jpc3RpYW4gUm90YXJpdSA8bWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUu
cmJAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gY29tbWl0IDk5YWU3OGYxZmMzYTczYzg4
ZmU3MjZjNjc2YWU5NjNjZTcyMmJmMjAgdXBzdHJlYW0uDQo+ID4NCj4gPiBUaGVyZSBzZWVtcyB0
byBiZSBubyBpc3N1ZSB3aXRoIHRoaXMgcGF0Y2gsIGJ1dCB3ZSBhbHNvIG5lZWQgdG8gdXBkYXRl
IGRlZmNvZm5pZy4NCj4gPiBJZiB0aGVyZSBpcyBubyBvdGhlciBvYmplY3Rpb24sIEkgd2lsbCBh
cHBseSB0aGlzLg0KPiA+DQo+IA0KPiBQYXRjaCBsb29rcyBnb29kIHRvIG1lLCB0b28uDQo+IA0K
QXBwbGllZCwgdGhhbmtzLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gCQkJCQkJCQlQYXZlbA0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBFbmdpbmVl
cmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+IEhSQiAx
NjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwg
R2VybWFueQ0K

--4733J2M2dcH14NfbT9yw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5078): https://lists.cip-project.org/g/cip-dev/message=
/5078
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4733J2M2dcH14NfbT9yw--
