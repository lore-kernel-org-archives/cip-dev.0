Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD02C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 07:36:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.146054.1783323369879893199
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 00:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=TVT4j27O;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783323366;x=1784532966;bh=AXX7EfMROfNF/RY/XH2KO5udWHMvs+ctZBCH4
	3gGMJo=;b=TVT4j27Oh8bYxn7+OgM45dBNQSp+8kqwedyDzUsenBQO1rOv58yr/fCtuigR+oYbAMW
	bhN5DWLYV0Hvp4FdyXjaAErU+HnZrJPWAQFX6XVNqmVaLDxxgRJg6cDmb/Kb/S8pCNqAoK50A9X3g
	MXj2A9Ft1Kqn86jhELRdZnMPHjuwuucvvMyghkN9RgR1RvHBhqza9Ec6/KpOIfzNRm6wKAYt+aFCk
	Xyq73qG9WTjpLohVurwvyrpmiUVbnd4rkETE20s1ihIh32rJ0i4zdqu4UaM1WWdm0c/Qrt6BCgAnb
	g5E5vQfhu0XiCkDQJLFhcSao9JKVMQGqM3nCDGjuiC5Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6667a66u1075249; Mon, 6 Jul 2026 16:36:06 +0900
X-Iguazu-Qid: 2rWgG8Kkh3Nc7efabY
X-Iguazu-QSIG: v=2; s=1; t=1783323366; q=2rWgG8Kkh3Nc7efabY; m=TXNiMOd37DDmkBkN//mZRvmMJkOiix8QqRzYLO0cxXk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gtx452s8Rz4vys; Mon,  6 Jul 2026 16:36:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3Li//QFBW9g8u5uGyj3d6E69JbjPFlitC+6IHri6RKRV8DkcoEsr4HIj6uRXYMpGKnqidm/rm60ZKg8UXXeV66kdEaGlaLlMkincmsvNJBhTLQ2FTTe6neKom01OHSHiP7/kaDCWJjjkEqgrBNgFEVfzKerZb8J6hK1bC7qtVP5kI8Fc5tzJnMODxBOGnithTqGl9F56KGMPJxva9j98GVk4JRm0eOAvuSP6Eo9kAc/krX+SOtbFrDLJpSGyy/+qnJzzqJbLl5ViEQgmJP7sufOjY8srk1P+4LHvBoIVjit/vGzR5XpTQDD4/DCdNwxwpYHx9dyTTfDpIqIys1/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXX7EfMROfNF/RY/XH2KO5udWHMvs+ctZBCH43gGMJo=;
 b=sNMM+UCqKTH7lSZi0kEJ9bscM8rIl+JZGUV2XelHcoib/KQEashy7SFcag6dWTwiPWR5YSVdoUgRdIvraoS+D/1iuyPfpLuGnjK8HKXbqleUjATthsRsem5C4cJwMmcZGCLmcVxHWJuuK8u20EOFuZyNaxz8ywAP0yHSBcX/kU9iPvQrPDa0p9p+XW36Cjh4A5DS2yl6xnyb/ysOoVyze7FnyyJmtfpiS3MnsivYMTyVS2WVZ9YLHIV6Xnq/bUO0QKLcYfYp5Ua/TVLUIFiP78UT8SirezxcpqJjR2ejs4GT7C6Ea8zlJKjzxStg9X33lUorT1amhRTe6mZFe3shdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/11] Add pin configuration and GPIO IRQ
 support to Renesas RZ/T2H SoC
Thread-Topic: [PATCH 6.12.y-cip 00/11] Add pin configuration and GPIO IRQ
 support to Renesas RZ/T2H SoC
