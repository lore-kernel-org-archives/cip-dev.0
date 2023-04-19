Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BEC77B73
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 13:57:00 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.59])
 by mx.groups.io with SMTP id smtpd.web11.38494.1681912583866191239
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 06:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YmmPdxH4;
 spf=pass (domain: siemens.com, ip: 40.107.7.59, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmbehZfFujVfrBLAhdm1YRYbrmNAxXFc0jeNC5BM4MHK0rFnlr/ZZ/gLjpSBwWY/6Gru4yN8y1cn4H05tU3KwCT8OOMvK7PCqn8W9XPcEaRtPP8fEXNKP0flwDKfjfak9y8D/uzLwmyM+Vr6YQ3wL58JdnOUEr9z+zlZvK+5fFwGlqwzD84phrv1AnlMHkekwPdAA8yAF/0iXM+Ahd5f/iEhBWwhjyN3sQel9Uu08A0hXN8Qol5RZOEVLw1m6+qQj9qql/0cvtYsov5R+61dOJaWyotZfO9+yapOS1CcypVQRL/ovDLL7+rv3P/Rnx+z/wgGjTjsr1//EO95KTe1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wLyo1rrVwO3BZ0dYhcwdvNSGuJGqaotmfPih0y5rFU=;
 b=SKRtO0uSvJ4B6OuALv7W+gyRhwD9fOnkkDZ58G5NGw1fpah4JjM89gRCgBTyLoNjdKqMviFXjdkeedtM3sUYNX9BpGaYO7jVC8RIHLnztgi0DxBsKTPbdHUPlol9J9bH66f5hiK4BFnfCpBRs31X5r0YyrlI8WOF6uJvkrRA/qLBroPl2wroEbmf3SzgQxZ7NhnhbvNl4e3CQcKwf2mempleOK3pvueba7lIG+wDLmFMG5GvXhlumkjMM1T+GTDyBUOgDHuDpjCQkI0CWTqLKKs/T8T8+fp8oRT2ge3japem7HRmCbConwZXyC0GZYHWLs/EGvAMFK/UkBbO9K30Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wLyo1rrVwO3BZ0dYhcwdvNSGuJGqaotmfPih0y5rFU=;
 b=YmmPdxH4+nOZMcFO0zjQ1VKrfOAoFJJnPce6pGaBPWr0a9Ulzolvi0EFxnSRXSe9o6zQjifHQ25UgFK6j1l3mrQx6LjRIJi/UnWFwXXe3naqSrVasyFhxOeqe5ZHZha3mOjU7qMSbGRMGCyOj29JrgslC5BLmgOOLPgrDCHzcKwSHpkqXT9vNSNwoVgQO7AYEo7/NXiKJ40oN8TJCx8S57CHUQzixsLuzuaaMBUkysvU96I/KVGZkDybOv9UZcCYWz8Lexh6qaLmN2ns0K6y4MR9Ye2N8d85nPH1fVWt4SVd5Gy0XMp+Lrq0ucjnKdO17dJcOxDmsNghTlNHLN8rFA==
Received: from OS6P279CA0134.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3b::10)
 by AS8PR10MB5877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:521::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 13:56:20 +0000
