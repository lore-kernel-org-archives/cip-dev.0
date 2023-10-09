Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6422EE95A96
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 11:49:49 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.72])
 by mx.groups.io with SMTP id smtpd.web11.55220.1696833260342834465
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 23:34:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O7Zc5t8r;
 spf=pass (domain: siemens.com, ip: 40.107.8.72, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA3DNhCF+MKLb5LG0rro6gQzOdPOB8LtGYWra6Gm42UYRTl9cTmnpnMUqBQNoK+s9WRCyv5BQdwTCxCuddrR2yQcHQlsFzU7/GaSYSL00KmFMqCtPg6n66Vr5kTQDUDEgnHL8DPbhPc5CT+8VfgVvoqu4aygu+zB7k64yo37+jJTRJb06ZTk0j1je2+ooo43Gd2Tjl786VxW/yTZ/zxYreWvRqOPBaPhcHKsmcVD/1dzjDNuuVWlHDlSiitFl3wagyrjQBpmQyAE4Ura4esqAnDc41GO9h5gzFCjbdWNpXj1i0HQN57IkNMjjZeLt1RFxpGTx61c1ZriQfmmfPReBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDtH6cCiW0mLTKEJ2yaO44e+Fujt9QDxb+kKxwEI6g8=;
 b=ZZ9dEPyreWbSrbH2g28K+jfJlIWy8Y+C4+rC43iOdSZhfeFm1N5JIq95ub53vAM1eoRD12tOVGvLAv19eFdA4uqyA6GhbYmYqRAJ5I0gIXrzBbprhIggoYlsxQld9+tlIHg7vkMO2m2m0N+zzGKutYTLmBGI6/PYCDxhKSlU4oPS93KievIJ3cg0/EScGtG8txMDXx7yD4rbpAm4d4Kf7YkNXPm93et1syzBaRxPKGOsDcej2VzgnBvS5Feg89UQZvBAmfGOY7aG9/1Mv9NGyyZOwRUusl/t1zIL7hmeosEgpkxM5RqeOUwOF9Azp2HkkAVpmgKZcyzdUuLEIhDB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDtH6cCiW0mLTKEJ2yaO44e+Fujt9QDxb+kKxwEI6g8=;
 b=O7Zc5t8r/FKswQ1qb+MCDhTYow5RyXm2sOnmaqX5mIwzdO9XxMnpLmJdO9HoYifYdJHqrIjk+upc9H0ExtpJ2HqccVLZv0YNLuIwGkyfgVTgMYq40wSfWRrDSXzUVpPMBeJwNHsU9GkgAF2ZFtj6y3xBzcntDnN047I3DFHXwdL06kffQMVOb7cpKEkuKKe/yWa/KgqNpai3OKl9jVj6K9YBcS78lVWdEHAW+AmEiYl6mcLQzd6kRJao1BeZXz7EhZxhUTCvad0vrnXnLLCqipqkU3zuAUTUZlyu1asDN5/CPfEt1CZ+sWkR8hnxLbLxKnoII4tPmGxEm4mGfBb+8Q==
Received: from DUZPR01CA0204.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::25) by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:164::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:34:17 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::ca) by DUZPR01CA0204.outlook.office365.com
 (2603:10a6:10:4b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 06:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:34:16 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 9 Oct 2023 08:34:15 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 14:34:13 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Mon, 9 Oct 2023 14:34:13 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with schroot imaging
Thread-Topic: [isar-cip-core][PATCH 1/4] make deploy-ovmf compatible with
 schroot imaging
Thread-Index: AQHZ+ZW+h1nJJRTqyUGK7Q4s7eDk8rA/KDyAgAAAcICAAUiWAIAACrEA
Date: Mon, 9 Oct 2023 06:34:13 +0000
Message-ID: <3a73a1391087e284e5e6a3aed0c9c731b82520e1.camel@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
	 <20231008031529.1338834-2-felix.moessbauer@siemens.com>
	 <7941a31b-121d-4f44-b815-2f494294ff9d@siemens.com>
	 <590f96d1b12c661e87f5d077c49e43707f0598c3.camel@siemens.com>
	 <1398609a-9314-4da6-8111-0854db5c40c6@siemens.com>
In-Reply-To: <1398609a-9314-4da6-8111-0854db5c40c6@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.53]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: e45211ba-8cec-4350-69f4-08dbc891c2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7m7/VK+tVVQrhqPrk1IYzjzNUzZRaxnw7WJg0JHBeq8/xon0eBTmoHjIcmyfMtmFeuc5fvVpRkI0px+W6dHX39NOy+6oBqMIpnAybGXsqN2bdwHZL9VxfO9uaG1iz3croEuuFwBPkqIWchMUH+9mD5iaIzOJWnusx2dcDTGQOYNzLPbVHcVLwN+XY73ozmuhC2PzN/fKTV9LlcrOWW/Beay7KNTYrtS1Dp3ubMIYFnh2KfzpRw1xyJLiRp2iu6BXJn695fpVrJtC1yESuXjca0KOpIoXM3r6IdrVsxplIVa7HZSkH6Rd3CmcsEmtKv9CSw0or4ywVqr6Yxwb4Utu+2LXcEoTDM1NP4MiaNV79TLXbz0HmolUHe/KUA1yOuSAAADC4IVeRL3LmrdAS+eHvH6hnCbvxP0RB1baax/+TJcdGIU4lzzsmXeIB3PlWHm7g3uT61WQAFPYPCxsti+aI/BVrapdIXP5Dk1WErvwiqJsujpMnAGi0rkQWYJ09JV597AK4mtdVZl5o2fS4bIbkCxUErqnOjKIWzNqdMEGxgNy18RKFSgypejSjkCeeVCSfJNwTrUXvL2+D2/sDptcBH/MBEevU0YDn67HMPTw95dFxEyCWUXV0e6xfzshGXXPwgCjpgJOeXV+Q3wkMJd7wWBDdj3w67IbOsyDsgiDlGyJoPiLhjbAm1wkH+OYwX5auImhFkyUucSFBiVcWS13OYDUKWa0gGETIku9zqDhqLfbrCXNawThAIQVCGl8DSYDr0vYZBSaFD7F3j2WOu/NNg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(53546011)(2616005)(107886003)(956004)(478600001)(41300700001)(336012)(47076005)(26005)(83380400001)(2906002)(5660300002)(110136005)(70586007)(70206006)(6636002)(4326008)(8676002)(8936002)(316002)(40460700003)(82960400001)(82740400003)(36860700001)(356005)(36756003)(81166007)(40480700001)(86362001)(66899024)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:34:16.8191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45211ba-8cec-4350-69f4-08dbc891c2e7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EA6911239ABBA48AF9A6E204342EE3A@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 11:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13316

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDA3OjU1ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwOC4xMC4yMyAxMjoxOSwgTU9FU1NCQVVFUiwgRmVsaXggKFQgQ0VEIElOVy1DTikgd3JvdGU6
DQo+ID4gT24gU3VuLCAyMDIzLTEwLTA4IGF0IDEyOjE4ICswMjAwLCBKYW4gS2lzemthIHdyb3Rl
Og0KPiA+ID4gT24gMDguMTAuMjMgMDU6MTUsIEZlbGl4IE1vZXNzYmF1ZXIgd3JvdGU6DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2ll
bWVucy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoHJlY2lwZXMtY29yZS9pbWFnZXMvZGVw
bG95LW92bWYuaW5jIHwgMTAgKysrKysrKy0tLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9kZXBsb3ktb3ZtZi5pbmMgYi9yZWNpcGVzLQ0KPiA+
ID4gPiBjb3JlL2ltYWdlcy9kZXBsb3ktb3ZtZi5pbmMNCj4gPiA+ID4gaW5kZXggMGVjODc2Mi4u
Y2RhYjExOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9kZXBsb3kt
b3ZtZi5pbmMNCj4gPiA+ID4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9kZXBsb3ktb3ZtZi5p
bmMNCj4gPiA+ID4gQEAgLTExLDExICsxMSwxNSBAQA0KPiA+ID4gPiDCoCMgVGhpcyByZWNpcGUg
ZGVwbG95cyB0aGUgT1ZNRiBiaW5hcmllcyB0byBydW4gdGhlIGltYWdlIGluDQo+ID4gPiA+IFFF
TVUNCj4gPiA+ID4gwqAjIE5vdGU6IHg4NiBvbmx5DQo+ID4gPiA+IA0KPiA+ID4gPiAtSU1BR0VS
X0lOU1RBTEwgKz0gIm92bWYiDQo+ID4gPiA+ICtJTlNUQUxMX2RlcGxveV9vdm1mX2JpbmFyaWVz
ICs9ICJvdm1mIg0KPiA+ID4gPiANCj4gPiA+ID4gK2RvX2RlcGxveV9vdm1mX2JpbmFyaWVzW25l
dHdvcmtdICs9ICIke1RBU0tfVVNFX1NVRE99Ig0KPiA+ID4gPiDCoGRvX2RlcGxveV9vdm1mX2Jp
bmFyaWVzW2NsZWFuZGlyc10gKz0NCj4gPiA+ID4gIiR7REVQTE9ZX0RJUl9JTUFHRX0vT1ZNRiIN
Cj4gPiA+ID4gK2RvX2RlcGxveV9vdm1mX2JpbmFyaWVzW2RlcGVuZHNdICs9ICIke1NDSFJPT1Rf
REVQfSINCj4gPiA+ID4gwqBkb19kZXBsb3lfb3ZtZl9iaW5hcmllcygpIHsNCj4gPiA+ID4gLcKg
wqDCoCBjcCAtdiAke0JVSUxEQ0hST09UX0RJUn0vdXNyL3NoYXJlL09WTUYvKi5mZA0KPiA+ID4g
PiAke0RFUExPWV9ESVJfSU1BR0V9L09WTUYNCj4gPiA+ID4gK8KgwqDCoCBpbWFnZXJfcnVuIC1w
IC1kICR7UFBfV09SS30gLS0gPDwnRU9JTUFHRVInDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBj
cCAtdiAvdXNyL3NoYXJlL09WTUYvKi5mZCAke1BQX0RFUExPWX0vT1ZNRi8NCj4gPiA+ID4gK0VP
SU1BR0VSDQo+ID4gPiANCj4gPiA+IFNpbmdsZSBjb21tYW5kLCBubyBuZWVkIGZvciB0aGUgRU9J
TUFHRVIgdHJpY2sgaGVyZS4NCj4gPiANCj4gPiBMb29rcyBsaWtlLCBidXQgaXQgdXNlcyBzaGVs
bCBnbG9iYmluZy4gQnkgdGhhdCB3ZSBlaXRoZXIgZG8gaXQNCj4gPiBsaWtlDQo+ID4gdGhpcywg
b3Igd2Ugc3Vycm91bmQgaXQgd2l0aCAvYmluL2Jhc2ggLWMgJycuDQo+ID4gDQo+IA0KPiBZZXAs
IHN0aWxsIG5pY2VyIHRvIHJlYWQgSU1ITy4NCg0KT2ssIEknbGwgY2hhbmdlIHRoaXMgYW5kIGFs
c28gc3F1YXNoIGludG8gb25lIGNvbW1pdC4NCg0KPiANCj4gPiBGZWxpeA0KPiA+IA0KPiA+ID4g
DQo+ID4gPiA+IMKgfQ0KPiA+ID4gPiArYWRkdGFzayBkZXBsb3lfb3ZtZl9iaW5hcmllcyBiZWZv
cmUgZG9faW1hZ2UNCj4gPiA+ID4gDQo+ID4gPiA+IC1hZGR0YXNrIGRlcGxveV9vdm1mX2JpbmFy
aWVzIGFmdGVyIGRvX2luc3RhbGxfaW1hZ2VyX2RlcHMNCj4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+
IGRvX2ltYWdlDQo+IA0KPiBUaGlzIGlzIGluY29ycmVjdDoNCj4gDQo+IExvZyBkYXRhIGZvbGxv
d3M6DQo+ID4gREVCVUc6IEV4ZWN1dGluZyBzaGVsbCBmdW5jdGlvbiBkb19kZXBsb3lfb3ZtZl9i
aW5hcmllcw0KPiA+IEU6IDEwbW91bnQ6IG1vdW50OiAvcnVuL3NjaHJvb3QvbW91bnQvaXNhci1i
dWlsZGVyLTBhZjRmYjAwLTk2N2YtDQo+ID4gNDIyNS1iYjQwLTI0MDgwZDIwYTQ5OS0xMTgtYTUy
NDZjYTAtNTVjYy00YTZiLTg3NjgtDQo+ID4gNWMwM2E4MmViM2Q4L2hvbWUvYnVpbGRlci9jaXAt
Y29yZS1pbWFnZS1xZW11LWFtZDY0L3Jvb3Rmczogc3BlY2lhbA0KPiA+IGRldmljZSAvYnVpbGQv
dG1wL3dvcmsvY2lwLWNvcmUtYm9va3dvcm0tYW1kNjQvY2lwLWNvcmUtaW1hZ2UtcWVtdS0NCj4g
PiBhbWQ2NC8xLjAtcjAvcm9vdGZzIGRvZXMgbm90IGV4aXN0Lg0KPiA+IEU6IDEwbW91bnQ6wqDC
oMKgwqDCoMKgwqAgZG1lc2coMSkgbWF5IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWls
ZWQNCj4gPiBtb3VudCBzeXN0ZW0gY2FsbC4NCj4gPiBXQVJOSU5HOiBleGl0IGNvZGUgMSBmcm9t
IGEgc2hlbGwgY29tbWFuZC4NCj4gRVJST1I6IFRhc2sgKC9idWlsZC8uLi9yZXBvL3JlY2lwZXMt
Y29yZS9pbWFnZXMvY2lwLWNvcmUtDQo+IGltYWdlLmJiOmRvX2RlcGxveV9vdm1mX2JpbmFyaWVz
KSBmYWlsZWQgd2l0aCBleGl0IGNvZGUgJzEnDQo+IA0KPiBNdXN0IGJlIHNvbWV0aGluZyBsaWtl
DQo+IA0KPiBhZGR0YXNrIGRlcGxveV9vdm1mX2JpbmFyaWVzIGFmdGVyIGRvX3Jvb3Rmc19pbnN0
YWxsIGJlZm9yZSBkb19idWlsZA0KPiANCj4gYmVjYXVzZSBzY2hyb290IG1vdW50aW5nIGV4cGVj
dHMgYSB0YXJnZXQgcm9vdGZzLg0KDQpPaywgZ29vZCBjYXRjaC4gSSBkaWQgbm90IHJ1biBpbnRv
IHRoaXMgaXNzdWUgd2hlbiB0ZXN0aW5nLCBidXQNCnByb2JhYmx5IG15IHJvb3RmcyB3YXMganVz
dCBzZXR1cCBhbHJlYWR5Lg0KDQpGZWxpeA0KDQo+IA0KPiBEaWQgeW91IHRlc3QgdGhpcz8NCj4g
DQo+IEphbg0KPiANCg0K

