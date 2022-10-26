Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9992C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 07:36:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.89])
 by mx.groups.io with SMTP id smtpd.web09.4929.1666769791570341587
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 00:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hV2+r658;
 spf=pass (domain: siemens.com, ip: 40.107.22.89, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFC5zAKc2iVgMFBqZN7LMtuy2I35SKCjqzknylKDO83Zc3glISDndPo276luDhjOmbBejb4A6ZjVOqpSFCAUG1z0Lpap3CaxX189YM24KEXGeYqjmGHLzhT3NswXN3g9Y3X2P5Xq41Oot1lioL3Q25JeQRhbbe1UXJ7iyz2UpmFxfB0x6QzI2i3m68JTwUol50sE85G9T6YvswanORThWTN3ukIx8+Qr7oPqoWuJ+ZTbddOTaPkWDSwcHekJ0cDvRQfoEHGpO2Wzv+3N9ZGtbNHNcL4qx3zxv92sIcIwLDS5jZu5NdcRvvUq9qmD8TvXzX039FcyAdvkUpteDJyfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyxl0eQQIIvI9z+gKbstpqH1653kNjwuvJGWImcFX2U=;
 b=eHdZRxA2N+mpxk+OJVFTsMwGFFsILuP3rNKH8jNFH4YciwsPmni5zTFVKnLhw3QZRK+3metIEga4asIoagV2qQzaysAPoJchQBaRE9LUTBjGzMsS7PUSI69qsEFcmj15knhD6lt/GANAV12LEP8JsK6LEeQKSV3rxwRnXjlcroYRfYzeosbdU2X9lJRoeK7KX+bgj/8C15Zh1RiyffIMGGcgn87gYMnSohRq9OaaaE3DRMPG9buRw0t6rag1t5KJaokUX7xdBOdmnQji6TnktBGGLUEfjEYyjr20xoussEa47isQc8eRIV3S6GUPukahhWL5/MSwxEto5C1YeQyaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyxl0eQQIIvI9z+gKbstpqH1653kNjwuvJGWImcFX2U=;
 b=hV2+r6586u4QtwS7VZe9k1i1N/2Ys8T+3P7tO+FhrRtnuNmYeal7rXDC9Ogk6LoAzFQywJqbiYasaq3uKRiR4vo2P7twt7pidH/nTDP6Wwm3EWUzgH2A+tnS56pfHXPDzPpcIA9PSO92z8UqrKeE8FxfWiDodxlaBKrgxYJhhxDtQVOh98A+uMo0EAWOXe2IDBLZG3wwQiBKB4NLldGEf0So/e1+mm7OOQOIxzwY45Mp/eW1RrdhiuvHYPhQGbjG3sj9W1o1lYNGkz3dQ0SUoIyHM8EcoeDv5QmkJav4FLhRqWvpwIQfz+LasB89vDxVnBxAYRU0C8umN4z7FW0oyw==
Received: from OS6P279CA0087.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3e::6) by
 PAWPR10MB7772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:362::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Wed, 26 Oct 2022 07:36:21 +0000
