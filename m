Return-Path: <SRS0=1a2R=FF=lists.cip-project.org=bounce+64572+5910+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E36C64E90
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 00:51:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B49B20725
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 00:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mqoZj/LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49B20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5910+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8V0QYY4521723xpxePwmOxG4; Mon, 30 Nov 2020 16:51:52 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.3156.1606783910236628647
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 16:51:51 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0B10pfHF018294; Tue, 1 Dec 2020 09:51:41 +0900
X-Iguazu-Qid: 34trMRoISTB3p1LjX7
X-Iguazu-QSIG: v=2; s=0; t=1606783901; q=34trMRoISTB3p1LjX7; m=oAe/9hplukOfzOvL73cm0CqxcuI9to7ZRH0fnyt1Vbs=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0B10pevA040225;
	Tue, 1 Dec 2020 09:51:40 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0B10peDw025661;
	Tue, 1 Dec 2020 09:51:40 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0B10pdnA032466;
	Tue, 1 Dec 2020 09:51:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6Luw4OzBwrlyJZZP/NCIEsPdaRosVRFxEyQo17o/ay8XLhE1FKx36De0sevtqjVZUZExZgbhi7SaUORnYu4xqLeoQB7zXi1TLL8Af0EfRh3xLVje8jdDgEtqDGGD3p5CQ6wvnITs2wucGzHNfpsomqrlc4/eDw05NmayNxf7R1AfmOgtL0Qvv1u72nTWnVqGYeD5AL7KU/KUxub+XNnqCMwuvQO18C3hAZIz0Jazz7lPMyzTVeE3Z9H6zKoUhB8jqtbxnYY8SlUfObaaNc9IxNOwl3WmdVhWjLNniwPh4spkYn8MAAbvvm+O5PczjN9F+zkMtKHFLdqqxRv/qQbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRGq9ISCUQPGxv7HSVHeshHDkGwn46PYz0v7/E7UhL0=;
 b=dG+eLTuorEkWD6SgbZ7Ocyuv4Z/k6Y4sIqZgpSKWNQFGM5yqjJJRK0iT6/R05oC0gMvCTCnoQ4fRuGo4Jn/SAbw3gf1eqxGMTls1nCSfReTdPckiGLpTh9e7vRLxjhHnNk59e/3fRzGeojofOzj1QE9J9ncChTFrGahwaCHBWgQvF8n2ImyMJcOvlHviKfdH5TWN0suGseslzTxgKCJbADwMoxelbldlLk0nrcKigXTmfYta7xfIK6CCw84fLtnaVuJQExf0R8XZSl+BXbLltHMdO2ziq2jBeF/nF2TZ+8eEQ+TPQnnewpEdXKvR93LU4xlle3vG/N2H8NVBDpUL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 07/11] ARM: dts: r8a7744: Add device node for PRR
Thread-Topic: [PATCH 4.4.y-cip 07/11] ARM: dts: r8a7744: Add device node for
 PRR
