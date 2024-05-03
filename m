Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84287C25B5F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 11:47:28 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.49])
 by mx.groups.io with SMTP id smtpd.web11.10147.1714735124185461126
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 04:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rMCeEPgQ;
 spf=pass (domain: siemens.com, ip: 40.107.14.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+urOjQQxlHNRT69teoUndyahMWC0Zm5VA+fjKpqHz6bTA2aACS7kF5AjwvIP7M/sDgdCcbreeWirmBN8ymmkQq44Yl7l19UDinw89300nvbIMfxGEMU8QwiIGGO/moliOTIPItYfkmmyMcM6JipuZSUNjAAUOJKx798/Mzmm96PQZwLxdqi3ttq56D/NmKN6CSjtUFvxMb9g1yr0d0hqhK46ykfYq5Q8ZjTwHixylaxkPeGfOkrNu2nHQ05/ZQ+ZpEKFL8Q1MJ5fJ1LvYnIVVWRlxrSRjsKeg/0u6tUk/iMRTLNGTWOHxBcZ8bU6e8mes1nl9GGejbu6gIircOo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YoqCepVNEYgeWiIuW70BYnjuJMPqQf/1w2XyubgTBc=;
 b=gah7fiTTUquL+70tXjaseFKU65oIvHz30we6AW9g+WfsttgNq9/s7vIjLSsY3HAXsXSDxDDC7MxLD6mcjla6lI8uGEMx6gbuSUDF/h6g/FGmUp9qUnxj9o1pkhuc0021JDcDhNtX7OKzkhOQcc5Y2BD3atTSUaabn4oMxMQmkjVOofjaqTp4G/oe9w6NQttX50FNJ/W0cAvgygHowNcmcp8ofzZRvGKzVWBSYnYw+WOPjOxiMCDWCf+0OaHAdIrRNZBZwKUAdAiu9rcwu63+akj/Eb5kdm1peWyQRIxkCW+W9yIfYGi4NzZnP43oA8eUctVgCBr5HYgzDyQCiK/eiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YoqCepVNEYgeWiIuW70BYnjuJMPqQf/1w2XyubgTBc=;
 b=rMCeEPgQzy6b3Eo3DgIEDJsaVNMB2BS3JmpYotMvxtEzs/3owctk11uAm5ulWumkGYn9RQUnGTBg0pYWBPCgqKKFzDfAeYC9IjZSUJ0PR3MZzduGQIms0wj9jGu83ge96F4N/lc15MKSXiE0ta9CDipUjWBTY3h/UZz2YrocaiwJAQ4gEF0cpPnGBufwafkryB9MZ2v8/z/I1E7+lK/4WKVP5j+tc07QcBxfthN4RxJAiYVwuodcrR+fA3oZK0OeoxnV8xmM9I05lwotUMF1Fx7Dke00C2pQua0fVQE7NQeXXNjNdAnB2fViZi4Ze/wlp4PF7fEDAY59NFE2aduNfw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM8PR10MB4067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 11:18:40 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:18:40 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 9/9] README.swupdate: Add section about partition selection
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 9/9] README.swupdate: Add
 section about partition selection
Thread-Index: AQHanHOyCNLIb6MTOkmZb21fXpVDf7GFXmSA
Date: Fri, 3 May 2024 11:18:40 +0000
Message-ID: <41f1843716a72636989c90bcbb02d1b28e594c5c.camel@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
	 <20240502093240.364093-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-10-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM8PR10MB4067:EE_
