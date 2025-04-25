Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513BC369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 08:03:27 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.49])
 by mx.groups.io with SMTP id smtpd.web10.2149.1745568200790937815
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 01:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cCtGEdj6;
 spf=pass (domain: siemens.com, ip: 40.107.247.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNbHfoZZPGfHMXL/eX4+DefknAKSseYrfSVTAQBDKNoreNZ0XXbU/kibUlwHqXONEZKzHDvODFR7K+ZGKYVsvdHAMizAn8zWzQNBQn4u0zMbpcVFtox0zloogDA1zYDq6Zt9BT9pKDr2gdSCuKXrWjvJ/4rJxi/Z+aKSGtwzF3vJIoEdTF7XrOCA3hDl07aUsHN0CxSdbWqEAbHnsU/O5WnoIfkKuh5JguNzOcyvqUHQ8cj+MKb8EEJBOsY3TQ//Kc5oDeUcA0w8iyTRmt8y9NjB7t/b5Z9VLx4z4nGaMG7fzS6Qp5/RZSTd4bcif+Bm1tXNj02r3vTQkAOuSNHzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMdJ1egWkD9+uG8fyvxXAVF9MbAXa0fRKRFSi0Oul14=;
 b=eS5FdysLpBD/i4Tnzq2Gs6qj4dG+O9/k/Qif2+F7DrOhZEz3LtqdznPwN32Ft7NKb9CHPY1tyG3zr2jHu1FFKwfgyUQltchVeblw+AMBsboNqAFX6juAQ5GBdfNTKUPYHmEWbHgXrfeLFLQjkFsDh9bhgtSuDMs5qJKW/iDvqDZQZiWml0pcC6ZfxdWirs4+2+IAtwxXpAPgr4Dd7jToSjCnlrAhXCdfW5QEdu9NXASMpXLzET0ojl5oUJhTSExYsnTEaTSZh3a0fTxTJXtvUrf4GkPik7Cf/0I/MsLzyfpSexX5j/5XYrJIOAdLZszBL12oxdc9hPyoKP2PcvPDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMdJ1egWkD9+uG8fyvxXAVF9MbAXa0fRKRFSi0Oul14=;
 b=cCtGEdj6cSnEg0Hb9nEYVwL2zt9+HyNQKSPk2ra4st+BV4cYpjdt2QU77Sj4zFR0X8fEHxk6ql4Aw8HoKmCG9DWCN1wqYfpi7Ow7Ar6VnV48/0tma4bgdYMI0Bb8wj2vIodNnZgeiAf+6XH3YARSM4c61LrDboExrlMscqUGOsBYX1oOw3rwpwUh7HJDeyAiFYcaX4wupWbL7u3dqaTzg1mwsvT+KWrehyMJ+bj2tQDkuCLuHcdCmxQoyL9c5c0mtWyKqm3a/9VxFgNRM0l827T0eMu4g19LMzjoPk13ob6EiqY/xNHiwYB0E2lM3MNs6CVv2nonY/fo4CJnYer36g==
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by DB9PR10MB6689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 08:03:17 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a4ec:4b8b:f70c:3a33%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 08:03:17 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/5] wic(ebg): add support to
 abrootfs env to cmdline
Thread-Topic: [cip-dev][isar-cip-core][RFC v2 3/5] wic(ebg): add support to
 abrootfs env to cmdline
Thread-Index: AQHbs5X0fHK02emlhUuKqSBzM94U6bO0CdMA
Date: Fri, 25 Apr 2025 08:03:17 +0000
Message-ID: <1a0aa6a193c0592423e10cd5fc3dade9c534e568.camel@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
	 <20250422145055.1095348-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250422145055.1095348-4-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6823:EE_|DB9PR10MB6689:EE_
