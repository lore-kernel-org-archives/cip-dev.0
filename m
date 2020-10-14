Return-Path: <SRS0=opVH=DV=lists.cip-project.org=bounce+64572+5572+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA64C433E7
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 04:16:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7610D221FE
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 04:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F7pLed+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7610D221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5572+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zdGlYY4521723xGtdB5yh1aU; Tue, 13 Oct 2020 21:16:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.4051.1602649013572224683
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2020 21:16:55 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 09E4GbtZ018007; Wed, 14 Oct 2020 13:16:37 +0900
X-Iguazu-Qid: 2wHHXRldaQx201JEHx
X-Iguazu-QSIG: v=2; s=0; t=1602648997; q=2wHHXRldaQx201JEHx; m=JFDYn91uRzrToWRxxFdZ8fB54sTR8gBl64hKh3prb+A=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 09E4GZov019511;
	Wed, 14 Oct 2020 13:16:36 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 09E4GZhB024651;
	Wed, 14 Oct 2020 13:16:35 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 09E4GY6i005748;
	Wed, 14 Oct 2020 13:16:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5KC5GFz1q4YMoSA3C6KJ4sO47XLShqJ+nzRUNdSCuWEaRU6IxFXtBd86icxdNl+jdg6U3d0KUp2dIx3niJhwT/QTJf1oazJPllz12IsPDyxujd457+wzXY7MBOCLYO+Mk14FRacOzGbnsyHn3bWcof8GJUnywfycBIbT3KWG6xtPk0Uxm7TLez2tHcY/KzChmQ2Co0NWXcfQKrG15dQtBKTvlT2w6Fw9QTF2L164slX+3bBmFLC6CXXzfhdxfaVB/Xw9JAigTWGUegR/5BDIlNPEyGH94UKewZLatEmz2q6/ta5Gdd7dGMby9Uf1D8IY2laKKw2QBFkw5qVbT5r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByWN863z8Lv/eQ1Pv3ET9gK3okqegHUDFqf07sfucxY=;
 b=QpWUjWOHylgREfZXyutYUd4oHH/eb1aDfQc2nd9LYg5VmJl35VTKgkvrHdYwOniCVjHaCb1JaFmirqp1ms/Y7XniCCD/I19kpcNqkKbcHAGdiHunQylgt4w3whcOfTlJ2eNK7c4DQ8HZUeXN7icU7y0TM7Yc7ku8//f5hs2AfV5+lDZB31qd4Dh5hxCtnnm//QBkWhOVBBEEKkOukQ9JPBZcOG9PG4CFlHOTs5w6/B1dbX4JXdnsj4gqR7NUhoIv8fKsKsC0wAWP01AXppElXh006qxpEz6A7tveaEk6sJoiEkyBhXEFZQIm3OjmBTABhoaQl2tHD/5QqnaR62Oexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <sz.lin@moxa.com>, <ben.hutchings@codethink.co.uk>
Subject: Re: [cip-dev] [cip-kernel-sec 3/3] issues: fill in the description field of remaining CVEs
Thread-Topic: [cip-dev] [cip-kernel-sec 3/3] issues: fill in the description
 field of remaining CVEs
Thread-Index: AQHWnUueNDsXBbEbyES95NJs/plybamWhkzQ
Date: Wed, 14 Oct 2020 04:16:21 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053976D2C2708EC5A906FDCD0050@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
 <20200925035927.1958987-4-daniel.sangorrin@toshiba.co.jp>
 <CAGb2v66v0N=eC_1-2kFbdYp=mLFTd69mRJ_BeBhw3HXyOya2Rg@mail.gmail.com>
