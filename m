Return-Path: <SRS0=Sxk6=JJ=lists.cip-project.org=bounce+64572+6358+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324CC433ED
	for <cip-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:25:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB9561027
	for <cip-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB9561027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6358+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7oKcYY4521723xXXb48wnFLI; Mon, 12 Apr 2021 04:25:31 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.121])
 by mx.groups.io with SMTP id smtpd.web11.28838.1618212315766738791
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Apr 2021 00:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT4NiRqILnJlXb1DNIIzJjXUGW2cZ89XI1R5R8/RxNDqKKV3GXEWuplQ5QBtHquWPcAcipNy+SUfFT1oAYOfRTqdnORt3BSezh8IWyW3VrfNX3rhmOYyWF2JYgPzFTfGGEAKW01WF1qdKRHK/Ging9k8NRonOlHFWhTv0JS27IHg+N9ntVaNg1asekhT4cDnLPQeUHJPsic1BoYCrSWGXeW+dTGjwPJIHXuXMNf3sAyRXRRTikZ7bJjy/lbOHD/O1vsMtwjJZJKgclLQq25IeQVOQGKETTOPpXQeAKulm5b/jqV00b8jAZwrkly5GYvS/TINVsZ/+zaVKZZwn6e+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+8nvq5nTwmo730dS42tRKDDStwtENKNAxnltnnlgTA=;
 b=D496S71K+GFgQtBqE9acmKPRLuhFJUZAPRCvnUJa3aVg5ae93ak87K4E6f62AoLC7m9HWVUAzl+OF8VR6LxRKso1ZsajZ6Po927x3IOfCqdZ5b7Q5CorNiyRBs2yc4EGXa0dbqtiqkpsVyHDUMTmXV0SVRw+mn9QWaPxn8p9cAavz4xtdfNSxgCiQS30sQkFXQdWyt7k8KWpJNQ+U843T68Dj4lrp9pYCopPOgCoJl1J/ESDzb6Rbti10C3J/pohQR84xEaoWFileNuKtwHHUB44ghU6qgI8VsiM1IqfBtQY9FeiUj9jrAYptK0hxnTcEvfWFSWVy07D4ZZU9FFLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5924.jpnprd01.prod.outlook.com (2603:1096:604:b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Mon, 12 Apr
 2021 07:25:08 +0000
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:25:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Thread-Topic: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
 clock for CRTC
Thread-Index: AQHXLVtz1UDxVgx6CkinWM1fXXtH9qqwfZeAgAAAaIA=
Date: Mon, 12 Apr 2021 07:25:07 +0000
Message-ID: 
 <OS0PR01MB5922C641A617FB8C2CE63ACC86709@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983AFFCF8CE63A21F53B8F092709@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983AFFCF8CE63A21F53B8F092709@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.139.26.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a87ccb24-8043-4647-71e6-08d8fd8419e8
x-ms-traffictypediagnostic: OS0PR01MB5924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB59244919BDECB6E6A553673986709@OS0PR01MB5924.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 WZ75TDqCVwNlz4ZeCwtTlLJshe8j9KHRESOhqusIs2wkGtkheTVACusy41v67u6a9hcyGR8LLkUcsuTwNUUuihQHshUDJBa1Qg6H/XIBajNplPqrg196FzqBQniiLCG4gYBnlOWzkGpalKPUxdUFBLKLCxAK9nvsAEyRLbJ8OgskbX1PpPKj/ooj7GqV7ltqEZ+7kI2tEuyB3QcV4+BgdVnULVwpH2W2piUekQK0uc1tU3eSA2i66npMZBdjVrmG9OuW4CUJTd3qH5m+azy/DEII+jQRovZEgU42W35KZ/2dKK4j0aW/IkEulXJby7p/aTYB+DQB/PNKoqzPeoQYKUDO6odCKT8s7cAprb5gxmBH9FpKXs4eMb23DEwYKvkAkdvS2aQtw4HRjQBaXx3ukXMZ2KD+3quy5Ag3QXBwktdL8eP7bawTitKEHKHQd5aMsO64Uye8s1uJSw7JpOQR+E4Z+qVnWdtVra/2OwwdVPo1bAs0FI80r57kOBi4ivWyhS5wiZSETP5Bq++kTHjY08lJ+oefNavlnAlBCcvI/jsxzhL4zKq67UFXOg30EkT5iBVvMdK/ecvWX0ozXDx+IdJkg2n1hxnaoW7HEpPtKrk=
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?RmlYZDhsL1Q2dTBlOTg5cjhuYVpDOXZJampTejROZVd2d01SN1NrdnF2eTZv?=
 =?utf-8?B?ejZSTFY0UjlqZjFpUzJVZkxadXJwUy80QWM5S3V4aWdLL1BPeURocXVNSGti?=
 =?utf-8?B?alhqdzF6QTJjVGxiSmRFS29KVTFiUWxUeHNnNkViaTlxQU1oZTJYeWVLZGFB?=
 =?utf-8?B?cmpYMDZxV3FBM1o3WGdtVVR4YmU2R3BtYkhaN3pZcW1uUUNmNlc1bkQ4R2Zz?=
 =?utf-8?B?em84MUJyTlk4MEJ5SG93VGdpTjhCTWczRXlaNUpQTkhRZWd6OExIYUxHbENw?=
 =?utf-8?B?K3ZJUjhVeU84Vko3NHZZbGhmblBoZGYwYTZVQUR1MlFXTEQzSC9CZDlPWWFK?=
 =?utf-8?B?WlRxNzIrcml3cVdtejhJRWxibUVLbjA2dUtSRzlNMytZM2NBcXRWdHY4eGZL?=
 =?utf-8?B?V1hJNWV0cWVSZ0pEZWk5Z1FhbTZpcGxrQ0pFaHN0V0JuN1M5blNkWE5vYzZp?=
 =?utf-8?B?cVdSUTAydjdEVDdFdlQ1SHc2Y1kxWFAvZ1NYMkppVDBaVXY3ckRKYlBabWNR?=
 =?utf-8?B?aDQvS0MvNUVCdXZwRjRIWTFienJPYWRvTDZYdU9ubHBUbCtTbUpFbS9MSko1?=
 =?utf-8?B?eWZqRnhuRzIwWU8vL3hpaUpKMUtwK3cxWmcwSzVNcFRpdzdCeDFGNGNlVmY1?=
 =?utf-8?B?QUVDV1VKbks3ZGlaeVVHMzNsY08xS3FrVGtVVVczSE84OXZUVTBZV084Y2dP?=
 =?utf-8?B?S1BIazU2dEZVU21FT0tBWDNNLytwa1N4SGlWbjE4K2VFdi91clBZaS9UMWx2?=
 =?utf-8?B?ZzRMMVpGdkxPWHp3T1NSdkVkdWJncTE5ckFhSFI1b1RrWkhSWjhmSE5UUDA5?=
 =?utf-8?B?K05WVy9qdGNXT3NkbVVMNmFpWFFRVUNOMHR3ZWs3SkNVS2hna3NKZlFaL1pw?=
 =?utf-8?B?eE1ob0x3bmNmeFFDeTBrTE91K0hwQThrcjJlMDREK3Y3L2N4V0x0Yncwbjc3?=
 =?utf-8?B?Y3YvbFo4dzFRN3ZkWW9kaDVRZTRUaVE3Qit2bWp4Y1U4VytsdlVFb1pXRFNr?=
 =?utf-8?B?YU4yWER2d3ZPQnBUTVBocVh2MC82aE10MVd0TXlkdVJxNmdoaFBwemNhZWhh?=
 =?utf-8?B?UERReW51eFJDcjRIbG1PWkc1MzhtV0hxakFodHBkQlltc2kvOGZCb2xLUGpF?=
 =?utf-8?B?UGc3d3hYVEtuS2ZxWktFYWkwQVQwQWlBK1paaE5CZ3pxbkJ4OXdRUmpvUDd0?=
 =?utf-8?B?ZUFuQ2RYN01CUGtHOWJ4aHdrUlB5cisxblRmWDNyZnFxWFVRREZGRWhtMDNF?=
 =?utf-8?B?RTVCanVRL2kvS0xVcmgvYUJKdG5BMW04cVIyVVpmV0p5ZVlQRVRkcUNNeXgy?=
 =?utf-8?B?V3Zqc0VMczltYUlHU1pTMzU3SDlKTmxrM1ZMcGwrRytrR1VNWk5VUXJYNHlo?=
 =?utf-8?B?am5EZTlLR1Y1d1NXS3Y0em80V2V5N1cyMUJtRzd4Um5QRUdKZkxzUVJEWmU1?=
 =?utf-8?B?aHBqTjdsaGE2TVIvTFBqbWZvWTJybTBFUVFOVDhYcGFmQlQzYk1GTm9sL01q?=
 =?utf-8?B?Z2EvSEx2RytNa0s5ZDRvekFCQ1VwTHM0SmNVWEdsbkpleXcxNmpNYWhFNUpS?=
 =?utf-8?B?YkM0cnp4YUs1WkhWWTBwODBORzVZWUhwUlRraEcwQjR4WmpKYXlnVjBZbXhl?=
 =?utf-8?B?a1R4anZJaktwWHpnWmJ6U3ZBd3hvSFFCeVZidlpaUUM1RTJPWGZmbWMwWmFS?=
 =?utf-8?B?amZRNG11UjdwNXBwamRjbU92N0s1VlFUaTNSQkFscHdQT3JXanFJZzIyZS9S?=
 =?utf-8?Q?kkEhOlWNgVu3ZLIXrwtJnv6OfHCSSghsZg/zHmx?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87ccb24-8043-4647-71e6-08d8fd8419e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 07:25:07.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXhD7SnkQCvisE/A63iyvZHUluwj7a1UdVsXXfDiwbXaZ9550hHvAcGZ3mpbs/vXpiPcZBz/ZvIx4lw68t/zzzG/qSubSu8pjseCiCEVFt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5924
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sZY29971uzWzg77WWXzaCizTx4520388AA=
Content-Type: multipart/mixed; boundary="6bqlrlfnf3N2O8ouCvHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618226731;
 bh=Cefw7wHvCzOSSGiV/YgQrD8xGIFB6aSCoqaj2D6oPFY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=AOeUrg/gIPGTKHfxD5Q3EfkokmYuMz/JvRU4g+lD6S6qCXnT/nx7hEEXFrngEnc4zYU
 EaIlEVbAs+lVUxADvxo9SmsaAQKqs3YgiZlDU3vs81SvdtDLo7OTd51EGcpzzfox+pDSV
 X3l0HvZL+GGOAEjqCAI/wsjhbOAalf6S+cQ=

--6bqlrlfnf3N2O8ouCvHI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggNC4xOS55LWNpcF0gZHJtOiByY2FyLWR1OiBGaXggY3Jhc2ggd2hlbiB1c2luZyBM
VkRTMQ0KPiBjbG9jayBmb3IgQ1JUQw0KPiANCj4gSGksDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQmlqdSBEYXMgW21haWx0bzpiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbV0NCj4gPiBTZW50OiBTYXR1cmRheSwgQXByaWwgMTAsIDIwMjEgMToxNSBBTQ0K
PiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o
5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil68NCj4g77yh77yj77y0KQ0KPiA+IDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4N
Cj4gPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47IEJp
anUgRGFzDQo+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFk
ZXYgTGFkDQo+ID4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4g
PiBTdWJqZWN0OiBbUEFUQ0ggNC4xOS55LWNpcF0gZHJtOiByY2FyLWR1OiBGaXggY3Jhc2ggd2hl
biB1c2luZyBMVkRTMQ0KPiA+IGNsb2NrIGZvciBDUlRDDQo+ID4NCj4gPiBGcm9tOiBMYXVyZW50
IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
Pg0KPiA+IFsgVXBzdHJlYW0gY29tbWl0IDUzY2VkMTY5MzczYWFiNTJkM2I1ZGEwZmVlNmEzNDIw
MDJkMTg3NmQgXQ0KPiA+DQo+ID4gT24gRDMgYW5kIEUzIHBsYXRmb3JtcywgdGhlIExWRFMgZW5j
b2RlciBpbmNsdWRlcyBhIFBMTCB0aGF0IGNhbg0KPiA+IGdlbmVyYXRlIGEgY2xvY2sgZm9yIHRo
ZSBjb3JyZXNwb25kaW5nIENSVEMsIHVzZWQgZXZlbiB3aGVuIHRoZSBDUlRDDQo+ID4gb3V0cHV0
IHRvIGEgbm9uLUxWRFMgcG9ydC4gVGhpcyBtZWNoYW5pc20gaXMgc3VwcG9ydGVkIGJ5IHRoZSBk
cml2ZXIsDQo+ID4gYnV0IHRoZSBpbXBsZW1lbnRhdGlvbiBpcyBicm9rZW4gaW4gZHVhbC1saW5r
IExWRFMgbW9kZS4gSW4gdGhhdCBjYXNlLA0KPiA+IHRoZSBMVkRTMSBkcm1fZW5jb2RlciBpcyBz
a2lwcGVkLCB3aGljaCBjYXVzZXMgYSBjcmFzaCB3aGVuIHRyeWluZyB0bw0KPiA+IGFjY2VzcyBp
dHMgYnJpZGdlIGxhdGVyIG9uLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgc3RvcmluZyBicmlkZ2Ug
cG9pbnRlcnMgaW50ZXJuYWxseSBpbnN0ZWFkIG9mIHJldHJpZXZpbmcNCj4gPiB0aGVtIGZyb20g
dGhlIGVuY29kZXIuIFRoZSByY2FyX2R1X2RldmljZSBlbmNvZGVycyBmaWVsZCBpc24ndCB1c2Vk
DQo+ID4gYW55bW9yZSBhbmQgY2FuIGJlIGRyb3BwZWQuDQo+ID4NCj4gPiBGaXhlczogOGU4ZmRk
YWIwZDBhICgiZHJtOiByY2FyLWR1OiBTa2lwIExWRFMxIG91dHB1dCBvbiBHZW4zIHdoZW4NCj4g
PiB1c2luZyBkdWFsLWxpbmsgTFZEUyBtb2RlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50
IFBpbmNoYXJ0DQo+ID4gPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBKYWNvcG8gTW9uZGkgPGphY29wbytyZW5lc2FzQGptb25kaS5v
cmc+DQo+ID4gUmV2aWV3ZWQtYnk6IEtpZXJhbiBCaW5naGFtIDxraWVyYW4uYmluZ2hhbStyZW5l
c2FzQGlkZWFzb25ib2FyZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNh
c2hhbEBrZXJuZWwub3JnPg0KPiANCj4gQ29tbWl0OiA1M2NlZDE2OTM3M2FhYjUyZDNiNWRhMGZl
ZTZhMzQyMDAyZDE4NzZkIGRvZXMgbm90IGhhdmUgU2FzaGEncw0KPiBzaW5nZWQtb2ZmLg0KPiAj
IEJhY2twb3J0ZWQgZnJvbSA1LjExIG9yIDUuMTA/DQoNClllcywgSSBiYWNrcG9ydGVkIHRoaXMg
cGF0Y2ggZnJvbSA1LjEwIGtlcm5lbC4NCg0KPiBJZiB5b3UgYmFja3BvcnRlZCBmcm9tIDUzY2Vk
MTY5MywgSSBkb24ndCB0aGluayB0aGlzIGlzIG5lY2Vzc2FyeS4NCj4gPiBbQmlqdTogTWFudWFs
bHkgYXBwbGllZCB0aGUgY2hhbmdlcyB0byBhZGFwdCB3aXRoIDQuMTkga2VybmVsXQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEl0
IG1heSBiZSBhIHByb2JsZW0gaW4gbXkgZW52aXJvbm1lbnQsIEkgY2FuIG5vdCBhcHBseSB0aGlz
IHBhdGNoIHRvDQo+IGxpbnV4LTQuMTkueS1jaXAgdHJlZS4NCj4gQW5kIEkgY2FuIG5vdCBmaW5k
IHRoaXMgbWFpbCBmcm9tIGNpcC1kZXYgTUwgYW5kIHBhdGNod29yay4NCg0KSSBhbHNvIG5vdGlj
ZWQgdGhpcyBwYXRjaCBpcyBub3QgdGhlcmUgaW4gY2lwLWRldiBNTCBvciBpbiBwYXRjaHdvcmsu
DQoNCkNoZWVycywNCkJpanUNCg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gICBOb2J1aGlybw0KPiAN
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMgICAg
fCAxMSArKysrLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X2Ry
di5oICAgICB8ICA2ICsrKy0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1
X2VuY29kZXIuYyB8ICA1ICsrKystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1
L3JjYXJfZHVfY3J0Yy5jDQo+ID4gaW5kZXggY2VjNGI1YzIxZWVhLi4zMzYyY2NjZWQwNWEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X2NydGMuYw0KPiA+IEBAIC02
NzYsMTMgKzY3NiwxMSBAQCBzdGF0aWMgdm9pZCByY2FyX2R1X2NydGNfYXRvbWljX2VuYWJsZShz
dHJ1Y3QNCj4gZHJtX2NydGMgKmNydGMsDQo+ID4gIAkgKi8NCj4gPiAgCWlmIChyY2R1LT5pbmZv
LT5sdmRzX2Nsa19tYXNrICYgQklUKHJjcnRjLT5pbmRleCkgJiYNCj4gPiAgCSAgICByc3RhdGUt
Pm91dHB1dHMgPT0gQklUKFJDQVJfRFVfT1VUUFVUX0RQQUQwKSkgew0KPiA+IC0JCXN0cnVjdCBy
Y2FyX2R1X2VuY29kZXIgKmVuY29kZXIgPQ0KPiA+IC0JCQlyY2R1LT5lbmNvZGVyc1tSQ0FSX0RV
X09VVFBVVF9MVkRTMCArIHJjcnRjLT5pbmRleF07DQo+ID4gKwkJc3RydWN0IGRybV9icmlkZ2Ug
KmJyaWRnZSA9IHJjZHUtPmx2ZHNbcmNydGMtPmluZGV4XTsNCj4gPiAgCQljb25zdCBzdHJ1Y3Qg
ZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9DQo+ID4gIAkJCSZjcnRjLT5zdGF0ZS0+YWRqdXN0ZWRf
bW9kZTsNCj4gPg0KPiA+IC0JCXJjYXJfbHZkc19jbGtfZW5hYmxlKGVuY29kZXItPmJhc2UuYnJp
ZGdlLA0KPiA+IC0JCQkJICAgICBtb2RlLT5jbG9jayAqIDEwMDApOw0KPiA+ICsJCXJjYXJfbHZk
c19jbGtfZW5hYmxlKGJyaWRnZSwgbW9kZS0+Y2xvY2sgKiAxMDAwKTsNCj4gPiAgCX0NCj4gPg0K
PiA+ICAJcmNhcl9kdV9jcnRjX3N0YXJ0KHJjcnRjKTsNCj4gPiBAQCAtNzAwLDE0ICs2OTgsMTMg
QEAgc3RhdGljIHZvaWQgcmNhcl9kdV9jcnRjX2F0b21pY19kaXNhYmxlKHN0cnVjdA0KPiA+IGRy
bV9jcnRjICpjcnRjLA0KPiA+DQo+ID4gIAlpZiAocmNkdS0+aW5mby0+bHZkc19jbGtfbWFzayAm
IEJJVChyY3J0Yy0+aW5kZXgpICYmDQo+ID4gIAkgICAgcnN0YXRlLT5vdXRwdXRzID09IEJJVChS
Q0FSX0RVX09VVFBVVF9EUEFEMCkpIHsNCj4gPiAtCQlzdHJ1Y3QgcmNhcl9kdV9lbmNvZGVyICpl
bmNvZGVyID0NCj4gPiAtCQkJcmNkdS0+ZW5jb2RlcnNbUkNBUl9EVV9PVVRQVVRfTFZEUzAgKyBy
Y3J0Yy0+aW5kZXhdOw0KPiA+ICsJCXN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UgPSByY2R1LT5s
dmRzW3JjcnRjLT5pbmRleF07DQo+ID4NCj4gPiAgCQkvKg0KPiA+ICAJCSAqIERpc2FibGUgdGhl
IExWRFMgY2xvY2sgb3V0cHV0LCBzZWUNCj4gPiAgCQkgKiByY2FyX2R1X2NydGNfYXRvbWljX2Vu
YWJsZSgpLg0KPiA+ICAJCSAqLw0KPiA+IC0JCXJjYXJfbHZkc19jbGtfZGlzYWJsZShlbmNvZGVy
LT5iYXNlLmJyaWRnZSk7DQo+ID4gKwkJcmNhcl9sdmRzX2Nsa19kaXNhYmxlKGJyaWRnZSk7DQo+
ID4gIAl9DQo+ID4NCj4gPiAgCXNwaW5fbG9ja19pcnEoJmNydGMtPmRldi0+ZXZlbnRfbG9jayk7
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZHJ2LmgN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZHJ2LmgNCj4gPiBpbmRleCBm
MTZjZDI2M2QyYzEuLjU1OGViZWZjZTRhYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcmNhci1kdS9yY2FyX2R1X2Rydi5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JjYXIt
ZHUvcmNhcl9kdV9kcnYuaA0KPiA+IEBAIC0yMyw5ICsyMyw5IEBADQo+ID4NCj4gPiAgc3RydWN0
IGNsazsNCj4gPiAgc3RydWN0IGRldmljZTsNCj4gPiArc3RydWN0IGRybV9icmlkZ2U7DQo+ID4g
IHN0cnVjdCBkcm1fZGV2aWNlOw0KPiA+ICBzdHJ1Y3QgcmNhcl9kdV9kZXZpY2U7DQo+ID4gLXN0
cnVjdCByY2FyX2R1X2VuY29kZXI7DQo+ID4NCj4gPiAgI2RlZmluZSBSQ0FSX0RVX0ZFQVRVUkVf
Q1JUQ19JUlFfQ0xPQ0sJQklUKDApCS8qIFBlci1DUlRDIElSUSBhbmQNCj4gY2xvY2sgKi8NCj4g
PiAgI2RlZmluZSBSQ0FSX0RVX0ZFQVRVUkVfVlNQMV9TT1VSQ0UJQklUKDEpCS8qIEhhcyBpbnB1
dHMgZnJvbQ0KPiBWU1AxICovDQo+ID4gQEAgLTczLDYgKzczLDcgQEAgc3RydWN0IHJjYXJfZHVf
ZGV2aWNlX2luZm8gew0KPiA+ICAjZGVmaW5lIFJDQVJfRFVfTUFYX0NSVENTCQk0DQo+ID4gICNk
ZWZpbmUgUkNBUl9EVV9NQVhfR1JPVVBTCQlESVZfUk9VTkRfVVAoUkNBUl9EVV9NQVhfQ1JUQ1Ms
IDIpDQo+ID4gICNkZWZpbmUgUkNBUl9EVV9NQVhfVlNQUwkJNA0KPiA+ICsjZGVmaW5lIFJDQVJf
RFVfTUFYX0xWRFMJCTINCj4gPg0KPiA+ICBzdHJ1Y3QgcmNhcl9kdV9kZXZpY2Ugew0KPiA+ICAJ
c3RydWN0IGRldmljZSAqZGV2Ow0KPiA+IEBAIC04NywxMCArODgsOSBAQCBzdHJ1Y3QgcmNhcl9k
dV9kZXZpY2Ugew0KPiA+ICAJc3RydWN0IHJjYXJfZHVfY3J0YyBjcnRjc1tSQ0FSX0RVX01BWF9D
UlRDU107DQo+ID4gIAl1bnNpZ25lZCBpbnQgbnVtX2NydGNzOw0KPiA+DQo+ID4gLQlzdHJ1Y3Qg
cmNhcl9kdV9lbmNvZGVyICplbmNvZGVyc1tSQ0FSX0RVX09VVFBVVF9NQVhdOw0KPiA+IC0NCj4g
PiAgCXN0cnVjdCByY2FyX2R1X2dyb3VwIGdyb3Vwc1tSQ0FSX0RVX01BWF9HUk9VUFNdOw0KPiA+
ICAJc3RydWN0IHJjYXJfZHVfdnNwIHZzcHNbUkNBUl9EVV9NQVhfVlNQU107DQo+ID4gKwlzdHJ1
Y3QgZHJtX2JyaWRnZSAqbHZkc1tSQ0FSX0RVX01BWF9MVkRTXTsNCj4gPg0KPiA+ICAJc3RydWN0
IHsNCj4gPiAgCQlzdHJ1Y3QgZHJtX3Byb3BlcnR5ICpjb2xvcmtleTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9lbmNvZGVyLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZW5jb2Rlci5jDQo+ID4gaW5kZXggZGU4ZmU3NGMw
MzYyLi4zMjVlMzAxZjk3ZTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JjYXIt
ZHUvcmNhcl9kdV9lbmNvZGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9y
Y2FyX2R1X2VuY29kZXIuYw0KPiA+IEBAIC00Nyw3ICs0Nyw2IEBAIGludCByY2FyX2R1X2VuY29k
ZXJfaW5pdChzdHJ1Y3QgcmNhcl9kdV9kZXZpY2UgKnJjZHUsDQo+ID4gIAlpZiAocmVuYyA9PSBO
VUxMKQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gLQlyY2R1LT5lbmNvZGVyc1tv
dXRwdXRdID0gcmVuYzsNCj4gPiAgCXJlbmMtPm91dHB1dCA9IG91dHB1dDsNCj4gPiAgCWVuY29k
ZXIgPSByY2FyX2VuY29kZXJfdG9fZHJtX2VuY29kZXIocmVuYyk7DQo+ID4NCj4gPiBAQCAtNjEs
NiArNjAsMTAgQEAgaW50IHJjYXJfZHVfZW5jb2Rlcl9pbml0KHN0cnVjdCByY2FyX2R1X2Rldmlj
ZSAqcmNkdSwNCj4gPiAgCQlnb3RvIGRvbmU7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlmIChvdXRw
dXQgPT0gUkNBUl9EVV9PVVRQVVRfTFZEUzAgfHwNCj4gPiArCSAgICBvdXRwdXQgPT0gUkNBUl9E
VV9PVVRQVVRfTFZEUzEpDQo+ID4gKwkJcmNkdS0+bHZkc1tvdXRwdXQgLSBSQ0FSX0RVX09VVFBV
VF9MVkRTMF0gPSBicmlkZ2U7DQo+ID4gKw0KPiA+ICAJLyoNCj4gPiAgCSAqIE9uIEdlbjMgc2tp
cCB0aGUgTFZEUzEgb3V0cHV0IGlmIHRoZSBMVkRTMSBlbmNvZGVyIGlzIHVzZWQgYXMgYQ0KPiA+
ICAJICogY29tcGFuaW9uIGZvciBMVkRTMCBpbiBkdWFsLWxpbmsgbW9kZS4NCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KDQo=

--6bqlrlfnf3N2O8ouCvHI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6358): https://lists.cip-project.org/g/cip-dev/message=
/6358
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6bqlrlfnf3N2O8ouCvHI--
