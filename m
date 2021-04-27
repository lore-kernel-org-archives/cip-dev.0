Return-Path: <SRS0=mwdk=JY=lists.cip-project.org=bounce+64572+6398+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F117AC433B4
	for <cip-dev@archiver.kernel.org>; Tue, 27 Apr 2021 00:48:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DE4611ED
	for <cip-dev@archiver.kernel.org>; Tue, 27 Apr 2021 00:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DE4611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6398+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2zBaYY4521723xY80iOvTwXJ; Mon, 26 Apr 2021 17:48:37 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web08.2158.1619484515737517057
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Apr 2021 17:48:36 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id bJrF24953A;
	Tue, 27 Apr 2021 09:43:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ55tI6of/Q0LawTasqOTMcEQLjmuEZ3P7WwPf0yXi9Fxbdeg0Kr+5IvCVZQ8t2QqJ/RCj4TnAqLJ4hg1EL3kgxWTV5UrMhZcmRjlOB4CpzujiD2r8NyV1CdcNm5Gi1y1hIZ+ugXXuLwM0pSbWsf8o/8TjdrVyVrE2yc/21EyPO4EfPqh52OKx/2N8c5mMm14PQ8g5KHMant5AqeMyIl7xFAn/ZOxo/qHz1OMOPzfOyGzYZADNHg0SNRzqu8PnrMslKxlatblrPOYPuUoQtwvci1jHnMm0ruMETFZ96/mjlwu91SR+tby00b4wYw9sRACZcT7sVjlseXHj3kHuOxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAPc6y5jWqWXo6+mWs4ix44ZJsvv95uByKKlfs5mSfI=;
 b=Ean6UmDeAkalTOTLYeGtVF7r93rfc/f+OFibwbSY6+OKUV8iIhhA4PYbuULHOkBEY17oSHAqvkpu2ieJWe6Yfo3McCUxJuZWwIXq6BMRaSFiPJfUp3hzzNF9/wn6M9n2jDdLp0ljlMv8abEADGE4oTapn0gJmb8bb2V+OF+pviBiM3xcaMmr2uMipcXTXUMm4zvZKGArpMw5njZT+ouqSIcNLomJvrIwpi3gySezh3A/TlqGxLUX5yMkSz96cckGSGC48209720PgJWEIugIjxZsxXrz69lAibWQYS2cr4dr0oqXpQQdt9uido8LSVmyLQhlvOs5R+du9P/6h5QHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com (2603:1096:604:7d::19)
 by OSBPR01MB3366.jpnprd01.prod.outlook.com (2603:1096:604:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 00:42:47 +0000
X-Received: from OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::28c7:f138:a2fb:6d]) by OSBPR01MB4967.jpnprd01.prod.outlook.com
 ([fe80::28c7:f138:a2fb:6d%3]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 00:42:47 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
	<minmin@plathome.co.jp>
Subject: Re: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the backporting
Thread-Topic: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the
 backporting
Thread-Index: Adc6XySnLTu+cWedTlKOJgoSIwGVRwAPiYmAABefKdAAAG5r0A==
Date: Tue, 27 Apr 2021 09:48:32 +0900
Message-ID: 
 <OSBPR01MB4967B8175C319A1F071F46F2A0419@OSBPR01MB4967.jpnprd01.prod.outlook.com>
References: 
 <OSAPR01MB496166751E93E55A64756505A0429@OSAPR01MB4961.jpnprd01.prod.outlook.com>
 <070cfa43-dc83-b3a9-366c-e07b122b6d34@siemens.com>
 <TYAPR01MB6252FBA097F34080E4A2C49C92419@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB6252FBA097F34080E4A2C49C92419@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ea9375-4c51-41e2-43bc-08d9091560af
x-ms-traffictypediagnostic: OSBPR01MB3366:
x-microsoft-antispam-prvs: 
 <OSBPR01MB3366FB91A94710C5498BA13DA0419@OSBPR01MB3366.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 C8iNRRfvevGfTNNuX5alPMDOFfjAWKhQflIjkh+J7OSx6ywEtD7Ne2U2boqP4x/51ARmU6/ZK5bynGPRN1Jgzkxr0xkIgLEfINtk2MI5o/nV1LXhvd5oMRiQllCcCmPzyJVGx4x93oUlAkNjehu8Z9xsvAyJO4kuqG0LtD6GTOQvYsweufKOPZ9i8f+TciaKh/gwWzwxwBGtZr/IBqnzviK5yb+ouudrabVPggLQyVEijGtU9YL2aLZ6C+WyELVakCADlwc55dUFFiIJeB9hgSP57WNVKmfaNPeUxngC1L3siSoOm0GR7pPzGLzlgFm67qnOl5eU9ujedafzosAdaSF1on2hTHCIR4J6sctT3ZJpFXUpYdvnnPxofT5JWE+hvnp9bSEReaL13EjjTgD+QEfCKPNYs4mqRTsBIJDfv015imMfzCx6IXSCXRnktitHLnmpmTIRNFelo2voWuAhHrzIK8PV0dXn0oDCy6WPg08LQZAECq3+Imla7G5BzRABpRM2OEJ/+cCna/v5ouC8sxN5El/acZZ3EZABCjyJj3M0L2kvbnQGiiIzqx9IZQxFswExDDRrXm/s2ZF5OlZXCBCMRPRbCk4SRBJ6F6/vJc3kQfqn33Sv+W7WC9ZdpdDZx+Xlbnt/wIaeIMVL3drBFCJ5vjq9rix3H6cyecd7GRBDEn/pQLyJ495SkAX4CTbf
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?V2ZoTzA0ODYrSjBaR3VZdGxuWWc3TU5NWUVwczBnZTNzS1E0VGJxSEF5V05z?=
 =?utf-8?B?YzBtZkt2bDVBQ0xORzNJbU5oeXNZSitIRTdZMGkyeGt4N0hzTFU5aTdzT3R5?=
 =?utf-8?B?M2JUZDBtL2lDZGhSVTlCRG9uSXhUU21MK1hYKzBaMjN3TTBhS1krUHMvTkFJ?=
 =?utf-8?B?QmY5eFZCbG9zamlBVGk3WlRiSmR3azBFd2F5M1YwVGFBVnIyd28wNlFUMUg2?=
 =?utf-8?B?N1lSb3U1TVVMeEcyVlRYNXFDdS9tWWg5aEZJUEMxVlNJbDNkOGhXMmdTcjEy?=
 =?utf-8?B?TWYrOWhWUWc2RURCM3hqK0I4Z3gvVFYycDQrSlJ0clNkTjNEeDNWWXBtMnA2?=
 =?utf-8?B?bGN4dGZBSmd2MitvL2xjUThIYzMwV0FPRzRSVDBVNy9QU21jRy9qdmc0ZFZX?=
 =?utf-8?B?QTVMc09KMFNoWHNXb3dJcktXOE5vYzZ5eExzOFBUaDNGM3BlRGIwZlFBL3Bm?=
 =?utf-8?B?ZG54Rmk2cWxBZUMzOTBZcElTelFQc1lEN3owb3FmbkliTXZQd0FBUlczWTFC?=
 =?utf-8?B?SzluWXdTQTRzcWJlMWJNMFhPeDIwallRL0twWCt4WG43RWgrRUJ2SGxvMFEr?=
 =?utf-8?B?NFFRV3k2UWxFOUlDRmpqVmJURm5QUWpoZ0szdG1YOEgrZElOQlRiemE0bXRy?=
 =?utf-8?B?TmViMThIRngwT3FNZGUvWDNnWXFESWF2NTZWT1ROZXU1QmlKTnBiSEJ0ckVF?=
 =?utf-8?B?S0JBM1k5NUh2bzVESmRXb2xpMzJvL29PeWJZd0U4dHRRWjZXWkJJOTY2NE9q?=
 =?utf-8?B?RHg5YTBCaXJZZzJucHFxNHduQ3ZjT2FETzdXL2lxZDJ3NGd4ai93OWhmdjJE?=
 =?utf-8?B?cW03Wll6VGhFd0NFY21jNDRNOE9OcUVneGlMSng3T29UOGppRTBGbks1Y0li?=
 =?utf-8?B?aXFFSTZWVkxVRHJrQXF0VTVmMXhaSGE4aSs5amVtcXhFa1ExM3ZKdGhabEIw?=
 =?utf-8?B?WEppSzJWY3BQM2FyOGNxS1lvcElTcU5PeEF3RXREMHg1a2UwOWROWFB1aVph?=
 =?utf-8?B?VlA3Sy9YWHJLLzRUeWZwbFk0TXppSUhITm1SL1RrZURrTWFWT1FnUkVkZ0Qx?=
 =?utf-8?B?ejBiV2ZQWlZ3V1AyM3JIQm4veGgwMGxPbng4cXMwcVR4ZlVWQ1VQcmhrQkYy?=
 =?utf-8?B?RlBwTk9telVwVFk3ZXVKVlA1SWdzSGM1WUVpRGdYMDJnWllVNVhweWVJNlRI?=
 =?utf-8?B?NFBrdFhVaEVFL2krbFM2b3dHRGdNYnU3UFJsQ2dpejc4OWVuYmhhcjRyNm5t?=
 =?utf-8?B?TkpvcGFNbUtPZmFvTWVYMkxiejlNU0E3dU5hSXFWSGxMN3hQS3ZWZSsrdmo5?=
 =?utf-8?B?d3QxQURtUUhjdnF0V1pwWS9PVFpSNnNBZzBPVVVzTFNjZzJQZUcwTjcvUFha?=
 =?utf-8?B?MC92NUZMdStvdTNSYWVXdU9kaUpwVVhNaGhUNWxwRDhQSStsbWZhcUF3U1FS?=
 =?utf-8?B?RGhKRkN0SU13bXdBcEZ1MVJ2SjcwazNYUWN4VmtTMC9Db1FPUFJlQ2Y5YjRI?=
 =?utf-8?B?QlltNkVKTTJKOGNoSFM3YkRmcnZKVzRRc0VXc2dvUngxdW9TeE4xcnpWR2xK?=
 =?utf-8?B?NXRZQ0ptd3FYUE83Z1ZIYk4rVUdGaHplMHVIa1NvQVkzT2c4aUY0M0NQM2Nt?=
 =?utf-8?B?NWdTU0plU2lqZXdPNlgxV2lXZUZmWTQ3bXhIdDVnMUpjZG55RHROaVRTaFdZ?=
 =?utf-8?B?S2djVk54N1dRSGtwV3JYQ2x3aW1WRHNCNW80RXh2RlZGU2J2MzZMdjcwWlJp?=
 =?utf-8?Q?x7KVAItjgl9b5CYLCnCLJan+6q1TTHSsq3Vl066?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4967.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea9375-4c51-41e2-43bc-08d9091560af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 00:42:46.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPRiGXvmLeDG4FOgvd8D1ZutU8OBD5IoQwBmOlb/8gtoknZK2aNEn+H5fKVqeEYgaSzXLvTp2Xl1lnFJoJlz8CV/hI2JDOQi9J0/y2XXuOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3366
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lxc2tJG4yu96BHJTYZvTIQYJx4520388AA=
Content-Type: multipart/mixed; boundary="OtY5FxrOtQpnyk2DBxS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619484517;
 bh=xAVsc7K/7mNkr4ZmU68ch8kgBCM+/QultiIDZOSKio8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LfegdVO54RXw0Kysq8WhIrbnbG03DJR9bx+v1KQ578uHwfDJ9TbskTx3FftHBPimNfa
 y2C8kghCoEeB6xLD7hralJI4xpbY1R4v9EIz9htMo6d9Ua1Tq9+skiZx389m+VXftroql
 4hjD+bOTBdmmNJurWBBnHslBHupRPhiB+0A=

--OtY5FxrOtQpnyk2DBxS6
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEphbi1zYW4sDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KSXdhbWF0c3Utc2Fu
LA0KDQpUaGFua3MgZm9yIHNoYXJpbmcgdGhlIGxhdGVzdCBzdGF0dXMuDQpTbywgbGV0IG1lIGRy
b3AgdGhpcyByZXF1ZXN0Lg0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU2VudDogVHVlc2Rh
eSwgQXByaWwgMjcsIDIwMjEgOTozMiBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc7IOW3peiXpOOAgOmbheWPuO+8iENUSuOAgE9TU+ODu0lvVOS6i+alremDqOOAgElvVOaK
gOihkw0KPiDmnKzpg6jvvIkgPG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwPjsgbWlubWlu
QHBsYXRob21lLmNvLmpwDQo+IFN1YmplY3Q6IFJFOiBbY2lwLWRldl0gW0lucXVpcnkgZm9yIENW
RS0yMDIxLTIzMTMzXSAtLSBuZWNlc3NpdHkgb2YgdGhlDQo+IGJhY2twb3J0aW5nDQo+IA0KPiBI
aSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnXSBPbg0KPiBCZWhhbGYgT2YgSmFuIEtpc3prYQ0KPiA+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MjYsIDIwMjEgMTA6MDkgUE0NCj4gPiBUbzogbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanA7
IG1pbm1pbkBwbGF0aG9tZS5jby5qcDsNCj4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtJbnF1aXJ5IGZvciBDVkUtMjAyMS0yMzEzM10g
LS0gbmVjZXNzaXR5IG9mIHRoZQ0KPiBiYWNrcG9ydGluZw0KPiA+DQo+ID4gT24gMjYuMDQuMjEg
MDc6NDksIG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwIHdyb3RlOg0KPiA+ID4gSGksIEph
bi1zYW4sIE1pbmRhLXNhbiwNCj4gPiA+DQo+ID4gPiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0
Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS82MzgyDQo+ID4gPiBBcyB3YXMgcmVwb3J0ZWQgYnkgQ2hl
bi1ZdSBzYW4gbGFzdCB3ZWVrLCB0aGUgZm9sbG93aW5nIENWRSBzZWN1cml0eSBwYXRjaA0KPiBp
cyBub3QgeWV0IGJhY2twb3J0ZWQgdG8ga2VybmVscyBiZWZvcmUNCj4gPiA1LjQuDQo+ID4gPiAJ
Q1ZFLTIwMjEtMjMxMzMgW25ldC9zY3RwOiByYWNlIGluIHNjdHBfZGVzdHJveV9zb2NrXQ0KPiA+
ID4NCj4gPiA+IEF0IHRoaXMgbW9tZW50LCBzY3RwIGlzIGVuYWJsZWQgb24gUGxhdEhvbWUgYm9h
cmRzIGFuZCBTaWVtZW5zIGJvYXJkcy4NCj4gPiA+IFdlIHdvbmRlciB3aGV0aGVyIHNjdHAgaXMg
cmVhbGx5IHVzZWQgb3Igbm90LiBJZiBub3QgdXNlZCwgd2Ugd291bGQNCj4gcmVjb21tZW5kIHRv
IGRpc2FibGUgc2N0cCBmb3IgdGhvc2UgYm9hcmRzLCBhbmQNCj4gPiB3ZSB3b24ndCB3b3JrIG9u
IGJhY2twb3J0aW5nIHRoaXMgcGF0Y2guLg0KPiA+ID4NCj4gPiA+IFdlIGFyZSBsb29raW5nIGZv
cndhcmQgdG8gaGVhcmluZyBiYWNrIGZyb20geW91Lg0KPiA+ID4NCj4gPg0KPiA+IEkgY2FuIHRy
eSB0byBsaXN0ZW4gYXJvdW5kLCBidXQgSSBzZWUgd2F5IG1vcmUgdXNlcnMgKGJhc2VkIG9uIGNv
bmZpZ3MpIHRoYW4gdXM6DQo+ID4NCj4gPg0KPiBodHRwczovL2dpdGxhYi5jb20vc2VhcmNoP3V0
Zjg9JUUyJTlDJTkzJnNlYXJjaD1DT05GSUdfSVBfU0NUUCZncm91cA0KPiBfaWQ9Mjc0ODgxNCZw
cm9qZWN0X2lkPTYwNTI3OTgmc2NvcGU9JnNlYXJjaF8NCj4gPiBjb2RlPXRydWUmc25pcHBldHM9
ZmFsc2UmcmVwb3NpdG9yeV9yZWY9bWFzdGVyJm5hdl9zb3VyY2U9bmF2YmFyDQo+ID4NCj4gPiBJ
biB0aGF0IGxpZ2h0LCBhIGJhY2twb3J0IG1pZ2h0IGJlIHJlcXVpcmVkLg0KPiANCj4gVGhpcyBD
VkUgcGF0Y2ggaGFzIGFscmVhZHkgYmVlbiBiYWNrcG9ydGVkIGFuZCB3aWxsIGJlIGluY2x1ZGVk
IGlmIHRoZXJlIGFyZSBubw0KPiBpc3N1ZXMuDQo+IA0KPiAgNC4xOS4xODktcmMxOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9zdGFibGUvMjAyMTA0MjYwNzI4MjAuNjIxNTgwMjIzQGxpbnV4
Zm91bmRhdGlvbi5vcmcNCj4gLw0KPiAgNC40LjI2OC1yYzE6DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3N0YWJsZS8yMDIxMDQyNjA3MjgxNi42MzEyMDE5ODhAbGludXhmb3VuZGF0aW9uLm9y
Zw0KPiAvDQo+IA0KPiBBbmQgNS4xMC55IGhhcyBiZWVuIGZpeGVkIGluIDUuMTAuMzIuDQo+IA0K
PiA+DQo+ID4gSmFuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgTm9idWhpcm8NCg==

--OtY5FxrOtQpnyk2DBxS6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6398): https://lists.cip-project.org/g/cip-dev/message=
/6398
Mute This Topic: https://lists.cip-project.org/mt/82371605/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OtY5FxrOtQpnyk2DBxS6--
