Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CAC43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 07:00:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.169000.1783407629920891741
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 00:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=IJTyrlpC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783407626;x=1784617226;bh=NteYTkYiHMQTkkHihPkaXow+6Jxzt3oBvxjU8
	pPW9XM=;b=IJTyrlpCmFmckplX+OyrTKGWFs4pDiUsHFQlT+BkgMq/yIn/1qNFdtnSbW5e88TjuB4
	nYP4HVaa77lK+jFWxSxnlsVLupdF+9DYImHfQko+I3WkJzkLd3I1pYM2YNJWRIX/rPvEWzMJ4WQiy
	V9erOBUNrp3oIkDSsSxQuHAkz4wWzCF0lk6g5bWt/gC/l2M2waJ0rk8q9Id80HUF4xQhTEPEqB0vG
	2Q4HvrdzyxLL57K1pBN1r4nu2BDVVCPUXL7ZssfrI6ad3BE7yo8LIyo5mWaC9I5QrL7cIOyPtA6bq
	BWL9AmFQ+N2+obOIwjtrPlb0i+Xge78762hEj4vHg9QQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66770P7C167691; Tue, 7 Jul 2026 16:00:25 +0900
X-Iguazu-Qid: 2rWg6M5YhMoF9ncaf9
X-Iguazu-QSIG: v=2; s=1; t=1783407625; q=2rWg6M5YhMoF9ncaf9; m=Gm3tQbN6s77E8Y8WkyyTXQaL2YemRKjupQz2Ie+RG/c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gvXDS6Q63z1xnj; Tue,  7 Jul 2026 16:00:24 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMSi+3U5SQLMWwa310xUYwSnzVQOeBUKalUwfFrWEwAZFOwkb5iIMclCmcI+60ewR1NovL+yS2VD8fE2Vn/ndlbuDkgLeVtkHHc+hp99QGmVleRX/ROUAm35m1sQB9l4Xj9JVA2t5SmlI/7F4d0oVNvHqf4kqKhuKSidQKz9Bbzt0EuIUyWrDo38mfZxiWz0/BlOD2guM/rGuCIrzPYZC85w/pnHZUVzg2uP7I7x0yzrjd4Apj6t9fAoVBBAExIaw3mxKrBG+Oz3pKMWuc/CIW1jz8ylo5hvbaurTmmGRcgml725ulTm7KbiWscQrkVFQLOwUbiGoWxobFcr6Y2Syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NteYTkYiHMQTkkHihPkaXow+6Jxzt3oBvxjU8pPW9XM=;
 b=ohYCRrepsV2lOF3eU9zAUrtD4ER+6gxU864mRcuma5IgaJYMODsy/AzIo/BIProQgxY7RoAQ3XdziYdmLkbZY2+oKDzOcWN8JN1iukpQf/4tyE8Vdai3Q/ygAqkNkuRU8cFLX5FMHR0CXiPfOjN2XHV51R6Ylv0K7tY4R+OGoqbcBmxh4I6iJK5siZKnduoNOwZvE8H7VLdms+tlhn43dCzHTuNhVjT7FSQVduuoCMEr2aZDlQSFYaRdZeztAXWGCUikvaTDRsYooqBQHX8ZCO9iT0+xS9lZWh339OEPQymzKs8tcSnFrh9CXZ+ine+YqtM7/FRy7jLb5PMXFHmfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <nobuhiro.iwamatsu.x90@mail.toshiba>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/11] Add pin configuration and GPIO
 IRQ support to Renesas RZ/T2H SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/11] Add pin configuration and
 GPIO IRQ support to Renesas RZ/T2H SoC
