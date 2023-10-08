Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057AE95A67
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:40 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.71])
 by mx.groups.io with SMTP id smtpd.web10.35531.1696760401151289673
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 03:20:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VFZyUQwK;
 spf=pass (domain: siemens.com, ip: 40.107.249.71, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bppjtZWOGB3i0y95hPdJZVUHFZlp32nRfcWhFypc/vzG1Slhtm+IndBpB4I04fpYNoIKc/VYh4EiRZ/g0BLoE2R3PtnRQJuZN9UWVdSMb9MCmA/wz/qD6jrVbZqAu4eTzDQEv8CfYggU0+GcdmPyyyeKYZzER9o9UJNVicR622PUi1c8vz43axi7YbrWRtkKphvxs2p6mGbGwfVvhQ30K9hAnqd+R5QGaADm6t6DK09AFJ8aRc1i4J3FwEHfSxz6ZL+P6NAGXuw3XjVUDA9zLI5JsH8jaSURkD1hrISFtUkufZs5X4ZP6jc/Zqs8UYHqdjX1YFzFbX4ez6qmbpOndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmQkPdAlmbiv9xsHxUGyJGIG7mNBHy+MmmDlLmHfLMI=;
 b=Os4DukGkxXt6et/4KkZp6z7bHHbkLXdGLcRT8GMU8lE4JjS5XnsQ9dQI3X8WRrDzVW2D0XExe+z9wLbQxmn0Ezqr8GJAihvWeEaQgy4tc3RstXmviwRMIE8s3OzgalH1nMFJ7UGGkA19QqKrnA9Wg28Qmv7n+Pg5czbToZ+BczsVYeoOLCXYgpTVcK2no7etioWQ8a3dvFU4Lnd+8U2tN/Nyqb1y9nJARemVXb0c1snzTiV6Vot2uge634srIfbNfkDnjRNFj39BWztvL+lbk0ZuhLMOjsM085/547Tguira6yW/vJjXP2mrgeaO6UW3cllvcEb+liVl+BRG/9nBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmQkPdAlmbiv9xsHxUGyJGIG7mNBHy+MmmDlLmHfLMI=;
 b=VFZyUQwKuXWZjZJYIlsNgEHbA/uw1OnjIql1wHYxT3piFcFI8sZgmdp2fN7H11sB0qAgQEsFrb4LEhKOEMuTOZ/ZIXZzjxkM+5CrM41u1uNGMOpbgLExZZ15jIk2fCJm5XQf3BP5w16JdlSbb5rXRIZf2k9wwRqGXOrJdLMdev1EYpY1MiX155YCuma6LiiJHegAKThI7BjhZBEu76MGBjB2UpbFIQE75LTvzju072rlYefwWmdmG1MR7uGU7hNS5b23bfEgoPc3cAMHwj5joe7In8nZs74BujqddfG2lkBl5kMyNCaYYw7UmGR6OKZGWZ0Unzga2izZSQjR8PKsxg==
Received: from AM0PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:208:122::42)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 10:19:58 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:208:122:cafe::7b) by AM0PR04CA0029.outlook.office365.com
 (2603:10a6:208:122::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Sun, 8 Oct 2023 10:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sun, 8 Oct 2023 10:19:57 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Sun, 8 Oct 2023 12:19:56 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 18:19:54 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Sun, 8 Oct 2023 18:19:54 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with schroot imaging
Thread-Topic: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with
 schroot imaging
Thread-Index: AQHZ+ZW+h1nJJRTqyUGK7Q4s7eDk8rA/KDyAgAAAcIA=
Date: Sun, 8 Oct 2023 10:19:54 +0000
Message-ID: <590f96d1b12c661e87f5d077c49e43707f0598c3.camel@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
	 <20231008031529.1338834-2-felix.moessbauer@siemens.com>
	 <7941a31b-121d-4f44-b815-2f494294ff9d@siemens.com>
In-Reply-To: <7941a31b-121d-4f44-b815-2f494294ff9d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.53]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|DU0PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a4dff1-4924-4a00-8aa7-08dbc7e81f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+HMO+eU8BIIE18/KtOLQCQ7VXAFqyUwf3Y9I6GIE69I1MToxjpiTh+UgSqw92MB3zxL4YoJ1LO9lcPNPVRZ9zJ6M19fHk6BtSzip1kIELa+SmQ1OOG1n5iTCVLz6QfZ4Et+Pa44zNssnuXiIV1WobPnY6NW+cHdLaakYlXGbAmhO8E6os/eDWYArYzEbXZTdpTkMphgfUcX1TKctFBl0GZsXOUBBeNsY3sRK88vCZRUQ16MKfKxB6a/d2CH2uwXeuFdHnMTEd2uIgGJpdlBDrEuXLyocqpUWtPlOpXuUlZz06OQd8fW5zdy5LAvclHBqmgFlWHG/095nZu022fg8rZ2TmMsClOZ7bUxSWxoRuRxNmemKXVEy25QKVQwvJyRYWNWzjnE//UHqdfGM8aTg/sdWTwshYOQ5nbJJIaOlfgTTk7jwGDAeh9e1TpATPU9GVr+3gNtrzCWr6+/f77WGzIU7Zjqgr8PIMT4aN9QiZGrFHJ3tWLcV26TcsV7vqq29owvvbkG5EeiP19vxqj55p7LrJo3TiU7prVbAmaTUhBLQQ7Y6+D3hmQnk9JnODVHVsidb1k2gy7LlzJnwjcI2UPX1xhkHY753wVdr98MTL2EnuxoTDu43mqAcnriq0a/7DAr3ruZPiHkmlPEG+9b6PGnajBYiswameMIm2zyD1SKQGLxezrmyRpPPVQ2pU8SbheKc9Svw79bYM5638BeIn+zY6TcH9Udco8TnlfJ60YQaHtXHN/oYan3R82tFsXf6NsyOHOyxqyyG+LMbGKpe3w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(86362001)(356005)(82960400001)(36756003)(40480700001)(2906002)(478600001)(82740400003)(5660300002)(41300700001)(8936002)(4326008)(8676002)(83380400001)(336012)(956004)(2616005)(107886003)(40460700003)(53546011)(6636002)(36860700001)(70586007)(110136005)(70206006)(316002)(26005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:19:57.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a4dff1-4924-4a00-8aa7-08dbc7e81f61
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09256309094C7469008D5941AB1C3E3@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13312

