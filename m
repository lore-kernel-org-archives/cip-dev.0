Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C7C7EE29
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:03:42 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.66])
 by mx.groups.io with SMTP id smtpd.web10.45032.1685347415241355044
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 01:03:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FgyaqAto;
 spf=pass (domain: siemens.com, ip: 40.107.104.66, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFMvFTaWQDK7KO2u29o3rMIhrTaKcSEOKdfBGbIrkA7bQbqnznNzO8uH3BkmN7DamnRq64ssOwlYGoU6ijWaWOXlUNFp6fcEv2Nkr+kPfqzXQ9cJK0whXVBXECYBzYJHX3s8+q9Eax+7fSGKGJmFRZl2GFnS2oJQSQ17tXoIYB7dVhf6bsU60WvRZswwhFHINVDlmiaE3EMpGVr9IVAyrTvUywAp0WhboqZYZEGqDWv+SlpR6ikbz4XxY6jBIiKMB6p2fjO/VOBrh2J7iefNmgIzn34bxOYwt3aJpkMPVYrRTG9f3cDQQvd1DeBXuORJs0cDxtRuZFQuiUJNRKuS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NUpvQP01QC24pl2uMCKKWzcfzvXZrXiRI6n6Jc44WQ=;
 b=Ny8UXAyfl/lLd5Mz7giD5gq4RGLEQqfAWr0SCqfL/ksLylAul2/KpPIvdTIw2IxPa2Jko7lxR1hxC8/1/xBkFLsUa2ihVEw6oWl4KYAagpf78tHhoCf7KLtTnt9IwuhqrF47XALubl1tSRKxvUNq673oHOINtHuWcFGlG0CX54LShv/bxxDsdmVuuOkmN3Ycg1V/Uv4PBunNLLUd3XaOEgsoITR3mavmER+3N1+TfIVYuWlaVUCKMWLysfbwJGDumjbokPAcacMfrcvN3CM36gi12v6CYm7wzHFPV/AFtbDpbYSqbpztTF3o9wWhRAngoIGRksPzY7du9hXme15oZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NUpvQP01QC24pl2uMCKKWzcfzvXZrXiRI6n6Jc44WQ=;
 b=FgyaqAtoXopZd3z1GABpoWG2foFL5h2qeGEGROo/CHAJkdLNSWE9QAyZwky1byHEuFZLAJX4+MVjvOL2DCSWAawGMmHwQjzbq+B1Yp3hC9FNJL5ZjdMqYtTcWNp0rTJAku7u5Am9YZ1XgRwrNz/oTtJ8/F3p1f1IVYX4B/IxLfmZgMCAlzSfRXHhZJOSEH/roSFj7s9LhAyQLIYOFEJ6uqbpAu1LhGYeyFzjZltAgIPLwladhfIjfoz9O1hJoZJbsq/0FsYac3qoS5mDsQzVfSqsRS4c4ofaxMiipxAWFICR8LoCDO4Z8awwV4PIXd7mRkehggFSey2BSMGz5/x2PQ==
Received: from FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::6) by
 DU0PR10MB6033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3c8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 08:03:32 +0000