Thread-Index: AQHdCBokxLlToyhX0EuV6VMFg+Z7krZgIvUggAGJADA=
Date: Tue, 7 Jul 2026 07:00:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A798BBD410C74938A70FCDF02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <18BFA32833927872.1336494@lists.cip-project.org>
In-Reply-To: <18BFA32833927872.1336494@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15382:EE_
x-ms-office365-filtering-correlation-id: 3ad31d24-f3c9-4a0c-53cc-08dedbf569d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|4143699003|18002099003|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 WuGn3nQo5slfZimjPCw2S6VgUQdJQJv8r8KwdFj7rCmUTgGGZdU+iWSkv2a2qIIhcatb7udsQVK1t00ThBMKM0HmgX9iCajSBS6QDxiLclT0EFBu6WzpqenF3HTZlm1P6sRG/fvdLLkCV2xo7C1SckV18j2x7izViUf7J1pjI0KXFLAdUNXGsNYzZIJu6Ey6UjvNzoMS7pdoCXZM4KafEeLYROihQVAX9a17zkW96qrx7XDeVlkcRBbT6Y49Snd8+EHpIXXmDQGqDrEVrl0mdZDLMqOR73qw67jAnBJbtbz8p5ZQ2yWMERVtakWv/szjwE2utadg58ij8IdaNOF2xSeReayjJFs9IkiHyEbLrZsTpuNDVzbSypOKDW4A54egcFKMo4GGzuXY2vCTp1Ax0zse+7KvuiqglrrwGbwAOoJKDt+0W0w6so4BrsR7gn42etyiVbwFquuyVnBKQxaHEPzvMCFkdEm/yRm+sgqEqXNcMfOkXoJeaJuaWeeiaAtcspKAqNcVc///1DjORJMKxWzvgGZ4kTAnOqvbq/YCgj4KzY4kPglt647nPtt6a/44vQOdaL7SZG96Svc9pi7q8RPNYxtQfjqDdSqW6djASy2+o99ldbRC8DDSp81OmZqNZU1wrweVZGf/M5+9TPkol7DAmd/wPgsVW8az31D7xno2ICpmN9c9864fUKxqdxAWpL10a4JN24friCrY/mq+vA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(18002099003)(11063799006)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bU5wbW50NzM0Rlp1WHFzbitmY2xYZ01CZDBCcFBERTU1MnRJeWNLMDhpbW5W?=
 =?utf-8?B?R1RPVW9Wd3VOMi9vNEFISVRjVFJGOCtpRjBJVDJhUUhpRVFPUkN3OERmOXkz?=
 =?utf-8?B?bXJCQi9KeVpIdFpCbFNMMG51clFrWHhlR3VxT05teXg4K1ZySW45SWZqMVAx?=
 =?utf-8?B?bWYrVHVHemUyU29RTHhOV01WQ09Vc2FTRit1b1VUSUQ4NGN1TlY2a1I1UC90?=
 =?utf-8?B?ZzVrM0JaY1g4WHV0M1ZsVitNMzJaWFlWalhEUituaUxiQ1czRzBOMCtMcnYv?=
 =?utf-8?B?YzRuUUdwZlBieWpaRzNDYld0VFFLZXNvaU15aG5wZisrZHlHajZmZEdPdUo1?=
 =?utf-8?B?cUU4dy9nWWVrLzRPQ2JMVFpjNFlEajUzNXVDR2h3WHYxdXozdHczbjlLQXBS?=
 =?utf-8?B?dzJhV3E2aFR6N1R5VE03MUpha1Ryc2s0ME1weEptRDZwTjlpK3E2UEhCZXow?=
 =?utf-8?B?RXBoZzFjS3htNEF1ckg0TVFiYjVNNmE3MHpmS3EycjFQb1NrWkpFOFlpSWw1?=
 =?utf-8?B?bmFmdDd4V1dMc0YvaUl3eEwvR29uY1FwVkZXS3V0RnM2ZW8xZndVeGRoNElp?=
 =?utf-8?B?TDN1SzBZcXBzWTRPTklvNzhTcGlvV1RFSlpjWVEzZnA0dml0d05MNkYvUTZl?=
 =?utf-8?B?Qm5oU21YV2F3cW16UG14NS9XQ0ZxMWVxeGlHUW9ZQjA2bjdmbnRhcVV1a1Zh?=
 =?utf-8?B?RE9oTlFwUTg5M2dGV2ZSV3czQUNnMU9mbkdJR0VKajlHNjU4ZGVEWnpWZisz?=
 =?utf-8?B?dko0NWRsZ1dqN0pCczdJWWV0TzlyNlhsOEQ0U2s5MldNUUgzaDhrQVB5OFdy?=
 =?utf-8?B?VHdUR1Bzc0hiZkNJZlNuV3Y3bCtUVU1uS0gwUnIxQU02MjRKWUI4QW1OSVMw?=
 =?utf-8?B?NlY2UFRuNlZCeWQ1Y3Z4eUpKVGM1SzVuUE83eFBvUG1oWXBIR1Jtc2dieklL?=
 =?utf-8?B?Q2ViSWROMEw1NXVCRUtzd0tGT3A5RzQrQmE3S2xGSTlGVW5FNmtzTjg3R1ZM?=
 =?utf-8?B?VStONVc5NUxLR2Rma1NOeWVvQW1MUERsVS80bE1WV3lhWjU1d1M4WDdRWE1a?=
 =?utf-8?B?eldWMWYrOW81Qys5cVJjNk5NU3Q2akt4eE5leUp2SkZDZUJCQ29xVTRXY2Iz?=
 =?utf-8?B?T3loZWlpT01ISnVJSzNManl0cS9hSDhiTytLZjU2VXEzT2psN1Zwd3Ntelp5?=
 =?utf-8?B?M0w0Mk9iVlhUOVJvU1dpbmgwY1M3YTNDdnpOWVVvc3U0d2JiQjdNTTRsWjl4?=
 =?utf-8?B?RXV1RVRZT3I2MzREbVk3RlNlYnRTNXd2azlRWENyaVlERG1oRWtrM0FiVEZa?=
 =?utf-8?B?ZnRnc2J4a2dtdGNJUk1pRUJGYlQwempoL3F5YklmRHhVU25YY0tjaUM1MllL?=
 =?utf-8?B?dkE4SDNJTVFRMEJVWENvd1BlbGV0cVNkRUJwQ2tpaTFpTjZEbXhGb1R3VzBl?=
 =?utf-8?B?NWVkeUkzOHM2TUwyaEZiS2pKcWMzQXQzRitRVmQxaTd3NjZ3Z2pHdUp6RTlI?=
 =?utf-8?B?RXFrL3I3RUtMWmFKM25PMjJkVS9aeml3akFkMUIydzBMejNvcng0VkhXQjNn?=
 =?utf-8?B?MTJkT1FQVlBxVXUyYlVBUUYyQW91LzA1bE5ZY1BTSnE0ZGNLNWxPNGVjRzdI?=
 =?utf-8?B?U2lqb1RTOUErbW9GbmJUcmNJcUhCVGdwZm5aRnpabUM4RGV1VDdaSzBUYmhP?=
 =?utf-8?B?WnY5RUR4RGJFd3JjNXhtamJWYk1BY0NnOU9Ib3JjV1ZxTXNIQS9vK3kxYVlp?=
 =?utf-8?B?ZjI1M3VGcXZNc1dtZ0ZJcG9WSVlYQWhXandnQytaeDhmR21VdXZ0WjcrM2tP?=
 =?utf-8?B?QkttOXpKc1Q4ZEhTcTJuRVVLRGlQYzgydWFPZlRpRCtZMEs5ZS84U2ZCc0lE?=
 =?utf-8?B?REdmaDRFSzlOZ2xKT0xTNkkvNEVWdUtkL3V0RDJGT1lva2x0WWpyT1BSd3NV?=
 =?utf-8?B?QTdpSXBLQUtaMkZoQ3J1Qnk1dy9acmJxeklwZEpIUGQ4SGUvTm11MDgzSVA4?=
 =?utf-8?B?aWlDRHZ6ako2QVV6VmZqWUJKbCtpM292bHFtUXNhUVp6VmJ1ZXJqZE5DZ3c1?=
 =?utf-8?B?N0xTcDJ5TkwvR1lQb0o4bnVyKzBXbVg1S1RzRlVCdHI1cGdoYjlrTm14ZkJN?=
 =?utf-8?B?MjFLVVE2T1V5cldQUHF1bTlZeDdvMlJoOGd4TllJWHdhenJocUFvZkp0RzJ5?=
 =?utf-8?B?QytnRHJtVnYzOW1qWERqZnV3UDk3NGhhNHkyMWkxZVltQ0lDeDlUZmdUZ2U2?=
 =?utf-8?B?cVBsc25kd0hZQ1VuaGlsZEtzaGtzclh3TnUreUd3Q3J6RlJnOTJmZEN6cmx1?=
 =?utf-8?B?enRwNXc0aUsvcEhOQWQ5L0tZNDBnakZVVGJxM2NZNm8yaHJsdzNCVWNjZHRn?=
 =?utf-8?Q?p3AYleAJESwDoo6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	lpuhhFKvZNYUG56uY2JMTHv8I2P4fWQ2CLFB/J+Jy6aK+9Rub2HV0MLD6qI3gMpGj7z+ZZFAygH8sKSA0IUKFgYb90esP4R7KkkhtzTzWc3l6Tp+OPdhB6k9QoR4gH2+o1DdX4c1oUx8639XuXvYYOY09+kaVk86xvxBwwXaTt2dF3XMR9f/72z8ADc0SwfvRHhlX9lbaoEerVy0RK2ATzgetGM5+1deUzURSAGjpU5L9YGhmy/gZJdgq8wAOzVxNusjEUsATQfMztB+7Nln2stS48WgtzQURdv3f+KIARTNExmDOPNRaZZex+dBwOtDiIwJvokrupwSpcOLHH6DPA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad31d24-f3c9-4a0c-53cc-08dedbf569d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 07:00:22.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzsUCZM5jVx99GZ+cTs/UBJZe3syp1Fk6AxetC8Noj16sHeGeEMUE3WLQRUj5NaZeng1jHi2/y2bXb9YKuYtkCLrU/3zzxvlg+X7IdWaxA0WFQQUR8B029jvRpQFxzqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 07:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23471

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1IHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gU2VudDogTW9uZGF5LCBKdWx5IDYsIDIwMjYgNDozNiBQTQ0KPiBUbzogcHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
ZzsNCj4gcGF2ZWxAbmFibGFkZXYuY29tDQo+IENjOiBiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bQ0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRDSCA2LjEyLnktY2lwIDAwLzExXSBBZGQg
cGluIGNvbmZpZ3VyYXRpb24gYW5kDQo+IEdQSU8gSVJRIHN1cHBvcnQgdG8gUmVuZXNhcyBSWi9U
MkggU29DDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJl
bmVzYXMuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMzAsIDIwMjYgNzo1MyBBTQ0KPiA+
IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp
5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4sNCj4gPiDvvKPvvLDvvLQpIDxub2J1aGlyby5p
d2FtYXRzdS54OTBAbWFpbC50b3NoaWJhPjsgUGF2ZWwgTWFjaGVrDQo+ID4gPHBhdmVsQG5hYmxh
ZGV2LmNvbT4NCj4gPiBDYzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiA+IFN1YmplY3Q6IFtQQVRDSCA2LjEyLnktY2lwIDAwLzExXSBBZGQgcGluIGNvbmZpZ3VyYXRp
b24gYW5kIEdQSU8gSVJRDQo+ID4gc3VwcG9ydCB0byBSZW5lc2FzIFJaL1QySCBTb0MNCj4gPg0K
PiA+IEhpIEFsbCwNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gYmFja3BvcnQg
cGluIGNvbmZpZ3VyYXRpb24gYW5kIEdQSU8gSVJRDQo+ID4gc3VwcG9ydCB0byBSZW5lc2FzIFJa
L1QySCBhbmQgUlovTjJIIFNvQ3MuIEVuYWJsaW5nIG9mIEdQSU8gSVJRDQo+ID4gc3VwcG9ydCB0
byBTb0MvYm9hcmQgRFRTL0kgd2lsbCBiZSBkb25lIGFzIGEgZm9sbG93LXVwIHNlcmllcyBhbG9u
ZyB3aXRoDQo+IHhTUEkgc3VwcG9ydC4NCj4gPg0KPiA+IEFsbCB0aGUgcGF0Y2hlcyBoYXZlIGJl
ZW4gY2hlcnJ5LXBpY2tlZCBmcm9tIHVwc3RyZWFtIGtlcm5lbCA3LjItcmMxLg0KPiA+IFBhdGNo
ZXMgYXBwbHkgb24gdG9wIHY2LjEyLjk0LWNpcDI2IChjb21taXQtaWQgZTAwMTc4ZTZmZTg1Myku
DQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4gUHJhYmhha2FyDQo+ID4NCj4gPiBDb3NtaW4gVGFuaXNs
YXYgKDQpOg0KPiA+ICAgcGluY3RybDogcmVuZXNhczogcnp0Mmg6IE1vdmUgR1BJTyBlbmFibGUv
ZGlzYWJsZSBpbnRvIHNlcGFyYXRlDQo+ID4gICAgIGZ1bmN0aW9uDQo+ID4gICBwaW5jdHJsOiBy
ZW5lc2FzOiByenQyaDogQWxsb3cgLmdldF9kaXJlY3Rpb24oKSBmb3IgSVJRIGZ1bmN0aW9uIEdQ
SU9zDQo+ID4gICBwaW5jdHJsOiByZW5lc2FzOiByenQyaDogQWRkIEdQSU8gSVJRIGNoaXAgdG8g
aGFuZGxlIGludGVycnVwdHMNCj4gPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6dDJoOiBGaXggaW52
YWxpZCB3YWl0IGNvbnRleHQNCj4gPg0KPiA+IEZlbGl4IEd1ICgxKToNCj4gPiAgIHBpbmN0cmw6
IHJlbmVzYXM6IHJ6dDJoOiBGaXggZGV2aWNlIG5vZGUgbGVhayBpbg0KPiA+IHJ6dDJoX2dwaW9f
cmVnaXN0ZXIoKQ0KPiA+DQo+ID4gR2VlcnQgVXl0dGVyaG9ldmVuICgzKToNCj4gPiAgIGJpdGZp
ZWxkOiBBZGQgbGVzcy1jaGVja2luZyBfX0ZJRUxEX3tHRVQsUFJFUH0oKQ0KPiA+ICAgYml0Zmll
bGQ6IEFkZCBub24tY29uc3RhbnQgZmllbGRfe3ByZXAsZ2V0fSgpIGhlbHBlcnMNCj4gPiAgIHBp
bmN0cmw6IHJlbmVzYXM6IFJlbW92ZSB1bm5lZWRlZCBzZW1pY29sb25zDQo+ID4NCj4gPiBMYWQg
UHJhYmhha2FyICgzKToNCj4gPiAgIHBpbmN0cmw6IHJlbmVzYXM6IHJ6dDJoOiBBZGQgcGluIGNv
bmZpZ3VyYXRpb24gc3VwcG9ydA0KPiA+ICAgcGluY3RybDogcmVuZXNhczogcnp0Mmg6IFJlbW92
ZSB1bnVzZWQgdmFyaWFibGUgaW4NCj4gPiAgICAgcnp0MmhfcGluY3RybF9yZWdpc3RlcigpDQo+
ID4gICBwaW5jdHJsOiByZW5lc2FzOiByenQyaDogU2tpcCBQRkMgbW9kZSBjb25maWd1cmF0aW9u
IGlmIGFscmVhZHkgc2V0DQo+ID4NCj4gPiAgZHJpdmVycy9waW5jdHJsL3JlbmVzYXMvS2NvbmZp
ZyAgICAgICAgIHwgICAyICsNCj4gPiAgZHJpdmVycy9waW5jdHJsL3JlbmVzYXMvcGluY3RybC1y
enQyaC5jIHwgNTM2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gZHJpdmVycy9w
aW5jdHJsL3JlbmVzYXMvcGluY3RybC1yenYybS5jIHwgIDEwICstDQo+ID4gIGluY2x1ZGUvbGlu
dXgvYml0ZmllbGQuaCAgICAgICAgICAgICAgICB8ICA5NSArKysrLQ0KPiA+ICA0IGZpbGVzIGNo
YW5nZWQsIDYwOCBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gSSBy
ZXZpZXdlZCB0aGlzLiBhbmQgbG9va3MgZ29vZCB0byBtZS4NCj4gSSBjYW4gYXBwbHkgdGhpcyBp
ZiB0ZXN0cyBhcmUgT0sgYW5kIHRoZXJlIGFyZSBubyBvdGhlciBjb21tZW50cy4NCj4gICBSZXZp
ZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRv
c2hpYmE+DQo+IA0KPiBUZXN0Og0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lw
LWtlcm5lbC9saW51eC1jaXAvLS9waXBlbGluZXMvMjY1NDM1NzIyNw0KPiANCg0KSSBoYWQgZm9y
Z290dGVuIHRoYXQgdjIgZXhpc3RlZC4gSSB3b24ndCBhcHBseSB0aGlzIHNlcmllcy4NCg0KQmVz
dCByZWdhcmRzLA0KICBOb2J1aGlybw0K


