Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB3C6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 13:57:00 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.46])
 by mx.groups.io with SMTP id smtpd.web10.38295.1681912386246337614
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 06:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J1OfNyUg;
 spf=pass (domain: siemens.com, ip: 40.107.105.46, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmLtM4DoO5R3R4HkXyOxSoT5qnjumwxheDqSAFo75m/SQmO4f8fyFFQrutVYkBdyLC/ae3UVs/1BmJYdPs97HkZzBZgQFGllKP9gDviMlOOAM+TMk1njghlNbHs2iEtATyfStM27uEIo/kwgHdmZGIshfZP3T91jks3LWt6tKi/cHViKmqXzzH7yclMAeeh7qBlnX8Djp38bi9AGd9BO6xWQ6Eje8ZltWRXAlo2LSy8kqJlfsqkniMaCbfBmLfCYv4aTLkvgy+e5zJAhudoeUsoy25gWNSQ3Sl7BusajsU3LPnG0BWUSnvoQPvKjPm+l0bzsbneAUu7j9NOUKdhiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqxGESQ7bMcqFhTv0stvhLd2QMyYJJLBqrdEMwhRMvQ=;
 b=Llvf+dNK3PHWwqivkUgVFMi1w52Nmb6eC5LWtyPQQybW4Qd1QsUuTdFFjFcKCCX9zwynBOkbtlfViOpAmx0Gc+jZqX7O+6PNC8Yb6gvwQexQ3zffkqzWIeW2W0ToStM8Ehc8ITsKbvm3hdLHcBVjwhr3jKwwoHMol03F1DU/OK2XgnYN/CGto057pRe9QYAGRy/zJo88gb+5vZihDrA3Mv0b+reWFfW5XbSywoelXQELI+2Yd+ZXjG2M8r09MVj3eMVDumzMJy/SjjY1NKSKOllmFQpIAK/E0mtt69hKzpYYLYIjDnVi04jQkMPUQwzft8NZh8UbL+KsBkZ67riwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqxGESQ7bMcqFhTv0stvhLd2QMyYJJLBqrdEMwhRMvQ=;
 b=J1OfNyUg9x+pLHi5aLGdBqRvznWAG7kyVdTdRjNO63t5twGaujTukVILZl7NDDYYUvqS6X15b5uDBG7qrguXG0usQb3nTLtOyr9jf1dUXeGghPxabmPmFKgtx+fWyk7qxxhvu/sVxornd4eIQ2+au7CdWQsB+l6qUEBGZsQ1th3byYPzuz/6FC2PS+mv07Rzngc7h4bBD/gI18383RWQeCsUeOrIqXYU4K8sDEDYmlPPrwE3U+ab0LD/Ir3jmUsMAf0xyxbPbuxkrtkxZ0ag3614xYTibWRvYg4cfdTP/VqqynaokD/jCC1Q+cwAUWboIgvMc0Z8MdSrpV5dLG9M0g==
Received: from DB6PR0501CA0036.eurprd05.prod.outlook.com (2603:10a6:4:67::22)
 by AM7PR10MB3796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 13:53:00 +0000
Received: from DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::ff) by DB6PR0501CA0036.outlook.office365.com
 (2603:10a6:4:67::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Wed, 19 Apr 2023 13:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT035.mail.protection.outlook.com (10.152.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.21 via Frontend Transport; Wed, 19 Apr 2023 13:52:59 +0000
Received: from CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Wed, 19 Apr 2023 15:52:58 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 21:52:56 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Wed, 19 Apr 2023 21:52:55 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE instead IMAGE_INITRD
Thread-Topic: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE
 instead IMAGE_INITRD
Thread-Index: AQHZcqnTF/t0Vl7zKEW53UDkwgbQmK8yB0SAgAAZnIA=
Date: Wed, 19 Apr 2023 13:52:55 +0000
Message-ID: <6b056f444843732dcc53ffaae028491009cb6411.camel@siemens.com>
References: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
	 <a8b641c2-c664-9230-ac9d-dcf64a7f936d@siemens.com>
In-Reply-To: <a8b641c2-c664-9230-ac9d-dcf64a7f936d@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-1 
x-originating-ip: [139.24.236.244]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT035:EE_|AM7PR10MB3796:EE_
X-MS-Office365-Filtering-Correlation-Id: 2422013a-6d94-4826-48ad-08db40dd632b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+1yosrDHEigpZqWxWky4vzXsnBPT2NoBwc68OD61+SNqwe3/seTyxBf6HKauNcqSyRpxwBGDCRDwCgHHN+OvlAzbRyplKQTWzNv0wkwJJ+pA2Jwf05A0PaFkOSNrtzo7UrLT7tKOS5qffy+p8SXwsqO0s2sOcckI+9HbHkqiAsynJFhGGL94Is6e04gFXvhN9xGxE4iXPLbY7cR7ECXd2sAQfxbv8MA82uxRr1lhcFt+6+i8DwMfxyhiIGlV6tY8sXRnWnQPf+RWmbM13e+EiYFTKEGSk7uY7tFwR6TgVSeURUQyv8hPHYez298051/TXqIlzX/Q0NuYtyP1RZW7tDOAMnPmp5kxBD8LDPg2p6mguefoNCRbvaWHiQtFkBB5KoiMZw9XjiQ3/bsgOZg7q4pzS+b7Sdb27en2UPFe14JClWMRZfPIiOwn2ieMYbUf1SVCC6E7AIQ9QLta0vVXHPSm38rQYlcrFam9tkeWRzaglJOV4x2KrPMzRfksBqYXykOcVV1I2cbdNz83egbXXEV7ktDZr7Jj2sMdF1+Y/LmBDvkAq3/++crZTepFKwFJjbP8m9+pB6YZdzUJ7LG+S+0SRcbooBJ031NZvqmSBa3LZ9nvIamN7E0fb8npJplw1w5VYaiwjsp2mBG18c2S8CrYb9o2/xSG4HjliBpcVw3tYxsJc+qbxllYgziyB5D2y4/Qo26ykeJXhE1eV7ad3XZP8/wcndc1IsimGXSFaos=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(53546011)(186003)(26005)(2906002)(47076005)(2616005)(956004)(336012)(40480700001)(966005)(5660300002)(41300700001)(316002)(70586007)(70206006)(6636002)(8676002)(8936002)(110136005)(478600001)(82960400001)(82740400003)(82310400005)(86362001)(40460700003)(36756003)(83380400001)(36860700001)(7636003)(7596003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:52:59.7650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2422013a-6d94-4826-48ad-08db40dd632b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3796
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C95FB65884A143A2D5B3F048C89C8A@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 13:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11234

T24gV2VkLCAyMDIzLTA0LTE5IGF0IDE0OjIwICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxOS4wNC4yMyAxMjoyOSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFdp
dGggY29tbWl0DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2lsYmVycy9pc2FyL2NvbW1pdC9mMDYw
ODY4M2ZkMThmOTYzMTkzMzJmMmVhMzgyNzUzNmJkMmZkNzYxDQo+ID4gwqB0aGUgdmFyaWFibGUN
Cj4gPiBJTklUUkRfREVQTE9ZX0ZJTEUgc2hvdWxkIGJlIHVzZWQgZm9yIGNyZWF0aW5nIHRoZSB3
aWMgaW1hZ2UswqAgc2VlDQo+ID4gWzFdLg0KPiA+IA0KPiA+IFsxXToNCj4gPiBodHRwczovL2dp
dGh1Yi5jb20vaWxiZXJzL2lzYXIvYmxvYi9tYXN0ZXIvUkVDSVBFLUFQSS1DSEFOR0VMT0cubWQj
d29ya2luZy13aXRoLWEtY3VzdG9tLWluaXRyYW1mcw0KPiA+IA0KPiANCj4gV2hhdCdzIHRoZSBp
bXBhY3Qgb2Ygbm90IGRvaW5nIHRoaXMgc28gZmFyPw0KDQpJdCBicmVha3MgdGhlIGJ1aWxkICh3
aWMpIHdoZW4gdXNpbmcgZWJnIGluIGNvbWJpbmF0aW9uIHdpdGggdGhlIHN0b2NrDQppbml0cmQg
ZnJvbSB0aGUgaW1hZ2UuIEluIHRoaXMgY2FzZSwgdGhlIElOSVRSRF9JTUFHRSB2YXJpYWJsZSBp
cw0KZW1wdHksIGhlbmNlIHdpYyB3aXRoIGViZyBwbHVnaW4gY2Fubm90IGZpbmQgdGhlIGluaXRy
ZCBhbmQgZmFpbHMuDQoNCkluIGNpcC1jb3JlLCB3ZSBhbHdheXMgdXNlIGEgY3VzdG9tIGluaXRy
ZCAoYnkgdGhhdCBJTklUUkRfSU1BR0UgaXMNCmNvcnJlY3RseSBkZWZpbmVkKSwgd2hpY2ggaGlk
ZXMgdGhlIHByb2JsZW0uIEhvd2V2ZXIsIGluIHNvbWUNCmRvd25zdHJlYW0gbGF5ZXJzIHdlIGhh
ZCBlYmcgKyBzdG9jayBpbml0cmQgYW5kIHRoZXJlIGl0IGJyb2tlLg0KDQpJTUhPIHRoaXMgc2hv
dWxkIGJlIGZpeGVkIGluIHRoZSAxLnggcmVsZWFzZSBhcyB3ZWxsLg0KDQpGZWxpeA0KDQo+IA0K
PiBKYQ0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3ls
c3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgcmVjaXBlcy1jb3JlL2ltYWdlcy9l
Zmlib290Z3VhcmQuaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+
IMKgc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFyZC1ib290LnB5IHwg
NCArKy0tDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9lZmlib290
Z3VhcmQuaW5jIGIvcmVjaXBlcy0NCj4gPiBjb3JlL2ltYWdlcy9lZmlib290Z3VhcmQuaW5jDQo+
ID4gaW5kZXggY2RmNTU1OC4uMWRlNDUyYSAxMDA2NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUv
aW1hZ2VzL2VmaWJvb3RndWFyZC5pbmMNCj4gPiArKysgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2Vm
aWJvb3RndWFyZC5pbmMNCj4gPiBAQCAtMTIsNSArMTIsNSBAQA0KPiA+IMKgSU1BR0VfSU5TVEFM
TDphcHBlbmQgPSAiIGVmaWJvb3RndWFyZCINCj4gPiDCoFdJQ19JTUFHRVJfSU5TVEFMTDphcHBl
bmQgPSAiIGVmaWJvb3RndWFyZDoke0RJU1RST19BUkNIfSINCj4gPiDCoFdET0dfVElNRU9VVCA/
PSAiNjAiDQo+ID4gLVdJQ1ZBUlMgKz0gIldET0dfVElNRU9VVCBLRVJORUxfSU1BR0UgSU5JVFJE
X0lNQUdFIERUQl9GSUxFUyINCj4gPiArV0lDVkFSUyArPSAiV0RPR19USU1FT1VUIEtFUk5FTF9J
TUFHRSBJTklUUkRfREVQTE9ZX0ZJTEUNCj4gPiBEVEJfRklMRVMiDQo+ID4gwqBJTUFHRV9GU1RZ
UEVTICs9ICJ3aWMiDQo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvbGliL3dpYy9wbHVnaW5zL3Nv
dXJjZS9lZmlib290Z3VhcmQtYm9vdC5weQ0KPiA+IGIvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMv
c291cmNlL2VmaWJvb3RndWFyZC1ib290LnB5DQo+ID4gaW5kZXggMGRlMjhjYS4uNzQzNWIyMiAx
MDA2NDQNCj4gPiAtLS0gYS9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1
YXJkLWJvb3QucHkNCj4gPiArKysgYi9zY3JpcHRzL2xpYi93aWMvcGx1Z2lucy9zb3VyY2UvZWZp
Ym9vdGd1YXJkLWJvb3QucHkNCj4gPiBAQCAtNjAsOSArNjAsOSBAQCBjbGFzcyBFZmlib290Z3Vh
cmRCb290UGx1Z2luKFNvdXJjZVBsdWdpbik6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGtlcm5lbF9pbWFnZSA9ICJ2bWxpbnV6Ig0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgYm9vdF9pbWFn
ZSA9IGtlcm5lbF9pbWFnZQ0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgIGluaXRyZF9pbWFn
ZSA9IGdldF9iaXRiYWtlX3ZhcigiSU5JVFJEX0lNQUdFIikNCj4gPiArwqDCoMKgwqDCoMKgwqAg
aW5pdHJkX2ltYWdlID0gZ2V0X2JpdGJha2VfdmFyKCJJTklUUkRfREVQTE9ZX0ZJTEUiKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IGluaXRyZF9pbWFnZToNCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtc2dlci53YXJuaW5nKCJJTklUUkRfSU1BR0Ugbm90IHNldFxuIikNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtc2dlci53YXJuaW5nKCJJTklUUkRfREVQTE9ZX0ZJTEUg
bm90IHNldFxuIikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5pdHJkX2ltYWdlID0g
ImluaXRyZC5pbWciDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBib290bG9hZGVyID0gY3JlYXRvci5r
cy5ib290bG9hZGVyDQo+ID4gwqANCj4gDQoNCg==

