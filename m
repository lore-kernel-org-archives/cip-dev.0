Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E7AE95A82
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:10 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web10.36149.1696763808971989827
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 04:16:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VOaCj5Of;
 spf=pass (domain: siemens.com, ip: 40.107.7.85, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0EHuSipMPGKaIp+Pj1p0I78u/3UO5OJSUEBHhBVrsG7gz83awDUxU7Og4gqu1Ab6SXF+GNDFfVBdWUmR3in/flMmGnO1zNuEouLbVg6323zCGJmMFpGBuadkUjnmBLbdhMr2T2CIvhnZk3pC1SoHa4N59kBDs7Y6TtTBSJuX2Y9r/3e9RwgWMIzl1wULmRXHgWnNyiFHiUGD5H6vxYBycWL/k6FhxeLUW9xXSR4erWgjjsXucIx2WPIYPtkSFamMlnMAiPlMHgMjbNn0ephcQotUji0ZofrFO81m8zvnPDPWqHlZduD+gXK7pa4sroowjMRRhz+Xbfs974gm8SwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UB30C0rqNLn4hwgps4/XD++h9WtokmvHXrvObxixCQ=;
 b=Jy+qRKnwSTWHQsRaQBxq++wsEdVAt80tAbsdtQFbTMekBBjAWBrHAcvlcU+xTc9qZayA534n4owSs3y88H05kNY5X33R8SgEqcDg8QRKhVWqrQ9xppkL8rIT5aKyfTf0e/v9uDIBt1aQkQztg60z7K1TVfKzOo9jefw1It3pnAW11AqBvWmV1IV+sZOh4vwsiD8x0rjV5wN8PCoSsaFIQqWNVul2mcb/BWIInZZr74oqkeY48vV05sM5HpGgKbl8rB5ix9Jj6ZSN7LTMu6kyqvmDd7odnJM25sgxnS4eJMWr2T5eypgLyIAnUK4m2/Xnc5UYQB+G+AotZvJ6Sn6/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UB30C0rqNLn4hwgps4/XD++h9WtokmvHXrvObxixCQ=;
 b=VOaCj5Of83RRA+PJ0SV7rDyYsYjG/iPnlXdeqBkM/NdDrjKM4gjs0+RE00upZfEOGKeAakYmdljlEcLwPZ+W4BEsbXvjkFyJIyoBsBTgnZPm2Yi4Q+6j/Ius2qvmBUeTH0TF0ZueP8YgIq48BnfpSOjKW4Lkd7t+uX+8Z/3PA5h5qK5uF8TlL6S4uCprgrh1YK1WQ2bMRZmzAJmhLkBfQhHY93N+gvCYxVyBtAwxLIBSTGQoNho1YYyKD1CiVWJEb7GqUPCusYHZGEAQUnRzrEKCUZYh8mf2BnIXcsFsMuz1alX+Q4nulb1KiqejUsYlKgSEU3fDXIdflfcBmV+cpw==
Received: from DB8PR03CA0035.eurprd03.prod.outlook.com (2603:10a6:10:be::48)
 by AS8PR10MB6866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sun, 8 Oct
 2023 11:16:45 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::ba) by DB8PR03CA0035.outlook.office365.com
 (2603:10a6:10:be::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Sun, 8 Oct 2023 11:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sun, 8 Oct 2023 11:16:44 +0000
Received: from CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Sun, 8 Oct 2023 13:16:43 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 19:16:41 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Sun, 8 Oct 2023 19:16:40 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"isar-users@googlegroups.com" <isar-users@googlegroups.com>
Subject: Re: [isar-cip-core][PATCH 0/4] make compatible with latest ISAR revision
Thread-Topic: [isar-cip-core][PATCH 0/4] make compatible with latest ISAR
 revision
Thread-Index: AQHZ+ZW+o2pQTrrS50GVTolBJbdtlrA/OIiA
Date: Sun, 8 Oct 2023 11:16:40 +0000
Message-ID: <be41f36b6bb8a295a01115ff82e692430725c441.camel@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
In-Reply-To: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.53]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AS8PR10MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: a552f5c4-1f7e-4df8-4b76-08dbc7f00e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SDPqBJVfzsKjkLKS/mDM8kHUvYwKkhoI44as0GiM2caJqIbOLWhVD3ySTxTZbrdyq3y/qGKzz4Y4NT31EYMLtPxVxeR/qQ8Pcod0yBsj6cpSQTId5QOUoHWDLqf/hQI67C9gBbcjm/GmQ0AbQ7Kn1DalH2LAg8ac0TyQ6FOwrF3KBhdHqfqUnhjMTT8Ablph+mVDv7hBhle8y0QIO430yDGU/AAupCO5iogbqwEq5CGSUulw2r4GEE3oxJqv5rdCGy9IPm0zOEiyIuz7ZCsAuuHIlqHWmKtPZH6xdw1KmSVdjZ+7LsbHNQkbVsSicSpxKXZkVEfZ6bWknLn0f4cb4VdwppO/YULRxyJdjqS1rRgDWU6hBBkUnaLIREMMR0TlugDR4GCq6QM2xyjkAC6Ac8akqL1vQnSfGtJPerwLzx6/hVuGLTK9GE1E/bKmmBrw+7kxJk8qp9CDLGxwOjg80JpHKkCRcRjDg7T8JB/87Bf1En18euBsudoZG7NYDfPAKa0eQVtwGZcgGhJNVx3CeVmNB7SGZRDwXSyFPQSdemGnW4LlBbtiA+n3HtVtIxQzT6GQpFfNeB2CdO3xqy1qwIofS994CZMT1zNcopI3rQ3JBJ2INJOx76EwecNlLTlbpH7ovuWzUQ07bLhWTIRPAEFwELWgJowYYhkW8zx3jJ1wZ3h7L2qArzFSZweXzPzhFRyvarfdr5Hri9ITUs1sjGT5yk3EIqh/BDcZMF55xxTC6WIbt/5U4s12rmyBudwRJG2zGieANhQNRUrjlagKuw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40460700003)(82960400001)(356005)(86362001)(82740400003)(81166007)(47076005)(36860700001)(36756003)(26005)(2616005)(956004)(83380400001)(336012)(40480700001)(70206006)(54906003)(316002)(6916009)(70586007)(41300700001)(2906002)(5660300002)(8936002)(4326008)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 11:16:44.7801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a552f5c4-1f7e-4df8-4b76-08dbc7f00e43
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6866
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6211FDF9FBE0F48AB8B3833F4620BAE@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13306

