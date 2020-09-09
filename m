Return-Path: <SRS0=Q4PZ=CS=lists.cip-project.org=bounce+64572+5438+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDAAC43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 20:12:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BAA2145D
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MMJ4xqNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BAA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5438+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id o3FYYY4521723x3tY08xiMNX; Wed, 09 Sep 2020 13:12:07 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.5692.1599682324854727456
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2020 13:12:06 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 089KBob1030044; Thu, 10 Sep 2020 05:11:50 +0900
X-Iguazu-Qid: 2wGrPVRPQn6DJlG0B6
X-Iguazu-QSIG: v=2; s=0; t=1599682309; q=2wGrPVRPQn6DJlG0B6; m=gpSAhzDkkgZkOx+Ya3HNkfKRGBrV/+UwphvSgiHtB7A=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 089KBlNV005163;
	Thu, 10 Sep 2020 05:11:48 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 089KBli9001523;
	Thu, 10 Sep 2020 05:11:47 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 089KBlT3009039;
	Thu, 10 Sep 2020 05:11:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJKbey33FWIh27I92zq8niMjIWBQiiNgbnEcjSecWW916XyGkTGf2Xwhcr/8Vt7mxtS7PfzBoT2iAYhxZuLg4v/4ReumyH/gz3GyaTnGQttbTMz5xar68WaL3yaHLboZ2rfT0ce4FK8JxsqbmDP+2w/d7qsdLcM+uxKPghE8PZXB4+2K53G7n6D/m9+nV1Yj0oeU3K2v0T4Megprd8fsODjkgUX4Q1TlInvUClFiu9J6XrzkQ4FxVPbLRgbhNATorEKwIbJ7lDgVdNDoQuonYTbCWwY9OOjoOT6xHedOzK866a1Hf6sjZJRrZOFLgVwZ8K3e0Ia8LuNAaTAK4txknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ls2i/FZcIxVZIj9nbb1SlholzK3iXe6CdgO9VBAdu4=;
 b=GVuNzdKHsIWCljxRQ8RP9NhxnDzHEOSD5bWmAD2jgdf+WAriVWa9tz4a6koMwmN1k9bp3oASILCjpzQ8Mur8bKZ3Ia5ECRV1SxECOltHSpk/gK5fgVEaAuiqVzthClwk/jwE6XxEQc+7jBczylppMbs5c7lp3sOaWW/rzRzpRlvBZO3ScjYvZ6sbO4fgvDW4FiWAsMWRGRxF4KfnIFbjWR5wHTyVjWDiU0Qfjz0UO3LtAbjELgN8ad39Ys7I5eA3/KLysThV7kNP9YCHY531Rxyfb5QAtDYd4BQAgsrmAKlugJ6Z+mna+lzQH86iTaWVdOW2E5iPiQNo22M81QL9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>, <JohnsonCH.Chen@moxa.com>,
        <victor.yu@moxa.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/11] ti-cpufreq backport
Thread-Topic: [PATCH 4.4.y-cip 00/11] ti-cpufreq backport
Thread-Index: AQHWhmP9mzdXCAG2yESbW986/agnBKlf4eyAgADYo7A=
Date: Wed, 9 Sep 2020 20:11:43 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298372C4AE76864B13EB934292260@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200909044233.4115-1-wens@csie.org>
 <20200909070343.GF27139@duo.ucw.cz>
