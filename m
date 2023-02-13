Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13EEC636D4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 02:36:01 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web10.16793.1676301498613802717
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 07:18:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OoOY5jrF;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW3RgDSOM2E9fwuG+uLMHrnuCWulBVub2mdCuhX7QYfhnVNX3Uc4v/D0g/GVua0IvIdbKYG0J310FQoT5eekrwpNXS46xwP4c3vfnnvsS2ev81m9AuUA9x3GhpsXW4SgJBrPTr8KSz0f++aWaWktX1AKd5QVQAPRjxK+htxiWhbMfxPChWDBqr7wx1HugA7VEL3xQe5CXiP5TizoyPa4cyNJl/NJ6lzB9HGR3vU0PKlTYpBN7I6UCe05i/5x8J+g+igy22YX21KciT1Nz0FE2O33rE4Qf/+UAdajA79RUFGROwZJHAq17jyPU+MtaPoe+kkPOCqSMxHpngZ8ufXFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6e48yJOvPUUPvDni9FYVe6I4hVz50sLdvi+T4pdiPM=;
 b=SEW08S+OQ+kYKvKYPMhvWakGagP6JEPZWpNDfSXfhS20N1eR3mFzahmDNT126F4AjeTGu8D7bmmUUSoWj9daVtMj2o7lYEsQo4zmuna5b9Q2LbGueN5vvf62mNq3bbE1zFPkFODPpLPTQJrk9ZYi8Kc8f0t1P87i181H18TM+itTIQE2KPYXrOUnkeKkQ7IXv1pvenbJjCXb3+nf2o/ySYQCMajng4oOBbsq5L0yfJQJ+Qa029z0ykfHUrtaBXbEkPrLM67raGnYbX54NY+zETnpNiV8x9tQq+RiFTL/c1jIhLcDXJ68VkKRxydbYJpG7REQENt1VzqqFhXbFSyz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6e48yJOvPUUPvDni9FYVe6I4hVz50sLdvi+T4pdiPM=;
 b=OoOY5jrFZN3+bVzWcC9y0x7rF1nYodn1Ct7vnDLSjzf0AQCUYVqHMiF6/TcLVfhh5Xh/UfVYUmPmP2DYgLh+cKMSR1x5CrNhTLicibBCCuR1kmSPm+5jdwNQFgQCYQVjhbMcgOrLw5/gEGSpeeY8eHOWPU2GFmHXgN6cO/xaN5jvVM7cmMzVeOofAjBWOEnBzleN9hrWnUnOkqTyaWQbK/lIhTP9mCZMeMumUTcy9pBxwXofJ9IdUjBXAelwmBLzHG3/t073k0c90XJecQWWJa/d9qU7lJen5C66du4idIX0JsJv0nFbICmAMy9dZekKV3klXu1uDmZyUPUgA6lMsQ==
Received: from DB9PR06CA0007.eurprd06.prod.outlook.com (2603:10a6:10:1db::12)
 by AS1PR10MB5438.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Mon, 13 Feb
 2023 15:18:15 +0000
