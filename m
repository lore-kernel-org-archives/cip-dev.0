Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8033FC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 13:07:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web10.76279.1675744786326605797
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 20:39:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KAL2cihp;
 spf=pass (domain: siemens.com, ip: 40.107.21.89, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0T7CTawwVaUK5xQYl1A25iKh36bynYsd/1HcXQsYbFzHiX+9cuqoIekY+SeGZXtNEjwpZHClGGqeLgC18ac5SPhuMmZwdupDxZErfnEJBPnakHr0HwX7/a8WvpbZoiUPgJF9pOgvGPUwq/hgPJlF2ha6qhH6QSDwrqsIwICNViVxMPdk66w7iHZKzs/2gxkxbTP0Ul+irnIxdgnCZ9tkvKbsuwpqymXTcro1Oc44SO4XQi/oZEyvNg1xIuO5m6Brp/PhrQLAP+WEjXpKwXCdkwbzVVw5IbK0+zQPGbeZo9GFofqLH4HDSiXh3eMd77FEXvWQYFWDckNuuBTa5RpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LANpVdt70JLFkQFXdlcj0HqhwzmZAFy56UU92xwpTY4=;
 b=KqoUnIMlUKRpA92d9qRh3d8sarFTuoJxj1hf6KA0d8QAol+TSjiTdKtroQKsueH4wkPf6pUCXxxLke58x4SRWYTU7HLAptP4LuqXLWXrJT5MyVK0I1mDyqrH6yUllEcX+vEwbN8OuKt7zFtbgHgRqLeMlwpEppUFrH71dhXFJUkgetvbcfqLbFpTyh7wGNrpewJEYVLx9trJQmzgfIYVaQ32IuqBlVkRVmrBM6Wre+VcsBfID1+lEWxlXW2j6ZRfby68bVLFM4LlsnwxeXgyCny1bNXGXO8sTPSb0ExPF9kd8zlQqkHSgpFa9zZZ9nnJogDJaip46MhlF+T8eo1KQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LANpVdt70JLFkQFXdlcj0HqhwzmZAFy56UU92xwpTY4=;
 b=KAL2cihpUoZVqgk+slOJw4p+FRcCOjmylkSVI08X9iyYV7Ly3zgh05yS+iMzLMW+93ARVN9CMlVtM+e8SAqfITExMK1UovC98byJR+Jg4FY+yuv8uAhN1NqIIcK14FplagzmybM4NlQ9aMor7/Nc4mGysVi8VbVkGxBvzsz/Esyj66ThWxkhQO+uAgnhOGoXgoUnqdSTSTn3hpSJCQDjK+l02GfH2PsWduvNXttQSDGWoZXqwXc+RbdwCqikIGm4/aVskRaUOOTPGCAnIv32gpGqwZ98Ym0+nhjHd1R4r/1iOyrnLoif3XcCzQAvf26dzPBCMNp0ac7n5Mnft1SuMQ==
Received: from DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) by DB4PR10MB7471.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3cd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 04:39:42 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46a:cafe::fd) by DUZPR01CA0076.outlook.office365.com
 (2603:10a6:10:46a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 04:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 04:39:42 +0000
Received: from CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Tue, 7 Feb 2023 05:39:41 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M07MSX.ad011.siemens.net (139.24.237.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Feb 2023 12:39:39 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Tue, 7 Feb 2023 12:39:39 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "venkata.pyla@toshiba-tsip.com"
	<venkata.pyla@toshiba-tsip.com>
CC: "isar-users@googlegroups.com" <isar-users@googlegroups.com>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core] Update ISAR revision
Thread-Topic: [isar-cip-core] Update ISAR revision
Thread-Index: AQHZOq4whC+SoLH490qw3hpQFhHL8w==
Date: Tue, 7 Feb 2023 04:39:39 +0000
Message-ID: <bfa0ec43563dca91594858896c7e5c2fe751ef03.camel@siemens.com>
References: <20230206115118.930-1-venkata.pyla@toshiba-tsip.com>
	 <d5ebd21e-547b-1f94-8f38-986aec3ae39c@siemens.com>
In-Reply-To: <d5ebd21e-547b-1f94-8f38-986aec3ae39c@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [140.231.210.96]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT096:EE_|DB4PR10MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c210d64-c962-4907-14ea-08db08c554c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h37gzCGLaal/EMyzUlWz868dYM16nLdOIJlxzjce7mPtHDlgM9HnDASOzApiNtvcS93/T31wPA7i9Z3XwuTonGu7oiZ6yFGzxJx5XZIuqcjClHzehaHJIOaewJM0lVlV8JcG/XYSAZom4jEAmsq77ltowRmgJywFxZ/UgbrQdILrIIEOMClam2jadB2IEi36XzNTALsJGvKngZ1/wH/CkKjse4tYDTXUlpZ6b0YRJkeeer402M2su3fajlZlj3kJrYyUO2KAgPkgsYpqpc4Nt6ZOM5qO4djdbNAzHeUvvM30YmRneQqywUpO6f/9RwxH03HjeDHb4L41WC6coTQdLdeIOYB9hv1mOYN72qRBXQtwwjAOK4Y5fuLT9ZqCj7T6Rg924NVGO5pc8/bAAG3D/vTtceDgtIwbzSKhDqF1ItZ5/IlRs/7ljegLQJgmNRiJGhvOHga902YbGxmdmgj1zMNNgJL3D0nRSx3RKuF3yr93a+am0CFT4eYk7aVlasla46VwWaEiLhThtDDmy4ImS7nfT2sMJma2G3Wp+48SEEXgZ67FsGSJTckH2zHTzM35xPzYZ53XNSlyhk+PfIypiTjndPV36R+JLXKHenBhnwCcZsiu7rf22BU8l2nyj6qWz0HTkLPXeH1Zao3JO3IdxbNaYm7l12OwsTg5O/Lja9YP0VhaloM0BWVLpGuiuqEoOdIpv3LNOSJp0/3pvxbdFm/Y9TTOZ9vu/whvzUsQOvU=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(478600001)(82310400005)(966005)(186003)(356005)(26005)(53546011)(8676002)(4326008)(40480700001)(70586007)(2906002)(86362001)(36756003)(15650500001)(70206006)(8936002)(41300700001)(5660300002)(40460700003)(54906003)(110136005)(7596003)(316002)(83380400001)(336012)(47076005)(7636003)(36860700001)(82960400001)(82740400003)(2616005)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 04:39:42.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c210d64-c962-4907-14ea-08db08c554c3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7471
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F1F1238782A1547A28691D1A08DCDA9@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 13:07:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10625

T24gTW9uLCAyMDIzLTAyLTA2IGF0IDE0OjAxICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNi4wMi4yMyAxMjo1MSwgdmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb23CoHdyb3RlOg0K
PiA+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGli
YS10c2lwLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGthcy1jaXAueW1sIHwgMiArLQ0KPiA+IMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2thcy1jaXAueW1sIGIva2FzLWNpcC55bWwNCj4gPiBpbmRleCBiOTcwZjM5Li4w
NDllY2E4IDEwMDY0NA0KPiA+IC0tLSBhL2thcy1jaXAueW1sDQo+ID4gKysrIGIva2FzLWNpcC55
bWwNCj4gPiBAQCAtMjIsNyArMjIsNyBAQCByZXBvczoNCj4gPiDCoA0KPiA+IMKgwqAgaXNhcjoN
Cj4gPiDCoMKgwqDCoCB1cmw6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbGJlcnMvaXNhci5naXQNCj4g
PiAtwqDCoMKgIHJlZnNwZWM6IGZjNGYwMDRlYjY3MjM3ZDlkMDliMWZmYWQwZGUxYTE5MjE3ZmE5
NGENCj4gPiArwqDCoMKgIHJlZnNwZWM6IDczZjBjYzE2Y2E1MGYxMTAyMDg0ODUxYjFiYzBmMmQ1
OTkyNWM5YWQNCj4gPiDCoMKgwqDCoCBsYXllcnM6DQo+ID4gwqDCoMKgwqDCoMKgIG1ldGE6DQo+
ID4gwqANCj4gDQo+IEkgaGF2ZSBhbiB1cGRhdGUgdG8gdGhlIGxhdGVzdCByZXZpc2lvbiBwZW5k
aW5nLCBidXQgaXQgaXMgY3VycmVudGx5DQo+IGF3YWl0aW5nIGFuIHVwc3RyZWFtIGZpeC4gV2ls
bCBicmluZyBiaXRiYWtlIDIgdGhlbi4NCg0KV2l0aCB0aGF0IHZlcnNpb24sIGRlYmlhbiBib29r
d29ybSB0YXJnZXRzIGFyZSBzdGlsbCBicm9rZW4uDQpUaGUgcmVxdWlyZWQgZml4ZXMgZm9yIGF0
IGxlYXN0IGFtZDY0IGFyZSBhbHJlYWR5IGluIG5leHQsIGJ1dA0KdW5mb3J0dW5hdGVseSBhZnRl
ciB0aGUgYml0YmFrZSAyLjAgYnJlYWtpbmcgY2hhbmdlLiBBIGZpeCBmb3IgcmlzY3Y2NA0KaXMg
c3RpbGwgd2FpdGluZyB0byBiZSBpbnRlZ3JhdGVkIChJJ20gdGhlIGF1dGhvcikuDQoNCklNSE8g
d2Ugc2hvdWxkIGVpdGhlciB3YWl0IHRpbGwgbmV4dCBpcyBpbnRlZ3JhdGVkIGluIG1hc3Rlciwg
b3Igc3dpdGNoDQp0byBuZXh0IHRoaXMgdGltZS4gRWl0aGVyIHdheSwgd2UgaGF2ZSB0byBkbyB0
aGUgYml0YmFrZSAyLjAgbWlncmF0aW9uLg0KDQpIYXZpbmcgYml0YmFrZSAyLjAgc3VwcG9ydCBh
bnl3YXlzIGhlbHBzIGFzIG1hbnkgZG93bnN0cmVhbSBsYXllcnMgYXJlDQpub3cgbG9ja2VkIHRv
IGEgYnJva2VuIElTQVIgdmVyc2lvbiBmb3IgYm9va3dvcm06IG5vIHdheSBmb3J3YXJkDQpiZWNh
dXNlIGNpcC1jb3JlIGlzIG5vdCBiYjIuMCwgbm8gd2F5IGJhY2t3YXJkIGJlY2F1c2Ugb2YgdGhl
IHJlcG8NCmNoYW5nZXMgaW4gYm9va3dvcm0gYW5kIGV4cGlyZWQga2V5cy4NCg0KSnVzdCBidW1w
aW5nIHRoZSB2ZXJzaW9uIGlzIG5vdCBzdWZmaWNpZW50IHRoaXMgdGltZS4NCg0KUFM6IHB1dHRp
bmcgdGhlIElTQVIgTUwgaW4gQ0MgdG8gY3JlYXRlIG1vcmUgYXdhcmVuZXNzIG9uIHRoZSBpc3N1
ZS4NCg0KRmVsaXgNCg0KPiANCj4gSmFuDQo+IA0KDQo=

