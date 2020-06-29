Return-Path: <SRS0=F2CV=AK=lists.cip-project.org=bounce+64572+4846+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B6C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 06:06:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D9A23134
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 06:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AZ/4iFZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D9A23134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4846+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2QqiYY4521723xcmYiHCP0ke; Sun, 28 Jun 2020 23:06:19 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.12896.1593410776387719438
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jun 2020 23:06:18 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 05T66ESb002198; Mon, 29 Jun 2020 15:06:14 +0900
X-Iguazu-Qid: 34trJzXMXOFoMijsq5
X-Iguazu-QSIG: v=2; s=0; t=1593410773; q=34trJzXMXOFoMijsq5; m=tvMTwR5Xi2TbZlCsLieL29qqN+oyunTyX96vPdNrwbU=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 05T66DgC023530;
	Mon, 29 Jun 2020 15:06:13 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 05T66CSI014400;
	Mon, 29 Jun 2020 15:06:12 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 05T66Cj1001774;
	Mon, 29 Jun 2020 15:06:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0GxBM7QzUgM+/PM9rydnY1Hy7aJOirO1Kjri+XKFJQmUSBRrgO+plY6yupL4Y+EM3Jm0/GEXiYh0hxDpkOd7VqYvM92OVu1FE/vpMC6l9ZcqYXRrKBcRwzYYjuWhPL+ZuPdp53DdGx0TLmgGsOKHTGrzU5VWqQeBplyKl+9L0nfrJ5IRZXohLfp67ZZbwEhNdm6SX2Ip8vhu+Cr1yppvTS3/nHppIPpRu+GbSkCttkNvthlrQvUXTCCBubI/BwB6jJgptgwVf3hZuaNJaP1YIudTXFksShRtq0uTv2QE/P0g+f2gqtPD2EPDaulNYOIVeo5HC5gW70nywIYveQi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXgv9MClzgSYmsHF/uYnVWeogkcnTAOHvmr6xqOm/5o=;
 b=dZhQqBbS4/QavO4+QB3r4KCDwvCAStl3OuHtVssfG3zHdHp6Nhr9rFkNP469eq+df80T/eGV76I5uMvqPAaPLUCI/fqcS7f5yvvyV2PeBIn4GvBWN7flxURlZWJuONhlGV/skJ59N39HrR2BrdHEHmQ0loyM2HlqqExlgy8vSTzCoHkR+cwjU1TKVkKuG5hZLWDSshLqojopHZKZt35bPcAdMin1GlgL4Z+JqLVAO24bzV8ZtKfbGZyftKXi8FjkSIfKmthBmvDzLGFV6uVFBmlURK9ZcyWOpk0uhnoJsJTh6+BeYM6saaZrvIiMcincwXGaJ0A16eCOe59bZuv4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Jan.Kiszka@siemens.com>
Subject: Re: [cip-dev] [cip-kernel-config PATCH] ipc227e: Add missing options to mount fat
Thread-Topic: [cip-dev] [cip-kernel-config PATCH] ipc227e: Add missing options
 to mount fat
Thread-Index: AQHWSvPWr8RyB/ow4U2tkBbot9sqfajvILEA
Date: Mon, 29 Jun 2020 06:06:10 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983BAAF5FE099BFC28994E6926E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200625132325.16774-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625132325.16774-1-Quirin.Gylstorff@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1616e1c0-09ea-4876-ba88-08d81bf28580
x-ms-traffictypediagnostic: OSBPR01MB2072:
x-microsoft-antispam-prvs: <OSBPR01MB2072E35129810A1F1166C04D926E0@OSBPR01MB2072.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:12;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwyyGNZaUbm4/TRt1b9eoOh1nfy1RX9IH08brP8jIM66Y2VHq0yp+UtGu5//3FNQpz3zHn1+RR0IS/N5L0S6NLTrcR12yDjoGSfuQWwff4zL9of8EiACN186cMcFgvr+xewESUoeBPFB5MzahGF7ok8NuXWu6haQsyQdH1+lgIcWAAHzJPuAjd5CxhCNhNfogt8q7yVbvXt+MoEc6gMrGjxnWMdJ+cAjufF//2EKgY7t1aiC79qzgbqB/lcZ+57KJ2tZF5sH9/bDt/HTunnhqxffQ7qTYaxR2FXCew7/BDvgIfoorfo3rQ6ztFMMfYCW
x-ms-exchange-antispam-messagedata: 8SBmEGKeFrsQ9CBXHksA8UfVr8HGmCDI0jmQxE42JKIWdVHGPkujE0PZ91GN0gRlQ38JXLp2KAs1cbjBr5QmpdF5LXwHAdyk29aTJM/qGVZcbEe5TBUlbSbBiY4KxzYU0kKgfIxsTFxYJeCeODrnLp6w/hNKcQeGmHfdiAu78sqZpb2In/rCf9aNTIbhlQQVVsPR/msXMN+TtGPB/UiQ6i7mD7Xezl7tm1VRQlLkD6iFQzyr0U+fbgTUDtNVgHRj9VsH04w0WRRPQxHqsmEoChWwFIk0Tag8RCZKaeHauH6B4llKFaV6CmbJAu4zLQI7yqNUbqq8xgQdr3cXs4w4vkw57IEbGZNa6BqjOtcj1zrEq3qRxPQukwE9HrlJ16RXk4bWYxT9diXFFqnKOY0MvSyVsddmMUbjosoOrmtGC82dV0HZdDdyXQmc1iP6xUfCw+f9IuSd6M3Q1J8gr8reL+JTXPQlMFWG/7kZXQg53TQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1616e1c0-09ea-4876-ba88-08d81bf28580
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 06:06:10.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QurMtSpa5ZNthEVYGOK+3GFjKzuiZPgRKIguPmA3Vtw6utd5NwBewgnyavb0bGRcQkFPF/HB2pmACoLuWw/GxwC92Ndhv0V1Y/69QAouTeb6FYRV/u1jcLK96+9bjIxG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2072
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fcudNXFm7ofSCUfQswT1YkT6x4520388AA=
Content-Type: multipart/mixed; boundary="sHeYU8VSOhG5NAV2w4OL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593410779;
 bh=BvWXWozmdQgV2ABW1yVgDLEuuaxRK9wGPYRHuZh+kec=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AZ/4iFZsXkByjDWHZcdZaDl9hMoVvWOMM/afwd6RWaEe3bmOqFLb7PgfC78M6zfEIM1
 WBHnpfxHdxtoR/mgMEz6p90XrvAsuFesv7J5CzaPkuzaeBIH52fvfxd4MJSKDsdWvwpXq
 EcOdm7Goog2lglSpCPDuKGSd1+RrSgs7Z/A=

