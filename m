Return-Path: <SRS0=I3q5=EK=lists.cip-project.org=bounce+64572+5731+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A5C2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 00:42:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D162E223C7
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 00:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="G2J7tNHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D162E223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5731+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uyG8YY4521723x1ToDgOllA9; Tue, 03 Nov 2020 16:42:24 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.6369.1604450541792309710
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 16:42:23 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0A40gAjC023925; Wed, 4 Nov 2020 09:42:10 +0900
X-Iguazu-Qid: 2wHHmca9fXKVMBclz4
X-Iguazu-QSIG: v=2; s=0; t=1604450529; q=2wHHmca9fXKVMBclz4; m=+21Wn0dmUdJXdU68yIoCMgyfiBLK4R8U5J6vRLt1bV4=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 0A40g8sU016063;
	Wed, 4 Nov 2020 09:42:08 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0A40g8jk016881;
	Wed, 4 Nov 2020 09:42:08 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0A40g74p023881;
	Wed, 4 Nov 2020 09:42:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWvkWlP8wPL1cA9LLxvj95CtTT4ehCBOgicxdtvaiBiKu8/zPKy7R+GxDoU3hEFT7iTPpAk+59FNcTORfXlaWpsrrRyb6IfsOgvUHxCAnU4tb4LG+Sh4O4um77MxFnIdGe16v6u8+MS839YDB98QFiDRxLrJVzub1lQCt0ChVqN2Cjly3H1qgUPzSTyQ3FKHXu4Gbp/MvhanIlhEIxe5cxKVbWMfJOCwYKKsUMVwQAr7qAjWfErZeP4Zg7T1TpJx9OqKwo3uDw/cCsSDl2isETCjeg9IN00I8YL1bN0cD3/QXn0OVaut5JQYfo//5gkNb38taNaJ91VuENXE5fNagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZgSKYe+J2Gneh1vWOGRegqt5VYeaFOUsS7Fkg3Wn0w=;
 b=nHlv/SNoYrw+ftUhf21M0WdxIO92XFK2jlgSA1eu2vBg+BiQUn2TF7RM+pE31NNqaxrfFHn33MslL0QY1u8UfASM0Tu1Rz2mrQzUKemkI3Bg5vp9UN942sACaNnx4/cg3FJoKvQfGctSHa3JdzlDc508A44rIKoMN3vvKkgYTs5FWUiEldBJpqsi4KG/42gvc0DPXUT4lQi4kliVg91yffG9zqvSUSvUxdc38EaScYgVNibuVT7END8Y3r/QqCF8AQ6cySszGl8hFolMt6ZoEXDol6AwQxwrRRGXp2Z3v/1N3zx0AifFpf9DF7uqnVKj1Gfeb0a7H1ktYsUq6VnfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add PCIe{EP}/SATA support