Thread-Index: AQHWxyPYjVX5GJ0f60KbmlGCEXdbZqnhZ3aw
Date: Tue, 1 Dec 2020 00:51:38 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298383351F9AA2DE1CE8E07692F40@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201130141916.8211-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e68fc6cf-ec4e-4a10-ae3e-08d8959342ae
x-ms-traffictypediagnostic: OS0PR01MB5298:
x-microsoft-antispam-prvs: <OS0PR01MB529838A67A3DB8C4F5CD221C92F40@OS0PR01MB5298.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y4OBlWSUbKmW7Zw6qf+5i2kzBo/8MsjS+BWz4GiowMVaKtyzblfKNK2w6KAK87fDEiVlHJLZYp9F9A5A9GYUZ+ehq5TMAuAVIEiEuMI4vzDrv152Z5YadmRxrvj2ebb1L+EkcKrPVUBt+6iPQGqhDuoBE4cuR/u92Na501/YH0xJVaCmvt5VVhdQoetlJu1vbfCJZmrdkS8Qvq8gea91NdrejXd349EAOcZHCHNN6h2NWYrOQh7tz4nz1dBQeywnkpvALJ4+Ja/IiXkhpq7iH1upCK8t1UC4c5nnB0xJQ8YMZ0zNAMGXTgC/GfnnskCm0nVGK0TkaNSLiL+TXAdVHQ==
x-ms-exchange-antispam-messagedata: =?utf-8?B?ditOSkp4SkNJTnk2N05FNEo3bUJIY01YQlJXOHk5WjV4L2lTZnlFNFhvZDZw?=
 =?utf-8?B?dGhrRnV4cGgrVXh1YW5DWDJYaXJZcDA3UXYweVV5MWRacndjdlB5WjN3dG9u?=
 =?utf-8?B?RkR0UEFLM3RwN2lpZ21FeTdCNE5MbXJyNERDdENsbVVick90blNmWDRNVGww?=
 =?utf-8?B?R3dySm9nNDhIWVViYS9ZZkJWeDhiRmJGUTVJVXd2OEdUTms0YzRlYjQ4cGlr?=
 =?utf-8?B?R09vNjJ6clE4RjkzRGFrcldUOWprSDF2ZVdaTEpmMkQ3K0FCd0ZOa213MEQw?=
 =?utf-8?B?Q1g1bzdOQVl6bEp4TURyY0FjZFgxN01GS2JZM3JVYlFFZmNuUmN2MitZVEdr?=
 =?utf-8?B?ZlVtUjNBMS9zWlY5cUNDMXl6V2VhSEJoV3dQRkQ5VXYvNWZrdWFkVE95WDk2?=
 =?utf-8?B?TnNPRlcxd2tTSXNHcGNOTURiUnlhT3hRcnRpVTBldjlYNUdDc1Z0RXp4bGp4?=
 =?utf-8?B?dXhsei9rTVFidHJTemFxcU5DcUpZbS95WGp2b3BKKzNLY1U1dzloTWhxaVMz?=
 =?utf-8?B?UlhKNWxCUmdTVnZDOTFtNGVSNUpWQVBqZ2RsdEFiQjdleEdacXJwQjFrM2pr?=
 =?utf-8?B?eHhXNDVDVHpXaFJSbEQ3a1lOQWFaU1E2dll4N1NhQUt1YlhhaVJONTg2NnZ6?=
 =?utf-8?B?Nk45K2R6cmtqaU1CSitRMEl1V0RqMlZKbWdONk1OamczKzJpMEJyTWZ4VWE5?=
 =?utf-8?B?RC92bml5bW5Rc0QwMkNJb3NvYkFQT0NGcEltak9wakVnbGZGUWFXQTZqL0xD?=
 =?utf-8?B?MGhmQjdWZnlHYVplZDQ5QUVmd1FxSFA4K2RQejhsYVk5Zjdrczh5YWRTL0Qr?=
 =?utf-8?B?T3lwNnlWVjFFRGlkM2NKTzFERGxiY1ZtTkZQRFBuQTZPQ2VSaDRvQXFYSWJB?=
 =?utf-8?B?d2hJdXZ2VmcwTWpUN25SQ2dIcmZnSUFDWXpHdmZxV2UxZU1ZOXh6elAwenhj?=
 =?utf-8?B?eWRRZUk0WjNvQUlBb04xRTJ3bUJqOVlxbG9oYS9RK3ZxWHBDVVlPVFFKd0pV?=
 =?utf-8?B?M1FLUzdBNXJtRXBEODVEbC93SWFpVGxPcnR1bjU4aURpckpvUklMMENaV3J3?=
 =?utf-8?B?N2FHME9ybTVKVWF6Zkk1L2tMREU3amJjQ291eEVEQkhUQUFuNGhmcjdESXUx?=
 =?utf-8?B?WWZFYUR0ZUppcXMvbG5rM3VqaEpaZnU3eHJWTnF1cDlGZUtQMkpQYW8wNm5C?=
 =?utf-8?B?S0d5ekRsY1hWaVZhc3FBVkErbllKVXJsQi8wREVqbEFYU0djb0FOT0U5dWxB?=
 =?utf-8?B?d1lnNE1UeEU0V3g1dGVSNDdMT1FreXp1T2prN2pQL1R0ODVKUDlIUjFEQ2lW?=
 =?utf-8?Q?6JHIsS0l9xqAE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68fc6cf-ec4e-4a10-ae3e-08d8959342ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 00:51:38.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nifRoCoWpTv9N7yCjL6mfggcmLIuVHtlhRi24psqf2x1jIMUbHwehgyup25Fam2++8OLGhEgfW0Mct8sXJAroYiHJ0NnksK7aOmxvvu3lsUmo8CKpW5pAjfTHb3TvNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5298
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KWFaPkhQOGcejDDwbrWQ3bfDx4520388AA=
Content-Type: multipart/mixed; boundary="a8jnyo7PDCiwx8b5UgXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606783912;
 bh=z7/rFfK/cK/HGz2G5K0ob5y6zW25m/SNYFaTM/j/Qec=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=mqoZj/LHQPuJNGXkxcGeEqEQhDx8AXw5vvwyiNaA8vYQcuT0pViNJh2b+IGLCi0KE2I
 UohYRs9a2BrtXWGpp1LEowFj9iIheemHwVg/mJQ5bXQAX9LJy7BwWprY6b0BkSCK3eDIt
 t7XIPhyRj/xzUAAhv+GZfHI/lCZJQpu2qFs=

