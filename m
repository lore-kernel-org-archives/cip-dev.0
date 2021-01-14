Return-Path: <SRS0=xuoe=GR=lists.cip-project.org=bounce+64572+6087+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA8C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 09:45:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DF3205CA
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 09:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF3205CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6087+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kYxzYY4521723x08QFisf2RI; Thu, 14 Jan 2021 01:45:53 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.98])
 by mx.groups.io with SMTP id smtpd.web11.5761.1610617552022251841
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jan 2021 01:45:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBi7xQP3dDM7gyPRFn27K4yeohkR77FQqHs9VxWdMldGhKvZkrZgdu8dMSzvFzPyCCgIuoIe9aA+fGgs8MDoWUlemq7jNHazbTYsqFgy/AuUAJM2FRqMxXqTV0Gi5ttHVP/i6ArQ4kIG7mzkMRFW4FwDaRYriUblZIWFLBZW+5choNBJr9d+CW46LtbZN5AwHbfqX5RROybSYBJOCW/teBXWcYQuuw/5rOF9IzRjV6X1IjVVvR5R8q/mfk+unokeUklXSr9p30DF3kk1hDYNtadAjiY6w8IAM3M23Z1pfUIsQ67G9PSSNoBS66B8KgKmXCPmF4Z0xRFZOz76lHngRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gGas1HxWq3Se3c1MhtcO4HBXVZofnylAUurDjZ6+60=;
 b=CnonMH6fscdyS9bZf+Tb65a6one1aAXRoKPQb/fPHe2LHszS6UVonv9UM7FWbA3mV8ri+z+7YYqodopUPLTbtqSzMvPRUYnc7eo+nhbVc1P37y0dkclbWQ3h3Ls6y5YNbEYSrI9LZ92KewomKVS9ctNoNmpy9C6dfSl1qzDwwBl2Ixjo0H/jO/m6xElV9+TCCktYtgRBiRs6aKndHLYno0Y79qB61maJLz9XMjdTDJGgQ4iIabUU9n3b8i2vfYdCTr7uU8uNMfJwMMdrP4VHL//P6del8BrV3dxJ/xlPx3sj0DJEabhc+vUJBRD6b1joURnCC0wVIz8tMsXRNLqLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB4870.jpnprd01.prod.outlook.com (2603:1096:604:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Thu, 14 Jan
 2021 09:45:47 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::e003:e079:b89f:bd1c%4]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 09:45:47 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU, PWM, LCD