--sHeYU8VSOhG5NAV2w4OL
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYNCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjUs
IDIwMjAgMTA6MjMgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBKYW4u
S2lzemthQHNpZW1lbnMuY29tDQo+IENjOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3Rv
cmZmQHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW2NpcC1rZXJuZWwtY29uZmln
IFBBVENIXSBpcGMyMjdlOiBBZGQgbWlzc2luZyBvcHRpb25zIHRvIG1vdW50IGZhdA0KPiANCj4g
RnJvbTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4g
DQo+IFRvIGluc3RhbGwgYSBzd3VwZGF0ZSBwYWNrYWdlIGludG8gYSBzeXN0ZW0gd2l0aCBhIEEv
QiBwYXJ0aXRpb24NCj4gc2NoZW1lIGFuZCBFRkkgaXQgaXMgbmVjZXNzYXJ5IHRvIGFjY2VzcyBh
IEZBVCBwYXJ0aXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxx
dWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gIDQuMTkueS1jaXAveDg2L3Np
ZW1lbnNfaXBjMjI3ZV9kZWZjb25maWcgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCg0KQXBwbGllZCwgdGhhbmtzLg0KDQpOb2J1aGlybw0KDQoNCj4gDQo+IGRp
ZmYgLS1naXQgYS80LjE5LnktY2lwL3g4Ni9zaWVtZW5zX2lwYzIyN2VfZGVmY29uZmlnIGIvNC4x
OS55LWNpcC94ODYvc2llbWVuc19pcGMyMjdlX2RlZmNvbmZpZw0KPiBpbmRleCAwYmJkNjQ5Li4y
NzNkMjBlIDEwMDY0NA0KPiAtLS0gYS80LjE5LnktY2lwL3g4Ni9zaWVtZW5zX2lwYzIyN2VfZGVm
Y29uZmlnDQo+ICsrKyBiLzQuMTkueS1jaXAveDg2L3NpZW1lbnNfaXBjMjI3ZV9kZWZjb25maWcN
Cj4gQEAgLTQwNCw2ICs0MDQsMTAgQEAgQ09ORklHX05GU0Q9eQ0KPiAgQ09ORklHX05GU0RfVjNf
QUNMPXkNCj4gIENPTkZJR19ORlNEX1Y0PXkNCj4gIENPTkZJR19OTFNfREVGQVVMVD0idXRmOCIN
Cj4gK0NPTkZJR19OTFNfQVNDSUk9eQ0KPiArQ09ORklHX05MU19DT0RFUEFHRV80Mzc9eQ0KPiAr
Q09ORklHX05MU19JU084ODU5XzE9eQ0KPiArQ09ORklHX05MU19VVEY4PXkNCj4gIENPTkZJR19Q
RVJTSVNURU5UX0tFWVJJTkdTPXkNCj4gIENPTkZJR19FTkNSWVBURURfS0VZUz1tDQo+ICBDT05G
SUdfU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1Q9eQ0KPiAtLQ0KPiAyLjIwLjENCg0K

--sHeYU8VSOhG5NAV2w4OL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4846): https://lists.cip-project.org/g/cip-dev/message=
/4846
Mute This Topic: https://lists.cip-project.org/mt/75102506/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sHeYU8VSOhG5NAV2w4OL--
