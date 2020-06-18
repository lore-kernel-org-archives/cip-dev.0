Return-Path: <SRS0=95QP=77=lists.cip-project.org=bounce+64572+4803+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2878C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:19:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625C321BE5
	for <cip-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IhTkGlin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625C321BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4803+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id B0oFYY4521723xop4WUPR7PU; Thu, 18 Jun 2020 00:19:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.2301.1592464759327550781
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2020 00:19:20 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 05I7JGIk016658; Thu, 18 Jun 2020 16:19:17 +0900
X-Iguazu-Qid: 2wHHD3mJ146bMeDK4Z
X-Iguazu-QSIG: v=2; s=0; t=1592464756; q=2wHHD3mJ146bMeDK4Z; m=PecknfiEgEq7VMNdI016KrxB9sYPcC2pLLTLNn/IcSk=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 05I7JFHE001745;
	Thu, 18 Jun 2020 16:19:16 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 05I7JFLU016965
	for <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2020 16:19:15 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 05I7JF9c010493
	for <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2020 16:19:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLKc4wVW0+XZy5bARB0a77GsiT1Amdar5+cuO9gjSIq6FkI8s8kvxY38ILII3q3uBLRQPI6C6TGQuVrjk0oknxk7YdzPRv99CE/z5OpuqaZCbP3wIw5n/jGJsjQ+kguCoDcjqCODTcxkhpg5kDRVV/XK9uAhipzCKPsdYroMCxCejQWYSwe0vMQMSSq1akdaKPUkDWX10mF2YIS8KNIv9HBduj2chQTbpIZC6OKYlyN3lrp9ttpbIoImJ1fi8jaraUjU3LIqXBq/kIM03oOV4XtJykMWK+SfClMinFEoQoTxOcq0zvwAZR9rE+ce6LIL5rVDUkZPX5p1FAHcg5U/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njArNiV3/HmyEeJ/WxT1upAFASWCU3nD2WhLX6aNLTI=;
 b=BfHP7xV0bknhTHXR0E3wlh2cD8caayG8I6FFGm2S5R/X9hij+bhGp/Lr3EsWowslSBSYm5uYRUDer3ntmfiOZBtG+H36R0QOFUQkXqPY4AOUT5TIO4sgyBJ/shah0OAH+eEvsBHXKjr0XLIsSYVZhzKLdkLKhQZ1EYsc9EyPIsSGcBWa1Hj55NTqY8wrCkuYbcwCBYVqbxwTlUEvgBb/bmEpPutcCNik4g0JRWgBC5rNg28FUecrQ+2LNs227vrx2p1H/EcH3l5tyBficvh6wpLKrtQCl6CXyJRtiDhZwIuKH/AerJak0mDKtcTzjWuORnXumagGEVhqX9D1oNkNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZFBivWuOLGgeYmT9uB8s67CZkn1wAOfFlQ
Date: Thu, 18 Jun 2020 07:19:12 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E460267AF655E16E83FD929B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972E56562DC57F5B8298721A09B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71dfa93f-f27f-4efe-1e9e-08d81357e6e9
x-ms-traffictypediagnostic: OSBPR01MB4168:
x-microsoft-antispam-prvs: <OSBPR01MB416802356CA06C5F307513C0929B0@OSBPR01MB4168.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pPw+YFAown/l6R1i9Ld2zUomgzr77lGlkhO0WYQQcI7Xf7DozojF9Mi/tDtZZhhHboePe+4ppmRZfcu+Swtn2Df1eJ9kpp+Ry8zid2lIzMdEy00PKamIhATsX3lXzw3C9lnRPlfLZ0Ye0Roo37hGwAN7dsLmPkBL/MOkxcglYU2MNJLs0OFpIOiym4Hx5u5UlYnV73O+CWuEWJTF6as6TKDthcBh5+6Uk1HnFf9ARL+5tQdqiKH7AfVsjGlIthzmoFsNcba8PviZ3ivuOG5VOCzuitjyqlKkEgCTdzxCbT7YmhDRqpgv+IRt3pkVTFZwpalV20XZ63NYV8paUx6ZalPfJnSTaDgHC16ZWi3TUilRL+sd85mx2KQbPa2ANpKtCXhJ5dpUnin2ol8Q/wgI/w==
x-ms-exchange-antispam-messagedata: rewl5jCdyecmH7gbEUJzad1n8H6picHWRL+F/1WnwEto8xqaid/gyLmryum/HLVO3Mg5T5uqm8RKv5cosI4GDRcHtZz2Vw2daUpFtLdYln+si/BJ/4WyAS7rc9wEmoNzxuW8LU49KONinvQX/NQHCW+SaTy5ZpdKoM9hiKM61YuN+Q78spaB+k1/KmlP03i7I2W1dmeLufucS4namwR+2Bkc3L7nEVlt/Cr5uVKwkQW7IfKxcJgVKho0GwxG0VgS4yGEcnXRUUF5hnPF0YKc/4AgPaltPvoBDBtGxyx1fmB6Md+Fez74hwwSsmehZOLWZvfqe/k89hDnmzpHUKMnzQ1Q9Fp9jhyy05vXZuL52BExgaJekFHGdi1mUumeE69GolUOtHgPLHw+YtJRn/74I5pvcaskUEsTckFchyTIvS9eCrcWUOI1o+/7Y+vQibIqO+NQn5BjzDZnvoxZqZDnwARph34jbo+vFX17TozyfBQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dfa93f-f27f-4efe-1e9e-08d81357e6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 07:19:12.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CU2ilUf7rLsaDcmm9eVURfbpt5VKblcAO6U6GCOmwh3zxehyxPnSnpSY9u5681BD1Us7gAYCfrwGhHbz9r8NRjZO706vMrJQvyqsOUywZ3YAydcm/v0sXkfnfLqDmTgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4168
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Q2ZPET5o5wag4xwYNfRwkjEJx4520388AA=
Content-Type: multipart/mixed; boundary="j9mCxENG3dNM8770O4O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592464761;
 bh=Otq9K3cdrRtE93VD0Tt2S1H4Wimxg6o9TW6UUe1ACvI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IhTkGlinHmxZGtOrTn580x08C+7rAwb2A749mMAnfWjT0GRv43Tm3N2E/2cM/pt3GiD
 dBvoKOKsxxQCSN54OhRr211Y58H9RFTCoLsyGmQd+DjIoGdAtM4FZTE/eH5Ilo+rtdxu3
 C+mLCaRUXWx6HN4DHFnVbbxgrNYvnjKntbY=