Thread-Topic: [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add PCIe{EP}/SATA support
Thread-Index: AQHWsPoM1gPszC7nCECmEi6KVGZDiam0pKaAgAJ/0/A=
Date: Wed, 4 Nov 2020 00:42:04 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29836C35A943408A503624D792EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201102103119.GA6161@duo.ucw.cz>
In-Reply-To: <20201102103119.GA6161@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2c3a8ca-c9d2-4a24-c11f-08d8805a73bd
x-ms-traffictypediagnostic: OSBPR01MB4534:
x-microsoft-antispam-prvs: <OSBPR01MB4534DEBD19F248615374310F92EF0@OSBPR01MB4534.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0X2rkMAVCWBcyCqY1Fil8qAB0oUNW5OcLWpZZeGE5D1isKYYzv/8B5j+gALDb5wIHAiS9AHCjsBQUbKmRmakH081KNX69pfsTK/+EBQho4MD3/AsKY3TGoR/bnPJKBruRzWUdzf4UARD4BUMfBif9bds4Z3NVTI32wfUT8z2rIG2xpX1qiBqEkDrqcU0TRqROse/NNqyuLGeJ+DVxcP80qxHE1R7/e9h12aqmXfn32gUt4Fol5gIKVEcSm25SFkI/GsUSA2OBT7kp1uIaYGzTrGWW3ek4drCYgrHr4dQqFDskBFZQ7U7TXICyNGAjVH724Dxpb5VEU0XTIAKgPWuSg==
x-ms-exchange-antispam-messagedata: 6ifm9187NG/UJKNpOnYmWmuUXvKMoe93cFY9eYBIy2n95Qrm8EAZKESZadTyxPf4iusWb5LGIV25j3T5rBxsGSEYNjTsCXEdOZJzodOOoXOqkzY2PJGVQ0wrFlh8JcrNpDhr0jmrOMPhY8qJS6L3qi/+ZZFfHc9Ne9uFLR1p5H0pRkjbIuEVmUPb0pMConC0QpNgYR02Ew/A/BH6QZOg7gTiDxaxX8+oO1g9N2IuB/+Qb+hD10MmlCMIgu93vhu4dI25Qcj9oy6rl5B+SLCSeEdQC+d+dsbuBr1z5NcyZYnZmB4v0C+SHRttfL+799yIDlR3qQuZw8IULJ9HEmuK7Zyouct2rkizvZK4A/0IXG/q81KkXcC6TIwPwqU7FcmXpGVA+Bh7VEWag9bhROwGza8wRfD3ml0RI3r5o5SyPCMQIUfYGPA3iGumT6Lz7lHzPgZPnEd2rdW7n3VtpuQ3CRWXOtFERZ75m/KaowndpXjaMXk9d/ZzkpTgyn7KUXL1DI6fMtrEYWSgrG6aScUCOmX9svIUyrJeqyWNnVOkiBZMxerX1NY/oQ9INVA0lhA6JrTSShKZHnR4NbTbXPeGxnRPWhqcR8O+rC8ZIeB2fpT4qWWNwsB+rK5hlne38Tn3ao1gRva6sQRWgottrKns0Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c3a8ca-c9d2-4a24-c11f-08d8805a73bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 00:42:04.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq158nGrDy97nK8UtgNoNUe2nb452GLlFd2fiICKI4D5YOVcLdrGBwdQCr9AVj+aQz6kBQjfLYJ6f82xI70Nr9y8m1LzYyE27HAc6ht3ain8Wm8hdZqoS4jNiJEPmM0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4534
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: M4XOUwFc4cZ5NKv8HNv3QNGAx4520388AA=
Content-Type: multipart/mixed; boundary="LAVVld6oOFq8WUxOolWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604450544;
 bh=Yb6dDC/8znGqiG9ySvAuEyWEgVKbqxcuvYFPZaZImYM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=G2J7tNHtDwrUAiTCdCE2wd8xpsPu7TIXgX9//YUZS8l/9cT6TSa0ChVihSLk3QOBRn/
 OpHGdEPkOAuUdXOUsmonX941uefkQjligpOVvDd7yg6frlAWSxK5RD5XbF0VhsAk9emeQ
 E9MikWmDig/49TdYal8MlwNNQ1Dj4mmuZ6Y=

--LAVVld6oOFq8WUxOolWx
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyLCAyMDIw
IDc6MzEgUE0NCj4gVG86IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2Ft
YXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4g
PG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBk
ZW54LmRlPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDQuMTkueS1jaXAgMC82XSBSZW5lc2FzIFJaL0cySCBhZGQgUENJZXtFUH0v
U0FUQSBzdXBwb3J0DQo+IA0KPiBIaSENCj4gDQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBQ
Q0lle0VQfS9TQVRBIHN1cHBvcnQgdG8gUmVuZXNhcyBSWi9HMkguDQo+ID4NCj4gPiBBbGwgdGhl
IHBhdGNoZXMgaGF2ZSBiZWVuIGNoZXJyeS1waWNrZWQgZnJvbSBtYWlubGluZSBrZXJuZWwNCj4g
PiB2NS4xMC1yYzIuDQo+IA0KPiBMb29rcyBnb29kIGFuZCBwYXNzZXMgb3VyIHRlc3RzLiBJIGNh
biBhcHBseSBpdCBpZiB0aGVyZSBhcmUgbm8gb3RoZXINCj4gY29tbWVudHMuDQoNCkxvb2tzIGdv
b2QgdG8gbWUsIHRvby4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCj4gDQo+IC0tDQo+IERFTlggU29mdHdhcmUgRW5n
aW5lZXJpbmcgR21iSCwgICAgICBNYW5hZ2luZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuaw0KPiBI
UkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnpl
bGwsIEdlcm1hbnkNCg==

--LAVVld6oOFq8WUxOolWx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5731): https://lists.cip-project.org/g/cip-dev/message=
/5731
Mute This Topic: https://lists.cip-project.org/mt/77977469/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LAVVld6oOFq8WUxOolWx--
