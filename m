Return-Path: <SRS0=YZnL=EC=lists.cip-project.org=bounce+64572+5682+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C3C388F9
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 21:25:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC45207E8
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KBVmavB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC45207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5682+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RHgHYY4521723xTsM0dT5j6z; Tue, 27 Oct 2020 14:25:42 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.4058.1603833940154085190
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 14:25:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 09RLPUMU018985; Wed, 28 Oct 2020 06:25:30 +0900
X-Iguazu-Qid: 2wHHLH0PmKTMIScP5M
X-Iguazu-QSIG: v=2; s=0; t=1603833930; q=2wHHLH0PmKTMIScP5M; m=QMtNfYRg4veaO/XJS+EjYnt8BgoBQATLRL45HPdbnXs=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 09RLPSL1016796;
	Wed, 28 Oct 2020 06:25:29 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 09RLPSkn017895;
	Wed, 28 Oct 2020 06:25:28 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 09RLPSGE003486;
	Wed, 28 Oct 2020 06:25:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic9hurxIcLD0DO7SsaLN7MU9fRcHXp/kGYheb+3ekM6dqlcJXyYkOYx8Fjm54w+J45/pyZYl1BiHc8LJ9/ruf6A2a3H/xJJDijIvedSNLsHX84oNgbM7L2bSdRnJXBPjQC6N2l2nRO0Jmk5vG0VBHYBEUpZveWKJnhl+A8v1j3BaM1g32WqXa0ZtuTVCWqSkLNIAEE5ibTV0On3xyAy+IBadRAEKtC1PiOgAoc9FxhzoWJR+uJNvTZZQrgnzQwRQtN/A8so0RTx9AHu9MbMefmjcPYp745dVmpDogEmZ9gUt86izhPlQu1pVKURB+IiIEqM2Nu6kbWaY+MWZxWO5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B5ymKJ6rswUz5MEKTPMJwyC21x6O11eP33o709fdSk=;
 b=UarhnddmWgQTYaSOkqUFPhvxHiI3yuSmK6ikWKndRR6F4OwTv1zCpkYX0mNrRbw82ODZcSvkoyCLLfoQtwdyXhQ30xjU6141DhQ11HPLqTxwwta2DY40dmy326EmtMisX/kDkJz+LnZDmgXSdcC/veYIEckaM7h+LSyeJSTsJFl/9MczqLkwfs8yn2+75yXxdXxxVOc/46nhQGjlROL74GMRzFSSz0k1evHm88hAtXuz9QKN+OFeptLxktoLV8p7F5OHccrWkzgUpWwaejzTPIZ83QGT3YspBixjM0zscaMx5vwtwmIIAWWsassA11Xq6xovRkCKVXvogyrgqLWsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Topic: [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Thread-Index: AQHWrIIjEZJU4dKxlUSorKTY6uSpvqmr9NsA
Date: Tue, 27 Oct 2020 21:25:17 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29834CF6CC78D3182436676292160@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85559ed8-b0d8-47fb-50ef-08d87abecd9f
x-ms-traffictypediagnostic: OSBPR01MB1685:
x-microsoft-antispam-prvs: <OSBPR01MB168544A1273CC299481720BB92160@OSBPR01MB1685.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qLipQxqpJPzxRRMQU+cZ6YMx3dbgGiraeGZf6pt8EVCoiz0us9BFVCUtOwpqSFAXzdNVMb9ZPz1FOP4hIFTPnw0YAFxUbZ2LOk3kCvxP6gDsrVHcLxpnDFN3iO71t/RT9pCjmUOx7eofptKYWHYeRN/bc1Pu52NRyiPz1nY2t3tXS7gR9tfzkXNrgy5VAO1y2bru+Ql66EgfhDrvvkOs4hP2vEonqUU0nnnaUwuJzifilo9rJvP1noyAI5m8peTa04wl1r2mPt6DYrVREn/DAMM1KWBbSCyUHS8EsDl8/Of7a55n7KaeM+Sk7oPZgx9hNGnLL7vJ0YoO/vvq+lJWMD8GVYGsprB0bBfosgNIDrxC0caWRrhMLYKwSf5nYrt39rgt2KRYtq3mfhpUUUIFpA==
x-ms-exchange-antispam-messagedata: uRkIFquHH883nj07gcibex0LQk6d/qtD35+vEyzpsGev4TnUU0CW/wrrnEBLe8o0nqQJAK8kKyycseEmGlLn++L/i/tXGMG7dh76pSSAj0i7IcO1WfIQ4rSyIXG3X+nK1R29VGuaba016tLsLoHZsm6IzVoz5lNGJqnqgg1wS9by/y/iv5FZFDWeDf9ZbduaC/3vbvunCerqKlptDND+zZ7oZ49+GQI+MU5aPJA6U5XBp1ONbuP6Xn2y35rgxa+jl/14mkdwTw3kOvuG86lD9//za62g8KgTlqFfc2FDbdMkckhYwD9keviIEuGuhCgesCOdh/Gkolg83yOOdOHDBEJXjgavl2KldtLZ72WNrg7PPZ4dom8DcYTt6IbrHAwHOOXMF9MDt2obNOaavBuhFqBV0rVYK55GIoj6MpJyAHiR8IevMXMmpDJPU9mQJoFFFadX6nMzqVlvwiDEvRwtHcMYH9TgdRlqczo9VVmb3ga5XDt+wA9NUTJ1vcDp8nYXaTwwLuDk8LEIeXeTXuNLC2qYLHRZN2tGXKu8VsB2ls5j/0k2KOL2TtClNOw+dnFhEnuFth2p+1h4rGzTxCtb+vrhfodMOJvfC6e8pQvdyCn1URQRgo60bZdH1zCjgK6NRxRkvG//J6dwk3oq/qQQpA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85559ed8-b0d8-47fb-50ef-08d87abecd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 21:25:18.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1coPOYzQ7720qJuTaUDwmC3j3AQ9TlZNmRCUuoz2EBDbPSoywp05uZujS0WUGOd+kz19qoL2UhXchZAFkPHokDEdNEvqEH1qdly5Pg2xArVE8Qx3gMvaC484Wun/h0Xw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1685
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: maGws5dtK1RDgmtbg8gdHKyyx4520388AA=
Content-Type: multipart/mixed; boundary="2BhnmPdxf0FBsllcdT2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603833942;
 bh=JSQS96gBs05PuSV0wfTf4Y0Z0QqQxGa3802keq9vpVk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KBVmavB9DHYcPY0HagXg8HEJu1Nje/krSJFX5LmNOrt848Ubbj0+9VXQk2iq7LJOdRA
 NIJC7Vf8QAqkwfW5YUUwZOZ5ZgDtBHhWHG2YWYvkRH1bbqUyiFcGc3q0BPdX6lwOUac7p
 PIlvfH5Ec+qxbPwUXFMis/JLk/TRB2csJH4=

--2BhnmPdxf0FBsllcdT2N
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rcyBmb3IgeW91ciB3b3JrLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IExhZCBQcmFiaGFrYXIgW21haWx0bzpwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyOCwgMjAyMCAx
OjU2IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4N
Cj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDog
W1BBVENIIDQuMTkueS1jaXAgMC81XSBBZGQgUENJZSBFUCBub2RlcyB0byBSWi9HMntFTU59DQo+
IA0KPiBIaSBBbGwsDQo+IA0KPiBUaGVzZSBwYXRjaGVzIGFyZSBwYXJ0IG9mIFJGQyBzZXJpZXMg
WzFdICh7NDMtNDYsNDh9LzUwKSwNCj4gdGhlc2Ugd2VyZSBkcm9wcGVkIGVhcmxpZXIgYXMgdGhl
eSB3ZXJlbid0IHBhcnQgb2YgLXJjIHJlbGVhc2UNCj4gYXQgdGhlIHRpbWUgb2YgcG9zdGluZyBu
b3cgdGhhdCBwYXRjaGVzIGhhdmUgbGFuZGVkIGluIHY1LjEwLXJjMQ0KPiBJIGFtIHJlc2VuZGlu
ZyB0aGVtIHdpdGggbm9uLVJGQyB0YWcuDQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2NpcC1kZXYvDQo+ICAgICBsaXN0Lz9zZXJpZXM9MzYzMjc5JnN0YXRl
PSUyQSZhcmNoaXZlPWJvdGgNCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0KPiBMYWQg
UHJhYmhha2FyICg1KToNCj4gICBkdC1iaW5kaW5nczogcGNpOiByY2FyLXBjaS1lcDogRG9jdW1l
bnQgcjhhNzc0YTEgYW5kIHI4YTc3NGIxDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0
YzA6IEFkZCBQQ0llIEVQIG5vZGUNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRhMTog
QWRkIFBDSWUgRVAgbm9kZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRiMTogQWRk
IFBDSWUgRVAgbm9kZXMNCj4gICBtaXNjOiBwY2lfZW5kcG9pbnRfdGVzdDogQWRkIERldmljZSBJ
RCBmb3IgUlovRzJNIGFuZCBSWi9HMk4gUENJZQ0KPiAgICAgY29udHJvbGxlcnMNCg0KSSBoYXZl
IHJldmlld2VkIHRoaXMgcGF0Y2ggc2VyaWVzLiBUaGVyZSBzZWVtcyB0byBiZSBubyBwcm9ibGVt
Lg0KSSB3aWxsIGFwcGx5IHRoaXMgaWYgdGhlcmUgaXMgbm8gb3RoZXIgb3Bpbmlvbi4NCg0KQmVz
dCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL3JjYXItcGNpLWVwLnlhbWwgIHwgIDcgKysrLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9y
ZW5lc2FzL3I4YTc3NGExLmR0c2kgICAgIHwgMzggKysrKysrKysrKysrKysrKysrKw0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGIxLmR0c2kgICAgIHwgMzggKysrKysrKysr
KysrKysrKysrKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3I4YTc3NGMwLmR0c2kg
ICAgIHwgMTkgKysrKysrKysrKw0KPiAgZHJpdmVycy9taXNjL3BjaV9lbmRwb2ludF90ZXN0LmMg
ICAgICAgICAgICAgIHwgIDcgKysrLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMTcuMQ0KDQo=

--2BhnmPdxf0FBsllcdT2N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5682): https://lists.cip-project.org/g/cip-dev/message=
/5682
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2BhnmPdxf0FBsllcdT2N--
