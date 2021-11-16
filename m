Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941C7C433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 09:27:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.7780.1637054864557035827
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Nov 2021 01:27:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1AG9RfD4020207;
 Tue, 16 Nov 2021 18:27:41 +0900
X-Iguazu-Qid: 2wGr0wVJrjRL2DoViT
X-Iguazu-QSIG: v=2; s=0; t=1637054861; q=2wGr0wVJrjRL2DoViT;
 m=KwYDM3+Zc/ZQz7pqsLYn2dzOTatxhcF+nncqVn+oWz0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 1AG9ReEO002541
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Nov 2021 18:27:40 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 772551000A6;
	Tue, 16 Nov 2021 18:27:40 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1AG9Re4i018416;
	Tue, 16 Nov 2021 18:27:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHQZVMGKYZ0eWtjZqxP6fNC7aslGsJkOGx+ywF35NsiAvnHhcKbHV38D56f5gcHg55TI2G3Wf+7VPr+Z4cnnq6fIp20cj5gRaewcVIBr4y87bCu7ECm6bz1dJCPfXfoMFYY9k4yacMnIbQPpDThE9D/FcO1m7QeubEHANDukmJPDgPzfDhISbmt83BpKm89ScgULXzEGsGQKJeu+HuZZNZAEsW8Jdovv4NiAPqkx4egwbmEPvCVKsfihwZUUUjcMOWdW6kC/SCqmaEEipjJTbr12h2kUyGvdoz7u9ZJVmCqr78pdVtsY/r27FyqYT8x3MypnW0DEzJINkT89Qw8xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUcx8v1Oe28cXDgqYXzCG+CkMak964TpXraov3DW0rE=;
 b=Hew5sOAitoK/GZo1QYTKl2eDJKYAkjewufPDbrHh1wHcrbzuOa8S4F0z2M6DiBYDu8uXfnj6Gu5L8R2ZDcFxwwVQV+E31YvHhgoibL4VBtmezeUX5sMTE+el1sqadtpytIHiHUHWIcFgMlbSVxJtImaJMqrrr8yH1qnblxAquoW0ZDSzjFCLFUY/KqDJTvtPh7STxtLOqQoWfEHRYP+KGuDkxXpEFoyJKtv+XX3xEjquxjIEfk2QyDFC0HoUyQeYjy98d0OnciYufIm27Q69VlrCc/O0bTCv/eROxNaKrqgGZc5eBp8dQov+5nowDczgSzvdkYZw1DDsl1XPeFd65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH] cip-core-image-security: remove unnecessary
 dependency package names
Thread-Topic: [cip-dev] [PATCH] cip-core-image-security: remove unnecessary
 dependency package names
Thread-Index: AQHX2lEjpYYzxTgk+0Oddx0uF1GSvqwFiZSAgAA4LQCAAALUUA==
Date: Tue, 16 Nov 2021 09:27:34 +0000
X-TSB-HOP: ON
Message-ID: 
 <OSYPR01MB5542D70BA9E3D356740EFA01A4999@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
 <f222455d-19e3-d047-a4b8-afa5ad6f7700@siemens.com>
 <OSYPR01MB5542E50807C642D356B91EFFA4999@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <962c7ab8-0bf3-2d13-3ea0-af55e7c91ef5@siemens.com>
