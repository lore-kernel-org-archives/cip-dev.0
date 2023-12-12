Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49467C4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:02:21 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.86])
 by mx.groups.io with SMTP id smtpd.web10.12130.1702369220032918277
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 00:20:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uVVq5fY1;
 spf=pass (domain: siemens.com, ip: 40.107.249.86, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAq57Bhc0c2oe8CDFsRgAsGl4q6OlIXTht/P9sqaNJbOw0A/tYPgoX6J/F0amUA9+fPdWMeTur2u4t7SLUikch0qRFJnW0qN/yKeadU9Ra0cWx2HvA8JTgb0jyYx6swNsCmRyuw08kiY3eZyrhnSBY70EdJ6TFh2O6GhcUmS1n7xQLBfiykxRck1kXiNhWk2PvF/XG4BbH+PjYMTnqJ8vUfkHKGfqXL2deCCjlkzo3Fznm6HLpaoqDZkmz7sBcY+roCrm3zz2diuMi1Sc2giKph+Hspa31BS1Yg73AjHAVWsTTt6/wMboiThR7MXPw8BGU9MOYA64iWkRpg2Symfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9F1Z2tLyQ3Adv2ILWk91HvJl+2if73CtV3bP2YKYnk=;
 b=KwvHd6Urf5N8GlDwHKiQNl78dBtDpj3vVikGsAQTuVzNBT2SwbBBcBZGQfyRwdouww5zKrwpQ11gxN+fCC5+fOHR16xJ0OH9Q9f4OQFcP6z/gGwIwYxaVLTtaflA5aQXHZXEwwIDSJRJrc/27mCROp0w5KRfggFSRS3VZMN9QZWVMy6p6pFKxNEvS3RN15g2ro4fgXxDRpk+ZZrvXhDcIFvaSDhZAyqsX6Ja/4PI+Xps3yooXpUp+djyqjD/iy5vzZ9T+Xc5DTEQdf7f7CVvZvz6SbKdp/q8HNHpCwws/EREAW547K+Zegq6NYXa++FFyhQt8OwNhBuVLAuv0dDOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9F1Z2tLyQ3Adv2ILWk91HvJl+2if73CtV3bP2YKYnk=;
 b=uVVq5fY1f+F+oalHwAZot2sg/FsKF5ZFzZRnbA8GfY60PRwxfGwm4qNFJOkq83ovUpsGn8c86Rl4rF1L2wtEQqo//vWA8r/cGOc16ALtoJyL7p1z5Rg4fnNW5DL8mJgmLKzgOHzsgySKnYAl1izNKNWWY4OhKCXqrbcSpI3d7U9MQ7TCW/9QUI2KnZSuhwqu9wHixyCEbgnfGbsSodg6RZa/tOhutU38muRP/v4pKPA82FRmizEU+WldF24pGtQbFh/OImMbOKijQ2hJOhe2YdB0RmNoxKa+00Tr+8oUJIDdtTDb5EQl/SoqloVALsgyJuRqqe7/CLST28sS+Nq88Q==
Received: from AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15) by
 AM7PR10MB3973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:20:16 +0000
