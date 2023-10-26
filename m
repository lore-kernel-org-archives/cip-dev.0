Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E768C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 04:42:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.63552.1698295352988574156
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 21:42:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 39Q4gUP91296988; Thu, 26 Oct 2023 13:42:30 +0900
X-Iguazu-Qid: 2rWgHjD2dmSL6Wilbn
X-Iguazu-QSIG: v=2; s=0; t=1698295349; q=2rWgHjD2dmSL6Wilbn; m=11GNnofG5pD0NeOT3X1B98fhnRvS/l0u0W+mWmk0P3w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 39Q4gRqm2905748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 13:42:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP0tmp7mETWD8WvNF4z2XMiYctqVBicE082J60qB60Nr+v1ZX94YWWpc+17+//mcFQtSsEM+7uX1Fz6FYVbBGviRBJyI8kW/8jJBCKJjNvIGRsJqITgGvCRLM6EGIBK7BIPqJqz3Si39stOFXpStS1rBPW2XUloRElgnFdAZdDQR/QiZm5ddzeua4Zj9sHbnhhR9+Q9h4McjMXHGLMGN8G3IgCbI5Qhmo4RKADKpq1DGjLfcV9IK4lrNgJZECcD+lOapQkE/Grfrjgf9EKz76qWDkpRj6x6D4W4ZLROwxRwv9MUdpLawX4EAZIKmoKgkNyKBriXH58ijiYEVnFUPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDb7U1zCn10iPqlhxEbQE04Zz/crCWn5EBipF0PLCFc=;
 b=MSmfwqxubL1olxRh3H90GULOwFMZSMG+grgwsVWcKJeHtKsFU2fDgFcWTZuVWs5/mjD0ci4vakHugBKhWm2aOdxmhvS73X/DM5QfwuanD4HjNoGezqD8+rQinYZsqOohOas5ChbRROhLdF6AFQHdhgEHj1Cpu1EMy8eAOB1usiJYCpHNEjfNCsXRm2uj3uYBc9zwp6ahdS6r6+5mcy9TXqIjYaPWOg/CL0t8PPv7KKcKnlisXEkNhkxu64fASdtnR2FotiIlTSnQ6uQVCO0wy6jPOkQtmb//89b7drrfqs7zbhYw0uU8yPOOf0I3PTKQfct+28GrthcxV5qagWrHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <Quirin.Gylstorff@siemens.com>,
        <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev][isar-cip-core][RFC 0/9] cleanup of customizations
