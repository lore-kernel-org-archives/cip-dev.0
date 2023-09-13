Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEAAEDEC50
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 13:02:35 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.49])
 by mx.groups.io with SMTP id smtpd.web11.2114.1694568386902812149
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 18:26:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CbdnR51E;
 spf=pass (domain: siemens.com, ip: 40.107.6.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBxDce5AsRYfuB+Rvju+ovfPXZEEhK8zdDpERd9PPJkXmWr1hmv1aNSUxHGbPSOEp87du3yNcumik+vJeo+a40YKGfG1t0P8mFnDNlO+VLCzL+A55FyJoi0CYU9cl74kizMbrxWBJHGKkzfdW+ttB/NR45r9t7JwouMC7hXSJAN7Wp+taZHnwDJFd2ifClo/l+xEnll2Xs41vHvrXzk5dnoiToHCrqE9ggyENpNjE53XnoVhrHjvjWR5zKhWn21fSgKHMxIQz1DlAmaRR+k1TqICOJEKpCF5xDLcmNG/2JF6nvy6nst7qneRYT/5+6Os4y4BoteBtYqMbaQKjCDBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54npdY1da1y8pck86kQ9nEdr+HOA9vU3AAM2YtDasLs=;
 b=RW/ydnjrQFTrfJqWoa0BOrGcG1zybz6Qo3w5iXAfuVhd6K6DuCobUiH3YrrJ6+42Lp6XmXLRRJS8Sng+27r2VVGKMcQKUmhEeTVBiBPQCUZOq2j+5n1/2VjyeTVArjJVIY8wDq9rPLUP3QN8igGGm4W3sNAU9UDujV2oNXebevt+m9k0/2GTbWQF+0lgXBFnBUo4UVYBaR9+gG9vPzuMr8NTDWBDNwKEKwaxEivwzA34jt5AP/42DetaalZpWG2gZkr3IlBHCPMWghGvy/V/fLCcPl8IREB+G/sZCP+HEQYfcc3CtOPn74sJ7rYbiIwPfbqwwHp3uVFEzTTiSZIoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54npdY1da1y8pck86kQ9nEdr+HOA9vU3AAM2YtDasLs=;
 b=CbdnR51E3o2l8SKf3u/vPXtIp0egTUfY8Xos3a4SiA82VQVFtvIgBX9gRcC3X6sfO/fGlTfGW5nKtnP+NfcPeJXPglSmCraJbSdbOrdlAoVe/+QJzRmFe6tdol79C8sCrAQx+VSd9dYPrOgxNQt4G3k0SRNQvPBO0fDfz8nsUacsib3kBFltRxVxxJR5j/r+BVYkEQEY/bMdYkBGCCJMI4MD4+gjzZq2d3ooP1SC0vTGSvsrGBRL4qLR9LNFBOLBL3+bicU89JZaID9NpiScEQEk6XlWe+TuzPsJHeqtiWXWplfsqB5jmkw/QW8kUP7knTd85Fk9TZYFQt/Bz8ulLQ==
Received: from DU2P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::9) by
 GV2PR10MB6091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Wed, 13 Sep 2023 01:26:23 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::57) by DU2P251CA0007.outlook.office365.com
 (2603:10a6:10:230::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 01:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 01:26:22 +0000
Received: from CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Wed, 13 Sep 2023 03:26:20 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 09:26:09 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Wed, 13 Sep 2023 09:26:09 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure sync on rebuild
Thread-Topic: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Thread-Index: AQHZ1cWuXRgLMF7zIUio1/bIjT8i3K/+xVKAgBfLBACAAATOAIAA+7wA
Date: Wed, 13 Sep 2023 01:26:09 +0000
Message-ID: <cfe1f5d1076d50f409e6f2f6aea7728ca8f06695.camel@siemens.com>
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
	 <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
	 <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
	 <c90ebb07-260e-496b-9280-c340ae41c26b@siemens.com>
In-Reply-To: <c90ebb07-260e-496b-9280-c340ae41c26b@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.122.232]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|GV2PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f0a897-1373-4cd7-1e60-08dbb3f870c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jvKs75nEsAmDvFK9aaeAFMak31DMygvLxL0qWCVu0kkS63DZVuSkyBCngAA5wvjdPyhwzFcujGqCyC807DikPNug+8/H2y9IBtbd8aeeN3tpY4KSuvoHMqXYkFu3IQVsgHwUJWdl+koIyoE3oHF4Hpwrb+h5GJwbJf4uWSDQk/l2a9OWc+huQPAnQlkMZCZfs/IiYAwWHMk9FC2VWf9QLrTI4yp0zlML1sCvITbqJ8nQyHDqsSXHuApmK1I9YXblYB+9ksvTh08Hy2jPpI2qEeEmbDFKYRVPDTyRAJMOGpgcpfbAqWBZoThc2B4d3CXZ3sJfn/u7KJKYjTX9Ftf8J8mE+xR8SlLPQrS/aTaWZ6w3BIywK8yIkAxJJh8QjD90Q1UgS9EiaXN8cgIidUsMaFNj0GXzy4GO2mjvBU6NUbs5Uh8iwLPbT6Jy152n7/sTLZ/7fIftYuBUO9DjCZERpAsz9CZ1VvU3vMauuOJaUIC5gvR7ePJgl7QIpTrK17wRhJZ1Nlq/kPf7cBwKuWlnYqgwKJgA6q0QuRlQO8rlH/FxV94eH9C5Ip5MHgqT82Q7HnXXggndVGkKIYmY+2fGYxpscnlQ8tAS0a7tj4hx5Kna5PPa0xqnD5RszsWtYeIfTsJVpvAobmPsvvv8cXJRKMItnxZ2irp+kRctVFOzgz7rn6FlGUKqj0XoXQOVJj/Im4XRUs0TCFYqlj0abdX90snTqUkLdVKnTDkheOIs0wbKbc1kpezJ6KoL4b5EaQGWOmKRuiFu1mknsj0VevduyQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(316002)(4326008)(8676002)(53546011)(70206006)(47076005)(110136005)(70586007)(40480700001)(6636002)(5660300002)(83380400001)(8936002)(336012)(82960400001)(41300700001)(86362001)(36756003)(36860700001)(26005)(2616005)(2906002)(107886003)(40460700003)(356005)(956004)(81166007)(478600001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:26:22.7856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f0a897-1373-4cd7-1e60-08dbb3f870c8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6091
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B69E05D8FD5307409F1BD9280DEBD3F1@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 13:02:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13098

T24gVHVlLCAyMDIzLTA5LTEyIGF0IDE1OjU1ICswNTMwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wOS4yMyAxNTozNywgR3lsc3RvcmZmIFF1aXJpbiB3cm90ZToNCj4gPiANCj4gPiANCj4g
PiBPbiA4LzI4LzIzIDA4OjQ3LCBKYW4gS2lzemthIHdyb3RlOg0KPiA+ID4gT24gMjMuMDguMjMg
MTU6MjgsIFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6DQo+ID4gPiA+IEZyb206IFF1aXJpbiBHeWxz
dG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBE
aXNhYmxlIHRoZSB0aW1lc3RhbXAgb2YgdGhlIGRvX2luc3RhbGwoKSB0YXNrIHRvDQo+ID4gPiA+
IHJlLWV4ZWN1dGUgd2hlbiBldmVyIGEgZGVwZW5kZW5jeSBvbiBkb19pbnN0YWxsDQo+ID4gPiA+
IGlzIGV4ZWN1dGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gV2l0aG91dCB0aGlzIGNoYW5nZSB0aGUg
c3N0YXRlIG5lZWRzIHRvIGJlIGNsZWFuIGZvcg0KPiA+ID4gPiBldmVyeSByZWJ1aWxkLg0KPiA+
ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgIC4uLi9pbml0cmFt
ZnMtdmVyaXR5LWhvb2svaW5pdHJhbWZzLXZlcml0eS0NCj4gPiA+ID4gaG9va18wLjEuYmLCoMKg
wqDCoMKgwqDCoMKgIHwgMyArKysNCj4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL3JlY2lwZXMt
aW5pdHJhbWZzL2luaXRyYW1mcy12ZXJpdHktaG9vay9pbml0cmFtZnMtdmVyaXR5LQ0KPiA+ID4g
PiBob29rXzAuMS5iYiBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy12ZXJpdHktDQo+ID4g
PiA+IGhvb2svaW5pdHJhbWZzLXZlcml0eS1ob29rXzAuMS5iYg0KPiA+ID4gPiBpbmRleCAzZmM2
M2VkLi43NDM1NjQ5IDEwMDY0NA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gYS9yZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtdmVyaXR5LWhvb2svaW5pdHJhbWZzLXZlcml0eS0NCj4gPiA+ID4gaG9v
a18wLjEuYmINCj4gPiA+ID4gKysrDQo+ID4gPiA+IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJh
bWZzLXZlcml0eS1ob29rL2luaXRyYW1mcy12ZXJpdHktDQo+ID4gPiA+IGhvb2tfMC4xLmJiDQo+
ID4gPiA+IEBAIC00MCw2ICs0MCw5IEBAIGRvX2luc3RhbGxbY2xlYW5kaXJzXSArPSAiIFwNCj4g
PiA+ID4gwqDCoMKgwqDCoCAke0R9L3Vzci9zaGFyZS9pbml0cmFtZnMtdG9vbHMvc2NyaXB0cy9s
b2NhbC10b3AgXA0KPiA+ID4gPiDCoMKgwqDCoMKgICR7RH0vdXNyL3NoYXJlL2luaXRyYW1mcy10
b29scy9jb25mLWhvb2tzLmQiDQo+ID4gPiA+IMKgICsjIEVuc3VyZSBWRVJJVFlfRU5WX0ZJTEUg
aXMgdXBkYXRlZCBhbHNvIHdoZW4gcmVidWlsZGluZw0KPiA+ID4gPiBpbml0cmFtZnMtdmVyaXR5
LWhvb2sNCj4gPiA+ID4gK2RvX2luc3RhbGxbbm9zdGFtcF0gPSAiMSINCj4gPiA+ID4gKw0KPiA+
ID4gPiDCoCBkb19pbnN0YWxsKCkgew0KPiA+ID4gPiDCoMKgwqDCoMKgICMgSW5zZXJ0IHRoZSB2
ZXJpdHlzZXR1cCBjb21tYW5kbGluZSBpbnRvIHRoZSBzY3JpcHQNCj4gPiA+ID4gwqDCoMKgwqDC
oCBpZiBbIC1mICIke1ZFUklUWV9FTlZfRklMRX0iIF07IHRoZW4NCj4gPiA+IA0KPiA+ID4gTm8g
b3RoZXIgZHBrZy1yYXcgcGFja2FnZXMgcmVxdWlyZSB0aGlzLCBkbyB0aGV5PyBXaGF0IG1ha2Vz
DQo+ID4gPiBpbml0cmFtZnMNCj4gPiA+IHBhY2thZ2VzIHNwZWNpYWwgaGVyZT8gQW5kIHdoYXQg
YWJvdXQgdGhvc2UgaW4gaXNhciB1cHN0cmVhbT8NCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgaXMg
bmVjZXNzYXJ5IGZvciB0aGUgaW5pdHJhbWZzIHBhY2thZ2Ugd2hpY2ggY29udGFpbiB0aGUNCj4g
PiBjaGVja3N1bS91dWlkIGZyb20gdGhlIHJvb3QgZmlsZSBzeXN0ZW0gYnVpbGQuDQo+ID4gVGhp
cyBlbnN1cmUgdGhhdCB0aGUgY2hlY2tzdW0vdXVpZCBpcyByZWZyZXNoZWQuDQo+ID4gDQo+ID4g
SXQgZml4ZXMgdGhlIHByb2JsZW0gdGhhdCBhbiByZWJ1aWxkIG9mIGEgdmVyaXR5IGltYWdlIGxl
YWRzIHRvIGENCj4gPiBicm9rZW4NCj4gPiBib290IGFmdGVyIHRoZSBidWlsZC4NCj4gDQo+IEFu
ZCB3aGF0IHdpbGwgaGFwcGVuIHdoZW4gdGhlIHVzZXIgZGVjaWRlcyB0byBwaW4gdGhlIFVVSUQg
dG8gZml4DQo+IHZhbHVlDQo+IGluIG9yZGVyIHRvIGhhdmUgcmVwcm9kdWNpYmlsaXR5PyBXb24n
dCB0aGF0IGNhdXNlIGEgbmVlZGxlc3MgcmUtcnVuPw0KPiBTaG91bGRuJ3QgdGhpcyByZWNpcGUg
cmF0aGVyIG1ha2Ugc3VyZSB0byBkZXBlbmQgb24gdGhlIFVVSUQgdmFsdWU/DQoNClRoaXMgaXMg
YSBnZW5lcmFsIHJlcHJvZHVjaWJpbGl0eSB0b3BpYzogVGhlIHRhc2sgY2hlY2tzdW1zIGFyZQ0K
Y29tcHV0ZWQgYXQgcGFyc2luZyB0aW1lIGFuZCBieSB0aGF0IHRoZSB0YXNrcyB0aGF0IG5lZWQg
dG8gYmUgcmUtcnVuDQphcmUgc2VsZWN0ZWQuIEhvd2V2ZXIsIHRoaXMgaXMgYmFzZWQgb24gdGhl
IGFzc3VtcHRpb24gdGhhdCB0YXNrcyBhcmUNCmRldGVybWluaXN0aWMsIGkuZS4gc2FtZSBpbnB1
dCBkYXRhIGFsc28gZ2VuZXJhdGVzIHNhbWUgb3V0cHV0IGRhdGEuDQoNClVuZm9ydHVuYXRlbHkg
d2UgYXJlIHN0aWxsIG5vdCAxMDAlIHJlcHJvZHVjaWJsZS4gQnkgdGhhdCB0aGlzIHByZS0NCmNv
bmRpdGlvbiBpcyBub3QgbWV0LiBGb3Igbm9ybWFsIHBhY2thZ2VzIHRoaXMgZG9lcyBub3QgcmVh
bGx5IG1hdHRlciwNCmJ1dCBmb3IgdGhlIGRtLXZlcml0eSBjaGVja3N1bSB0aGlzIHZlcnkgd2Vs
bCBtYXR0ZXJzLg0KDQpJJ20ganVzdCB3b25kZXJpbmcgaWYgd2UgY291bGQgd29yayBhcm91bmQg
dGhhdCBieSBtYWtpbmcgdGhpcw0KY29tcG9uZW50IG5vbi1jYWNoZWFibGUuIFB1dHRpbmcgQWRy
aWFhbiBpbiBDQyBmb3IgdGhlIHNzdGF0ZSBwYXJ0Lg0KDQpGZWxpeA0KDQo+IA0KPiBKYW4NCj4g
DQoNCg==

