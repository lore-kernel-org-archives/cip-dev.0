Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB70C54788
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.41])
 by mx.groups.io with SMTP id smtpd.web11.9116.1708506458864495318
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:07:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nqySRrO8;
 spf=pass (domain: siemens.com, ip: 40.107.8.41, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq+6GQHEFn7l6VpTccbRYpS5EXEr/vmuOMYVIeAxBtKqnnRFwBthsmOMc87bFYFWATyUQTXwtSfCHMo0cAYIbajx6O6i7qkr1TUi9TWGRE+h8+20wGUlRiBfWGMOMMyuzBgcnIgWdWasC13QLjT0QtqvKw/qWv1Oc90wqyYF6Oi03ZnQ5nhdVr2cG6JJs+ujEtIK5ZWSx1XgOzcXVLU5I0GeS9bh5D9soNDuHKuHmFWzD+oXvhDmnd3DEBk0+WLWnAiKgsztWW6VCQ7bbFVhwmsTGtjB6usQlasxSafmDL7XoGhH2hd21wqdEuylz1txh01xuStmdzd/3+tiaWiVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPE+Q/ckp2gDZw5zFTxwtv3z8kMn3TIFODfuvJlrwRw=;
 b=hcC2QVairlFOIJKNAqDN9gpiCiaEpcNJW0vbzL7BpofxVxq7/Ke3EPci4lYeopQspDcjbpYr0sVjQ7NVDKIt8NX7F35ll4q2nlgXA0Q6D4oMlptqc7d4Ekue4TwXx8ejgnBdQbsO/e8AxbebrOfaEQv/eV4Pj9mqB8u/BcQLIR+gWaZvMm8BIM/6XACZUEiupAQ5wXe3cjqsZmCcAK5aDTe5OwAPXJx4iFSYAYUVOKQ616Jo1S7qi9opDWE+VC8AAydqIHhkSi/kNhnqgV/jEKx/KVG/VzQB1YLAKq1Ef2ELbCphBasZiL4V3lvHVMoo2Vli7K9HSxVl2ehy3JB8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPE+Q/ckp2gDZw5zFTxwtv3z8kMn3TIFODfuvJlrwRw=;
 b=nqySRrO8uV4k1LmlELCMZf6dsrRGCKN5u4VyVgfW+hSNI6nhNrOC/TU3Fz/YPiv0FlvfjvCxD8jAZLbNHfo1Hr7JBkWsCV0TIxzOeydVUbtOBzsoy3tHFJpcGR4mtEYRmkzrXnRh0Si53NhAK05wR79Up/uyDQlDSBH846t8zESNxUBLbXbxm/ejzxPjaJCJIDYYcIF9neqHONdMLYIwQNaYTexzrdJ7eURhGuTt5Ip8/R7Muy+wsn2aYpzxbUplIwa5LTYkTq2EBmRO74wtGxkdTodJmukm1zoDFFcLB1A9UyJIpeanyySLl/7Ncbp1kmIU+SSp7YlNwUQHGCwzdw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB8256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 21 Feb
 2024 09:07:35 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:07:35 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Mou, ChengShu(Ben)" <Chengshu.Mou@siemens.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare boolean variables
Thread-Topic: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare
 boolean variables
Thread-Index: AQHaZKRpHFe3Wqv5KEyD9nUEyDigarEUgYcA
Date: Wed, 21 Feb 2024 09:07:35 +0000
Message-ID: <8db7bfef6dd7a11ef3d647b8187e6e523da3e78a.camel@siemens.com>
References: <20240221090005.54520-1-felix.moessbauer@siemens.com>
In-Reply-To: <20240221090005.54520-1-felix.moessbauer@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB8256:EE_
x-ms-office365-filtering-correlation-id: 26d8dbf9-f0ef-43e4-e67b-08dc32bc8b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RYd+mGIKSxNneNeRzjO4aBWxcir6QON/9wzms4Menjc6kw3qanINij+R259Of8Hdzk2q+vAYaNbRtVz7zjyPkpqi7gllCRV7O1gHRz8YZqXEz+wQ2O9ww76RX6PNbtthQ2cZsEPtncdWeXtrllJ6WGI9Vp9D9fFEO+LFAscIHSs/onVTziwAcpgSfByDXjLfManHzgw8YrSQITwFcv9WuXawDgeqCoXSK+s40PWlQ6JQRQ+hWpSkDMsLw74WsXPMiKusUggk+HjsAnD0SJ4y3L7ZCsFaxzbG+9Jc1ZEnwg056WRH1/Owvm8w99pXS00eIsTgWJTTxlCpdJG8ordekp2jvo25UKaw9FjKT+NNxViMdbc4WI66E/UvyW7jayzQZV/c9Rby2Th1TDwzdfFUIYBZpN3s4kGKT2Q5WaNw7d5k+d9pkNPMN8HBpCSmmOsv5THyR/eMGgkr+cBC9KhXVLCr9KHEGawItH4SaXmbxgE1L3faCXuMHB1fSLf9Ly1idBjIHKlwGfMqwkRo9j2KFSjy0qwiQZPzgpi5IyE4mONNKHAyj1t6xUXDk715GXKwJSn2FMH1Wea3ncZK0Lt1E/MKqwP4D717xzeAx0pYvULKfnbCOatDY/7XBteI4DLd
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TFFKM1JwdVRIRDhZWmhiMzNTcGRrOTArbmZuVFBWWDhQY250V1N2YlNQbzRZ?=
 =?utf-8?B?bWM2N2xSQmJwRjBXb1dUd1loRHgyV1hSTEs4dG5lejRFSURUbExJckJRc3ha?=
 =?utf-8?B?dVY0VnFwWGRBa0ROeC9ZbFkxdTZBZ0lmNnkzZG8xd2ppdDZuOFYzUGxnT3lF?=
 =?utf-8?B?bTdiazZPdnBpblZVM0crWU85dW9vL2V6d1VwdGVIb0hYcFU3N3Vkc2JFOUVX?=
 =?utf-8?B?N0IreUZhck9IVUQ5MnljYkFDWnFTdjhUZCtSNlRRU2tURHJPdFNFTUpOd2RT?=
 =?utf-8?B?ZHdHN3lkYllBZUlkbXcyNUpidGhBM2FDSXNjeEdvdHdXeGFMQkNXcU9EOWFY?=
 =?utf-8?B?QktzdVk2SHdwcTc0VVNXUFg1NHF2ZUZtY28yMkZsYWhiZFFxUjRVWktCd2tE?=
 =?utf-8?B?aEZwNGcvanhpeU1TWGZRSnE3cnlKTmVmaCtEa29xK2FQcjhrcGVDSDhoVDgx?=
 =?utf-8?B?WSs1TGFkcmljcW02UE5GSC84SCtSOTJjY0JlZVJqVmYxR0kyeExKcHBaNkxs?=
 =?utf-8?B?S0dVeGdUQUJpZjNTTmZ5ZlRkNlBMRUFKd01LRmVGK09PQTltaVNvYlVzVkd4?=
 =?utf-8?B?UU12M25wcitnbjQyL0g1RG82VGlVR3llVGFWMjl0TERwek5mUGlUMWRDU1B3?=
 =?utf-8?B?QjIxWExodkZrWDBLK1Z4dkhOcHVGTklUMTMzbmE3MUprd043cmFCUC9tQldI?=
 =?utf-8?B?UUdpT1ZsWmV5VkpDMDJSOVJLOXhWa05uYUQ2bVF6T3U1WEZXWndoSm1CWkhz?=
 =?utf-8?B?RUZiaWJHbGQ2TWdXYStEVnlIRjREUHQ1MjN0amEvQW9NbWZybmt1NVhIR05Z?=
 =?utf-8?B?c1ZwVWFmKzlacUlxTzIwc1BlYzAzekVqdE9RRC94OE1jSnU3UTMzMlJlM1Ry?=
 =?utf-8?B?SGpFNlBPRnV2eUlZR09tREh4QzZabmJUZGk2SStvN0NoRmMveEgyQ09VaStl?=
 =?utf-8?B?OXVkdmxFa24wZ1p4NTBzRUkwOUdSeFJWUk5TM2w4ZzFYYjl4Nm5wRHJIVUUw?=
 =?utf-8?B?amtFbGZjTkE3SmQ4aGlhanc4ZjRhVk5oMjFKVWJrWHlPa1pqRElMcXVwTm5B?=
 =?utf-8?B?YUZqT1ZHOXdkeFI1VmNjMFZWWFJ1ZnVodHVBRWIzOFdUUlp6ei8xYTFjWFE5?=
 =?utf-8?B?RjFGQnZzY2crazhvVEZzUU92bDI4TXowZXAyZExTNVJueW5LWEFEUmlDalIv?=
 =?utf-8?B?QnpMOFRra0JGVk1Dc1Qwdks2ZTF1VGN5VHIzSk9sSmkxdDFEb3ZXR0FrUmZE?=
 =?utf-8?B?MmxtZTJyNGZaZER5WWNrNVZUTFU2Z21BR3RITWxMUkl1bXdoUnAvK0xCSlIx?=
 =?utf-8?B?Y0p1SFIwdituOCsxQjJNaUc0ZHRFQUxudGxFREtpdi9ZUG91VFVSbHMvRlgr?=
 =?utf-8?B?RTVsTWtEc0cvSjJBQzAyNVFPL3M4T0ZvOWJ6NFI0aVRtVElnMGFyMGZXSE1B?=
 =?utf-8?B?enhEcHlJVjFjcVZZS281czRUTFJNeGtNVUJJZFlMTm9mY1F0VTRBVm42RVpD?=
 =?utf-8?B?ckUySmVCQWZvZFN4ZURqRUYveDVpT2J2bWUwcE54MlBFTldCYjhkYWlGVVpu?=
 =?utf-8?B?RE92Sjl4SHp5b05KMUVkdENJSHE3aS96dkxGM1ZiS1JnUll0aStlY0g3d0pE?=
 =?utf-8?B?NnY2OGUzd241OElldjE3MzhtMGM0aE0wcGhKZXJqaWc5NlR6MjhNc3NBd0hX?=
 =?utf-8?B?YVlYcDBVN3NFTDEydWhCb0hXcEtWSStZTE53UWhEZjROK2dFQWZLSTRqbGdo?=
 =?utf-8?B?YUNVeUV5WkZGNlE3NW55RzBkSjd5QnhyQStQaWY1OTZjM3RrUGZmelg0dklI?=
 =?utf-8?B?aVhURUJkQVdxemtRY1o3QmpLeFFnck90VDFYSjJkbjRlbUdsbDBCMzREUnJY?=
 =?utf-8?B?ZFVxWlVKUmNsS1BlZnF4QUpOTUFBVThJbVVmcGQ4L3FkS3ZkOFlSVkU4Nm4w?=
 =?utf-8?B?Q294M09DT0t3OGxRWFl0d2VNWE9yczM4S21jWFdWcHZKODhGdUFPcVpsNlZT?=
 =?utf-8?B?NndoR1dNYmd6ZGNNNkZCU1lVQkZraXBDV0QxdHY1ajhJNUtyd3FVR2Jmeldi?=
 =?utf-8?B?M05yd3QvU2FIYVoyMThTU1BFUk44enJPWUI5N3ErR2UzWnBKZDJXcmQzSDRm?=
 =?utf-8?B?Z3ExdEhuRjZVTmZ6ZDdpMisrdmwwS3ZNaVRtUFB0NkZMTTgwWEdjWDNCT29Y?=
 =?utf-8?B?Qm1CTkk2R2ZWVHJXT2duTDMyOVg2Ymtya2NuRzVqZ2dJUE03Zm9EMkxSaXhR?=
 =?utf-8?Q?M8ATkVY51WMGLoxc6G7lyFzRpdJuXPJ433xgYZ9qRM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d8dbf9-f0ef-43e4-e67b-08dc32bc8b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:07:35.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In3ZfAxzQix6wK2aO9ZRU+XCPY+HQGrJzKxK62am3YQr7lRXd198MglQTz3SLsjN9lEK3msFOfDq3BJI4f+YgIxTRJHDybLGyzr4SMBjnQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8256
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC32C1A40AB20458BE53088198670C1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 12:27:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15054

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDEwOjAwICswMTAwLCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3Rl
Og0KPiBXaGVuIGNoZWNraW5nIGlmIGJvb2xlYW4gd2FyaWFibGVzIGFyZSBlbmFibGVkIC8gZGlz
YWJsZWQsIGENCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLV4NCg0KQEphbiBwbGVhc2UgZml4
IHRoaXMgdHlwbyB3aGVuIG1lcmdpbmcgKGluIGNhc2Ugbm8gdjIgaXMgcmVxdWlyZWQpLg0KDQpG
ZWxpeA0KDQo+IGNvbXBhcmlzb24NCj4gYWdhaW5zdCAiMCIgb3IgIjEiIGlzIGVycm9yIHByb25l
LCBhcyBhIHVzZXIgbWlnaHQgdXNlIG90aGVyIHZhbHVlcw0KPiBsaWtlDQo+ICJUcnVlIiB0byBl
bmFibGUgaXQuIEZvciB0aGF0LCBiaXRiYWtlIG9mZmVycyB0aGUgdG9fYm9vbGVhbi4NCj4gDQo+
IFJlcG9ydGVkLWJ5OiBDaGVuZyBzaHUgTW91IDxjaGVuZ3NodS5tb3VAc2llbWVucy5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVu
cy5jb20+DQo+IC0tLQ0KPiDCoHJlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMgfCA0
ICsrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMg
Yi9yZWNpcGVzLQ0KPiBjb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYw0KPiBpbmRleCBjYjE3MTZi
Li43YTQyMTRmIDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUu
aW5jDQo+ICsrKyBiL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZS5pbmMNCj4gQEAgLTIz
LDcgKzIzLDcgQEAgZGVmIGdldF9ib290bG9hZGVyX2RlcGVuZGVuY2llcyhkKToNCj4gwqDCoMKg
wqAgaWYgYm9vdGxvYWRlciA9PSAiZWZpYm9vdGd1YXJkIjoNCj4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gImxpYmViZ2Vudi1kZXYiDQo+IMKgwqDCoMKgIGlmIGJvb3Rsb2FkZXIgPT0gInUtYm9v
dCI6DQo+IC3CoMKgwqDCoMKgwqDCoCBpZiBkLmdldFZhcigiVV9CT09UX0NPTkZJR19QQUNLQUdF
IikgPT0gIjEiOg0KPiArwqDCoMKgwqDCoMKgwqAgaWYgYmIudXRpbHMudG9fYm9vbGVhbihkLmdl
dFZhcigiVV9CT09UX0NPTkZJR19QQUNLQUdFIikpOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuICJsaWJ1Ym9vdGVudiB1LWJvb3Qte30tDQo+IGNvbmZpZyIuZm9ybWF0KGQuZ2V0
VmFyKCJNQUNISU5FIikpDQo+IMKgwqDCoMKgwqDCoMKgwqAgZWxzZToNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAibGlidWJvb3RlbnYiDQo+IEBAIC0zMiw3ICszMiw3IEBAIGRl
ZiBnZXRfYm9vdGxvYWRlcl9kZXBlbmRlbmNpZXMoZCk6DQo+IMKgREVQRU5EUyArPSAiJHtAZ2V0
X2Jvb3Rsb2FkZXJfZGVwZW5kZW5jaWVzKGQpfSINCj4gwqBERVBFTkRTICs9ICIke0BiYi51dGls
cy5jb250YWlucygnREVCX0JVSUxEX1BST0ZJTEVTJywgJ210ZCcsICdtdGQtDQo+IHV0aWxzJywg
JycsIGQpfSINCj4gwqANCj4gLURFQl9CVUlMRF9QUk9GSUxFUyArPSAiJHtAJ3BrZy5zd3VwZGF0
ZS5ub3NpZ25pbmcnIGlmIG5vdA0KPiBkLmdldFZhcignU1dVX1NJR05FRCcpID09ICcxJyBlbHNl
ICcnfSINCj4gK0RFQl9CVUlMRF9QUk9GSUxFUyArPSAiJHtAJ3BrZy5zd3VwZGF0ZS5ub3NpZ25p
bmcnIGlmIG5vdA0KPiBiYi51dGlscy50b19ib29sZWFuKGQuZ2V0VmFyKCdTV1VfU0lHTkVEJykp
IGVsc2UgJyd9Ig0KPiDCoA0KPiDCoCMgZGVhY3RpdmF0ZSBoYXJkd2FyZSBjb21wYWJpbGl0eSBm
b3Igc2ltcGxlIGEvYiByb290ZnMgdXBkYXRlDQo+IMKgREVCX0JVSUxEX1BST0ZJTEVTICs9ICJw
a2cuc3d1cGRhdGUubm9od2NvbXBhdCINCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpM
aW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

