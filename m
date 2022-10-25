Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEBC38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 08:09:27 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.77])
 by mx.groups.io with SMTP id smtpd.web09.4723.1666685359672830713
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 01:09:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l/ftQ1gK;
 spf=pass (domain: siemens.com, ip: 40.107.13.77, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l97WUiaiyRI7Z7Eo7I5oKI3Eo43rUV8aURKoIMLH+Podj/Rr7X4/PGvv4+2Nxm5yYL0Xqr9NsQKW8kGNH0JjhGf6NXcpPE+oQvNngdjExcvNMo1c162O0uyeUzsKHp3GNbijUaFZZrFBeQIne/8gX2CwkzAFL+aVml9SV/pxIoXIEOlqis1DZ3D+1AdDI3lIVHZW+4lZasc489sTsZmUfQ+3HvZISYoZDrmIKTM8Kz4Ix9CDFp+8lXvq7urfdV/pRFse9QNj4I0A4fSKKGlYZAuA9czhCiDVb+jmDZ6mJOwawxHzwOxDN8sN1BniBHS1FySEBQ9OWqkgmjFqs/KClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjQQxmAmwmNGaHtcZYNvetTBmtFQN0VY/2oAcMfDv28=;
 b=Bw2o9YMke7TyJfq0jTB6FpEGctf4nOO63eRJFRLrlCF9tv7bRwDug/zAsgUIT6MaK9VcGgnFs/S2w6p33JglmkWGeUVMzcmM+fln+33uBQWXxat2pQ9uW6MtTmBmpudhWFIpxlhyyPacOqe9/GykCwK0uqeC8qOjpHKh889+Tfu6SxOLTEx1TtEc0mLe8ZerN8QCIYmBs8rJzPfjaMq4B20LNFcYLF2R53zqH7CoLqNoL2gxLwufrkN11zblOeW2T3IkJqoca9T+3KbYO0e4qDh7SjYfR95XYIYb3/CAYOGb7sRmHzahuoqtzHMJOl798gFMHoOyLC2lnab0H7HJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjQQxmAmwmNGaHtcZYNvetTBmtFQN0VY/2oAcMfDv28=;
 b=l/ftQ1gKAuWrgV3Fs33Zs9zbQVR5L7Hs6dmkXSatF+9tsP6vz4F0YorZQQ8uq/xmSDZkochW8AJcAFK1XyUxRaMGQRzXPj8XwYhdPD3fm7mUNsJ7fj58z7S4UzRdIdE2DAjw5VKEtZRsHv+3H2e5krz+NgVfkPbi3lBA+X1l8XmdKwAgmT3P21oZRSprHtb7MfPFnv8jdmby8T0CvNP3iMQ8jQoqtD4P/ofWl1Nwb2Wsk9X/e272YtcqY+/Wzlf6g5TRL/hjZqJKp300EsFmhLpl6ywt3HLBMUsgoePX8hD8HVhPyMKaenStSZEZck9ftwAcdeAdcFI9HNjrG5TCYA==
Received: from AS8PR04CA0151.eurprd04.prod.outlook.com (2603:10a6:20b:331::6)
 by GV1PR10MB6123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 08:09:16 +0000
Received: from VE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::fd) by AS8PR04CA0151.outlook.office365.com
 (2603:10a6:20b:331::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Tue, 25 Oct 2022 08:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT095.mail.protection.outlook.com (10.152.3.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 08:09:15 +0000
Received: from CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.15; Tue, 25 Oct 2022 10:09:14 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 25 Oct 2022 16:09:10 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.013; Tue, 25 Oct 2022 16:09:10 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "Schultschik, Sven" <sven.schultschik@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/8] Secureboot on QEMU with EDK2, OP-TEE
 and RPBM
Thread-Topic: [isar-cip-core][PATCH 0/8] Secureboot on QEMU with EDK2, OP-TEE
 and RPBM
Thread-Index: AQHY6Ei2wCmBlM16hker75raBF4rhq4eO22A
Date: Tue, 25 Oct 2022 08:09:10 +0000
Message-ID: <23b969e6df97fb95a7e5fefe68c4a01a4c4fe7c7.camel@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
x-originating-ip: [140.231.151.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F8345CBC85AA4BAFD10E9ABFCDD1BC@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT095:EE_|GV1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: a53d1c66-c7c5-4787-9f90-08dab6603585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/GH3NgRAnL4TVFOAxhI89mklc7RJU5Ouu7r448iKkynKZGwLQHVtlcMfrbzv0z52T4Ds4qLhevjmzPI0bOx8l2mwqZmF2uhH9gpPd6zLIbED0GxOrEZrJXgp2EZInic19A5Y0kbEC8ie7XoU8g10XslSlsOeqfRnUkTPVE63A4SHglKC6LFzrzQw5gcYPO6N2Z4kc3aNmLOECEZfc01kDUi/+jajxjTw3wdQ6eApUo/WjkBNASCNQ1OIl0z3qA7piaO4RttiMnUHAPYe/AMPeheOAbLIk8WUyl2uJ2Ff7Ci6z/udPBlinnxVOPPbqacAZ+IEk413uBN8EZ0JKDHWwy8rsMb7fem6AWpMWXjEvj5dLcYXxtmEs7GOkuy3u8VSOdUUYZGPgGr0futtTip/s4yW5Wf7omSYlmbwFSwoP4bnP3Mmrg777gpwHeqaKllytmC0nWRNGIrRje3ag/TWHurAvJ5KpumGeLTsigMv7BhZlEVsusyJyM3PX3jJesgmfN7Fab616I2r9FLDcuygpo4pMjqVtSjfedTPI11Nf9y1h5RV47CXesNbHnWVc/DqJ+r/b0RdBIbZj5JJN4dYNZLImLrovuOnA2tGkVncoJMqBBgG0ycqyRYR7Kpp+O3N3P/Q2eXpnxSL/lkms9GwJdJIZRdQ440ndT+D/ed7IbnbTIfZLEouVTk+syZ1Ht8NPilXBXhnTlEjWSh8etdeQgz+v+17PWKw9ptq4OsUTfYI2kmRpMFy0GbJbleF7iTzpH2Uk2DJbtF/yw9ea66KEU3eY4wlYTUFtFguJlh1eXo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(86362001)(4001150100001)(82740400003)(40460700003)(2906002)(82960400001)(336012)(2616005)(956004)(186003)(5660300002)(356005)(47076005)(81166007)(83380400001)(316002)(107886003)(26005)(70586007)(110136005)(4326008)(40480700001)(70206006)(478600001)(8676002)(41300700001)(8936002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:09:15.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53d1c66-c7c5-4787-9f90-08dab6603585
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 08:09:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9813

T24gTW9uLCAyMDIyLTEwLTI0IGF0IDE0OjI3ICswMjAwLCBzdmVuLnNjaHVsdHNjaGlrQHNpZW1l
bnMuY29tIHdyb3RlOg0KPiBGcm9tOiBTdmVuIFNjaHVsdHNjaGlrIDxzdmVuLnNjaHVsdHNjaGlr
QHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyB3aWxsIGFkZCByZWNp
cGVzIHRvIGJ1aWxkIGEgUUVNVSBzZXR1cA0KPiB3aGljaCB1c2VzIE9QLVRFRSB0byB1c2UgUlBC
TSAoUmVwbGF5IHByb3RlY3RlZCBtZW1vcnkpIG9mDQo+IGFuIEVNTUMgZm9yIGEgc2VjdXJlIHN0
b3JhZ2UuIFdoaWNoIGlzIHVzZWQgd2l0aGluIFNlY3VyZWJvb3QNCj4gb24gQVJNNjQuIFFFTVUg
aXRzZWxmIGRvZXMgbm90IGhhdmUgYW4gaW1wbGVtZW50YXRpb24gb2YgYQ0KPiB2aXJ0dWFsIFJQ
Qk0uIFRoZXJlZm9yZSBhIHBhdGNoIGZvciB1LWJvb3QgaXMgbmVlZGVkIHdoaWNoDQo+IGFkZHMg
dGhpcyBmZWF0dXJlIHRvIHUtYm9vdCwgYnV0IGJyZWFrcyBoYXJkd2FyZQ0KPiBjb21wYXRpYmls
aXR5IHdpdGhpbiB1LWJvb3QuIEFzIHNvb24gYXMgUUVNVSBoYXMgYSBuYXRpdmUNCj4gUlBNQiBz
dXBwb3J0IGluY2x1ZGVkLCB0aGUgcGF0Y2ggY2FuIGJlIHJlbW92ZWQuDQo+IA0KDQpQYXJ0IG9m
IHRoaXMgcGF0Y2ggY291bGQgYWxzbyBiZSBpbnRlZ3JhdGVkIGludG8gcmVhbCBzZXR1cCwgYmVz
aWRlcw0KUUVNVT8NCg0KQnkgdGhlIHdheSwgcy9SUEJNL1JQTUIvDQoNCj4gVGhlIGxhc3QgcGF0
Y2ggaXMgbWVudCBmb3IgbWFudWFsbHkgdGVzdCBhbmQgdmVyaWZ5IHRoZSANCj4gcGF0Y2hlcywg
YnV0IHNob3VsZCBub3QgYmUgbWVyZ2VkLg0KPiANCj4gU3ZlbiBTY2h1bHRzY2hpayAoOCk6DQo+
IMKgwqBhZGQgcmVjaXBlIGZvciBlZGsyDQo+IMKgwqBhZGQgcmVjaXBlIGZvciBvcHRlZSBxZW11
IGFybTY0DQo+IMKgwqBJbmNsdWRlIG9wdGVlIGludG8gdS1ib290DQo+IMKgwqBhZGQgdS1ib290
IHBhdGNoIGZvciBxZW11IHRvIHN1cHBvcnQgUlBNQg0KPiDCoMKgYWRkIHJlY2lwZSBmb3IgdHJ1
c3RlZCBmaXJtd2FyZSBhIHFlbXUgYXJtNjQNCj4gwqDCoGFkZCBrYXMgZmlsZXMgZm9yIGJ1aWxk
aW5nIHFlbXUgc2VjdXJlIGJvb3QgaW1hZ2VzDQo+IMKgwqBlbmhhbmNlIHN0YXJ0LXFlbXUuc2gg
Zm9yIGFybTY0IHNlY3VyZSBib290DQo+IMKgwqBubyBtZXJnZSAtIG1hbnVhbGx5IGluc3RydWN0
aW9ucyB0ZXN0IHNlY3VyZSBib290DQo+IA0KPiDCoFJFQURNRS5tZCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgNjUgKw0KPiDCoGthcy9vcHQvdS1ib290LWVmaS1lYmct
b3AtdGVlLXFlbXUueW1sICAgICAgICB8ICAgMTEgKw0KPiDCoGtleXMvaGVsbG93b3JsZC5lZmkg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICBCaW4gMCAtPiA0NTc2IGJ5dGVzDQo+IMKgcmVj
aXBlcy1ic3AvZWRrMi9lZGsyXzIwMjIwNS5iYiAgICAgICAgICAgICAgIHwgICA0MyArDQo+IMKg
cmVjaXBlcy1ic3AvZWRrMi9maWxlcy9ydWxlcy50bXBsICAgICAgICAgICAgIHwgICA2MSArDQo+
IMKgLi4uL29wLXRlZS9vcHRlZS1vcy1xZW11LWFybTY0XzMuMTcuMC5iYiAgICAgIHwgICA1NCAr
DQo+IMKgLi4uL3RydXN0ZWQtZmlybXdhcmUtYS1xZW11LWFybTY0XzIuNy4wLmJiICAgIHwgICA2
MSArDQo+IMKgLi4uaGFjay4tQnJlYWtzLXByb3Blci1oYXJkd2FyZS1zdXBwb3J0LnBhdGNoIHwg
MTM3NSArKysrKysrKysrKysrKysrKw0KPiDCoHJlY2lwZXMtYnNwL3UtYm9vdC9maWxlcy9zZWN1
cmUtYm9vdC5jZmcudG1wbCB8ICAgIDkgKy0NCj4gwqByZWNpcGVzLWJzcC91LWJvb3QvdS1ib290
LXFlbXUtY29tbW9uLmluYyAgICAgfCAgICA1ICsNCj4gwqBzdGFydC1xZW11LnNoICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE0ICstDQo+IMKgMTEgZmlsZXMgY2hhbmdlZCwg
MTY5NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBrYXMvb3B0L3UtYm9vdC1lZmktZWJnLW9wLXRlZS1xZW11LnltbA0KPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCBrZXlzL2hlbGxvd29ybGQuZWZpDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lw
ZXMtYnNwL2VkazIvZWRrMl8yMDIyMDUuYmINCj4gwqBjcmVhdGUgbW9kZSAxMDA3NTUgcmVjaXBl
cy1ic3AvZWRrMi9maWxlcy9ydWxlcy50bXBsDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lw
ZXMtYnNwL29wLXRlZS9vcHRlZS1vcy1xZW11LWFybTY0XzMuMTcuMC5iYg0KPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCByZWNpcGVzLWJzcC90cnVzdGVkLWZpcm13YXJlLWEvdHJ1c3RlZC1maXJtd2Fy
ZS1hLXFlbXUtYXJtNjRfMi43LjAuYmINCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1i
c3AvdS1ib290L2ZpbGVzLzAwMDItcnBtYi1lbXVsYXRpb24taGFjay4tQnJlYWtzLXByb3Blci1o
YXJkd2FyZS1zdXBwb3J0LnBhdGNoDQo+IA0KDQo=

