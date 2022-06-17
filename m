Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C2C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Jun 2022 14:17:31 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.49])
 by mx.groups.io with SMTP id smtpd.web08.30590.1655475446351808647
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jun 2022 07:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t4Myuvqi;
 spf=pass (domain: siemens.com, ip: 40.107.15.49,
 mailfrom: florian.bezdeka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwJTHuayDans+xds//23cYc6hom0Ejgne9SfKseAJ9yh4ZrqlVhtQdGwwTDy7AhRe5La1Pef61FeKZHIvfqwQQCn8zNbWXz7Oc61F+yojBlCQ5WuW9KugnFv/YmEbJTmKIbeIdw+9nqoUMbde+P5wrD1FvvmsfcBIqMDdh7XX5JKKsXkBt8dhHpvB6mhByMZyFdSEeMsCebd3Ka15IoIEdL1CY6U6q1Vyz+A/VuicSyIoipzJuaxQSFqgjWQh7Y/sjhQZuaRDDMoSZ0FUXEZGgR582ZlLVBA9onOPpSUT9FdurHr/KO3W+ixxL96JyYkJ/6tFdpvJa/hipABxA6+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9Lm6CqjLeFCW3SPe+GrrndtWngwM1Qi3cef+9wlYb8=;
 b=h27HnmF8hmsCrZ+Ijx2r021mcrbXs2QNePBLDRUE490vXMM3EC7sf5dWHJZe9IemUgdjLqsCW6vMgRZ88h66hvX18r6t5vhCmM3H6JzfjoG80v7a9uOKnfySgFa3gbq2/XorHwm5qVTsZN0TmX2pVWZw+a72n5p7//ZgX78oC0De/zt7fABfeBoS0Ye1jxXsPoEycvS/ardU42Vf6qch6yz1G690c9qcWxz7wgDKVIdcdeyZ5EJLsRgGJgFrY92ijRuELJfiBQcykhzfyFjG1wDMjIPpkyK4ADhlAHlvOkZpzNyAV0MA6GSplONxpC2JyONFXWh+WtK/Zf76Qnqwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9Lm6CqjLeFCW3SPe+GrrndtWngwM1Qi3cef+9wlYb8=;
 b=t4MyuvqilaTfqLmJdoM62Vww3zh6PzAJJTjCHE+zO71xKjGtO6DrtEQ82YlVZolg87M8PCLAutncFdurAV47Y95LszluyJzky2t8Lk13FyTCWqwFBcrahFI4dsyjQdPHEHWSpP5f8t19+rj8lOZkdf2nBZEyEa82Ew4sLn0m/oLpV82qOAKoH5szx2IBYvvp3GyRkkMTObvFl2J5BV+QuILvCAa+up5WFcEqFXYILvJfq6KHQi6Bk5vwiE/i+HS7x/O3suB6ngCvvPAOu1J52fAFunmGk4gtFNT8nrV6uXyNOvQh0sr7tsFYYFEi+DSmLqXo8LnU4fcGDA/Yb1jQxQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 14:17:23 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd%3]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 14:17:23 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] swupdate: Limit SRC_URI addition
 to the supported efibootguard case
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] swupdate: Limit SRC_URI
 addition to the supported efibootguard case