x-ms-office365-filtering-correlation-id: 8f8c7f62-2e2c-4e50-45ad-08dd83cfa330
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T1pidXlzVW9qdDZWMmU0a3crV0FJRFUyS0ZvMTYzdnl2Wlo3czVjV0UrK1RV?=
 =?utf-8?B?S3FFenY4ZU1CYnNKOTBDY1NaNFpRM0k0RmF4ajZsQkd5TWk0U3BqYVZFMktZ?=
 =?utf-8?B?d09qSUJ4eXNGQ295TWNJYXMzaUZvbzlqeVdqVDRDLy81MG1UNjlMcmFjWU05?=
 =?utf-8?B?UVA5UWdvOWNja0kyeDJYQU5KTVNxUmcyWjUvZzY5SXRiaVlSK2tvNU5XK2M5?=
 =?utf-8?B?T3U3Z0FjVXVHRGJ1YmFRTVplbmNIcTExT04vL1ZINW01eEpSSStVUGs4ZVdn?=
 =?utf-8?B?MjFseGV1Z1B6NGVZMXNyenBkaTlGREtya3FGKy9BWVpob3lSaDZVeEswcnVD?=
 =?utf-8?B?SlpoaEQ1WGZldkYvVElMYnhMSTZmTVNPSEkxWlhKcnVudytNL2JwS2ExQlJl?=
 =?utf-8?B?d3d6SnkwdXRDejJIVmN1dzRjNEtBOFV0clVKUzRpb0w3NDFScllSMGJnMlJ4?=
 =?utf-8?B?V0llRU44VGRSVjdpNkVuYlNNbkhiWnQzR0orOXQ0bVgzMVVTOEFKemVvejM4?=
 =?utf-8?B?ZE1MS0FiU1JCREI2amd4aWJINmhVNXpIUnRpOHQwcDN3WFh6NTd1aWFUR0F2?=
 =?utf-8?B?QWxkVVpjcXErTFZENGt5K2J5VHhUNmpNU2QxQUwwdnp0b0w2bWIvU3ZpeHll?=
 =?utf-8?B?eW9PNEs1d3pvWUZmc1BFK1ljZ0FpQURHd1NIbnRhMEFMSm5oMDZKVXIwRkVU?=
 =?utf-8?B?WVRiYmlPaURtWFpTOWl3QlRSYkpFNnIyRlBYSGN5QTdRUm92S1hidCtiSGpa?=
 =?utf-8?B?V2VrUmdVQzhuczlKVWFHL3d3WmI3QVNndHVIV3oyYnVJbzcrdnZMNnNRQXUz?=
 =?utf-8?B?blJ2cm42eDFQTXNvMG95dThvQ2FpRDRDeHZJMWtyTFl4S3gxNjRVVWlaYmJE?=
 =?utf-8?B?OUNTKzRaSitzVGtWdHpMZkRpQjZ3OU1MSXZRbUJEci9iUGJZTGNNb1RkRXFK?=
 =?utf-8?B?NnA0VWgxbU5VcG45VXo5Uk1NR2xKTlQ0ZWIvb1NBajFiNjcwWko4cGdwc2hI?=
 =?utf-8?B?ZE45Z3ArekZZRVdtWVVjV1BnVlhFejhGbTRuYy9FY1B4OTZIZW1RRThPNkRv?=
 =?utf-8?B?ZEM5aDVvZEZwbGdWK25JeGoxclduQUoxempRVTNtcml0a1c2YytzcWhFaGpp?=
 =?utf-8?B?Z3RMZFQvaC9KbWpaOHJiV0tCUk8zYWc4L1FXeERLV3hZdkdGWkVKanhPbjRp?=
 =?utf-8?B?ZHdhKzBBb1oycEpNaG9yOWg5bEpGQWtwM0VtNzBlUW5LYU5vSVppSlJTRXpp?=
 =?utf-8?B?UVZveFJNbHJpUEhUZ2s2SHM3ejBkT1ZtVlUzaTlFRkEyaVBVd3F1ekVqdzlR?=
 =?utf-8?B?K3RaNEdiS3dVOVVmQUcraGlPbGhFZGdhSjhPeWhUZTdySEo3ZEN3REZ3dGxZ?=
 =?utf-8?B?NytmREJLOGo2MWo0R0RyVmFUaTg1UFkrbEhNR3V6UXZPUjZSdGc4amdaRmNF?=
 =?utf-8?B?Q21YTzhmVSt1R05SMHdKNUFoQjhhYU9qTlM5UGVtNS9lSEt0Rkw4MmQ3WkM5?=
 =?utf-8?B?YmVzM1puaVMrZ3hORjU2L21Rb3I0TGd3cmtMVXUvU2VWNlNvQ0R6QklobWpx?=
 =?utf-8?B?cjR6NlVHRHpXcFJKdndVT2VITTdSaWhFTkwydTNSVnZzNERmWjdpVEV2L0Nt?=
 =?utf-8?B?QXJDanFHRFhjYm1KM0ZpeHVvVzBwSDNtbHVsTEx6S3M3ZTlmeWwzdzN3MWU4?=
 =?utf-8?B?K2g2a0tsdFRWZUsyS2MwdHMzMlZWVlN2ZG14OGR2bzRjU0NlTjQxdzRBOVJN?=
 =?utf-8?B?a095SkkrZHpwYWQxN25PS2Z3NkZ0empseEFzTURXZUhBQkVTTWU2V3FydmdT?=
 =?utf-8?B?WnlXT0V0NitDZ1ZMUE1rb3p2M21ZWDM4Qkpqa1BlMUlmWHExWk4xNkdSZ2RV?=
 =?utf-8?B?SW9XejJ2S1Vuck9tcmVTYXdrSjl2ZUpYTEZIek1qRG94ODJGYURYK1RHWTFB?=
 =?utf-8?B?Q0FrSFczK0N4dzBZbDQ0eDg5NENnRWxXZi9DR0hJMmk1cmpmdGNkMnN1SlFn?=
 =?utf-8?Q?BlJGlgIMSXorDmEk4srq58KfRRozQc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cGR0MnQ1UTgyQStYYm4vakRaV1VkeGhwMHpkbm52c21vcGpPcGFvekR6UWlI?=
 =?utf-8?B?ak9MbHlzbkR3am12ejZNWkYrRlprODFPdGtRN0pJdm93QXAvejVQOXVmV1Zk?=
 =?utf-8?B?OW1ZU1BhZ0IxaHR1aWw2K2lFQjZpL2RCdXBncVRkYWwyUVlqVS9pczlWWnZi?=
 =?utf-8?B?cC9Bd0t6RFpNanQraTY5YStST2pNOHhySTFCcmltR2M1MStXQ1NJQTNlbFRo?=
 =?utf-8?B?NHJUN3ZXSDQ3QVI3VDMyUkE0WDE1MFpkSy91c0V2M0JKa1RjTEF3UG5CdzVE?=
 =?utf-8?B?OElOeGFOZnpqTW9kbjhDYlBnVjdPRUtmVWkzM0twVHk4ZC9ZOFg0REc1U1hF?=
 =?utf-8?B?YzlNb3ZiaTZWSEdIZjBxUHRtNXVHNUovQ1dKQllGMUFPZmRjS1lBQUpVeUdY?=
 =?utf-8?B?M0dJQkhFRkZ1VmhQaFhsSjVEOWxuOWFhKy9IK09MNVdWajIxL3ZRaEVHeGdq?=
 =?utf-8?B?bGRhRDZzdlJrT0NuSm52NGlUZkEwNElOTjc5MVN4VEhldUw3Sko1SHU4TktL?=
 =?utf-8?B?cHVBUjdJVjlGWjArN0o1SFpQUGVGdzR2bzZOSjNGZWx6MjNndUdsbUw5eG5I?=
 =?utf-8?B?UjlPZ2dkKzVBWE8rTmlZME9HamV2VUFmVGpGcjVSdmpRS1hMRGtVUjA1STg4?=
 =?utf-8?B?MjRQQWFoR2dLTkZGN0hxUm9GcHhXR1Z1Y1lOMCtTcUNleVVYVzNWYk1kQm1B?=
 =?utf-8?B?VDRmdHl6RXNyRWRrVi94WHkzK01MSHZDQjc4NlJaZmxFK0E3STh0dllmM01P?=
 =?utf-8?B?MXJtVHRwNWM1a2k2L0J0anhleUJNK2RDRDU1VmZZdzhDZXVnTjBOZWtYaDZG?=
 =?utf-8?B?djZ3bXJtbmg4TlNVZDBJSi9ENG5kYlFyOFR2YmNQUHRJRE5ncDZZNVZUMUk5?=
 =?utf-8?B?QjJobVE3dkZFSWtZUTVJV1BTT1R4NVROZXg1TmxyYVJvYjNyUldGdC9DS3B3?=
 =?utf-8?B?MW5vK1VpNFdUWTFmVDNNZmFwY2dEUjNsazY2dEdhU01VVURqeDAxenNuazhl?=
 =?utf-8?B?WDMzZi83V3ZBUSs0ZDVlZmRZdmQ0UUNrMHpwZWdYaHhtNjZnby9YNnpGZ2tY?=
 =?utf-8?B?b0l0TCtnSkxScFVhb3Z4SUppY2YyMnptQnNjM2ZIaDZVRnRZQkx3QUdzblQw?=
 =?utf-8?B?cCt6MWN1VlhmR3NtT1Vnb2xzVEwzdEIvQlkyYzNIL2ordTVOSE1WMktTbXNR?=
 =?utf-8?B?cmxuQ2JmdG11eUdLbmtQSHEwVzNpbU5XVzRvSnFVZUtXM0pnR3d2ckJCaGRH?=
 =?utf-8?B?bnNSTnI2OU1ZM1V6RkplcmxrZm9zVlYxYm5FZEFBSnlITWlYbzRISUxtcndm?=
 =?utf-8?B?YkZXWlY5MEo0dGE5M2wzSTBuVU82MHhsV2lZRUhDN0NxblgzRXhGT3lOUHQv?=
 =?utf-8?B?bC9KMHNYRFg4Zks2RWNheS90QjZIeTdBNTMxYXZSVVNpTTZ3N2Rzc2pSODJx?=
 =?utf-8?B?aXZLa1NUS1B5cnc0RlZsaENTeGlwK05oQk43ZFhhcFBYblRCTUNqYjhQOGh6?=
 =?utf-8?B?cE4xSFZjcTU3UmJaSytQcVVwRW50TDhuZno4VmFKUFFZeWRpemZ3SWJIcjY3?=
 =?utf-8?B?MlVZQTlLeTd2bGxVb2VFMitwTDl2SHkvT252RG00ZFNuTFY4V29uNnhaV1BY?=
 =?utf-8?B?SlgvMlEvMXpUeFlwYUpNdU9wdjZuTFR2VDUxL3UrMDVKeThycjZIbkdaZmhj?=
 =?utf-8?B?TEZSYTdJQTdSNlQ2WXN5dVFDa1d4Yjc4TzZvYWhsWU9uWGVsM2krRE05UWQ1?=
 =?utf-8?B?akxnT0RsSFVmY21jbDN2b0ZGVUNWNkZYUnhuQVFTREhPUWdhckpJazlmMkd0?=
 =?utf-8?B?d1J6aU5NR1hQNFBrdnBkV3pSbjNoOVVDMjRaQTZha3p3U2VnV0c5ZzVtZmdV?=
 =?utf-8?B?aG0rRlRJVTJVNzhsSDl2Z2ZYUmtZWVdPREtKYVZHQkFhOE95eXVRcjNMRVh3?=
 =?utf-8?B?ajl5MFdJTU9YY0N2ZllNV2pMajk3NmFkT3Z3T2o5TkRnWXZ3MjFKR2UzMWZi?=
 =?utf-8?B?VmFzMGRITGwxZW8ya09RTDUvUElzT2ZnWENjUGtRZGxTVVBVYk1naWtGQlA3?=
 =?utf-8?B?ejlpbVFwbE11MDcydGl4aGNSMHplNmJuU05OMSthdzRXMmQvL1p1T0RLSTZY?=
 =?utf-8?B?RUlNelVoZmFDUFBHeGp4WGtsK3FlZXRZc1B3TTl2Mm1YemJOWnFWMTZKVzRY?=
 =?utf-8?Q?nALccseJXIIx3tKaZIraoik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2734D13BE06444281A24463311D1CA8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8c7f62-2e2c-4e50-45ad-08dd83cfa330
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 08:03:17.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNWT01Lw85Dx2Y8bA8H7aVfghiaAhYz8ONquaTIgyojwD2VZbKDNtfd4t4+4gDAGvFUzytxdedh+igcI7hrTK+4Cpqr+eufVy+CeVKFYLO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 08:03:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18602

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDE2OjM1ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Ogo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+
Cj4gCj4gVGhpcyBhZGRzIHN1cHBvcnQgc2ltaWxhciB0byB0aGUgdmVyaXR5IGVudmlyb25tZW50
Cj4gCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbT4KPiAtLS0KPiDCoC4uLi93aWMvcGx1Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJk
LWJvb3QucHnCoMKgIHwgMjUKPiArKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL2xpYi93aWMvcGx1
Z2lucy9zb3VyY2UvZWZpYm9vdGd1YXJkLWJvb3QucHkKPiBiL3NjcmlwdHMvbGliL3dpYy9wbHVn
aW5zL3NvdXJjZS9lZmlib290Z3VhcmQtYm9vdC5weQo+IGluZGV4IGFhMDkzZTIuLjk0MTYzNGEg
MTAwNjQ0Cj4gLS0tIGEvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3RndWFy
ZC1ib290LnB5Cj4gKysrIGIvc2NyaXB0cy9saWIvd2ljL3BsdWdpbnMvc291cmNlL2VmaWJvb3Rn
dWFyZC1ib290LnB5Cj4gQEAgLTkxLDYgKzkxLDkgQEAgY2xhc3MgRWZpYm9vdGd1YXJkQm9vdFBs
dWdpbihTb3VyY2VQbHVnaW4pOgo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgc291cmNlX3BhcmFtcy5n
ZXQoInZlcml0eV9yb290IikgPT0gJ3knOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWRs
aW5lICs9ICIgY2lwLnZlcml0eV9yb290X29wdGlvbnM9cGFuaWMtb24tCj4gY29ycnVwdGlvbiwl
cyIgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICUgY2xzLl9nZXRfdmVyaXR5
X29wdHMoKQo+ICvCoMKgwqDCoMKgwqDCoCBpZiBzb3VyY2VfcGFyYW1zLmdldCgiYWJyb290ZnNf
cm9vdCIpID09ICd5JzoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWRsaW5lICs9ICIgY2lw
LmFicm9vdGZzX3Jvb3Rfb3B0aW9ucz0lcyIgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJSBjbHMuX2dldF9hYnJvb3Rmc19vcHRzKCkKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIHVu
aWZpZWRfa2VybmVsID09ICd5JzoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vdF9pbWFn
ZSA9Cj4gY2xzLl9jcmVhdGVfdW5pZmllZF9rZXJuZWxfaW1hZ2Uocm9vdGZzX2RpciwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+
IGNyX3dvcmtkaXIsCj4gQEAgLTE3Miw2ICsxNzUsMjggQEAgY2xhc3MgRWZpYm9vdGd1YXJkQm9v
dFBsdWdpbihTb3VyY2VQbHVnaW4pOgo+IMKgwqDCoMKgwqDCoMKgwqAgc2Rfb3B0cyA9IHtrOiB2
IGZvciBrLCB2IGluIG9wdHMuaXRlbXMoKSBpZiBrIGluCj4gdmVyaXR5X3NkX2tleXN9Cj4gwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gIiwiLmpvaW4oWyIlcz0lcyIgJSAoaywgdikgZm9yIGssIHYg
aW4KPiBzZF9vcHRzLml0ZW1zKCldKQo+IMKgCj4gK8KgwqDCoCBAY2xhc3NtZXRob2QKPiArwqDC
oMKgIGRlZiBfZ2V0X2Ficm9vdGZzX29wdHMoY2xzKToKCkhpLCBJJ20gd29uZGVyaW5nIGlmIHdl
IGNvdWxkIHVuaWZ5IHRoaXMgd2l0aCB0aGUgdmVyaXR5IGxvZ2ljLgoKRmVsaXgKCj4gK8KgwqDC
oMKgwqDCoMKgIGFicm9vdGZzX3NkX2tleXMgPSBbInRhcmdldC1pbWFnZS11dWlkIl0KPiArwqDC
oMKgwqDCoMKgwqAgZGVwbG95X2RpciA9IGdldF9iaXRiYWtlX3ZhcigiREVQTE9ZX0RJUl9JTUFH
RSIpCj4gK8KgwqDCoMKgwqDCoMKgIGltYWdlX2Jhc2VuYW1lID0gZ2V0X2JpdGJha2VfdmFyKCJJ
TUFHRV9CQVNFTkFNRSIpCj4gK8KgwqDCoMKgwqDCoMKgIGFicm9vdGZzZW52ID0gTm9uZQo+ICvC
oMKgwqDCoMKgwqDCoCBvcHRzID0ge30KPiArwqDCoMKgwqDCoMKgwqAgZm9yIGZpbGUgaW4gb3Mu
bGlzdGRpcihkZXBsb3lfZGlyKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBmbm1hdGNo
LmZubWF0Y2goZmlsZSwgZid7aW1hZ2VfYmFzZW5hbWV9Ki51dWlkLmVudicpOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWJyb290ZnNlbnYgPSBvcy5wYXRoLmpvaW4oZGVwbG95
X2RpciwgZmlsZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrCj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIG5vdCBhYnJvb3Rmc2VudjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtc2dlci5lcnJvcigiYWJyb290ZnMgZW52IGZpbGUgJyVzLnV1aWQuZW52JyBub3QgZm91bmTC
oAo+IGluIGRpcmVjdG9yeSAlcyIsIGltYWdlX2Jhc2VuYW1lLCBkZXBsb3lfZGlyKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoMSkKPiArwqDCoMKgwqDCoMKgwqAgd2l0aCBvcGVuKGFi
cm9vdGZzZW52LCAiciIpIGFzIHZlbnY6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGxp
bmUgaW4gdmVudjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGssIHYgPSBsaW5l
LnN0cmlwKCkuc3BsaXQoIj0iKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Rf
a2V5ID0gay5yZXBsYWNlKCJfIiwgIi0iKS5sb3dlcigpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBvcHRzW3NkX2tleV0gPSB2Cj4gK8KgwqDCoMKgwqDCoMKgIHNkX29wdHMgPSB7
azogdiBmb3IgaywgdiBpbiBvcHRzLml0ZW1zKCkgaWYgayBpbgo+IGFicm9vdGZzX3NkX2tleXN9
Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAiLCIuam9pbihbIiVzPSVzIiAlIChrLCB2KSBmb3Ig
aywgdiBpbgo+IHNkX29wdHMuaXRlbXMoKV0pCj4gKwo+IMKgwqDCoMKgIEBjbGFzc21ldGhvZAo+
IMKgwqDCoMKgIGRlZiBfY3JlYXRlX2ltZyhjbHMsIHBhcnRfcm9vdGZzX2RpciwgcGFydCwgY3Jf
d29ya2RpciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hdGl2
ZV9zeXNyb290LCBvZV9idWlsZGRpcik6CgotLSAKU2llbWVucyBBRwpMaW51eCBFeHBlcnQgQ2Vu
dGVyCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55
Cgo=