Thread-Topic: [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU,
 PWM, LCD
Thread-Index: AQHW6djbQM7EgNfUJUG9MNVdLX7SiaomqjeAgAA12sA=
Date: Thu, 14 Jan 2021 09:45:47 +0000
Message-ID: 
 <OSBPR01MB50480DD74EB3E78CC6EC8696AAA80@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210113182058.GA25010@duo.ucw.cz>
 <OSBPR01MB29836C639D484CD9EBBA14A592A80@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB29836C639D484CD9EBBA14A592A80@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ee2f128-5c52-4025-ad20-08d8b8712bb5
x-ms-traffictypediagnostic: OSBPR01MB4870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB48702AC119B5CFE1EC60A037AAA80@OSBPR01MB4870.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 G9f6ziG8M1jFKgbjoOKSgv0CavmpQCnj5Gsj+9fA1fGb2K0ZYoTq1xEeDEDU+tpwYI7HM6Hm7iizpdd4gXt7sSR2lvWLJULkoLzUWOa1Kf2yDhDNsjdNBDXi5x3870els58QzjkmujRMYMnPPNFHXGn8tjL4wlwUDLltlJhGJwI7yC+Mq5pnyoAp1IOA8mK/7jLZ0IaLmWRDOuwte6jjjEt0lZaZhcCaIERaT+mrV+sdKXA/Zhthf0hEvnG70bUX8onGHlDFV5gE8SghtqSfPQ7Xpq1dTJqbd6t1eP/k/jAy2ZErpOpXS7nzzBBvMEVUOQ7PKuTHyE+snqqFnesW21M0v2ES4f6MgBg9euByF23YSINoWOD7olSuzjpY1l3qXMI3oRorcFGh56y4UF8C0g==
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?Nlk5YkhFZUFYWG1TelVlRlNiWXFRV0c5aWZFc2gzcHhmOTNEWFdsT3kreVhR?=
 =?utf-8?B?RmNaRWI1N2hienJ5U1pSSjBjZUxoZExyWHNJTENhZ2ZPcThRRldBU2t5Ykp6?=
 =?utf-8?B?L05zRnZRZnlHMUxZaVc5RExZTEFpRU9WOFh4TzRzYUNwUUJpVmk1N09mbWJV?=
 =?utf-8?B?Y1BEeVRYeU5ySUc4NzVOa24rbkJqVXVBY0tSYnpnVGo3SzNjOURiV1o5Uzlr?=
 =?utf-8?B?SGpsK2FlTUxpUEVULyt2WXR3MnN5YVhKMTJJZmppbHBMOENGNDJBVVFOTWpM?=
 =?utf-8?B?K2N1Q3NYYWp6aG5nS1ZLdTRqTjh0NFVsQjVGTHgxMkZlU084dlJlU1l6NnVK?=
 =?utf-8?B?L1VmZG1lT3pLS3hlcGNwYitaRUc4aXpILzlEemZGN2FxYmJraFoyNHhTTHM1?=
 =?utf-8?B?dGl2WG5nY2UrdWYrRG50dno3NlN4aG5Va1dCclVjbmRBcVFkUUxnM0srWFVi?=
 =?utf-8?B?R1B6MUJtYk5LTEVsaUhpWHZJV1FxSGpaNml4S0doTnlMK1JRS0NUMmlBejhz?=
 =?utf-8?B?Qjh4QzZDQmdybnVsdzEwZVlYZUtTM3M5SEpFSDd1aXVFMUlpV3EyVGJKYWFt?=
 =?utf-8?B?TTZTWUNITGxXVlUzOE1RVnY5MjhCemFZZnZXZTV2dm1zZUp5OGROVWZBckl1?=
 =?utf-8?B?cllZSzFqUkVqU2xwMFE0TzhzTnd3eHpOb2k3QWQvUGZKRlNqRUdRZXY2a2V4?=
 =?utf-8?B?ajhOZ3hJVXk2ejh3TVFiaFFvTzlDNVNNWENpRElSWWhXYzRVMnpDa3ZrV0VZ?=
 =?utf-8?B?Nk5vZTJkVnY2Smh5b2x6NHA3ZWxDbjhMTG9ZMmlNdzRSTjlnODdKcEFVNFZJ?=
 =?utf-8?B?SW9YeVRRN0l5NklaOEJCQXBPT1dLb09uUFU2cFhoNWw5eGJLbHpqNGFWN0Ew?=
 =?utf-8?B?ODFROHcrdmJqNWlzSjNEczlqbThKQ3R0N1Rmd3BBeTU0UU55dERaNVZuZGxU?=
 =?utf-8?B?QjVQTzEweVZDVkJaQ1RyU1VJVW5PS01XaFNKSFJrRCtZdnljMUxUWlFSQlpa?=
 =?utf-8?B?Mm9waTZYNkFvdlBnSG9TODRJbWVGaVZIU2l6WlE3RzRZMk5GUUpyWm1xaTdD?=
 =?utf-8?B?WUNRK1lGc2lrZWlld1RxVGxYTUovZlJteFFEdmZBU3JSRkJXN1VwMnp2UGtG?=
 =?utf-8?B?aXNPelNpL3YrYmhhYUQ3Uk8yMGRhMWVNUytWZXgrcUF3Y1JtR1RWYzBYemcz?=
 =?utf-8?B?c2pFTXltNWcvUGdTbFBiSEF6MVZrMGJ5OU9EbWs2SWtaV055OUV4L28ybnpX?=
 =?utf-8?B?aGFjQ2F6YWVtcUlsY2RqeFNTQ2JGMVYzNTdic2gzNXpXbFF3OUE5UmY3QS9a?=
 =?utf-8?Q?iJ0QgYuQ9Spgs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee2f128-5c52-4025-ad20-08d8b8712bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 09:45:47.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhejFkLgl+YJzFIZBlNGB4DFSvaxaMIrNeTQiEH3tF1C0JY8CLJbEjZIOzpET0W3jeGqID3pMA7Hn9juTdSf52DMQPJrqNolIDbvfWkx7wnXR7VO8JxpGAa6DoqQJ8c/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4870
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uPJt0rxJDHfDwSBfiL9jBQSBx4520388AA=
Content-Type: multipart/mixed; boundary="InCMEC4XhcyzVoYBfSh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610617553;
 bh=VEtUR6zBOmc60cnbt9V4tZbWtUcowYCRJiuaBw5y9ts=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rmReLAbDnF/752O8ACFJ6Nbra0rttQo5jS0vLMoMJNFcFLbIJRJYWS5zuC0l6SEGcwW
 PhMFsZ/5SurhV2+w4peYQdP8r3ahv3/ri6gqqV4BRAAxxaDc2gD4s4Z8UqBuPsjh6q8rj
 nrG0iwwHtRRL2WoQltrnj/9kas5QBSzcRM8=

--InCMEC4XhcyzVoYBfSh4
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTm9idWhpcm8sIFBhdmVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU2VudDogMTQgSmFudWFyeSAyMDIxIDA2OjMyDQo+IFRvOiBwYXZl
bEBkZW54LmRlOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5y
akBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggNC40LnktY2lwIDAvOV0gUmVuZXNhcyBSWi9HMSBhZGQgc3VwcG9ydCBmb3IgRFUsIFRQVSwg
UFdNLCBMQ0QNCj4gDQo+IEhpIGFsbCwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiBGcm9tOiBQYXZlbCBNYWNoZWsgW21haWx0bzpwYXZlbEBkZW54LmRlXQ0KPiA+IFNl
bnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE0LCAyMDIxIDM6MjEgQU0NCj4gPiBUbzogTGFkIFByYWJo
YWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IENjOiBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/
oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+ID4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgQmlqdSBEYXMNCj4g
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC40
LnktY2lwIDAvOV0gUmVuZXNhcyBSWi9HMSBhZGQgc3VwcG9ydCBmb3IgRFUsIFRQVSwgUFdNLCBM
Q0QNCj4gPg0KPiA+IEhpIQ0KPiA+DQo+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMg
c3VwcG9ydCBmb3IgVFBVLCBQV00sIERVIHRvIFI4QTc3NDIgU29DIGFuZA0KPiA+ID4gZW5hYmxl
IExDRCBvbiBpd2cyMWQgYm9hcmQuDQo+ID4gPg0KPiA+ID4gQWxsIHRoZSBwYXRjaGVzIGhhdmUg
YmVlbiBjaGVycnkgcGlja2VkIGZyb20gdjUuMTEtcmMzLg0KPiA+DQo+ID4gU2VyaWVzIGxvb2tz
IG9rYXkgdG8gbWUuIEkgY2FuIGFwcGx5IGl0IGlmIHRoZXJlIGFyZSBubyBvdGhlcg0KPiA+IGNv
bW1lbnRzLg0KPiANCj4gVGhpcyBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSwgdG9vLiBJIHdpbGwg
bWVyZ2UgYW5kIHB1c2guDQo+IA0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCBhY2NlcHRh
bmNlLg0KDQpDaGVlcnMsDQpQcmFiaGFrYXINCg0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgTm9idWhp
cm8NCj4gDQo+IA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IAkJCQkJCQkJUGF2ZWwNCj4g
Pg0KPiA+IC0tDQo+ID4gREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFn
aW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+ID4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmlj
ZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

--InCMEC4XhcyzVoYBfSh4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6087): https://lists.cip-project.org/g/cip-dev/message=
/6087
Mute This Topic: https://lists.cip-project.org/mt/79653996/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--InCMEC4XhcyzVoYBfSh4--