Thread-Index: AQHYglSVisSUGdeG8U+ws38sNri/ea1TpUIA
Date: Fri, 17 Jun 2022 14:17:23 +0000
Message-ID: <956a1a70a5819042632fcbc470958de4ab342c63.camel@siemens.com>
References: <16F96DF9E5B6CC23.22184@lists.cip-project.org>
In-Reply-To: <16F96DF9E5B6CC23.22184@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17356e42-e20b-4d28-9872-08da506c18ea
x-ms-traffictypediagnostic: VI1PR10MB3118:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: 
 <VI1PR10MB31180D3AF268477A7E8B137FF6AF9@VI1PR10MB3118.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bsLD1QkvqsZkSYqCWABsWlM5K/yh+qHoKx8hZ64NqzaEgL7Ov51rAsXfQS99UFF8XiFPnFZSygYWIndK6qI80lpfQUi5kMxqCr03wRKSfVjPE0JDiH05bbAqE9M10YWIrqhWL0MBgEhCSdKgCLQW86/m+e9KZxjAv9P1f75UIVFd7SZhqlrrA005bgG4DB93801HG6BKApLlWtgFgiT4ixeViCffi1jya3X/etxAiUjcy3t3y27GVPeg/PsVo6J1fFSfhj5BFUeYRxhZdBKn6B05Bgk2kkvTDGf32DRnOYaptfliwYJt/LQwoWBe/V0bd53MSTmCna4ZbFbDqCir1Tf/HUb5bHCnxjRKWzmDOOvlakc7FnxBV60t2R+dA7pzRjhEQTXQRmhAU6OGth2QTfQ/PahCWO3o/x0wOrNAvx+RTigTb0/3jmXv1pgutCh27jg6ALaAxtpiSdJvr0u1ZJ18w1GUz3gqEnYNpB0ljtdO58eWc1TjgqctwIzpMRIgazUMXrYzUC346eNp8wRLIIsZtJ2jRgJ750yPblAJ5iT1hH4AUG/VOKegO3SAmKE+CeVYgoUTQIRoN8MOuuSAYsMwaYZfWAp1McpUB8C6ywAcbWI56LXtjH4RhxOWKV1L5Z2EgmSdqD7WcIhGTV+Qb6i1XHy8oLlmoen5ruvdXiUCE0YMVzI6uCEBYR/g97pHVNpvwhPu9AX3H2uFT8lA0w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(2616005)(66946007)(6506007)(6916009)(6486002)(107886003)(6512007)(5660300002)(36756003)(2906002)(4744005)(4326008)(76116006)(66556008)(64756008)(498600001)(8936002)(86362001)(71200400001)(122000001)(66476007)(8676002)(38070700005)(66446008)(91956017)(82960400001)(38100700002)(54906003)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q0dtenlNOHQwVUJIU2RWZ1lVUUFYMm1QSnhweCtjWkttZGR3aFR0SENyeDhh?=
 =?utf-8?B?Z1RKemQrdnFMUXFzakZaYytOc3BRRUs0VzNQdEtZR2RobXQvVGN6ZUNpZFE1?=
 =?utf-8?B?UTVBbG5HUmxWb2VvWmdxbzdMRW1EUE9OUEJ0Z1gzOHVOTXhCMWNTUkZpUjJQ?=
 =?utf-8?B?K2RjbTV1eGxicmtydUY5QmVGM2VkazUybzBpZW9HRndrTWpBckZnVVNIVkFQ?=
 =?utf-8?B?QVRLdXE3bXBpOHVudnJVaS95VGRSYkZ2MFkrOU9DWjFwQ3hacFRaZ3RzanI3?=
 =?utf-8?B?d2dhTE9NMWxVWXpVSUJPSkkrYmZmemsrdFluZVBFYS9GQTA2L1ZuVURuZmxH?=
 =?utf-8?B?UU1qR2NCV2pTZ0R3R0UzZVBPSHB4OUdMWVR0NVMxSTR2U0ZSMG05RDFBVVBI?=
 =?utf-8?B?UDlhVm0xRXNJMkRuTDhYbXRpaUFsVzAyM2lwMHR6ZkJrOW9Od1JEK0RrUnQv?=
 =?utf-8?B?NXUyWjJ2cUtsZnNKQnNLVVkxQlUxVm1qRVEwai9OYUt2Skp6dWpJb2xoWFI4?=
 =?utf-8?B?Z1E0TVczOEJjVUlMM0w0U0J3eWZqbXhpY1l3a2RzVXBoYzg4WDRKVko4N08x?=
 =?utf-8?B?SUxVNzVlSnFzZDBxOGtzUDkzZUY2S05OQ2ptZkRIZlJJUnQyUWZYU1p2Mysw?=
 =?utf-8?B?MmNkaFd5OSs2Q2ZZem1uc0JMSHpZNW13bFNiaVdmQUcweHhuWGFFRTczYUVL?=
 =?utf-8?B?REVmZjVtaUhGOTZZNEQ0Wmt1dXl2N3djMVNWR3VUWG9KemNaN1drU2pGR1Ba?=
 =?utf-8?B?aWthbldDWEV2d1pSMkZ6anFnN3J6QjVRUVF3Q01FaWpNUWIxMnJxYjQ0OXVx?=
 =?utf-8?B?ejByWGExaDFqcHgvTFRpNHg1V0MzazVzNDFmZFdxNlVQdU1nRS93Q3NBVEg4?=
 =?utf-8?B?L3lNWmFOb2lqWnJUYXhqY0Y2S2JibTJpeFNxR1p2Qmd3TG9EVnhzTFdkUDI5?=
 =?utf-8?B?S2VlUHhoUG1zSnRUUXIxMTlIeHZqSEhNUTJRYml5U3E3WHdXclpYTW4ranA5?=
 =?utf-8?B?YjZPUE1SN1RtNytxQ0ZCSzZtYUhzWHEzZTFKdW5JZ29GdlhoaFZ6U2I3MVFM?=
 =?utf-8?B?T3NzQWlwTTMycEM1S2h1MkcvS3ptWjJab1c2cDFCSVBZeTM0N3ZRa0JwUWdH?=
 =?utf-8?B?Vm5JTlJZS3QrY0kyVHlnVXJBRDZwUU5wbWx2SXRBSzJXNmR0WlZxdTR6ejVW?=
 =?utf-8?B?TU9KWTNkNmFpMkpSYXNxRjdUR2hwNWxVcS9jaWlhYVRCcERpbHd2UVJ1czVz?=
 =?utf-8?B?a05tOTBZbVZ0OTVSTjhBM2Nka0szNmE5dlRCQ01zb3Y4NE1mM0VJY3F6Q1Vm?=
 =?utf-8?B?QWFQc2JreXRoc3dQSll3L2dtS0duSDUwM1h6b0lWLzNXWWt4bU1tNDM5L2Fa?=
 =?utf-8?B?TGFCNjFGSktMUGlzZWZ6Wms4V0J3cklVL0VQWjhPYytQUTh4aHl5SjRKK0R6?=
 =?utf-8?B?OU0rOHpjMjRhV2x0QTI2S3c0RklWQW1YbHZlWkd5ZnhEajkzL0djRUloR0J2?=
 =?utf-8?B?dTBxK3R4VDZ5ZHFkTllSenZndng0Z1ZJaUpJNUR2Nlc5azYxNk1qTEJxYjZl?=
 =?utf-8?B?Q2ltbDJLMFViYzY0eENtcEZzaENPZGRYaGVxTExwN3dGU2lacHpuakhCR1dU?=
 =?utf-8?B?eXQ1c0pKbDZsa0d6N1FkekVFWUpqRjBSTmRtV1F0SVFtTTVMY2VqUXJvWGtk?=
 =?utf-8?B?MlhkSWE5SGF0U1RIb0gwUmxRYjRJcUlvRVBkSGtTVmZvVDFLNHpYMmJWV3c5?=
 =?utf-8?B?QnB3ZVRQZmN6QVVKNmZ2YjBOMFQwRUFmQjQ0YmR3Tm8xVjdaSFlOZmdraUJM?=
 =?utf-8?B?Vk1STld2aWZnLzgvU0NWRGo0YWRUbWdFNHphOVhvTWk4Q3Q3LzFYQmFoKzNI?=
 =?utf-8?B?eW9VVXNtdWlaL0RQR1Q1WDRBMnlhR3Z1ejJYTFhaUTRUY2JtY1pWYzhpbWh2?=
 =?utf-8?B?RFV5MS9CU1hGODBMeGFHdVdCNlRnVEJoQWRPQXBYcWlnYlptbTh4Wmo1SDln?=
 =?utf-8?B?dzlTOTBFUDZ6ZUxhZVJFUWxmRVIxNkpNb1FsTnpHVDVkSmZFb3FjRjhhZXdW?=
 =?utf-8?B?czhRMlB1SEZPNEN5clBFZFNLdzFNQnFzZDBEd29YRHNvdkxmWTFzelhYSUtS?=
 =?utf-8?B?MkYwV3pTTFJwK05UYVFtQ2lzT1NqK3pMemhaWGpCeVpFbXdybU1zUjdXOGNY?=
 =?utf-8?B?R0ZOazc2Q2NjZCt4dldNWm1BRHoyaFl0WVNYaGV5UDF5bUNNcURmYXREVVBH?=
 =?utf-8?B?dFBwOFAyQUpwRnU3b3NRdWZMd0xtUXJ2dVhhODJLQjJqUmRzdFhSeURLbjdX?=
 =?utf-8?B?czNHU3Q0M0VVR2VGOU5LcXJHRlFESGNuc1FobnFJOXJSVGR5OWhYOWRrcDJQ?=
 =?utf-8?Q?WUADcwYF49n+nGQvH6uFJdLq4exGySiOOl04zHQ424f6t?=
