Return-Path: <SRS0=I2QU=E5=lists.cip-project.org=bounce+64572+5834+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240ECC63798
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:05:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB22204FD
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 23:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ll0xH6np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB22204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5834+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rJGvYY4521723x6NTURjuqYP; Mon, 23 Nov 2020 15:05:44 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.109])
 by mx.groups.io with SMTP id smtpd.web10.43826.1606172744088188746
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 15:05:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HND9e8JOYDqsqphB6wb/aIvGxZmKQi6NJ1IUzTt808/cguS1ffmI7D6CmfmXcqukSlXi/HlTACulDLDegOMeAJoyaIMfaw3Q6MXMEW57mt0woggVaUvCpFeX1ocgIudPmfXLSb8B38M9R/SZ/FVXTxEoPnLYdl5n7RkJsL5NnjRiD3T4OIQg1G8vrd0NiItct4BnL2zy8vjWdP+7sNA8DS+ULyaUec12s9gFm7YwaazHMONhXSL6bYKWQEYJR4Li7LV39m2jzjQ0idL3Aj+wDLMVFgsrqKP85CZ30tsOr08Lvf6Hecwd+yWNc4+0xpyzXonoC5BiC39r0EGYl7lZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO7ZEC7h86HWY1X+aBuytQMPVikMPuCjf44yYW2UH44=;
 b=GN6HZ5V5qfWy5L/0YRuPWsKJR50/wGY3mjJw/sbZR+HdvOhXhjzjUdT2ldpPOORrHOxs8w0NXa7XLm/EcwaRrkRc+cxz6j/mnHJPmiBj3BqY57+N4MII1t3syYs6AyXy4j5A4JaeKUlRKNOUnUagnzo9YSrUQsOvOCkqqgwGYm1jnbfgjZ9V5jre18PzmEujSPeuvrek6xU9J/Ik+Gss8G7R8+tlsd2LKjdPzOgFCYjyhb4MFYbRBxNtoT01F7Mg6bhmy6nxU5dlBPTb6LA09M1Fq5BMVIANPz+cOKPvl4+RtMKvDButMRXsNU76eFmKJS6Drh3KnLyVYMcrS0vZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4182.jpnprd01.prod.outlook.com (2603:1096:604:4c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 23:05:41 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 23:05:41 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 5/7] spi: spi-mem: Split spi_mem_exec_op() code
Thread-Topic: [PATCH 4.19.y-cip 5/7] spi: spi-mem: Split spi_mem_exec_op()
 code
Thread-Index: AQHWwdD6QPFXPe3Kl0mGtgB8xtVZyKnWVj3Q
Date: Mon, 23 Nov 2020 23:05:41 +0000
Message-ID: 
 <OSBPR01MB5048B6AECF7534A896439005AAFC0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123194345.GC5619@amd>
In-Reply-To: <20201123194345.GC5619@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cd8921d-f0f5-4047-9adc-08d890044cd5
x-ms-traffictypediagnostic: OSBPR01MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB4182C2CDD79DA786F6676DE0AAFC0@OSBPR01MB4182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 U+D2YkIjbWEU7W3MpIInv43vjbuwXBjBS6I+/wrm3ACUTUbHNrwQRncGM4kAh2kKWaBqeqC0DNUWSizVcLPFF2Q1SXVeuXxv43mErS5LQKWiL8blyRrdYpDKYftbii9mb1eZd2UFJINAm4OCgJRf3C4LYBj4Oxkbr2m7rtb/Sn2dEj9+xDLv2KKR9MeOBG3MdfvAFAW6Dgs/jxx38ZRGS4WEP5YuQpiv6++RTY3W8spNwho4tjfoXSaXsTAWmIDYJgeAi3lm/1j6mQvYRwbAR+k9QV6phT7Ht04JXyS0iubg3+FaL1W2nEX8xJiiST92a6hCJaZ7FrgMnQxKzvdJ9g==
x-ms-exchange-antispam-messagedata: 
 Mlq0ynVK9mJALZIZbC5AQ00WtqH40K+iPnPOPJXE0VLnfuv+y+CILTVlRMP7DFp1m7/8tkz08ZlPaN1JQxMp45hSpkF+hGJSQPXh2YbB0/+u5gjsf9JXHYjkgvw7Zvhj4/JIVV/vXl/JSN2c4DttXaiEcpk3aygGgcvXpTAmrr0Qb53jEwrVsHw+cWqG+pWG1HeZMBMTPaHNqYZzovJD67qdQRePKlR9u30xgQ3ag4w93fcdL+gDfkASbppaJIqAeU4UpqqcJm4CFi1hFvpPQH+8vZW0Pekd31dBgC6RygRVGaUROc6hsR+fyCszqHF5OEuKS1jb2OzOOCccO8HuDkqU6DY2W6wHPcGMpVpmFFDdtjPdMgS0bUrTSrqZ9p8OFSc5AKKEuy3e9VdoksCS1P8MFNzHrlZYrzq8D8xjOosI1d1anHBiKg348z1CUx6vR90/mLirfzV31oY6LHqQjSlKL9airF4PWUMpzFH/kWkOn2o2EpDEukTaNyrD4zqt4r97ZdeNBgda8hCQ/TMuYVSDR3wmhVfWT5ufjOlPaRgt1RU7I6ZpUkFDO5VtxZ7Ov216m81tRwdijTD4Fmhtak13gKYoLbUZGMiSSZpd+jJNrmRMW7M0iMv5qLYnOIMYhQeJmFGjWIHjm6ZRC3xhQBKVaEIES0rAc5hedseLNCrox+pqKpVxl7Gp5LBe74k61u1gp2kx2OeZwt/TTl1iEUaXdHWmZpQtSdDBfLPTyLioq1tSzSmINJGw4X2Zh5c9RwA1G1sWcAkRUJJTqfOLWYEQsllXpabf21K1y6i5uOQYQZebIhtw7tR+0PUerH2mvEA98RKmxpvqcxWwRiIDHLUKsvmXuD7k1otPU6v0/EipqarUiyeY9QJZRjM/6QxOe6QNvg8URIpfzot+MYRlGw==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd8921d-f0f5-4047-9adc-08d890044cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:05:41.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndw8I9tCnKv1wube6wKY7w2oiKvIE08WbPvPn8a12HRxQrPy3d8twnKau8FfwGyhHk/HxA4W+ulsMWplPFy54u6q2oDeyDUdrBirfVCVmXltMtXLr6qdNHXn3hrnHQdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4182
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: U8LejP3HzdM50entBlGrTzsgx4520388AA=
Content-Type: multipart/mixed; boundary="3oVpm4AN1FXYcQIq60tB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606172744;
 bh=Vl3xz6/ZNJZdj5VLWggS28seh7GwJSO6kHCFji6pkr4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ll0xH6npMXUVqTevz2iPgJgoZLGMmCv4Ks5mLBZoKjRV3UJ3Z4Shp0dx77bm4vjC70h
 hO+CcbEsYpsOZ6rH6VuGAENt26dYOeVA/zjKtdUBJbtKLoMrOK+p4SGE1WT9SiaPm1pSx
 RPXxLmesnH2lTQOl/ueIiUBpcU2xPH2eq5Q=

