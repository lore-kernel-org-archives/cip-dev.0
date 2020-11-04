Return-Path: <SRS0=R+MJ=EK=lists.cip-project.org=bounce+64572+5735+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E30AC2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 11:00:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6977F20867
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 11:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eXFrvSwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5735+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MiXrYY4521723x58rYbBu0vm; Wed, 04 Nov 2020 03:00:30 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.125])
 by mx.groups.io with SMTP id smtpd.web12.11543.1604487629046290507
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 03:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmS/1CA9GQYI24OIap/WnSy7y7tRGTm2lJsS3KHKqUY8BVaEpcwdP6lCIRjPmU+cMby79Gv8SWzhLMALiVmzDtSeNkTPknmPfU6eBjKVN39YTFvDhN/F1pEnpSscpFGd4AQmZiVomEvkfW+FzDlvAZInlGyqrHY6H3aFzbtMQ5Dfkvqx/t/6EvijVXWyQSiN5jKjRYA5uXB/L9aIBdne47x4K30DRUi5CLB7ZpdsTorES5L/d127+hmPeeaKB3GU7ibzk7Ajt1miOjkbDSUZwioxs39ud5y8HqTnKnOt1T2ziwbj18dy5uUL1EjuVe7SQb/WZfizYLLyOxz1QayuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dy3RvFJaztysSK7xxS34MYjIWQ1GwaXbCk1erdilTY=;
 b=CDU6DjcHATI+S8FKPJe6j0t6zkMFQM4Ne4KmaY5h7HebsyOAwCrdRHPM4YqeYRJ0YpRpQDwQM+bMow+cnRlvyIZz8xguI/aKQOKyv0Dkx2IsCjKjXiA4ShhyNURtgMWExKE0id39ecEB1JICW+kINh5o4gy2qCgfyO9bL70os+vVyfJf9tiwWLnxEKLmH2DXtk0Se7ICcTe+3sffffa7v1c9/l+FB4HbFUGii4odMuTsAcLwOS00jPVlnNHK92J5vwrq+JN+WCjS7RUWDdjlcYqPVzRjSw++530qnaCEx8h61BV7Qk+GQVjhlHO8mMU0I7qqbrSFqWEaKph0iSG6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB1906.jpnprd01.prod.outlook.com (2603:1096:603:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 11:00:26 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 11:00:19 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 17/17] arm64: dts: renesas: r8a774e1: Add audio support
Thread-Topic: [PATCH 4.19.y-cip 17/17] arm64: dts: renesas: r8a774e1: Add
 audio support
Thread-Index: AQHWsgeNx9TJVSOpp0C41rE0XKpQb6m3PjBwgACQIyA=
Date: Wed, 4 Nov 2020 11:00:19 +0000
Message-ID: 
 <OSBPR01MB5048D3A68C59D1F2695C57DDAAEF0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201103173336.2829-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983979C875F6B1EE7FC19AD92EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983979C875F6B1EE7FC19AD92EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bfa77d9-049b-4b59-c5bc-08d880b0d1df