Received: from HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3b:cafe::9) by OS6P279CA0134.outlook.office365.com
 (2603:10a6:e10:3b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 13:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT050.mail.protection.outlook.com (10.152.1.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 13:56:20 +0000
Received: from CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Wed, 19 Apr 2023 15:56:19 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 21:56:17 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Wed, 19 Apr 2023 21:56:17 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE instead IMAGE_INITRD
Thread-Topic: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE
 instead IMAGE_INITRD
Thread-Index: AQHZcqnTF/t0Vl7zKEW53UDkwgbQmK8yIfQA
Date: Wed, 19 Apr 2023 13:56:16 +0000
Message-ID: <beae3fd3c278c0d22a2d91f019513f46b0a5fe97.camel@siemens.com>
References: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-1 
x-originating-ip: [139.24.236.244]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT050:EE_|AS8PR10MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0b8ca1-41e1-477b-0435-08db40dddaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zMhr3AQ58ue6ssfKZDLX4nSdIPE3OSX448lSQwHX9Xln6xRv1adwCNohUli4Zz93MUAyHR5VvbFAwnrgcc5q7Z4XgnQzlPGOVMWPzDZCvp1qjbMLNFxIkYKllSqUGNDsaap9DD7t9hKE1vaG/ZgG6N1Is8Rxp2bedJ1v9Pn5JZbUBYL7RZWhnwOjMeP9/IYQDwIWtJ9sDPCOWg8zPKhOmr+cHaBfxV7/0zGBiJ9jhTesLv5J7g8PnB11ki3KtGpDyb2Z9HG9tvIsjsYJYantaMbgEwl6NXrHg2/yEq5jz6Ae3hYyD+K5MRfEywkymdkSAq3w5wrFPmYzZrXA7YtbfTR3RqgnlT+sT5eUzxB6+ICnHJSXqq1o5QJosioVI4KvPBZx8PVRcX5gKOE8KnHeBEkm3FUHg7r0nvZYn1RAPO6yEzKASFRQiyAvC7UEVUNaCBivGmC6CqYH8XsxW1edWMiIShg84crBFb4iLvNf95GD9n5fuLS9Xl9O633cbN0EtmM9SDDg1zRZ6+1q7Mzbn308HVcrbOuEVqT+t2U66kF1DMBYfGr8C6MR8QcUcutFnh95dppqpKUa1lq6h4edgrlNBV0VxCIMN3iVOINFstmHiASPUlRJNGiPC8rKvNUJfve7e8iAonzhLo2lOwjMz0en+MlRmiXOt6AJm6HsrkKhA2N26osVsaM2Ovod3GyxWYF5X7oiklZueMXnbEln6cBseU2Q/SCBz9SYIXVq9ypRt2YIv+nP7AUSt2ywaLLrXViQV4iCKmieuWdpbf9KHQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(316002)(110136005)(6636002)(70586007)(70206006)(966005)(40460700003)(478600001)(8936002)(40480700001)(8676002)(5660300002)(82310400005)(41300700001)(2906002)(81166007)(356005)(82960400001)(86362001)(82740400003)(36756003)(336012)(2616005)(36860700001)(956004)(26005)(47076005)(186003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:56:20.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0b8ca1-41e1-477b-0435-08db40dddaae
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5877
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF8D190393ABB04D9BFCAB0E77F316B9@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 13:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11235

T24gV2VkLCAyMDIzLTA0LTE5IGF0IDEyOjI5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gV2l0aCBjb21taXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL2lsYmVycy9pc2FyL2Nv
bW1pdC9mMDYwODY4M2ZkMThmOTYzMTkzMzJmMmVhMzgyNzUzNmJkMmZkNzYxDQo+IMKgdGhlIHZh
cmlhYmxlDQo+IElOSVRSRF9ERVBMT1lfRklMRSBzaG91bGQgYmUgdXNlZCBmb3IgY3JlYXRpbmcg
dGhlIHdpYyBpbWFnZSzCoCBzZWUNCj4gWzFdLg0KPiANCj4gWzFdOg0KPiBodHRwczovL2dpdGh1
Yi5jb20vaWxiZXJzL2lzYXIvYmxvYi9tYXN0ZXIvUkVDSVBFLUFQSS1DSEFOR0VMT0cubWQjd29y
a2luZy13aXRoLWEtY3VzdG9tLWluaXRyYW1mcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmlu
IEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCg0KSSB0ZXN0ZWQgdGhp
cyBpbiBhIGRvd25zdHJlYW0gbGF5ZXIgd2l0aG91dCBhIGN1c3RvbSBpbml0cmQgYW5kIGNhbg0K
Y29uZmlybSB0aGF0IHRoaXMgZml4ZXMgdGhlIGlzc3VlLiBQbGVhc2Ugbm90ZSwgdGhhdCBJJ20g
YWxzbyB0aGUNCmF1dGhvciBvZiB0aGUgbWVudGlvbmVkIGNvbW1pdCBpbiBJU0FSLiBUaGUgSVNB
UiBmaXggd2FzIHJlcXVpcmVkIHRvDQpmaXggYSByYWNlIGNvbmRpdGlvbiBvbiB0aGUgZGVwbG95
bWVudCBvZiB0aGUgaW5pdHJkLg0KDQpBY2tlZC1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgu
bW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqByZWNpcGVzLWNvcmUvaW1hZ2Vz
L2VmaWJvb3RndWFyZC5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+
IMKgc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1ib290LnB5IHwg
NCArKy0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290Z3VhcmQu
aW5jIGIvcmVjaXBlcy0NCj4gY29yZS9pbWFnZXMvZWZpYm9vdGd1YXJkLmluYw0KPiBpbmRleCBj
ZGY1NTU4Li4xZGU0NTJhIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2VmaWJv
b3RndWFyZC5pbmMNCj4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290Z3VhcmQuaW5j
DQo+IEBAIC0xMiw1ICsxMiw1IEBADQo+IMKgSU1BR0VfSU5TVEFMTDphcHBlbmQgPSAiIGVmaWJv
b3RndWFyZCINCj4gwqBXSUNfSU1BR0VSX0lOU1RBTEw6YXBwZW5kID0gIiBlZmlib290Z3VhcmQ6
JHtESVNUUk9fQVJDSH0iDQo+IMKgV0RPR19USU1FT1VUID89ICI2MCINCj4gLVdJQ1ZBUlMgKz0g
IldET0dfVElNRU9VVCBLRVJORUxfSU1BR0UgSU5JVFJEX0lNQUdFIERUQl9GSUxFUyINCj4gK1dJ
Q1ZBUlMgKz0gIldET0dfVElNRU9VVCBLRVJORUxfSU1BR0UgSU5JVFJEX0RFUExPWV9GSUxFIERU
Ql9GSUxFUyINCj4gwqBJTUFHRV9GU1RZUEVTICs9ICJ3aWMiDQo+IGRpZmYgLS1naXQgYS9zY3Jp
cHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkNCj4gYi9zY3Jp
cHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkNCj4gaW5kZXgg
MGRlMjhjYS4uNzQzNWIyMiAxMDA2NDQNCj4gLS0tIGEvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMv
c291cmNlL2VmaWJvb3RndWFyZC1ib290LnB5DQo+ICsrKyBiL3NjcmlwdHMvbGliL3dpYy9wbHVn
aW5zL3NvdXJjZS9lZmlib290Z3VhcmQtYm9vdC5weQ0KPiBAQCAtNjAsOSArNjAsOSBAQCBjbGFz
cyBFZmlib290Z3VhcmRCb290UGx1Z2luKFNvdXJjZVBsdWdpbik6DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBrZXJuZWxfaW1hZ2UgPSAidm1saW51eiINCj4gwqDCoMKgwqDCoMKgwqDCoCBi
b290X2ltYWdlID0ga2VybmVsX2ltYWdlDQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoCBpbml0cmRf
aW1hZ2UgPSBnZXRfYml0YmFrZV92YXIoIklOSVRSRF9JTUFHRSIpDQo+ICvCoMKgwqDCoMKgwqDC
oCBpbml0cmRfaW1hZ2UgPSBnZXRfYml0YmFrZV92YXIoIklOSVRSRF9ERVBMT1lfRklMRSIpDQo+
IMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IGluaXRyZF9pbWFnZToNCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbXNnZXIud2FybmluZygiSU5JVFJEX0lNQUdFIG5vdCBzZXRcbiIpDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG1zZ2VyLndhcm5pbmcoIklOSVRSRF9ERVBMT1lfRklMRSBub3Qg
c2V0XG4iKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5pdHJkX2ltYWdlID0gImluaXRy
ZC5pbWciDQo+IMKgwqDCoMKgwqDCoMKgwqAgYm9vdGxvYWRlciA9IGNyZWF0b3Iua3MuYm9vdGxv
YWRlcg0KPiDCoA0KDQo=