T24gU3VuLCAyMDIzLTEwLTA4IGF0IDEyOjE4ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwOC4xMC4yMyAwNToxNSwgRmVsaXggTW9lc3NiYXVlciB3cm90ZToNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgcmVjaXBlcy1jb3JlL2ltYWdlcy9kZXBsb3ktb3ZtZi5pbmMgfCAxMCArKysr
KysrLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2RlcGxveS1v
dm1mLmluYyBiL3JlY2lwZXMtDQo+ID4gY29yZS9pbWFnZXMvZGVwbG95LW92bWYuaW5jDQo+ID4g
aW5kZXggMGVjODc2Mi4uY2RhYjExOCAxMDA2NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1h
Z2VzL2RlcGxveS1vdm1mLmluYw0KPiA+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvZGVwbG95
LW92bWYuaW5jDQo+ID4gQEAgLTExLDExICsxMSwxNSBAQA0KPiA+IMKgIyBUaGlzIHJlY2lwZSBk
ZXBsb3lzIHRoZSBPVk1GIGJpbmFyaWVzIHRvIHJ1biB0aGUgaW1hZ2UgaW4gUUVNVQ0KPiA+IMKg
IyBOb3RlOiB4ODYgb25seQ0KPiA+IMKgDQo+ID4gLUlNQUdFUl9JTlNUQUxMICs9ICJvdm1mIg0K
PiA+ICtJTlNUQUxMX2RlcGxveV9vdm1mX2JpbmFyaWVzICs9ICJvdm1mIg0KPiA+IMKgDQo+ID4g
K2RvX2RlcGxveV9vdm1mX2JpbmFyaWVzW25ldHdvcmtdICs9ICIke1RBU0tfVVNFX1NVRE99Ig0K
PiA+IMKgZG9fZGVwbG95X292bWZfYmluYXJpZXNbY2xlYW5kaXJzXSArPSAiJHtERVBMT1lfRElS
X0lNQUdFfS9PVk1GIg0KPiA+ICtkb19kZXBsb3lfb3ZtZl9iaW5hcmllc1tkZXBlbmRzXSArPSAi
JHtTQ0hST09UX0RFUH0iDQo+ID4gwqBkb19kZXBsb3lfb3ZtZl9iaW5hcmllcygpIHsNCj4gPiAt
wqDCoMKgIGNwIC12ICR7QlVJTERDSFJPT1RfRElSfS91c3Ivc2hhcmUvT1ZNRi8qLmZkDQo+ID4g
JHtERVBMT1lfRElSX0lNQUdFfS9PVk1GDQo+ID4gK8KgwqDCoCBpbWFnZXJfcnVuIC1wIC1kICR7
UFBfV09SS30gLS0gPDwnRU9JTUFHRVInDQo+ID4gK8KgwqDCoMKgwqDCoMKgIGNwIC12IC91c3Iv
c2hhcmUvT1ZNRi8qLmZkICR7UFBfREVQTE9ZfS9PVk1GLw0KPiA+ICtFT0lNQUdFUg0KPiANCj4g
U2luZ2xlIGNvbW1hbmQsIG5vIG5lZWQgZm9yIHRoZSBFT0lNQUdFUiB0cmljayBoZXJlLg0KDQpM
b29rcyBsaWtlLCBidXQgaXQgdXNlcyBzaGVsbCBnbG9iYmluZy4gQnkgdGhhdCB3ZSBlaXRoZXIg
ZG8gaXQgbGlrZQ0KdGhpcywgb3Igd2Ugc3Vycm91bmQgaXQgd2l0aCAvYmluL2Jhc2ggLWMgJycu
DQoNCkZlbGl4DQoNCj4gDQo+ID4gwqB9DQo+ID4gK2FkZHRhc2sgZGVwbG95X292bWZfYmluYXJp
ZXMgYmVmb3JlIGRvX2ltYWdlDQo+ID4gwqANCj4gPiAtYWRkdGFzayBkZXBsb3lfb3ZtZl9iaW5h
cmllcyBhZnRlciBkb19pbnN0YWxsX2ltYWdlcl9kZXBzIGJlZm9yZQ0KPiA+IGRvX2ltYWdlDQo+
IA0KPiBKYW4NCj4gDQoNCg==