x-ms-office365-filtering-correlation-id: 114f668c-8742-4347-f6ea-08dc6b62c940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T3V6eHJnTXBiMDF6TmRnQjhmQ1FOUys2TWlMQURmNVlSZUNJTi9jS1JneXU5?=
 =?utf-8?B?WVU1aUFSWWJpekRmVG9sR09lQVlyVEQ5K2pRUkdBRm0rdkwvNzk3SkFzcW53?=
 =?utf-8?B?UG1tdjh0NmI0TGdmZ1ZTTFJudlZ5elpDNnByTlBTOWU0cmNVRUJzYithSTds?=
 =?utf-8?B?VldVV20vdzVKOUhLTkxtQ3VlYWx4YU5ma0lZcTZnNW1FNjQ4NDVmS0lIMFRk?=
 =?utf-8?B?TzRQY3FyZG1VNDkrNHZ5SGxIME1aMHMvMW9mdU9SQXQ3Sks4U1FUYXBwY0tt?=
 =?utf-8?B?Smx3MUhySTVaL25CWk5rdUdwaHlsanQ0MUt6UWpLM2xQSnFkVXpsSG5JL25N?=
 =?utf-8?B?ZkczaFVHU3htaVl5bjBqTGpBQ1dPMnd0K0J1VlJScXJHM0RwbmxwTFZ2RkRh?=
 =?utf-8?B?YVloRkFSZFZQMzNPVDY5b01FcEhkOEllSU9RaFpySDdtZm5RcVpQeXlzVTNX?=
 =?utf-8?B?SWtFc080Y3NCVTdRNmNKYnB6STMxQ3JJaDJxeXQyVGl6WFlMZnkvL1NBclVn?=
 =?utf-8?B?d3J6QjZtSm15TXkyV2Q5MWV5UnVGSDN6NGhrWmZXZjBhYWxBWnU5RE96anV0?=
 =?utf-8?B?dGtTZTBTaWxUYktsN09OM0hrcE5LSDR5bWpURXVLSTNtVmVjMWJIUFl6ZGdO?=
 =?utf-8?B?c2szOTBucGs1M2RjU0JxbjMxaTVCWmlMSXgzZVc1OVFmd0lVK2xadTVHZ1ZW?=
 =?utf-8?B?T0JDeDZPVGhzYXFxdnJZUnhYWWZZWE51amtZR1ZUczJ4eDBxT0JmSmhROTVv?=
 =?utf-8?B?dS9Vem9wb0x5NUVjSzJHekNsWnNMZW9DM3l6bWdCc3VSeW1KVEMwNXZhcTNF?=
 =?utf-8?B?b2cxZ1pRUVk3MGlsTTg3YWpvRm85QlZWZFRRUmIyMG5oZWdsZ24wOXdaMWZ5?=
 =?utf-8?B?YjUyNmRScFo1NXNsNTNzcERLU0xncVk3ejNsbVdwdkhTOTNOUVdWNkdPR0pv?=
 =?utf-8?B?RVh3aVBxeDlFbnlzeCs1ZXdMSzFaZ1NORFlOdTJPWkhzOVU2ajdxbXBCL0Zu?=
 =?utf-8?B?UmRScVNBa2dHM0tNbFRUWHZVNTRNMGJhWnl1eXcweEx6S2hkdkF5cS9PbXA0?=
 =?utf-8?B?b2ZocHczbi9vZzgwdWZEZzg2MGExcGFYYVBobmJXVmZyaXFPcXVGdVZkWkVx?=
 =?utf-8?B?VlJPd0YrbzZ6WWY2aitMcXo1KzF5ZUxFTVlSQS9Id2loSDZUOVRZTWlFekE3?=
 =?utf-8?B?czV5MnY0Wjh1S2syN1F2aDh5eWpzRXFFc3k1T1U0MS9qUVE3RG4rUC9IVDBp?=
 =?utf-8?B?Wkp5MGhMb3A3QTdqTDdiV2xuODZZeWkyd3RpanlzTDZGSDRnVi9hUks0NUlS?=
 =?utf-8?B?S3ViZzhpOTRRK2VwUm1DOEs0TndGQUx3NzlMQUJtRHp4Y01IVDBRbEUxSHR0?=
 =?utf-8?B?bkIySnpqaHJsRTBWVVdOSnlNa0JUVit5dkNUSmRRWlRNMGNJZ0FMNEtVZ0Zp?=
 =?utf-8?B?Z1BiM011akhrZEhsYURFWmZuaFpWRTNkcmRFZHBWZUFsYkpsNEZkbStjZVA1?=
 =?utf-8?B?blB5dGV3QnZDOUI3UjE2NEdTRCsvMjR3UVlydjFFaHpJc3RNUzRjVUZqSGdK?=
 =?utf-8?B?UHhwTFpHSTRFTzRjOG5kcEt5aDY2U1dEZnBTamQ3T1ZiMzlWMFpESXJraGlz?=
 =?utf-8?B?c3g0RVlIOFdSKzBiVDdOUiswa01GRFd6QlQxcHI5MTUzaE54S2dQdlNnSzl4?=
 =?utf-8?B?UUtLNG13Y0QvTENVSGlXZlMybUxBbTE2L2ZwTEVHK003RmtSSXFjcDR3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UDZZZlcyTVZrb3dFQ2FIdGNobGRXYm1IWkxaTlM5K0crN2UrZUdjdGlVNi93?=
 =?utf-8?B?WmxCdGRmMndkMXNnNGdrQXlCRDZEbWhFWFNwWnhVWlIwVDBrRXlWN0tETU1O?=
 =?utf-8?B?SisrWDVqNGJlMVhxQ1JHVXdYTWxSQUMvL3YwaEdqRUJiUnVLeXFCVDU5ZG5R?=
 =?utf-8?B?TUdoWDJ4cFFGaUkweG52K25YMlRFMTZGcmpCOUxaT29JTjN2d09FKzdEM0Fm?=
 =?utf-8?B?VUpTb2R1VldOalhPQWJ4bHNLa3FlSGt4ck1uaUZCc2Y3SENLTkNlNkJ4amtm?=
 =?utf-8?B?MlJZckZiZGc4UW9OcksyeXh3VXZ1TzVsMWhCSFJ1NDg0cHFrR29GaGw4Q3Zw?=
 =?utf-8?B?dDNCOXQ3RzlTa21yOHN5SnFIaFVkdy9SK3oxUnVJa1hQM3RmdkU2NDdmZkNS?=
 =?utf-8?B?VmNQZkk4bkZHa05ZdDgyd2x1Mkh6TlpyaWI0cDNwMkRlbExxL2Y1V2NxRnEz?=
 =?utf-8?B?QTdtWDFMcDFaMkpyQ1YxRjRsZlhaMEFYdDFwVHNRUCsxbWFSNGpOdUZGZFhN?=
 =?utf-8?B?S3hKZkZyVmVBaWhFaVdBZG00ZXBIbXo5NXloMFAxd0RSUjhGSkVWWnJVQWJR?=
 =?utf-8?B?c0pKK2pFUm9uS1o4TDZnaERQbkh2WXNNNlNNR25GNk9lSUR6R0M2bkpKU3VG?=
 =?utf-8?B?eFBodUZYNVJ0aGJzUENML25PSkZrbkpiMDExcTFQQXNvdmVVZmZZR1VESWx0?=
 =?utf-8?B?Q3draGZuVFdMV2t4YlpBNC9sYnNWL1R0aUZ3OGViakdvZDJmSCtrdVBvaE8z?=
 =?utf-8?B?RlMyWlEzUnV3Ti9vaDRoSnZSaU9tUFQzYmEzTGlMUzdFL3lpYjdPbEttZ2gz?=
 =?utf-8?B?ajgxVDV3TFpqYmhNWEZtam1RY3ZTa0loZzhPcWVLcTd1M2g4enpjSXhocmN0?=
 =?utf-8?B?bUovYUNIb3pDOWJMUDUvRFRJTGp0a25XTVBNWE1EOFg0MjRNcFcvc3Z0VzNp?=
 =?utf-8?B?YVM2Smo1b1RlL1YybXRxYWhJcDNMaDJLUUU3RmZ3NjZEc24wN1hOeHZsU1hj?=
 =?utf-8?B?R0RocU80M3V5WGZZU0NTY3VKUmhDU3JMYnlGNHBPRFFhOXFJQXNPUXJTVmgr?=
 =?utf-8?B?VnBKNGxXR3NJeVBqbVRtd01xQlFNU1JWZVhQcCtBSGhKa29kVVVPbVByN2Yw?=
 =?utf-8?B?cEpONXJwTFNFcE1LeHVoUDhLbCtVYVBKamxMWU1BM21MSTVOZmp1TmFZZnZJ?=
 =?utf-8?B?OVlRQk9jb2ZGTXRDZU02T0U0RmhhNGNNK3RpT1B2Z1dUY00vNmM3cTRGeXp3?=
 =?utf-8?B?UWluMEZpYWdWaHNhUzYvUndrb24zaE45aWVCQ0ZkcEJLcVNVa0IrMVcrbHhp?=
 =?utf-8?B?VkkyT3ZyeUpMbWZjU1h5SE96cUc1UTFmUGRWekRoZzFDMW9VZkJreCtyZm9E?=
 =?utf-8?B?VW9oWXlQckEzTStiK1NwU3M0NGFxR25vaThiR3paMEdXSzBObE5uYzhGUndX?=
 =?utf-8?B?b2twWHlLTjRzQ1FQUFZSRnNFL3dUaVR2NVdXa0V3MllqUVhpOVJaUHNjcG9k?=
 =?utf-8?B?L0xIZ3FaUncwcFRBanJxTkV6NUlIN3RaNU9RZ3hlbnFkR3dtU2Z0Z0VhWUVm?=
 =?utf-8?B?bGpkOTcwWG1maDVWVU1jdEpSK00rdTRaQU9qZ3JUNENjc0RLcVZQUDI2L0lG?=
 =?utf-8?B?a1lNUEJsd1lTcnhrODg3RSt3QktOSGtGUFNYbks0dFZrZkRReVVoeE9oazZs?=
 =?utf-8?B?YmF2aGNKR25rUXJmUC91dDhrLzJ1WXgyamZFYVVmRkxrVmdocHlhTXFRZ3dY?=
 =?utf-8?B?ODhkQnRYUmRCeHd0WG1EbjRQSTd0Z2dUT0FqeG9HelBMM1dZNXcyRHcwd0Ni?=
 =?utf-8?B?Y1paaFhFVnF2SE9kcys2ZEY2V0lrM2grOWZaaVBwTzlsbUdBR01jZk9OWDNF?=
 =?utf-8?B?SVZuNzBMMFdXK0hjaW9MbFhZOXRhaHZBbVAyNGdwbXpQTkh5eG1FZERZYTVj?=
 =?utf-8?B?MGV0aDIzTVFMNVBRLytDZCs4NDhmc25mRFIrSDlGTGg2RXIxTkk5VVl0STZa?=
 =?utf-8?B?UTBGdERxdXpZaVdIenJaditvQ2VQRW82SkJWeXZVb2VFYW5wcG9RUkNMTXNF?=
 =?utf-8?B?akwvQ1NHS3E0ZTN5eVE0ZTZwRktDNGVxck5DV3RtQUFWbWNnZm9iSGFqenFi?=
 =?utf-8?B?eTJobHBlK3gyMUNxdjZIbGtnNDJuOEhPZmI2bHA5OFB4WXZ0c2YwYkw2Vi9h?=
 =?utf-8?B?a3RlQ3FPN1RtaFk0bHNBRVNsVExUY0N2L0NUcnZKUXRrQkRCWENlcXZWdGYr?=
 =?utf-8?Q?UoqTKLHiIBaMyvIzNHEWBbqC4QHvo5LmFBhxCRVz5w=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 114f668c-8742-4347-f6ea-08dc6b62c940
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 11:18:40.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmB4HEfTEjljItCK33brUwUiIr1WVFlkhtTGF801LFjmvk11LvNJFxfpEIi0LBhq11UXahtnw2RkXKs+zQb2LySufzccNKmCmeN6eNxhdeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4067
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3AF3C40684ABF49BF1053F2953D8778@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15821

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDExOjMxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZCB8IDE2ICsr
KysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgYi9kb2MvUkVBRE1FLnN3dXBk
YXRlLm1kDQo+IGluZGV4IGI3ZTEzZjcuLmZlZTY5NWUgMTAwNjQ0DQo+IC0tLSBhL2RvYy9SRUFE
TUUuc3d1cGRhdGUubWQNCj4gKysrIGIvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0KPiBAQCAtNyw2
ICs3LDIyIEBAIFN0YXJ0IHdpdGggY2xvbmluZyB0aGUgaXNhci1jaXAtY29yZSByZXBvc2l0b3J5
Og0KPiDCoGBgYA0KPiDCoGhvc3QkIGdpdCBjbG9uZQ0KPiBodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS5naXQNCj4gwqBgYGANCj4gKw0KPiArIyMg
VXBkYXRlIFBhcnRpdGlvbiBzZWxlY3Rvcihzd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4pDQo+
ICsNCj4gK1NXVXBkYXRlIHVzZXMgdGhlIGhhbmRsZXIgW3N3dXBkYXRlLWhhbmRsZXItDQo+IHJv
dW5kcm9iaW5dKGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtc3ctdXBkYXRlcy9z
d3VwZGF0ZS0NCj4gaGFuZGxlci1yb3VuZHJvYmluKSB0byBzZWxlY3QgdGhlIHVwZGF0ZSBwYXJ0
aXRpb24uDQoNCi4uLiB0aGUgcGFydGl0aW9uIHRvIHVwZGF0ZS4NCg0KPiArVGhlIGhhbmRsZXIg
dXNlcyB0aGUgbGFiZWwgb2YgdGhlwqANCj4gYnkgZWZpYm9vdGd1YXJkIHNlbGVjdGVkIGJvb3Qg
cGFydGl0aW9uLg0KDQpJdCB0aGF0IGFsd2F5cyB0cnVlPyBXaGF0IHRoZSBoYW5kbGVyIHNlbGVj
dHMgZGVwZW5kcyBvbiB3aGF0IHlvdSBwdXQNCmludG8gdGhlIHN3LWRlc2NyaXB0aW9uIGZpbGUu
IEluIHRoZSBDSVAgcmVmZXJlbmNlIGltcGxlbWVudGF0aW9uLCB0aGlzDQppcyBpbmRlZWQgYSBs
YWJlbC4NCg0KRmVsaXgNCg0KPiArSW4gdGhlIGNpcC1jb3JlIHByb3ZpZGVkIGltYWdlcyB0aGUg
Ym9vdCBwYXJ0aXRpb25zIGFyZSBsYWJlbGVkDQo+IGBCT09UMGANCj4gK2FuZCBgQk9PVDFgLCBz
ZWUgW2ViZy1zeXNwYXJ0cy5pbmNdKC4uL3dpYy9lYmctc3lzcGFydHMuaW5jKS4NCj4gKw0KPiAr
VGhlIFtzdy1kZXNjcmlwdGlvbl0ocmVjaXBlcy1jb3JlL2ltYWdlcy9zd3Uvc3ctZGVzY3JpcHRp
b24udG1wbCkNCj4gY29udGFpbnMgdGhlIG1hcHBpbmcgZnJvbSBib290DQo+ICtwYXJ0aXRpb24g
dG8gcm9vdCBmaWxlIHN5c3RlbSBwYXJ0aXRpb24sIGUuZy46DQo+ICtgYGANCj4gK2RldmljZSA9
ICJDOkJPT1QwOmxpbnV4LmVmaS0NCj4gPiR7QUJST09URlNfUEFSVF9VVUlEX0F9LEM6Qk9PVDE6
bGludXguZWZpLT4ke0FCUk9PVEZTX1BBUlRfVVVJRF9CfSI7DQo+ICtgYGANCj4gK1RoZSB2YXJp
YWJsZXMgYEFCUk9PVEZTX1BBUlRfVVVJRF9BYCBhbmQgYEFCUk9PVEZTX1BBUlRfVVVJRF9CYA0K
PiBjb250YWluIHBhcnRpdGlvbiB1dWlkcy4gVGhlIGhhbmRsZXIgc2VhcmNoZXMNCj4gK2ZvciB0
aGUgbWF0Y2hpbmcgZGV2aWNlIGFuZCBTV1VwZGF0ZSB3cml0ZXMgdGhlIGltYWdlIHRvIHRoZQ0K
PiBzZWxlY3RlZCBkZXZpY2UuDQo+ICsNCj4gwqAjIyBTV1VwZGF0ZSBFZmlib290Z3VhcmQgdXBk
YXRlDQo+IMKgDQo+IMKgOndhcm5pbmc6ICoqSWYgdGhlIGVmaWJvb3RndWFyZCBiaW5hcnkgaXMg
Y29ycnVwdGVkIHRoZSBzeXN0ZW0gY2FuDQo+IG5vIGxvbmdlciBib290KioNCg0KLS0gDQpTaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