--3oVpm4AN1FXYcQIq60tB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IFNl
bnQ6IDIzIE5vdmVtYmVyIDIwMjAgMTk6NDQNCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8
cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBDYzogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmc7IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0
c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAZGVueC5kZT47IEJpanUg
RGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LjE5LnktY2lwIDUvN10gc3BpOiBzcGktbWVtOiBTcGxpdCBzcGlfbWVtX2V4ZWNfb3AoKSBjb2Rl
DQo+IA0KPiBIaSENCj4gDQo+ID4gRnJvbTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxs
b25AYm9vdGxpbi5jb20+DQo+ID4NCj4gPiBjb21taXQgZjg2YzI0ZjQ3OTUzMDNlNDAyNGJjMTEz
MTk2ZGUzMjc4MmY2Y2NiNSB1cHN0cmVhbS4NCj4gPg0KPiA+IFRoZSBsb2dpYyBzdXJyb3VuZGlu
ZyB0aGUgLT5leGVjX29wKCkgY2FsbCBhcHBsaWVzIHRvIGRpcmVjdCBtYXBwaW5nDQo+ID4gYWNj
ZXNzb3JzLiBNb3ZlIHRoaXMgY29kZSB0byBzZXBhcmF0ZSBmdW5jdGlvbnMgdG8gYXZvaWQgZHVw
bGljYXRpbmcNCj4gPiBjb2RlLg0KPiA+DQo+IA0KPiA+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1t
ZW0uYw0KPiA+IEBAIC0yMTMsNiArMjEzLDQ0IEBAIGJvb2wgc3BpX21lbV9zdXBwb3J0c19vcChz
dHJ1Y3Qgc3BpX21lbSAqbWVtLCBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ID4gIH0N
Cj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoc3BpX21lbV9zdXBwb3J0c19vcCk7DQo+ID4NCj4gPiAr
c3RhdGljIGludCBzcGlfbWVtX2FjY2Vzc19zdGFydChzdHJ1Y3Qgc3BpX21lbSAqbWVtKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIgPSBtZW0tPnNwaS0+Y29udHJv
bGxlcjsNCj4gLi4uDQo+ID4gKwlpZiAoY3Rsci0+YXV0b19ydW50aW1lX3BtKSB7DQo+ID4gKwkJ
aW50IHJldDsNCj4gPiArDQo+ID4gKwkJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhjdGxyLT5k
ZXYucGFyZW50KTsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ICsJCQlkZXZfZXJyKCZjdGxy
LT5kZXYsICJGYWlsZWQgdG8gcG93ZXIgZGV2aWNlOiAlZFxuIiwNCj4gPiArCQkJCXJldCk7DQo+
ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiANCj4gVGhpcyBtaXNzZXMgcG1fcnVudGlt
ZV9wdXQoKSBpbiB0aGUgZXJyb3IgY2FzZS4NCj4gDQpBZ3JlZWQgKHBtX3J1bnRpbWVfcHV0X25v
aWRsZSgpKS4NCg0KPiA+ICsJbXV0ZXhfbG9jaygmY3Rsci0+YnVzX2xvY2tfbXV0ZXgpOw0KPiA+
ICsJbXV0ZXhfbG9jaygmY3Rsci0+aW9fbXV0ZXgpOw0KPiANCj4gUGx1cyBoaWRpbmcgbG9ja2lu
ZyBpbnRvIGZ1bmN0aW9uIGxpa2UgdGhpcyAuLi4gaXMgcXVpdGUNCj4gImludGVyZXN0aW5nIi4N
Cj4gDQrwn5iKIA0KDQpDaGVlcnMsDQpQcmFiaGFrYXINCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJ
CQkJCQkJUGF2ZWwNCj4gDQo+IC0tDQo+IERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwg
ICAgICBNYW5hZ2luZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuaw0KPiBIUkIgMTY1MjM1IE11bmlj
aCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCg==

--3oVpm4AN1FXYcQIq60tB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5834): https://lists.cip-project.org/g/cip-dev/message=
/5834
Mute This Topic: https://lists.cip-project.org/mt/78451545/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3oVpm4AN1FXYcQIq60tB--