Received: from DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::55) by DB9PR06CA0007.outlook.office365.com
 (2603:10a6:10:1db::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 15:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT049.mail.protection.outlook.com (10.152.5.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.23 via Frontend Transport; Mon, 13 Feb 2023 15:18:15 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Mon, 13 Feb 2023 16:18:13 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 23:18:11 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Mon, 13 Feb 2023 23:18:11 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v4 1/8] register image classes via layer.conf
Thread-Topic: [isar-cip-core][PATCH v4 1/8] register image classes via
 layer.conf
Thread-Index: AQHZPrv0UOtL/FzDK0y+c7gQ1NFkuq7McdmAgAAHUwA=
Date: Mon, 13 Feb 2023 15:18:11 +0000
Message-ID: <cb6012fa494252328ab28e05b4e00ab791eaf27a.camel@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
	 <20230212082758.1166262-2-felix.moessbauer@siemens.com>
	 <7201431e-f281-8a48-dceb-5419673fca3a@siemens.com>
In-Reply-To: <7201431e-f281-8a48-dceb-5419673fca3a@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.127]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT049:EE_|AS1PR10MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c11776-23c8-4c1a-fc6b-08db0dd58774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YuctIBo4t/Tpt4/8xhh+3LrK3AC/POyAXSmGfO/LEXv4VCByVjZ+opefBEKBt7TjsfukYlij4Ru0rl9oCYq7BTU+sVCZzQjaDUcQaKGXT9zL81RBhe6KOYseg8XtKiemTpd2OjJ91CilTrneiluPJNR7+DCwyEqRpGM8bW4/W2v2qqpjTIdSrOEPjCn4EFSWL/hz1T22TO7nGv/VvyqMN/hW8kGlnSAyHrK5y5rBIflW0MLBdJtiXmZHBTPCmAd6ilAYyshd1mJuPS/fff2RFGUuXCbzuywKbMlAkH+fmvPqhyqtoKGdtCBpXDAEAcGbjcwMkLb5KWtykOq9Oh6iEU2gyE+ZqlwPYXpquqIjszMEtuY4hGMUWtMhcXCLtyy8UHphqH2cKpYZNn/QKVjfrw6y5lT9Bgh4mc6GsX5aJOb3vqYlHTRRnQki94Je4iiZSmOniECErRel2j9HlKVLjjU4GZflt9/mK3F6dYQmIdeVwztmPIy5UrHQ7oZyb4pm4mtvu6eq42fdPaq6V043RGGKOnqe2rFGdnc5tI0uyetSdAmjBQuKOdfDqrbhhZgz6arZABXMg/ps1vZbkAM1gsIUgxuMAOXS2AVNaJN33pPuQDlCifoD0uv0MaPnHooIrEONQg8tZnH4VvaDxIGmlYbByAu4nZR6xQ0ZqxnpjpMMBF+S2lxuTvb55r5C4I1B5WFhcTWhPYjfgJKn3Ih88+UXC9WirL2+J9SlHdOAhxA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(336012)(81166007)(40480700001)(186003)(8936002)(26005)(5660300002)(70586007)(107886003)(6636002)(316002)(40460700003)(70206006)(478600001)(8676002)(2906002)(41300700001)(83380400001)(110136005)(54906003)(86362001)(956004)(53546011)(36756003)(82310400005)(4326008)(356005)(47076005)(2616005)(82740400003)(36860700001)(82960400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 15:18:15.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c11776-23c8-4c1a-fc6b-08db0dd58774
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5438
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2C64E991059A4EA3860237A66E8C2C@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Feb 2023 02:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10689

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDE1OjUxICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wMi4yMyAwOToyNywgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IHJlZ2lzdGVycyB0aGUgcHJvdmlkZWQgaW1hZ2UgY2xhc3NlcyB2aWEgdGhlDQo+ID4gYmJsYXll
ci5jb25mDQo+ID4gZmlsZS4gQnkgdGhhdCwgbm8gbWFudWFsIGFkZGl0aW9ucyBvZiB0aGVzZSBj
bGFzc2VzIHZpYSBrYXMgaXMNCj4gPiByZXF1aXJlZA0KPiA+IGFuZCBlcnJvbm91cyBpbXBsZW1l
bnRhdGlvbnMgYXJlIGRldGVjdGVkIGVhcmx5IChlLmcuIG1hbmRhdG9yeQ0KPiA+IGlucHV0cw0K
PiA+IHdpdGhvdXQgZGVmYXVsdHMpLg0KPiA+IA0KPiANCj4gVGhlbiB3aHkgaXMgdGhpcyBjb21t
aXQgbm90IHJlbW92aW5nIHRob3NlIG9ic29sZXRlIElNQUdFX0NMQVNTRVMNCj4gYWRkaXRpb25z
Pw0KDQpHb29kIGNhdGNoLiBUaGUga2FzLWZpbGUgY2hhbmdlcyByZWcuIElNQUdFX0NMQVNTRVMg
ZnJvbSB0aGUgZm9sbG93aW5nDQpjb21taXRzIHNob3VsZCBiZSBtb3ZlZCBpbnRvIHRoaXMgY29t
bWl0Lg0KDQpXaWxsIHNlbmQgYSB2NSB0b21vcnJvdy4NCg0KRmVsaXgNCg0KPiANCj4gSmFuDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJA
c2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gwqBjb25mL2xheWVyLmNvbmYgfCAyICsrDQo+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2NvbmYvbGF5ZXIuY29uZiBiL2NvbmYvbGF5ZXIuY29uZg0KPiA+IGluZGV4IDBjNWZkMzkuLjJj
ODg4YjIgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZi9sYXllci5jb25mDQo+ID4gKysrIGIvY29uZi9s
YXllci5jb25mDQo+ID4gQEAgLTIyLDMgKzIyLDUgQEAgTEFZRVJTRVJJRVNfQ09NUEFUX2NpcC1j
b3JlID0gIm5leHQiDQo+ID4gwqANCj4gPiDCoExBWUVSRElSX2NpcC1jb3JlID0gIiR7TEFZRVJE
SVJ9Ig0KPiA+IMKgTEFZRVJESVJfY2lwLWNvcmVbdmFyZGVwdmFsdWVdID0gImlzYXItY2lwLWNv
cmUiDQo+ID4gKw0KPiA+ICtJTUFHRV9DTEFTU0VTICs9ICJzcXVhc2hmcyB2ZXJpdHkgc3d1cGRh
dGUiDQo+IA0KDQo=