x-ms-traffictypediagnostic: OSAPR01MB1906:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB190640CF991CC40CC8639B37AAEF0@OSAPR01MB1906.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 gjqdEzHAP7H+w8qSbVo5Khp080SN9n+nCaXiDPxQmh5bkuEF7xzVaKZbEW8aempTCxqPhiRgEXvLPacvUQUTjl4ZfyRDw3Lk/82NCojDJqs0VyGFnKVF9N5EMuod2EJp8B7SKHWgagSDIh53ugq629hIAVi4eS8KZnZtQZnFxysjL+NQ+lYWb7aVfWbWA9ykYWnU7U4aS9LGyJh9O3oA0vgOFQqpLbzFHFT/I29GcdGAQxw3kXyKz/q5E4T7SsPsgHqVi7FiddnC0XbkSN1i4uBp1TdQ1qhLepMpNOgnt0UYRz/Ko+O1i0FhTPln+H/BFHiY90+DcFdD0aegaKsETi5AZJJb5RJRzC5A9qBIfwu2AP2ZYW80zKtRg23QBaNg5jnfaTFpf7iCLd9Jak/TIg==
x-ms-exchange-antispam-messagedata: 
 CrEv3ymq4nThaMxd7c7wXt2ffMprfbkMaw8cKZv6XeB2RF5Oar+aSs6iso8IPX2sdSKtyLbcC+Vo6GpPlWwje2iwtLsGCsAynUDZbiPIBc585o6XDzXSrgq2MbBLHxNrYa/RPUcvSzWZIuLyOTSnn3bq98wN45MWHIP9hdsL6j8A7B92VsgoH/BNNEw9aAAX3pOgrj+5O1jNlgb1ET+YddowJ5Dgyp37CwDUYHuNnhnwnVJbdop0/p1JxLs/5qIQjs9z9z+dMs5QnYSg99hVRhzqAJSME0hkzQEeCFEeIG8jJ2Xh8z7aS4/msH5FSNIn3tCct70sJdQa5zvg6B1b0BSDuIzfxzsmEuiJBLHz2H3IxF9KallfhU1D4+nWxYHweK3htrBTrU0AA8PuCu0uxYj7dwa3c+M+MZRdqbYsGF+eL04imRnPPm1JUSNI/87UBjxIvVCkJDp6w74GEVkcszXjnnMdVHG2Z7AqLs6XDCmXCJu3+07K9DvYOEK+1Od9gV2fSWF/hszHPT/SUDXmKKRCZdJU5sqtFCJk1A4sKTEaBAjz256mfp8HLkwCjMKOsbcBxl793WmNKH1D+Y1uXMoE7VKPvIrPcPR9A1sYNooVr12MskCPDrFjSKSjfnwEWWseZobowrbKrvao4F1wEQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfa77d9-049b-4b59-c5bc-08d880b0d1df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 11:00:19.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJwnh7aMQsBvGk9xBLDMicpAMxhl0w5QDlp8qFwPavgWUIi9NBc5R/NmRQkgevCgsxjFqueJWu7Onj+937/1wXrYjoxR0NaFGnvYpNHsWJwhdpGK7W9YE1+RcjXS2Uyr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1906
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4ane2joz8PF5SViY2xcKZnDVx4520388AA=
Content-Type: multipart/mixed; boundary="9G3j7k2RJwUbsuzal8AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604487630;
 bh=r91xmRoj75ebLdijTIc8VzpShsqqkuihncJehMAg0GY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=eXFrvSwUsjggAuHaO5Q+JVNBx6va72E3IjB9pv2RR9H/OeueG2Iqxr+HQOffO8MGw0+
 UQzcMJMkYFdjNwMuSg9pqsY/vmBahjKz68vTeN0YNibPM5/ofqornfqSGoQsDW4+6zOJI
 Pbk3iQPuI0DJoGvtt/8DBl328eZd3BzfEAY=

