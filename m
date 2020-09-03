Return-Path: <SRS0=JghJ=CM=lists.cip-project.org=bounce+64572+5388+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A0C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B0420737
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WdaGwu9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B0420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5388+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IZBvYY4521723x0V3yLczJOl; Wed, 02 Sep 2020 23:20:57 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.7912.1599114056517437413
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 23:20:56 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0836Kl4B010301; Thu, 3 Sep 2020 15:20:47 +0900
X-Iguazu-Qid: 2wGqu78fjWebf98JHc
X-Iguazu-QSIG: v=2; s=0; t=1599114047; q=2wGqu78fjWebf98JHc; m=fD9ihgzTiyLtCdYpkqLVMSAo7266XwE8Q71guVYgQW0=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 0836KjSX001199;
	Thu, 3 Sep 2020 15:20:46 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0836KjTv005722;
	Thu, 3 Sep 2020 15:20:45 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0836KjsO014568;
	Thu, 3 Sep 2020 15:20:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eobe/mths5p7diQDd95fRkI6cYS/4iWWBosSMI9ArVgZFVGAu99XPL1zPY0G9bYJswQuzJl0VLzq7hOHG6qjNbf8hVCBc5QJnzkKY8QBaL6SyqTFd/uAloN6ZdmxK1IJwG4po7msRsbO326getJAGyExa+amzT2OKvmZ4xz/kXptOBrWbNvOBhvI2Npjm2dZblJnt0nNlqBNrTXAcNXgAx0N+0XrsnOOd4liHXar8mALc8TXajy285LrP9qMFl33vhjDy2WOVB40jpWPh2Vhl0jMdlJq0fOjEFFlCQzIeQ+COeHbF1ZGwsX7Sg28T7LzTP3Zle6hVyPYBgf4uostQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKl5ErRrOZuN/hEmcybFg5kf4M3DNGmwBAJ8ncW1fGA=;
 b=IotvaZdqD4w0KLds9kLWlebUnU4QIRGVW7DoHp0zi6yNx1YcyMzAaph5fodVC0wNHdT6KBBPr2T1yOLJxxRnwI3ndNTslvMsxbXK0RzBKkYK0m59AA8MiRQ7xdBLBlyLPbfeNesSojw436p5GCrc/dnPnKA5cw2kG0S67RHE7pJf1T0WXsXETIp6dxi9uImw0U57jvzD8dC8Z4uno6Rd3jS4uOFhe5nOe0SfDh0IdZ5/dN8PN7CaBF53aoyYrjlnUwtAtKpedab/Y9DK8xNOzPAQGarXwG55k0kJFhuZIUz7tedoNzz34RsE1M3DlCgMB492ZmPcV3d7hzomsEyiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/5] Add RZ/G1H MMC/SDHI support