--j9mCxENG3dNM8770O4O4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgY2FuIG5vdCBhdHRlbmQgSVJDIG1lZXRpbmcgdG9kYXksIHNvcnJ5Lg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBP
Zg0KPiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAxOCwgMjAyMCA5OjIwIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
PiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheQ0KPiANCj4g
SGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1l
ZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtl
cm5lbCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3YXMg
cmVzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAwIHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IHdl
ZWsgb2YgQXByLiBhY2NvcmRpbmcNCj4gdG8gVFNDIG1lZXRpbmcqDQo+IGh0dHBzOi8vd3d3LnRp
bWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIwJm1v
bnRoPTYmZGF5PTE4JmhvdXI9OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3OSZwMz0xMzYm
cDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiAw
MjowMAkwNTowMAkxMDowMAkxMTowMAkxNzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBp
cmM6Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVz
Og0KPiBodHRwczovL2lyY2xvZ3MuYmFzZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIwLzA2L2Np
cC4yMDIwLTA2LTExLTA5LjAwLmxvZy5odG1sDQo+IA0KPiBBZ2VuZGE6DQo+IA0KPiAqIEFjdGlv
biBpdGVtDQo+ICAgMS4gQ29tYmluZSByb290IGZpbGVzeXN0ZW0gd2l0aCBrc2VsZnRlc3QgYmlu
YXJ5IC0gaXdhbWF0c3UNCg0KTm8gdXBkYXRlLg0KDQo+ICAgMi4gUG9zdCBMVFAgcmVzdWx0cyB0
byBLZXJuZWxDSSAtIHBhdGVyc29uYw0KPiAgIDMuIEFzayBib2FyZCBvd25lcnMgdG8gcmV2aWV3
IHJlZmVyZW5jZSBwbGF0Zm9ybSBjb25maWdzIHRvIG9wdGltaXplIGJhY2twb3J0aW5nIC0gbWFz
YXNoaTkxMA0KPiAgIDQuIENoZWNrIENWRSBhbmQgUGF0Y2gsIEJsdWV0b290aCBCQUlTIGF0dGFj
ayAoQ1ZFLTIwMjAtMTAxMzUpIC0gaXdhbWF0c3UNCg0KTm8gdXBkYXRlLg0KTm8gdXBkYXRlICAv
IHdvcmsgY2FuIGJlIHNlZW4gZXZlbiBpbiBVcHN0cmVhbSBldGMuDQoNCj4gICA1LiBJc3N1ZXMg
dG8gYmUgZml4ZWQgZm9yIHN3dXBkYXRlICJjb3B5cmlnaHQgY29ycmVjdGlvbiBhbmQgc2Fsc2Eg
Q0kgdGVzdGluZyIgLSBpd2FtYXRzdQ0KPiANCj4gTm90ZTogVGhlIGZvbGxvd2luZ3MgYXJlIDIw
MjAgS2VybmVsIFRlYW0gUm9hZG1hcCBzdHVmZi4gSWYgdGhlcmUgYXJlIGFueSBwcm9ncmVzc2Vz
IEkgd2lsbCByZXBvcnQgYXQgdGhlICJLZXJuZWwNCj4gbWFpbnRlbmFuY2UgdXBkYXRlcyIgaW4g
ZnV0dXJlLg0KPiAgICsuIFN0cmVuZ3RoZW4gc3VzdGFpbmFibGUgcHJvY2VzcyB0byBiYWNrcG9y
dCBwYXRjaGVzIGZyb20gTWFpbmxpbmUvTFRTIC0gS2VybmVsIFRlYW0NCj4gICArLiBVcGxvYWQg
YSBndWlkZWxpbmUgZm9yIHJlZmVyZW5jZSBoYXJkd2FyZSBwbGF0Zm9ybSBhZGRpdGlvbiAtIG1h
c2FzaGk5MTANCj4gDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSByZXZpZXdl
ZCBMVFMtcmMuIEkgc2VuZCBhIGNvbW1lbnQuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIFNv
ZnR3YXJlIHVwZGF0ZQ0KPiAqIENJUCBTZWN1cml0eQ0KPiAqIEFPQg0KPiANCj4gVGhlIG1lZXRp
bmcgd2lsbCB0YWtlIDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhv
dXIgaWYgaXQgbWFrZXMgc2Vuc2UgYW5kIHRob3NlIGludm9sdmVkIGluIHRoZSB0b3BpY3MNCj4g
Y2FuIHN0YXkuIE90aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUgdGFrZW4gb2ZmbGluZSBvciBp
biB0aGUgbmV4dCBtZWV0aW5nLg0KPiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+
IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTS4gS3Vkbw0KPiBDeWJlcnRydXN0IEphcGFuIENvLiwg
THRkLg0K

--j9mCxENG3dNM8770O4O4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4803): https://lists.cip-project.org/g/cip-dev/message=
/4803
Mute This Topic: https://lists.cip-project.org/mt/74949757/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j9mCxENG3dNM8770O4O4--