Thread-Topic: [cip-dev][isar-cip-core][RFC 0/9] cleanup of customizations
Thread-Index: AQHaBcIG20/mU/LDd0eyT7OGZPisDrBatomAgADJfxA=
Date: Thu, 26 Oct 2023 04:42:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB68564FB34324487E970D617DA4DDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <f4f3487d-a5c9-4da6-8c3c-2df750362c83@siemens.com>
In-Reply-To: <f4f3487d-a5c9-4da6-8c3c-2df750362c83@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6856:EE_|TYCPR01MB10618:EE_
x-ms-office365-filtering-correlation-id: 6601c8ac-22a6-4746-8c96-08dbd5ddf325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rC9y9rDZ3AqF4pA2evKkQHF87zcUw0ujY5BPYSx5x+/+KM/vBhmRa2Gls7rWEY4ck3luOtPFpryaUIHp7irtHRZmo2+aOMNSlsCK/rQuQ2w8Fo73Yxj6Cd5jQmec5Q/74wK5aRxEgmdiMmFdNrkMsdPw5tXeoSkcg8uGKAmRNRJgi4RZwRZMA1Q3IoSOZjmqKkzFE4wgEa7rVbnsDfTVEJ2v6xi1eC6DDvSARST4pEITKkonKPQlWiDuLoEoPaHtR5ey7d4KSeAh5M4VWVndUDeWPZ3Vm1EnDpM3yty/sXYp8ifJ/wYpOgSBlbZt9iHpKDeLLeYfym+CxD40I+3DTFz7SjQOuPGmIXTq11Bb6OuP5u6YDPYn797pvLtNZt8RTG9y73ngLTqB7l2twx05C3JN9+AWuZZByJdZCDqCFuPE6m8pOFmzibCkLSqDZZoREunXzUFavdOVNVQZ+o2ipQHARrxZRJ04hQXGqGbzWrsbSOTEbeY/jhvKPLFaWwxNu2t6JmYO7xk9YT5vmKb47ELxva6+659VtlDkiQrpDPbEwJElFd6gY6D/x7vqVrqWGIvTrkcymxLmyVYumGO3pHvgkiV8gifZWtVqQIp/fWeeoJfQO/KEegFfP+y5ApPV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6856.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(41300700001)(38100700002)(66476007)(55016003)(64756008)(76116006)(85182001)(66556008)(66446008)(122000001)(71200400001)(478600001)(6506007)(316002)(7696005)(66946007)(53546011)(9686003)(83380400001)(86362001)(5660300002)(52536014)(33656002)(8676002)(8936002)(110136005)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TEZDazdxNGp1RFZrZmpiNFNxcjAwUmZiS0FpVlZpWURHOTFmTG9YNHRIck82?=
 =?utf-8?B?bHJ3V01SK0dVbDF2TGR3SjZTZFZSNW5VNFV5c3dTTHdFOUFXdWlqUDFPM2I1?=
 =?utf-8?B?NW81OGxWRXo0ZjMwckdWRFpGOFlHTkQyOHl0bDJ0dERkZHJ2ZjZyeWhQZmUy?=
 =?utf-8?B?R1l5RUZrRVRxMk1sNG94SmcxbVJmWm45VzY2TjZMT2Y1QmwzNGJUcTE4Mk9G?=
 =?utf-8?B?QytRVm40bVlMZUM3YjIySVA4NkJ2c083d25McVZOZzNhc3VvYTJ5Njhiczh2?=
 =?utf-8?B?b3JQMWQrSmU4ZDNxVkdLZThiWEluaUFJeTNxcWlrOGdOd3pQbzh4WmhOSndJ?=
 =?utf-8?B?TjF2cFNwTFc2NGJJbmRXV2V5aFlBeENrckh2SE9UTDFZYWNEdFRVYUt6eW9x?=
 =?utf-8?B?TTZPeFNaVkZBRXFOSi9rRDh3N3VqZHJDcXNXVzZ5dm5Ib3dIWHYzbXg1K3o4?=
 =?utf-8?B?QlRzMHh4QlZnUDBmZ0Y5czZLRHJ3TEJBdVVNNE5pREkvQ045WWJmalVaNy9a?=
 =?utf-8?B?L0JZbDZCZEhyai9ScFJmWGtBR0dKQm10cFVWZE1TNTBST1owTGdmTDBxcUNS?=
 =?utf-8?B?SEFDZmhYaVgvK2tHaGcyVzJWemJZQW4wYVNQTmFzbkpKM2lxRTdKMUg2TTg3?=
 =?utf-8?B?QVpVUUxYZUwveXZhajNPSGJEOFAyY3pseTZmbWxqd3FwQ25HVjRXdWNjRHBo?=
 =?utf-8?B?L2ZWdkZaaDJaRHdMWDV4SmxXYThGSDlWSGJ1UWVoQ200V2Fnd1Azd3BacWNl?=
 =?utf-8?B?RkNkZXpoWXQ3Q2lkVWFPMXRJY000dVlYaG5DeXYwN29TMFFJUDF5ZWZjUkt6?=
 =?utf-8?B?N3hzblFmMzZqN2xMc1ZtaG9sUWkwSko1S2hxMjNQM2RKakE4OTJxMEtJYWRl?=
 =?utf-8?B?MzNXU25XMmlURkFsM204MVVETVJnR2lYTHJndjltekI4MllwMldFekI1ZWZ1?=
 =?utf-8?B?dHFUaHVsZVVKUzRJUloxNFNwYXdXNE1Qa29EcDZMazU1eEVLbVdUdGpYWCti?=
 =?utf-8?B?dUU0NHNJSldGUERFQlhIaVBhYWhDWWwvajdadWMvSU9jazhrYzVNcno2TllS?=
 =?utf-8?B?MVdRc0k3Y1pSd2dKajdXVXlTY1JSRWJaYzYwNzJpMElHQWNwZG83L2VlN08v?=
 =?utf-8?B?UDhXWlRGSmdMQXNnRkZEU2lHclluQlFPZGp1S1lIYjNRUVFvU0JTaWxuSjQz?=
 =?utf-8?B?NzJpeE1GaUhZd0dXRkswLzNNRm1sQzduR1cyRXZXcVNTL0EwcEFuaHFvWXJr?=
 =?utf-8?B?NWNPUTdHU0xWenhBb1JjSE5qQ1crQTkwQWVMd1pvV0FxQjNxOXZTMlNHTUZx?=
 =?utf-8?B?U2pGTTVMQnhBK29CenFldUM4UldMQjdPSzVuMGgyNU04aUJ6cmoyV2lEMVZH?=
 =?utf-8?B?WXdzK04yUGVCUDVLVEQ0bGRTZGUzbnFQLzlIVEtuT3hGMVFYODBwTTNsT0lU?=
 =?utf-8?B?dmxtQVk4dDRSeTE1a0ptM3YrTWlxNHJwS1ZNV28wL1paYVpvSjRmL245OVhm?=
 =?utf-8?B?aE84SUlCT3lCenF0bTl0MUt1SVY0b0JudTRHelJibmpMTGZHbDF6Z3lBNWtO?=
 =?utf-8?B?YmhDUzRZNWNZcWRFZE8xUzgzRHFVY1hBNlJaK2UvSWZOMUNpakI4L2dWdHZ2?=
 =?utf-8?B?d01UaFd5b2JYQ3FMTmo0ZlpwV3pJbmhJYmFJOEhGRXJvZHdyYU12UUVLS2F6?=
 =?utf-8?B?dzF5MVpyMndNSytRallLVFlDYytiNE5aQjAyL0RkWE5iRE9Ia09VblAxVjg0?=
 =?utf-8?B?VWlXeXE0OTNtQmYxcnluZjk1TWxpQ0xwN0ZVcDN4RjE4dHNaNmgrY0xQeGgw?=
 =?utf-8?B?ZnZPZWgvbjR2WFc0b1FONWxlRitzSE9hTlNxYzlqOTMvOStlMnkwcjQva1E1?=
 =?utf-8?B?MHdtREpxeGZzR0JCTU41VndpaFAzYzBJb3kwdEFiSFZVSFVYK3RaM3N3SnZ6?=
 =?utf-8?B?TmlBYnpzWHYzYzlCWlA2UXRubDdvYWZsWnF5Z3NSQjRYY09Vd3F4cFRLYjhs?=
 =?utf-8?B?Y1B0UENUMHB0U0lqL1NTRXYyNi8xbGt3RlcxZnEzL1ByRG8rRHVzVTVGeW9K?=
 =?utf-8?B?WUhGTThMaDdocG1CbkQycElIUE1aZm9XVlpiZy9OOTZkUVo4Rk12WEgwV29Q?=
 =?utf-8?B?OUVIT0J4UDZSU0M2TlpCQXNrdGN6WlIzdkEzV1ZsWWxwUzhTcDhhRVEvT29M?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6856.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6601c8ac-22a6-4746-8c96-08dbd5ddf325
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 04:42:24.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ii/Pbx+u/0i/jP4uoIXeDMWh/8Z7Zfm2bVaaWZkgIQ6TOz3VnqK+oTRUHDMTXycqOjXKMBo+0KvkC/7/SAYiQJIfPnfeqbJ/2aujeinrEBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 04:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13455

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI1LCAyMDIz
IDEwOjA0IFBNDQo+IFRvOiBRdWlyaW4gR3lsc3RvcmZmIDxRdWlyaW4uR3lsc3RvcmZmQHNpZW1l
bnMuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtDQo+IHByb2plY3Qub3JnOyBweWxhIHZlbmthdGEo
77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKQ0KPiA8VmVua2F0YS5QeWxhQHRvc2hpYmEt
dHNpcC5jb20+OyBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERw0KPiBQb3J0aW5n
KSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDl
kozlro8NCj4g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkg
PGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRl
dl1baXNhci1jaXAtY29yZV1bUkZDIDAvOV0gY2xlYW51cCBvZiBjdXN0b21pemF0aW9ucw0KPiAN
Cj4gT24gMjMuMTAuMjMgMTY6NTksIFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6DQo+ID4gRnJvbTog
UXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPg0KPiA+
IGNsZWFudXAgdGhlIGN1c3RvbWl6YXRpb25zIHNjcmlwdHMgYnk6DQo+ID4gICAtIE1vdmUgdGhl
IHNzaCBjb25maWd1cmF0aW9uIGZyb20gcG9zdGluc3QgdG8gL2V0Yy9zc2gvc3NoZF9jb25maWcu
ZA0KPiA+ICAgLSBNb3ZlIHN5c3RlbWQgc2VydmljZSBvdmVycmlkZXMgdG8gZmlsZXMgaW5zdGVh
ZCBvZiBzZXR0aW5nIGl0IGluDQo+ID4gICAgIHBvc3RpbnN0DQo+ID4gICAtIGZpeCBmb3JtYXR0
aW5nDQo+ID4gICAtIGZpeCBzY3JpcHRpbmcgZXJyb3IgaW4gc2VjdXJpdHkgY3VzdG9taXphdGlv
bnMNCj4gPg0KPiA+IFF1aXJpbiBHeWxzdG9yZmYgKDkpOg0KPiA+ICAgc2NyaXB0cy9kZXBsb3kt
a2VybmVsY2k6IEZvcm1hdCBweXRob24gY29kZSBhbmQgcmVtb3ZlIHVudXNlZCBpbXBvcnQNCj4g
PiAgIGN1c3RvbWl6YXRpb25zOiBBZGQgdmFyaWFibGUgdG8gc2V0IHRoZSBIT1NUTkFNRQ0KPiA+
ICAgY3VzdG9taXphdGlvbnM6IE1vdmUgc3NoIGNvbmZpZ3VyYXRpb24gZnJvbSBwb3N0aW5zdCB0
byBzc2hkX2NvbmZpZy5kDQo+ID4gICBzZWN1cml0eS1jdXN0b21pemF0aW9uczogQWRkIGRlcGVu
ZGVuY3kgdG8gY3VzdG9taXphdGlvbnMNCj4gPiAgIHNlY3VyaXR5LWN1c3RvbWl6YXRpb25zOiBG
aXggc2hlbGwgZXJyb3INCj4gPiAgIHNlY3VyaXR5LWN1c3RvbWl6YXRpb25zOiBFeHRyYWN0IHNz
aGQgY29uZmlnIGZyb20gcG9zdGluc3QgdG8gZmlsZXMNCj4gPiAgIGNpcC1jb3JlLWltYWdlLXNl
Y3VyaXR5OiBNb3ZlIHBhY2thZ2VzIHRvIHNlY3VyaXR5LWN1c3RvbWl6YXRpb24NCj4gPiAgIGN1
c3RvbWl6YXRpb24ta2VybmVsY2k6IEFkZCBkZXBlbmRlbmN5IHRvIGN1c3RvbWl6YXRpb25zDQo+
ID4gICBrYXMvb3B0L3JlcHJvZHVjaWJsZS55bWw6IE1vdmUgU09VUkNFX0RBVEVfRVBPQ0ggdG8g
bGF5ZXIuY29uZg0KPiA+DQo+ID4gIGNvbmYvbGF5ZXIuY29uZiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyICsrDQo+ID4gIGthcy9vcHQvcmVwcm9kdWNpYmxlLnltbCAgICAgICAg
ICAgICAgICAgICAgICB8ICAxIC0NCj4gPiAga2FzL29wdC9zZWN1cml0eS55bWwgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gPiAgcmVjaXBlcy1jb3JlL2N1c3RvbWl6YXRpb25z
L2NvbW1vbi5pbmMgICAgICAgIHwgIDYgKysrLQ0KPiA+ICByZWNpcGVzLWNvcmUvY3VzdG9taXph
dGlvbnMvY3VzdG9taXphdGlvbnMuYmIgfCAxMCArKysrKysNCj4gPiAgLi4uL2ZpbGVzL3twb3N0
aW5zdCA9PiBwb3N0aW5zdC50bXBsfSAgICAgICAgIHwgIDggKystLS0NCj4gPiAgLi4uL2N1c3Rv
bWl6YXRpb25zL2ZpbGVzL3NzaC1wZXJtaXQtcm9vdC5jb25mIHwgIDEgKw0KPiA+ICAuLi4vaW1h
Z2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiICAgICAgICAgfCAxMiArLS0tLS0tDQo+ID4g
IC4uLi9rZXJuZWxjaS1jdXN0b21pemF0aW9ucy9maWxlcy9wb3N0aW5zdCAgICB8IDExIC0tLS0t
LS0NCj4gPiAgLi4uL2ZpbGVzL3NlcmlhbC1nZXR0eS1rZXJuZWxjaS1vdmVycmlkZS5jb25mIHwg
IDMgKysNCj4gPiAgLi4uL2ZpbGVzL3NzaC1wZXJtaXQtZW1wdHktcGFzc3dvcmRzLmNvbmYgICAg
IHwgIDIgKysNCj4gPiAgLi4uL2tlcm5lbGNpLWN1c3RvbWl6YXRpb25zLmJiICAgICAgICAgICAg
ICAgIHwgMTggKysrKysrKystLS0NCj4gPiAgLi4uL3NlY3VyaXR5LWN1c3RvbWl6YXRpb25zL2Zp
bGVzL3Bvc3RpbnN0ICAgIHwgMjQgKystLS0tLS0tLS0tLS0NCj4gPiAgLi4uL2ZpbGVzL3NzaC1w
YW0tcmVtb3RlLmNvbmYgICAgICAgICAgICAgICAgIHwgIDQgKysrDQo+ID4gIC4uLi9maWxlcy9z
c2gtcmVtb3RlLXNlc3Npb24tdGVybS5jb25mICAgICAgICB8ICA1ICsrKw0KPiA+ICAuLi4vc2Vj
dXJpdHktY3VzdG9taXphdGlvbnMuYmIgICAgICAgICAgICAgICAgfCAyNSArKysrKysrKysrKyst
LS0NCj4gPiAgc2NyaXB0cy9kZXBsb3kta2VybmVsY2kucHkgICAgICAgICAgICAgICAgICAgIHwg
MzEgKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxNyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRp
b25zKCspLCA3NiBkZWxldGlvbnMoLSkgIHJlbmFtZQ0KPiA+IHJlY2lwZXMtY29yZS9jdXN0b21p
emF0aW9ucy9maWxlcy97cG9zdGluc3QgPT4gcG9zdGluc3QudG1wbH0gKDYyJSkNCj4gPiBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gPiByZWNpcGVzLWNvcmUvY3VzdG9taXphdGlvbnMvZmlsZXMvc3No
LXBlcm1pdC1yb290LmNvbmYNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gcmVjaXBlcy1j
b3JlL2tlcm5lbGNpLWN1c3RvbWl6YXRpb25zL2ZpbGVzL3NlcmlhbC1nZXR0eS1rZXJuZWxjaS1v
dmVycg0KPiA+IGlkZS5jb25mICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiByZWNpcGVzLWNvcmUv
a2VybmVsY2ktY3VzdG9taXphdGlvbnMvZmlsZXMvc3NoLXBlcm1pdC1lbXB0eS1wYXNzd29yZHMu
DQo+ID4gY29uZiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gcmVjaXBlcy1jb3JlL3NlY3VyaXR5
LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3NzaC1wYW0tcmVtb3RlLmNvbmYNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gcmVjaXBlcy1jb3JlL3NlY3VyaXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVz
L3NzaC1yZW1vdGUtc2Vzc2lvbi10ZXJtLmNvbg0KPiA+IGYNCj4gPg0KPiANCj4gVGhpbmdzIGxv
b2sgZ29vZCB0byBtZSwgYnV0IEknZCBsaWtlIHRvIGdldCBhbm90aGVyIGNoZWNrL29waW5pb24u
DQoNCkhpIEphbiBhbmQgUXVpcmluLA0KDQpUaGFua3MgZm9yIGltcHJvdmluZyB0aGUgY2hhbmdl
cywgSSBoYXZlIHJldmlld2VkIHRoZSBjaGFuZ2VzIG9mIHNlY3VyaXR5IGN1c3RvbWl6YXRpb25z
IGFuZCByZXByb2R1Y2libGUgYnVpbGRzIHBhdGNoZXMgYW5kIG1vc3Qgb2YgdGhlbSBhcmUgbG9v
ayBnb29kIHRvIG1lLCBleGNlcHQgZm9yIG9uZSBwYXRjaCBoYXZlIGFza2VkIGNsYXJpZmljYXRp
b24gdG8gUXVpcmluLg0KDQpzZWN1cml0eS1jdXN0b21pemF0aW9uczogQWRkIGRlcGVuZGVuY3kg
dG8gY3VzdG9taXphdGlvbnMNCnNlY3VyaXR5LWN1c3RvbWl6YXRpb25zOiBGaXggc2hlbGwgZXJy
b3INCnNlY3VyaXR5LWN1c3RvbWl6YXRpb25zOiBFeHRyYWN0IHNzaGQgY29uZmlnIGZyb20gcG9z
dGluc3QgdG8gZmlsZXMNCmthcy9vcHQvcmVwcm9kdWNpYmxlLnltbDogTW92ZSBTT1VSQ0VfREFU
RV9FUE9DSCB0byBsYXllci5jb25mDQotIExHVE0NCg0KY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHk6
IE1vdmUgcGFja2FnZXMgdG8gc2VjdXJpdHktY3VzdG9taXphdGlvbg0KLSBIYXZlIGFza2VkIGNs
YXJpZmljYXRpb24gdG8gUXVpcmluLg0KDQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMg
QUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K