--9G3j7k2RJwUbsuzal8AX
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cCA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IFNlbnQ6IDA0IE5vdmVtYmVy
IDIwMjAgMDI6MjUNCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFk
ZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7
IHBhdmVsQGRlbnguZGUNCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA0LjE5LnktY2lwIDE3LzE3XSBhcm02NDogZHRzOiBy
ZW5lc2FzOiByOGE3NzRlMTogQWRkIGF1ZGlvIHN1cHBvcnQNCj4gDQo+IEhpLA0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IExhZCBQcmFiaGFrYXIgW21haWx0
bzpwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb21dDQo+ID4gU2VudDogV2Vk
bmVzZGF5LCBOb3ZlbWJlciA0LCAyMDIwIDI6MzQgQU0NCj4gPiBUbzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y3
77yj4pev77yh77yj77y0KQ0KPiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47
IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gPiBDYzogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCA0LjE5LnktY2lwIDE3LzE3
XSBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTogQWRkIGF1ZGlvIHN1cHBvcnQNCj4gPg0K
PiA+IGNvbW1pdCA4MTgzYTc5MzhjZmVjMDU2OWQ3Nzc1NWFmNWNlNWZmNTU4OWYzNTQwIHVwc3Ry
ZWFtLg0KPiA+DQo+ID4gQWRkIHNvdW5kIHN1cHBvcnQgZm9yIHRoZSBSWi9HMkggU29DIChhLmsu
YS4gUjhBNzc0RTEpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBN
YXJpYW4tQ3Jpc3RpYW4gUm90YXJpdSA8bWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUucmJAYnAucmVu
ZXNhcy5jb20+DQo+ID4gTGluazogaHR0cHM6Ly9qcG4wMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGciUyRjE1OTQ5
MTk5MTUtNTIyNS0xNi1naXQtc2VuZC1lbWFpbC0NCj4gcHJhYmhha2FyLm1haGFkZXYtbGFkLnJq
JTQwYnAucmVuZXNhcy5jb20mYW1wO2RhdGE9MDQlN0MwMSU3Q3ByYWJoYWthci5tYWhhZGV2LQ0K
PiBsYWQucmolNDBicC5yZW5lc2FzLmNvbSU3QzM0OWE3YzBiNDRhMjRjNzFkNWNlMDhkODgwNjhk
ZDVmJTdDNTNkODI1NzFkYTE5NDdlNDljYjQ2MjVhMTY2YTRhMmElN0MwJTdDMCU3QzYzNzQwMDUz
NQ0KPiAxNjU3NjE0NzYlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZh
bXA7DQo+IHNkYXRhPUtoNlJiVUZBcnlLc2ppbzlOS0RYaFl4dHI2S3c2b0dXMVpET0ttYkJpJTJC
cyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gW1BMOiBNYW51YWxseSBhcHBsaWVkIHRo
ZSBjaGFuZ2VzIHRvIGR0c2ldDQo+ID4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0ZTEuZHRzaSB8IDQ3OCArKysrKysrKysrKysr
KysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVz
YXMvcjhhNzc0ZTEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3NzRlMS5k
dHNpDQo+ID4gaW5kZXggMjcxMDQ1NTU2YWEwLi45YWYzZGRiZTU0NTQgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGUxLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0ZTEuZHRzaQ0KPiA+IEBAIC0xNDM1LDYg
KzE0MzUsMTkgQEANCj4gPiAgCQl9Ow0KPiA+DQo+ID4gIAkJcmNhcl9zb3VuZDogc291bmRAZWM1
MDAwMDAgew0KPiA+ICsJCQkvKg0KPiA+ICsJCQkgKiAjc291bmQtZGFpLWNlbGxzIGlzIHJlcXVp
cmVkDQo+ID4gKwkJCSAqDQo+ID4gKwkJCSAqIFNpbmdsZSBEQUkgOiAjc291bmQtZGFpLWNlbGxz
ID0gPDA+Owk8JnJjYXJfc291bmQ+Ow0KPiA+ICsJCQkgKiBNdWx0aSAgREFJIDogI3NvdW5kLWRh
aS1jZWxscyA9IDwxPjsJPCZyY2FyX3NvdW5kIE4+Ow0KPiA+ICsJCQkgKi8NCj4gPiArCQkJLyoN
Cj4gPiArCQkJICogI2Nsb2NrLWNlbGxzIGlzIHJlcXVpcmVkIGZvciBhdWRpb19jbGtvdXQwLzEv
Mi8zDQo+ID4gKwkJCSAqDQo+ID4gKwkJCSAqIGNsa291dAk6ICNjbG9jay1jZWxscyA9IDwwPjsJ
PCZyY2FyX3NvdW5kPjsNCj4gPiArCQkJICogY2xrb3V0MC8xLzIvMzogI2Nsb2NrLWNlbGxzID0g
PDE+Owk8JnJjYXJfc291bmQgTj47DQo+ID4gKwkJCSAqLw0KPiA+ICsJCQljb21wYXRpYmxlID0g
ICJyZW5lc2FzLHJjYXJfc291bmQtcjhhNzc0ZTEiLCAicmVuZXNhcyxyY2FyX3NvdW5kLWdlbjMi
Ow0KPiA+ICAJCQlyZWcgPSA8MCAweGVjNTAwMDAwIDAgMHgxMDAwPiwgLyogU0NVICovDQo+ID4g
IAkJCSAgICAgIDwwIDB4ZWM1YTAwMDAgMCAweDEwMD4sICAvKiBBREcgKi8NCj4gPiAgCQkJICAg
ICAgPDAgMHhlYzU0MDAwMCAwIDB4MTAwMD4sIC8qIFNTSVUgKi8NCj4gPiBAQCAtMTQ0MiwxNyAr
MTQ1NSw0NzYgQEANCj4gPiAgCQkJICAgICAgPDAgMHhlYzc2MDAwMCAwIDB4MjAwPjsgIC8qIEF1
ZGlvIERNQUMgcGVyaSBwZXJpKi8NCj4gPiAgCQkJcmVnLW5hbWVzID0gInNjdSIsICJhZGciLCAi
c3NpdSIsICJzc2kiLCAiYXVkbWFwcCI7DQo+ID4NCj4gPiAtCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gPiArCQkJY2xvY2tzID0gPCZjcGcgQ1BHX01PRCAxMDA1PiwNCj4gPiArCQkJCSA8JmNw
ZyBDUEdfTU9EIDEwMDY+LCA8JmNwZyBDUEdfTU9EIDEwMDc+LA0KPiA+ICsJCQkJIDwmY3BnIENQ
R19NT0QgMTAwOD4sIDwmY3BnIENQR19NT0QgMTAwOT4sDQo+ID4gKwkJCQkgPCZjcGcgQ1BHX01P
RCAxMDEwPiwgPCZjcGcgQ1BHX01PRCAxMDExPiwNCj4gPiArCQkJCSA8JmNwZyBDUEdfTU9EIDEw
MTI+LCA8JmNwZyBDUEdfTU9EIDEwMTM+LA0KPiA+ICsJCQkJIDwmY3BnIENQR19NT0QgMTAxND4s
IDwmY3BnIENQR19NT0QgMTAxNT4sDQo+ID4gKwkJCQkgPCZjcGcgQ1BHX01PRCAxMDIyPiwgPCZj
cGcgQ1BHX01PRCAxMDIzPiwNCj4gPiArCQkJCSA8JmNwZyBDUEdfTU9EIDEwMjQ+LCA8JmNwZyBD
UEdfTU9EIDEwMjU+LA0KPiA+ICsJCQkJIDwmY3BnIENQR19NT0QgMTAyNj4sIDwmY3BnIENQR19N
T0QgMTAyNz4sDQo+ID4gKwkJCQkgPCZjcGcgQ1BHX01PRCAxMDI4PiwgPCZjcGcgQ1BHX01PRCAx
MDI5PiwNCj4gPiArCQkJCSA8JmNwZyBDUEdfTU9EIDEwMzA+LCA8JmNwZyBDUEdfTU9EIDEwMzE+
LA0KPiA+ICsJCQkJIDwmY3BnIENQR19NT0QgMTAyMD4sIDwmY3BnIENQR19NT0QgMTAyMT4sDQo+
ID4gKwkJCQkgPCZjcGcgQ1BHX01PRCAxMDIwPiwgPCZjcGcgQ1BHX01PRCAxMDIxPiwNCj4gPiAr
CQkJCSA8JmNwZyBDUEdfTU9EIDEwMTk+LCA8JmNwZyBDUEdfTU9EIDEwMTg+LA0KPiA+ICsJCQkJ
IDwmYXVkaW9fY2xrX2E+LCA8JmF1ZGlvX2Nsa19iPiwNCj4gDQo+IA0KPiBUaGVyZSBpcyBubyBk
ZWZpbml0aW9uIGZvciBhdWRpb19jbGtfYi4NCj4gVGhlIGNsb2NrIHdpbGwgYmUgb3ZlcndyaXR0
ZW4gYnkgaGlob3BlLXJldjQuZHRzaSwgYnV0IEkgdGhpbmsgaXQgbmVlZHMgdG8gYmUgZGVmaW5l
IGxpa2UgYXVkaW9fY2xrX2EuDQo+IA0KQWdyZWVkLCBJIGhhdmUgcG9zdGVkIGEgZml4IHVwc3Ry
ZWFtIFsxXSB3aWxsIHJlLXNlbmQgdGhlIHBhdGNoZXMgb25jZSBpdCBoaXRzIC1yYy4NCg0KWzFd
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZW5lc2FzLXNvYy9w
YXRjaC8yMDIwMTEwNDEwNTUwOC4yMTE5Ny0xLXByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5y
ZW5lc2FzLmNvbS8NCg0KQ2hlZXJzLA0KUHJhYmhha2FyDQo=

--9G3j7k2RJwUbsuzal8AX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5735): https://lists.cip-project.org/g/cip-dev/message=
/5735
Mute This Topic: https://lists.cip-project.org/mt/78011712/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9G3j7k2RJwUbsuzal8AX--
