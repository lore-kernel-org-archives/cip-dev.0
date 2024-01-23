Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A043C47258
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 15:39:59 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.48])
 by mx.groups.io with SMTP id smtpd.web11.8073.1706001406728732221
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:16:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z6I//IPK;
 spf=pass (domain: siemens.com, ip: 40.107.247.48, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9GINXkICG4+g4SmZI+c6nQqUSYW3/NflxzBmflwZgcptFnOsN7TCh9uTD0ZhOJUHR8MF5Bq5/nZCMeD+dRPmNsEtJHCz88QKAkZs6Axml5fFd3KDKz8NKJ8P896PoawqIBDAhJLodavtZPGJ2zikL/clzp4eOjXN0alu2LUEwBSJA86kZ5pSNY2OvYac9LFlR8/D97VDhyfSWMOiXKGlNFSqnenhpP9ZmjS77kkaXn2NTFUw0MNM1xgx/OihkVC1J9ODzWGQ8xj8rS/p4HfZSneWtTZ1xSd4DLBBrzl1r+OxEGHahvUJvJ1BsyAWRuAFRy+6ba4esJ2pgsdIHZRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u89R2Btdwb2nm+Fj1eFDjIgqWT2dS14lJIhC/5a33KM=;
 b=dgxWy5mWXxXJjs36u0SyeMr5eIv+nQMsMl6IDcLCSQCo0H1o/vQNW/oDxH6TcHX2BKQh7z8JUrz+VXdg3W3l55upygUVWNGVrcsYZz5lR9W34Vd9WP6+A1SCmPi2i6n2xlKSxIrp0iJmQOSmPCkoG8SPrPoZMg7pdlyJAoJR3ZhgTG7DHeFvvMznWAH/BbZJvTyCA1ZzXrKTOm6bC/0MleQOAwg4+2Id4R7LYs6P2dDpq+zGxWIhjFulkawOwEEKXVNwtO4AtXZpTKyIY3Vdj9513vIWPlk2mcFtpRArKHcbVHdRD7lUdLUFSsFSVRMOB/TFb2700Jq+8yMviUwL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u89R2Btdwb2nm+Fj1eFDjIgqWT2dS14lJIhC/5a33KM=;
 b=z6I//IPKaKZTp+T6wMr9JanLYrcR1Ejp/tZuELR+ZmPxbP20YwRPpAlfT/Cb0PE13cqyfeluABp4Ief6j5+0mRqDsVM6ACkRzIWRyOMSryYa3MPWIwpc8DNqpGHHZp5NViS3SJshAxXKxeNR/Aq72oWe5tbOYHHPM/Do1GwVERsz4vhoamXVnoiBw8ylwwLpEuu/B8wP1hr/UjxRDEOY70SSmUNJ6Ivid3gET/Gu6YRps65wS7GKMHLxFzFQYdfEwOeNNoeUoSL6u37SnjOZdOJSLbjSAJLhIUB/xWuHP0q5v8lrmAeP9ujfXId7Sdq4vDLuafj0tpaeyY20qNeZ7Q==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB7637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:640::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 09:16:42 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:16:42 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 2/4] swupdate: set SWU_HW_COMPAT
Thread-Topic: [cip-dev][isar-cip-core][RFC 2/4] swupdate: set SWU_HW_COMPAT
Thread-Index: AQHaTS/RGfdhh+2w9Uaj44jLZSP3aLDnH16A
Date: Tue, 23 Jan 2024 09:16:41 +0000
Message-ID: <e3e6215aa9e705dffa9e38178dd8c5435ba41b4f.camel@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
	 <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB7637:EE_
x-ms-office365-filtering-correlation-id: 4ffdf9ea-d79b-412b-39c5-08dc1bf4033b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AqFIKOc1Atk7ngrcu+yWJBqPbQIj5US4Lqf6s+XUmhXR/t3NR7jfvjdX57uTyiJ4RvuvIuXrujbETXvHvivNOuSqL1Xzrs2FxDrt1MPvrNS1VJ7Q9msAaUZu0Hn97sfLI/toOw2ozJeuDIRPLXhlMzOGKL2fu1OLJi2HXaG7csDfMto/BcgvGftyfcxZ0XNV9qyuvCGDbPX3l0K3pjOS/l6p5mAf4Q6CIPUi7WA367KLIBCLTnC8c8c+gMKG6kBzSBr1uXot0UaMvaXGCnLVm9rAed7OtuBLbpri4ZIiLdlyNsd92cy5RUkKq55zh9XjdOPs2MdlwAr+c92VFAeh2X0ZcRvAoY53Qy75SJpJot00sJFxRQRCEmD441z1hb/hA//gYxLf31UN8sRTmX31AlKpemgi5T+TaV/iCT8hwaZcPePhFPasC86e9EWrsC1adAZOvEMTR3eLqqTx6kyrxReVrSJAFgxL5BvfyV69T2xVa029+8S7H6DlX+8z3pb8wFRQAfEc69Q8Rlduqw4M+VM4/0fjjPniaq9Rxd5UkbQ9Mh5uKJtsy0Wqw/PpSls5xAeHI3UWEBCEoIcCW1wySSmqgtOUJ1FalpIgcGaS4Szklcmm2de9FMnqLEDYet+E
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(38100700002)(122000001)(82960400001)(64756008)(8936002)(91956017)(6506007)(66946007)(6636002)(2906002)(5660300002)(66556008)(36756003)(6512007)(66476007)(316002)(478600001)(110136005)(66446008)(6486002)(8676002)(76116006)(2616005)(86362001)(71200400001)(83380400001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UU5HMjRxQ2I2RFNscjN0NlhhakI4cjBmMDFUZmd1WnZ0SVRTQW5NUnZKcGJs?=
 =?utf-8?B?ejZaTitSMWxraHdFL3NaTytpV3I3M2YzUjFkU0ZvK3FBc3VpdklrVXlGWXlG?=
 =?utf-8?B?SVFWd0dldU95aXRhZjNzOVdyWnJXTXdnMzhmSHl5SGwrUGpjS2h4WTdITXZ1?=
 =?utf-8?B?RlA3WHN3TStqcTBjNHhzcGtsMHoxWFJ0M2hzZzVZMFE3ZGVOU0NEUGpUZFVv?=
 =?utf-8?B?eXVaT01JY1FQcktWWHIzdXRYbEE2NEI5N052TFI0aVVpTHVwZ3ZYV0EzSVNJ?=
 =?utf-8?B?eVFoYS9RcnZoY3k4REIyVlV6b1loM0JKelZ5SmlHdksrdTk0Y3plSUdNcGtv?=
 =?utf-8?B?NHRJY1NuUVNoKzM1cDBaTDEzYXQ1cWRZWUM5VkpwOXZxK0VCZVVsdUljTSth?=
 =?utf-8?B?bWc0bmVIZ08xZUF1QlBUS2NKVFIxblFZWU9tZkwwTG9DaTZxY0JsVXQzOVU0?=
 =?utf-8?B?UWhBNmpMWnpYVkF2eS9QRTc1MmpRWEFIamt2WCtQdEFnSHpjYlJvU05rdnVR?=
 =?utf-8?B?WTBlSXFSTzJJbXM2R1lyRnFiTjYvbHFhU2x2Wk9CVjZRS3RFckt1T21jQnMx?=
 =?utf-8?B?alNLM1dvT05kcVI1QkM4cmRFMXBJQ0txMDhKc0VNdk9reFA5NEdQSXF0RTI4?=
 =?utf-8?B?d282RDBqOWZBZXhJdDJkVWVteWJQaHh3cEJrTElXcys5NTRtbjBSU1UxdlNS?=
 =?utf-8?B?czJBVFZ6Nk5NVnVrR3dEdUR4RzBRaWc4bTVtNkhFTU0vd09CMUhZbnp5Vk5L?=
 =?utf-8?B?M04vYXhWcnNFeVA3YkMvb09SRTJLc2dMWGRaamw3eXpGTHRxakdjQWxEenRz?=
 =?utf-8?B?RDl3NWJHOUJNd2gwTG5aMUlLVnR0STM2TWJ1Y0lQWDNtdHVuc3JJcm9rWWJB?=
 =?utf-8?B?QWxKR0M5Z3FZdW9QYUJTek15REk4eW5XS1BrSE8zVkhqN2F5UVlOSUk2Q3Jq?=
 =?utf-8?B?cnZXanpWTXpjQmx4ZWFTeFE3MkhMNWRxSnh0MGVPbWthaDMrRFdYYlV4MHRq?=
 =?utf-8?B?TzVpRmNZWjFXVVc4TTRCN3JHWWYyY1NubUdQcHFmWUNLK2pqZ2FmL1ZCVnVF?=
 =?utf-8?B?UytIOWFCTlZZdDd0ejFpYWFCcEs2QmRMU1ZVNFlzbTVaZy9LWFBESHh1MUlR?=
 =?utf-8?B?UHVwZkROenNNRlVBem9DaWlxWXRjU2JlM3poc1Mrd1R2cUorRllQUStUdHNW?=
 =?utf-8?B?aWl6cFZFQ2RlbS8rb202b2JXRTVOeUVHc3cxdkdDalJ2SUdramlxL2IvOTVF?=
 =?utf-8?B?WmJhNmZLZlRiWFYyQ3JncmJHMFFCdlZBRkZmLzhrZS8ybkF5VzJoclJMSHBa?=
 =?utf-8?B?YzBQVFZScjRTK0QvY1pEa3BnL25zQ3lnTE9MQTJvam5lQTJOa04rZkVpTVl6?=
 =?utf-8?B?L2JVdG0rc3J0NUhvck5qcGt5clRuQkZhWVc0WXFOUWpXWG5UUFZTejJLc2xQ?=
 =?utf-8?B?bUxnNEx5eWpqZ1l1dTY2RUZpZUlCbmNZOGRkQVB0L2xDOG81emZlZmgvNkxu?=
 =?utf-8?B?Vjh4ODh1TGxWY2hPYWc3U0NFMmtUNVZXTElTMWpNKzN0NXdVMGIzdjN2MVgy?=
 =?utf-8?B?eWpGNFk5ckxRelBzTHM5RklWNWI2cnhxSlQzbVF6NDdxTk54L1VkaHV5RVMy?=
 =?utf-8?B?Y055R09WM1JEL0c3dUQ3dXF0Y1pVUms0TURFb25URVpHVGNHbU15eEFGRkpp?=
 =?utf-8?B?UGl3WkxHa0tZQkdKRFdRSkdCMWNZaVU5QnlzN3o0WkV5WTdFalNLLzJBOE9B?=
 =?utf-8?B?Z3JwRzRKdjgxNC8zL2wrWDNERnI3R3lERGVoYnFCY0M3VzBJMSs2UmcrODNH?=
 =?utf-8?B?K0Q4Tk9nNHgwQVpjdmRiTVQxL0MzU0JXbTZ1K1BEZUEza2diQ2VhdUcrVWdB?=
 =?utf-8?B?VDR2ZjYwVzNJcDhQTzN0ZlJOemRnVHorMVB0NVhiRXV5aWV3bUlEdjhmOEpx?=
 =?utf-8?B?Tk5RbnNEc0pVR3pncGxRRWtrQlpZN2tzNEJObWNHOHdHZEpFSkgrRlZHWm5o?=
 =?utf-8?B?ZmJJV2lscWpaVzV3TEdVVHNleFBIcXpyeHdsMmo4V2FVa3ZYMjVvTHdseFp0?=
 =?utf-8?B?SjBQU3ZJOUhJdWppaWNCODhnYVZkM094SkJHSDdlK2RmS1lCaHlNN2pneSt0?=
 =?utf-8?B?eHJKN2tiNFprKzZrWDZhMmU4M0pvU2xuSVgra2FjRFRDNi9PcnVrT1UxNm5Z?=
 =?utf-8?B?Yzl2UHhWeXN5djJKM1dGUHZ1U1RuYjBLNUhRWVprWVdqOE9PL0lmMFBTdU1l?=
 =?utf-8?B?ZjlIeU05aC9tYjB4NGhnOVZub1ZnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffdf9ea-d79b-412b-39c5-08dc1bf4033b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:16:41.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vk+AvHjzVDdvaVe0JZQJ6XGBc4TEHXrM2x8CpVuA4WDnxT5JlbGYhSxOPQxm3oOxzUP5ChD62R2RDnddMz/CN3NNmN0OL5EAmKf63NoKd4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7637
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD3844397D58E48BBC16CD9347FE2D0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 15:39:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14447

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDEzOjM3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gV2l0aCB0aGlzIGl0ZW0gU1dVcGRhdGUgZnJvbSBEZWJpYW4gY2FuIGJlIHVzZWQg
aW4gcGxhY2Ugb2YgYQ0KPiBidWlsZCBmcm9tIGlzYXItY2lwLWNvcmUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0K
PiAtLS0NCj4gwqByZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBkYXRlLmluY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiDCoHJlY2lwZXMtY29yZS9zd3VwZGF0
ZS1jb25maWcvZmlsZXMvaHdyZXZpc2lvbi50bXBswqAgfCAyICstDQo+IMKgcmVjaXBlcy1jb3Jl
L3N3dXBkYXRlLWNvbmZpZy9zd3VwZGF0ZS1jb25maWdfMC4xLmJiIHwgMiArLQ0KPiDCoHJlY2lw
ZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMyAtLS0NCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBk
YXRlLmluYyBiL3JlY2lwZXMtDQo+IGNvcmUvaW1hZ2VzL3N3dXBkYXRlLmluYw0KPiBpbmRleCA0
OTgzZjdjLi4xODM1MDNiIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBk
YXRlLmluYw0KPiArKysgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dXBkYXRlLmluYw0KPiBAQCAt
MTMsNyArMTMsNyBAQCBpbmhlcml0IGltYWdlX3V1aWQNCj4gwqBpbmhlcml0IHJlYWQtb25seS1y
b290ZnMNCj4gwqANCj4gwqBTV1VfU0lHTkVEID89ICIxIg0KPiAtDQo+ICtTV1VfSFdfQ09NUEFU
ID89ICJjaXAtY29yZS0xLjAiDQo+IMKgSU1BR0VfSU5TVEFMTCArPSAiIHN3dXBkYXRlIg0KPiDC
oA0KPiDCoElNQUdFX0lOU1RBTEwgKz0gIiBzd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4iDQo+
IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL2ZpbGVzL2h3cmV2aXNp
b24udG1wbA0KPiBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMvaHdyZXZpc2lv
bi50bXBsDQo+IGluZGV4IGVjMWQ2NjcuLjFlYjA5OTYgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMt
Y29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMvaHdyZXZpc2lvbi50bXBsDQo+ICsrKyBiL3JlY2lw
ZXMtY29yZS9zd3VwZGF0ZS1jb25maWcvZmlsZXMvaHdyZXZpc2lvbi50bXBsDQo+IEBAIC0xICsx
IEBADQo+IC1jaXAtJHtNQUNISU5FfSAke0lNQUdFX0hXX1ZFUlNJT059DQo+ICtjaXAtJHtNQUNI
SU5FfSAke01BQ0hJTkVfSFdfVkVSU0lPTn0NCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9z
d3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmlnXzAuMS5iYg0KPiBiL3JlY2lwZXMtY29yZS9z
d3VwZGF0ZS1jb25maWcvc3d1cGRhdGUtY29uZmlnXzAuMS5iYg0KPiBpbmRleCA2OTkxMzIxLi4y
NjBjMGYxIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtY29uZmlnL3N3dXBk
YXRlLWNvbmZpZ18wLjEuYmINCj4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWNvbmZpZy9z
d3VwZGF0ZS1jb25maWdfMC4xLmJiDQo+IEBAIC0xNCw3ICsxNCw3IEBAIGluaGVyaXQgZHBrZy1y
YXcNCj4gwqBTUkNfVVJJID0gImZpbGU6Ly9zd3VwZGF0ZS5jZmfCoFwNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmaWxlOi8vaHdyZXZpc2lvbi50bXBsIg0KPiDCoA0KPiAtTUFDSElORV9IV19W
RVJTSU9OID8/PSAiIg0KPiArTUFDSElORV9IV19WRVJTSU9OID8/PSAiY2lwLWNvcmUtMS4wIg0K
PiDCoFRFTVBMQVRFX0ZJTEVTICs9ICJod3JldmlzaW9uLnRtcGwiDQo+IMKgVEVNUExBVEVfVkFS
UyArPSAiTUFDSElORSBNQUNISU5FX0hXX1ZFUlNJT04iDQo+IMKgDQo+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jIGIvcmVjaXBlcy0NCj4gY29yZS9zd3Vw
ZGF0ZS9zd3VwZGF0ZS5pbmMNCj4gaW5kZXggY2IxNzE2Yi4uODE4YjQzMSAxMDA2NDQNCj4gLS0t
IGEvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYw0KPiArKysgYi9yZWNpcGVzLWNv
cmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jDQo+IEBAIC0zNCw5ICszNCw2IEBAIERFUEVORFMgKz0N
Cj4gIiR7QGJiLnV0aWxzLmNvbnRhaW5zKCdERUJfQlVJTERfUFJPRklMRVMnLCAnbXRkJywgJ210
ZC11dGlscycsICcnLCBkDQo+IMKgDQo+IMKgREVCX0JVSUxEX1BST0ZJTEVTICs9ICIke0AncGtn
LnN3dXBkYXRlLm5vc2lnbmluZycgaWYgbm90DQo+IGQuZ2V0VmFyKCdTV1VfU0lHTkVEJykgPT0g
JzEnIGVsc2UgJyd9Ig0KPiDCoA0KPiAtIyBkZWFjdGl2YXRlIGhhcmR3YXJlIGNvbXBhYmlsaXR5
IGZvciBzaW1wbGUgYS9iIHJvb3RmcyB1cGRhdGUNCj4gLURFQl9CVUlMRF9QUk9GSUxFUyArPSAi
cGtnLnN3dXBkYXRlLm5vaHdjb21wYXQiDQoNClRoaXMgaXMgYSBicmVha2luZyBjaGFuZ2UsIHdo
aWNoIHNob3VsZCBiZSBhZGRlZCB0byB0aGUgY2hhbmdlbG9nIChkbw0Kd2UgZXZlbiBoYXZlIG9u
ZT8pLg0KDQpGZWxpeA0KDQo+IC0NCj4gwqAjIGFkZCBjcm9zcyBidWlsZCBhbmQgZGVhY3RpdmF0
ZSB0ZXN0aW5nIGZvciBhcm0gYmFzZWQgYnVpbGRzDQo+IMKgREVCX0JVSUxEX1BST0ZJTEVTICs9
ICJjcm9zcyBub2NoZWNrIg0KPiDCoA0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxp
bnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