Received: from VE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::a5) by FR0P281CA0140.outlook.office365.com
 (2603:10a6:d10:96::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.21 via Frontend
 Transport; Mon, 29 May 2023 08:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT094.mail.protection.outlook.com (10.152.3.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.20 via Frontend Transport; Mon, 29 May 2023 08:03:31 +0000
Received: from CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 29 May 2023 10:03:25 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 16:03:23 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.023; Mon, 29 May 2023 16:03:23 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Thread-Topic: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Thread-Index: AQHZje3u8Yf4/syLuk+pJerpd+u8na9rmHuAgATNl4A=
Date: Mon, 29 May 2023 08:03:23 +0000
Message-ID: <7047e533b93015d8be1b9ff6043f562a9cb8ba7c.camel@siemens.com>
References: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
	 <92b92c22a0e0daa636398ebca60945fb087b5555.camel@siemens.com>
In-Reply-To: <92b92c22a0e0daa636398ebca60945fb087b5555.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [140.231.151.229]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FE8AA2D50AF6644857B8415F9991A4B@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT094:EE_|DU0PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 579e68b3-1b55-4b64-2dcb-08db601b31c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	beeYIuSl/yrHC4HZ6EDbZAWezwDwXNIh0oko8ZPpQGys12VF9vyCIrMn8iOmqc/owWFLI2Fj9j4pSmZRjYZj9rJastQCqfKUo/wPptkuhJ2TtfyIDGfUNuhLBUcugkhf8oRQ2g/tvFPuWH4jpy07x89Z/pjA9XBn3FwQ8+xc9AiYqo10LQBweGd8nWNib+R43Ptfo5bAWbtJI/0TZYgtc4OqDJtTCELyA7urkr3BmY15INq6HAHSNmW6aOeqz7WbiMT7DSH/BVszwZ2wbLs5i3d7rZi8JGJ4Ohv1Wbhs0pskFXt6JIkipu9e0KZXok3QBAI0YLcBsLg51ZukMf//5TfRhC9IUGLbAdDzmDRIs3AtQs9N5Y+4mzAZ39s7+BN43GntEoSbfdL0df999G87CyHbYLtZhfyXzL0uNU2ItLQIz2IPW6j9N7080dA/sXYJd5PcEdYs2WmMAWkOD7Mt2EzGAVPtXFQXkbTQXHAd8y4UA669dljR3iYLKqaf4dIAMfkq+xFXxszS6NLVL0AcpnVh1RS/8z3KwzY5gZGkV0VMyLhL4g7zs6gjTUG+QxvrJDqbogsuvnKC/dH4W7PIuZjVgYkSiVZCF5BVnLEriAp6K1DtV9QogAKJx2/tGV4z38augqep5s8KfnlLSSxUa8qcOexxwtRKP+TAt2QQaUpEYHdWYksWTmK3zjLZupP3JxKttFsyZxVpreT6J9/sPQaTseadkGJlzywVAWuRC3rXT40EgKfLy8r5L4kwb1U7
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(47076005)(5660300002)(316002)(70206006)(70586007)(36756003)(107886003)(4326008)(6636002)(82310400005)(966005)(82960400001)(82740400003)(356005)(8676002)(81166007)(41300700001)(8936002)(86362001)(40480700001)(110136005)(54906003)(2906002)(956004)(2616005)(186003)(336012)(478600001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 08:03:31.7796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579e68b3-1b55-4b64-2dcb-08db601b31c7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:03:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11686

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDE0OjQyICswODAwLCBNT0VTU0JBVUVSLCBGZWxpeCAoVCBD
RUQgSU5XLUNOKQ0Kd3JvdGU6DQo+IE9uIFdlZCwgMjAyMy0wNS0yNCBhdCAwMzoxNSArMDAwMCwg
U3UsIEJhbyBDaGVuZyB3cm90ZToNCj4gPiBQcmVwYXJlIGZvciBpbml0cmFtZnMgYXBwbGljYXRp
b25zIHJlcGx5aW5nIG9uIFRQTSwgc3VjaCBhcyBjbGV2aXMNCj4gPiBvcg0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXl5eXl5eXl4NCj4gSSBndWVzcyBpdCBzaG91bGQgYmUgcmVseWluZyAtLS0tLS0tLXwN
Cg0KWWVwLCA6KQ0KDQo+IA0KPiBGZWxpeA0KPiANCj4gPiBzeXN0ZW1kLWNyeXB0c2V0dXANCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW9jaGVuZyBTdSA8YmFvY2hlbmcuc3VAc2llbWVucy5j
b20+DQo+ID4gLS0tDQo+ID4gwqAuLi4vaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9tcy1m
dHBtLmhvb2sgfCAzNg0KPiA+ICsrKysrKysrKysrKysrKysNCj4gPiDCoC4uLi9maWxlcy9tcy1m
dHBtLnNjcmlwdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQz
DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgLi4uL2luaXRyYW1mcy1tcy1mdHBtLWhv
b2tfMC4xLmJiwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzAgKysrKysrKysrKysrKw0KPiA+
IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLQ0KPiA+IGhvb2svZmls
ZXMvbXMtZnRwbS5ob29rDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFt
ZnMvaW5pdHJhbWZzLW1zLWZ0cG0tDQo+ID4gaG9vay9maWxlcy9tcy1mdHBtLnNjcmlwdA0KPiA+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBt
LQ0KPiA+IGhvb2svaW5pdHJhbWZzLW1zLWZ0cG0taG9va18wLjEuYmINCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9t
cy0NCj4gPiBmdHBtLmhvb2sgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1o
b29rL2ZpbGVzL21zLQ0KPiA+IGZ0cG0uaG9vaw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMC4uOTk4YWU2Mg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9y
ZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLWZ0cG0uaG9v
aw0KPiA+IEBAIC0wLDAgKzEsMzYgQEANCj4gPiArIyEvYmluL3NoDQo+ID4gKyMNCj4gPiArIyBD
SVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ID4gKyMNCj4gPiArIyBDb3B5cmlnaHQgKGMpIFNp
ZW1lbnMgQUcsIDIwMjMNCj4gPiArIw0KPiA+ICsjIEF1dGhvcnM6DQo+ID4gKyPCoCBTdSBCYW8g
Q2hlbmcgPGJhb2NoZW5nLnN1QHNpZW1lbnMuY29tPg0KPiA+ICsjDQo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IE1JVA0KPiA+ICsjDQo+ID4gK1BSRVJFUT0iIg0KPiA+ICtwcmVyZXFz
KCkNCj4gPiArew0KPiA+ICvCoMKgwqAgZWNobyAiJFBSRVJFUSINCj4gPiArfQ0KPiA+ICtjYXNl
ICQxIGluDQo+ID4gK3ByZXJlcXMpDQo+ID4gK8KgwqDCoCBwcmVyZXFzDQo+ID4gK8KgwqDCoCBl
eGl0IDANCj4gPiArwqDCoMKgIDs7DQo+ID4gK2VzYWMNCj4gPiArDQo+ID4gKy4gL3Vzci9zaGFy
ZS9pbml0cmFtZnMtdG9vbHMvaG9vay1mdW5jdGlvbnMNCj4gPiArDQo+ID4gK2hvb2tfZXJyb3Io
KSB7DQo+ID4gK8KgwqDCoCBlY2hvICIoRVJST1IpOiAkMiIgPiYyDQo+ID4gK8KgwqDCoCBleGl0
IDENCj4gPiArfQ0KPiA+ICsNCj4gPiArIyBKdXN0IGluIGNhc2UgdGhlc2UgbW9kdWxlcyBhcmUg
bm90IGJ1aWx0LWluDQo+ID4gK21hbnVhbF9hZGRfbW9kdWxlcyB0ZWUNCj4gPiArbWFudWFsX2Fk
ZF9tb2R1bGVzIG9wdGVlDQo+ID4gK21hbnVhbF9hZGRfbW9kdWxlcyB0cG1fZnRwbV90ZWUNCj4g
DQo+IEFyZSB0aGVzZSBtb2R1bGVzIGF2YWlsYWJsZSBpbiBhIHN0b2NrIERlYmlhbiBrZXJuZWwg
YXMgd2VsbD8NCg0KQXJlIHlvdSByZWZlcnJpbmcgdG8gdGhlIG9mZmljaWFsIGFybTY0IGtlcm5l
bCBvZiBEZWJpYW4/IEhhdmVuJ3QNCmNoZWNrZWQgaXQgeWV0LiBGb3IgYW1kNjQsIGhvd2V2ZXIs
IEkgZG9uJ3QgZXhwZWN0IHRoZSBvcHRlZSAmDQp0cG1fZnRwbV90ZWUgaW4gdGhlIHN0b2NrIGRl
YmlhbiBrZXJuZWwuDQoNCkFNRCBhbHNvIHByb3ZpZGVzIGEgVEVFLCBzbyB0cG1fZnRwbV90ZWUg
bWF5IGJlIHBvc3NpYmxlIG9uIGFtZDY0Lg0KDQo+IA0KPiA+ICsNCj4gPiArY29weV9leGVjIC91
c3Ivc2Jpbi90ZWUtc3VwcGxpY2FudCB8fCBob29rX2Vycm9yICIvdXNyL3NiaW4vdGVlLQ0KPiA+
IHN1cHBsaWNhbnQgbm90IGZvdW5kIg0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1m
cy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiA+IGZ0cG0uc2NyaXB0IGIvcmVj
aXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9tcy0NCj4gPiBmdHBt
LnNjcmlwdA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uYzZl
ZTJkZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLWZ0cG0uc2NyaXB0DQo+ID4gQEAgLTAsMCArMSw0
MyBAQA0KPiA+ICsjIS9iaW4vc2gNCj4gPiArIw0KPiA+ICsjIENJUCBDb3JlLCBnZW5lcmljIHBy
b2ZpbGUNCj4gPiArIw0KPiA+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMw0KPiA+
ICsjDQo+ID4gKyMgQXV0aG9yczoNCj4gPiArI8KgIFN1IEJhbyBDaGVuZyA8YmFvY2hlbmcuc3VA
c2llbWVucy5jb20+DQo+ID4gKyMNCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlU
DQo+ID4gKyMNCj4gPiArUFJFUkVRPSIiDQo+ID4gKw0KPiA+ICtwcmVyZXFzKCkNCj4gPiArew0K
PiA+ICvCoMKgwqDCoMKgwqDCoGVjaG8gIiRQUkVSRVEiDQo+ID4gK30NCj4gPiArDQo+ID4gK2Nh
c2UgJDEgaW4NCj4gPiArIyBnZXQgcHJlLXJlcXVpc2l0ZXMNCj4gPiArcHJlcmVxcykNCj4gPiAr
wqDCoMKgwqDCoMKgwqBwcmVyZXFzDQo+ID4gK8KgwqDCoMKgwqDCoMKgZXhpdCAwDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgOzsNCj4gPiArZXNhYw0KPiA+ICsNCj4gPiArRlRQTV9ERVY9L2Rldi90cG1y
bTANCj4gPiArDQo+ID4gKy4gL3NjcmlwdHMvZnVuY3Rpb25zDQo+ID4gKw0KPiA+ICsvdXNyL3Ni
aW4vdGVlLXN1cHBsaWNhbnQgLWQNCj4gPiArDQo+ID4gKyMgVGhlIGZUUE0gVEEgd291bGQgdGFr
ZSBzb21lIHRpbWUgdG8gYmUgZGlzY292ZXJlZCBhcyB3ZWxsIGFzIHRoZQ0KPiA+IHRlZS1zdXBw
bGljYW50DQo+ID4gKyMgMTAgc2Vjb25kcyBzaG91bGQgYmUgZW5vdWdoDQo+ID4gK3dhaXRfc2Vj
PTEwDQo+ID4gK3VudGlsIHRlc3QgJHdhaXRfc2VjIC1lcSAwIHx8IHRlc3QgLWMgIiR7RlRQTV9E
RVZ9IiA7IGRvDQo+ID4gK8KgwqDCoMKgwqDCoMKgd2FpdF9zZWM9JCgod2FpdF9zZWMtMSkpDQo+
ID4gK8KgwqDCoMKgwqDCoMKgc2xlZXAgMQ0KPiA+ICtkb25lDQo+ID4gKw0KPiA+ICtpZiAhIHRl
c3QgLWMgIiR7RlRQTV9ERVZ9IjsgdGhlbg0KPiA+ICvCoMKgwqAgcGFuaWMgIkNhbid0IGRpc2Nv
dmVyIHRoZSBmVFBNIGRldmljZSAke0ZUUE1fREVWfSEiDQo+ID4gK2ZpDQo+ID4gZGlmZiAtLWdp
dCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2svaW5pdHJhbWZzLW1z
LQ0KPiA+IGZ0cG0taG9va18wLjEuYmIgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMt
ZnRwbS0NCj4gPiBob29rL2luaXRyYW1mcy1tcy1mdHBtLWhvb2tfMC4xLmJiDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5mZWNlNmZmDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2sv
aW5pdHJhbWZzLW1zLWZ0cG0tDQo+ID4gaG9va18wLjENCj4gDQo+IFdoZXJlIGlzIHRoaXMgcGFj
a2FnZSBhY3R1YWxseSB1c2VkPyBJIGNhbid0IHNlZSB0aGF0IGl0IGlzIGFkZGVkIHRvDQo+IHRo
ZSBpbml0cmFtZnMgcmVjaXBlLg0KPiANCg0KSXQgd291bGQgYmUgdXNlZCBpbiB0aGUgZG93bnN0
cmVhbSBtZXRhLWlvdDIwNTAsIHNlZQ0KaHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvbWV0YS1p
b3QyMDUwL3B1bGwvNDQyLg0KDQotIEJhb2NoZW5nDQoNCj4gRmVsaXgNCj4gDQo+ID4gLmJiDQo+
ID4gQEAgLTAsMCArMSwzMCBAQA0KPiA+ICsjDQo+ID4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJv
ZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDIzDQo+ID4g
KyMNCj4gPiArIyBBdXRob3JzOg0KPiA+ICsjwqAgU3UgQmFvIENoZW5nIDxiYW9jaGVuZy5zdUBz
aWVtZW5zLmNvbT4NCj4gPiArIw0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQN
Cj4gPiArIw0KPiA+ICsNCj4gPiAraW5oZXJpdCBkcGtnLXJhdw0KPiA+ICsNCj4gPiArU1JDX1VS
SSArPSAiIFwNCj4gPiArwqDCoMKgIGZpbGU6Ly9tcy1mdHBtLmhvb2vCoFwNCj4gPiArwqDCoMKg
IGZpbGU6Ly9tcy1mdHBtLnNjcmlwdMKgXA0KPiA+ICvCoMKgwqAgIg0KPiA+ICsNCj4gPiArREVC
SUFOX0RFUEVORFMgPSAiaW5pdHJhbWZzLXRvb2xzLCB0ZWUtc3VwcGxpY2FudCINCj4gPiArDQo+
ID4gK2RvX2luc3RhbGxbY2xlYW5kaXJzXSArPSAiIFwNCj4gPiArwqDCoMKgICR7RH0vdXNyL3No
YXJlL2luaXRyYW1mcy10b29scy9ob29rcyBcDQo+ID4gK8KgwqDCoCAke0R9L3Vzci9zaGFyZS9p
bml0cmFtZnMtdG9vbHMvc2NyaXB0cy9sb2NhbC1ib3R0b20iDQo+ID4gKw0KPiA+ICtkb19pbnN0
YWxsKCkgew0KPiA+ICvCoMKgwqAgaW5zdGFsbCAtbSAwNzU1ICIke1dPUktESVJ9L21zLWZ0cG0u
aG9vayIgXA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAiJHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRv
b2xzL2hvb2tzL21zLWZ0cG0iDQo+ID4gK8KgwqDCoCBpbnN0YWxsIC1tIDA3NTUgIiR7V09SS0RJ
Un0vbXMtZnRwbS5zY3JpcHQiIFwNCj4gPiArwqDCoMKgwqDCoMKgwqAgIiR7RH0vdXNyL3NoYXJl
L2luaXRyYW1mcy10b29scy9zY3JpcHRzL2xvY2FsLWJvdHRvbS9tcy0NCj4gPiBmdHBtIg0KPiA+
ICt9DQo+ID4gDQo+IA0KDQo=