Received: from VE1EUR01FT099.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:205:0:cafe::aa) by AM4PR05CA0002.outlook.office365.com
 (2603:10a6:205::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT099.mail.protection.outlook.com (10.152.3.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.25 via Frontend Transport; Tue, 12 Dec 2023 08:20:15 +0000
Received: from CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 12 Dec 2023 09:20:14 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 16:20:12 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.035; Tue, 12 Dec 2023 16:20:12 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update binary
Thread-Topic: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Thread-Index: AQHaLC0jzFFhz+41h0e6g5SRkZxp47CkyZWA
Date: Tue, 12 Dec 2023 08:20:12 +0000
Message-ID: <c128e4def13fc0a707f627e5bb8c01cd8bdea42f.camel@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.59]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT099:EE_|AM7PR10MB3973:EE_
X-MS-Office365-Filtering-Correlation-Id: d78effa8-bc7e-42b0-827b-08dbfaeb2b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kIQ2QtUukPYOATRX3weIBwmP/c4NcFkejqkWEngTXIZkHo2mvgMCVIzgrjLw0MIBAYVSw2ODINzuJ3zdp7rABWTBSQxEVuBDknFn/d+QEh0sLybNXALYu3rCejngFzT3UxJL45OHP1cUq84QO4ZgamgbPV3oKiZizrVf0687CwZPWlGfEItakTjUuJLZFTExtV7d1fZ466s3SsfmdkSubU5BqK+vomgNeZ8AiBMGZF1VY8jq1f2583uwTBzlEi9/kFUzcX9NrBYpoqEwEWZ24AKS7Aea8B7eGtM5qJcWSgkgMA3pgA3HOBiGyzoXc68n+vlAGoq6UeXKgYU1m7x5UHlc/Y4dzZW6wovVXfNb3uzajKSHg6aEungzaPBiT4/z3s6sMiJgTIs0hDa++bu0F/rbh9hk/QdD6gQSpz6O7ss3dGSSfr0xasdCk50EOOfaiPoQC5WqARh56ICCXwhAPxCsJmEthaxSVX2d5RFY4VygBuljMZgiZApeTwAPhrAMCd9XdmM+/cqbTvz7VjsWsPsLtMrC6GDkbo5/75g8kaUQsY+okt/W5lRjYHHemSJV6MS7WOOua2VVdlTI8HXlxpNsbCBDQjz6mwOn/maSsChrCYDfsb4G9ZbIewKJmvtqomi5+Zj8VfMTiSRyXN200FAyGeYIgEwOZ5ODs02d6RFWJfy4L1RrgObPnD/EG6F8CxDcTwtg83nBo5QbdIlPt4HxL4XBUsfIRGRmwVOdJ794EIKoOHsezgxeY6tPk8sE
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(4001150100001)(36860700001)(83380400001)(2906002)(47076005)(15650500001)(336012)(2616005)(956004)(8676002)(7596003)(41300700001)(82960400001)(356005)(82740400003)(7636003)(478600001)(110136005)(26005)(5660300002)(316002)(86362001)(6636002)(70586007)(70206006)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:20:15.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78effa8-bc7e-42b0-827b-08dbfaeb2b87
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT099.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3973
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C4244B477476499B69550E19EAE4D4@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 14:02:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14058

T24gTW9uLCAyMDIzLTEyLTExIGF0IDEzOjE5ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBzZXJpZXMgYWRkcyB0aGUsIHBvc3NpYmxlIHNpZ25lZCwgZWZpYm9vdGd1
YXJkIGJpbmFyaWVzIHRvIHRoZQ0KPiBkZXBsb3kgZGlyDQo+IGFuZCBhZGRzIHRoZW0gdG8gc3d1
IGZpbGUgYW5kIHN3LWRlc2NyaXB0aW9uIHRvIHVwZGF0ZSB0aGUNCj4gYm9vdGxvYWRlci4NCg0K
SGkgUXVpcmluLA0KDQpJIGp1c3QgdGVzdGVkIHRoaXMgc2VyaWVzIG9uIGEgbmFub3BpLW5lby1j
b3JlIChhcm1oZiB0YXJnZXQpIGFuZCBjYW4NCmNvbmZpcm0gdGhhdCBzd3VwZGF0ZSBzdWNjZXNz
ZnVsbHkgdXBkYXRlZCB0aGUgRUJHLg0KDQpUZXN0ZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZl
bGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+DQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4DQoNCj4g
DQo+IFRoZSBuZXcgZW50cnkgY29udGFpbnMgZm9sbG93aW5nIGluZm9ybWF0aW9uOg0KPiB7DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGVuYW1lID0gIntlZmlfYm9vdF9sb2FkZXJfZmlsZX0i
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXRoID0gIkVGSS9CT09UL3tlZmlfYm9vdF9sb2Fk
ZXJfZmlsZX0iOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZpY2UgPSAie2VmaV9ib290X2Rl
dmljZX0iOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWxlc3lzdGVtID0gInZmYXQiOw0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzaGEyNTYgPSAie2VmaV9ib290X2xvYWRlcl9maWxlfS1zaGEy
NTYiOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOiB7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWMtaW5zdGFsbCA9IHRydWU7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH07DQo+IMKgwqDCoCB9DQo+IENoYW5nZXMgdjI6DQo+IMKgLSBUaGUgZWZpYm9v
dGd1YXJkIGZpbGUgaXMgb25seSBhZGRlZCBpZiB0aGUgbmV3IHZhcmlhYmxlDQo+IGBTV1VfRUJH
X1VQREFURWAgZXF1YWxzIGAxYA0KPiDCoC0gQWRkIHRoZSB2YXJpYWJsZSBgU1dVX0VGSV9CT09U
X0RFVklDRWAgdG8gc2V0IHRoZSBkZXZpY2UNCj4gY29udGFpbmluZw0KPiDCoMKgIHRoZSBlZmli
b290Z3VhcmQgYmluYXJ5DQo+IMKgLSBBZGQgdGhlIHZhcmlhYmxlIGBTV1VfRVhURU5EX1NXX0RF
U0NSSVBUSU9OYCB0byBhbGwgZXh0ZW5zaW9uIG9mDQo+IHRoZQ0KPiDCoMKgIHN3LWRlc2NyaXB0
aW9uIGZpbGUNCj4gwqAtIHVzZSBhdG9taWMtaW5zdGFsbCB0byB1cGRhdGUgdGhlIGJpbmFyeSBh
dG9taWNhbGx5DQo+IA0KPiBRdWlyaW4gR3lsc3RvcmZmICgzKToNCj4gwqAgZWZpYm9vdGd1YXJk
LWVmaS5weTogY29weSBzaWduZWQgZWJnIGJpbmFyeSB0byBERVBMT1lfRElSDQo+IMKgIHN3dXBk
YXRlLmJiY2xhc3M6IEFkZCBTV1VfRVhURU5EX1NXX0RFU0NSSVBUSU9ODQo+IMKgIHN3dXBkYXRl
OiBFeHRlbmQgc3ctZGVzY3JpcHRpb24gdG8gdXBkYXRlIGVmaWJvb3RndWFyZA0KPiANCj4gwqBj
bGFzc2VzL3N3dXBkYXRlLmJiY2xhc3PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCA0Nw0KPiArKysrKysrKysrKysrKysrKystDQo+IMKgcmVjaXBlcy1jb3JlL2lt
YWdlcy9zd3Uvc3ctZGVzY3JpcHRpb24udG1wbMKgwqAgfMKgIDIgKy0NCj4gwqAuLi4vd2ljL3Bs
dWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1lZmkucHnCoMKgwqAgfCAxMyArKysrKw0KPiDCoDMg
ZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQoNCg==