x-ms-exchange-antispam-messagedata-1: 
 2uwaO2D/GvDAxgn3uvL80Pkwf17l7Dmbbk0KDiXmUGSxfViIDt+SsMYC
Content-Type: text/plain; charset="utf-8"
Content-ID: <79328DC3DD6B904B899599C4DC21EC42@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 17356e42-e20b-4d28-9872-08da506c18ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 14:17:23.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 meybPK8u9k6thIUenIGN49fzivXlvF278ZX/wvV+2WGftgz76Qj7mhfZOPNrAn9Mpqe8IuoMDF5E8NKKMocTQyh/XHPeCFToqxibqlPF0Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jun 2022 14:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8577

T24gRnJpLCAyMDIyLTA2LTE3IGF0IDE2OjE0ICswMjAwLCBmbG9yaWFuLmJlemRla2FAc2llbWVu
cy5jb20gdmlhDQpsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6DQo+IFRoZSBmb2xsb3dpbmcg
YnVpbGQgd2FybmluZyB3YXMgb2JzZXJ2ZWQgd2hlbiBTV1VQREFURV9CT09UTE9BREVSIHdhcw0K
PiBzZXQgdG8gc29tZXRoaW5nIGRpZmZlcmVudCBmcm9tICJlZmlib290Z3VhcmQiIGluIGRvd25z
dHJlYW0gbGF5ZXJzOg0KPiANCj4gV0FSTklORzoNCj4gL3dvcmsvY2lwLWNvcmUvcmVjaXBlcy1j
b3JlL3N3dXBkYXRlLWhhbmRsZXItcm91bmRyb2Jpbi9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9i
aW5fMC4xLmJiOg0KPiBVbmFibGUgdG8gZ2V0IGNoZWNrc3VtIGZvciBzd3VwZGF0ZS1oYW5kbGVy
LXJvdW5kcm9iaW4gU1JDX1VSSSBlbnRyeQ0KPiBzd3VwZGF0ZS5oYW5kbGVyLnUtYm9vdC5pbmk6
IGZpbGUgY291bGQgbm90IGJlIGZvdW5kDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEJl
emRla2EgPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQoNClBsZWFzZSBpZ25v
cmUgdGhpcyBvbmUuIFNlZW1zIEkgcG9zdGVkIHRoZSB3cm9uZyB2ZXJzaW9uIG9mIHRoYXQNCnBh
dGNoLi4uIHYyIHNob3VsZCBmb2xsb3cgc29vbi4NCg==

