Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96EC77B7A
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 16:33:38 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web11.2640.1685083351093726116
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 May 2023 23:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vF8RI1Bq;
 spf=pass (domain: siemens.com, ip: 40.107.8.42, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejn6AnJhjBFRPi2u+RFJnKbESmV1zzxhQwg3jL2KsZx7GeFwAZsVLohPD3m1sTNIT98CCaK3KhJdVQTo49KMDAH8fgvDgG5AVe56fPKJjvZsi85Oze65H8gm0mB/e5lwmdtNSby+04KMoZa41M7ihjK1XMv3L0NJVywrVuqivTXtk2SNykakUuHGISHatEMz/62VntJyrlXn937BM1XGtfV49wjIrpGcdNMCHSMHtoL581hs3vfQKtzfrnWn2EPmIh27/hw7tp9m9gqymwm2F3qPyR4v57g4zLqudfC8FDHOYyo6+LCbw1ldVtYNCxMileJIPwl4WSegDHhFS0rz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUHkCRZD07QAUQwWCbPz0RtM3f1Cdu/vkpYQZBIWVdc=;
 b=WK2mOCCSgvTURU5fYq06y67ZiAgm0CL2WfUSZkGfFnaZVyOl7AbfdpzEVNxktaPnKkbjcIjGhPXBc/z/wYvOFggT/jC1SW1FnnTPfbGLcHc+KFnxPebCNNzcJ2tWhlGqrImZvTvezxd5lsgkLngxGyw9HNYOksMcncuRBBbS5uA+PNGaKfTREyFqMHO6fnulAwGOtGDt18377zEwqPJW037NCPY0/nIjpGSJtENkDrRz+p/YcGV4p62hf0fk4A2blIB95Gb2ZTz4n54Hgeb7Nmo4kzXAg/xhwdUsNehjtrnMw2HdawSs72k7ApwIpMU+K+YSmq11idq6u1SP0k0UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUHkCRZD07QAUQwWCbPz0RtM3f1Cdu/vkpYQZBIWVdc=;
 b=vF8RI1BqI7G4vugFM3F4J108hNFdaEFEajh/Tfg7mmEMq6/sIOwO5WtQDhue3BfiNgXBiAGfmmmPIOP10p2iVFC4zHARN6a9x+C+DQ23+GvOYEiC6/dSpM7x7k1UWCEg3quRSm+36YKilSxeyiOzjRX9UJTguKV3RbVMLHmT5smv55sTq65oreaLflD7mMTk9uNnxdZtklq5/adGuZs+xS+oHxhCRdqlliXnAK9KgV9EnNCuYhef2c3NjUwn0guldnzZOtKmtmagQUjcmJwI95NdENdDfG1De/x4bnfQMwVtqk4d3ykcxaDwn3++DamI6TzXx9Y6pwvgtWa+aiQELg==
Received: from DU2PR04CA0240.eurprd04.prod.outlook.com (2603:10a6:10:2b1::35)
 by AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 06:42:27 +0000
Received: from DB5EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::cf) by DU2PR04CA0240.outlook.office365.com
 (2603:10a6:10:2b1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Fri, 26 May 2023 06:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT072.mail.protection.outlook.com (10.152.5.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 06:42:27 +0000
Received: from CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Fri, 26 May 2023 08:42:25 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 14:42:23 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Fri, 26 May 2023 14:42:23 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Su, Bao
 Cheng" <baocheng.su@siemens.com>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based ftpm hook
Thread-Topic: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Thread-Index: AQHZj506G/ph5dw1tUWcf/tXablGBA==
Date: Fri, 26 May 2023 06:42:23 +0000
Message-ID: <92b92c22a0e0daa636398ebca60945fb087b5555.camel@siemens.com>
References: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
In-Reply-To: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.52]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT072:EE_|AS2PR10MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab30410-76db-48f5-7e2e-08db5db45f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CGopWbvf/qoB537QamgneW4VJKytlV/i6xBinYHH2NQlNU/3BIi+wAX8244MBdFLTSwYDqpG6iAF9viFxQJI1F/1oHq8KN3PDH3dg8dJCqs4wEF/L2o8TeNrgnMzSX3HE/1Wtx6yoBoAv0+iO3/w+nvypAzeASgEbPhQD1p54iUkrtk0fXecalSkDeU4K4Rxy56rPZ6VDOKbb8oAxCbHUbReXn37G3KfaZfqFAuly+UF4qCCtT1KSX4dWporZDHPyeiBxgUCA1oZa35cs93JfY7OsxFvObt1P4s3B4wgQ/mQ+In6rct/PjE2fxzgeD1oaUOZEFf2c7xABDoB1R9Y512aT1H58lztsZr7ZgX0ExL/PdLJNAw8laEZzSQswHVbm4fKPt3AmZ76OEAWGn9EnebO/bZsWwjnbHBWyhcwkEs62UXQ+1WaFW+J9uX1mYC/9ZtarOsOBatDU0kfFny47zykkJp+MEJVHgfMn/kJ/CTl0aI+/03KLFjEHzGweNj7meK4UIcGZwhdUAIAPTa9xhaQqpSUk43bjQXyUbYkWM1+qR9pYPIKPlfz238ZDAje0LvzRxTq234TbpEZ4Qxn5gxrn287Ol0V9Ep6PSigudB1EMF5iSlyRd/1eYrajOHXEgVX37CHZ217jJEG8g7fEFRLnPIV1OKTbQw+LFJ9V3qmjxUHf4/IExL/yI18y2Fu31Ul/nb4k71D7qjBWPmHByuDLZ3rNqrTWF69py5u0zsBAdTTzUv0ug8m2dqvWCGfWsHDmTSc592bF0X8vuHoEw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(4326008)(110136005)(54906003)(82740400003)(82960400001)(40480700001)(6636002)(316002)(478600001)(70206006)(40460700003)(41300700001)(86362001)(356005)(81166007)(186003)(8936002)(8676002)(26005)(107886003)(2906002)(336012)(47076005)(82310400005)(5660300002)(36756003)(36860700001)(956004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 06:42:27.3344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab30410-76db-48f5-7e2e-08db5db45f1a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7429
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <54FDED16ED43474D8F97DD9B454B7697@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 16:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11658

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDAzOjE1ICswMDAwLCBTdSwgQmFvIENoZW5nIHdyb3RlOg0K
PiBQcmVwYXJlIGZvciBpbml0cmFtZnMgYXBwbGljYXRpb25zIHJlcGx5aW5nIG9uIFRQTSwgc3Vj
aCBhcyBjbGV2aXMgb3INCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5e
Xl5eXg0KSSBndWVzcyBpdCBzaG91bGQgYmUgcmVseWluZyAtLS0tLS0tLXwNCg0KRmVsaXgNCg0K
PiBzeXN0ZW1kLWNyeXB0c2V0dXANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJhb2NoZW5nIFN1IDxi
YW9jaGVuZy5zdUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgLi4uL2luaXRyYW1mcy1tcy1mdHBt
LWhvb2svZmlsZXMvbXMtZnRwbS5ob29rIHwgMzYgKysrKysrKysrKysrKysrKw0KPiDCoC4uLi9m
aWxlcy9tcy1mdHBtLnNjcmlwdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDQzDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gwqAuLi4vaW5pdHJhbWZzLW1zLWZ0
cG0taG9va18wLjEuYmLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzMCArKysrKysrKysrKysr
DQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCByZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS0NCj4gaG9vay9maWxl
cy9tcy1mdHBtLmhvb2sNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMv
aW5pdHJhbWZzLW1zLWZ0cG0tDQo+IGhvb2svZmlsZXMvbXMtZnRwbS5zY3JpcHQNCj4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0tDQo+IGhv
b2svaW5pdHJhbWZzLW1zLWZ0cG0taG9va18wLjEuYmINCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiBmdHBtLmhv
b2sgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0K
PiBmdHBtLmhvb2sNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uOTk4
YWU2Mg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1m
cy1tcy1mdHBtLWhvb2svZmlsZXMvbXMtZnRwbS5ob29rDQo+IEBAIC0wLDAgKzEsMzYgQEANCj4g
KyMhL2Jpbi9zaA0KPiArIw0KPiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBwcm9maWxlDQo+ICsjDQo+
ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAyMw0KPiArIw0KPiArIyBBdXRob3JzOg0K
PiArI8KgIFN1IEJhbyBDaGVuZyA8YmFvY2hlbmcuc3VAc2llbWVucy5jb20+DQo+ICsjDQo+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gKyMNCj4gK1BSRVJFUT0iIg0KPiArcHJl
cmVxcygpDQo+ICt7DQo+ICvCoMKgwqAgZWNobyAiJFBSRVJFUSINCj4gK30NCj4gK2Nhc2UgJDEg
aW4NCj4gK3ByZXJlcXMpDQo+ICvCoMKgwqAgcHJlcmVxcw0KPiArwqDCoMKgIGV4aXQgMA0KPiAr
wqDCoMKgIDs7DQo+ICtlc2FjDQo+ICsNCj4gKy4gL3Vzci9zaGFyZS9pbml0cmFtZnMtdG9vbHMv
aG9vay1mdW5jdGlvbnMNCj4gKw0KPiAraG9va19lcnJvcigpIHsNCj4gK8KgwqDCoCBlY2hvICIo
RVJST1IpOiAkMiIgPiYyDQo+ICvCoMKgwqAgZXhpdCAxDQo+ICt9DQo+ICsNCj4gKyMgSnVzdCBp
biBjYXNlIHRoZXNlIG1vZHVsZXMgYXJlIG5vdCBidWlsdC1pbg0KPiArbWFudWFsX2FkZF9tb2R1
bGVzIHRlZQ0KPiArbWFudWFsX2FkZF9tb2R1bGVzIG9wdGVlDQo+ICttYW51YWxfYWRkX21vZHVs
ZXMgdHBtX2Z0cG1fdGVlDQoNCkFyZSB0aGVzZSBtb2R1bGVzIGF2YWlsYWJsZSBpbiBhIHN0b2Nr
IERlYmlhbiBrZXJuZWwgYXMgd2VsbD8NCg0KPiArDQo+ICtjb3B5X2V4ZWMgL3Vzci9zYmluL3Rl
ZS1zdXBwbGljYW50IHx8IGhvb2tfZXJyb3IgIi91c3Ivc2Jpbi90ZWUtDQo+IHN1cHBsaWNhbnQg
bm90IGZvdW5kIg0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1z
LWZ0cG0taG9vay9maWxlcy9tcy0NCj4gZnRwbS5zY3JpcHQgYi9yZWNpcGVzLWluaXRyYW1mcy9p
bml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLQ0KPiBmdHBtLnNjcmlwdA0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi5jNmVlMmRkDQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9t
cy1mdHBtLnNjcmlwdA0KPiBAQCAtMCwwICsxLDQzIEBADQo+ICsjIS9iaW4vc2gNCj4gKyMNCj4g
KyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiArIw0KPiArIyBDb3B5cmlnaHQgKGMpIFNp
ZW1lbnMgQUcsIDIwMjMNCj4gKyMNCj4gKyMgQXV0aG9yczoNCj4gKyPCoCBTdSBCYW8gQ2hlbmcg
PGJhb2NoZW5nLnN1QHNpZW1lbnMuY29tPg0KPiArIw0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogTUlUDQo+ICsjDQo+ICtQUkVSRVE9IiINCj4gKw0KPiArcHJlcmVxcygpDQo+ICt7DQo+
ICvCoMKgwqDCoMKgwqDCoGVjaG8gIiRQUkVSRVEiDQo+ICt9DQo+ICsNCj4gK2Nhc2UgJDEgaW4N
Cj4gKyMgZ2V0IHByZS1yZXF1aXNpdGVzDQo+ICtwcmVyZXFzKQ0KPiArwqDCoMKgwqDCoMKgwqBw
cmVyZXFzDQo+ICvCoMKgwqDCoMKgwqDCoGV4aXQgMA0KPiArwqDCoMKgwqDCoMKgwqA7Ow0KPiAr
ZXNhYw0KPiArDQo+ICtGVFBNX0RFVj0vZGV2L3RwbXJtMA0KPiArDQo+ICsuIC9zY3JpcHRzL2Z1
bmN0aW9ucw0KPiArDQo+ICsvdXNyL3NiaW4vdGVlLXN1cHBsaWNhbnQgLWQNCj4gKw0KPiArIyBU
aGUgZlRQTSBUQSB3b3VsZCB0YWtlIHNvbWUgdGltZSB0byBiZSBkaXNjb3ZlcmVkIGFzIHdlbGwg
YXMgdGhlDQo+IHRlZS1zdXBwbGljYW50DQo+ICsjIDEwIHNlY29uZHMgc2hvdWxkIGJlIGVub3Vn
aA0KPiArd2FpdF9zZWM9MTANCj4gK3VudGlsIHRlc3QgJHdhaXRfc2VjIC1lcSAwIHx8IHRlc3Qg
LWMgIiR7RlRQTV9ERVZ9IiA7IGRvDQo+ICvCoMKgwqDCoMKgwqDCoHdhaXRfc2VjPSQoKHdhaXRf
c2VjLTEpKQ0KPiArwqDCoMKgwqDCoMKgwqBzbGVlcCAxDQo+ICtkb25lDQo+ICsNCj4gK2lmICEg
dGVzdCAtYyAiJHtGVFBNX0RFVn0iOyB0aGVuDQo+ICvCoMKgwqAgcGFuaWMgIkNhbid0IGRpc2Nv
dmVyIHRoZSBmVFBNIGRldmljZSAke0ZUUE1fREVWfSEiDQo+ICtmaQ0KPiBkaWZmIC0tZ2l0IGEv
cmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9pbml0cmFtZnMtbXMtDQo+
IGZ0cG0taG9va18wLjEuYmIgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS0N
Cj4gaG9vay9pbml0cmFtZnMtbXMtZnRwbS1ob29rXzAuMS5iYg0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwLi5mZWNlNmZmDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
cmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9pbml0cmFtZnMtbXMtZnRw
bS0NCj4gaG9va18wLjENCg0KV2hlcmUgaXMgdGhpcyBwYWNrYWdlIGFjdHVhbGx5IHVzZWQ/IEkg
Y2FuJ3Qgc2VlIHRoYXQgaXQgaXMgYWRkZWQgdG8NCnRoZSBpbml0cmFtZnMgcmVjaXBlLg0KDQpG
ZWxpeA0KDQo+IC5iYg0KPiBAQCAtMCwwICsxLDMwIEBADQo+ICsjDQo+ICsjIENJUCBDb3JlLCBn
ZW5lcmljIHByb2ZpbGUNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDIz
DQo+ICsjDQo+ICsjIEF1dGhvcnM6DQo+ICsjwqAgU3UgQmFvIENoZW5nIDxiYW9jaGVuZy5zdUBz
aWVtZW5zLmNvbT4NCj4gKyMNCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KPiAr
Iw0KPiArDQo+ICtpbmhlcml0IGRwa2ctcmF3DQo+ICsNCj4gK1NSQ19VUkkgKz0gIiBcDQo+ICvC
oMKgwqAgZmlsZTovL21zLWZ0cG0uaG9va8KgXA0KPiArwqDCoMKgIGZpbGU6Ly9tcy1mdHBtLnNj
cmlwdMKgXA0KPiArwqDCoMKgICINCj4gKw0KPiArREVCSUFOX0RFUEVORFMgPSAiaW5pdHJhbWZz
LXRvb2xzLCB0ZWUtc3VwcGxpY2FudCINCj4gKw0KPiArZG9faW5zdGFsbFtjbGVhbmRpcnNdICs9
ICIgXA0KPiArwqDCoMKgICR7RH0vdXNyL3NoYXJlL2luaXRyYW1mcy10b29scy9ob29rcyBcDQo+
ICvCoMKgwqAgJHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL3NjcmlwdHMvbG9jYWwtYm90
dG9tIg0KPiArDQo+ICtkb19pbnN0YWxsKCkgew0KPiArwqDCoMKgIGluc3RhbGwgLW0gMDc1NSAi
JHtXT1JLRElSfS9tcy1mdHBtLmhvb2siIFwNCj4gK8KgwqDCoMKgwqDCoMKgICIke0R9L3Vzci9z
aGFyZS9pbml0cmFtZnMtdG9vbHMvaG9va3MvbXMtZnRwbSINCj4gK8KgwqDCoCBpbnN0YWxsIC1t
IDA3NTUgIiR7V09SS0RJUn0vbXMtZnRwbS5zY3JpcHQiIFwNCj4gK8KgwqDCoMKgwqDCoMKgICIk
e0R9L3Vzci9zaGFyZS9pbml0cmFtZnMtdG9vbHMvc2NyaXB0cy9sb2NhbC1ib3R0b20vbXMtDQo+
IGZ0cG0iDQo+ICt9DQo+IA0KDQo=