Thread-Index: AQHdCBokxLlToyhX0EuV6VMFg+Z7krZgIvUg
Date: Mon, 6 Jul 2026 07:36:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181721D386BFD276F4BB4FCDF12@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13608:EE_
x-ms-office365-filtering-correlation-id: af62b88c-b0c4-44f5-0b72-08dedb313b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: 
 H3r9GK3CBwtygIhfDavE/6f9pHW+R60KZ5xNCEKUp/rFHXmXPHH3KjiimtfPprNYccKIRDZYeDfv4ctjwIDSS9O05/TO+FFgqVOuRXQO0jm5sdNpiKpODPFJgRz7Z4xuXV7a2EWCm9SeoK1IIdoJplVof+8l93rdCOb2t72z3CyOaEAuZyCJZiS5G+g6Zm5rv8RDgF/Ide8zth6vQmMjR03odoLahhyu+rikz5e/P2GXYgtNoxnF3W0zBZ+yhE8z0BnI8QG11Av9yfE1GsK1Ip9jDXuBnU63pfRR/6pliMPyT30MFLuW97Wxu+7ZeAE2kFvc8dXAe/GrehcsZ0Ae2Y7RJfG/rvMSqSKfT+d/EibYzoAdZ0py5m2qzM7ICbtXpiGf12l6Wofgc1fP3eV9Wvtj5VoXjCb7lbGFchkrXyv0xQ7+TQJSu2v6/K07+u1bNfxqxeSadQwwfnIF2VXsMVZrfMkY/aj1S/zDEUVy+LQzp0V1/rXz/3hiH03B63pKyHKCKwQHItLgnwDXLF40AO1YTJukswdqLRByPuJj5rVAKanTYDO2XMmf0oyjbTPYLZi6wwDOLwvTzGFvLoFWvxGZ/YXAt0f8AJdyDo0byrICjZpWWiPZtDsfVeawk37omOLzOQzXYBi6RVxu61oB4i3c2Q2kK48GNMA7A61qUrdBqf1NuK5AK5hrJ0YNfUVjkfkngFOJPJ95Zj8IynE/Rw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R3hFYlBVY29CTmpYS2pXYStZeVROSysxamFPYXlYeVZ5YStnM0pZRnFXY0dL?=
 =?utf-8?B?QVJrWFFZeFNQSk1iaGllcjJRenJpZEFZYlpBVGlOaWFjaTdwWmljazRHc1FO?=
 =?utf-8?B?UFJoalE4b1c3SWZDVU9QUUNveGlMNTJYMURycUFNRUFCUHBSYmx3SHJ6NHpK?=
 =?utf-8?B?ZisxQTdyYlZaVGtFcGFlUHhOUmxINVZWRzFCR3dIZ1U4c28vSFB1cnUrbGdn?=
 =?utf-8?B?alRBbzFqOWVCQlZzZ3VNT09vUE5jTTRDYVgyalJJT3J5WHIveTFjWkNvcW5v?=
 =?utf-8?B?SjBBcnpUc0NhSE5lS3cyQU15bnR0ZnJSMGF5NWI4WHlHZU1kekZyQ0tDR3BF?=
 =?utf-8?B?VFNnMG5zQk81aCtlZkZQSzVtTVFhQWVqcHJiUG54RDl1Q0xucHNmM21Pc2o2?=
 =?utf-8?B?eEJaWHBCRE5iUzAzT2tLV1dKM1d6MWhUYjBLU0ljK3JkckMydFJpbXQ5by9O?=
 =?utf-8?B?VGp4RmIwMUdBUDlLdGlzMlpDRlAweUFMbDd6b2U4bkJieEY4NDJLRHpRMVZh?=
 =?utf-8?B?T1grVS9oTCtwRUlCb1N2bFM1ZnBzV2hJcE12QUxkbTZTaHJvUTNaT1BmZkFa?=
 =?utf-8?B?QzM3aWZUeFVNYWZ3T3VKcmdHN3NPZm10TkFQWjl0MHJSY1pVazNvVklueDZR?=
 =?utf-8?B?eVRURTRoUW1JVXd1UWNnajBrb0R0bmpQalJ1MllUUWRUb2VrTVY3MndLMUF5?=
 =?utf-8?B?RCt6aXVWWHJNd25jNWkvek9FTWh3eUczbmxyL0o5dmU0S0dlN3BDbEk2cHhy?=
 =?utf-8?B?Y1BFVHBHNURrWStSQWROK1NrOURoZndFZ1ZXRVlLWGcxc2JGbDArUjM0cG55?=
 =?utf-8?B?aG5hY0FXRzlnTHhrNEtWdHp1YUcvZ3VJaUFJNEpnSDUxSDE5TlROampDZWQ4?=
 =?utf-8?B?bUFaeGJUTkNDMkFpdU1ZZnk1Y0Z2SXh3SWxrRWJHSHEyYVkrMkg2cDFlcUxk?=
 =?utf-8?B?cSt5UzZOZElkbzNnOFFHaWpoSjQrdGY3b3N5T1RKZ0JhZlE3TmM4Mk5FcHdG?=
 =?utf-8?B?dmlKWVhuYXVGS2NnZmt4SkF4MUhBUzNpeHMxUDNUd2JFN2xJRHBhV3Y3Nklv?=
 =?utf-8?B?REJTYVZCMUJHTnozWWN0Y1Y4azRndlJibm1FWmRzMmhRUnBrQ21TM3E4M291?=
 =?utf-8?B?NGdlTFJMKzRlZDA4RHBNRWF0aVorb3VkRnB1aUlJTmZwamtKNldsU0hzbXRM?=
 =?utf-8?B?MXBqeFBlNjFXa0NGZC9YOWI1OGxERGNTSjcrR2FjRVVxYzZub3NJWTU2bHg5?=
 =?utf-8?B?M3NXWUplWnBzRENCa1BGZEtCMDdyZ3hEV3ZzZzlKYlRhY2djdGJyc3BUVWRo?=
 =?utf-8?B?S2UydjBQMnNvRXQ1VjhrVm5DOHVkQ3VMVmRMeGFXL2NGVzV3cUtZRWJpbUM1?=
 =?utf-8?B?b3huQkJsR0p3SXdqc2J0aUkwUk5GM2NuNmxhczB5UUNUR2M4KzJJMEh6ZStC?=
 =?utf-8?B?M2xNN2c2RG9qL2daVTBiakk4Y3pXWVI3cTNlTUJGd3c0MkxLcC8zT1cwcjha?=
 =?utf-8?B?QWdPWDlXaUQ1MXJ3aEd3QlJ3QnlBd3FDeWxaSCtkNi81M2o3WFdTN1hOOExS?=
 =?utf-8?B?bTZsQ1k1WG41Vi9GUmVQUmRHQnBnVE9iS2hmODhtNDl0V20vNDcxeXRrMWl5?=
 =?utf-8?B?RGs0MWNlNnYzVDZyczNWbGxXU0JDRXhnVlVqeEQ3RVFXVkJReEIxM2k2Smhh?=
 =?utf-8?B?b0R1blZDd3Vkc25YWGhVdHZreHRObE9QMVNmblZlZHBuTDIyNHQzMWJ2aVF4?=
 =?utf-8?B?b0pRbnBzcFIzd1MzSWVlVmRvajlORUtockNNSzFlaU8rRXB1U2FYeUpod1lL?=
 =?utf-8?B?MDNtRjBuS1ZRZHJmeHkrOXF1S0dldjJvS2t3Q24xUkVjWFJDc2RmQVdHVkVl?=
 =?utf-8?B?ZFB4eEhPNmtxV3RPQ1U3RE93OWlOZVd4SURIWVZJTWgzNUhnNUI5VFN4ZEs1?=
 =?utf-8?B?TGlOYUJiQkRMeHkwRTBySXNJNnlLVXN3QitIOCtzWjNaSmdPcjFSdmFaTkpT?=
 =?utf-8?B?WThBd2tuSXJMU0wxN2FNV2Ywemo3Mmo0UEFWYUhLb1dSMTdBZ01UZURML1VG?=
 =?utf-8?B?aWpyejVrVTQybXErMnd4MjZON21pVTU2MHc0MzcwL0JQTWttVWRZWWNhQkhZ?=
 =?utf-8?B?VlJ6RWtLZ2theEwzU0RsL0xNZEJ2UXFHOGUvUHBHbkVFWlJsM0dwcHVtNk9F?=
 =?utf-8?B?WkVLK1pHeW0yYkd0TERmcXNDQU9ldVJIbWZYaXBvQTRpYStmWFJxaS82WGMv?=
 =?utf-8?B?SmFUTnNKV0MrTWJMbVp4eFdOcXhIUGU4U2tScDVvKzFBa1FOSllBa1Yyc3Ji?=
 =?utf-8?B?SnRhaEdCRlVZdkJMVHJ6VzhUUWpvVy80cit5YUZiQmh1WXlYc3YxQk5aTHJh?=
 =?utf-8?Q?cno80rOU8Ak7KkJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZXvoPKXvofytmcNYPg0wd4AI4MFAmrnIXg3TWw4ByhKvF1zYbUJVbtod6NNlcft6O0sYrABJu5/WE2tVEXs0LgWB+GjGvOsxsVQjpmpKh6oH9njH3tUylCHlt0QYSusWvc/Xsamlknyt1ebkIR59TZ+fL4CUIbuWKWwUz9GrovITF7ybPyMyMLjq2KG1BUsVw2GTpXwXicq/JP5anChDUSbJsHXU/5EaQHlKi8/MaalR98rSOdJtgFSSm00f9e8Ei+k+vSqD/uR/OHuHaZc6yikt5fEgEI5JrOdgCoZHLY7ZRdbSkVSwXJZ4/V6QDsybT58DpHSLdqyENb8xO51r0Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af62b88c-b0c4-44f5-0b72-08dedb313b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 07:36:02.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kfeDlU3cnMNQhBAW1OID88b2NnXd+iz1RM1oEVXWWrzarkcTUg9pJocvgHXiPSwgXLqxDJi9Fh5OK2QlEYAb3+HhdBtbN0cuRQ6eef8WEkSC7XiY6ejmfsRh4Lx43/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13608
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 07:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23455

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgSnVuZSAzMCwgMjAyNiA3OjUzIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTv
vKPil4sNCj4g77yj77yw77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT47
IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAbmFibGFkZXYuY29tPg0KPiBDYzogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggNi4xMi55LWNpcCAw
MC8xMV0gQWRkIHBpbiBjb25maWd1cmF0aW9uIGFuZCBHUElPIElSUQ0KPiBzdXBwb3J0IHRvIFJl
bmVzYXMgUlovVDJIIFNvQw0KPiANCj4gSGkgQWxsLA0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMg
YWltcyB0byBiYWNrcG9ydCBwaW4gY29uZmlndXJhdGlvbiBhbmQgR1BJTyBJUlEgc3VwcG9ydCB0
bw0KPiBSZW5lc2FzIFJaL1QySCBhbmQgUlovTjJIIFNvQ3MuIEVuYWJsaW5nIG9mIEdQSU8gSVJR
IHN1cHBvcnQgdG8NCj4gU29DL2JvYXJkIERUUy9JIHdpbGwgYmUgZG9uZSBhcyBhIGZvbGxvdy11
cCBzZXJpZXMgYWxvbmcgd2l0aCB4U1BJIHN1cHBvcnQuDQo+IA0KPiBBbGwgdGhlIHBhdGNoZXMg
aGF2ZSBiZWVuIGNoZXJyeS1waWNrZWQgZnJvbSB1cHN0cmVhbSBrZXJuZWwgNy4yLXJjMS4NCj4g
UGF0Y2hlcyBhcHBseSBvbiB0b3AgdjYuMTIuOTQtY2lwMjYgKGNvbW1pdC1pZCBlMDAxNzhlNmZl
ODUzKS4NCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0KPiBDb3NtaW4gVGFuaXNsYXYg
KDQpOg0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6dDJoOiBNb3ZlIEdQSU8gZW5hYmxlL2Rpc2Fi
bGUgaW50byBzZXBhcmF0ZQ0KPiAgICAgZnVuY3Rpb24NCj4gICBwaW5jdHJsOiByZW5lc2FzOiBy
enQyaDogQWxsb3cgLmdldF9kaXJlY3Rpb24oKSBmb3IgSVJRIGZ1bmN0aW9uIEdQSU9zDQo+ICAg
cGluY3RybDogcmVuZXNhczogcnp0Mmg6IEFkZCBHUElPIElSUSBjaGlwIHRvIGhhbmRsZSBpbnRl
cnJ1cHRzDQo+ICAgcGluY3RybDogcmVuZXNhczogcnp0Mmg6IEZpeCBpbnZhbGlkIHdhaXQgY29u
dGV4dA0KPiANCj4gRmVsaXggR3UgKDEpOg0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6dDJoOiBG
aXggZGV2aWNlIG5vZGUgbGVhayBpbiByenQyaF9ncGlvX3JlZ2lzdGVyKCkNCj4gDQo+IEdlZXJ0
IFV5dHRlcmhvZXZlbiAoMyk6DQo+ICAgYml0ZmllbGQ6IEFkZCBsZXNzLWNoZWNraW5nIF9fRklF
TERfe0dFVCxQUkVQfSgpDQo+ICAgYml0ZmllbGQ6IEFkZCBub24tY29uc3RhbnQgZmllbGRfe3By
ZXAsZ2V0fSgpIGhlbHBlcnMNCj4gICBwaW5jdHJsOiByZW5lc2FzOiBSZW1vdmUgdW5uZWVkZWQg
c2VtaWNvbG9ucw0KPiANCj4gTGFkIFByYWJoYWthciAoMyk6DQo+ICAgcGluY3RybDogcmVuZXNh
czogcnp0Mmg6IEFkZCBwaW4gY29uZmlndXJhdGlvbiBzdXBwb3J0DQo+ICAgcGluY3RybDogcmVu
ZXNhczogcnp0Mmg6IFJlbW92ZSB1bnVzZWQgdmFyaWFibGUgaW4NCj4gICAgIHJ6dDJoX3BpbmN0
cmxfcmVnaXN0ZXIoKQ0KPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6dDJoOiBTa2lwIFBGQyBtb2Rl
IGNvbmZpZ3VyYXRpb24gaWYgYWxyZWFkeSBzZXQNCj4gDQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVu
ZXNhcy9LY29uZmlnICAgICAgICAgfCAgIDIgKw0KPiAgZHJpdmVycy9waW5jdHJsL3JlbmVzYXMv
cGluY3RybC1yenQyaC5jIHwgNTM2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiBkcml2
ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6djJtLmMgfCAgMTAgKy0NCj4gIGluY2x1ZGUv
bGludXgvYml0ZmllbGQuaCAgICAgICAgICAgICAgICB8ICA5NSArKysrLQ0KPiAgNCBmaWxlcyBj
aGFuZ2VkLCA2MDggaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQo+IA0KDQpJIHJldmll
d2VkIHRoaXMuIGFuZCBsb29rcyBnb29kIHRvIG1lLg0KSSBjYW4gYXBwbHkgdGhpcyBpZiB0ZXN0
cyBhcmUgT0sgYW5kIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cy4NCiAgUmV2aWV3ZWQtYnk6
IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPg0K
DQpUZXN0OiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1j
aXAvLS9waXBlbGluZXMvMjY1NDM1NzIyNw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