--a8jnyo7PDCiwx8b5UgXM
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogTW9uZGF5LCBOb3ZlbWJlciAzMCwgMjAyMCAxMToxOSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz
77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IENjOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0LjQueS1jaXAgMDcvMTFdIEFS
TTogZHRzOiByOGE3NzQ0OiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KPiANCj4gQWRkIGEgZGV2
aWNlIG5vZGUgZm9yIHRoZSBQcm9kdWN0IFJlZ2lzdGVyLCB3aGljaCBwcm92aWRlcyBTb0MgcHJv
ZHVjdA0KPiBhbmQgcmV2aXNpb24gaW5mb3JtYXRpb24uDQo+IA0KPiBDaGFuZ2VzIGFyZSBhbHJl
YWR5IHByZXNlbnQgaW4gdXBzdHJlYW0gYnV0IHRoZSBQUlIgbm9kZSBpcyBwYXJ0IG9mDQo+IGlu
aXRpYWwgU29DIERUU0kgYW5kIGNhbm5vdCBiZSBpbmRpdmlkdWFsbHkgYmFja3BvcnRlZCBoZW5j
ZSB0aGlzDQo+IG5ldyBjb21taXQuDQoNCkkgdGhvdWdodCBpdCB3b3VsZCBiZSBnb29kIHRvIGlu
Y2x1ZGUgdGhlIHJlbGV2YW50IGNvbW1pdCBJRC4NCkZvciBleGFtcGxlLCB0aGlzIHNob3VsZCBi
ZSBpbmNsdWRlZCBhcyA2OTI5ZGZjNTkxODA0OTI3MmUwNzY1M2IxNzYwYjBiMzA1ZjA5OGU2LA0K
YnV0IGhhcyBiZWVuIHJlbW92ZWQgYnkgNjA1ZTg5NTY4ZmFmZTU3YzE3OTEyMTliNDExYWIwNzcx
OTgxYmVlYS4NCg0KSWYgeW91IGFjY2VwdCB0aGlzIHN1Z2dlc3Rpb24sIHBsZWFzZSBhZGQgdGhl
IHNhbWUgY29tbWVudCB0byBvdGhlciBzaW1pbGFyIHBhdGNoZXMuDQoNCkJlc3QgcmVnYXJkcywN
CiAgTm9idWhpcm8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJhYmhh
a2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3I4YTc3NDQuZHRzaSB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ0LmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ0LmR0c2kNCj4gaW5kZXggMDc5ZjQ2ZjE3MDQ5
Li4zMTJjOWFhZThhMTAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDQu
ZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ0LmR0c2kNCj4gQEAgLTE1MjYs
NiArMTUyNiwxMSBAQA0KPiAgCQkJfTsNCj4gIAkJfTsNCj4gDQo+ICsJCXBycjogY2hpcGlkQGZm
MDAwMDQ0IHsNCj4gKwkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxwcnIiOw0KPiArCQkJcmVnID0g
PDAgMHhmZjAwMDA0NCAwIDQ+Ow0KPiArCQl9Ow0KPiArDQo+ICAJCWNtdDA6IHRpbWVyQGZmY2Ew
MDAwIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAicmVuZXNhcyxjbXQtNDgtcjhhNzc0NCIsDQo+ICAJ
CQkJICAgICAicmVuZXNhcyxjbXQtNDgtZ2VuMiI7DQo+IC0tDQo+IDIuMTcuMQ0KDQo=

--a8jnyo7PDCiwx8b5UgXM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5910): https://lists.cip-project.org/g/cip-dev/message=
/5910
Mute This Topic: https://lists.cip-project.org/mt/78608808/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--a8jnyo7PDCiwx8b5UgXM--