In-Reply-To: <20200909070343.GF27139@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4f1af5-c4d8-4a71-ef0f-08d854fc92e3
x-ms-traffictypediagnostic: OSBPR01MB3143:
x-microsoft-antispam-prvs: <OSBPR01MB3143C80C1E423BE8B44452A192260@OSBPR01MB3143.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U+f8XRsc9n+TojsF9Wo0U7MC5JoKlvNzkNSoZl9Ow+g/vYkk77qrA5AeTPMFxm4X5ajBpLBYTed0FeN2vWmTJY6E9DvIwqhp/QtYJ/Mmpj7v8XUr7XM3cUZ0NzVl5z0ZOCcQFnKqp2Vp4m0H83S53M12O8Btq1/xERmm/2roa4k6mFUNjN8M9oFVmzBTYi/qaTf6M9FJPaEpnr7b2bdpyNQ6rpqwlZ63fZVrKnNgoVTmgjokWIvfCL4pl5wE0rBgSNn7ghoupJbj2/kjU7UWem2EBXncUY3cytC/Vm4LM2TkRE+fZV60ymtxDTOFVuGht99vnfdARVlhWOVZjx0A2A==
x-ms-exchange-antispam-messagedata: Sz7EPO/broi5kX+Os0mOJfbidjXb8Z9JS8tVW04SfwGipomTb4KoLNoOD1EZTQKh3/BIpDhDT3q0OjP0LJdFiheufpYLoHWVOUSaDxZTQb074CZG5ckdFh9cvYp7Y2yEOHOq8hK1EUOz5w2vQW/tZokA4j47ui4rzBRV6dLhcizf9MyxfrlaNKPbY1NSo02FqW8ma6RjEA3RkN4c06s+mIaz9ybP6YpAJTU5bFbBH9XuN+mEwFXfjdkzuyj8wWY9hWOrekjOOiXRpfdM9DYcs5+na44PtLMBTDcx6R59FYpDI5nwjv/X9tKJtGZSW4vhfmXD4rUsunLUpwy7dwW00QfaN/3ywjmkpwLiMT7vsw9Nj33wMAbcSNeb7MFtGFw4FF15g+STL7DJ2RbrofDcmehr9hwqE6mQJvX++W2LjJ4ElhFxoojmgFGlFYGHcniEU6mNpX+pBDcNazK9R4m/QaJiAvS8O6CKk7DvpcsYqITE/KULMQ9Yz3CYNg9ZbKaS16+BKbqx4nq4UKnMarErmYmW3eMT+JQUEb7TRsmPPNOUQVqcloQ0pgCAFb0yHyZxFzK6AwENmcI+FR4bP+B+ODmaOdeFBSIG1CR/eE2n56zSr+8aqmiv6H0B7f/aB2gXvusRenz0VxAExa9JIDemoA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4f1af5-c4d8-4a71-ef0f-08d854fc92e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 20:11:44.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxAnwyI/WEu/h8hFFw/tI9MPFqQfxJ4Kup8Sld4Tpw0wnzK/M7KBTcDsYptMCZtxj6KQyNOA9k4okiJmXj8RBbKarv8oxpDtRgxpauT7jvFrwGJiJ7gZ4KeUwkFcFEz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3143
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SZ0WnxV4vMqR415l1etC4OuYx4520388AA=
Content-Type: multipart/mixed; boundary="UsOCxF4J5d4Dt26XnjXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599682327;
 bh=u3XKERcjP+/yM6lk35qP3sgHhKfdMXrQxV+kdUWK9E0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=MMJ4xqNPxYONecsnqrdSg1fdz+lEMBoXL6C+C8SLhYmbgQga/tMy1m+V8H1Ir2IZjOQ
 PeJp2UzXyjBP6IRPybo8Iw2TO9AjA0zJCjDojGIcPurwwrg0FntDfbZ0bF5OKFTbMiG64
 MpiIWB/G7pRniaLKcU80B5MHKa2Ge5VCo2E=