Received: from HE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3e:cafe::f1) by OS6P279CA0087.outlook.office365.com
 (2603:10a6:e10:3e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 07:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT096.mail.protection.outlook.com (10.152.1.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.13 via Frontend Transport; Wed, 26 Oct 2022 07:36:20 +0000
Received: from CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.15; Wed, 26 Oct 2022 09:36:18 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Wed, 26 Oct 2022 15:36:15 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.013; Wed, 26 Oct 2022 15:36:15 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "Schultschik, Sven" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Thread-Topic: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Thread-Index: AQHY6ElhCx9TvN160UuJVOQLUIZ8PK4fxI2A
Date: Wed, 26 Oct 2022 07:36:15 +0000
Message-ID: <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
	 <20221024122725.383791-4-sven.schultschik@siemens.com>
In-Reply-To: <20221024122725.383791-4-sven.schultschik@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
x-originating-ip: [140.231.151.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA8F98320794145A7FFA31B355CC4AE@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT096:EE_|PAWPR10MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db0f6c7-d71c-44c7-3264-08dab724c6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UPLTUEsSWKOpECOT9ohGq7QDtYoi8n01W6D0K1dOFWRT/kgN4YTRBPrTmpAswZk9sMgEc5jypeYC0eUHvImwRE4AmhvCq8vgwh8hDxYYzZFg1166h6qc28zY/r0csPFBaYdUOVmG2kYyQtngToymTDvLyIIXI4AY8A5HdqTI/MzuwTlYMJ0C76IMF8mZFfEiRux9J3CRhZgWdBIfKpcsoFlSbBJJvKg6NibaCHjVLud/P0mkJ7VHCjnCMD/DFhwTeGIV/gUfEEQHeimmmmo8zWKfzPde2Pa2rg3vlWM5agunhagylvE2brRm57m9rWzw1ZHGwsKwvv0zhhcOz+N85KWvH7lN9aM04v9/0SEtvnk3hP39i9HXUf6la7B0Lq0cC32x9B25sA09LgkxaAC/cjWpaPSIOk+BHfN9bwU94ROQKMSHMi/LWCntBCy5Be4v9EPCk4+ZO/RR3EnLwFQD3xijCeJCI7/3k/zboGOgXrzJ46huS1MaBparn0exh1s3Bt0i7uOulOseew87sX9UhN6oQA/FNRuUySaaRU/LwQtFnge3V0/mlLswsXlj01vGZP2QQZIzDRzEgITIc3Zt6HenJYyhhsZGOUs04ydGfwGU2IakSTKUJtvEEWHzYhBTBRi2q3i/bYzgsPBA3qjf0y/1tBCLbJk8rQMrTuRSV7ybehBKfCVzIM104s5m0ztxtBAH/QYGSEz2JflmjIbxecaVsGjFO7SRTpIrGfQ7lN874lVK6CurGp3xTKWZJexblVZ1/KUWq89IjAvTdMCsyO/ABbhHUsUlcK+N4W5d6FGLYg+rTV0qmM77bBYv7ptz
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(110136005)(47076005)(40460700003)(41300700001)(5660300002)(36756003)(26005)(8936002)(4001150100001)(956004)(336012)(316002)(70206006)(8676002)(4326008)(186003)(82310400005)(2906002)(36860700001)(81166007)(70586007)(2616005)(107886003)(356005)(478600001)(86362001)(83380400001)(82740400003)(82960400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:36:20.9800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db0f6c7-d71c-44c7-3264-08dab724c6f2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 07:36:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9841

T24gTW9uLCAyMDIyLTEwLTI0IGF0IDE0OjI3ICswMjAwLCBzdmVuLnNjaHVsdHNjaGlrQHNpZW1l
bnMuY29tIHdyb3RlOg0KPiBGcm9tOiBTdmVuIFNjaHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNjaGlr
QHNpZW1lbnMuY29tPg0KPiANCj4gT3B0ZWUgaXMgcGFydCBvZiB1LWJvb3QgSW4gdGhlIHNlY3Vy
ZWJvb3Qgc2NlbmFyaW8gdG8gdXNlIG9wdGVlIGFuZCBSUE1CIGFzIHNlY3VyZSBzdG9yYWdlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU3ZlbiBTY2h1bHRzY2hpayA8c3Zlbi5zY2h1bHRzY2hpa0Bz
aWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgcmVjaXBlcy1ic3AvdS1ib290L2ZpbGVzL3NlY3VyZS1i
b290LmNmZy50bXBsIHwgNyArKysrKysrDQo+IMKgcmVjaXBlcy1ic3AvdS1ib290L3UtYm9vdC1x
ZW11LWNvbW1vbi5pbmMgICAgIHwgMiArKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1ic3AvdS1ib290L2ZpbGVzL3NlY3Vy
ZS1ib290LmNmZy50bXBsIGIvcmVjaXBlcy1ic3AvdS1ib290L2ZpbGVzL3NlY3VyZS1ib290LmNm
Zy50bXBsDQo+IGluZGV4IDk1NmRjYmZlZC4uOGU2NDI4MjM4IDEwMDY0NA0KPiAtLS0gYS9yZWNp
cGVzLWJzcC91LWJvb3QvZmlsZXMvc2VjdXJlLWJvb3QuY2ZnLnRtcGwNCj4gKysrIGIvcmVjaXBl
cy1ic3AvdS1ib290L2ZpbGVzL3NlY3VyZS1ib290LmNmZy50bXBsDQo+IEBAIC00LDMgKzQsMTAg
QEAgQ09ORklHX1VTRV9CT09UQ09NTUFORD15DQo+IMKgQ09ORklHX0JPT1RDT01NQU5EPSJzZXRl
bnYgc2Nhbl9kZXZfZm9yX2Jvb3QgJ2lmIHRlc3QgLWUgJHtkZXZ0eXBlfSAke2Rldm51bX06JHtk
aXN0cm9fYm9vdHBhcnR9IGVmaS9ib290L2Jvb3Qke0VGSV9BUkNIfS5lZmk7IHRoZW4gbG9hZCAk
e2RldnR5cGV9ICR7ZGV2bnVtfToke2Rpc3Ryb19ib290cGFydH0gJHtrZXJuZWxfYWRkcl9yfSBl
ZmkvYm9vdC9ib290JHtFRklfQVJDSH0uZWZpOyBib290ZWZpICR7a2VybmVsX2FkZHJfcn0gJHtm
ZHRjb250cm9sYWRkcn07IGZpJzsgcnVuIGRpc3Ryb19ib290Y21kOyBlY2hvICdFRkkgQm9vdCBm
YWlsZWQhJzsgc2xlZXAgMTAwMDsgcmVzZXQiDQo+IMKgQ09ORklHX0VGSV9WQVJJQUJMRVNfUFJF
U0VFRD15DQo+IMKgQ09ORklHX0VGSV9TRUNVUkVfQk9PVD15DQo+ICsjIyMgT1BURUUgY29uZmln
DQo+ICtDT05GSUdfQ01EX09QVEVFX1JQTUI9eQ0KPiArQ09ORklHX01NQz15DQo+ICtDT05GSUdf
U1VQUE9SVF9FTU1DX1JQTUI9eQ0KPiArQ09ORklHX1RFRT15DQo+ICtDT05GSUdfT1BURUU9eQ0K
PiArQ09ORklHX0VGSV9NTV9DT01NX1RFRT15DQoNCkFjY29yZGluZyB0byBsaWIvZWZpX2xvYWRl
ci9NYWtlZmlsZToNCg0KaWZlcSAoJChDT05GSUdfRUZJX01NX0NPTU1fVEVFKSx5KQ0Kb2JqLXkg
Kz0gZWZpX3ZhcmlhYmxlX3RlZS5vDQplbHNlDQpvYmoteSArPSBlZmlfdmFyaWFibGUubw0Kb2Jq
LSQoQ09ORklHX0VGSV9WQVJJQUJMRVNfUFJFU0VFRCkgKz0gZWZpX3Zhcl9zZWVkLm8NCmVuZGlm
DQoNClRoZSBgQ09ORklHX0VGSV9NTV9DT01NX1RFRWAgY29uZmxpY3RzIHdpdGgNCmBDT05GSUdf
RUZJX1ZBUklBQkxFU19QUkVTRUVEYCwgc28geW91IGhhdmUgdG8gY2hvb3NlIG9uZS4NCg0KLSBC
YW9jaGVuZw0KDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWJzcC91LWJvb3QvdS1ib290LXFlbXUt
Y29tbW9uLmluYyBiL3JlY2lwZXMtYnNwL3UtYm9vdC91LWJvb3QtcWVtdS1jb21tb24uaW5jDQo+
IGluZGV4IDBhOWExNWEwZi4uODAyZmM1MDU2IDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWJzcC91
LWJvb3QvdS1ib290LXFlbXUtY29tbW9uLmluYw0KPiArKysgYi9yZWNpcGVzLWJzcC91LWJvb3Qv
dS1ib290LXFlbXUtY29tbW9uLmluYw0KPiBAQCAtMTMsNiArMTMsOCBAQCByZXF1aXJlIHJlY2lw
ZXMtYnNwL3UtYm9vdC91LWJvb3QtY29tbW9uLmluYw0KPiDCoA0KPiANCj4gDQo+IA0KPiDCoFVf
Qk9PVF9CSU4gPSAidS1ib290LmJpbiINCj4gwqANCj4gDQo+IA0KPiANCj4gK0RFUEVORFNfYXBw
ZW5kX3NlY3VyZWJvb3QgPSAiIG9wdGVlLW9zLSR7TUFDSElORX0iDQo+ICsNCj4gwqBkb19kZXBs
b3lbZGlyc10gPSAiJHtERVBMT1lfRElSX0lNQUdFfSINCj4gwqBkb19kZXBsb3koKSB7DQo+IMKg
wqDCoMKgwqBkcGtnIC0tZnN5cy10YXJmaWxlICIke1dPUktESVJ9L3UtYm9vdC0ke01BQ0hJTkV9
XyR7UFZ9XyR7RElTVFJPX0FSQ0h9LmRlYiIgfCBcDQoNCg==