In-Reply-To: <962c7ab8-0bf3-2d13-3ea0-af55e7c91ef5@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac691125-266f-40f6-7b6c-08d9a8e352ca
x-ms-traffictypediagnostic: OS3PR01MB5640:
x-microsoft-antispam-prvs: 
 <OS3PR01MB564060E74F18E41617048833A4999@OS3PR01MB5640.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IFS2iFWH270fQprbvZpaGsP/V298sFj7RtGl3QsXas52kUr4LqR48VguMzOqwPYJC+fRfJ5Og45Qns928ZXzhGQOIktLETUhBQ/xnbM3uCpuGP/HRTm2+LVDJuKQ9LguJeOWjNvKBb+Tito2q5BPqjZRG4/aVblFa89XTTFWVQ5u82B9f2T/R5kECJNypsh28J/tcylczQ21dYnfYwTYfHVt4qJ9d4nieXlPPuKOZ4s7pv1sMlWew0+69wRXzZXJj2gmh3UQJ1rPDIc1FQtf0rmWSVuBCwAuPZTS7dF97OCmTQWgqvg4ZYiR4A/BeECq1lIqz0zUMQXXrCTQJPSs5dN5JV4jw/ujKaMvr906vIKJRMmX8BpTy84Hrok5LvFUmrEYEYZ0dEE0r0qirN4tBUnZa14gQBuFT1dnUjD9T7FInvO3Z0vD6RmPAbNUt9zWdGEQuRvI66kWG20LEkxHp2d42IOk/MVedBBnXYGT9Hc5p+X9xKFSRwKCo82bL6Xy+dQrMVTb+RpzcY45CDWVuMIFtRTZYkSfnLv6GpXYF+Oj0DZS32h+5GfFmxfXeIs0EjriOCupThdItmQ8qka0eUudpmySHByvhKyjs4HrKFzYz9eUkcyQc6sHDJJRUU+frMlunicc2AF3AJnhEfYGfriiHfb8ttU+ArkxNbchwRJOJGqzCWUfYLAHpYGrJfG9FGGpbefopUyzBojIC/WCzw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(5660300002)(26005)(6506007)(110136005)(53546011)(8936002)(71200400001)(186003)(52536014)(38100700002)(15650500001)(7696005)(76116006)(8676002)(66946007)(33656002)(2906002)(316002)(86362001)(55016002)(9686003)(66556008)(66476007)(38070700005)(83380400001)(64756008)(66446008)(85182001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bEJGZDJOdXhXSVpvU0pqU005ZlcvN1M1Y2I5STZxemd1aUdlcHlzeHJVNjJG?=
 =?utf-8?B?U3I1VWZYZ3ErRUIxSHZ5YU44dnYzbElrb0tUV3hOWnNHblpoSk45SDR1aFNy?=
 =?utf-8?B?Y3dzMEFjY0poOFlrS09tc3hhaGJudWtmMlJmQ25jSlF4M3crOWdnNU5yTU1m?=
 =?utf-8?B?T2V4aGRDYWJMWmk0bFZta0x1NVFJSzB2VUZLeEIzdXp4b1lrZUlrYm82aDZ4?=
 =?utf-8?B?Rk9ISGpuSWJNdG9DVHJyeTNvYXYvM0lKY3NOWmF2UWZpMHEwQzNPS0dRNzJT?=
 =?utf-8?B?SjdENnBJajJ4LzBkbFIxSks4Y3d4YVV4WElhOGc1Rm56R0w4QTBLM2YvamYy?=
 =?utf-8?B?Y3RyVVBvSGErWGFHU2ZBTXRZM0QrMmVFWXpDUEcrUzNUejdZOHBJQXFHZzNt?=
 =?utf-8?B?QTl0RnA0REd1NWpWS0p5WWQ0WTVGb0Vwa2lDOHJqelh4UGxqbkFJT3JhSjVn?=
 =?utf-8?B?TDVwN2o0V21SbXVFUEFkMUU5NmdkSUY3QXFESG1QS2l1TjU5a1ZsVjZreDUr?=
 =?utf-8?B?MVBQditqTzdiOFc2MFk2bHBtNEJVZnBrSVZuT2R1ckF2cjRtL1NmaTVFa3B0?=
 =?utf-8?B?VDRJdkQwamc2cmNHWmtqdWdnY2pnODFnNTY5T2RxYVlleFlmRmlFeVlwb3k2?=
 =?utf-8?B?MXlnN2xtUFJTenEzTHBwR3dsTnN6Y2llT1ZiMUhFRlpheDBOaUZmTUxpK3lx?=
 =?utf-8?B?RUR3OGRsUUc0aHF0M0krRXYyWlY2WG9rRWZXS3ZmZnQ3bHkrcEZ2NHNEY0VW?=
 =?utf-8?B?TmwvT1NjNFNzUXFiS2JPYnhpNWVLRUtLcHB3Qy9EcFZWNE5ZVkh6OVFvOCtZ?=
 =?utf-8?B?UVUyZmU0ZE5lVEhNalpsaTZjeFlpYU5SNGpYWm50RTF2YUZSMlhTaUgydXUv?=
 =?utf-8?B?QTlwOGYzMzhUbjBURGZXNW1TSHJtbEVMR3ZHZEtjMGV4T0N0WWxtSUo5SVVz?=
 =?utf-8?B?SmNiekt6RDFmSm1rMzFhc2pyejFZU2RCY0IybDZWYXlNSDNuUU8vUWd5YTMw?=
 =?utf-8?B?d0ZOM3IvWHFRelBlL0FSU2o5MW5RWFdNZG5GOWFmbFdlb0psbG01OXo5cjJG?=
 =?utf-8?B?Uk9RY0h3UTdEYkZ3aFNvYzdqTGVxcGthcTc1OHJPREVmclZDa3ZzWXRSc0Fp?=
 =?utf-8?B?SjNYbE5qUUhoaXhuMzRoeVlhcG50WnpnMzFXVXJjL05TT2lMTjZ5WEEraGFa?=
 =?utf-8?B?bjhObksrczN3ejN4UnFId2QrNzFVZkoxQm91WWhmbmh4TW9VYjJHZmlHUG5P?=
 =?utf-8?B?bGZCYndsRSszbEtjNnUwc05vNzcxRWVZSjdMVVhIbFJxL1JTeEZBcnZvanE4?=
 =?utf-8?B?bjVpY1lyVktQanM3eFprRDBoVHB2VWJFNGxIcEpMakhtQmpLV09ERXBEbTRP?=
 =?utf-8?B?a0lpd3V5TVZYK2RUcWhuendLRmNSNFEybVdDUEVScFhTV0FwNDJibk1PK0VD?=
 =?utf-8?B?QWQyQ2VoZ3M1c3BSOVhUS1o5M21lS3pNNDhRWFllVWh0dEI2NktlUGNuS21L?=
 =?utf-8?B?SnJmSnBuM0ovMnlFUTFCY0xjZzRESzZ1T1V5ZUk3N2s5VG9KWnRMOW5BQjVo?=
 =?utf-8?B?RmwrTTJoK2lSYW1mU2pPdTc2SW1RekhrQWFFdUxFSDRGajd4Z0I5UHJEQ29m?=
 =?utf-8?B?NUx3OFI5UGt5eHBscHpoNXpwbThqVG8yc0dud0tBOXhXK05kVlFBOFFRbGk3?=
 =?utf-8?B?Z0xYc1dVNzNtUDNtaVU2bW9rSlZSTVpNK2F1OHZHWFR3SFFCSG1lREY3QTl0?=
 =?utf-8?B?M2w2bHFQN29ISURoaUVYaGlQeVIvNjdFWTg1UU5ERUlPUUpPK0lHL1ZGSFJG?=
 =?utf-8?B?N0lXbUtjVkdKc1BwV2NIeXJ2dkw2MGRyUG90WjE0a2cvVzBIRXhmQkhPQWY4?=
 =?utf-8?B?ZFcrcE5xb0NKQUZGaDVHdFVzRFphSUFsZGJOVmpTSHNSanRHNlhQbEtCK1B3?=
 =?utf-8?B?TnIyUnUwb1ZoMnlUOEwvWnhUcUllK1QvenBPRWk4TFVPWWMvUGloczRic1hk?=
 =?utf-8?B?NEwxa1pwRk5tdkh3Y0dUOHBSY0xlcGdsT2VjVWhITDBGb2ZwSzN0RnpQN3lG?=
 =?utf-8?B?K1h5WklNeHFCRTRLU2dvRmRIcTE4bVBodmdlNEhyT0ZxaHFqcmVaa1JsZTd5?=
 =?utf-8?B?WFVLb25CbW9BU3BMa3hUKzBmYUZWQktERXZlNGJOL1YxcUVZamZEakp1MWV2?=
 =?utf-8?B?ZDFxOW1DdXQ4L0J0U0tqL0tYNEZleHBZT2RXbXVYM3YrRG9mdEJRY1dzUkhT?=
 =?utf-8?B?Y0YvcGd0dExFYUJLR21PVVlGb3pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac691125-266f-40f6-7b6c-08d9a8e352ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 09:27:34.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 dJRZ0puH6ZQQz74G+QqaqpZkL++vXlO5h6cKpWvTRMer+RabpLbuQWpsVcPAQVVRek/W3Jp/6MVmRT9gWmyF/RAC1pTeMurN06Pu7QPEgSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5640
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 09:27:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6924

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMTYgTm92ZW1iZXIgMjAyMSAxMjo1Ng0KPlRvOiBw
eWxhIHZlbmthdGEo77y077yz77yp77ywKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtdHNpcC5jb20+
OyBjaXAtDQo+ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPlN1YmplY3Q6IFJlOiBbY2lwLWRl
dl0gW1BBVENIXSBjaXAtY29yZS1pbWFnZS1zZWN1cml0eTogcmVtb3ZlIHVubmVjZXNzYXJ5DQo+
ZGVwZW5kZW5jeSBwYWNrYWdlIG5hbWVzDQo+DQo+T24gMTYuMTEuMjEgMDY6MTEsIFZlbmthdGEu
UHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+Pj4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2EN
Cj4+PiBTZW50OiAxNiBOb3ZlbWJlciAyMDIxIDAwOjE2DQo+Pj4gVG86IHB5bGEgdmVua2F0YSjv
vLTvvLPvvKnvvLApIDxWZW5rYXRhLlB5bGFAdG9zaGliYS10c2lwLmNvbT47IGNpcC0NCj4+PiBk
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFU
Q0hdIGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5OiByZW1vdmUNCj4+PiB1bm5lY2Vzc2FyeSBkZXBl
bmRlbmN5IHBhY2thZ2UgbmFtZXMNCj4+Pg0KPj4+IE9uIDE1LjExLjIxIDE3OjE1LCB2ZW5rYXRh
LnB5bGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+Pj4gRnJvbTogdmVua2F0YSBweWxhIDx2
ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+Pj4NCj4+Pj4gSXQgaXMgbm90IG5lY2Vz
c2FyeSB0byBtZW50aW9uIGRlcGVuZGVuY3kgcGFja2FnZSBuYW1lcyB3aGVuIHBhcmVudA0KPj4+
PiBwYWNrYWdlIGlzIHByZXNlbnQsIHRoZSBkZXBlbmRlbmN5IHBhY2thZ2VzIHdpbGwgYXV0b21h
dGljYWxseQ0KPj4+PiBpbnN0YWxsIGJ5IGlzYXIgZnJhbWV3b3JrLg0KPj4+Pg0KPj4+PiBzbyBy
ZW1vdmluZyB0aGUgZGVwZW5kZW5jeSBwYWNrYWdlcyB3aGljaCBhcmUgbm90IG5lY2Vzc2FyeS4N
Cj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9z
aGliYS10c2lwLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICByZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1j
b3JlLWltYWdlLXNlY3VyaXR5LmJiIHwgOCArKysrLS0tLQ0KPj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4+Pj4gYi9y
ZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiDQo+Pj4+IGluZGV4
IDYxZGRjMzkuLjZjNDFiMDAgMTAwNjQ0DQo+Pj4+IC0tLSBhL3JlY2lwZXMtY29yZS9pbWFnZXMv
Y2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4+Pj4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdl
cy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPj4+PiBAQCAtMTcsMTIgKzE3LDEyIEBAIElN
QUdFX0lOU1RBTEwgKz0gInNlY3VyaXR5LWN1c3RvbWl6YXRpb25zIg0KPj4+Pg0KPj4+PiAgIyBE
ZWJpYW4gcGFja2FnZXMgdGhhdCBwcm92aWRlIHNlY3VyaXR5IGZlYXR1cmVzICBJTUFHRV9QUkVJ
TlNUQUxMDQo+Pj4+ICs9ICIgXA0KPj4+PiAtCW9wZW5zc2wgbGlic3NsMS4xIFwNCj4+Pj4gKwlv
cGVuc3NsIFwNCj4+Pj4gIAlmYWlsMmJhbiBcDQo+Pj4+ICAJb3BlbnNzaC1zZXJ2ZXIgb3BlbnNz
aC1zZnRwLXNlcnZlciBvcGVuc3NoLWNsaWVudCBcDQo+Pj4+ICAJc3lzbG9nLW5nLWNvcmUgc3lz
bG9nLW5nLW1vZC1qb3VybmFsIFwNCj4+Pj4gLQlhaWRlIGFpZGUtY29tbW9uIFwNCj4+Pj4gLQls
aWJuZnRhYmxlczAgbmZ0YWJsZXMgXA0KPj4+PiArCWFpZGUgXA0KPj4+PiArCW5mdGFibGVzIFwN
Cj4+Pj4gIAlsaWJwYW0tcGtjczExIFwNCj4+Pj4gIAljaHJvbnkgXA0KPj4+PiAgCXRwbTItdG9v
bHMgXA0KPj4+PiBAQCAtMzAsNyArMzAsNyBAQCBJTUFHRV9QUkVJTlNUQUxMICs9ICIgXA0KPj4+
PiAgCWxpYnRzczItZXN5czAgbGlidHNzMi11ZGV2IFwNCj4+Pj4gIAlsaWJwYW0tY3JhY2tsaWIg
XA0KPj4+PiAgCWFjbCBcDQo+Pj4+IC0JbGliYXVwYXJzZTAgYXVkaXNwZC1wbHVnaW5zIGF1ZGl0
ZCBcDQo+Pj4+ICsJYXVkaXNwZC1wbHVnaW5zIGF1ZGl0ZCBcDQo+Pj4+ICAJdXVpZC1ydW50aW1l
IFwNCj4+Pj4gIAlzdWRvIFwNCj4+Pj4gICINCj4+Pj4NCj4+Pg0KPj4+IFdhcyB0aGUgbGlzdCBw
b3NzaWJseSBpbnRlbmRlZCB0byBsaXN0IGFsbCBwYWNrYWdlcyBleHBsaWNpdGx5IHRoYXQNCj4+
PiBhcmUgc2VjdXJpdHkgcmVsYXRlZD8gSWYgbm90IG9yIHRoYXQgd2FzIGluY29tcGxldGUgYW55
d2F5LCB0aGlzIGlzIGZpbmUuDQo+Pg0KPj4gVGhlIG9yaWdpbmFsIGludGVudGlvbiBvZiB0aGUg
cGFja2FnZSBsaXN0IGlzIHRvIG1lbnRpb24gaXQgZXhwbGljaXRseSBhbGwgdGhlDQo+cGFja2Fn
ZXMgcmVxdWlyZWQgdG8gYWNoaWV2ZSB0aGUgc2VjdXJpdHkgZnVuY3Rpb25hbGl0eSwgIGV2ZW4g
dGhvdWdoIHNvbWUgb2YNCj50aGUgcGFja2FnZXMgYXJlIGRlcGVuZGVuY3kgcGFja2FnZXMgb2Yg
dGhlIG1haW4gcGFja2FnZS4NCj4+DQo+PiBJIEp1c3Qgd2FudCB0byByZW1vdmUgdGhlIGRlcGVu
ZGVuY3kgcGFja2FnZXMgYmVjYXVzZSwgdGhlaXIgbmFtZXMgYXJlDQo+PiBjaGFuZ2VkIHdoZW4g
ZGlmZmVyZW50IGRpc3RyaWJ1dGlvbiB2ZXJzaW9uIChidXN0ZXIsIGJ1bGxzZXllLCBldGMpIGlz
IHVzZWQgbGlrZQ0KPmJlbG93IFtidXN0ZXJdDQo+PiAgIFBhY2thZ2U6IG5mdGFibGVzDQo+PiAg
ICAgICAgRGVwOiBsaWJuZnRhYmxlczANCj4+IFtidWxsc2V5ZV0NCj4+ICAgUGFja2FnZTogbmZ0
YWJsZXMNCj4+ICAgICAgICBEZXA6IGxpYm5mdGFibGVzMQ0KPj4gU28sIEkgaGF2ZSByZW1vdmVk
IHRoZSBkZXBlbmRlbmN5IHBhY2thZ2VzIGhlcmUgYW5kIGFsbG93ZWQgcGFja2FnZS0NCj5tYW5h
Z2VyIHRvIGluc3RhbGwgdGhlIGNvcnJlY3QgZGVwZW5kZW5jeSBwYWNrYWdlcy4NCj4NCj5PSywg
d291bGQgYmUgZ29vZCB0byBkb2N1bWVudCB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0K
SSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCBhZGRpbmcgdGhpcyBpbmZvcm1hdGlvbiBpbiB0
aGUgY29tbWl0Lg0KDQo+DQo+Pg0KPj4gQnV0LCBzdGlsbCB0aGVyZSBpcyBwcm9ibGVtIHdoZW4g
dGhlIG1haW4gcGFja2FnZSBpdHNlbGYgaGFzIGRpZmZlcmVudCBuYW1lIGluDQo+dGhlIG90aGVy
IGRpc3RyaWJ1dGlvbiB2ZXJzaW9uLCBpbiB0aGlzIGNhc2Ugc2hvdWxkIHdlIGhhdmUgZGlmZmVy
ZW50IHJlY2lwZSBmb3INCj5lYWNoIGRpc3RyaWJ1dGlvbiB2ZXJzaW9uPyBQbGVhc2Ugc3VnZ2Vz
dCBpZiB0aGVyZSBpcyBhbnkgdG8gcmVzb2x2ZSBzdWNoDQo+c2NlbmFyaW9zLg0KPj4gW2J1c3Rl
cl0NCj4+ICAgUGFja2FnZTogbGlidHNzMi1lc3lzMA0KPj4gW2J1bGxzZXllXQ0KPj4gICBQYWNr
YWdlOiBsaWJ0c3MyLWVzeXMtMy4wLjItMA0KPg0KPk9WRVJSSURFU19hcHBlbmQgPSAiOiR7QkFT
RV9ESVNUUk9fQ09ERU5BTUV9Ig0KPg0KPklNQUdFX1BSRUlOU1RBTExfYXBwZW5kX2J1c3RlciA9
ICJsaWJ0c3MyLWVzeXMwIg0KPklNQUdFX1BSRUlOU1RBTExfYXBwZW5kX2J1bGxzZXllID0gImxp
YnRzczItZXN5cy0zLjAuMi0wIg0KDQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLCBJIHdp
bGwgdXNlIHRoaXMgYXBwcm9hY2guDQoNCj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFQg
UkRBIElPVA0KPkNvcnBvcmF0ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