T24gU3VuLCAyMDIzLTEwLTA4IGF0IDExOjE1ICswODAwLCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3Rl
Og0KPiBUaGlzIHNlcmllcyBhZGFwdHMgdGhlIGltYWdlciBwYXJ0cyBvZiBjaXAtY29yZSB0byB0
aGUgbmV3IHNjaHJvb3QtDQo+IGJhc2VkDQo+IGltYWdpbmcgaW4gSVNBUi4gVGhpcyBjaGFuZ2Ug
aXMgcmVxdWlyZWQgdG8gbWFrZSBpdCBjb21wYXRpYmxlIHdpdGgNCj4gdGhlIGxhdGVzdA0KPiBt
YXN0ZXIgYnJhbmNoIG9mIElTQVIuIEZpbmFsbHksIHRoZSBJU0FSIHZlcnNpb24gaXMgYnVtcGVk
Lg0KDQpXaGlsZSB0ZXN0aW5nIHRoaXMgb24gYSBicm9hZGVyIHNjb3BlLCBJIG5vdGljZWQgdGhh
dCBpbiBzb21lIGNhc2VzIHRoZQ0KaW1hZ2UgdXNlcnMgYXJlIG5vdCBjcmVhdGVkIGNvcnJlY3Rs
eSAodGhlIHVzZXIgaXMgY3JlYXRlZCBhY2NvcmRpbmcgdG8NCi9ldGMvcGFzc3dkLCBidXQgdGhl
IHBhc3N3b3JkIGRvZXMgbm90IHdvcmspLg0KSSBjYW4gcmVsaWFibHkgcmVwcm9kdWNlIHRoaXMg
b24gYW4gaW50ZXJuYWwgdGFyZ2V0LCBidXQgdW5mb3J0dW5hdGVseQ0KdGhpcyByZXF1aXJlcyBh
bHNvIHJlYWwgaGFyZHdhcmUuIFRoZSBhZmZlY3RlZCBpbWFnZSB1c2VzIHN3dXBkYXRlIHdpdGgN
CmViZy4NCg0KSXMgdGhlcmUgYW55IHJlY2VudCBjaGFuZ2UgaW4gSVNBUiB3aGljaCBlZmZlY3Rz
IHRoZSBwb2ludCBpbiB0aW1lIHdoZW4NCnVzZXJzIGFyZSBjcmVhdGVkPyBQdXR0aW5nIHRoZSBJ
U0FSIE1MIGluIENDLg0KDQpGZWxpeA0KDQo+IA0KPiBOb3RlOiBUaGlzIHNlcmllcyBkZXBlbmRz
IG9uICJkcm9wIGRlcGVuZGVuY3kgdG8gbm8gbG9uZ2VyIGV4aXN0aW5nDQo+IGJ1aWxkY2hyb290
Ii4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gRmVsaXggTW9lc3NiYXVlcg0KPiANCj4gRmVsaXgg
TW9lc3NiYXVlciAoNCk6DQo+IMKgIG1ha2UgZGVwbG95LW92bWYgY29tcGF0aWJsZSB3aXRoIHNj
aHJvb3QgaW1hZ2luZw0KPiDCoCBtYWtlIHN3dXBkYXRlIGNsYXNzIGNvbXBhdGlibGUgd2l0aCBz
Y2hyb290IGltYWdpbmcNCj4gwqAgYXZvaWQgdXNlIG9mIHN1ZG8gd2hlbiBjcmVhdGluZyBzcXVh
c2hmcw0KPiDCoCB1cGRhdGUgSVNBUiB0byBsYXRlc3QgdmVyc2lvbiBvbiBtYXN0ZXIgYnJhbmNo
DQo+IA0KPiDCoGNsYXNzZXMvc3F1YXNoZnMuYmJjbGFzc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDIgKy0NCj4gwqBjbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3PCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA1ICsrKy0tDQo+IMKga2FzLWNpcC55bWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqByZWNpcGVzLWNvcmUvaW1hZ2Vz
L2RlcGxveS1vdm1mLmluYyB8IDEwICsrKysrKystLS0NCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KDQo=