--UsOCxF4J5d4Dt26XnjXG
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgOSwg
MjAyMCA0OjA0IFBNDQo+IFRvOiBDaGVuLVl1IFRzYWkgKE1veGEpIDx3ZW5zQGNzaWUub3JnPg0K
PiBDYzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHv
vKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHBhdmVsQGRlbnguZGU7
DQo+IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBKb2huc29uQ0guQ2hlbkBtb3hhLmNv
bTsgdmljdG9yLnl1QG1veGEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC40LnktY2lwIDAw
LzExXSB0aS1jcHVmcmVxIGJhY2twb3J0DQo+IA0KPiBIaSENCj4gDQo+ID4gVGhpcyBpcyB0aGUg
ZmluYWwgcGFydCBvZiBNT1hBJ3MgUE0gLyBPUFAgLyB0aS1jcHVmcmVxIGJhY2twb3J0IHNlcmll
cy4NCj4gPiBQYXJ0IDIsIHdoaWNoIGNvbnNpc3RlZCBvZiBPUFAgLyBjcHVmcmVxLWR0IGNsZWFu
dXBzLCBpcyBhYmFuZG9uZWQgaW4NCj4gPiBmYXZvciBvZiBkaXJlY3RseSBiYWNrcG9ydGluZyB0
aGUgdGktY3B1ZnJlcSBkcml2ZXIuDQo+ID4NCj4gPiBUaGlzIHBhcnQgaW5jbHVkZXMgYSBjb3Vw
bGUgb2YgcGF0Y2hlcyB0byB0aGUgUE0gLyBPUFAgc3Vic3lzdGVtIHRvDQo+ID4gZXhwb3NlIHJl
cXVpcmVkIEFQSXMsIGFuZCBkZWFsIHdpdGggdGhlIHYxL3YyIG1peGVkIE9QUCB0YWJsZSB1c2Vk
DQo+ID4gYnkgYW0zM3h4LiBUaGUgcmVzdCBhcmUgdGhlIGJhY2twb3J0IG9mIHRoZSB0aS1jcHVm
cmVxIGRyaXZlciwgYW5kDQo+ID4gZml4ZXMgZm9yIHRoaXMgZHJpdmVyLiBUaGUgZml4ZXMgd2Vy
ZSByZXF1ZXN0ZWQgYnkgQ0lQIGtlcm5lbA0KPiA+IG1haW50YWluZXJzIGFzIHBhcnQgb2YgTU9Y
QSdzIHByZXZpb3VzIGF0dGVtcHQgdG8gYmFja3BvcnQgdGktY3B1ZnJlcS4NCj4gPiBUaGV5IGFy
ZSBpbmNsdWRlZCBhcyBzZXBhcmF0ZSBwYXRjaGVzLCBhcyB0aGVyZSBhcmUgcXVpdGUgYSBmZXcg
b2YgdGhlbQ0KPiA+IHNwcmVhZCBvdmVyIG11bHRpcGxlIGtlcm5lbCByZWxlYXNlcy4NCj4gPg0K
PiA+IFRoZSByZXN1bHQgaXMgdGhhdCBteSBCZWFnbGVCb25lIEJsYWNrIGNhbiBydW4gYXQgaGln
aGVyIHNwZWVkcyB0aGFuDQo+ID4gd2l0aG91dCB0aGUgdGktY3B1ZnJlcSBkcml2ZXIgZHVlIHRv
IGhhdmluZyBhIGJldHRlciBzaWxpY29uDQo+ID4gcmV2aXNpb24uDQo+IA0KPiBUaGUgc2VyaWVz
IGxvb2tzIGdvb2QgdG8gbWUuIEkgY2FuIGFwcGx5IGl0IGlmIGl0IHBhc3NlcyB0ZXN0aW5nIGFu
ZA0KPiB0aGVyZSBhcmUgbm8gb3RoZXIgY29tbWVudHMuDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGxv
b2tzIGdvb2QgdG8gbWUgdG9vLg0KU28sIEkgYXBwbGllZCBhbmQgcHVzaGVkLg0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGly
bw0K

--UsOCxF4J5d4Dt26XnjXG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5438): https://lists.cip-project.org/g/cip-dev/message=
/5438
Mute This Topic: https://lists.cip-project.org/mt/76726426/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UsOCxF4J5d4Dt26XnjXG--