Thread-Topic: [PATCH 4.4.y-cip 0/5] Add RZ/G1H MMC/SDHI support
Thread-Index: AQHWgP3P1wCFnMPi/Eu5XyhaeNBWPKlVCDtQgABRDACAARk4AA==
Date: Thu, 3 Sep 2020 06:20:42 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A43CD11C4642C059C711922C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB29839D5D38C48CF0899AB729922F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20200902133324.GA10493@duo.ucw.cz>
In-Reply-To: <20200902133324.GA10493@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14a0c935-0737-4720-e697-08d84fd17c6b
x-ms-traffictypediagnostic: OSYPR01MB5320:
x-microsoft-antispam-prvs: <OSYPR01MB5320A77955E385DC77AB8E24922C0@OSYPR01MB5320.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: znlmPF7wY7JPW4mrladBS+dx52fvcBNgNPMjUcHDwZ/R+keGEGz1iKvxmQDuQKN/SOQ5euAL4LkJuCkX5xEXvSOAsuNt7t90uu3jh9V7w8NIgzul8n3huIsSb0lA6aGSbyVma3doMQ1up2ripFSgOs3ni4/5ATxUaFCEaj43cUjTXL5Ap2br5krwJMeI227Wwk/vtFGQdpqfx0qR1ihrhhWLuv0YPfKHLXFn1VktpWxkwx2q+A8m2RGUQNhc3MVawBPWwUu9d/9fJv5vbYvhgDrOowuMXP2O7nAe/PgYENI5Alt+deMXyC6obdK9i1Kj4vmS58kPZ+nG7vqTPmaKxw==
x-ms-exchange-antispam-messagedata: pQ4QKk5WOCrhb9McZsNW+ucDI5O73aAqnQsQwAn91jWd2aj/CdBmka2LXrDddwmoxpZ00A3rHzg0dnFDwm4L1mxoQj/hQ8pRwvuNgb2TcPvKXyZ+OG4VaAuAXfF0Aq4cNlz5A+afjJAAmVDH+RF/7E1+MmvELX+3vNS5jaIc84FtbRWx6DojnJeJ/vFu+EPGWAPxkaFR/Dw4fDO3irVlQNwq15PfHUjjCHW6yVDdBuy7C0EJq9MxyuzQu4UgU53PpP3mSuvZXfCBiXPXLqF6Lgt4Soy7bE4X6v8Mt8FY/waEAGQEf+1LXcQZQh/qaR1w0yI9l6k0m89X/hhKSUGBa0mypYLjqNti598Meglv6x5sMrSgT19YgLZyJjtj4TQ/zWTM8vORHXkV0bPNxkXDVyntif03gtq8VQJTUVerNdzgrt0x02U0MVW4TK+LepuL59crhnTn3A71ioCsXluWNCKKYOqAAnVO3FsLJZYSqDOVCqrcY94djj68SBDNTv+4Wh6YBaSWFfj2jOQ2ByXVQ3fUv5vsD32+5kYZ4NHwnyTbbafGs2DxQJZy7Kgiu87S2eV+pBeUCNRhOirZjhIlwDAHTuFXGq74qkifS/I36yTDGkkzlRYX4KtaikHeClCd9DysF5lcxs9aVVXsPdzD6g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a0c935-0737-4720-e697-08d84fd17c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 06:20:42.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kWIayKUiJAu8XALQUgFkfkBpqNYxxI31gFNgNEEahGNTYRtOeMMVmoNC0ZcbrZP60OcvYkbIGx8CGzX1xDRWBKlTq+C2Hy+CXjxIlCVEVkwPu6Z8aNbCdN/JvOd6q3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5320
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: McMZ52zJDOAWTrLAWFZahaBWx4520388AA=
Content-Type: multipart/mixed; boundary="cPwioqMPU64oSLagGHWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599114057;
 bh=HYbYfd9NTa5WsWdEjQe6yfJwkg2RSoWZ8RZi3c8UB9A=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=WdaGwu9xmNipZ7Oob3nysVLx7EAEM0tvD7TnxJ1ycvbZzp4FTzPhkyDb4JsHz/Z3Ker
 7S/skQjI+JMedt8VzyUxAI5rim8RIY1TZPVOjgNGUXAQiDbSZz/ErLnzeJ9BJSsr8dxwD
 hqYhs6HAcomIWkCvjEBn3wtux/5M7gytXrg=

--cPwioqMPU64oSLagGHWU
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMiwg
MjAyMCAxMDozMyBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHv
vLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4N
Cj4gQ2M6IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZzsgcGF2ZWxAZGVueC5kZTsgY2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tOw0KPiBw
cmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCA0LjQueS1jaXAgMC81XSBBZGQgUlovRzFIIE1NQy9TREhJIHN1cHBvcnQNCj4gDQo+IEhp
IQ0KPiANCj4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvdG1pb19tbWMudHh0ICAg
ICAgfCAgMSArDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi1pd2cyMWQtcTcuZHRz
ICAgICAgIHwgMzkgKysrKysrKysrKw0KPiA+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDIu
ZHRzaSAgICAgICAgICAgICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBhcmNo
L2FybS9ib290L2R0cy9yOGE3NzQzLmR0c2kgICAgICAgICAgICAgICAgfCAgNiArLQ0KPiA+ID4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDQuZHRzaSAgICAgICAgICAgICAgICB8ICA2ICstDQo+
ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NS5kdHNpICAgICAgICAgICAgICAgIHwgIDYg
Ky0NCj4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9yOGE3NzQ3MC5kdHNpICAgICAgICAgICAgICAg
fCAgNiArLQ0KPiA+ID4gIDcgZmlsZXMgY2hhbmdlZCwgMTIzIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4N
Cj4gPiBJZiB0aGVyZSBhcmUgbm8gb3RoZXIgY29tbWVudHMsIEkgd2lsbCBhcHBseSB0aGlzLg0K
PiANCj4gSSByZXZpZXdlZCB0aGUgc2VyaWVzIGFuZCB0aGV5IGxvb2sgZ29vZCB0byBtZS4NCj4g
DQoNCk9LLCBJIGFwcGxpZWQgYW5kIHB1c2hlZC4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJ
CQkJUGF2ZWwNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--cPwioqMPU64oSLagGHWU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5388): https://lists.cip-project.org/g/cip-dev/message=
/5388
Mute This Topic: https://lists.cip-project.org/mt/76578438/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cPwioqMPU64oSLagGHWU--