In-Reply-To: <CAGb2v66v0N=eC_1-2kFbdYp=mLFTd69mRJ_BeBhw3HXyOya2Rg@mail.gmail.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac65d574-569f-43b7-0dcf-08d86ff7e805
x-ms-traffictypediagnostic: OSBPR01MB2229:
x-microsoft-antispam-prvs: <OSBPR01MB22293F47C2852DFBEAD5871BD0050@OSBPR01MB2229.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HHUsq8+SkVbYvub5Lv+uPaN0Y9dt29PY0iuTbQ8R4mhRx3MA55Hltw41h1m5rFPRCrOae+SaSDQgYIqB7sUCkQ3wfVz2JU+oAWpTzodZA+SLxsSbK+ypi1UrN6dGF6FNPAiwH4xsfQm6DVN3qCbKyYGQrlMnJe8Lm2iwgReRlWZa1zC0QuYpShRPPxoWpx09u2lm82YYrOIRbDvT1RF0yFL30L1dalqHys3z6na10CkVu/MRY6kITLHuQeJubhQ4i3abR57OlilhENX8fB+oIDmp0rE2R9IDhVlol6/FXdG5EFV2Fy9Qpkd+HGjqOzKoamUoRH0iWN2Wz4Bs8T53FA==
x-ms-exchange-antispam-messagedata: Yr/Ux+D8i3s+/WDNUtiAom3MDN+V3xC/4mdolYfYgHT9j1mJShhEeZtvZPennybLSusIZO4+xRBH8BVrmYyD5LucBlXGG+vNO9S2ajkg41jg/jPn51Ky5RwXWU7mTOvxQOopTug9Fs6UR8hXzKpgan9IYFtW0Xs40FmjXs44PNO9KuggIj7NdkDOIByVxSDHia7/fhzGYpBLhH5HjsEu2jDxTraaiwPob6zVsPMw7S0FwkTha48vBgj5BK43bo5zF7NCCdKRXn3owFfffBP9DRc65wIthTlikirhxC8IQgfpk3vyDhsVWRLLCo9xubjScT4MbB+rma41bVw1IXkfv2kB7KernHPm++8NTkCd62MuMCcrEhBAQXNWnWRaVjJfbdO3FL9eXG1bHx8LFsYDRK/TmZKaWjmsZ7PhAABhVJVIFkztSIeoPSmRdUIdy3wO/aoY5QCK3h3gM2m3j0/NW7JMf+mLwnZETH3DKoP2yAA3EaNojA1uvfah4TpAKw0dyj+jawVqhklzmi+vRNC1RXs6d3UBFQgSUb+DnEKG0ANeJo3meNDIe+w811PfXQek9S1uhSxVy4e9HgqyqUs1McHVkoCAvg6ZOx6QjvaZp0XCJpphRQjYj3o32Ch4rcXmuCf46p4VsiS/fYZTVIruDw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac65d574-569f-43b7-0dcf-08d86ff7e805
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 04:16:21.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rafjkbqTfb1Js/u+TL5oEbTsto2VBLsGik68aOMp9f6Z7edRjo47XWpdF/X7cPSHbh9X0gdba9Hmpp0qL4Q0z+yM268Q/Oyccu5bj0whYcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2229
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kROiamHb1Bspi6F9Vr7Dx0YQx4520388AA=
Content-Type: multipart/mixed; boundary="IRlazmqJqwVgkqJ7hgd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602649015;
 bh=5+5RkoFERLk+YVJ6JOwnSJ+vfKnF4xnZ/ZftRpYZgnE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=F7pLed+fL6wF6o4EN0W/RAr+lkYG/I8KcbP186sMAr7j8kJTRw48XdFvMT5/78ObViv
 tFwWXA1A8uYnzi6FD3HfBCQuiGz2tQpZ9xoTs245MJXw8cOt9vwu3sW1aSj1deu5FKz5V
 LHWIe/WoxytcJlEOg3KjSloEXv8Vks9ieCM=

--IRlazmqJqwVgkqJ7hgd5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hlbi15dSwNCg0KVGhhbmtzIGZvciB5b3VyIGNoZWNrLg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIENoZW4tWXUgVHNhaSAo
TW94YSkNCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyMCA1OjE5IFBNDQo+IFRvOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogU1ogTGluICjmnpfkuIrmmbopIDxz
ei5saW5AbW94YS5jb20+OyBCZW4gSHV0Y2hpbmdzIDxiZW4uaHV0Y2hpbmdzQGNvZGV0aGluay5j
by51az4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbY2lwLWtlcm5lbC1zZWMgMy8zXSBpc3N1
ZXM6IGZpbGwgaW4gdGhlIGRlc2NyaXB0aW9uIGZpZWxkIG9mIHJlbWFpbmluZyBDVkVzDQo+IA0K
PiBPbiBGcmksIFNlcCAyNSwgMjAyMCBhdCAxMjowMSBQTSBEYW5pZWwgU2FuZ29ycmluIDxkYW5p
ZWwuc2FuZ29ycmluQHRvc2hpYmEuY28uanA+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogbmd1eWVu
IHZhbiBoaWV1IDxoaWV1Mi5uZ3V5ZW52YW5AdG9zaGliYS5jby5qcD4NCj4gPg0KPiA+IEkgbm90
aWNlZCB0aGF0IHNvbWUgaXNzdWVzIGhhdmUgdGhlIGRlc2NyaXB0aW9uIGZpZWxkIGVtcHR5IHdo
ZW4gdXNpbmcNCj4gPiB0aGUgLS1zaG93LWRlc2NyaXB0aW9uIG9wdGlvbi4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IG5ndXllbiB2YW4gaGlldSA8aGlldTIubmd1eWVudmFuQHRvc2hpYmEuY28u
anA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFNhbmdvcnJpbiA8ZGFuaWVsLnNhbmdvcnJp
bkB0b3NoaWJhLmNvLmpwPg0KPiANCj4gTG9va3MgbGlrZSBhbGwgdGhlIG5ldyBkZXNjcmlwdGlv
bnMgd2VyZSBjb3BpZWQgZnJvbSBNSVRSRS4NCj4gDQo+IFJldmlld2VkLWJ5OiBDaGVuLVl1IFRz
YWkgKE1veGEpIDx3ZW5zQGNzaWUub3JnPg0KDQpJcyB0aGVyZSBhIHByb2JsZW0gd2l0aCB0aGF0
Pw0KVGhlIE1JVFJFIGxpY2Vuc2UgaXMgaW5jbHVkZWQgaW4gdGhlIENPUFlJTkcgZmlsZSBhcyBm
YXIgYXMgSSBrbm93Lg0KDQpUaGFua3MsDQpEYW5pZWwNCg0KDQoNCg0K

--IRlazmqJqwVgkqJ7hgd5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5572): https://lists.cip-project.org/g/cip-dev/message=
/5572
Mute This Topic: https://lists.cip-project.org/mt/77073076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IRlazmqJqwVgkqJ7hgd5--
